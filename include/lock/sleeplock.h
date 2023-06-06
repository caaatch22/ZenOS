#ifndef SLEEP_LOCK_H
#define SLEEP_LOCK_H

#include "lock/spinlock.h"
#include "arch/cpu.h"
#include "proc/proc.h"

typedef struct sleeplock {
  uint8_t locked;
  struct spinlock spinlock;

  char *nickname;
  struct proc *holder;
} sleeplock_t;

void init_sleeplock(sleeplock_t *, char *);
void acquire_sleeplock(sleeplock_t *);
void release_sleeplock(sleeplock_t *);
int holdingsleep(struct sleeplock *);

#endif
