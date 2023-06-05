#ifndef HW_H
#define HW_H
//describe cpu and board parameters

#define PAGE_SIZE (1 << 12)

#define PHYSICAL_MEM_SIZE (1 << 27) //128M
#define PHYSICAL_MEM_BASE 0x80000000
#define PHYSICAL_MEM_END (PHYSICAL_MEM_BASE + PHYSICAL_MEM_SIZE)

#define MAXVA (1L << (9 + 9 + 9 + 12 - 1))  // 256 GB

#define USER_TOP (MAXVA)    // virtual address
#define TRAPFORWARD (USER_TOP - PAGE_SIZE)  // virtual address
#define TRAPFRAME (TRAPFORWARD - PAGE_SIZE) // virtual address

#define NCPU 2

#define VIRT_MMIO_VIRTIO_BASE 0x10001000
#define VIRT_MMIO_VIRTIO_SIZE 0x1000

#define VIRTIO0_IRQ 1

#define VIRT_MMIO_PLIC_BASE 0xc000000
#define VIRT_MMIO_PLIC_SIZE (0x200000 + NCPU * 0x1000)
#define INITRD_START 0x84200000
#define INITRD_END 0x86a00000

// qemu puts platform-level interrupt controller (PLIC) here.
#define PLIC 0x0c000000L       // 192 MB
#define PLIC_PRIORITY (PLIC + 0x0)
#define PLIC_PENDING (PLIC + 0x1000)
#define PLIC_MENABLE(hart) (PLIC + 0x2000 + (hart)*0x100)
#define PLIC_SENABLE(hart) (PLIC + 0x2080 + (hart)*0x100)
#define PLIC_MPRIORITY(hart) (PLIC + 0x200000 + (hart)*0x2000)
#define PLIC_SPRIORITY(hart) (PLIC + 0x201000 + (hart)*0x2000)
#define PLIC_MCLAIM(hart) (PLIC + 0x200004 + (hart)*0x2000)
#define PLIC_SCLAIM(hart) (PLIC + 0x201004 + (hart)*0x2000)

#define USTACK_BOTTOM 0xC0000000   // 3GB, user stack lower address

#endif
