#ifndef SYSCALL_IDS_H
#define SYSCALL_IDS_H

#define SYS_getcwd 17
#define SYS_dup 23
#define SYS_dup3 24
// #define SYS_mknod 33
#define SYS_mkdirat 34
#define SYS_unlinkat 35
#define SYS_linkat 37
// #define SYS_unlink 38
#define SYS_umount2 39
#define SYS_mount 40
#define SYS_chdir 49
#define SYS_openat 56
#define SYS_close 57
#define SYS_pipe2 59
#define SYS_getdents64 61
#define SYS_read 63
#define SYS_write 64
#define SYS_fstat 80
#define SYS_exit 93
// #define SYS_waitpid 95
#define SYS_nanosleep 101
#define SYS_sched_yield 124
// #define SYS_kill 129
// #define SYS_setpriority 140
// #define SYS_getpriority 141
#define SYS_times 153
#define SYS_uname 160
#define SYS_gettimeofday 169
// #define SYS_settimeofday 170
#define SYS_getpid 172
#define SYS_getppid 173
// #define SYS_sysinfo 179
#define SYS_brk 214
#define SYS_munmap 215
#define SYS_clone 220
#define SYS_execve 221
#define SYS_mmap 222
#define SYS_wait4 260
// #define SYS_execv 281
// #define SYS_sharedmem 282

#endif // SYSCALL_IDS_H
