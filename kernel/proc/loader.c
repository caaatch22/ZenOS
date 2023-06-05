#include "common/common.h"
#include "trap/trap.h"
#include "proc/proc.h"
#include "arch/hw.h"
#include "utils/string.h"
#include "mm/pmallocator.h"

static int app_cur, app_num;
static uint64_t *app_info_ptr;
extern char _app_num[], _app_names[];
const uint64_t BASE_ADDRESS = 0x1000; // user text start
char names[40][100];


void batchinit() {
  char* s;
  app_info_ptr = (uint64_t *) _app_num;
  app_cur = -1;
  app_num = *app_info_ptr;
  app_info_ptr++;

  s = _app_names;
  for (int i = 0; i < app_num; ++i) {
    int len = strlen(s);
    strncpy(names[i], (const char *)s, len);
    s += len + 1;
    LOG_TRACE("new name: %s\n", names[i]);
  }
}

int get_id_by_name(char* name) {
  for(int i = 0; i < app_num; ++i) {
    if(strncmp(name, names[i], 100) == 0)
      return i;
  }
  LOG_WARN("not find such app\n");
  return -1;
}

void alloc_ustack(struct proc *p) {

  va_page_bind_range(p->pagetable, USTACK_BOTTOM, USTACK_SIZE,
                     (uint64_t)pm_alloc(), PTE_U | PTE_R | PTE_W | PTE_X);
  p->ustack = USTACK_BOTTOM;
  p->trapframe->sp = p->ustack + USTACK_SIZE;

}


void bin_loader(uint64_t start, uint64_t end, struct proc *p) {
  LOG_INFO("load range = [%p, %p)\n", start, end);
  uint64_t s = PAGE_ROUNDDOWN(start), e = PAGE_ROUNDUP(end), length = e - s;
  for (uint64_t va = BASE_ADDRESS, pa = s; pa < e; va += PAGE_SIZE, pa += PAGE_SIZE) {
    void *page = pm_alloc();
    if (page == 0) {
      PANIC("bin_loader pm_alloc");
    }
    memmove(page, (const void *)pa, PAGE_SIZE);
    va_page_bind_range(p->pagetable, va, PAGE_SIZE, (uint64_t)page, PTE_U | PTE_R | PTE_W | PTE_X);
  }

  p->trapframe->epc = BASE_ADDRESS;
  alloc_ustack(p);
  p->total_size = USTACK_SIZE + length;
}


void loader(int id, void* p) {
  LOG_INFO("loader %s\n", names[id]);
  bin_loader(app_info_ptr[id], app_info_ptr[id+1], p);
}

int run_all_app() {
  struct proc *p = allocproc();
  p->parent = 0;
  int id = get_id_by_name("user_shell");
  if (id < 0)
    PANIC("no user shell");
  loader(id, p);
  p->state = RUNNABLE;
  release_spinlock(&p->lock);
  return 0;
}
