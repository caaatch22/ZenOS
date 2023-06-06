#include "common/common.h"
#include "arch/riscv.h"
#include "lock/spinlock.h"

void init_spinlock(spinlock_t *lock,char *name)
{
  lock->nickname = name;
  lock->locked = 0;
  lock->holder = 0;
}

void acquire_spinlock(spinlock_t *lock)
{
  push_off();  //disable interrupt
  if((lock->locked == 1) && (lock->holder == mycpu()))
    PANIC("MULTIPLE ACQUIRE\n");

  while(__sync_lock_test_and_set(&lock->locked, 1))
    ;
  lock->holder = mycpu();
  __sync_synchronize();

}

void release_spinlock(spinlock_t *lock)
{
  if(lock->locked == 0)
    PANIC("attempt to release a unlocked spinlock\n");
  lock->locked = 0;
  pop_off();
}

void push_off()
{
  struct cpu *req_cpu = mycpu();
  uint64_t prev_intr_status = r_sie();
  w_sie(0ul);

  if(req_cpu->intr_disable_depth == 0) {
    req_cpu->prev_intr_status = prev_intr_status;
  }
  ++req_cpu->intr_disable_depth;
}

void pop_off()
{
  struct cpu *req_cpu = mycpu();
  --req_cpu->intr_disable_depth;
  if(req_cpu->intr_disable_depth == 0) {
    w_sie(req_cpu->prev_intr_status);
  }
}

// Check whether this cpu is holding the lock.
// Interrupts must be off.
int holding(struct spinlock *lk) {
  int r;
  r = (lk->locked && lk->holder == mycpu());
  return r;
}