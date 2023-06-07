#include "proc/proc.h"
#include "lock/spinlock.h"
#include "arch/hw.h"
#include "arch/cpu.h"
#include "arch/riscv.h"
#include "utils/string.h"
#include "trap/trap.h"
#include "mm/vm.h"
#include "fs/vfs.h"
#include "mm/pmallocator.h"
#include "common/common.h"

extern void swtch(struct context *, struct context *);
extern void rootfs_init();

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

// Free a process's page table, and free the
// physical memory it refers to.
void proc_free_mem_and_pagetable(struct proc* p) {
  va_page_unbind(p->pagetable, TRAPFORWARD, FALSE); // unmap, don't recycle physical, shared
  va_page_unbind(p->pagetable, TRAPFRAME, TRUE);   // unmap, should recycle physical
  p->trapframe = NULL;

  // dont need it, cause we currently dont support shmem
  // // unmap shared memory
  // for (int i = 0; i < MAX_PROC_SHARED_MEM_INSTANCE; i++) {
  //   if (p->shmem[i]) { // active shared memory
  //     LOG_DEBUG("free shared mem");
  //     uvmunmap(p->pagetable, (uint64)p->shmem_map_start[i], p->shmem[i]->page_cnt, FALSE);
  //     // debugcore("free page = %d", get_free_page_count());
  //     drop_shared_mem(p->shmem[i]);
  //     p->shmem[i] = NULL;
  //     p->shmem_map_start[i] = 0;
  //     // LOG_DEBUG("free page = %d", get_free_page_count());
  //   }
  // }

  free_user_mem_and_pagetables(p->pagetable, p->total_size);
  p->pagetable = NULL;
  p->total_size = 0;
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
  p->killed = FALSE;
  p->waiting_target = NULL;
  p->parent = NULL;
  p->ustack = 0;
  p->pagetable = proc_pagetable(p);
  if (p->pagetable == 0) {
    PANIC("");
  }
  memset(&p->context, 0, sizeof(p->context));
  p->kstack = (uint64_t)kstack[p - pool];
  memset((void *)p->kstack, 0, KSTACK_SIZE);
  // LOG_DEBUG("memset done");
  p->context.ra = (uint64_t)forkret; // used in swtch()
  p->context.sp = p->kstack + KSTACK_SIZE;

  p->stride = 0;
  p->priority = 16;
  for (int i = 0; i < FD_MAX; i++) {
    p->ofiles[i] = NULL;
  }
  p->user_time = 0;
  p->kernel_time = 0;
  p->cwd = NULL;
  p->name[0] = '\0';
  return p;
}

/**
 * clean a process struct
 * The only useful action is "p->state = UNUSED"
 * the others are just for safety
 * should hold p->lock
 */
void freeproc(struct proc *p) {
  ASSERT(holding(&p->lock), "should lock the process to free");

  ASSERT(p->trapframe == NULL, "p->trapfram is pointing somewhere, did you forget to free trapframe?");
  ASSERT(p->pagetable == NULL, "p->pagetable is pointing somewhere, did you forget to free pagetable?");
  ASSERT(p->cwd == NULL, "p->cwd is not NULL, did you forget to release the inode?");
  ASSERT(p->waiting_target == NULL, "p->cwd is waiting something");
  ASSERT(p->total_size == 0, "memory not freed");
  ASSERT(p->heap_sz == 0, "heap not freed");

  p->state = UNUSED; // very important
  p->pid = 0;
  p->killed = FALSE;
  p->parent = NULL;
  p->exit_code = 0;
  p->ustack = 0;
  p->kstack = 0;
  memset(&p->context, 0, sizeof(p->context));
  p->stride = 0;
  p->priority = 0;
  // p->cpu_time = 0;
  // p->last_start_time = 0;
  for (int i = 0; i < FD_MAX; i++) {
    ASSERT(p->ofiles[i] == NULL, "some file is not closed");
  }
  memset(p->name, 0, PROC_NAME_MAX);

  // now everything should be clean
  // still holding the lock
}


// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *waiting_target, struct spinlock *lk) {

  struct proc *p = curr_proc();

  LOG_TRACE("sleep");
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


/**
 * Allocate a file descriptor of this process for the given file
 */
int fdalloc(struct file *f) {
  struct proc *p = curr_proc();

  for (int i = 0; i < FD_MAX; ++i) {
    if (p->ofiles[i] == 0) {
      p->ofiles[i] = f;
      return i;
    }
  }
  return -1;
}

int fdalloc2(struct file *f, int fd) {
  struct proc *p = curr_proc();

  if (fd < 0 || fd >= FD_MAX) {
    return -1;
  }
  if (p->ofiles[fd] != 0) {
    LOG_INFO("p->ofiles[fd] != 0");
    // TODO: do we need it?
    // fileclose(p->ofiles[fd]);
    return -1;
  }
  p->ofiles[fd] = f;
  return fd;
}

// get the given process and its child processes running time in ticks
// include kernel time and user time
int get_cpu_time(struct proc *p, struct tms *tms) {
  if (p == NULL) {
   LOG_INFO("get_cpu_time: p is NULL");
   return -1;
  }
  if (tms == NULL) {
    LOG_INFO("get_cpu_time: tms is NULL");
    return -1;
  }

  tms->tms_utime = p->user_time;
  tms->tms_stime = p->kernel_time;
  tms->tms_cutime = 0;
  tms->tms_cstime = 0;

  acquire_spinlock(&pool_lock);
  struct proc *child;
  for (child = pool; child < &pool[NPROC]; child++) {
    if (child != p) {// avoid deadlock
      acquire_spinlock(&child->lock);
      if (child->state != UNUSED && child->parent == p) {
        // found a child
        tms->tms_cutime += child->user_time;
        tms->tms_cstime += child->kernel_time;
      }
      release_spinlock(&child->lock);
    }
  }
  release_spinlock(&pool_lock);
  return 0;
}


// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
  // printf("run in forkret\n");
  static int first = 1;

  // Still holding p->lock from scheduler.
  release_spinlock(&curr_proc()->lock);

  // clean float-system
	// w_sstatus_fs(SSTATUS_FS_CLEAN);
  struct proc *p = curr_proc();

  if (first) {
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    // printf("[forkret]first scheduling\n");
    first = 0;
    rootfs_init();
    p->cwd = namei("/");
  }

  // p->iktmp = readtime();
  usertrapret();
}
