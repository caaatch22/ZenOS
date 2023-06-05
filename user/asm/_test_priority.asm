
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_priority:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a8a1                	j	1058 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <stdlib.h>
#include <ucore.h>
#include <string.h>

int main(int argc, char *argv[])
{
    1002:	1141                	addi	sp,sp,-16
    long long p;

    p = setpriority(100);
    1004:	06400513          	li	a0,100
{
    1008:	e406                	sd	ra,8(sp)
    p = setpriority(100);
    100a:	210000ef          	jal	ra,121a <setpriority>
    assert(p == 100, -1);
    100e:	f9c50513          	addi	a0,a0,-100
    1012:	55fd                	li	a1,-1
    1014:	00153513          	seqz	a0,a0
    1018:	08e000ef          	jal	ra,10a6 <assert>

    p = setpriority(20);
    101c:	4551                	li	a0,20
    101e:	1fc000ef          	jal	ra,121a <setpriority>
    assert(p == 20, -2);
    1022:	1531                	addi	a0,a0,-20
    1024:	55f9                	li	a1,-2
    1026:	00153513          	seqz	a0,a0
    102a:	07c000ef          	jal	ra,10a6 <assert>

    p = setpriority(-5);
    102e:	556d                	li	a0,-5
    1030:	1ea000ef          	jal	ra,121a <setpriority>
    assert(p == -1, -3);
    1034:	0505                	addi	a0,a0,1
    1036:	55f5                	li	a1,-3
    1038:	00153513          	seqz	a0,a0
    103c:	06a000ef          	jal	ra,10a6 <assert>

    p = getpriority();
    1040:	1e4000ef          	jal	ra,1224 <getpriority>
    assert(p == 20, -4);
    1044:	1531                	addi	a0,a0,-20
    1046:	00153513          	seqz	a0,a0
    104a:	55f1                	li	a1,-4
    104c:	05a000ef          	jal	ra,10a6 <assert>

    return 0;
    1050:	60a2                	ld	ra,8(sp)
    1052:	4501                	li	a0,0
    1054:	0141                	addi	sp,sp,16
    1056:	8082                	ret

0000000000001058 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1058:	1141                	addi	sp,sp,-16
    105a:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    105c:	fa7ff0ef          	jal	ra,1002 <main>
}
    1060:	60a2                	ld	ra,8(sp)
    1062:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    1064:	a095                	j	10c8 <exit>

0000000000001066 <srand>:
#include <ucore.h>

static uint64 seed;

void srand(unsigned s) {
    seed = s - 1;
    1066:	357d                	addiw	a0,a0,-1
    1068:	1502                	slli	a0,a0,0x20
    106a:	9101                	srli	a0,a0,0x20
    106c:	00001797          	auipc	a5,0x1
    1070:	d4a7be23          	sd	a0,-676(a5) # 1dc8 <seed>
}
    1074:	8082                	ret

0000000000001076 <rand>:

int rand(void) {
    seed = 6364136223846793005ULL * seed + 1;
    1076:	00001797          	auipc	a5,0x1
    107a:	d5278793          	addi	a5,a5,-686 # 1dc8 <seed>
    107e:	6388                	ld	a0,0(a5)
    1080:	00001717          	auipc	a4,0x1
    1084:	d2073703          	ld	a4,-736(a4) # 1da0 <memmove+0x10c>
    1088:	02e50533          	mul	a0,a0,a4
    108c:	0505                	addi	a0,a0,1
    108e:	e388                	sd	a0,0(a5)
    return seed >> 33;
}
    1090:	9105                	srli	a0,a0,0x21
    1092:	8082                	ret

0000000000001094 <panic>:

void panic(char* m) {
    1094:	1141                	addi	sp,sp,-16
    1096:	e406                	sd	ra,8(sp)
    puts(m);
    1098:	1e0000ef          	jal	ra,1278 <puts>
    exit(-100);
}
    109c:	60a2                	ld	ra,8(sp)
    exit(-100);
    109e:	f9c00513          	li	a0,-100
}
    10a2:	0141                	addi	sp,sp,16
    exit(-100);
    10a4:	a015                	j	10c8 <exit>

00000000000010a6 <assert>:

