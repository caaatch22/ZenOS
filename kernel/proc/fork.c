#include "proc/proc.h"
#include "trap/trap.h"
#include "utils/string.h"
#include "common/common.h"
#include "fs/vfs.h"
#include "fs/file.h"
/**
 * @brief fork current process
 * 
 * @return int 0 or child pid, -1 on error
 */
int clone(void* stack) {
  int i, pid;
  struct proc *np;
  struct proc *p = curr_proc();

  LOG_TRACE("clone: stage0");
  // Allocate process.
  if ((np = allocproc()) == NULL) {
    return -1;
  }

  LOG_TRACE("clone: stage1");
  // Copy user memory from parent to child.
  if (uvmcopy(p->pagetable, np->pagetable, p->total_size) < 0) {
    freeproc(np);
    release_spinlock(&np->lock);
    return -1;
  }
  np->total_size = p->total_size;
  np->heap_start = p->heap_start;
  np->heap_sz = p->heap_sz;
  np->stride = p->stride;
  // copy saved user registers.
  *(np->trapframe) = *(p->trapframe);

  // Cause fork to return 0 in the child.
  np->trapframe->a0 = 0;

  // change sp if the given stack is not NULL.
  if (stack != NULL) {
    np->trapframe->sp = (uint64_t)stack;
  }

  LOG_TRACE("clone: stage2");
  // increment reference counts on open file descriptors.
  for (i = 0; i < FD_MAX; i++)
    if (p->ofiles[i])
        np->ofiles[i] = filedup(p->ofiles[i]);
  LOG_TRACE("clone: stage3");
  np->cwd = idup(p->cwd);

  LOG_TRACE("clone: stage4");

  // dup shared mem
//   for (int i = 0; i < MAX_PROC_SHARED_MEM_INSTANCE; i++) {
//     np->shmem[i] = (p->shmem[i] == NULL) ? NULL : dup_shared_mem(p->shmem[i]);
//     np->shmem_map_start[i] = p->shmem_map_start[i];
//   }

  LOG_TRACE("clone: stage5");
  // dup mapping
//   for (int i = 0; i < MAX_MAPPING; i++) {
//     if (p->maps[i].va == NULL) {
//         break;
//     }
//     uvmmap_dup(p->pagetable, np->pagetable, p->maps[i].va, p->maps[i].npages, p->maps[i].shared);
//     np->maps[i].va = p->maps[i].va;
//     np->maps[i].npages = p->maps[i].npages;
//     np->maps[i].shared = p->maps[i].shared;
//   }

//   np->next_shmem_addr = p->next_shmem_addr;

  safestrcpy(np->name, p->name, sizeof(p->name));

  pid = np->pid;

  release_spinlock(&np->lock);

  LOG_TRACE("clone: stage6");
  acquire_spinlock(&wait_lock);
  np->parent = p;
  release_spinlock(&wait_lock);

  LOG_TRACE("clone: stage7");
  acquire_spinlock(&np->lock);
  np->state = RUNNABLE;
  release_spinlock(&np->lock);

  LOG_TRACE("clone: stage8");
  return pid;
}
