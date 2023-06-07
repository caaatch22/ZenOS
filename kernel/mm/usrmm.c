#include "common/defs.h"
#include "mm/usrmm.h"
#include "mm/kmalloc.h"
#include "proc/proc.h"
#include "mm/vm.h"
#include "mm/pmallocator.h"

// 为一个seg分配内存，并为其对应的代码分配内存。
// 同时按照该seg对应代码的内存地址前后顺序，将其
// 插入到seg链中
struct seg*
newseg(pagetable_t pagetable, struct seg *head, enum segtype type, uint64_t offset, uint64_t sz, long flag)
{
  uint64_t nstart, nend;
  nstart = PAGE_ROUNDDOWN(offset);
  nend = PAGE_ROUNDUP(offset + sz);

  LOG_INFO("type=%d nstart=%p nend=%p\n", type, nstart, nend);
  // LOG_INFO("sizeof(struct seg): %d\n", sizeof(struct seg));
  struct seg *seg = NULL;
  for(struct seg *s = head; s != NULL; s = s->next)
  {
    uint64_t start, end;
    start = s->addr;
    end = s->addr + s->sz;
    // LOG_INFO("type=%d start=%p end=%p\n", s->type, start, end);
    if(nend <= start)
    {
      break;
    }
    else if(nstart >= end){
      seg = s;
    }
    else
    {
      LOG_ERROR("segments overlap\n");
	    return NULL;
    }
  }

  // LOG_INFO("calling to kmalloc\n");
  struct seg *p;
  if((p = (struct seg *)kmalloc(sizeof(struct seg))) == NULL)
  {
    LOG_ERROR("fail to kmalloc\n");
	  return NULL;
  }

  // 为该段对应的代码在内存中申请一段空间
  if(uvmalloc(pagetable, nstart, nend, flag) == 0)
  {
    kfree(p);
    LOG_ERROR("newseg", "fail to uvmalloc\n");
	  return NULL;
  }

  if(seg == NULL)
  {
    p->next = head;
    head = p;
  }
  else
  {
    p->next = seg->next;
    seg->next = p;
  }
  p->addr = offset;
  p->sz = sz;
  p->type = type;
  p->flag = flag;

  // LOG_INFO("done\n");
  // return p;
  return head;
}

enum segtype
typeofseg(struct seg *head, uint64_t addr)
{
  head = locateseg(head, addr);

  return head == NULL ? NONE : head->type;
}

struct seg*
locateseg(struct seg *head, uint64_t addr)
{
  while(head){
    uint64_t start, end;
    start = head->addr;
    end = head->addr + head->sz;
    // LOG_INFO("type=%d start=%p end=%p\n", head->type, start, end);
    if(addr >= start && addr < end)
    {
      return head;
    }
    else if(addr >= end)
      head = head->next;
    else{
      LOG_ERROR("va=%p in no segment\n", addr);
	  return NULL;
    }
  }

  return NULL;
}

struct seg*
getseg(struct seg *head, enum segtype type)
{
  for (struct seg *seg = head; seg != NULL; seg = seg->next) {
    if (seg->type == type)
      return seg;
  }
  return NULL;
}

// end is not included
enum segtype
partofseg(struct seg *head, uint64_t start, uint64_t end)
{
  LOG_INFO("start=%p end=%p\n", start, end);
  enum segtype st = typeofseg(head, start);
  if (st == NONE)
    return NONE;

  return st == typeofseg(head, end - 1) ? st : NONE;
}

void 
freeseg(pagetable_t pagetable, struct seg *p)
{
  uvmdealloc(pagetable, p->addr, p->addr+p->sz, p->type);
  p->sz = 0;
}

struct seg*
delseg(pagetable_t pagetable, struct seg *s)
{
  struct seg *next = s->next;
  uvmdealloc(pagetable, s->addr, s->addr + s->sz, s->type);

  if(s->type == MMAP && s->file_mmap)
    fileclose(s->file_mmap);

  kfree(s);
  return next;
}

void
delsegs(pagetable_t pagetable, struct seg *head){
  while(head){
    head = delseg(pagetable, head);
  }
}