void assert(int f, int code) {
    if(!f) {
    10a6:	c111                	beqz	a0,10aa <assert+0x4>
        exit(code);
    }
    10a8:	8082                	ret
        exit(code);
    10aa:	852e                	mv	a0,a1
    10ac:	a831                	j	10c8 <exit>

00000000000010ae <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    10ae:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    10b2:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    10b6:	2501                	sext.w	a0,a0
    10b8:	8082                	ret

00000000000010ba <exec>:
    register long a7 __asm__("a7") = n;
    10ba:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    10be:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    10c0:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    10c4:	2501                	sext.w	a0,a0
    10c6:	8082                	ret

00000000000010c8 <exit>:
    register long a7 __asm__("a7") = n;
    10c8:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    10cc:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    10d0:	8082                	ret

00000000000010d2 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    10d2:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    10d6:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    10da:	8082                	ret

00000000000010dc <write>:
    register long a7 __asm__("a7") = n;
    10dc:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    10e0:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    10e4:	8082                	ret

00000000000010e6 <getpid>:
    register long a7 __asm__("a7") = n;
    10e6:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    10ea:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    10ee:	2501                	sext.w	a0,a0
    10f0:	8082                	ret

00000000000010f2 <getppid>:
    register long a7 __asm__("a7") = n;
    10f2:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    10f6:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    10fa:	2501                	sext.w	a0,a0
    10fc:	8082                	ret

00000000000010fe <open>:
    register long a7 __asm__("a7") = n;
    10fe:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1102:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1106:	2501                	sext.w	a0,a0
    1108:	8082                	ret

000000000000110a <mknod>:
    register long a7 __asm__("a7") = n;
    110a:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    110e:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1112:	2501                	sext.w	a0,a0
    1114:	8082                	ret

0000000000001116 <dup>:
    register long a7 __asm__("a7") = n;
    1116:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1118:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    111c:	2501                	sext.w	a0,a0
    111e:	8082                	ret

0000000000001120 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1120:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1124:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1128:	2501                	sext.w	a0,a0
    112a:	8082                	ret

000000000000112c <waitpid>:
    register long a7 __asm__("a7") = n;
    112c:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1130:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1134:	2501                	sext.w	a0,a0
    1136:	8082                	ret

0000000000001138 <wait>:

pid_t wait(int *wstatus)
{
    1138:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    113a:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    113e:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1140:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1144:	2501                	sext.w	a0,a0
    1146:	8082                	ret

0000000000001148 <mkdir>:
    register long a7 __asm__("a7") = n;
    1148:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    114c:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1150:	2501                	sext.w	a0,a0
    1152:	8082                	ret

0000000000001154 <close>:
    register long a7 __asm__("a7") = n;
    1154:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1158:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    115c:	2501                	sext.w	a0,a0
    115e:	8082                	ret

0000000000001160 <fork>:
    register long a7 __asm__("a7") = n;
    1160:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1164:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1168:	2501                	sext.w	a0,a0
    116a:	8082                	ret

000000000000116c <time_ms>:
    register long a7 __asm__("a7") = n;
    116c:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1170:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1174:	8082                	ret

0000000000001176 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1176:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1178:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    117c:	00000073          	ecall
    1180:	87aa                	mv	a5,a0
    1182:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1186:	97ba                	add	a5,a5,a4
    1188:	00f57c63          	bgeu	a0,a5,11a0 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    118c:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1190:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1194:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1198:	00000073          	ecall
    119c:	fef568e3          	bltu	a0,a5,118c <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    11a0:	4501                	li	a0,0
    11a2:	8082                	ret

00000000000011a4 <pipe>:
    register long a7 __asm__("a7") = n;
    11a4:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    11a8:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    11ac:	2501                	sext.w	a0,a0
    11ae:	8082                	ret

00000000000011b0 <fstat>:
    register long a7 __asm__("a7") = n;
    11b0:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    11b4:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    11b8:	2501                	sext.w	a0,a0
    11ba:	8082                	ret

00000000000011bc <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    11bc:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    11be:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    11c2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    11c4:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    11c8:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    11cc:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    11d0:	0206c163          	bltz	a3,11f2 <stat+0x36>
    register long a7 __asm__("a7") = n;
    11d4:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    11d8:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    11da:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    11dc:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    11e0:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    11e4:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    11e8:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    11ea:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    11ee:	853e                	mv	a0,a5
    11f0:	8082                	ret
        return -1;
    11f2:	57fd                	li	a5,-1
    11f4:	bfed                	j	11ee <stat+0x32>

00000000000011f6 <chdir>:
    register long a7 __asm__("a7") = n;
    11f6:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    11fa:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    11fe:	2501                	sext.w	a0,a0
    1200:	8082                	ret

0000000000001202 <link>:
    register long a7 __asm__("a7") = n;
    1202:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1206:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    120a:	2501                	sext.w	a0,a0
    120c:	8082                	ret

000000000000120e <unlink>:
    register long a7 __asm__("a7") = n;
    120e:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1212:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1216:	2501                	sext.w	a0,a0
    1218:	8082                	ret

000000000000121a <setpriority>:
    register long a7 __asm__("a7") = n;
    121a:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    121e:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1222:	8082                	ret

0000000000001224 <getpriority>:
    register long a7 __asm__("a7") = n;
    1224:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1228:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    122c:	8082                	ret

000000000000122e <sharedmem>:
    register long a7 __asm__("a7") = n;
    122e:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1232:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1236:	8082                	ret

0000000000001238 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    1238:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    123a:	00f10593          	addi	a1,sp,15
    123e:	4605                	li	a2,1
    1240:	4501                	li	a0,0
int getchar() {
    1242:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1244:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1248:	e8bff0ef          	jal	ra,10d2 <read>
    return byte;
}
    124c:	60e2                	ld	ra,24(sp)
    124e:	00f14503          	lbu	a0,15(sp)
    1252:	6105                	addi	sp,sp,32
    1254:	8082                	ret

0000000000001256 <putchar>:

int putchar(int c)
{
    1256:	1141                	addi	sp,sp,-16
    1258:	e406                	sd	ra,8(sp)
    125a:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    125c:	00001597          	auipc	a1,0x1
    1260:	b7458593          	addi	a1,a1,-1164 # 1dd0 <put.1156>
    return write(stdout, put, 1);
    1264:	4605                	li	a2,1
    1266:	4505                	li	a0,1
    put[0] = c;
    1268:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    126c:	e71ff0ef          	jal	ra,10dc <write>
}
    1270:	60a2                	ld	ra,8(sp)
    1272:	2501                	sext.w	a0,a0
    1274:	0141                	addi	sp,sp,16
    1276:	8082                	ret

0000000000001278 <puts>:

int puts(const char* s)
{
    1278:	1141                	addi	sp,sp,-16
    127a:	e022                	sd	s0,0(sp)
    127c:	e406                	sd	ra,8(sp)
    127e:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    1280:	66e000ef          	jal	ra,18ee <strlen>
    1284:	862a                	mv	a2,a0
    1286:	85a2                	mv	a1,s0
    1288:	4505                	li	a0,1
    128a:	e53ff0ef          	jal	ra,10dc <write>
    128e:	00055763          	bgez	a0,129c <puts+0x24>
    return r;
}
    1292:	60a2                	ld	ra,8(sp)
    1294:	6402                	ld	s0,0(sp)
    1296:	557d                	li	a0,-1
    1298:	0141                	addi	sp,sp,16
    129a:	8082                	ret
    put[0] = c;
    129c:	00001597          	auipc	a1,0x1
    12a0:	b3458593          	addi	a1,a1,-1228 # 1dd0 <put.1156>
    12a4:	47a9                	li	a5,10
    return write(stdout, put, 1);
    12a6:	4605                	li	a2,1
    12a8:	4505                	li	a0,1
    put[0] = c;
    12aa:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    12ae:	e2fff0ef          	jal	ra,10dc <write>
}
    12b2:	60a2                	ld	ra,8(sp)
    12b4:	6402                	ld	s0,0(sp)
    12b6:	41f5551b          	sraiw	a0,a0,0x1f
    12ba:	0141                	addi	sp,sp,16
    12bc:	8082                	ret

00000000000012be <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    12be:	7115                	addi	sp,sp,-224
    12c0:	ed06                	sd	ra,152(sp)
    12c2:	e922                	sd	s0,144(sp)
    12c4:	e526                	sd	s1,136(sp)
    12c6:	e14a                	sd	s2,128(sp)
    12c8:	fcce                	sd	s3,120(sp)
    12ca:	f8d2                	sd	s4,112(sp)
    12cc:	f4d6                	sd	s5,104(sp)
    12ce:	f0da                	sd	s6,96(sp)
    12d0:	ecde                	sd	s7,88(sp)
    12d2:	e8e2                	sd	s8,80(sp)
    12d4:	e4e6                	sd	s9,72(sp)
    12d6:	e0ea                	sd	s10,64(sp)
    12d8:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    12da:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    12de:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    12e0:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    12e2:	f52e                	sd	a1,168(sp)
    12e4:	f932                	sd	a2,176(sp)
    12e6:	fd36                	sd	a3,184(sp)
    12e8:	e1ba                	sd	a4,192(sp)
    12ea:	e9c2                	sd	a6,208(sp)
    12ec:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    12ee:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    12f0:	0c030b63          	beqz	t1,13c6 <printf+0x108>
    12f4:	8aaa                	mv	s5,a0
    12f6:	0003071b          	sext.w	a4,t1
    12fa:	4481                	li	s1,0
        if (c != '%') {
    12fc:	02500b93          	li	s7,37
    put[0] = c;
    1300:	00001417          	auipc	s0,0x1
    1304:	ad040413          	addi	s0,s0,-1328 # 1dd0 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    1308:	4c51                	li	s8,20
    put[0] = c;
    130a:	02500c93          	li	s9,37
    130e:	00001a17          	auipc	s4,0x1
    1312:	acaa0a13          	addi	s4,s4,-1334 # 1dd8 <put.1156+0x8>
    1316:	00001997          	auipc	s3,0x1
    131a:	b1a98993          	addi	s3,s3,-1254 # 1e30 <digits>
    131e:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    1322:	0014879b          	addiw	a5,s1,1
    1326:	00fa8933          	add	s2,s5,a5
    132a:	13771163          	bne	a4,s7,144c <printf+0x18e>
        c = fmt[++i] & 0xff;
    132e:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    1332:	080d0a63          	beqz	s10,13c6 <printf+0x108>
        switch (c) {
    1336:	2489                	addiw	s1,s1,2
    1338:	009a8933          	add	s2,s5,s1
    133c:	257d0e63          	beq	s10,s7,1598 <printf+0x2da>
    1340:	f9cd079b          	addiw	a5,s10,-100
    1344:	0ff7f793          	andi	a5,a5,255
    1348:	0cfc6263          	bltu	s8,a5,140c <printf+0x14e>
    134c:	078a                	slli	a5,a5,0x2
    134e:	97d2                	add	a5,a5,s4
    1350:	439c                	lw	a5,0(a5)
    1352:	97d2                	add	a5,a5,s4
    1354:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    1356:	67a2                	ld	a5,8(sp)
    1358:	4398                	lw	a4,0(a5)
    135a:	07a1                	addi	a5,a5,8
    135c:	e43e                	sd	a5,8(sp)
    135e:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    1362:	26074663          	bltz	a4,15ce <printf+0x310>
        buf[i++] = digits[x % base];
    1366:	8bbd                	andi	a5,a5,15
    1368:	97ce                	add	a5,a5,s3
    136a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    136e:	40475d1b          	sraiw	s10,a4,0x4
    1372:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    1376:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    137a:	020d0163          	beqz	s10,139c <printf+0xde>
        buf[i++] = digits[x % base];
    137e:	9d4e                	add	s10,s10,s3
    1380:	000d4783          	lbu	a5,0(s10)
    1384:	4d05                	li	s10,1
    1386:	00f108a3          	sb	a5,17(sp)
    if (sign)
    138a:	00075963          	bgez	a4,139c <printf+0xde>
        buf[i++] = digits[x % base];
    138e:	4d09                	li	s10,2
        buf[i++] = '-';
    1390:	181c                	addi	a5,sp,48
    1392:	02d00713          	li	a4,45
    1396:	97ea                	add	a5,a5,s10
    1398:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    139c:	9d5a                	add	s10,s10,s6
    139e:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    13a2:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    13a6:	4605                	li	a2,1
    13a8:	1d7d                	addi	s10,s10,-1
    13aa:	85a2                	mv	a1,s0
    13ac:	4505                	li	a0,1
    put[0] = c;
    13ae:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    13b2:	d2bff0ef          	jal	ra,10dc <write>
    while (--i >= 0)
    13b6:	ffbd16e3          	bne	s10,s11,13a2 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    13ba:	00094303          	lbu	t1,0(s2)
    13be:	0003071b          	sext.w	a4,t1
    13c2:	f60310e3          	bnez	t1,1322 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    13c6:	60ea                	ld	ra,152(sp)
    13c8:	644a                	ld	s0,144(sp)
    13ca:	64aa                	ld	s1,136(sp)
    13cc:	690a                	ld	s2,128(sp)
    13ce:	79e6                	ld	s3,120(sp)
    13d0:	7a46                	ld	s4,112(sp)
    13d2:	7aa6                	ld	s5,104(sp)
    13d4:	7b06                	ld	s6,96(sp)
    13d6:	6be6                	ld	s7,88(sp)
    13d8:	6c46                	ld	s8,80(sp)
    13da:	6ca6                	ld	s9,72(sp)
    13dc:	6d06                	ld	s10,64(sp)
    13de:	7de2                	ld	s11,56(sp)
    13e0:	612d                	addi	sp,sp,224
    13e2:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    13e4:	67a2                	ld	a5,8(sp)
    13e6:	0007bd03          	ld	s10,0(a5)
    13ea:	07a1                	addi	a5,a5,8
    13ec:	e43e                	sd	a5,8(sp)
    13ee:	000d1b63          	bnez	s10,1404 <printf+0x146>
    13f2:	aafd                	j	15f0 <printf+0x332>
    return write(stdout, put, 1);
    13f4:	4605                	li	a2,1
    13f6:	85a2                	mv	a1,s0
    13f8:	4505                	li	a0,1
                for (; *s; s++)
    13fa:	0d05                	addi	s10,s10,1
    put[0] = c;
    13fc:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1400:	cddff0ef          	jal	ra,10dc <write>
                for (; *s; s++)
    1404:	000d4783          	lbu	a5,0(s10)
    1408:	f7f5                	bnez	a5,13f4 <printf+0x136>
    140a:	a02d                	j	1434 <printf+0x176>
    return write(stdout, put, 1);
    140c:	4605                	li	a2,1
    140e:	00001597          	auipc	a1,0x1
    1412:	9c258593          	addi	a1,a1,-1598 # 1dd0 <put.1156>
    1416:	4505                	li	a0,1
    put[0] = c;
    1418:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    141c:	cc1ff0ef          	jal	ra,10dc <write>
    1420:	4605                	li	a2,1
    1422:	00001597          	auipc	a1,0x1
    1426:	9ae58593          	addi	a1,a1,-1618 # 1dd0 <put.1156>
    142a:	4505                	li	a0,1
    put[0] = c;
    142c:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    1430:	cadff0ef          	jal	ra,10dc <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1434:	00094303          	lbu	t1,0(s2)
    1438:	0003071b          	sext.w	a4,t1
    143c:	f80305e3          	beqz	t1,13c6 <printf+0x108>
        if (c != '%') {
    1440:	0014879b          	addiw	a5,s1,1
    1444:	00fa8933          	add	s2,s5,a5
    1448:	ef7703e3          	beq	a4,s7,132e <printf+0x70>
    return write(stdout, put, 1);
    144c:	4605                	li	a2,1
    144e:	00001597          	auipc	a1,0x1
    1452:	98258593          	addi	a1,a1,-1662 # 1dd0 <put.1156>
    1456:	4505                	li	a0,1
    put[0] = c;
    1458:	00640023          	sb	t1,0(s0)
            continue;
    145c:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    145e:	c7fff0ef          	jal	ra,10dc <write>
            continue;
    1462:	bfc9                	j	1434 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    1464:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    1466:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    1468:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    146a:	0007b883          	ld	a7,0(a5)
    146e:	07a1                	addi	a5,a5,8
    1470:	e43e                	sd	a5,8(sp)
        x = -xx;
    1472:	43f8d713          	srai	a4,a7,0x3f
    1476:	011747b3          	xor	a5,a4,a7
    147a:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    147c:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    147e:	02c7f733          	remu	a4,a5,a2
    1482:	8d36                	mv	s10,a3
    1484:	0685                	addi	a3,a3,1
    1486:	00db0533          	add	a0,s6,a3
    148a:	85be                	mv	a1,a5
    148c:	974e                	add	a4,a4,s3
    148e:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    1492:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    1496:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    149a:	feb862e3          	bltu	a6,a1,147e <printf+0x1c0>
    if (sign)
    149e:	1208c063          	bltz	a7,15be <printf+0x300>
    while (--i >= 0)
    14a2:	9d5a                	add	s10,s10,s6
    put[0] = c;
    14a4:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    14a8:	4605                	li	a2,1
    14aa:	85a2                	mv	a1,s0
    14ac:	4505                	li	a0,1
    put[0] = c;
    14ae:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    14b2:	c2bff0ef          	jal	ra,10dc <write>
    while (--i >= 0)
    14b6:	87ea                	mv	a5,s10
    14b8:	1d7d                	addi	s10,s10,-1
    14ba:	fefb15e3          	bne	s6,a5,14a4 <printf+0x1e6>
    14be:	bf9d                	j	1434 <printf+0x176>
                printptr(va_arg(ap, uint64));
    14c0:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    14c2:	4605                	li	a2,1
    14c4:	00001597          	auipc	a1,0x1
    14c8:	90c58593          	addi	a1,a1,-1780 # 1dd0 <put.1156>
                printptr(va_arg(ap, uint64));
    14cc:	0007bd83          	ld	s11,0(a5)
    14d0:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    14d4:	4505                	li	a0,1
    put[0] = c;
    14d6:	03000793          	li	a5,48
    14da:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    14de:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    14e0:	bfdff0ef          	jal	ra,10dc <write>
    put[0] = c;
    14e4:	07800793          	li	a5,120
    return write(stdout, put, 1);
    14e8:	4605                	li	a2,1
    14ea:	00001597          	auipc	a1,0x1
    14ee:	8e658593          	addi	a1,a1,-1818 # 1dd0 <put.1156>
    14f2:	4505                	li	a0,1
    put[0] = c;
    14f4:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    14f8:	4d41                	li	s10,16
    14fa:	be3ff0ef          	jal	ra,10dc <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    14fe:	03cdd793          	srli	a5,s11,0x3c
    1502:	97ce                	add	a5,a5,s3
    put[0] = c;
    1504:	0007c783          	lbu	a5,0(a5)
    1508:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    150a:	4605                	li	a2,1
    150c:	85a2                	mv	a1,s0
    150e:	4505                	li	a0,1
    put[0] = c;
    1510:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1514:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1516:	bc7ff0ef          	jal	ra,10dc <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    151a:	fe0d12e3          	bnez	s10,14fe <printf+0x240>
    151e:	bf19                	j	1434 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    1520:	67a2                	ld	a5,8(sp)
    1522:	4394                	lw	a3,0(a5)
    1524:	07a1                	addi	a5,a5,8
    1526:	e43e                	sd	a5,8(sp)
    1528:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    152c:	0006d663          	bgez	a3,1538 <printf+0x27a>
        x = -xx;
    1530:	40f007bb          	negw	a5,a5
    1534:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    1538:	4729                	li	a4,10
    153a:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    153e:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    1542:	964e                	add	a2,a2,s3
    1544:	00064603          	lbu	a2,0(a2)
    1548:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    154c:	0a0d0963          	beqz	s10,15fe <printf+0x340>
        buf[i++] = digits[x % base];
    1550:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    1554:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    1558:	00c98733          	add	a4,s3,a2
    155c:	00074703          	lbu	a4,0(a4)
    1560:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    1564:	c3cd                	beqz	a5,1606 <printf+0x348>
        buf[i++] = digits[x % base];
    1566:	97ce                	add	a5,a5,s3
    1568:	0007c703          	lbu	a4,0(a5)
    156c:	4d09                	li	s10,2
    156e:	478d                	li	a5,3
    1570:	00e10923          	sb	a4,18(sp)
    if (sign)
    1574:	0206cd63          	bltz	a3,15ae <printf+0x2f0>
    while (--i >= 0)
    1578:	9d5a                	add	s10,s10,s6
    157a:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    157e:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1582:	4605                	li	a2,1
    1584:	1d7d                	addi	s10,s10,-1
    1586:	85a2                	mv	a1,s0
    1588:	4505                	li	a0,1
    put[0] = c;
    158a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    158e:	b4fff0ef          	jal	ra,10dc <write>
    while (--i >= 0)
    1592:	ffbd16e3          	bne	s10,s11,157e <printf+0x2c0>
    1596:	bd79                	j	1434 <printf+0x176>
    return write(stdout, put, 1);
    1598:	4605                	li	a2,1
    159a:	00001597          	auipc	a1,0x1
    159e:	83658593          	addi	a1,a1,-1994 # 1dd0 <put.1156>
    15a2:	4505                	li	a0,1
    put[0] = c;
    15a4:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    15a8:	b35ff0ef          	jal	ra,10dc <write>
    15ac:	b561                	j	1434 <printf+0x176>
        buf[i++] = '-';
    15ae:	1818                	addi	a4,sp,48
    15b0:	973e                	add	a4,a4,a5
    15b2:	02d00693          	li	a3,45
    15b6:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    15ba:	8d3e                	mv	s10,a5
    15bc:	bf75                	j	1578 <printf+0x2ba>
        buf[i++] = '-';
    15be:	181c                	addi	a5,sp,48
    15c0:	97b6                	add	a5,a5,a3
    15c2:	02d00713          	li	a4,45
    15c6:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    15ca:	8d36                	mv	s10,a3
    15cc:	bdd9                	j	14a2 <printf+0x1e4>
        x = -xx;
    15ce:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    15d2:	00f7f693          	andi	a3,a5,15
    15d6:	96ce                	add	a3,a3,s3
    15d8:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    15dc:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    15e0:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    15e4:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    15e8:	d80d1be3          	bnez	s10,137e <printf+0xc0>
        buf[i++] = digits[x % base];
    15ec:	4d05                	li	s10,1
    15ee:	b34d                	j	1390 <printf+0xd2>
                s = "(null)";
    15f0:	00000d17          	auipc	s10,0x0
    15f4:	7d0d0d13          	addi	s10,s10,2000 # 1dc0 <memmove+0x12c>
                for (; *s; s++)
    15f8:	02800793          	li	a5,40
    15fc:	bbe5                	j	13f4 <printf+0x136>
        buf[i++] = digits[x % base];
    15fe:	4785                	li	a5,1
    if (sign)
    1600:	f606dce3          	bgez	a3,1578 <printf+0x2ba>
    1604:	b76d                	j	15ae <printf+0x2f0>
        buf[i++] = digits[x % base];
    1606:	4789                	li	a5,2
    1608:	4d05                	li	s10,1
    if (sign)
    160a:	f606d7e3          	bgez	a3,1578 <printf+0x2ba>
    160e:	b745                	j	15ae <printf+0x2f0>

0000000000001610 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1610:	02000793          	li	a5,32
    1614:	00f50663          	beq	a0,a5,1620 <isspace+0x10>
    1618:	355d                	addiw	a0,a0,-9
    161a:	00553513          	sltiu	a0,a0,5
    161e:	8082                	ret
    1620:	4505                	li	a0,1
}
    1622:	8082                	ret

0000000000001624 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1624:	fd05051b          	addiw	a0,a0,-48
}
    1628:	00a53513          	sltiu	a0,a0,10
    162c:	8082                	ret

000000000000162e <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    162e:	02000613          	li	a2,32
    1632:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1634:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1638:	ff77069b          	addiw	a3,a4,-9
    163c:	04c70d63          	beq	a4,a2,1696 <atoi+0x68>
    1640:	0007079b          	sext.w	a5,a4
    1644:	04d5f963          	bgeu	a1,a3,1696 <atoi+0x68>
        s++;
    switch (*s) {
    1648:	02b00693          	li	a3,43
    164c:	04d70a63          	beq	a4,a3,16a0 <atoi+0x72>
    1650:	02d00693          	li	a3,45
    1654:	06d70463          	beq	a4,a3,16bc <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1658:	fd07859b          	addiw	a1,a5,-48
    165c:	4625                	li	a2,9
    165e:	873e                	mv	a4,a5
    1660:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1662:	4e01                	li	t3,0
    while (isdigit(*s))
    1664:	04b66a63          	bltu	a2,a1,16b8 <atoi+0x8a>
    int n = 0, neg = 0;
    1668:	4501                	li	a0,0
    while (isdigit(*s))
    166a:	4825                	li	a6,9
    166c:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1670:	0025179b          	slliw	a5,a0,0x2
    1674:	9d3d                	addw	a0,a0,a5
    1676:	fd07031b          	addiw	t1,a4,-48
    167a:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    167e:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1682:	0685                	addi	a3,a3,1
    1684:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1688:	0006071b          	sext.w	a4,a2
    168c:	feb870e3          	bgeu	a6,a1,166c <atoi+0x3e>
    return neg ? n : -n;
    1690:	000e0563          	beqz	t3,169a <atoi+0x6c>
}
    1694:	8082                	ret
        s++;
    1696:	0505                	addi	a0,a0,1
    1698:	bf71                	j	1634 <atoi+0x6>
    169a:	4113053b          	subw	a0,t1,a7
    169e:	8082                	ret
    while (isdigit(*s))
    16a0:	00154783          	lbu	a5,1(a0)
    16a4:	4625                	li	a2,9
        s++;
    16a6:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16aa:	fd07859b          	addiw	a1,a5,-48
    16ae:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    16b2:	4e01                	li	t3,0
    while (isdigit(*s))
    16b4:	fab67ae3          	bgeu	a2,a1,1668 <atoi+0x3a>
    16b8:	4501                	li	a0,0
}
    16ba:	8082                	ret
    while (isdigit(*s))
    16bc:	00154783          	lbu	a5,1(a0)
    16c0:	4625                	li	a2,9
        s++;
    16c2:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16c6:	fd07859b          	addiw	a1,a5,-48
    16ca:	0007871b          	sext.w	a4,a5
    16ce:	feb665e3          	bltu	a2,a1,16b8 <atoi+0x8a>
        neg = 1;
    16d2:	4e05                	li	t3,1
    16d4:	bf51                	j	1668 <atoi+0x3a>

00000000000016d6 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    16d6:	16060d63          	beqz	a2,1850 <memset+0x17a>
    16da:	40a007b3          	neg	a5,a0
    16de:	8b9d                	andi	a5,a5,7
    16e0:	00778713          	addi	a4,a5,7
    16e4:	482d                	li	a6,11
    16e6:	0ff5f593          	andi	a1,a1,255
    16ea:	fff60693          	addi	a3,a2,-1
    16ee:	17076263          	bltu	a4,a6,1852 <memset+0x17c>
    16f2:	16e6ea63          	bltu	a3,a4,1866 <memset+0x190>
    16f6:	16078563          	beqz	a5,1860 <memset+0x18a>
    16fa:	00b50023          	sb	a1,0(a0)
    16fe:	4705                	li	a4,1
    1700:	00150e93          	addi	t4,a0,1
    1704:	14e78c63          	beq	a5,a4,185c <memset+0x186>
    1708:	00b500a3          	sb	a1,1(a0)
    170c:	4709                	li	a4,2
    170e:	00250e93          	addi	t4,a0,2
    1712:	14e78d63          	beq	a5,a4,186c <memset+0x196>
    1716:	00b50123          	sb	a1,2(a0)
    171a:	470d                	li	a4,3
    171c:	00350e93          	addi	t4,a0,3
    1720:	12e78b63          	beq	a5,a4,1856 <memset+0x180>
    1724:	00b501a3          	sb	a1,3(a0)
    1728:	4711                	li	a4,4
    172a:	00450e93          	addi	t4,a0,4
    172e:	14e78163          	beq	a5,a4,1870 <memset+0x19a>
    1732:	00b50223          	sb	a1,4(a0)
    1736:	4715                	li	a4,5
    1738:	00550e93          	addi	t4,a0,5
    173c:	12e78c63          	beq	a5,a4,1874 <memset+0x19e>
    1740:	00b502a3          	sb	a1,5(a0)
    1744:	471d                	li	a4,7
    1746:	00650e93          	addi	t4,a0,6
    174a:	12e79763          	bne	a5,a4,1878 <memset+0x1a2>
    174e:	00750e93          	addi	t4,a0,7
    1752:	00b50323          	sb	a1,6(a0)
    1756:	4f1d                	li	t5,7
    1758:	00859713          	slli	a4,a1,0x8
    175c:	8f4d                	or	a4,a4,a1
    175e:	01059e13          	slli	t3,a1,0x10
    1762:	01c76e33          	or	t3,a4,t3
    1766:	01859313          	slli	t1,a1,0x18
    176a:	006e6333          	or	t1,t3,t1
    176e:	02059893          	slli	a7,a1,0x20
    1772:	011368b3          	or	a7,t1,a7
    1776:	02859813          	slli	a6,a1,0x28
    177a:	40f60333          	sub	t1,a2,a5
    177e:	0108e833          	or	a6,a7,a6
    1782:	03059693          	slli	a3,a1,0x30
    1786:	00d866b3          	or	a3,a6,a3
    178a:	03859713          	slli	a4,a1,0x38
    178e:	97aa                	add	a5,a5,a0
    1790:	ff837813          	andi	a6,t1,-8
    1794:	8f55                	or	a4,a4,a3
    1796:	00f806b3          	add	a3,a6,a5
    179a:	e398                	sd	a4,0(a5)
    179c:	07a1                	addi	a5,a5,8
    179e:	fed79ee3          	bne	a5,a3,179a <memset+0xc4>
    17a2:	ff837693          	andi	a3,t1,-8
    17a6:	00de87b3          	add	a5,t4,a3
    17aa:	01e6873b          	addw	a4,a3,t5
    17ae:	0ad30663          	beq	t1,a3,185a <memset+0x184>
    17b2:	00b78023          	sb	a1,0(a5)
    17b6:	0017069b          	addiw	a3,a4,1
    17ba:	08c6fb63          	bgeu	a3,a2,1850 <memset+0x17a>
    17be:	00b780a3          	sb	a1,1(a5)
    17c2:	0027069b          	addiw	a3,a4,2
    17c6:	08c6f563          	bgeu	a3,a2,1850 <memset+0x17a>
    17ca:	00b78123          	sb	a1,2(a5)
    17ce:	0037069b          	addiw	a3,a4,3
    17d2:	06c6ff63          	bgeu	a3,a2,1850 <memset+0x17a>
    17d6:	00b781a3          	sb	a1,3(a5)
    17da:	0047069b          	addiw	a3,a4,4
    17de:	06c6f963          	bgeu	a3,a2,1850 <memset+0x17a>
    17e2:	00b78223          	sb	a1,4(a5)
    17e6:	0057069b          	addiw	a3,a4,5
    17ea:	06c6f363          	bgeu	a3,a2,1850 <memset+0x17a>
    17ee:	00b782a3          	sb	a1,5(a5)
    17f2:	0067069b          	addiw	a3,a4,6
    17f6:	04c6fd63          	bgeu	a3,a2,1850 <memset+0x17a>
    17fa:	00b78323          	sb	a1,6(a5)
    17fe:	0077069b          	addiw	a3,a4,7
    1802:	04c6f763          	bgeu	a3,a2,1850 <memset+0x17a>
    1806:	00b783a3          	sb	a1,7(a5)
    180a:	0087069b          	addiw	a3,a4,8
    180e:	04c6f163          	bgeu	a3,a2,1850 <memset+0x17a>
    1812:	00b78423          	sb	a1,8(a5)
    1816:	0097069b          	addiw	a3,a4,9
    181a:	02c6fb63          	bgeu	a3,a2,1850 <memset+0x17a>
    181e:	00b784a3          	sb	a1,9(a5)
    1822:	00a7069b          	addiw	a3,a4,10
    1826:	02c6f563          	bgeu	a3,a2,1850 <memset+0x17a>
    182a:	00b78523          	sb	a1,10(a5)
    182e:	00b7069b          	addiw	a3,a4,11
    1832:	00c6ff63          	bgeu	a3,a2,1850 <memset+0x17a>
    1836:	00b785a3          	sb	a1,11(a5)
    183a:	00c7069b          	addiw	a3,a4,12
    183e:	00c6f963          	bgeu	a3,a2,1850 <memset+0x17a>
    1842:	00b78623          	sb	a1,12(a5)
    1846:	2735                	addiw	a4,a4,13
    1848:	00c77463          	bgeu	a4,a2,1850 <memset+0x17a>
    184c:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    1850:	8082                	ret
    1852:	472d                	li	a4,11
    1854:	bd79                	j	16f2 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1856:	4f0d                	li	t5,3
    1858:	b701                	j	1758 <memset+0x82>
    185a:	8082                	ret
    185c:	4f05                	li	t5,1
    185e:	bded                	j	1758 <memset+0x82>
    1860:	8eaa                	mv	t4,a0
    1862:	4f01                	li	t5,0
    1864:	bdd5                	j	1758 <memset+0x82>
    1866:	87aa                	mv	a5,a0
    1868:	4701                	li	a4,0
    186a:	b7a1                	j	17b2 <memset+0xdc>
    186c:	4f09                	li	t5,2
    186e:	b5ed                	j	1758 <memset+0x82>
    1870:	4f11                	li	t5,4
    1872:	b5dd                	j	1758 <memset+0x82>
    1874:	4f15                	li	t5,5
    1876:	b5cd                	j	1758 <memset+0x82>
    1878:	4f19                	li	t5,6
    187a:	bdf9                	j	1758 <memset+0x82>

000000000000187c <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    187c:	00054783          	lbu	a5,0(a0)
    1880:	0005c703          	lbu	a4,0(a1)
    1884:	00e79863          	bne	a5,a4,1894 <strcmp+0x18>
    1888:	0505                	addi	a0,a0,1
    188a:	0585                	addi	a1,a1,1
    188c:	fbe5                	bnez	a5,187c <strcmp>
    188e:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    1890:	9d19                	subw	a0,a0,a4
    1892:	8082                	ret
    1894:	0007851b          	sext.w	a0,a5
    1898:	bfe5                	j	1890 <strcmp+0x14>

000000000000189a <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    189a:	87aa                	mv	a5,a0
    189c:	0005c703          	lbu	a4,0(a1)
    18a0:	0785                	addi	a5,a5,1
    18a2:	0585                	addi	a1,a1,1
    18a4:	fee78fa3          	sb	a4,-1(a5)
    18a8:	fb75                	bnez	a4,189c <strcpy+0x2>
        ;
    return os;
}
    18aa:	8082                	ret

