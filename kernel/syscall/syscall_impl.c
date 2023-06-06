#include "syscall/syscall_impl.h"
#include "common/common.h"
// #include "arch/timer.h"
#include "proc/proc.h"
#include "mm/vm.h"
#include "fs/file.h"
#include "fs/fstat.h"
#include "fs/pipe.h"
#include "fs/vfs.h"
#include "proc/proc.h"

#define min(a, b) (a) < (b) ? (a) : (b);

int sys_fstat(int fd, struct kstat *statbuf_va) {
  struct proc *p = curr_proc();

  // invalid fd
  if (fd < 0 || fd >= FD_MAX) {
    LOG_INFO("invalid fd %d", fd);
    return -1;
  }

  struct file *f = p->ofiles[fd];

  // invalid fd
  if (f == NULL) {
    LOG_WARN("fd %d is not opened", fd);
    return -1;
  }

  return filestat(f, (uint64_t)statbuf_va);

}

int sys_pipe(int (*pipefd_va)[2]) {
  struct proc *p = curr_proc();
  struct file *rf, *wf;
  int fd0, fd1;
  int(*pipefd)[2];
  pipefd = (void *)va2pa(p->pagetable, (uint64_t)pipefd_va);
  if (pipefd == NULL) {
    LOG_INFO("pipefd invalid");
    return -1;
  }
  if (pipealloc(&rf, &wf) < 0) {
    return -1;
  }
  fd0 = -1;
  if ((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0) {
    if (fd0 >= 0)
      p->ofiles[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  LOG_INFO("fd0=%d, fd1=%d", fd0, fd1);

  if (copyout(p->pagetable, (uint64_t)pipefd_va, (char *)&fd0, sizeof(fd0)) < 0 ||
    copyout(p->pagetable, (uint64_t)pipefd_va + sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0) {
    p->ofiles[fd0] = 0;
    p->ofiles[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
}

int sys_exit(int code) {
  exit(code);
  return 0;
}

int sys_sched_yield() {
  yield();
  return 0;
}

pid_t sys_getpid() {
  return curr_proc()->pid;
}

pid_t sys_getppid()
{
  struct proc *p = curr_proc();
  acquire_spinlock(&wait_lock);
  struct proc *parent = p->parent;
  int ppid;
  if (parent) {
    ppid = parent->pid;
    release_spinlock(&wait_lock);
    return ppid;
  }
  release_spinlock(&wait_lock);
  return -1;
}

// pid_t sys_fork() {
//   return fork();
// }

// /**
//  * @brief Create directory at given path
//  * 
//  * @param path_va Points to the path at user space
//  * @return int64 0 if successfull, otherwise failed 
//  */
// int sys_mkdir(char *path_va) {
//   struct proc *p = curr_proc();
//   char path[MAXPATH];
//   struct inode *ip;

//   if (copyinstr(p->pagetable, path, (uint64_t)path_va, MAXPATH) != 0) {
//     return -2;
//   }
//   ip = create(path, T_DIR, 0, 0);

//   if (ip == NULL) {
//     return -1;
//   }
//   iunlockput(ip);

//   return 0;
// }

int sys_chdir(char *path_va) {
  char path[128];
  struct inode *ip;
  struct proc *p = curr_proc();
  // 128 MAXPATH 
  if (copyinstr(p->pagetable, path, (uint64_t)path_va, 128) != 0) {
    return -2;
  }
  ip = namei(path);
  if (ip == NULL) {
    return -1;
  }
  ilock(ip);
  if (ip->mode != T_DIR) {
    iunlockput(ip);
    return -1;
  }
  iunlock(ip);
  iput(p->cwd);

  p->cwd = ip;
  return 0;
}

// int sys_mknod(char *path_va, short major, short minor) {
//     struct proc *p = curr_proc();
//     struct inode *ip;
//     char path[MAXPATH];

//     if (copyinstr(p->pagetable, path, (uint64_t)path_va, MAXPATH) != 0) {
//         debugcore("can not copyinstr");
//         return -1;
//     }
//     ip = create(path, T_DEVICE, major, minor);

//     if (ip == NULL) {
//         debugcore("can not create inode");
//         return -1;
//     }

//     iunlockput(ip);

//     return 0;
// }

// int sys_execv( char *pathname_va, char * argv_va[]) {
//     struct proc *p = curr_proc();
//     char name[MAXPATH];
//     char argv_str[MAX_EXEC_ARG_COUNT][MAX_EXEC_ARG_LENGTH];
//     copyinstr(p->pagetable, name, (uint64_t)pathname_va, MAXPATH);
//     infof("sys_exec %s", name);

//     int argc = 0;
//     const char *argv[MAX_EXEC_ARG_COUNT];
//     // tracecore("argv_va=%d argc=%d", argv_va, argc);
//     if (argv_va == NULL) {
//         // nothing
//     } else {

//         while (argc < MAX_EXEC_ARG_COUNT)
//         {
//             char* argv_i;   // the argv[i]
//             if (copyin(p->pagetable, (char*)&argv_i, (uint64_t) &argv_va[argc], sizeof(char*))<0){
//                 return -1;
//             }

//             if (argv_i == NULL){
//                 // no more argv
//                 break;
//             }

//             // copy *argv[i] (the string)
//             if (copyinstr(p->pagetable,argv_str[argc], (uint64_t)argv_i, MAX_EXEC_ARG_LENGTH) < 0) {
//                 return -1;
//             }

//             argv[argc] = argv_str[argc];    // point at the copied string
//             argc++;
//         }
//     }
//     tracecore("argv_va=%d argc=%d", argv_va, argc);

//     return exec(name, argc, argv);
// }

// pid_t sys_waitpid(pid_t pid, int *wstatus_va) {
//   return wait(pid, wstatus_va);
// }

uint64_t sys_times(struct tms *tms_va) {
  // print("core %d %d  time=%p\n",cpuid(), intr_get(),(r_sie() & SIE_STIE));

  // needn't to get CPU time if the given tms address is NULL
  if (tms_va == NULL) {
    return get_tick();
  }

  struct tms tms;
  struct proc *p = curr_proc();
  acquire_spinlock(&p->lock);
  if (get_cpu_time(p, &tms) < 0) {
    release_spinlock(&p->lock);
    LOG_INFO("sys_times: get_cpu_time failed");
    return -1;
  }
  release_spinlock(&p->lock);
  if (copyout(p->pagetable, (uint64_t)tms_va, (char *)&tms, sizeof(struct tms)) < 0) {
    LOG_INFO("sys_times: copyout failed");
    return -1;
  }

  return get_tick();
}

int sys_close(int fd) {
  struct proc *p = curr_proc();

  // invalid fd
  if (fd < 0 || fd >= FD_MAX) {
    LOG_INFO("invalid fd %d", fd);
    return -1;
  }

  struct file *f = p->ofiles[fd];

  // invalid fd
  if (f == NULL) {
    LOG_INFO("fd %d is not opened", fd);
    return -1;
  }

  p->ofiles[fd] = NULL;

  fileclose(f);
  return 0;
}

// int sys_open(char *pathname_va, int flags){
//   LOG_DEBUG("sys_open");
//   struct proc *p = curr_proc();
//   char path[MAXPATH];
//   copyinstr(p->pagetable, path, (uint64_t)pathname_va, MAXPATH);
//   return fileopen(path, flags);
// }


// int64 sys_mmap(void *start, uint64_t len, int prot) {
//     if (len == 0)
//         return 0;

//     if (len > 1024 * 1024 * 1024) {
//         return -1;
//     }
//     uint64_t aligned_len = PGROUNDUP(len);

//     uint64_t offset = (uint64_t)start & 0xfff;
//     if (offset != 0) {
//         return -1;
//     }
//     if ((prot & ~0x7) != 0) {
//         return -1;
//     }
//     if ((prot & 0x7) == 0) {
//         return -1;
//     }
//     struct proc *curr_pcb = curr_proc();
//     uint64_t map_size = 0;
//     while (aligned_len > 0) {
//         void *pa = alloc_physical_page();
//         // int PER_R = prot & 1;
//         // int PER_W = prot & 2;
//         // int PER_X = prot & 4;

//         if (map1page(curr_pcb->pagetable, (uint64_t)start,
//                      (uint64_t)pa, PTE_U | (prot << 1)) < 0) {
//             debugf("sys_mmap mappages fail\n");
//             return -1;
//         }
//         aligned_len -= PGSIZE;
//         start += PGSIZE;
//         map_size += PGSIZE;
//     }

//     if (aligned_len != 0) {
//         panic("aligned_len != 0");
//     }
//     // TODO: add size to proc.size
//     debugf("map_size=%p\n", map_size);
//     return map_size;
// }

// int64 sys_munmap(void *start, uint64_t len) {
//     uint64_t va = (uint64_t)start;
//     uint64_t a;
//     pte_t *pte;
//     pagetable_t pagetable = curr_proc()->pagetable;

//     if (((uint64_t)start % PGSIZE) != 0) {
//         return -1;
//     }
//     int npages = PGROUNDUP(len) / PGSIZE;

//     for (a = va; a < va + npages * PGSIZE; a += PGSIZE) {
//         if ((pte = walk(pagetable, a, FALSE)) == 0) {
//             infof("uvmunmap: walk\n");
//             return -1;
//         }
//         if ((*pte & PTE_V) == 0) {
//             infof("uvmunmap: not mapped\n");
//             return -1;
//         }
//         if (PTE_FLAGS(*pte) == PTE_V) {
//             infof("uvmunmap: not a leaf\n");
//             return -1;
//         }

//         uint64_t pa = PTE2PA(*pte);
//         recycle_physical_page((void *)pa);

//         *pte = 0;
//     }
//     return npages * PGSIZE;
// }

ssize_t sys_read(int fd, void *dst_va, size_t len) {
  if (fd >= FD_MAX || fd < 0) {
    return -1;
  }
  struct proc *p = curr_proc();
  struct file *f = p->ofiles[fd];
  if (f == NULL) {
    return -1;
  }
  return fileread(f, (uint64_t)dst_va, len);
}

ssize_t sys_write(int fd, void *src_va, size_t len) {
  if (fd >= FD_MAX || fd < 0) {
    return -1;
  }
  struct proc *p = curr_proc();
  struct file *f = p->ofiles[fd];
  if (f == NULL) {
    return -1;
  }

  return filewrite(f, (uint64_t)src_va, len);
}

int sys_dup(int oldfd) {
  struct file *f;
  int fd;
  struct proc *p = curr_proc();
  if (p == NULL)
    PANIC("Are you kidding me?");
  if (oldfd < 0 || oldfd >= FD_MAX) {
    LOG_INFO("old fd is not valid");
    // print_proc(p);
    return -1;
  }
  f = p->ofiles[oldfd];

  if ((fd = fdalloc(f)) < 0) {
    LOG_INFO("cannot allocate new fd");
    return -1;
  }
  filedup(f);
  return fd;
}

// // Create the path new as a link to the same inode as old.
// int sys_link(char *oldpath_va, char *newpath_va) {
//   char name[DIRSIZ], new[MAXPATH], old[MAXPATH];
//   struct inode *dp, *ip;

//   struct proc *p = curr_proc();
//   if (copyinstr(p->pagetable, old, (uint64_t)oldpath_va, MAXPATH) != 0) {
//     return -1;
//   }
//   if (copyinstr(p->pagetable, new, (uint64_t)newpath_va, MAXPATH) != 0) {
//     return -1;
//   }

//   if ((ip = inode_by_name(old)) == 0) {
//     return -1;
//   }

//   ilock(ip);
//   if (ip->type == T_DIR) {
//     iunlockput(ip);
//     return -1;
//   }

//   ip->num_link++;
//   iupdate(ip);
//   iunlock(ip);

//   if ((dp = inode_parent_by_name(new, name)) == 0)
//     goto bad;
//   ilock(dp);
//   if (dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0) {
//     iunlockput(dp);
//     goto bad;
//   }
//   iunlockput(dp);
//   iput(ip);

//   return 0;

// bad:
//   ilock(ip);
//   ip->num_link--;
//   iupdate(ip);
//   iunlockput(ip);

//   return -1;
// }
