#include "defs.h"
#include "log.h"
#include "riscv.h"
#include "status.h"
#include "spinlock.h"
#include <stdatomic.h>

void init_spinlock(spinlock *lock,char *name)
{
  lock->nickname = name;
  lock->locked = 0;
  lock->holder = 0;
}

void acqure_spinlock(spinlock *lock)
{
  push_off();
  if((lock->locked==1)&&(lock->holder==mycpu()))
    PANIC("MULTIPLE ACQUIRE\n");

  while(__sync_test_and_set(lock->locked,1))
    ;
  lock->holder = mycpu();
  __sync_synchronize();

  pop_off();
}

void release_spinlock(spinlock *lock)
{
  push_off();
  if(lock->locked==0)
    PANIC("attempt to release a unlocked spinlock\n");
  lock->locked = 0;
  pop_off();
}

void push_off()
{
  cpu_status *req_cpu = mycpu();
  uint64 prev_intr_status = r_sie();
  w_sie(0ul);

  if(req_cpu->intr_disable_depth==0) {
    req_cpu->prev_intr_status = prev_intr_status;
  }
  ++req_cpu->intr_disable_depth;
}

void pop_off()
{
  cpu_status *req_cpu = mycpu();
  --req_cpu->intr_disable_depth;
  if(req_cpu->intr_disable_depth==0) {
    w_sie(req_cpu->prev_intr_status);
  }
}
