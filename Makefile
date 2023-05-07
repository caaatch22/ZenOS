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


BUILDDIR = build


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


all:
	$(CC) $(CFLAGS) $(KSRCS) $(LSRCS) -o ./build/kernel

qemu: all
	qemu-system-riscv64 -machine virt -nographic -bios default -m 128M -kernel ./build/kernel

clean:
	rm -rf $(BUILDDIR)
