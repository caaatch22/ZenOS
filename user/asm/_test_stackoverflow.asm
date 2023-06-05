
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_stackoverflow:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a80d                	j	1032 <__start_main>

Disassembly of section .text:

0000000000001002 <smash>:
#include <ucore.h>
#include <fcntl.h>
#include <string.h>


int smash(int x){
    1002:	1141                	addi	sp,sp,-16
    1004:	e022                	sd	s0,0(sp)
    x++;
    1006:	0015041b          	addiw	s0,a0,1
    smash(x*x);
    100a:	0284053b          	mulw	a0,s0,s0
int smash(int x){
    100e:	e406                	sd	ra,8(sp)
    smash(x*x);
    1010:	ff3ff0ef          	jal	ra,1002 <smash>
    return x*2;
}
    1014:	60a2                	ld	ra,8(sp)
    1016:	0014151b          	slliw	a0,s0,0x1
    101a:	6402                	ld	s0,0(sp)
    101c:	0141                	addi	sp,sp,16
    101e:	8082                	ret

0000000000001020 <main>:


int main(int argc, char* argv[]){
    1020:	1141                	addi	sp,sp,-16
    smash(x*x);
    1022:	4511                	li	a0,4
int main(int argc, char* argv[]){
    1024:	e406                	sd	ra,8(sp)
    smash(x*x);
    1026:	fddff0ef          	jal	ra,1002 <smash>

    smash(0);
    // should be killed
    return 0;
    102a:	60a2                	ld	ra,8(sp)
    102c:	4501                	li	a0,0
    102e:	0141                	addi	sp,sp,16
    1030:	8082                	ret

0000000000001032 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1032:	1141                	addi	sp,sp,-16
    1034:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    1036:	febff0ef          	jal	ra,1020 <main>
}
    103a:	60a2                	ld	ra,8(sp)
    103c:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    103e:	a831                	j	105a <exit>

0000000000001040 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1040:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1044:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1048:	2501                	sext.w	a0,a0
    104a:	8082                	ret

000000000000104c <exec>:
    register long a7 __asm__("a7") = n;
    104c:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1050:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1052:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1056:	2501                	sext.w	a0,a0
    1058:	8082                	ret

000000000000105a <exit>:
    register long a7 __asm__("a7") = n;
    105a:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    105e:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1062:	8082                	ret

0000000000001064 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1064:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1068:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    106c:	8082                	ret

000000000000106e <write>:
    register long a7 __asm__("a7") = n;
    106e:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1072:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1076:	8082                	ret

0000000000001078 <getpid>:
    register long a7 __asm__("a7") = n;
    1078:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    107c:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1080:	2501                	sext.w	a0,a0
    1082:	8082                	ret

0000000000001084 <getppid>:
    register long a7 __asm__("a7") = n;
    1084:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1088:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    108c:	2501                	sext.w	a0,a0
    108e:	8082                	ret

0000000000001090 <open>:
    register long a7 __asm__("a7") = n;
    1090:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1094:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1098:	2501                	sext.w	a0,a0
    109a:	8082                	ret

000000000000109c <mknod>:
    register long a7 __asm__("a7") = n;
    109c:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    10a0:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    10a4:	2501                	sext.w	a0,a0
    10a6:	8082                	ret

00000000000010a8 <dup>:
    register long a7 __asm__("a7") = n;
    10a8:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    10aa:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    10ae:	2501                	sext.w	a0,a0
    10b0:	8082                	ret

00000000000010b2 <sched_yield>:
    register long a7 __asm__("a7") = n;
    10b2:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    10b6:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    10ba:	2501                	sext.w	a0,a0
    10bc:	8082                	ret

00000000000010be <waitpid>:
    register long a7 __asm__("a7") = n;
    10be:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    10c2:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    10c6:	2501                	sext.w	a0,a0
    10c8:	8082                	ret

00000000000010ca <wait>:

pid_t wait(int *wstatus)
{
    10ca:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    10cc:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    10d0:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    10d2:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    10d6:	2501                	sext.w	a0,a0
    10d8:	8082                	ret

00000000000010da <mkdir>:
    register long a7 __asm__("a7") = n;
    10da:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    10de:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    10e2:	2501                	sext.w	a0,a0
    10e4:	8082                	ret

00000000000010e6 <close>:
    register long a7 __asm__("a7") = n;
    10e6:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    10ea:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    10ee:	2501                	sext.w	a0,a0
    10f0:	8082                	ret

00000000000010f2 <fork>:
    register long a7 __asm__("a7") = n;
    10f2:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    10f6:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    10fa:	2501                	sext.w	a0,a0
    10fc:	8082                	ret

00000000000010fe <time_ms>:
    register long a7 __asm__("a7") = n;
    10fe:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1102:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1106:	8082                	ret

0000000000001108 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1108:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    110a:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    110e:	00000073          	ecall
    1112:	87aa                	mv	a5,a0
    1114:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1118:	97ba                	add	a5,a5,a4
    111a:	00f57c63          	bgeu	a0,a5,1132 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    111e:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1122:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1126:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    112a:	00000073          	ecall
    112e:	fef568e3          	bltu	a0,a5,111e <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1132:	4501                	li	a0,0
    1134:	8082                	ret

0000000000001136 <pipe>:
    register long a7 __asm__("a7") = n;
    1136:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    113a:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    113e:	2501                	sext.w	a0,a0
    1140:	8082                	ret

0000000000001142 <fstat>:
    register long a7 __asm__("a7") = n;
    1142:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1146:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    114a:	2501                	sext.w	a0,a0
    114c:	8082                	ret

000000000000114e <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    114e:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1150:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1154:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1156:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    115a:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    115e:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1162:	0206c163          	bltz	a3,1184 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1166:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    116a:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    116c:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    116e:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1172:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1176:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    117a:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    117c:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1180:	853e                	mv	a0,a5
    1182:	8082                	ret
        return -1;
    1184:	57fd                	li	a5,-1
    1186:	bfed                	j	1180 <stat+0x32>

0000000000001188 <chdir>:
    register long a7 __asm__("a7") = n;
    1188:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    118c:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1190:	2501                	sext.w	a0,a0
    1192:	8082                	ret

0000000000001194 <link>:
    register long a7 __asm__("a7") = n;
    1194:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1198:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    119c:	2501                	sext.w	a0,a0
    119e:	8082                	ret

00000000000011a0 <unlink>:
    register long a7 __asm__("a7") = n;
    11a0:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    11a4:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    11a8:	2501                	sext.w	a0,a0
    11aa:	8082                	ret

00000000000011ac <setpriority>:
    register long a7 __asm__("a7") = n;
    11ac:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    11b0:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    11b4:	8082                	ret

00000000000011b6 <getpriority>:
    register long a7 __asm__("a7") = n;
    11b6:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    11ba:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    11be:	8082                	ret

00000000000011c0 <sharedmem>:
    register long a7 __asm__("a7") = n;
    11c0:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    11c4:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    11c8:	8082                	ret
