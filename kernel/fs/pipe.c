#include "fs/pipe.h"
#include "common/common.h"
#include "arch/riscv.h"
#include "lock/spinlock.h"
#include "proc/proc.h"
#include "lock/sleeplock.h"
#include "fs/file.h"
#include "mm/vm.h"
#include "mm/pmallocator.h"

int
pipealloc(struct file **f0, struct file **f1)
{
  struct pipe *pi;

  pi = NULL;
  *f0 = *f1 = NULL;
  if((*f0 = filealloc()) == NULL || (*f1 = filealloc()) == NULL)
    goto bad;
  if((pi = (struct pipe*)pm_alloc()) == NULL)
    goto bad;

  pi->readopen = 1;
  pi->writeopen = 1;
  pi->nwrite = 0;
  pi->nread = 0;
  init_spinlock(&pi->lock, "pipe.lock");
  (*f0)->type = FD_PIPE;
  (*f0)->readable = 1;
  (*f0)->writable = 0;
  (*f0)->pipe = pi;
  // not support poll right now
  // (*f0)->poll = pipepoll;

  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = pi;

  return 0;

 bad:
  if(pi)
    pm_free((char*)pi);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}

void
pipeclose(struct pipe *pi, int writable)
{
  acquire_spinlock(&pi->lock);
  if(writable){
    pi->writeopen = 0;
    wakeup(&pi->nread);
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    release_spinlock(&pi->lock);
    pm_free((char*)pi);
  } else
    release_spinlock(&pi->lock);
}


// int
// pipewrite(struct pipe *pi, uint64_t addr, int n)
// {
//   int i = 0;
//   char ch;
//   struct proc *pr = myproc();

//   acquire_spinlock(&pi->lock);
//   for(i = 0; i < n; i++) {
//     while(pi->nwrite == pi->nread + PIPESIZE) {  //DOC: pipewrite-full
//       if(pi->readopen == 0 || pr->killed){
//         release(&pi->lock);
//         return -1;
//       }
//       wakeup(&pi->nread);
//       sleep(&pi->nwrite, &pi->lock);
//     }
//     // if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
//     if(copyin2(&ch, addr + i, 1) == -1)
//       break;
//     pi->data[pi->nwrite++ % PIPESIZE] = ch;
//   }
//   wakeup(&pi->nread);
//   release_spinlock(&pi->lock);

//   return i;
// }

int pipewrite(struct pipe *pi, uint64_t addr, int n) {
  int i = 0;
  struct proc *pr = curr_proc();

  acquire_spinlock(&pi->lock);
  while (i < n) {
    if (pi->readopen == 0 || pr->killed) {
      release_spinlock(&pi->lock);
      return -1;
    }
    if (pi->nwrite == pi->nread + PIPESIZE) {
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if (copyin(pr->pagetable, &ch, addr + i, 1) == -1)
        break;
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
      i++;
    }
  }
  wakeup(&pi->nread);
  release_spinlock(&pi->lock);

  return i;
}

int piperead(struct pipe *pi, uint64_t addr, int n) {
  int i;
  struct proc *pr = curr_proc();
  char ch;

  acquire_spinlock(&pi->lock);
  while (pi->nread == pi->nwrite && pi->writeopen) {
    if (pr->killed) {
      release_spinlock(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock);
  }
  for (i = 0; i < n; i++) { 
    if (pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if (copyout(pr->pagetable, addr + i, &ch, 1) == -1)
      break;
  }

  wakeup(&pi->nwrite); 
  release_spinlock(&pi->lock);
  return i;
}

