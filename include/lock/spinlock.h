#ifndef SPINLOCK_H
#define SPINLOCK_H

#include "common/defs.h"
#include "arch/cpu.h"

struct spinlock {
  uint32_t locked;
  char *nickname;
  struct cpu *holder;
};

typedef struct spinlock spinlock_t;

void init_spinlock(spinlock_t* lock, char* name);
void push_off();
void pop_off();

#endif
