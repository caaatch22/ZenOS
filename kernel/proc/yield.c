#include "proc/proc.h"
#include "common/common.h"

void yield(void) {
  struct proc *p = curr_proc();
  ASSERT(p != NULL, "yield() has no current proc");
  acquire_spinlock(&p->lock);

  p->state = RUNNABLE;
  switch_to_scheduler();

  release_spinlock(&p->lock);
}
