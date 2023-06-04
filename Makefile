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
-Wno-builtin-declaration-mismatch

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


all: $(OBJDIR)
	$(CC) $(CFLAGS) $(KSRCS) $(LSRCS) -o ./$(OBJDIR)/kernel

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
		-initrd local/initrd.img

$(OBJDIR):
	@mkdir -p $(OBJDIR)

clean:
	rm -rf $(OBJDIR)

