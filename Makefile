K = kernel
I = include
L = lib
U = user

TOOLPREFIX = riscv64-unknown-elf-
CC = $(TOOLPREFIX)gcc
AS = $(TOOLPREFIX)gcc
LD = $(TOOLPREFIX)ld
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump
GDB = $(TOOLPREFIX)gdb
CP = cp
PY = python3

OBJDIR = build
C_SRCS = $(wildcard $K/*.c) $(wildcard $K/*/*.c)
AS_SRCS = $(wildcard $K/*.S) $(wildcard $K/*/*.S)
C_OBJS = $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(C_SRCS))))
AS_OBJS = $(addprefix $(OBJDIR)/, $(addsuffix .o, $(basename $(AS_SRCS))))


OBJS = $(C_OBJS) $(AS_OBJS)

HEADER_DEP = $(addsuffix .d, $(basename $(C_OBJS)))

ifndef CPUS
CPUS := 1  # temporary
endif

CFLAGS = \
-mcmodel=medany \
-I $(I) \
-static \
-nostdlib \
-fno-pie -no-pie \
-Wno-builtin-declaration-mismatch \
-Wl,--no-warn-rwx-segments \
-fno-omit-frame-pointer \
-ffreestanding \
-mno-relax \
-march=rv64gc \


# log flags
LOG ?= error

ifeq ($(LOG), error)
CFLAGS += -D LOG_LEVEL_ERROR
else ifeq ($(LOG), warn)
CFLAGS += -D LOG_LEVEL_WARN
else ifeq ($(LOG), info)
CFLAGS += -D LOG_LEVEL_INFO
else ifeq ($(LOG), debug)
CFLAGS += -D LOG_LEVEL_DEBUG
else ifeq ($(LOG), trace)
CFLAGS += -D LOG_LEVEL_TRACE
endif


LDFLAGS = -z max-page-size=4096

$(AS_OBJS): $(OBJDIR)/$K/%.o : $K/%.S
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

$(C_OBJS): $(OBJDIR)/$K/%.o : $K/%.c  $(OBJDIR)/$K/%.d
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

INCLUDEFLAGS = -I$(I)

$(HEADER_DEP): $(OBJDIR)/$K/%.d : $K/%.c
	@mkdir -p $(@D)
	@set -e; rm -f $@; $(CC) -MM $< $(INCLUDEFLAGS) > $@.$$$$; \
        sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
        rm -f $@.$$$$

kernel/link_app.o: kernel/link_app.S
kernel/link_app.S: scripts/pack.py
	@$(PY) scripts/pack.py
kernel/kernel_app.ld: scripts/kernelld.py
	@$(PY) scripts/kernelld.py

generate_link: kernel/kernel_app.ld kernel/link_app.S

build_kernel: build_os

build_os: $(OBJS)
	$(LD) $(LDFLAGS) -T kernel/kernel.lds -o $(OBJDIR)/os $(OBJS)
	$(OBJDUMP) -S $(OBJDIR)/os > $(OBJDIR)/os.asm
	$(OBJDUMP) -t $(OBJDIR)/os | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > $(OBJDIR)/os.sym
	@echo 'Build kernel done'

all: $(OBJDIR)
	$(CC) $(CFLAGS) $(C_SRCS) $(AS_SRCS) -o ./$(OBJDIR)/kernel

QEMU = qemu-system-riscv64
QEMUOPTS = \
	-nographic \
	-smp $(CPUS) \
	-machine virt \
	-bios default \
	-kernel build/os \
	-drive file=./sdcard.img,if=none,format=raw,id=x0 \
	-device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0 \
	-initrd ./build/initrd.img

run: build_kernel initrd.img
	$(QEMU) $(QEMUOPTS)

$(OBJDIR):
	@mkdir -p $(OBJDIR)

initrd.img:
	-sudo umount ./build/initrd.img
	dd if=/dev/zero of=./build/initrd.img bs=512 count=81920
	sudo mkfs.vfat -F 32 ./build/initrd.img
	-mkdir ./build/mnt
	sudo mount ./build/initrd.img ./build/mnt
	sudo mkdir ./build/mnt/bin
	sudo mkdir ./build/mnt/mnt
	sudo cp ./usr/build/init ./build/mnt
	sudo umount ./build/initrd.img

initcode:
	$(CC) $(CFLAGS) -march=rv64g -nostdinc -I. -Ikernel -c usr/src/initcode.S -o usr/build/initcode.o
	$(LD) $(LDFLAGS) -N -e start -Ttext 0 -o usr/build/initcode.out usr/build/initcode.o
	$(OBJCOPY) -S -O binary usr/build/initcode.out usr/build/initcode
	$(OBJDUMP) -S usr/build/initcode.o > usr/build/initcode.asm

clean:
	rm -rf $(OBJDIR)
	rm -rf ./usr/build/*


# try to generate a unique GDB port
GDBPORT = $(shell expr `id -u` % 5000 + 25000)
# QEMU's gdb stub command line changed in 0.11
QEMUGDB = $(shell if $(QEMU) -help | grep -q '^-gdb'; \
	then echo "-gdb tcp::$(GDBPORT)"; \
	else echo "-s -p $(GDBPORT)"; fi)

qemu-gdb: build_kernel .gdbinit initrd.img initcode
	@echo "*** Now run 'gdb' in another window." 1>&2
	$(QEMU) $(QEMUOPTS) -S $(QEMUGDB)