#ifndef VM_H
#define VM_H

#include "common/defs.h"

#define VA_VPN_MASK (0x1FFul)
#define VA_VPN_SHIFT(level) (12 + (3 - level) * 9)
#define VA_VPN_FETCH(x, level) ((x >> VA_VPN_SHIFT(level)) & VA_VPN_MASK)

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

struct pagetable {
  uint64_t page_entry[1 << 9];
};

typedef struct pagetable* pagetable_t;

uint64_t *pte_fetch(pagetable_t pt, uint64_t va);

void va_page_bind(pagetable_t pt, uint64_t va, uint64_t pa, uint64_t PTE_PERM);

void va_page_bind_range(pagetable_t pt, uint64_t va, uint64_t pa, uint64_t size, uint64_t PTE_PERM);

void va_page_unbind(pagetable_t pt, uint64_t va, int do_free);

void va_page_unbind_range(pagetable_t pt, uint64_t va, uint64_t npages, int do_free);

void kernel_vmenable();

void kernel_vminit();

void free_user_mem_and_pagetables(pagetable_t pagetable, uint64_t total_size);

void free_pagetable_pages(pagetable_t pagetable);

pagetable_t create_empty_pagetable();

int copyin_impl(pagetable_t pagetable, char *dst, uint64_t srcva, uint64_t len);

int copyout_impl(pagetable_t pagetable, uint64_t dstva, char *src, uint64_t len);

int copyin(char *dst, uint64_t srcva, uint64_t len);

int copyout(uint64_t dstva, char *src, uint64_t len);

#endif
