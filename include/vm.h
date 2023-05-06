#ifndef VM_H
#define VM_H

#include "defs.h"

#define VA_VPN_MASK (0x1FFul)
#define VA_VPN_SHIFT(level) (12 + (3 - level) * 9)
#define VA_VPN_FETCH(x, level) ((x >> VPN_SHIFT(level)) & VA_VPN_MASK)

#define PPN_MASK (0xFFFFFFFFFFFul)
#define PA_PPN_SHIFT (12)
#define PTE_PPN_SHIFT (10)

#define PA2PTE_PPN(x) (((x >> PA_PPN_SHIFT) & PPN_MASK) << PTE_PPN_SHIFT)
#define PTE2PA_PPN(x) (((x >> PTE_PPN_SHIFT) & PPN_MASK) << PA_PPN_SHIFT)

#define PTE_V (1ul << 0)
#define PTE_R (1ul << 1)
#define PTE_W (1ul << 2)
#define PTE_X (1ul << 3)
#define PTE_U (1ul << 4)

typedef struct pagetable_t
{
  uint64_t page_entry[1 << 9];
} pagetable_t;

uint64_t *pte_fetch(pagetable_t *, uint64_t);

#endif
