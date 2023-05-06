#include "defs.h"
#include "vm.h"
#include "riscv.h"
#include "pmallocator.h"

uint64_t *pte_fetch(pagetable_t *pt, uint64_t va) //do not gaurd the given pte to be vaild or with any permission
{
  uint32_t ptindex, level;
  uint64_t *pte;

  for (level = 1; level <= 3; ++level) {
    ptindex = VA_VPN_FETCH(va, level);
    pte = &pt->page_entry[ptindex];

    if(level!=3) {
      if((*pte & PTE_V) || ((*pte = (PA2PTE_PPN((uint64_t)pm_alloc()))) != NULL)) { //if pte_v=1, allocator will not be invoked, otherwise a page will be allocated and its ppn will be stored in the pte
        if(*pte & (PTE_R|PTE_W|PTE_X))
          PANIC("high level pagetable entry with unauthority permission !");

        *pte |= PTE_V;
        pt = PTE2PA_PPN(*pte);
      }
    }
    if(*pte==NULL)
      PANIC("unable to make a lower pagetable");
  }

  return pte;
}

void va_page_bind(pagetable_t *pt, uint64_t va, uint64_t pa, uint64_t PTE_PERM)
{
  if(PTE_PERM & (~(PTE_R|PTE_W|PTE_X)))
    PANIC("illegal perm indicate");

  if((va & ~(PAGE_SIZE-1)) || (pa & ~(PAGE_SIZE-1)))
    PANIC("address not aligned");

  uint64_t *pte = pte_fetch(pt, va);
  if(*pte & PTE_V)
    PANIC("multiple va_pa_bind");

  *pte = PA2PTE_PPN(pa);
  *pte |= PTE_V;
  *pte |= PTE_PERM;
}

void va_page_bind_range(pagetable_t *pt, uint64_t va, uint64_t pa ,uint64_t size, uint64_t PTE_PERM)
{
  if(PTE_PERM & (~(PTE_R|PTE_W|PTE_X)))
    PANIC("illegal perm indicate");

  if((va & ~(PAGE_SIZE-1)) || (pa & ~(PAGE_SIZE-1)))
    PANIC("address not aligned");
  if((size & ~(PAGE_SIZE-1)))
    PANIC("size not aligned");

  uint64_t range_end = va + size;

  while(va < range_end) {
    va_page_bind(pt, va, pa, PTE_PERM);
    va += PAGE_SIZE;
    pa += PAGE_SIZE;
  }

  if(va != range_end)
    PANIC("range bind error");
}

void va_page_unbind(pagetable_t *pt, uint64_t va)
{

}

void kernel_vminit()
{

}
