
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_matrix:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a019                	j	1006 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
            }
        }
    }

    return 0;
}
    1002:	4501                	li	a0,0
    1004:	8082                	ret

0000000000001006 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1006:	1141                	addi	sp,sp,-16
    1008:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    100a:	ff9ff0ef          	jal	ra,1002 <main>
}
    100e:	60a2                	ld	ra,8(sp)
    1010:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    1012:	a831                	j	102e <exit>

0000000000001014 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1014:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1018:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    101c:	2501                	sext.w	a0,a0
    101e:	8082                	ret

0000000000001020 <exec>:
    register long a7 __asm__("a7") = n;
    1020:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1024:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1026:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    102a:	2501                	sext.w	a0,a0
    102c:	8082                	ret

000000000000102e <exit>:
    register long a7 __asm__("a7") = n;
    102e:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1032:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1036:	8082                	ret

0000000000001038 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1038:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    103c:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1040:	8082                	ret

0000000000001042 <write>:
    register long a7 __asm__("a7") = n;
    1042:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1046:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    104a:	8082                	ret

000000000000104c <getpid>:
    register long a7 __asm__("a7") = n;
    104c:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1050:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1054:	2501                	sext.w	a0,a0
    1056:	8082                	ret

0000000000001058 <getppid>:
    register long a7 __asm__("a7") = n;
    1058:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    105c:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1060:	2501                	sext.w	a0,a0
    1062:	8082                	ret

0000000000001064 <open>:
    register long a7 __asm__("a7") = n;
    1064:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1068:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    106c:	2501                	sext.w	a0,a0
    106e:	8082                	ret

0000000000001070 <mknod>:
    register long a7 __asm__("a7") = n;
    1070:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1074:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1078:	2501                	sext.w	a0,a0
    107a:	8082                	ret

000000000000107c <dup>:
    register long a7 __asm__("a7") = n;
    107c:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    107e:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1082:	2501                	sext.w	a0,a0
    1084:	8082                	ret

0000000000001086 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1086:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    108a:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    108e:	2501                	sext.w	a0,a0
    1090:	8082                	ret

0000000000001092 <waitpid>:
    register long a7 __asm__("a7") = n;
    1092:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1096:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    109a:	2501                	sext.w	a0,a0
    109c:	8082                	ret

000000000000109e <wait>:

pid_t wait(int *wstatus)
{
    109e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    10a0:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    10a4:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    10a6:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    10aa:	2501                	sext.w	a0,a0
    10ac:	8082                	ret

00000000000010ae <mkdir>:
    register long a7 __asm__("a7") = n;
    10ae:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    10b2:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    10b6:	2501                	sext.w	a0,a0
    10b8:	8082                	ret

00000000000010ba <close>:
    register long a7 __asm__("a7") = n;
    10ba:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    10be:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    10c2:	2501                	sext.w	a0,a0
    10c4:	8082                	ret

00000000000010c6 <fork>:
    register long a7 __asm__("a7") = n;
    10c6:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    10ca:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    10ce:	2501                	sext.w	a0,a0
    10d0:	8082                	ret

00000000000010d2 <time_ms>:
    register long a7 __asm__("a7") = n;
    10d2:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    10d6:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    10da:	8082                	ret

00000000000010dc <sleep>:

int sleep(unsigned long long time_in_ms)
{
    10dc:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    10de:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    10e2:	00000073          	ecall
    10e6:	87aa                	mv	a5,a0
    10e8:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    10ec:	97ba                	add	a5,a5,a4
    10ee:	00f57c63          	bgeu	a0,a5,1106 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    10f2:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    10f6:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    10fa:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    10fe:	00000073          	ecall
    1102:	fef568e3          	bltu	a0,a5,10f2 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1106:	4501                	li	a0,0
    1108:	8082                	ret

000000000000110a <pipe>:
    register long a7 __asm__("a7") = n;
    110a:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    110e:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1112:	2501                	sext.w	a0,a0
    1114:	8082                	ret

0000000000001116 <fstat>:
    register long a7 __asm__("a7") = n;
    1116:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    111a:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    111e:	2501                	sext.w	a0,a0
    1120:	8082                	ret

0000000000001122 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1122:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1124:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1128:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    112a:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    112e:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1132:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1136:	0206c163          	bltz	a3,1158 <stat+0x36>
    register long a7 __asm__("a7") = n;
    113a:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    113e:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1140:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1142:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1146:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    114a:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    114e:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1150:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1154:	853e                	mv	a0,a5
    1156:	8082                	ret
        return -1;
    1158:	57fd                	li	a5,-1
    115a:	bfed                	j	1154 <stat+0x32>

000000000000115c <chdir>:
    register long a7 __asm__("a7") = n;
    115c:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1160:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1164:	2501                	sext.w	a0,a0
    1166:	8082                	ret

0000000000001168 <link>:
    register long a7 __asm__("a7") = n;
    1168:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    116c:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1170:	2501                	sext.w	a0,a0
    1172:	8082                	ret

0000000000001174 <unlink>:
    register long a7 __asm__("a7") = n;
    1174:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1178:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    117c:	2501                	sext.w	a0,a0
    117e:	8082                	ret

0000000000001180 <setpriority>:
    register long a7 __asm__("a7") = n;
    1180:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1184:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1188:	8082                	ret

000000000000118a <getpriority>:
    register long a7 __asm__("a7") = n;
    118a:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    118e:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1192:	8082                	ret

0000000000001194 <sharedmem>:
    register long a7 __asm__("a7") = n;
    1194:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1198:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    119c:	8082                	ret
