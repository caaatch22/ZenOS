#ifndef SPINLOCK_H
#define SPINLOCK_H

#include "defs.h"
#include "status.h"

typedef struct spinlock
{
  uint32 locked;
  char *nickname;
  cpu_status *holder;
} spinlock;

void init_spinlock(spinlock *,char *);
void push_off(void);
void pop_off(void);

#endif
