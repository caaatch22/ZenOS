#include "proc/scheduler.h"
#include "proc/proc.h"
#include "lock/spinlock.h"
#include "common/common.h"

extern void swtch(struct context *old, struct context *new);

void scheduler(void)
{

  for (;;) {
    uint64_t min_stride = ~0ULL;
    struct proc *next_proc = NULL;
    int any_proc = FALSE;
    // lock when picking proc
    acquire_spinlock(&pool_lock);
    for (struct proc *p = pool; p < &pool[NPROC]; p++) {
      if (!p->state == UNUSED) {
        any_proc = TRUE;
      }
      if (p->state == RUNNABLE && !p->lock.locked) {
        if (p->stride < min_stride) {
          min_stride = p->stride;
          next_proc = p;
        }
      }
    }

    if (next_proc != NULL) {
      // found a process to run, lock down the proc;
      acquire_spinlock(&next_proc->lock);
    }
    // picking proc done
    release_spinlock(&pool_lock);

    if (next_proc != NULL) {
      LOG_TRACE("Core %d pick proc %s\n", cpuid(), next_proc->name);
            
      struct cpu *mycore = mycpu();
      mycore->proc = next_proc;
      next_proc->state = RUNNING;

      uint64_t pass = BIGSTRIDE / (next_proc->priority);
      next_proc->stride += pass;

      swtch(&mycpu()->prev_context, &next_proc->context);
      mycore->proc = NULL;

      release_spinlock(&next_proc->lock);
    } else {
      if (!any_proc) {
        LOG_ERROR("zero proc in pool");
        break;
        // end scheduler, kernel will shutdown
      }
    }
  }
}