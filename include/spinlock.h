#ifndef SPINLOCK_H
#define SPINLOCK_H

#include "defs.h"
#include "status.h"

struct spinlock {
  uint32_t locked;
  char *nickname;
  cpu_status *holder;
};

typedef struct spinlock spinlock_t;

void init_spinlock(spinlock_t *, char *);
void acquire_spinlock(spinlock_t *);
void release_spinlock(spinlock_t *);
void push_off();
void pop_off();

#endif
