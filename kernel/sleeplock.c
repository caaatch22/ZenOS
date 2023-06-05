#include "sleeplock.h"
#include "spinlock.h"

sleep(void *, spinlock_t *);
wakeup(void *);

void init_sleeplock(sleeplock_t *lock, char *name)
{
  lock->locked = 0;
  init_spinlock(&lock->spinlock, name);
  lock->nickname = name;
  lock->holder = NULL;
}

void acquire_sleeplock(sleeplock_t *lock)
{
  acquire_spinlock(&lock->spinlock);
  while(lock->locked = 1) {
    sleep(lock, &lock->spinlock);
  }

  lock->holder = myproc();
  lock->locked = 1;

  release_spinlock(&lock->spinlock);
}

void release_sleeplock(sleeplock_t *lock)
{
  acquire_spinlock(&lock->spinlock);
  lock->holder = NULL;
  lock->locked = 0;
  wakeup(lock);
  release_spinlock(&lock->spinlock);
}
