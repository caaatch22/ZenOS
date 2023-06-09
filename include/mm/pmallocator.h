#ifndef PMALLOCATOR_H
#define PMALLOCATOR_H

#include "common/defs.h"
#include "arch/hw.h"


#define PAGE_ROUNDUP(x)  (((uint64_t)x + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1))
#define PAGE_ROUNDDOWN(x) ((uint64_t)x & ~(PAGE_SIZE - 1))
#define ALIGNED(x) (!((uint64_t)x & (PAGE_SIZE - 1)))

typedef struct pmfreelist {
  struct pmpagenode *head;
} pm_freelist;

typedef struct pmpagenode {
  struct pmpagenode *next;
} pm_page_node;

void pm_init();

void *pm_alloc();

void pm_free(pm_page_node *node);

#endif
