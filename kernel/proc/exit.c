#include "proc/proc.h"
#include "common/common.h"
#include "fs/file.h"
#include "fs/vfs.h"

static void close_proc_files(struct proc *p)
{
  for (int i = 0; i < FD_MAX; ++i) {
    if (p->ofiles[i] != NULL) {
      fileclose(p->ofiles[i]);
      p->ofiles[i] = NULL;
    }
  }
}

// make p->parent = NULL
// if p is zombie, free the struct but the memory or files
// because they should be freed before p became a zombie
void reparent(struct proc *p)
{
  LOG_TRACE("reparent");
  ASSERT(holding(&wait_lock), "reparent lock");

  if (p->state == ZOMBIE) {
    freeproc(p);
  } else {
    p->parent = NULL;
  }
}

/**
 * Exit current running process
 * will do:
 * 1. close files and dir
 * 2. reparent this process's children
 * 3. free all the memory and pagetables
 * 4. set the state to ZOMBIE if parent is alive 
 *    or just free this proc struct if parent is dead
 */
void exit(int code)
{
  LOG_TRACE("exit");
  struct proc *p = curr_proc();
  int pid_tmp = p->pid; // keep for infof
  // (void)pid_tmp;
  acquire_spinlock(&p->lock);
  p->exit_code = code;

  // 1. close files
  close_proc_files(p);

  iput(p->cwd);
  p->cwd = NULL;
  release_spinlock(&p->lock);

  // 2. reparent this process's children
  acquire_spinlock(&wait_lock);
  struct proc *child;
  for (child = pool; child < &pool[NPROC]; child++) {
    if (child != p) { // avoid deadlock
        // print_proc(child);
      if (child->state != UNUSED && child->parent == p) {
          // found a child
          acquire_spinlock(&child->lock);
          reparent(child);
          release_spinlock(&child->lock);
      }
    }
  }
  release_spinlock(&wait_lock);

  // 3. free all the memory and pagetables
  ASSERT(p->trapframe != NULL, "???");
  ASSERT(p->pagetable != NULL, "????");

  proc_free_mem_and_pagetable(p);

  // 4. set the state
  acquire_spinlock(&wait_lock);
  acquire_spinlock(&p->lock);
  if (p->parent != NULL) {
    p->state = ZOMBIE;
    wakeup(p->parent);
  } else {
    // parent is dead
    freeproc(p);
  }
  release_spinlock(&wait_lock);

  LOG_INFO("proc %d exit with %d\n", pid_tmp, code);
  switch_to_scheduler();
}
