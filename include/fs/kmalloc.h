#ifndef KMALLOC_H
#define KMALLOC_H

#include "defs.h"

/*
 * init allocator
 */
void 			kmallocinit(void);

/*
 * allocate a range of mem of wanted size
 */
void*           kmalloc(uint32_t size);

/*
 * free memory starts with `addr`
 */
void            kfree(void *addr);

void 			kmview(void);

#endif
