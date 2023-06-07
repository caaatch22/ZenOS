#ifndef VM_H
#define VM_H

#include "common/defs.h"
enum segtype;

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

#define PTE_FLAGS(pte) ((pte) &0x3FF)

// Flags of unmappages()
#define VM_FREE (1 << 0)  // free the pages when unmapping
#define VM_USER (1 << 1)  // are the pages belong to user?
#define VM_HOLE (1 << 2)  // whether allow unmapped or invalid hole in the pages range

struct pagetable {
  uint64_t page_entry[1 << 9];
};

typedef struct pagetable* pagetable_t;

uint64_t *pte_fetch(pagetable_t pt, uint64_t va);

uint64_t va2pa(pagetable_t pagetable, uint64_t va);

void va_page_bind(pagetable_t pt, uint64_t va, uint64_t pa, uint64_t PTE_PERM);

void va_page_bind_range(pagetable_t pt, uint64_t va, uint64_t pa, uint64_t size, uint64_t PTE_PERM);

void va_page_unbind(pagetable_t pt, uint64_t va, int do_free);

void va_page_unbind_range(pagetable_t pt, uint64_t va, uint64_t npages, int do_free);

void kernel_vmenable();

void kernel_vminit();

void free_user_mem_and_pagetables(pagetable_t pagetable, uint64_t total_size);

void free_pagetable_pages(pagetable_t pagetable);

pagetable_t create_empty_pagetable();

int copyin(pagetable_t pagetable, char *dst, uint64_t srcva, uint64_t len);

int copyout(pagetable_t pagetable, uint64_t dstva, char *src, uint64_t len);

int copyin2(char *dst, uint64_t srcva, uint64_t len);

int copyout2(uint64_t dstva, char *src, uint64_t len);

int copyinstr(pagetable_t pagetable, char *dst, uint64_t srcva, uint64_t max);

int copyinstr2(char *dst, uint64_t srcva, uint64_t max);

int uvmcopy(pagetable_t old_pagetable, pagetable_t new_pagetable, uint64_t total_size);

uint64_t
uvmalloc(pagetable_t pagetable, uint64_t start, uint64_t end, int perm);

uint64_t
uvmdealloc(pagetable_t pagetable, uint64_t start, uint64_t end, enum segtype segt);

void uvmfree(pagetable_t pagetable);

#endif
