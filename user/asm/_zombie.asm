
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_zombie:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a00d                	j	1022 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <string.h>
#include <ucore.h>

int
main(void)
{
    1002:	1141                	addi	sp,sp,-16
    1004:	e406                	sd	ra,8(sp)
  if(fork() > 0)
    1006:	0dc000ef          	jal	ra,10e2 <fork>
    100a:	00a05563          	blez	a0,1014 <main+0x12>
    sleep(5);  // Let child exit before parent.
    100e:	4515                	li	a0,5
    1010:	0e8000ef          	jal	ra,10f8 <sleep>
  exit(0);
    1014:	4501                	li	a0,0
    1016:	034000ef          	jal	ra,104a <exit>
}
    101a:	60a2                	ld	ra,8(sp)
    101c:	4501                	li	a0,0
    101e:	0141                	addi	sp,sp,16
    1020:	8082                	ret

0000000000001022 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1022:	1141                	addi	sp,sp,-16
    1024:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    1026:	fddff0ef          	jal	ra,1002 <main>
}
    102a:	60a2                	ld	ra,8(sp)
    102c:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    102e:	a831                	j	104a <exit>

0000000000001030 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1030:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1034:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1038:	2501                	sext.w	a0,a0
    103a:	8082                	ret

000000000000103c <exec>:
    register long a7 __asm__("a7") = n;
    103c:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1040:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1042:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1046:	2501                	sext.w	a0,a0
    1048:	8082                	ret

000000000000104a <exit>:
    register long a7 __asm__("a7") = n;
    104a:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    104e:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1052:	8082                	ret

0000000000001054 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1054:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1058:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    105c:	8082                	ret

000000000000105e <write>:
    register long a7 __asm__("a7") = n;
    105e:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1062:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1066:	8082                	ret

0000000000001068 <getpid>:
    register long a7 __asm__("a7") = n;
    1068:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    106c:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1070:	2501                	sext.w	a0,a0
    1072:	8082                	ret

0000000000001074 <getppid>:
    register long a7 __asm__("a7") = n;
    1074:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1078:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    107c:	2501                	sext.w	a0,a0
    107e:	8082                	ret

0000000000001080 <open>:
    register long a7 __asm__("a7") = n;
    1080:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1084:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1088:	2501                	sext.w	a0,a0
    108a:	8082                	ret

000000000000108c <mknod>:
    register long a7 __asm__("a7") = n;
    108c:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1090:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1094:	2501                	sext.w	a0,a0
    1096:	8082                	ret

0000000000001098 <dup>:
    register long a7 __asm__("a7") = n;
    1098:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    109a:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    109e:	2501                	sext.w	a0,a0
    10a0:	8082                	ret

00000000000010a2 <sched_yield>:
    register long a7 __asm__("a7") = n;
    10a2:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    10a6:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    10aa:	2501                	sext.w	a0,a0
    10ac:	8082                	ret

00000000000010ae <waitpid>:
    register long a7 __asm__("a7") = n;
    10ae:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    10b2:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    10b6:	2501                	sext.w	a0,a0
    10b8:	8082                	ret

00000000000010ba <wait>:

pid_t wait(int *wstatus)
{
    10ba:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    10bc:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    10c0:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    10c2:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    10c6:	2501                	sext.w	a0,a0
    10c8:	8082                	ret

00000000000010ca <mkdir>:
    register long a7 __asm__("a7") = n;
    10ca:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    10ce:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    10d2:	2501                	sext.w	a0,a0
    10d4:	8082                	ret

00000000000010d6 <close>:
    register long a7 __asm__("a7") = n;
    10d6:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    10da:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    10de:	2501                	sext.w	a0,a0
    10e0:	8082                	ret

00000000000010e2 <fork>:
    register long a7 __asm__("a7") = n;
    10e2:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    10e6:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    10ea:	2501                	sext.w	a0,a0
    10ec:	8082                	ret

00000000000010ee <time_ms>:
    register long a7 __asm__("a7") = n;
    10ee:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    10f2:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    10f6:	8082                	ret

00000000000010f8 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    10f8:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    10fa:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    10fe:	00000073          	ecall
    1102:	87aa                	mv	a5,a0
    1104:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1108:	97ba                	add	a5,a5,a4
    110a:	00f57c63          	bgeu	a0,a5,1122 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    110e:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1112:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1116:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    111a:	00000073          	ecall
    111e:	fef568e3          	bltu	a0,a5,110e <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1122:	4501                	li	a0,0
    1124:	8082                	ret

0000000000001126 <pipe>:
    register long a7 __asm__("a7") = n;
    1126:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    112a:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    112e:	2501                	sext.w	a0,a0
    1130:	8082                	ret

0000000000001132 <fstat>:
    register long a7 __asm__("a7") = n;
    1132:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1136:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    113a:	2501                	sext.w	a0,a0
    113c:	8082                	ret

000000000000113e <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    113e:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1140:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1144:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1146:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    114a:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    114e:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1152:	0206c163          	bltz	a3,1174 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1156:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    115a:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    115c:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    115e:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1162:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1166:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    116a:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    116c:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1170:	853e                	mv	a0,a5
    1172:	8082                	ret
        return -1;
    1174:	57fd                	li	a5,-1
    1176:	bfed                	j	1170 <stat+0x32>

0000000000001178 <chdir>:
    register long a7 __asm__("a7") = n;
    1178:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    117c:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1180:	2501                	sext.w	a0,a0
    1182:	8082                	ret

0000000000001184 <link>:
    register long a7 __asm__("a7") = n;
    1184:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1188:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    118c:	2501                	sext.w	a0,a0
    118e:	8082                	ret

0000000000001190 <unlink>:
    register long a7 __asm__("a7") = n;
    1190:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1194:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1198:	2501                	sext.w	a0,a0
    119a:	8082                	ret

000000000000119c <setpriority>:
    register long a7 __asm__("a7") = n;
    119c:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    11a0:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    11a4:	8082                	ret

00000000000011a6 <getpriority>:
    register long a7 __asm__("a7") = n;
    11a6:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    11aa:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    11ae:	8082                	ret

00000000000011b0 <sharedmem>:
    register long a7 __asm__("a7") = n;
    11b0:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    11b4:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    11b8:	8082                	ret
