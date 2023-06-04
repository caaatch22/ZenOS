K = kernel
I = include
L = lib

KSRCS = $(K)/*.c
KSRCS += $(K)/*.S

LSRCS = $(L)/*.c

TOOLPREFIX = riscv64-unknown-elf-
CC = $(TOOLPREFIX)gcc
AS = $(TOOLPREFIX)gcc
LD = $(TOOLPREFIX)ld
OBJCOPY = $(TOOLPREFIX)objcopy
OBJDUMP = $(TOOLPREFIX)objdump
GDB = $(TOOLPREFIX)gdb

OBJDIR = build


CFLAGS = \
-mcmodel=medany \
-T $(K)/kernel.lds \
-I $(I) \
-static \
-nostdlib \
-fno-pie -no-pie \
-Wno-builtin-declaration-mismatch \
-Wl,--no-warn-rwx-segments

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


all: $(OBJDIR) initrd.img
	$(CC) $(CFLAGS) $(KSRCS) $(LSRCS) -o ./$(OBJDIR)/kernel
	echo "kernel compiled"

qemu: all
	qemu-system-riscv64 \
		-machine virt \
		-smp 2 \
		-nographic \
		-bios default \
		-m 128M \
		-kernel ./build/kernel \
		-drive file=local/sdcard.img,if=none,format=raw,id=x0 \
		-device virtio-blk-device,drive=x0,bus=virtio-mmio-bus.0 \
		-initrd ./build/initrd.img

$(OBJDIR):
	@mkdir -p $(OBJDIR)

initrd.img:
	-umount ./build/initrd.img
	dd if=/dev/zero of=./build/initrd.img bs=512 count=81920
	mkfs.vfat -F 32 ./build/initrd.img
	-mkdir ./build/mnt
	mount ./build/initrd.img ./build/mnt
	mkdir ./build/mnt/bin
	mkdir ./build/mnt/dev
	umount ./build/initrd.img

clean:
	rm -rf $(OBJDIR)

