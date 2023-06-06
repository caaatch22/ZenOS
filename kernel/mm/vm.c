#include "mm/vm.h"
#include "arch/riscv.h"
#include "arch/hw.h"
#include "mm/pmallocator.h"
#include "proc/proc.h"
#include "utils/string.h"

pagetable_t kernel_pagetable;

extern char etext[];
extern char trapforward[];


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
      } else if (*pte == 0)
        PANIC("unable to make a lower pagetable");
    }

  }

  return pte;
}


// Look up a virtual address, return the physical address
uint64_t va2pa(pagetable_t pagetable, uint64_t va)
{
  uint64_t *pte = pte_fetch(pagetable, va);
  // should consider what is pte_fetch fail
  uint64_t pa = PTE2PA_PPN(*pte);

  return pa | (va & 0xFFFULL);
}

void va_page_bind(pagetable_t pt, uint64_t va, uint64_t pa, uint64_t PTE_PERM)
{
  if(PTE_PERM & (~(PTE_R|PTE_W|PTE_X)))
    PANIC("illegal permisson indicate");
  if (!ALIGNED(va) || !ALIGNED(pa))
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
  // LOG_DEBUG("pagesize=%p", size);
  if (PTE_PERM & (~(PTE_R | PTE_W | PTE_X)))
    PANIC("illegal perm indicate");
  if (!ALIGNED(va) || !(ALIGNED(pa)))
    PANIC("address not aligned");
  if (!ALIGNED(size))
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

void va_page_unbind(pagetable_t pt, uint64_t va, int do_free)
{
  uint64_t *pte = pte_fetch(pt, va);

  if ((*pte & PTE_V) == 0)
    PANIC("va not mapped in unbind page");

  // #define PTE_FLAGS(pte) ((pte) &0x3FF)
  // if (PTE_FLAGS(*pte) == PTE_V)
  //   PANIC("not the third level pte");

  if (do_free) {
    uint64_t pa = PTE2PA_PPN(*pte);
    pm_free((pm_page_node *)pa);
  }
  *pte = 0;
}

// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void va_page_unbind_range(pagetable_t pt, uint64_t va, uint64_t npages, int do_free)
{
  uint64_t a;
  LOG_DEBUG("va=%p npages=%d do_free=%d", va, npages, do_free);
  if (!ALIGNED(va))
    PANIC("page not aligned in unbind");

  for (a = va; a < va + npages * PAGE_SIZE; a += PAGE_SIZE) {
    va_page_unbind(pt, a, do_free);
  }
}


// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void free_pagetable_pages(pagetable_t pagetable)
{
  // there are 2^9 = 512 PTEs in a page table.
  for (int i = 0; i < 512; i++) {
    uint64_t pte = pagetable->page_entry[i];
    if ((pte & PTE_V) && (pte & (PTE_R | PTE_W | PTE_X)) == 0) {
      // this PTE points to a lower-level page table.
      uint64_t child = PTE2PA_PPN(pte);
      free_pagetable_pages((pagetable_t)child);
      pagetable->page_entry[i] = 0;
    } else if (pte & PTE_V) {
      PANIC("free_pagetable_pages is containing a valid page");
    }
  }
  pm_free((void *)pagetable);
}

// Free user memory pages,
// then free page-table pages.
// total_size used for checking
void free_user_mem_and_pagetables(pagetable_t pagetable, uint64_t total_size)
{
  // free ustack
  LOG_DEBUG("free_user_mem_and_pagetables free stack");
  va_page_unbind_range(pagetable, USTACK_BOTTOM - USTACK_SIZE, USTACK_SIZE / PAGE_SIZE, TRUE);
  total_size -= USTACK_SIZE;

  // free bin
  LOG_DEBUG("free_user_mem_and_pagetables free bin");

  va_page_unbind_range(pagetable, UTEXT_START, PAGE_ROUNDUP(total_size) / PAGE_SIZE, TRUE);
  total_size -= PAGE_ROUNDUP(total_size);

  ASSERT(total_size == 0, "total_size != 0 after freed");

  // free page-table pages
  free_pagetable_pages(pagetable);
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
  LOG_DEBUG("kernel text va=%p -> [%p, %p]", PHYSICAL_MEM_BASE
            , PHYSICAL_MEM_BASE, (uint64_t)etext);
  va_page_bind_range(kernel_pagetable, PHYSICAL_MEM_BASE, PHYSICAL_MEM_BASE, (uint64_t)etext - PHYSICAL_MEM_BASE, PTE_R | PTE_X);

  // map kernel data and the physical RAM we'll make use of.
  LOG_DEBUG("kernel data va=%p -> [%p, %p]", etext, etext, PHYSICAL_MEM_END);
  va_page_bind_range(kernel_pagetable, (uint64_t)etext, (uint64_t)etext, PHYSICAL_MEM_END - (uint64_t)etext, PTE_R | PTE_W);

  // map the trampoline for trap entry/exit to
  // the highest virtual address in the kernel.
  LOG_DEBUG("trampoline va=%p -> [%p, %p]", TRAPFORWARD, trapforward, trapforward + PAGE_SIZE);
  va_page_bind_range(kernel_pagetable, TRAPFORWARD, (uint64_t)trapforward, PAGE_SIZE, PTE_R | PTE_X);

}


// create an empty user page table.
// map trampoline page
// returns 0 if out of memory.
pagetable_t
create_empty_pagetable()
{
  pagetable_t pagetable;
  pagetable = (pagetable_t)pm_alloc();
  // do not need to memset, cause pm_alloc has memset that
  // if (pagetable != NULL) {
  //   memset(pagetable, 0, PGSIZE);
  // }
  return pagetable;
}



// Copy from kernel to user.
// Copy len bytes from src to virtual address dstva in a given page table.
// Return 0 on success, -1 on error.
int copyout(pagetable_t pagetable, uint64_t dstva, char *src, uint64_t len) {
  uint64_t n, va0, pa0;

  while (len > 0) {
    va0 = PAGE_ROUNDDOWN(dstva);
    uint64_t *pte = pte_fetch(pagetable, va0);
    pa0 = PTE2PA_PPN(*pte);
    if (pa0 == 0)
      return -1;
    n = PAGE_SIZE - (dstva - va0);
    if (n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);

    len -= n;
    src += n;
    dstva = va0 + PAGE_SIZE;
  }
  return 0;
}

// Copy from user to kernel.
// Copy len bytes to dst from virtual address srcva in a given page table.
// Return 0 on success, -1 on error.
int copyin(pagetable_t pagetable, char *dst, uint64_t srcva, uint64_t len) {
  uint64_t n, va0, pa0;

  while (len > 0) {
    va0 = PAGE_ROUNDDOWN(srcva);
    uint64_t *pte = pte_fetch(pagetable, va0);
    pa0 = PTE2PA_PPN(*pte);
    if (pa0 == 0)
      return -1;
    n = PAGE_SIZE - (srcva - va0);
    if (n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);

    len -= n;
    dst += n;
    srcva = va0 + PAGE_SIZE;
  }
  return 0;
}

int copyin2(char *dst, uint64_t srcva, uint64_t len) {
  return copyin(curr_proc()->pagetable, dst, srcva, len);
}

int copyout2(uint64_t dstva, char *src, uint64_t len) {
  return copyout(curr_proc()->pagetable, dstva, src, len);
}


// Copy a null-terminated string from user to kernel.
// Copy bytes to dst from virtual address srcva in a given page table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int copyinstr(pagetable_t pagetable, char *dst, uint64_t srcva, uint64_t max) {
  uint64_t n, va0, pa0;
  int got_null = 0;

  while (got_null == 0 && max > 0) {
    va0 = PAGE_ROUNDDOWN(srcva);
    pa0 = PTE2PA_PPN(*pte_fetch(pagetable, va0));
    pa0 = walkaddr(pagetable, va0);
    if (pa0 == 0) {
      LOG_DEBUG("bad addr");
      return -1;
    }
    n = PAGE_SIZE - (srcva - va0);
    if (n > max)
      n = max;

    char *p = (char *)(pa0 + (srcva - va0));
    while (n > 0) {
      if (*p == '\0') {
        *dst = '\0';
        got_null = 1;
        break;
      } else {
        *dst = *p;
      }
      --n;
      --max;
      p++;
      dst++;
    }

    srcva = va0 + PAGE_SIZE;
  }
  if (got_null) {
    return 0;
  } else {
    LOG_DEBUG("no null");
    return -1;
  }
}