all:
	riscv64-unknown-elf-gcc -mcmodel=medany -T kernel/kernel.lds -I ./include -static -nostdlib -fno-pie -no-pie -Wbuiltin-declaration-mismatch ./lib/*.c ./kernel/*.c ./kernel/*.S -o ./build/kernel

qemu:
	qemu-system-riscv64 -machine virt -nographic -bios default -m 128M -kernel ./build/kernel
