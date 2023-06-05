#ifndef PROC_H
#define PROC_H

#include "common/defs.h"
#include "mm/vm.h"
#include "lock/spinlock.h"

#define NPROC (256)
#define KSTACK_SIZE (8192)
#define USTACK_SIZE (4096)
#define TRAPFRAME_SIZE (4096)
#define FD_MAX (16)
#define PROC_NAME_MAX (16)

extern char trapforward[];
extern char boot_stack_top[];
extern char boot_stack[];

enum procstate {
  UNUSED = 0,
  USED,
  SLEEPING,
  RUNNABLE,
  RUNNING,
  ZOMBIE
};

// Per-process state
struct proc {
  spinlock_t lock;

  // PUBLIC: p->lock must be held when using these:
  enum procstate state;  // Process state
  int pid;               // Process ID
  int killed;            // If non-zero, have been killed
  pagetable_t pagetable; // User page table
  void *waiting_target;  // used by sleep and wakeup, a pointer of anything
  uint64_t exit_code;    // Exit status to be returned to parent's wait

  // proc_tree_lock must be held when using this:
  struct proc *parent; // Parent process

  // PRIVATE: these are private to the process, so p->lock need not be held.
  uint64_t ustack;             // Virtual address of user stack
  uint64_t kstack;             // Virtual address of kernel stack
  struct trapframe *trapframe; // data page for trampoline.S, physical address
  struct context context;      // swtch() here to run process
  uint64_t total_size;         // total memory used by this process
  uint64_t heap_sz;
  uint64_t stride;
  uint64_t priority;
//   uint64_t cpu_time;          // ms, user and kernel
//   uint64_t last_start_time;   // ms
  struct file *files[FD_MAX]; // Opened files
  struct inode *cwd;          // Current directory
  struct inode *elf;          //self-file
  //   struct shared_mem *shmem[MAX_PROC_SHARED_MEM_INSTANCE];
  //   void *shmem_map_start[MAX_PROC_SHARED_MEM_INSTANCE];
  //   void *next_shmem_addr;
  char name[PROC_NAME_MAX]; // Process name (debugging)
};

struct proc *findproc(int pid);

struct proc *curr_proc();
void procinit(void);
// int spawn(char *filename);
extern struct proc pool[NPROC];
extern struct spinlock pool_lock;
extern struct spinlock wait_lock;
// extern struct spinlock proc_tree_lock;

void sleep(void *waiting_target, struct spinlock *lk);
void wakeup(void *waiting_target);

void switch_to_scheduler(void);

void print_proc(struct proc *proc);
void forkret(void);

void proc_free_mem_and_pagetable(struct proc* p);
struct proc *allocproc(void);
struct file *get_proc_file_by_fd(struct proc *p, int fd);
pagetable_t proc_pagetable(struct proc *p);
void freeproc(struct proc *p);

#endif // PROC_H
