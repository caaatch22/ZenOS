#include "vm.h"
#include "hw.h"
#include "defs.h"
#include "log.h"
#include "riscv.h"
#include "pmallocator.h"

pagetable_t kernel_pagetable;

extern char etext[];

uint64_t *pte_fetch(pagetable_t pt, uint64_t va) //do not gaurd the given pte to be vaild or with any permission
{
  uint32_t ptindex, level;
  uint64_t *pte;

  for (level = 1; level <= 3; ++level) {
    ptindex = VA_VPN_FETCH(va, level);
    pte = &(pt->page_entry[ptindex]);

    if(level != 3) {
       //if pte_v is 1, allocator will not be invoked, otherwise a page will be allocated and its PPN will be stored in the pte
      if((*pte & PTE_V) || ((*pte = (PA2PTE_PPN((uint64_t)pm_alloc()))) != 0)) {
        if(*pte & (PTE_R|PTE_W|PTE_X))
          PANIC("high level pagetable entry with illegal permission!");

        *pte |= PTE_V;
        pt = (pagetable_t)PTE2PA_PPN(*pte);
      }
    }
    if(*pte == 0)
      PANIC("unable to make a lower pagetable");
  }

  return pte;
}

void va_page_bind(pagetable_t pt, uint64_t va, uint64_t pa, uint64_t PTE_PERM)
{
  if(PTE_PERM & (~(PTE_R|PTE_W|PTE_X)))
    PANIC("illegal permisson indicate");

  if((va & ~(PAGE_SIZE - 1)) || (pa & ~(PAGE_SIZE - 1)))
    PANIC("address not aligned");

  uint64_t *pte = pte_fetch(pt, va);
  if(*pte & PTE_V)
    PANIC("multiple va_pa_bind");

  *pte = PA2PTE_PPN(pa);
  *pte |= PTE_V;
  *pte |= PTE_PERM;
}

void va_page_bind_range(pagetable_t pt, uint64_t va, uint64_t pa ,uint64_t size, uint64_t PTE_PERM)
{
  if(PTE_PERM & (~(PTE_R|PTE_W|PTE_X)))
    PANIC("illegal perm indicate");

  if((va & ~(PAGE_SIZE - 1)) || (pa & ~(PAGE_SIZE - 1)))
    PANIC("address not aligned");
  if((size & ~(PAGE_SIZE - 1)))
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

void va_page_unbind(pagetable_t pt, uint64_t va)
{

}

void kernel_vmenable()
{
  sfence_vma();
  w_satp(MAKE_SATP(kernel_pagetable));
  sfence_vma();
  LOG_INFO("enable pageing at %p", r_satp());
}

void kernel_vminit()
{

  kernel_pagetable = (pagetable_t) pm_alloc();

  // map kernel text executable and read-only.
  va_page_bind_range(kernel_pagetable, PHYSICAL_MEM_BASE, PHYSICAL_MEM_BASE, (uint64_t)etext - PHYSICAL_MEM_BASE, PTE_R | PTE_X);

  // map kernel data and the physical RAM we'll make use of.
  va_page_bind_range(kernel_pagetable, (uint64_t)etext, (uint64_t)etext, PHYSICAL_MEM_END - (uint64_t)etext, PTE_R | PTE_W);

  // map the trampoline for trap entry/exit to
  // the highest virtual address in the kernel.
  // kvmmap(kernel_pagetable, TRAMPOLINE, (uint64_t)trampoline, PAGE_SIZE, PTE_R | PTE_X);

  // allocate and map a kernel stack for each process.
  // proc_mapstacks(kernel_pagetable);

}
