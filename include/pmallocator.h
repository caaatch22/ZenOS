#ifndef PMALLOCATOR_H
#define PMALLOCATOR_H

#include "defs.h"

#define PAGE_SIZE (1 << 12) //4KB

#define PAGE_ROUNDUP(x) ((((uint64_t)x) + PAGE_SIZE - 1) - ((((uint64_t)x) + PAGE_SIZE - 1) % PAGE_SIZE))
#define PAGE_ROUNDDOWN(x) (((uint64_t)x)-(((uint64_t)x) % PAGE_SIZE))

typedef struct pmfreelist
{
  struct pmpagenode *head;
} pm_freelist;

typedef struct pmpagenode
{
  struct pmpagenode *next;
} pm_page_node;

void pm_freelist_init(void);

void *pm_alloc(void);

void pm_free(pm_page_node *);

#endif