00000000000018ac <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    18ac:	ce05                	beqz	a2,18e4 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18ae:	00054703          	lbu	a4,0(a0)
    18b2:	0005c783          	lbu	a5,0(a1)
    18b6:	cb0d                	beqz	a4,18e8 <strncmp+0x3c>
    if (!n--)
    18b8:	167d                	addi	a2,a2,-1
    18ba:	00c506b3          	add	a3,a0,a2
    18be:	a819                	j	18d4 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18c0:	00a68e63          	beq	a3,a0,18dc <strncmp+0x30>
    18c4:	0505                	addi	a0,a0,1
    18c6:	00e79b63          	bne	a5,a4,18dc <strncmp+0x30>
    18ca:	00054703          	lbu	a4,0(a0)
    18ce:	0005c783          	lbu	a5,0(a1)
    18d2:	cb19                	beqz	a4,18e8 <strncmp+0x3c>
    18d4:	0005c783          	lbu	a5,0(a1)
    18d8:	0585                	addi	a1,a1,1
    18da:	f3fd                	bnez	a5,18c0 <strncmp+0x14>
        ;
    return *l - *r;
    18dc:	0007051b          	sext.w	a0,a4
    18e0:	9d1d                	subw	a0,a0,a5
    18e2:	8082                	ret
        return 0;
    18e4:	4501                	li	a0,0
}
    18e6:	8082                	ret
    18e8:	4501                	li	a0,0
    return *l - *r;
    18ea:	9d1d                	subw	a0,a0,a5
    18ec:	8082                	ret

