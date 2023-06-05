#include "proc/proc.h"
#include "lock/spinlock.h"
#include "arch/hw.h"
#include "arch/cpu.h"
#include "arch/riscv.h"
#include "utils/string.h"
#include "trap/trap.h"
#include "mm/vm.h"
#include "mm/pmallocator.h"
#include "common/common.h"

extern void swtch(struct context *, struct context *);

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
  acquire_spinlock(&next_pid.lock);
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
  acquire_spinlock(&pool_lock);
  for (p = pool; p < &pool[NPROC]; p++) {
    if (p->state == UNUSED) {
      acquire_spinlock(&p->lock);
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

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *waiting_target, struct spinlock *lk) {

  struct proc *p = curr_proc();

  // tracecore("sleep");
  // Must acquire p->lock in order to
  // change p->state and then call switch_to_scheduler.
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.
  // print_proc(p);

  acquire_spinlock(&p->lock);

  release_spinlock(lk);

  // Go to sleep.
  p->waiting_target = waiting_target;
  p->state = SLEEPING;

  switch_to_scheduler();

  // Tidy up.
  p->waiting_target = NULL;

  // Reacquire original lock.

  release_spinlock(&p->lock);

  acquire_spinlock(lk);

}

void wakeup(void *waiting_target) {
  struct proc *p;

  for (p = pool; p < &pool[NPROC]; p++) {
    if (p != curr_proc()) {
      acquire_spinlock(&p->lock);
      if (p->state == SLEEPING && p->waiting_target == waiting_target) {
        p->state = RUNNABLE;
      }
      release_spinlock(&p->lock);
    }
  }
}

// Switch to scheduler.  Must hold only p->lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->noff, but that would
// break in the few places where a lock is held but
// there's no process.
void switch_to_scheduler(void) {
  uint64_t prev_intr_status;
  uint64_t old_ra = r_ra();

  struct proc *p = curr_proc();
  ASSERT(p->state != RUNNING, "current proc shouldn't be running");
  // ASSERT(holding(&p->lock), "should hold currernt proc's lock"); // holding currernt proc's lock
  ASSERT(mycpu()->intr_disable_depth == 1, "");                  // and it's the only lock
  // ASSERT(!intr_get(), "interrput should be off");                // interrput is off

  prev_intr_status = mycpu()->prev_intr_status;
  // LOG_DEBUG("in switch_to_scheduler before swtch prev_intr_status=%d", prev_intr_status);
  uint64_t old_sp = r_sp();
  swtch(&p->context, &mycpu()->prev_context); // will goto scheduler()
  uint64_t new_sp = r_sp();
  // LOG_DEBUG("in switch_to_scheduler after swtch");
  mycpu()->prev_intr_status = prev_intr_status;
}
