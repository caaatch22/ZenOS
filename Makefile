K = kernel
I = include
L = lib

KSRCS = $(K)/*.c
KSRCS += $(K)/*.S

LSRCS = $(L)/*.c

CC = riscv64-unknown-elf-gcc

CFLAGS = \
-mcmodel=medany \
-T $(K)/kernel.lds \
-I $(I) \
-static \
-nostdlib \
-fno-pie -no-pie \
-Wno-builtin-declaration-mismatch

all:
	$(CC) $(CFLAGS) $(KSRCS) $(LSRCS) -o ./build/kernel

qemu:
	qemu-system-riscv64 -machine virt -nographic -bios default -m 128M -kernel ./build/kernel

clean:
	rm -rf ./build/*