00000000000018ee <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    18ee:	00757793          	andi	a5,a0,7
    18f2:	cf89                	beqz	a5,190c <strlen+0x1e>
    18f4:	87aa                	mv	a5,a0
    18f6:	a029                	j	1900 <strlen+0x12>
    18f8:	0785                	addi	a5,a5,1
    18fa:	0077f713          	andi	a4,a5,7
    18fe:	cb01                	beqz	a4,190e <strlen+0x20>
        if (!*s)
    1900:	0007c703          	lbu	a4,0(a5)
    1904:	fb75                	bnez	a4,18f8 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1906:	40a78533          	sub	a0,a5,a0
}
    190a:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    190c:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    190e:	6394                	ld	a3,0(a5)
    1910:	00000597          	auipc	a1,0x0
    1914:	4985b583          	ld	a1,1176(a1) # 1da8 <memmove+0x114>
    1918:	00000617          	auipc	a2,0x0
    191c:	49863603          	ld	a2,1176(a2) # 1db0 <memmove+0x11c>
    1920:	a019                	j	1926 <strlen+0x38>
    1922:	6794                	ld	a3,8(a5)
    1924:	07a1                	addi	a5,a5,8
    1926:	00b68733          	add	a4,a3,a1
    192a:	fff6c693          	not	a3,a3
    192e:	8f75                	and	a4,a4,a3
    1930:	8f71                	and	a4,a4,a2
    1932:	db65                	beqz	a4,1922 <strlen+0x34>
    for (; *s; s++)
    1934:	0007c703          	lbu	a4,0(a5)
    1938:	d779                	beqz	a4,1906 <strlen+0x18>
    193a:	0017c703          	lbu	a4,1(a5)
    193e:	0785                	addi	a5,a5,1
    1940:	d379                	beqz	a4,1906 <strlen+0x18>
    1942:	0017c703          	lbu	a4,1(a5)
    1946:	0785                	addi	a5,a5,1
    1948:	fb6d                	bnez	a4,193a <strlen+0x4c>
    194a:	bf75                	j	1906 <strlen+0x18>

