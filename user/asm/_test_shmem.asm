
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_shmem:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a889                	j	1052 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <ucore.h>
#include <string.h>
#include <fcntl.h>

int main(int argc, char *argv[])
{
    1002:	1101                	addi	sp,sp,-32
    1004:	e426                	sd	s1,8(sp)
    1006:	ec06                	sd	ra,24(sp)
    1008:	e822                	sd	s0,16(sp)
    int pid1 = fork();
    100a:	108000ef          	jal	ra,1112 <fork>
    100e:	84aa                	mv	s1,a0
    if (pid1 == 0)
    1010:	c11d                	beqz	a0,1036 <main+0x34>
    {
        exec("test_shmem1");
    }
    int pid2 = fork();
    1012:	100000ef          	jal	ra,1112 <fork>
    1016:	842a                	mv	s0,a0
    if (pid2 == 0)
    1018:	c515                	beqz	a0,1044 <main+0x42>
    {
        exec("test_shmem2");
    }
    waitpid(pid1, NULL);
    101a:	4581                	li	a1,0
    101c:	8526                	mv	a0,s1
    101e:	0c0000ef          	jal	ra,10de <waitpid>
    waitpid(pid2, NULL);
    1022:	8522                	mv	a0,s0
    1024:	4581                	li	a1,0
    1026:	0b8000ef          	jal	ra,10de <waitpid>
    return 0;
    102a:	60e2                	ld	ra,24(sp)
    102c:	6442                	ld	s0,16(sp)
    102e:	64a2                	ld	s1,8(sp)
    1030:	4501                	li	a0,0
    1032:	6105                	addi	sp,sp,32
    1034:	8082                	ret
        exec("test_shmem1");
    1036:	00000517          	auipc	a0,0x0
    103a:	1ba50513          	addi	a0,a0,442 # 11f0 <sharedmem+0x10>
    103e:	02e000ef          	jal	ra,106c <exec>
    1042:	bfc1                	j	1012 <main+0x10>
        exec("test_shmem2");
    1044:	00000517          	auipc	a0,0x0
    1048:	1bc50513          	addi	a0,a0,444 # 1200 <sharedmem+0x20>
    104c:	020000ef          	jal	ra,106c <exec>
    1050:	b7e9                	j	101a <main+0x18>

0000000000001052 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1052:	1141                	addi	sp,sp,-16
    1054:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    1056:	fadff0ef          	jal	ra,1002 <main>
}
    105a:	60a2                	ld	ra,8(sp)
    105c:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    105e:	a831                	j	107a <exit>

0000000000001060 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1060:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1064:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1068:	2501                	sext.w	a0,a0
    106a:	8082                	ret

000000000000106c <exec>:
    register long a7 __asm__("a7") = n;
    106c:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1070:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1072:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1076:	2501                	sext.w	a0,a0
    1078:	8082                	ret

000000000000107a <exit>:
    register long a7 __asm__("a7") = n;
    107a:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    107e:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1082:	8082                	ret

0000000000001084 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1084:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1088:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    108c:	8082                	ret

000000000000108e <write>:
    register long a7 __asm__("a7") = n;
    108e:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1092:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1096:	8082                	ret

0000000000001098 <getpid>:
    register long a7 __asm__("a7") = n;
    1098:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    109c:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    10a0:	2501                	sext.w	a0,a0
    10a2:	8082                	ret

00000000000010a4 <getppid>:
    register long a7 __asm__("a7") = n;
    10a4:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    10a8:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    10ac:	2501                	sext.w	a0,a0
    10ae:	8082                	ret

00000000000010b0 <open>:
    register long a7 __asm__("a7") = n;
    10b0:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    10b4:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    10b8:	2501                	sext.w	a0,a0
    10ba:	8082                	ret

00000000000010bc <mknod>:
    register long a7 __asm__("a7") = n;
    10bc:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    10c0:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    10c4:	2501                	sext.w	a0,a0
    10c6:	8082                	ret

