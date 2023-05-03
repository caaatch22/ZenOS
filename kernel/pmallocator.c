//allocator to allocate physical mem
#include "defs.h"
#include "pmallocator.h"
#include "cpu.h"
#include "string.h"
#include "log.h"

pm_freelist physical_mem;

extern char ekernel[];

void pm_freelist_init(void){

  physical_mem.head = (void *)0;

  pm_page_node *node = (pm_page_node *)PAGE_ROUNDUP(ekernel);

  while(node<(pm_page_node *)PAGE_ROUNDDOWN(PHYCICAL_MEM_END)) {
    pm_free(node);
  }
}


//non-lock list
void *pm_alloc(void)
{
  if(physical_mem.head==(void *)0)
    PANIC("PM_FULL");

  pm_page_node *allocated_node;

  while (1)
  {
    allocated_node = physical_mem.head;
    if(__sync_bool_compare_and_swap(&physical_mem.head, allocated_node, allocated_node->next))
      break;
  }

  allocated_node->next = (void *)0;

  return (void *)allocated_node;
}

void pm_free(pm_page_node *node)
{
  if(((uint64)node%PAGE_SIZE)!=0)
    PANIC("PM_FREE NOT ALIGNED");

  pm_page_node *old;

  memset((void *)node, PAGE_SIZE, 0);

  while (1)
  {
    node->next = physical_mem.head;
    old = physical_mem.head;
    if (__sync_bool_compare_and_swap(&physical_mem.head, node->next, node))
      break;
  }
}