000000000000194c <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    194c:	00757713          	andi	a4,a0,7
{
    1950:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1952:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1956:	cb19                	beqz	a4,196c <memchr+0x20>
    1958:	ce25                	beqz	a2,19d0 <memchr+0x84>
    195a:	0007c703          	lbu	a4,0(a5)
    195e:	04b70e63          	beq	a4,a1,19ba <memchr+0x6e>
    1962:	0785                	addi	a5,a5,1
    1964:	0077f713          	andi	a4,a5,7
    1968:	167d                	addi	a2,a2,-1
    196a:	f77d                	bnez	a4,1958 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    196c:	4501                	li	a0,0
    if (n && *s != c) {
    196e:	c235                	beqz	a2,19d2 <memchr+0x86>
    1970:	0007c703          	lbu	a4,0(a5)
    1974:	04b70363          	beq	a4,a1,19ba <memchr+0x6e>
        size_t k = ONES * c;
    1978:	00000517          	auipc	a0,0x0
    197c:	44053503          	ld	a0,1088(a0) # 1db8 <memmove+0x124>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1980:	471d                	li	a4,7
        size_t k = ONES * c;
    1982:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1986:	02c77a63          	bgeu	a4,a2,19ba <memchr+0x6e>
    198a:	00000897          	auipc	a7,0x0
    198e:	41e8b883          	ld	a7,1054(a7) # 1da8 <memmove+0x114>
    1992:	00000817          	auipc	a6,0x0
    1996:	41e83803          	ld	a6,1054(a6) # 1db0 <memmove+0x11c>
    199a:	431d                	li	t1,7
    199c:	a029                	j	19a6 <memchr+0x5a>
    199e:	1661                	addi	a2,a2,-8
    19a0:	07a1                	addi	a5,a5,8
    19a2:	02c37963          	bgeu	t1,a2,19d4 <memchr+0x88>
    19a6:	6398                	ld	a4,0(a5)
    19a8:	8f29                	xor	a4,a4,a0
    19aa:	011706b3          	add	a3,a4,a7
    19ae:	fff74713          	not	a4,a4
    19b2:	8f75                	and	a4,a4,a3
    19b4:	01077733          	and	a4,a4,a6
    19b8:	d37d                	beqz	a4,199e <memchr+0x52>
    19ba:	853e                	mv	a0,a5
    19bc:	97b2                	add	a5,a5,a2
    19be:	a021                	j	19c6 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    19c0:	0505                	addi	a0,a0,1
    19c2:	00f50763          	beq	a0,a5,19d0 <memchr+0x84>
    19c6:	00054703          	lbu	a4,0(a0)
    19ca:	feb71be3          	bne	a4,a1,19c0 <memchr+0x74>
    19ce:	8082                	ret
    return n ? (void*)s : 0;
    19d0:	4501                	li	a0,0
}
    19d2:	8082                	ret
    return n ? (void*)s : 0;
    19d4:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19d6:	f275                	bnez	a2,19ba <memchr+0x6e>
}
    19d8:	8082                	ret

