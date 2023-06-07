#include "syscall/syscall_ids.h"
#include "syscall/syscall_impl.h"
#include "arch/riscv.h"
#include "arch/timer.h"
#include "proc/proc.h"
#include "trap/trap.h"
#include "common/common.h"
#include "fs/fstat.h"


// for debug
char *syscall_names(int id)
{
  switch (id) {
  case SYS_exec:
    return "SYS_exec";
  case SYS_getcwd:
    return "SYS_getcwd";
  case SYS_dup:
    return "SYS_dup";
  case SYS_dup3:
    return "SYS_dup3";
//   case SYS_mknod:
//     return "SYS_mknod";
  case SYS_mkdirat:
    return "SYS_mkdirat";
  case SYS_unlinkat:
    return "SYS_unlinkat";
  case SYS_linkat:
    return "SYS_linkat";
//   case SYS_link:
//     return "SYS_link";
//   case SYS_unlink:
//     return "SYS_unlink";
  case SYS_umount2:
    return "umount2";
  case SYS_mount:
    return "SYS_mount";
  case SYS_chdir:
    return "SYS_chdir";
  case SYS_openat:
    return "SYS_openat";
  case SYS_close:
    return "SYS_close";
  case SYS_pipe2:
    return "SYS_pipe2";
  case SYS_read:
    return "SYS_read";
  case SYS_write:
    return "SYS_write";
  case SYS_fstat:
    return "SYS_fstat";
  case SYS_exit:
    return "SYS_exit";
  case SYS_nanosleep:
    return "SYS_nanosleep";
  case SYS_sched_yield:
    return "SYS_sched_yield";
  case SYS_times:
    return "SYS_times";
  case SYS_uname:
    return "SYS_uname";
  case SYS_gettimeofday:
    return "SYS_gettimeofday";
//   case SYS_waitpid:
//     return "SYS_waitpid";
//   case SYS_kill:
//     return "SYS_kill";
//   case SYS_setpriority:
//     return "SYS_setpriority";
//   case SYS_getpriority:
//     return "SYS_getpriority";
  case SYS_getdents64:
    return "SYS_getdents64";
  case SYS_getpid:
    return "SYS_getpid";
  case SYS_getppid:
    return "SYS_getppid";
  case SYS_brk:
    return "SYS_brk";
  case SYS_munmap:
    return "SYS_munmap";
//   case SYS_fork:
//     return "SYS_fork";
  case SYS_clone:
    return "SYS_clone";
  case SYS_execve:
    return "SYS_execve";
  case SYS_mmap:
    return "SYS_mmap";
  case SYS_wait4:
    return "SYS_wait4";
#define SYS_wait4 260
  default:
    return "?";
  }
}

// dispatch syscalls to different functions
void syscall()
{
  struct proc *p = curr_proc();
  struct trapframe *trapframe = p->trapframe;
  uint64_t id = trapframe->a7;
  uint64_t ret;
  uint64_t args[7] = {trapframe->a0, trapframe->a1, trapframe->a2, trapframe->a3, trapframe->a4, trapframe->a5, trapframe->a6};

  // ignore read and write so that shell command don't get interrupted
  if (id != SYS_write && id != SYS_read) {
    char *name = syscall_names(id);
    (void)name;
    LOG_TRACE("syscall %d (%s) args:%p %p %p %p %p %p %p", (int)id, name, args[0], args[1], args[2], args[3], args[4], args[5], args[6]);
  }
  switch (id) {
  case SYS_getcwd:
    ret = (uint64_t)sys_getcwd((char *)args[0], args[1]);
    break;
  case SYS_write:
    ret = sys_write(args[0], (void *)args[1], args[2]);
    break;
  case SYS_read:
    ret = sys_read(args[0], (void *)args[1], args[2]);
    break;
  case SYS_open:
    ret = sys_open((char *)args[0], args[1]);
    break;
  case SYS_openat:
    ret = sys_openat(args[0], (char *)args[1], args[2], args[3]);
    break;
  case SYS_close:
    ret = sys_close(args[0]);
    break;
  case SYS_exit:
    ret = sys_exit(args[0]);
    break;
  case SYS_sched_yield:
    ret = sys_sched_yield();
    break;
//   case SYS_setpriority:
//     ret = sys_setpriority(args[0]);
//     break;
//   case SYS_getpriority:
//     ret = sys_getpriority(args[0]);
//     break;
  case SYS_getdents64:
    ret = sys_getdents((int)args[0], (struct dirent *)args[1], args[2]);
    break;
  case SYS_brk:
    ret = sys_brk((void *)args[0]);
    break;
  case SYS_getpid:
    ret = sys_getpid();
    break;
  case SYS_getppid:
    ret = sys_getppid();
    break;
  case SYS_dup:
    ret = sys_dup((int)args[0]);
    break;
  case SYS_dup3:
    ret = sys_dup3((int)args[0], (int)args[1], (int)args[2]);
    break;
  case SYS_clone:
    ret = sys_clone(args[0], (void *)args[1], (void *)args[2], (void *)args[3], (void *)args[4]);
    break;
  case SYS_exec:
    ret = sys_exec((char *)args[0], (char **)args[1]);
    break;
  case SYS_execve:
    ret = sys_execve((char *)args[0], (char **)args[1], (char **)args[2]);
    break;
  // case SYS_waitpid:
  //   ret = sys_waitpid(args[0], (int *)args[1]);
  //   break;
  case SYS_uname:
    ret = sys_uname((struct utsname *)args[0]);
    break;
  case SYS_gettimeofday:
    ret = sys_gettimeofday((struct timeval *)args[0], (struct timezone *)args[1]);
    break;
  case SYS_times:
    ret = sys_times((struct tms *)args[0]);
    break;
  case SYS_nanosleep:
    ret = sys_nanosleep((struct timeval *)args[0], (struct timeval *)args[1]);
    break;
    //   case SYS_mknod:
    //     ret = sys_mknod((char *)args[0], args[1], args[2]);
    //     break;
  case SYS_pipe2:
    ret = sys_pipe((int(*)[2])args[0]);
    break;
  case SYS_fstat:
    ret = sys_fstat((int)args[0], (void *)args[1]);
    break;
  case SYS_chdir:
    ret = sys_chdir((char *)args[0]);
    break;
  case SYS_mkdirat:
    ret = sys_mkdirat(args[0], (char *)args[1], args[2]);
    break;
  case SYS_linkat:
    ret = sys_linkat(args[0], (char *)args[1], args[2], (char *)args[3], args[4]);
    break;
  case SYS_unlinkat:
    ret = sys_unlinkat(args[0], (char *)args[1], args[2]);
    break;
//   case SYS_sharedmem:
//     ret = (uint64_t)sys_sharedmem((char *)args[0], args[1]);
//     break;
  default:
    ret = -1;
    LOG_WARN("unknown syscall %d", (int)id);
  }
  if(id != SYS_execve)
    trapframe->a0 = ret; // return value

  if (id != SYS_write && id != SYS_read) {
    LOG_TRACE("syscall %d ret %l", (int)id, ret);
  }
}