#include "defs.h"
#include "pmallocator.h"
#include "hw.h"
#include "string.h"
#include "log.h"

pm_freelist physical_mem;

extern char ekernel[];

void pm_freelist_init()
{
  physical_mem.head = NULL;

  pm_page_node *node = (pm_page_node *)PAGE_ROUNDUP(ekernel);
  while(node < (pm_page_node *)PAGE_ROUNDDOWN(PHYSICAL_MEM_END)) {
    pm_free(node);
    node = (pm_page_node*)((uint64_t)node + PAGE_SIZE);
  }
}


//non-lock list
void *pm_alloc(void)
{
  pm_page_node *allocated_node;

  while (1) {
    allocated_node = physical_mem.head;
    if(physical_mem.head == NULL)
      PANIC("PM_FULL");
    if(__sync_bool_compare_and_swap(&physical_mem.head, allocated_node, allocated_node->next))
      break;
  }

  if(allocated_node)
    memset((void *)allocated_node, PAGE_SIZE, 0);

  return (void *)allocated_node;
}

void pm_free(pm_page_node *node)
{
  if(((uint64_t)node % PAGE_SIZE) != 0)
    PANIC("PM_FREE NOT ALIGNED");

  while (1) {
    node->next = physical_mem.head;
    if (__sync_bool_compare_and_swap(&physical_mem.head, node->next, node))
      break;
  }
}