00000000000019da <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    19da:	1101                	addi	sp,sp,-32
    19dc:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    19de:	862e                	mv	a2,a1
{
    19e0:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    19e2:	4581                	li	a1,0
{
    19e4:	e426                	sd	s1,8(sp)
    19e6:	ec06                	sd	ra,24(sp)
    19e8:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    19ea:	f63ff0ef          	jal	ra,194c <memchr>
    return p ? p - s : n;
    19ee:	c519                	beqz	a0,19fc <strnlen+0x22>
}
    19f0:	60e2                	ld	ra,24(sp)
    19f2:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19f4:	8d05                	sub	a0,a0,s1
}
    19f6:	64a2                	ld	s1,8(sp)
    19f8:	6105                	addi	sp,sp,32
    19fa:	8082                	ret
    19fc:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19fe:	8522                	mv	a0,s0
}
    1a00:	6442                	ld	s0,16(sp)
    1a02:	64a2                	ld	s1,8(sp)
    1a04:	6105                	addi	sp,sp,32
    1a06:	8082                	ret

0000000000001a08 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1a08:	00b547b3          	xor	a5,a0,a1
    1a0c:	8b9d                	andi	a5,a5,7
    1a0e:	eb95                	bnez	a5,1a42 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1a10:	0075f793          	andi	a5,a1,7
    1a14:	e7b1                	bnez	a5,1a60 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a16:	6198                	ld	a4,0(a1)
    1a18:	00000617          	auipc	a2,0x0
    1a1c:	39063603          	ld	a2,912(a2) # 1da8 <memmove+0x114>
    1a20:	00000817          	auipc	a6,0x0
    1a24:	39083803          	ld	a6,912(a6) # 1db0 <memmove+0x11c>
    1a28:	a029                	j	1a32 <stpcpy+0x2a>
    1a2a:	e118                	sd	a4,0(a0)
    1a2c:	6598                	ld	a4,8(a1)
    1a2e:	05a1                	addi	a1,a1,8
    1a30:	0521                	addi	a0,a0,8
    1a32:	00c707b3          	add	a5,a4,a2
    1a36:	fff74693          	not	a3,a4
    1a3a:	8ff5                	and	a5,a5,a3
    1a3c:	0107f7b3          	and	a5,a5,a6
    1a40:	d7ed                	beqz	a5,1a2a <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1a42:	0005c783          	lbu	a5,0(a1)
    1a46:	00f50023          	sb	a5,0(a0)
    1a4a:	c785                	beqz	a5,1a72 <stpcpy+0x6a>
    1a4c:	0015c783          	lbu	a5,1(a1)
    1a50:	0505                	addi	a0,a0,1
    1a52:	0585                	addi	a1,a1,1
    1a54:	00f50023          	sb	a5,0(a0)
    1a58:	fbf5                	bnez	a5,1a4c <stpcpy+0x44>
        ;
    return d;
}
    1a5a:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a5c:	0505                	addi	a0,a0,1
    1a5e:	df45                	beqz	a4,1a16 <stpcpy+0xe>
            if (!(*d = *s))
    1a60:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a64:	0585                	addi	a1,a1,1
    1a66:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a6a:	00f50023          	sb	a5,0(a0)
    1a6e:	f7fd                	bnez	a5,1a5c <stpcpy+0x54>
}
    1a70:	8082                	ret
    1a72:	8082                	ret

