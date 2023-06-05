#include "proc/proc.h"
#include "lock/spinlock.h"
#include "arch/hw.h"
#include "arch/cpu.h"
#include "arch/riscv.h"
#include "utils/string.h"
#include "trap/trap.h"
#include "mm/vm.h"
#include "mm/pmallocator.h"

struct proc pool[NPROC];

__attribute__((aligned(16))) char kstack[NPROC][KSTACK_SIZE];


// helps ensure that wakeups of wait()ing
// parents are not lost. helps obey the
// memory model when using p->parent.
// must be acquired before any p->lock.
spinlock_t wait_lock;
spinlock_t pool_lock;

struct {
  int pid;
  spinlock_t lock;
} next_pid;

struct proc *
curr_proc()
{
  push_off();
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
  pop_off();
  return p;
}


void procinit(void) {
  struct proc *p;
  init_spinlock(&pool_lock, "pool_lock");
  init_spinlock(&wait_lock, "wait_lock");

  for (p = pool; p < &pool[NPROC]; p++) {
    init_spinlock(&p->lock, "proc.lock");
    p->state = UNUSED;
  }

  next_pid.pid = 1;
  init_spinlock(&next_pid.lock, "next_pid.lock");
}


int allocpid() {
  acqure_spinlock(&next_pid.lock);
  int pid = next_pid.pid;
  next_pid.pid++;
  release_spinlock(&next_pid.lock);
  return pid;
}

pagetable_t proc_pagetable(struct proc *p) {
  pagetable_t pagetable;

  // An empty page table.
  pagetable = create_empty_pagetable();
  if (pagetable == NULL)
    PANIC("cannot create empty user pagetable");

  // if bind failed, the page allocated should be free (NOT handled here)
  va_page_bind_range(pagetable, TRAPFORWARD, PAGE_SIZE,
                     (uint64_t)trapforward, PTE_R | PTE_X);

  if ((p->trapframe = (struct trapframe *)pm_alloc()) == 0) {
    PANIC("alloc trapframe page failed\n");
  }

  // map the trapframe just below TRAMPOLINE, for trampoline.S.
  va_page_bind_range(pagetable, TRAPFRAME, PAGE_SIZE,
                     (uint64_t)(p->trapframe), PTE_R | PTE_W);
  return pagetable;
}

struct proc *allocproc(void)
{
  struct proc *p;
  acqure_spinlock(&pool_lock);
  for (p = pool; p < &pool[NPROC]; p++) {
    if (p->state == UNUSED) {
      acqure_spinlock(&p->lock);
      release_spinlock(&pool_lock);
      goto found;
    }
  }
  release_spinlock(&pool_lock);
  LOG_DEBUG("no proc alloced");
  return 0;

found:
  p->pid = allocpid();
  p->state = USED;
  p->total_size = 0;
  p->heap_sz = 0;
  p->exit_code = -1;
  p->parent = 0;
  p->ustack = 0;
  p->pagetable = proc_pagetable(p);
  if (p->pagetable == 0) {
    PANIC("");
  }
  memset(&p->context, 0, sizeof(p->context));
  memset((void *)p->kstack, 0, KSTACK_SIZE);
  // LOG_DEBUG("memset done");
  p->context.ra = (uint64_t)usertrapret; // used in swtch()
  p->context.sp = p->kstack + KSTACK_SIZE;

  p->stride = 0;
  p->priority = 16;
  return p;
}