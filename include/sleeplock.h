#ifndef SLEEP_LOCK_H
#define SLEEP_LOCK_H

#include "spinlock.h"
#include "status.h"

typedef struct sleeplock {
  uint8_t locked;
  struct spinlock spinlock;

  char *nickname;
  proc_status *holder;
} sleeplock_t;

void init_sleeplock(sleeplock_t *, char *);
void acquire_sleeplock(sleeplock_t *);
void release_sleeplock(sleeplock_t *);

#endif
