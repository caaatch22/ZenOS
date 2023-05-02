#include "defs.h"
#include "log.h"
#include "riscv.h"
#include "spinlock.h"

void init_spinlock(spinlock *lock,char *name)
{
  lock->nickname = name;
  lock->locked = 0;
  lock->holder = 0;
}

void acqure_spinlock(spinlock *lock)
{
  push_off();
}