00000000000010c8 <dup>:
    register long a7 __asm__("a7") = n;
    10c8:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    10ca:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    10ce:	2501                	sext.w	a0,a0
    10d0:	8082                	ret

00000000000010d2 <sched_yield>:
    register long a7 __asm__("a7") = n;
    10d2:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    10d6:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    10da:	2501                	sext.w	a0,a0
    10dc:	8082                	ret

00000000000010de <waitpid>:
    register long a7 __asm__("a7") = n;
    10de:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    10e2:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    10e6:	2501                	sext.w	a0,a0
    10e8:	8082                	ret

00000000000010ea <wait>:

pid_t wait(int *wstatus)
{
    10ea:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    10ec:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    10f0:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    10f2:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    10f6:	2501                	sext.w	a0,a0
    10f8:	8082                	ret

00000000000010fa <mkdir>:
    register long a7 __asm__("a7") = n;
    10fa:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    10fe:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1102:	2501                	sext.w	a0,a0
    1104:	8082                	ret

0000000000001106 <close>:
    register long a7 __asm__("a7") = n;
    1106:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    110a:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    110e:	2501                	sext.w	a0,a0
    1110:	8082                	ret

0000000000001112 <fork>:
    register long a7 __asm__("a7") = n;
    1112:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1116:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    111a:	2501                	sext.w	a0,a0
    111c:	8082                	ret

000000000000111e <time_ms>:
    register long a7 __asm__("a7") = n;
    111e:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1122:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1126:	8082                	ret

0000000000001128 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1128:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    112a:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    112e:	00000073          	ecall
    1132:	87aa                	mv	a5,a0
    1134:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1138:	97ba                	add	a5,a5,a4
    113a:	00f57c63          	bgeu	a0,a5,1152 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    113e:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1142:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1146:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    114a:	00000073          	ecall
    114e:	fef568e3          	bltu	a0,a5,113e <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1152:	4501                	li	a0,0
    1154:	8082                	ret

0000000000001156 <pipe>:
    register long a7 __asm__("a7") = n;
    1156:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    115a:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    115e:	2501                	sext.w	a0,a0
    1160:	8082                	ret

0000000000001162 <fstat>:
    register long a7 __asm__("a7") = n;
    1162:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1166:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    116a:	2501                	sext.w	a0,a0
    116c:	8082                	ret

000000000000116e <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    116e:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1170:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1174:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1176:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    117a:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    117e:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1182:	0206c163          	bltz	a3,11a4 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1186:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    118a:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    118c:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    118e:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1192:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1196:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    119a:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    119c:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    11a0:	853e                	mv	a0,a5
    11a2:	8082                	ret
        return -1;
    11a4:	57fd                	li	a5,-1
    11a6:	bfed                	j	11a0 <stat+0x32>

00000000000011a8 <chdir>:
    register long a7 __asm__("a7") = n;
    11a8:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    11ac:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    11b0:	2501                	sext.w	a0,a0
    11b2:	8082                	ret

00000000000011b4 <link>:
    register long a7 __asm__("a7") = n;
    11b4:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    11b8:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    11bc:	2501                	sext.w	a0,a0
    11be:	8082                	ret

00000000000011c0 <unlink>:
    register long a7 __asm__("a7") = n;
    11c0:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    11c4:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    11c8:	2501                	sext.w	a0,a0
    11ca:	8082                	ret

00000000000011cc <setpriority>:
    register long a7 __asm__("a7") = n;
    11cc:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    11d0:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    11d4:	8082                	ret

00000000000011d6 <getpriority>:
    register long a7 __asm__("a7") = n;
    11d6:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    11da:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    11de:	8082                	ret

00000000000011e0 <sharedmem>:
    register long a7 __asm__("a7") = n;
    11e0:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    11e4:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    11e8:	8082                	ret