0000000000001a74 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1a74:	00b547b3          	xor	a5,a0,a1
    1a78:	8b9d                	andi	a5,a5,7
    1a7a:	1a079863          	bnez	a5,1c2a <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a7e:	0075f793          	andi	a5,a1,7
    1a82:	16078463          	beqz	a5,1bea <stpncpy+0x176>
    1a86:	ea01                	bnez	a2,1a96 <stpncpy+0x22>
    1a88:	a421                	j	1c90 <stpncpy+0x21c>
    1a8a:	167d                	addi	a2,a2,-1
    1a8c:	0505                	addi	a0,a0,1
    1a8e:	14070e63          	beqz	a4,1bea <stpncpy+0x176>
    1a92:	1a060863          	beqz	a2,1c42 <stpncpy+0x1ce>
    1a96:	0005c783          	lbu	a5,0(a1)
    1a9a:	0585                	addi	a1,a1,1
    1a9c:	0075f713          	andi	a4,a1,7
    1aa0:	00f50023          	sb	a5,0(a0)
    1aa4:	f3fd                	bnez	a5,1a8a <stpncpy+0x16>
    1aa6:	4805                	li	a6,1
    1aa8:	1a061863          	bnez	a2,1c58 <stpncpy+0x1e4>
    1aac:	40a007b3          	neg	a5,a0
    1ab0:	8b9d                	andi	a5,a5,7
    1ab2:	4681                	li	a3,0
    1ab4:	18061a63          	bnez	a2,1c48 <stpncpy+0x1d4>
    1ab8:	00778713          	addi	a4,a5,7
    1abc:	45ad                	li	a1,11
    1abe:	18b76363          	bltu	a4,a1,1c44 <stpncpy+0x1d0>
    1ac2:	1ae6eb63          	bltu	a3,a4,1c78 <stpncpy+0x204>
    1ac6:	1a078363          	beqz	a5,1c6c <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1aca:	00050023          	sb	zero,0(a0)
    1ace:	4685                	li	a3,1
    1ad0:	00150713          	addi	a4,a0,1
    1ad4:	18d78f63          	beq	a5,a3,1c72 <stpncpy+0x1fe>
    1ad8:	000500a3          	sb	zero,1(a0)
    1adc:	4689                	li	a3,2
    1ade:	00250713          	addi	a4,a0,2
    1ae2:	18d78e63          	beq	a5,a3,1c7e <stpncpy+0x20a>
    1ae6:	00050123          	sb	zero,2(a0)
    1aea:	468d                	li	a3,3
    1aec:	00350713          	addi	a4,a0,3
    1af0:	16d78c63          	beq	a5,a3,1c68 <stpncpy+0x1f4>
    1af4:	000501a3          	sb	zero,3(a0)
    1af8:	4691                	li	a3,4
    1afa:	00450713          	addi	a4,a0,4
    1afe:	18d78263          	beq	a5,a3,1c82 <stpncpy+0x20e>
    1b02:	00050223          	sb	zero,4(a0)
    1b06:	4695                	li	a3,5
    1b08:	00550713          	addi	a4,a0,5
    1b0c:	16d78d63          	beq	a5,a3,1c86 <stpncpy+0x212>
    1b10:	000502a3          	sb	zero,5(a0)
    1b14:	469d                	li	a3,7
    1b16:	00650713          	addi	a4,a0,6
    1b1a:	16d79863          	bne	a5,a3,1c8a <stpncpy+0x216>
    1b1e:	00750713          	addi	a4,a0,7
    1b22:	00050323          	sb	zero,6(a0)
    1b26:	40f80833          	sub	a6,a6,a5
    1b2a:	ff887593          	andi	a1,a6,-8
    1b2e:	97aa                	add	a5,a5,a0
    1b30:	95be                	add	a1,a1,a5
    1b32:	0007b023          	sd	zero,0(a5)
    1b36:	07a1                	addi	a5,a5,8
    1b38:	feb79de3          	bne	a5,a1,1b32 <stpncpy+0xbe>
    1b3c:	ff887593          	andi	a1,a6,-8
    1b40:	9ead                	addw	a3,a3,a1
    1b42:	00b707b3          	add	a5,a4,a1
    1b46:	12b80863          	beq	a6,a1,1c76 <stpncpy+0x202>
    1b4a:	00078023          	sb	zero,0(a5)
    1b4e:	0016871b          	addiw	a4,a3,1
    1b52:	0ec77863          	bgeu	a4,a2,1c42 <stpncpy+0x1ce>
    1b56:	000780a3          	sb	zero,1(a5)
    1b5a:	0026871b          	addiw	a4,a3,2
    1b5e:	0ec77263          	bgeu	a4,a2,1c42 <stpncpy+0x1ce>
    1b62:	00078123          	sb	zero,2(a5)
    1b66:	0036871b          	addiw	a4,a3,3
    1b6a:	0cc77c63          	bgeu	a4,a2,1c42 <stpncpy+0x1ce>
    1b6e:	000781a3          	sb	zero,3(a5)
    1b72:	0046871b          	addiw	a4,a3,4
    1b76:	0cc77663          	bgeu	a4,a2,1c42 <stpncpy+0x1ce>
    1b7a:	00078223          	sb	zero,4(a5)
    1b7e:	0056871b          	addiw	a4,a3,5
    1b82:	0cc77063          	bgeu	a4,a2,1c42 <stpncpy+0x1ce>
    1b86:	000782a3          	sb	zero,5(a5)
    1b8a:	0066871b          	addiw	a4,a3,6
    1b8e:	0ac77a63          	bgeu	a4,a2,1c42 <stpncpy+0x1ce>
    1b92:	00078323          	sb	zero,6(a5)
    1b96:	0076871b          	addiw	a4,a3,7
    1b9a:	0ac77463          	bgeu	a4,a2,1c42 <stpncpy+0x1ce>
    1b9e:	000783a3          	sb	zero,7(a5)
    1ba2:	0086871b          	addiw	a4,a3,8
    1ba6:	08c77e63          	bgeu	a4,a2,1c42 <stpncpy+0x1ce>
    1baa:	00078423          	sb	zero,8(a5)
    1bae:	0096871b          	addiw	a4,a3,9
    1bb2:	08c77863          	bgeu	a4,a2,1c42 <stpncpy+0x1ce>
    1bb6:	000784a3          	sb	zero,9(a5)
    1bba:	00a6871b          	addiw	a4,a3,10
    1bbe:	08c77263          	bgeu	a4,a2,1c42 <stpncpy+0x1ce>
    1bc2:	00078523          	sb	zero,10(a5)
    1bc6:	00b6871b          	addiw	a4,a3,11
    1bca:	06c77c63          	bgeu	a4,a2,1c42 <stpncpy+0x1ce>
    1bce:	000785a3          	sb	zero,11(a5)
    1bd2:	00c6871b          	addiw	a4,a3,12
    1bd6:	06c77663          	bgeu	a4,a2,1c42 <stpncpy+0x1ce>
    1bda:	00078623          	sb	zero,12(a5)
    1bde:	26b5                	addiw	a3,a3,13
    1be0:	06c6f163          	bgeu	a3,a2,1c42 <stpncpy+0x1ce>
    1be4:	000786a3          	sb	zero,13(a5)
    1be8:	8082                	ret
            ;
        if (!n || !*s)
    1bea:	c645                	beqz	a2,1c92 <stpncpy+0x21e>
    1bec:	0005c783          	lbu	a5,0(a1)
    1bf0:	ea078be3          	beqz	a5,1aa6 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bf4:	479d                	li	a5,7
    1bf6:	02c7ff63          	bgeu	a5,a2,1c34 <stpncpy+0x1c0>
    1bfa:	00000897          	auipc	a7,0x0
    1bfe:	1ae8b883          	ld	a7,430(a7) # 1da8 <memmove+0x114>
    1c02:	00000817          	auipc	a6,0x0
    1c06:	1ae83803          	ld	a6,430(a6) # 1db0 <memmove+0x11c>
    1c0a:	431d                	li	t1,7
    1c0c:	6198                	ld	a4,0(a1)
    1c0e:	011707b3          	add	a5,a4,a7
    1c12:	fff74693          	not	a3,a4
    1c16:	8ff5                	and	a5,a5,a3
    1c18:	0107f7b3          	and	a5,a5,a6
    1c1c:	ef81                	bnez	a5,1c34 <stpncpy+0x1c0>
            *wd = *ws;
    1c1e:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c20:	1661                	addi	a2,a2,-8
    1c22:	05a1                	addi	a1,a1,8
    1c24:	0521                	addi	a0,a0,8
    1c26:	fec363e3          	bltu	t1,a2,1c0c <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c2a:	e609                	bnez	a2,1c34 <stpncpy+0x1c0>
    1c2c:	a08d                	j	1c8e <stpncpy+0x21a>
    1c2e:	167d                	addi	a2,a2,-1
    1c30:	0505                	addi	a0,a0,1
    1c32:	ca01                	beqz	a2,1c42 <stpncpy+0x1ce>
    1c34:	0005c783          	lbu	a5,0(a1)
    1c38:	0585                	addi	a1,a1,1
    1c3a:	00f50023          	sb	a5,0(a0)
    1c3e:	fbe5                	bnez	a5,1c2e <stpncpy+0x1ba>
        ;
