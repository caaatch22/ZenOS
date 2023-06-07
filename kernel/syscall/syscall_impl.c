#include "syscall/syscall_impl.h"
#include "common/common.h"
#include "arch/timer.h"
#include "proc/proc.h"
#include "mm/vm.h"
#include "fs/file.h"
#include "fs/fstat.h"
#include "fs/pipe.h"
#include "fs/vfs.h"
#include "proc/proc.h"
#include "fs/fcntl.h"
#include "utils/string.h"

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

int sys_uname(struct utsname *utsname_va) {
  struct utsname utsname;
  struct proc *p = curr_proc();
  strcpy(utsname.sysname, "ZenOS");
  strcpy(utsname.nodename, "ZenOS");
  strcpy(utsname.release, "1.0");
  strcpy(utsname.version, "1.0");
  strcpy(utsname.machine, "riscv64");
  strcpy(utsname.domainname, "Metaverse");

  if (copyout(p->pagetable, (uint64_t)utsname_va, (char *)&utsname, sizeof(utsname)) != 0)
  {
    LOG_INFO("sys_uname: copyout failed");
    return -1;
  }
  return 0;
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

int sys_getdents(int fd, struct dirent *dirp64, unsigned long len) {
  
  struct file *f;
  struct proc *p = curr_proc();
  f = p->ofiles[fd];
  if (f == NULL) {
    LOG_INFO("sys_getdents: fd=%d is not valid", fd);
    // print_proc(p);
    return -1;
  }
  return filereaddir(f, dirp64, len);
}

int sys_brk(void *addr) {
  struct proc *p = curr_proc();
  uint64_t newbrk = (uint64_t)addr;
  if (newbrk == 0) {
    // printf("sys_brk want: %p    brk:%p\n", newbrk, p->program_break);
    return p->program_break;
  } else {
    // printf("sys_brk want: %p    brk:%p\n", newbrk, p->program_break);
  }

  if(growproc(newbrk) < 0){
    print("in sys_brk, growproc failed\n");
    return p->program_break;
  }
  
  // printf("brk return: %p\n", newbrk);
  return newbrk;
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
//   char path[MAX_NAME_SIZE];
//   struct inode *ip;

//   if (copyinstr(p->pagetable, path, (uint64_t)path_va, MAX_NAME_SIZE) != 0) {
//     return -2;
//   }
//   ip = create(path, T_DIR, 0, 0);

//   if (ip == NULL) {
//     return -1;
//   }
//   iunlockput(ip);

//   return 0;
// }

int sys_getcwd(char *ubuf, size_t size) {

  char buf[128];

  int max = 128 < size ? 128 : size;
  if ((size = namepath(curr_proc()->cwd, buf, max)) < 0)
    return -1;

  if (copyout2((uint64_t)ubuf, buf, max) < 0)
    return -1;

  return size;
}

int sys_chdir(char *path_va) {
  char path[128];
  struct inode *ip;
  struct proc *p = curr_proc();
  // 128 MAX_NAME_SIZE 
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
//     char path[MAX_NAME_SIZE];

//     if (copyinstr(p->pagetable, path, (uint64_t)path_va, MAX_NAME_SIZE) != 0) {
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
//     char name[MAX_NAME_SIZE];
//     char argv_str[MAX_EXEC_ARG_COUNT][MAX_EXEC_ARG_LENGTH];
//     copyinstr(p->pagetable, name, (uint64_t)pathname_va, MAX_NAME_SIZE);
//     LOG_INFO("sys_exec %s", name);

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

// only WNOHANG is supported, WUNTRACED, WCONTINUED are not supported
// and rusage is not supported
pid_t sys_wait4(pid_t pid, int *status, int options) {
  if (options & ~WNOHANG) {
    LOG_ERROR("sys_wait4: options=%d not support", options);
    return -1;
  }
  return wait(pid, status, options);
}

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

int sys_gettimeofday(struct timeval *tv_va, struct timezone *tz_va) {
  if (tv_va == NULL && tz_va == NULL) {
    LOG_INFO("sys_gettimeofday: tv_va and tz_va are both NULL");
    return -1;
  }

  struct timeval tv;
  struct timezone tz;

  uint64_t timeus = get_time_us();
  tv.tv_sec = timeus / USEC_PER_SEC;
  tv.tv_usec = timeus % USEC_PER_SEC;
  memset(&tz, 0, sizeof(tz));

  struct proc *p = curr_proc();
  if (tv_va && copyout(p->pagetable, (uint64_t)tv_va, (char *)&tv, sizeof(struct timeval)) != 0) {
    LOG_INFO("sys_gettimeofday: copyout failed");
    return -1;
  }
  if (tz_va && copyout(p->pagetable, (uint64_t)tz_va, (char*)&tz, sizeof(struct timezone)) != 0) {
    LOG_INFO("sys_gettimeofday: copyout failed");
    return -1;
  }
  return 0;
}

int sys_nanosleep(struct timeval *req_va, struct timeval *rem_va) {
  if (req_va == NULL) {
    LOG_INFO("sys_nanosleep: req_va is NULL");
      return -1;
  }
  struct timeval req;
  struct timeval rem;
  struct proc *p = curr_proc();
  if (copyin(p->pagetable, (char *)&req, (uint64_t)req_va, sizeof(struct timeval)) != 0) {
    LOG_INFO("sys_nanosleep: copyin failed");
    return -1;
  }

  uint64_t timeus = get_time_us();
  uint64_t expires = req.tv_sec * USEC_PER_SEC + req.tv_usec;

    // already expired
  if (timeus + expires > get_time_us()) {
    return 0;
  }

  struct timer *timer = add_timer(expires);
  if (timer == NULL) {
    LOG_INFO("sys_nanosleep: timer is full, cannot add timer");
    goto err_rem;
  }
    // guard lock is acquired by add_timer
  sleep(timer, &timer->guard_lock);

  release_spinlock(&timer->guard_lock);
  del_timer(timer);

  uint64_t duration = get_time_us() - timeus;
  uint64_t remain = 0;
  if (duration < expires) {
    remain = expires - duration;
    goto err_rem;
  }
  return 0;


err_rem:
  if (rem_va) {
    rem.tv_sec = remain / USEC_PER_SEC;
    rem.tv_usec = remain % USEC_PER_SEC;
    if (copyout(p->pagetable, (uint64_t)rem_va, (char*)&rem, sizeof(struct timeval)) != 0) {
      LOG_INFO("sys_nanosleep: copyout failed");
      return -1;
    }
  }
  return -1;
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

int sys_open(char *pathname_va, int flags){
  LOG_DEBUG("sys_open");
  struct proc *p = curr_proc();
  char path[MAX_NAME_SIZE];
  copyinstr(p->pagetable, path, (uint64_t)pathname_va, MAX_NAME_SIZE);
  return fileopen(path, flags);
}

int sys_openat(int fd, char *filename, int flags, int mode) {
  // dont support mode now
  LOG_DEBUG("sys_openat");
  struct proc *p = curr_proc();
  char path[MAX_NAME_SIZE];
  copyinstr(p->pagetable, path, (uint64_t)filename, MAX_NAME_SIZE);
  return fileopenat(fd, path, flags, mode);
}

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
//             LOG_INFO("uvmunmap: walk\n");
//             return -1;
//         }
//         if ((*pte & PTE_V) == 0) {
//             LOG_INFO("uvmunmap: not mapped\n");
//             return -1;
//         }
//         if (PTE_FLAGS(*pte) == PTE_V) {
//             LOG_INFO("uvmunmap: not a leaf\n");
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

int sys_dup3(int oldfd, int newfd, int flags) {
  if (flags != 0) {
    LOG_INFO("sys_dup3: flags must be 0");
    return -1;
  }

  struct file *f;
  int fd;
  struct proc *p = curr_proc();
  f = p->ofiles[oldfd];

  if (f == NULL) {
    LOG_INFO("old fd is not valid");
    // print_proc(p);
    return -1;
  }

  if (newfd == oldfd) {
    // do nothing
    // ref: https://linux.die.net/man/2/dup3
    return newfd;
  }

  // try close new fd
  sys_close(newfd);

  if ((fd = fdalloc2(f, newfd)) < 0) {
    LOG_INFO("cannot allocate new fd");
    return -1;
  }
  filedup(f);
  return fd;
}

int sys_linkat(int olddirfd, char *oldpath, int newdirfd, char *newpath, int flags) {
  LOG_DEBUG("sys_linkat");
  if (flags != 0) {
    LOG_INFO("sys_linkat: flags=%d not support", flags);
    return -1;
  }
  struct proc *p = curr_proc();
  char old[MAX_NAME_SIZE];
  char new[MAX_NAME_SIZE];
  copyinstr(p->pagetable, old, (uint64_t)oldpath, MAX_NAME_SIZE);
  copyinstr(p->pagetable, new, (uint64_t)newpath, MAX_NAME_SIZE);

  int oldfd = -1, newfd = -1, ret;
  oldfd = fileopenat(olddirfd, old, O_RDONLY, 0);
  if (oldfd < 0) {
    LOG_INFO("sys_linkat: open old %s failed", old);
    ret = -1;
    goto end;
  }
  newfd = fileopenat(newdirfd, new, O_WRONLY | O_CREAT, 0);
  if (newfd < 0) {
    LOG_INFO("sys_linkat: open new %s failed", new);
    ret = -1;
    goto end;
  }

  struct file *file_old = p->ofiles[oldfd];
  struct file *file_new = p->ofiles[newfd];

  ASSERT(file_old != NULL && file_new != NULL, "sys_linkat: file is NULL, data is corrupted");

  ret = filelink(file_old, file_new);

end:
  if (oldfd >= 0) {
    sys_close(oldfd);
  }
  if (newfd >= 0) {
    sys_close(newfd);
  }
  return ret;
}

// useless flags, only deal with fd is a file 
int sys_unlinkat(int dirfd, char *pathname, int flags) {
  LOG_DEBUG("sys_unlinkat");

  struct proc *p = curr_proc();
  char path[MAX_NAME_SIZE];
  copyinstr(p->pagetable, path, (uint64_t)pathname, MAX_NAME_SIZE);

  int fd = fileopenat(dirfd, path, O_RDONLY, 0);
  if (fd < 0) {
    LOG_INFO("sys_unlinkat: open %s failed", path);
    return -1;
  }
  struct file* f = p->ofiles[fd];
  ASSERT(f != NULL, "sys_unlinkat: file is NULL, data is corrupted");
  struct inode *ip = f->ip;
  ilock(ip);
  int ret = unlink(ip);
  iunlockput(ip);

  sys_close(fd);
  return ret;
}

// mode is ignored
int sys_mkdirat(int dirfd, char *path_va, int mode)
{
  char path[MAX_NAME_SIZE];
  copyinstr(curr_proc()->pagetable, path, (uint64_t)path_va, MAX_NAME_SIZE);

  struct file *f = curr_proc()->ofiles[dirfd];

  struct inode *dp = NULL, *ip;

	if ((ip = create(path, T_DIR, dp)) == NULL) {
		return -1;
	}
	iunlockput(ip);
	return 0;
}

// only support SIGCHLD, and other params are ignored.
pid_t sys_clone(unsigned long flags, void *child_stack, void *ptid, void *tls, void *ctid) {
//    if (flags != SIGCHLD) {
//        LOG_INFO("clone: flags must be SIGCHLD");
//        return -1;
//    }
  return clone(child_stack);
}



#define MAX_EXEC_ARG_COUNT 16
#define MAX_EXEC_ARG_LENGTH 128

static int arg_copy(struct proc* p, char *arg_va[], char *arg[], char arg_str[][MAX_EXEC_ARG_LENGTH]) {
  int argc = 0;

  while (argc < MAX_EXEC_ARG_COUNT) {
    char *arg_i; // the argv[i]
    if (copyin(p->pagetable, (char *)&arg_i, (uint64_t)&arg_va[argc], sizeof(char *)) < 0) {
      break;
    }

    if (arg_i == NULL) {
      // no more arg
      break;
    }

    // copy *arg[i] (the string)
    if (copyinstr(p->pagetable, arg_str[argc], (uint64_t)arg_i, MAX_EXEC_ARG_LENGTH) < 0)
    {
      break;
    }

    arg[argc] = arg_str[argc]; // point at the copied string
    argc++;
  }
  return argc;
}

int sys_exec(char *path, char** argv)
{
  return sys_execve(path, argv, 0);
}

int sys_execve( char *pathname_va, char * argv_va[], char * envp_va[]) {
  struct proc *p = curr_proc();
  char name[MAX_NAME_SIZE];
  char argv_str[MAX_EXEC_ARG_COUNT][MAX_EXEC_ARG_LENGTH];
  char envp_str[MAX_EXEC_ARG_COUNT][MAX_EXEC_ARG_LENGTH];
  copyinstr(p->pagetable, name, (uint64_t)pathname_va, MAX_NAME_SIZE);
  LOG_INFO("sys_exec %s", name);

  int argc, envc;
  const char *argv[MAX_EXEC_ARG_COUNT];
  const char *envp[MAX_EXEC_ARG_COUNT];
  // tracecore("argv_va=%d argc=%d", argv_va, argc);
  argc = argv_va == NULL ? 0 : arg_copy(p, argv_va, argv, argv_str);
  envc = envp_va == NULL ? 0 : arg_copy(p, envp_va, envp, envp_str);

  LOG_TRACE("argv_va=%d argc=%d", argv_va, argc);
  LOG_TRACE("envp_va=%d envc=%d", envp_va, envc);
  return execve(name, argv, envp);
}

// // Create the path new as a link to the same inode as old.
// int sys_link(char *oldpath_va, char *newpath_va) {
//   char name[DIRSIZ], new[MAX_NAME_SIZE], old[MAX_NAME_SIZE];
//   struct inode *dp, *ip;

//   struct proc *p = curr_proc();
//   if (copyinstr(p->pagetable, old, (uint64_t)oldpath_va, MAX_NAME_SIZE) != 0) {
//     return -1;
//   }
//   if (copyinstr(p->pagetable, new, (uint64_t)newpath_va, MAX_NAME_SIZE) != 0) {
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