tail:
    1c40:	b59d                	j	1aa6 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c42:	8082                	ret
    1c44:	472d                	li	a4,11
    1c46:	bdb5                	j	1ac2 <stpncpy+0x4e>
    1c48:	00778713          	addi	a4,a5,7
    1c4c:	45ad                	li	a1,11
    1c4e:	fff60693          	addi	a3,a2,-1
    1c52:	e6b778e3          	bgeu	a4,a1,1ac2 <stpncpy+0x4e>
    1c56:	b7fd                	j	1c44 <stpncpy+0x1d0>
    1c58:	40a007b3          	neg	a5,a0
    1c5c:	8832                	mv	a6,a2
    1c5e:	8b9d                	andi	a5,a5,7
    1c60:	4681                	li	a3,0
    1c62:	e4060be3          	beqz	a2,1ab8 <stpncpy+0x44>
    1c66:	b7cd                	j	1c48 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1c68:	468d                	li	a3,3
    1c6a:	bd75                	j	1b26 <stpncpy+0xb2>
    1c6c:	872a                	mv	a4,a0
    1c6e:	4681                	li	a3,0
    1c70:	bd5d                	j	1b26 <stpncpy+0xb2>
    1c72:	4685                	li	a3,1
    1c74:	bd4d                	j	1b26 <stpncpy+0xb2>
    1c76:	8082                	ret
    1c78:	87aa                	mv	a5,a0
    1c7a:	4681                	li	a3,0
    1c7c:	b5f9                	j	1b4a <stpncpy+0xd6>
    1c7e:	4689                	li	a3,2
    1c80:	b55d                	j	1b26 <stpncpy+0xb2>
    1c82:	4691                	li	a3,4
    1c84:	b54d                	j	1b26 <stpncpy+0xb2>
    1c86:	4695                	li	a3,5
    1c88:	bd79                	j	1b26 <stpncpy+0xb2>
    1c8a:	4699                	li	a3,6
    1c8c:	bd69                	j	1b26 <stpncpy+0xb2>
    1c8e:	8082                	ret
    1c90:	8082                	ret
    1c92:	8082                	ret

0000000000001c94 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1c94:	fff6071b          	addiw	a4,a2,-1
    1c98:	0cb57063          	bgeu	a0,a1,1d58 <memmove+0xc4>
        while (n-- > 0)
    1c9c:	0ec05063          	blez	a2,1d7c <memmove+0xe8>
    1ca0:	00750693          	addi	a3,a0,7
    1ca4:	8e8d                	sub	a3,a3,a1
    1ca6:	00b567b3          	or	a5,a0,a1
    1caa:	00f6b693          	sltiu	a3,a3,15
    1cae:	8b9d                	andi	a5,a5,7
    1cb0:	0016c693          	xori	a3,a3,1
    1cb4:	0017b793          	seqz	a5,a5
    1cb8:	8ff5                	and	a5,a5,a3
    1cba:	c3f1                	beqz	a5,1d7e <memmove+0xea>
    1cbc:	0007079b          	sext.w	a5,a4
    1cc0:	46a5                	li	a3,9
    1cc2:	0af6fe63          	bgeu	a3,a5,1d7e <memmove+0xea>
    1cc6:	0036589b          	srliw	a7,a2,0x3
    1cca:	088e                	slli	a7,a7,0x3
    1ccc:	2601                	sext.w	a2,a2
    1cce:	87ae                	mv	a5,a1
    1cd0:	86aa                	mv	a3,a0
    1cd2:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1cd4:	0007b803          	ld	a6,0(a5)
    1cd8:	07a1                	addi	a5,a5,8
    1cda:	06a1                	addi	a3,a3,8
    1cdc:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1ce0:	ff179ae3          	bne	a5,a7,1cd4 <memmove+0x40>
    1ce4:	ff867813          	andi	a6,a2,-8
    1ce8:	02081793          	slli	a5,a6,0x20
    1cec:	9381                	srli	a5,a5,0x20
    1cee:	00f506b3          	add	a3,a0,a5
    1cf2:	95be                	add	a1,a1,a5
    1cf4:	4107073b          	subw	a4,a4,a6
    1cf8:	09060263          	beq	a2,a6,1d7c <memmove+0xe8>
            *dst++ = *src++;
    1cfc:	0005c783          	lbu	a5,0(a1)
    1d00:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1d04:	06e05c63          	blez	a4,1d7c <memmove+0xe8>
            *dst++ = *src++;
    1d08:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1d0c:	4785                	li	a5,1
            *dst++ = *src++;
    1d0e:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1d12:	06e7d563          	bge	a5,a4,1d7c <memmove+0xe8>
            *dst++ = *src++;
    1d16:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1d1a:	4789                	li	a5,2
            *dst++ = *src++;
    1d1c:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1d20:	04e7de63          	bge	a5,a4,1d7c <memmove+0xe8>
            *dst++ = *src++;
    1d24:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1d28:	478d                	li	a5,3
            *dst++ = *src++;
    1d2a:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1d2e:	04e7d763          	bge	a5,a4,1d7c <memmove+0xe8>
            *dst++ = *src++;
    1d32:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1d36:	4791                	li	a5,4
            *dst++ = *src++;
    1d38:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1d3c:	04e7d063          	bge	a5,a4,1d7c <memmove+0xe8>
            *dst++ = *src++;
    1d40:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1d44:	4795                	li	a5,5
            *dst++ = *src++;
    1d46:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1d4a:	02e7d963          	bge	a5,a4,1d7c <memmove+0xe8>
            *dst++ = *src++;
    1d4e:	0065c783          	lbu	a5,6(a1)
    1d52:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1d56:	8082                	ret
    } else {
        dst += n;
    1d58:	00c507b3          	add	a5,a0,a2
        src += n;
    1d5c:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1d5e:	00c05f63          	blez	a2,1d7c <memmove+0xe8>
    1d62:	1702                	slli	a4,a4,0x20
    1d64:	9301                	srli	a4,a4,0x20
    1d66:	fff74713          	not	a4,a4
    1d6a:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1d6c:	fff5c683          	lbu	a3,-1(a1)
    1d70:	17fd                	addi	a5,a5,-1
    1d72:	15fd                	addi	a1,a1,-1
    1d74:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1d78:	fee79ae3          	bne	a5,a4,1d6c <memmove+0xd8>
    }
    return vdst;
}
    1d7c:	8082                	ret
    1d7e:	02071693          	slli	a3,a4,0x20
    1d82:	9281                	srli	a3,a3,0x20
    1d84:	0685                	addi	a3,a3,1
    1d86:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1d88:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1d8a:	0005c703          	lbu	a4,0(a1)
    1d8e:	0585                	addi	a1,a1,1
    1d90:	0785                	addi	a5,a5,1
    1d92:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1d96:	fed59ae3          	bne	a1,a3,1d8a <memmove+0xf6>
    1d9a:	8082                	ret
