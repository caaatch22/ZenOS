
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_mkdir:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a06d                	j	10aa <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <stdlib.h>
#include <ucore.h>
#include <string.h>

int main(int argc, char *argv[])
{
    1002:	1141                	addi	sp,sp,-16
    int err;

    err = mkdir("tmp_dir1");
    1004:	00001517          	auipc	a0,0x1
    1008:	dec50513          	addi	a0,a0,-532 # 1df0 <memmove+0x10a>
{
    100c:	e406                	sd	ra,8(sp)
    err = mkdir("tmp_dir1");
    100e:	18c000ef          	jal	ra,119a <mkdir>
    assert(err==0, -1);
    1012:	55fd                	li	a1,-1
    1014:	00153513          	seqz	a0,a0
    1018:	0e0000ef          	jal	ra,10f8 <assert>

    err = mkdir("tmp_dir2");
    101c:	00001517          	auipc	a0,0x1
    1020:	de450513          	addi	a0,a0,-540 # 1e00 <memmove+0x11a>
    1024:	176000ef          	jal	ra,119a <mkdir>
    assert(err==0, -2);
    1028:	55f9                	li	a1,-2
    102a:	00153513          	seqz	a0,a0
    102e:	0ca000ef          	jal	ra,10f8 <assert>

    err = mkdir("tmp_dir3");
    1032:	00001517          	auipc	a0,0x1
    1036:	dde50513          	addi	a0,a0,-546 # 1e10 <memmove+0x12a>
    103a:	160000ef          	jal	ra,119a <mkdir>
    assert(err==0, -3);
    103e:	55f5                	li	a1,-3
    1040:	00153513          	seqz	a0,a0
    1044:	0b4000ef          	jal	ra,10f8 <assert>

    err = mkdir("tmp_dir3");    // existing
    1048:	00001517          	auipc	a0,0x1
    104c:	dc850513          	addi	a0,a0,-568 # 1e10 <memmove+0x12a>
    1050:	14a000ef          	jal	ra,119a <mkdir>
    assert(err==-1, -4);
    1054:	0505                	addi	a0,a0,1
    1056:	55f1                	li	a1,-4
    1058:	00153513          	seqz	a0,a0
    105c:	09c000ef          	jal	ra,10f8 <assert>

    err = mkdir("/tmp_dir4");   // absolute
    1060:	00001517          	auipc	a0,0x1
    1064:	dc050513          	addi	a0,a0,-576 # 1e20 <memmove+0x13a>
    1068:	132000ef          	jal	ra,119a <mkdir>
    assert(err==0, -5);
    106c:	55ed                	li	a1,-5
    106e:	00153513          	seqz	a0,a0
    1072:	086000ef          	jal	ra,10f8 <assert>

    err = mkdir("/tmp_dir1/tmp_dir_n1");   // nested
    1076:	00001517          	auipc	a0,0x1
    107a:	dba50513          	addi	a0,a0,-582 # 1e30 <memmove+0x14a>
    107e:	11c000ef          	jal	ra,119a <mkdir>
    assert(err==0, -6);
    1082:	55e9                	li	a1,-6
    1084:	00153513          	seqz	a0,a0
    1088:	070000ef          	jal	ra,10f8 <assert>

    err = mkdir("tmp_dir2/tmp_dir_n2");   // nested
    108c:	00001517          	auipc	a0,0x1
    1090:	dbc50513          	addi	a0,a0,-580 # 1e48 <memmove+0x162>
    1094:	106000ef          	jal	ra,119a <mkdir>
    assert(err==0, -7);
    1098:	00153513          	seqz	a0,a0
    109c:	55e5                	li	a1,-7
    109e:	05a000ef          	jal	ra,10f8 <assert>

    return 0;
    10a2:	60a2                	ld	ra,8(sp)
    10a4:	4501                	li	a0,0
    10a6:	0141                	addi	sp,sp,16
    10a8:	8082                	ret

00000000000010aa <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    10aa:	1141                	addi	sp,sp,-16
    10ac:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    10ae:	f55ff0ef          	jal	ra,1002 <main>
}
    10b2:	60a2                	ld	ra,8(sp)
    10b4:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    10b6:	a095                	j	111a <exit>

00000000000010b8 <srand>:
#include <ucore.h>

static uint64 seed;

void srand(unsigned s) {
    seed = s - 1;
    10b8:	357d                	addiw	a0,a0,-1
    10ba:	1502                	slli	a0,a0,0x20
    10bc:	9101                	srli	a0,a0,0x20
    10be:	00001797          	auipc	a5,0x1
    10c2:	dca7b523          	sd	a0,-566(a5) # 1e88 <seed>
}
    10c6:	8082                	ret

00000000000010c8 <rand>:

int rand(void) {
    seed = 6364136223846793005ULL * seed + 1;
    10c8:	00001797          	auipc	a5,0x1
    10cc:	dc078793          	addi	a5,a5,-576 # 1e88 <seed>
    10d0:	6388                	ld	a0,0(a5)
    10d2:	00001717          	auipc	a4,0x1
    10d6:	d9673703          	ld	a4,-618(a4) # 1e68 <memmove+0x182>
    10da:	02e50533          	mul	a0,a0,a4
    10de:	0505                	addi	a0,a0,1
    10e0:	e388                	sd	a0,0(a5)
    return seed >> 33;
}
    10e2:	9105                	srli	a0,a0,0x21
    10e4:	8082                	ret

00000000000010e6 <panic>:

void panic(char* m) {
    10e6:	1141                	addi	sp,sp,-16
    10e8:	e406                	sd	ra,8(sp)
    puts(m);
    10ea:	1e0000ef          	jal	ra,12ca <puts>
    exit(-100);
}
    10ee:	60a2                	ld	ra,8(sp)
    exit(-100);
    10f0:	f9c00513          	li	a0,-100
}
    10f4:	0141                	addi	sp,sp,16
    exit(-100);
    10f6:	a015                	j	111a <exit>

00000000000010f8 <assert>:

void assert(int f, int code) {
    if(!f) {
    10f8:	c111                	beqz	a0,10fc <assert+0x4>
        exit(code);
    }
    10fa:	8082                	ret
        exit(code);
    10fc:	852e                	mv	a0,a1
    10fe:	a831                	j	111a <exit>

0000000000001100 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1100:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1104:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1108:	2501                	sext.w	a0,a0
    110a:	8082                	ret

000000000000110c <exec>:
    register long a7 __asm__("a7") = n;
    110c:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1110:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1112:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1116:	2501                	sext.w	a0,a0
    1118:	8082                	ret

000000000000111a <exit>:
    register long a7 __asm__("a7") = n;
    111a:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    111e:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1122:	8082                	ret

0000000000001124 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1124:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1128:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    112c:	8082                	ret

000000000000112e <write>:
    register long a7 __asm__("a7") = n;
    112e:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1132:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1136:	8082                	ret

0000000000001138 <getpid>:
    register long a7 __asm__("a7") = n;
    1138:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    113c:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1140:	2501                	sext.w	a0,a0
    1142:	8082                	ret

0000000000001144 <getppid>:
    register long a7 __asm__("a7") = n;
    1144:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1148:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    114c:	2501                	sext.w	a0,a0
    114e:	8082                	ret

0000000000001150 <open>:
    register long a7 __asm__("a7") = n;
    1150:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1154:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1158:	2501                	sext.w	a0,a0
    115a:	8082                	ret

000000000000115c <mknod>:
    register long a7 __asm__("a7") = n;
    115c:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1160:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1164:	2501                	sext.w	a0,a0
    1166:	8082                	ret

0000000000001168 <dup>:
    register long a7 __asm__("a7") = n;
    1168:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    116a:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    116e:	2501                	sext.w	a0,a0
    1170:	8082                	ret

0000000000001172 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1172:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1176:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    117a:	2501                	sext.w	a0,a0
    117c:	8082                	ret

000000000000117e <waitpid>:
    register long a7 __asm__("a7") = n;
    117e:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1182:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1186:	2501                	sext.w	a0,a0
    1188:	8082                	ret

000000000000118a <wait>:

pid_t wait(int *wstatus)
{
    118a:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    118c:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1190:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1192:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1196:	2501                	sext.w	a0,a0
    1198:	8082                	ret

000000000000119a <mkdir>:
    register long a7 __asm__("a7") = n;
    119a:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    119e:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    11a2:	2501                	sext.w	a0,a0
    11a4:	8082                	ret

00000000000011a6 <close>:
    register long a7 __asm__("a7") = n;
    11a6:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    11aa:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    11ae:	2501                	sext.w	a0,a0
    11b0:	8082                	ret

00000000000011b2 <fork>:
    register long a7 __asm__("a7") = n;
    11b2:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    11b6:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    11ba:	2501                	sext.w	a0,a0
    11bc:	8082                	ret

00000000000011be <time_ms>:
    register long a7 __asm__("a7") = n;
    11be:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    11c2:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    11c6:	8082                	ret

00000000000011c8 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    11c8:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    11ca:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    11ce:	00000073          	ecall
    11d2:	87aa                	mv	a5,a0
    11d4:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    11d8:	97ba                	add	a5,a5,a4
    11da:	00f57c63          	bgeu	a0,a5,11f2 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    11de:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    11e2:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    11e6:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    11ea:	00000073          	ecall
    11ee:	fef568e3          	bltu	a0,a5,11de <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    11f2:	4501                	li	a0,0
    11f4:	8082                	ret

00000000000011f6 <pipe>:
    register long a7 __asm__("a7") = n;
    11f6:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    11fa:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    11fe:	2501                	sext.w	a0,a0
    1200:	8082                	ret

0000000000001202 <fstat>:
    register long a7 __asm__("a7") = n;
    1202:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1206:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    120a:	2501                	sext.w	a0,a0
    120c:	8082                	ret

000000000000120e <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    120e:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1210:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1214:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1216:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    121a:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    121e:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1222:	0206c163          	bltz	a3,1244 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1226:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    122a:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    122c:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    122e:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1232:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1236:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    123a:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    123c:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1240:	853e                	mv	a0,a5
    1242:	8082                	ret
        return -1;
    1244:	57fd                	li	a5,-1
    1246:	bfed                	j	1240 <stat+0x32>

0000000000001248 <chdir>:
    register long a7 __asm__("a7") = n;
    1248:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    124c:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1250:	2501                	sext.w	a0,a0
    1252:	8082                	ret

0000000000001254 <link>:
    register long a7 __asm__("a7") = n;
    1254:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1258:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    125c:	2501                	sext.w	a0,a0
    125e:	8082                	ret

0000000000001260 <unlink>:
    register long a7 __asm__("a7") = n;
    1260:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1264:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1268:	2501                	sext.w	a0,a0
    126a:	8082                	ret

000000000000126c <setpriority>:
    register long a7 __asm__("a7") = n;
    126c:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1270:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1274:	8082                	ret

0000000000001276 <getpriority>:
    register long a7 __asm__("a7") = n;
    1276:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    127a:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    127e:	8082                	ret

0000000000001280 <sharedmem>:
    register long a7 __asm__("a7") = n;
    1280:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1284:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1288:	8082                	ret

000000000000128a <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    128a:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    128c:	00f10593          	addi	a1,sp,15
    1290:	4605                	li	a2,1
    1292:	4501                	li	a0,0
int getchar() {
    1294:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1296:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    129a:	e8bff0ef          	jal	ra,1124 <read>
    return byte;
}
    129e:	60e2                	ld	ra,24(sp)
    12a0:	00f14503          	lbu	a0,15(sp)
    12a4:	6105                	addi	sp,sp,32
    12a6:	8082                	ret

00000000000012a8 <putchar>:

int putchar(int c)
{
    12a8:	1141                	addi	sp,sp,-16
    12aa:	e406                	sd	ra,8(sp)
    12ac:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    12ae:	00001597          	auipc	a1,0x1
    12b2:	be258593          	addi	a1,a1,-1054 # 1e90 <put.1156>
    return write(stdout, put, 1);
    12b6:	4605                	li	a2,1
    12b8:	4505                	li	a0,1
    put[0] = c;
    12ba:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    12be:	e71ff0ef          	jal	ra,112e <write>
}
    12c2:	60a2                	ld	ra,8(sp)
    12c4:	2501                	sext.w	a0,a0
    12c6:	0141                	addi	sp,sp,16
    12c8:	8082                	ret

00000000000012ca <puts>:

int puts(const char* s)
{
    12ca:	1141                	addi	sp,sp,-16
    12cc:	e022                	sd	s0,0(sp)
    12ce:	e406                	sd	ra,8(sp)
    12d0:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    12d2:	66e000ef          	jal	ra,1940 <strlen>
    12d6:	862a                	mv	a2,a0
    12d8:	85a2                	mv	a1,s0
    12da:	4505                	li	a0,1
    12dc:	e53ff0ef          	jal	ra,112e <write>
    12e0:	00055763          	bgez	a0,12ee <puts+0x24>
    return r;
}
    12e4:	60a2                	ld	ra,8(sp)
    12e6:	6402                	ld	s0,0(sp)
    12e8:	557d                	li	a0,-1
    12ea:	0141                	addi	sp,sp,16
    12ec:	8082                	ret
    put[0] = c;
    12ee:	00001597          	auipc	a1,0x1
    12f2:	ba258593          	addi	a1,a1,-1118 # 1e90 <put.1156>
    12f6:	47a9                	li	a5,10
    return write(stdout, put, 1);
    12f8:	4605                	li	a2,1
    12fa:	4505                	li	a0,1
    put[0] = c;
    12fc:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1300:	e2fff0ef          	jal	ra,112e <write>
}
    1304:	60a2                	ld	ra,8(sp)
    1306:	6402                	ld	s0,0(sp)
    1308:	41f5551b          	sraiw	a0,a0,0x1f
    130c:	0141                	addi	sp,sp,16
    130e:	8082                	ret

0000000000001310 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    1310:	7115                	addi	sp,sp,-224
    1312:	ed06                	sd	ra,152(sp)
    1314:	e922                	sd	s0,144(sp)
    1316:	e526                	sd	s1,136(sp)
    1318:	e14a                	sd	s2,128(sp)
    131a:	fcce                	sd	s3,120(sp)
    131c:	f8d2                	sd	s4,112(sp)
    131e:	f4d6                	sd	s5,104(sp)
    1320:	f0da                	sd	s6,96(sp)
    1322:	ecde                	sd	s7,88(sp)
    1324:	e8e2                	sd	s8,80(sp)
    1326:	e4e6                	sd	s9,72(sp)
    1328:	e0ea                	sd	s10,64(sp)
    132a:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    132c:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    1330:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    1332:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    1334:	f52e                	sd	a1,168(sp)
    1336:	f932                	sd	a2,176(sp)
    1338:	fd36                	sd	a3,184(sp)
    133a:	e1ba                	sd	a4,192(sp)
    133c:	e9c2                	sd	a6,208(sp)
    133e:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    1340:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1342:	0c030b63          	beqz	t1,1418 <printf+0x108>
    1346:	8aaa                	mv	s5,a0
    1348:	0003071b          	sext.w	a4,t1
    134c:	4481                	li	s1,0
        if (c != '%') {
    134e:	02500b93          	li	s7,37
    put[0] = c;
    1352:	00001417          	auipc	s0,0x1
    1356:	b3e40413          	addi	s0,s0,-1218 # 1e90 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    135a:	4c51                	li	s8,20
    put[0] = c;
    135c:	02500c93          	li	s9,37
    1360:	00001a17          	auipc	s4,0x1
    1364:	b38a0a13          	addi	s4,s4,-1224 # 1e98 <put.1156+0x8>
    1368:	00001997          	auipc	s3,0x1
    136c:	b8898993          	addi	s3,s3,-1144 # 1ef0 <digits>
    1370:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    1374:	0014879b          	addiw	a5,s1,1
    1378:	00fa8933          	add	s2,s5,a5
    137c:	13771163          	bne	a4,s7,149e <printf+0x18e>
        c = fmt[++i] & 0xff;
    1380:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    1384:	080d0a63          	beqz	s10,1418 <printf+0x108>
        switch (c) {
    1388:	2489                	addiw	s1,s1,2
    138a:	009a8933          	add	s2,s5,s1
    138e:	257d0e63          	beq	s10,s7,15ea <printf+0x2da>
    1392:	f9cd079b          	addiw	a5,s10,-100
    1396:	0ff7f793          	andi	a5,a5,255
    139a:	0cfc6263          	bltu	s8,a5,145e <printf+0x14e>
    139e:	078a                	slli	a5,a5,0x2
    13a0:	97d2                	add	a5,a5,s4
    13a2:	439c                	lw	a5,0(a5)
    13a4:	97d2                	add	a5,a5,s4
    13a6:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    13a8:	67a2                	ld	a5,8(sp)
    13aa:	4398                	lw	a4,0(a5)
    13ac:	07a1                	addi	a5,a5,8
    13ae:	e43e                	sd	a5,8(sp)
    13b0:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    13b4:	26074663          	bltz	a4,1620 <printf+0x310>
        buf[i++] = digits[x % base];
    13b8:	8bbd                	andi	a5,a5,15
    13ba:	97ce                	add	a5,a5,s3
    13bc:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    13c0:	40475d1b          	sraiw	s10,a4,0x4
    13c4:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    13c8:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    13cc:	020d0163          	beqz	s10,13ee <printf+0xde>
        buf[i++] = digits[x % base];
    13d0:	9d4e                	add	s10,s10,s3
    13d2:	000d4783          	lbu	a5,0(s10)
    13d6:	4d05                	li	s10,1
    13d8:	00f108a3          	sb	a5,17(sp)
    if (sign)
    13dc:	00075963          	bgez	a4,13ee <printf+0xde>
        buf[i++] = digits[x % base];
    13e0:	4d09                	li	s10,2
        buf[i++] = '-';
    13e2:	181c                	addi	a5,sp,48
    13e4:	02d00713          	li	a4,45
    13e8:	97ea                	add	a5,a5,s10
    13ea:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    13ee:	9d5a                	add	s10,s10,s6
    13f0:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    13f4:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    13f8:	4605                	li	a2,1
    13fa:	1d7d                	addi	s10,s10,-1
    13fc:	85a2                	mv	a1,s0
    13fe:	4505                	li	a0,1
    put[0] = c;
    1400:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1404:	d2bff0ef          	jal	ra,112e <write>
    while (--i >= 0)
    1408:	ffbd16e3          	bne	s10,s11,13f4 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    140c:	00094303          	lbu	t1,0(s2)
    1410:	0003071b          	sext.w	a4,t1
    1414:	f60310e3          	bnez	t1,1374 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    1418:	60ea                	ld	ra,152(sp)
    141a:	644a                	ld	s0,144(sp)
    141c:	64aa                	ld	s1,136(sp)
    141e:	690a                	ld	s2,128(sp)
    1420:	79e6                	ld	s3,120(sp)
    1422:	7a46                	ld	s4,112(sp)
    1424:	7aa6                	ld	s5,104(sp)
    1426:	7b06                	ld	s6,96(sp)
    1428:	6be6                	ld	s7,88(sp)
    142a:	6c46                	ld	s8,80(sp)
    142c:	6ca6                	ld	s9,72(sp)
    142e:	6d06                	ld	s10,64(sp)
    1430:	7de2                	ld	s11,56(sp)
    1432:	612d                	addi	sp,sp,224
    1434:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    1436:	67a2                	ld	a5,8(sp)
    1438:	0007bd03          	ld	s10,0(a5)
    143c:	07a1                	addi	a5,a5,8
    143e:	e43e                	sd	a5,8(sp)
    1440:	000d1b63          	bnez	s10,1456 <printf+0x146>
    1444:	aafd                	j	1642 <printf+0x332>
    return write(stdout, put, 1);
    1446:	4605                	li	a2,1
    1448:	85a2                	mv	a1,s0
    144a:	4505                	li	a0,1
                for (; *s; s++)
    144c:	0d05                	addi	s10,s10,1
    put[0] = c;
    144e:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1452:	cddff0ef          	jal	ra,112e <write>
                for (; *s; s++)
    1456:	000d4783          	lbu	a5,0(s10)
    145a:	f7f5                	bnez	a5,1446 <printf+0x136>
    145c:	a02d                	j	1486 <printf+0x176>
    return write(stdout, put, 1);
    145e:	4605                	li	a2,1
    1460:	00001597          	auipc	a1,0x1
    1464:	a3058593          	addi	a1,a1,-1488 # 1e90 <put.1156>
    1468:	4505                	li	a0,1
    put[0] = c;
    146a:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    146e:	cc1ff0ef          	jal	ra,112e <write>
    1472:	4605                	li	a2,1
    1474:	00001597          	auipc	a1,0x1
    1478:	a1c58593          	addi	a1,a1,-1508 # 1e90 <put.1156>
    147c:	4505                	li	a0,1
    put[0] = c;
    147e:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    1482:	cadff0ef          	jal	ra,112e <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1486:	00094303          	lbu	t1,0(s2)
    148a:	0003071b          	sext.w	a4,t1
    148e:	f80305e3          	beqz	t1,1418 <printf+0x108>
        if (c != '%') {
    1492:	0014879b          	addiw	a5,s1,1
    1496:	00fa8933          	add	s2,s5,a5
    149a:	ef7703e3          	beq	a4,s7,1380 <printf+0x70>
    return write(stdout, put, 1);
    149e:	4605                	li	a2,1
    14a0:	00001597          	auipc	a1,0x1
    14a4:	9f058593          	addi	a1,a1,-1552 # 1e90 <put.1156>
    14a8:	4505                	li	a0,1
    put[0] = c;
    14aa:	00640023          	sb	t1,0(s0)
            continue;
    14ae:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    14b0:	c7fff0ef          	jal	ra,112e <write>
            continue;
    14b4:	bfc9                	j	1486 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    14b6:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    14b8:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    14ba:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    14bc:	0007b883          	ld	a7,0(a5)
    14c0:	07a1                	addi	a5,a5,8
    14c2:	e43e                	sd	a5,8(sp)
        x = -xx;
    14c4:	43f8d713          	srai	a4,a7,0x3f
    14c8:	011747b3          	xor	a5,a4,a7
    14cc:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    14ce:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    14d0:	02c7f733          	remu	a4,a5,a2
    14d4:	8d36                	mv	s10,a3
    14d6:	0685                	addi	a3,a3,1
    14d8:	00db0533          	add	a0,s6,a3
    14dc:	85be                	mv	a1,a5
    14de:	974e                	add	a4,a4,s3
    14e0:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    14e4:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    14e8:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    14ec:	feb862e3          	bltu	a6,a1,14d0 <printf+0x1c0>
    if (sign)
    14f0:	1208c063          	bltz	a7,1610 <printf+0x300>
    while (--i >= 0)
    14f4:	9d5a                	add	s10,s10,s6
    put[0] = c;
    14f6:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    14fa:	4605                	li	a2,1
    14fc:	85a2                	mv	a1,s0
    14fe:	4505                	li	a0,1
    put[0] = c;
    1500:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1504:	c2bff0ef          	jal	ra,112e <write>
    while (--i >= 0)
    1508:	87ea                	mv	a5,s10
    150a:	1d7d                	addi	s10,s10,-1
    150c:	fefb15e3          	bne	s6,a5,14f6 <printf+0x1e6>
    1510:	bf9d                	j	1486 <printf+0x176>
                printptr(va_arg(ap, uint64));
    1512:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    1514:	4605                	li	a2,1
    1516:	00001597          	auipc	a1,0x1
    151a:	97a58593          	addi	a1,a1,-1670 # 1e90 <put.1156>
                printptr(va_arg(ap, uint64));
    151e:	0007bd83          	ld	s11,0(a5)
    1522:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    1526:	4505                	li	a0,1
    put[0] = c;
    1528:	03000793          	li	a5,48
    152c:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    1530:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    1532:	bfdff0ef          	jal	ra,112e <write>
    put[0] = c;
    1536:	07800793          	li	a5,120
    return write(stdout, put, 1);
    153a:	4605                	li	a2,1
    153c:	00001597          	auipc	a1,0x1
    1540:	95458593          	addi	a1,a1,-1708 # 1e90 <put.1156>
    1544:	4505                	li	a0,1
    put[0] = c;
    1546:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    154a:	4d41                	li	s10,16
    154c:	be3ff0ef          	jal	ra,112e <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    1550:	03cdd793          	srli	a5,s11,0x3c
    1554:	97ce                	add	a5,a5,s3
    put[0] = c;
    1556:	0007c783          	lbu	a5,0(a5)
    155a:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    155c:	4605                	li	a2,1
    155e:	85a2                	mv	a1,s0
    1560:	4505                	li	a0,1
    put[0] = c;
    1562:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1566:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1568:	bc7ff0ef          	jal	ra,112e <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    156c:	fe0d12e3          	bnez	s10,1550 <printf+0x240>
    1570:	bf19                	j	1486 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    1572:	67a2                	ld	a5,8(sp)
    1574:	4394                	lw	a3,0(a5)
    1576:	07a1                	addi	a5,a5,8
    1578:	e43e                	sd	a5,8(sp)
    157a:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    157e:	0006d663          	bgez	a3,158a <printf+0x27a>
        x = -xx;
    1582:	40f007bb          	negw	a5,a5
    1586:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    158a:	4729                	li	a4,10
    158c:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    1590:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    1594:	964e                	add	a2,a2,s3
    1596:	00064603          	lbu	a2,0(a2)
    159a:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    159e:	0a0d0963          	beqz	s10,1650 <printf+0x340>
        buf[i++] = digits[x % base];
    15a2:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    15a6:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    15aa:	00c98733          	add	a4,s3,a2
    15ae:	00074703          	lbu	a4,0(a4)
    15b2:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    15b6:	c3cd                	beqz	a5,1658 <printf+0x348>
        buf[i++] = digits[x % base];
    15b8:	97ce                	add	a5,a5,s3
    15ba:	0007c703          	lbu	a4,0(a5)
    15be:	4d09                	li	s10,2
    15c0:	478d                	li	a5,3
    15c2:	00e10923          	sb	a4,18(sp)
    if (sign)
    15c6:	0206cd63          	bltz	a3,1600 <printf+0x2f0>
    while (--i >= 0)
    15ca:	9d5a                	add	s10,s10,s6
    15cc:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    15d0:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    15d4:	4605                	li	a2,1
    15d6:	1d7d                	addi	s10,s10,-1
    15d8:	85a2                	mv	a1,s0
    15da:	4505                	li	a0,1
    put[0] = c;
    15dc:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    15e0:	b4fff0ef          	jal	ra,112e <write>
    while (--i >= 0)
    15e4:	ffbd16e3          	bne	s10,s11,15d0 <printf+0x2c0>
    15e8:	bd79                	j	1486 <printf+0x176>
    return write(stdout, put, 1);
    15ea:	4605                	li	a2,1
    15ec:	00001597          	auipc	a1,0x1
    15f0:	8a458593          	addi	a1,a1,-1884 # 1e90 <put.1156>
    15f4:	4505                	li	a0,1
    put[0] = c;
    15f6:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    15fa:	b35ff0ef          	jal	ra,112e <write>
    15fe:	b561                	j	1486 <printf+0x176>
        buf[i++] = '-';
    1600:	1818                	addi	a4,sp,48
    1602:	973e                	add	a4,a4,a5
    1604:	02d00693          	li	a3,45
    1608:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    160c:	8d3e                	mv	s10,a5
    160e:	bf75                	j	15ca <printf+0x2ba>
        buf[i++] = '-';
    1610:	181c                	addi	a5,sp,48
    1612:	97b6                	add	a5,a5,a3
    1614:	02d00713          	li	a4,45
    1618:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    161c:	8d36                	mv	s10,a3
    161e:	bdd9                	j	14f4 <printf+0x1e4>
        x = -xx;
    1620:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    1624:	00f7f693          	andi	a3,a5,15
    1628:	96ce                	add	a3,a3,s3
    162a:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    162e:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    1632:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    1636:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    163a:	d80d1be3          	bnez	s10,13d0 <printf+0xc0>
        buf[i++] = digits[x % base];
    163e:	4d05                	li	s10,1
    1640:	b34d                	j	13e2 <printf+0xd2>
                s = "(null)";
    1642:	00001d17          	auipc	s10,0x1
    1646:	81ed0d13          	addi	s10,s10,-2018 # 1e60 <memmove+0x17a>
                for (; *s; s++)
    164a:	02800793          	li	a5,40
    164e:	bbe5                	j	1446 <printf+0x136>
        buf[i++] = digits[x % base];
    1650:	4785                	li	a5,1
    if (sign)
    1652:	f606dce3          	bgez	a3,15ca <printf+0x2ba>
    1656:	b76d                	j	1600 <printf+0x2f0>
        buf[i++] = digits[x % base];
    1658:	4789                	li	a5,2
    165a:	4d05                	li	s10,1
    if (sign)
    165c:	f606d7e3          	bgez	a3,15ca <printf+0x2ba>
    1660:	b745                	j	1600 <printf+0x2f0>

0000000000001662 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1662:	02000793          	li	a5,32
    1666:	00f50663          	beq	a0,a5,1672 <isspace+0x10>
    166a:	355d                	addiw	a0,a0,-9
    166c:	00553513          	sltiu	a0,a0,5
    1670:	8082                	ret
    1672:	4505                	li	a0,1
}
    1674:	8082                	ret

0000000000001676 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1676:	fd05051b          	addiw	a0,a0,-48
}
    167a:	00a53513          	sltiu	a0,a0,10
    167e:	8082                	ret

0000000000001680 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1680:	02000613          	li	a2,32
    1684:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1686:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    168a:	ff77069b          	addiw	a3,a4,-9
    168e:	04c70d63          	beq	a4,a2,16e8 <atoi+0x68>
    1692:	0007079b          	sext.w	a5,a4
    1696:	04d5f963          	bgeu	a1,a3,16e8 <atoi+0x68>
        s++;
    switch (*s) {
    169a:	02b00693          	li	a3,43
    169e:	04d70a63          	beq	a4,a3,16f2 <atoi+0x72>
    16a2:	02d00693          	li	a3,45
    16a6:	06d70463          	beq	a4,a3,170e <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    16aa:	fd07859b          	addiw	a1,a5,-48
    16ae:	4625                	li	a2,9
    16b0:	873e                	mv	a4,a5
    16b2:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    16b4:	4e01                	li	t3,0
    while (isdigit(*s))
    16b6:	04b66a63          	bltu	a2,a1,170a <atoi+0x8a>
    int n = 0, neg = 0;
    16ba:	4501                	li	a0,0
    while (isdigit(*s))
    16bc:	4825                	li	a6,9
    16be:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    16c2:	0025179b          	slliw	a5,a0,0x2
    16c6:	9d3d                	addw	a0,a0,a5
    16c8:	fd07031b          	addiw	t1,a4,-48
    16cc:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    16d0:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    16d4:	0685                	addi	a3,a3,1
    16d6:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    16da:	0006071b          	sext.w	a4,a2
    16de:	feb870e3          	bgeu	a6,a1,16be <atoi+0x3e>
    return neg ? n : -n;
    16e2:	000e0563          	beqz	t3,16ec <atoi+0x6c>
}
    16e6:	8082                	ret
        s++;
    16e8:	0505                	addi	a0,a0,1
    16ea:	bf71                	j	1686 <atoi+0x6>
    16ec:	4113053b          	subw	a0,t1,a7
    16f0:	8082                	ret
    while (isdigit(*s))
    16f2:	00154783          	lbu	a5,1(a0)
    16f6:	4625                	li	a2,9
        s++;
    16f8:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16fc:	fd07859b          	addiw	a1,a5,-48
    1700:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1704:	4e01                	li	t3,0
    while (isdigit(*s))
    1706:	fab67ae3          	bgeu	a2,a1,16ba <atoi+0x3a>
    170a:	4501                	li	a0,0
}
    170c:	8082                	ret
    while (isdigit(*s))
    170e:	00154783          	lbu	a5,1(a0)
    1712:	4625                	li	a2,9
        s++;
    1714:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1718:	fd07859b          	addiw	a1,a5,-48
    171c:	0007871b          	sext.w	a4,a5
    1720:	feb665e3          	bltu	a2,a1,170a <atoi+0x8a>
        neg = 1;
    1724:	4e05                	li	t3,1
    1726:	bf51                	j	16ba <atoi+0x3a>

0000000000001728 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    1728:	16060d63          	beqz	a2,18a2 <memset+0x17a>
    172c:	40a007b3          	neg	a5,a0
    1730:	8b9d                	andi	a5,a5,7
    1732:	00778713          	addi	a4,a5,7
    1736:	482d                	li	a6,11
    1738:	0ff5f593          	andi	a1,a1,255
    173c:	fff60693          	addi	a3,a2,-1
    1740:	17076263          	bltu	a4,a6,18a4 <memset+0x17c>
    1744:	16e6ea63          	bltu	a3,a4,18b8 <memset+0x190>
    1748:	16078563          	beqz	a5,18b2 <memset+0x18a>
    174c:	00b50023          	sb	a1,0(a0)
    1750:	4705                	li	a4,1
    1752:	00150e93          	addi	t4,a0,1
    1756:	14e78c63          	beq	a5,a4,18ae <memset+0x186>
    175a:	00b500a3          	sb	a1,1(a0)
    175e:	4709                	li	a4,2
    1760:	00250e93          	addi	t4,a0,2
    1764:	14e78d63          	beq	a5,a4,18be <memset+0x196>
    1768:	00b50123          	sb	a1,2(a0)
    176c:	470d                	li	a4,3
    176e:	00350e93          	addi	t4,a0,3
    1772:	12e78b63          	beq	a5,a4,18a8 <memset+0x180>
    1776:	00b501a3          	sb	a1,3(a0)
    177a:	4711                	li	a4,4
    177c:	00450e93          	addi	t4,a0,4
    1780:	14e78163          	beq	a5,a4,18c2 <memset+0x19a>
    1784:	00b50223          	sb	a1,4(a0)
    1788:	4715                	li	a4,5
    178a:	00550e93          	addi	t4,a0,5
    178e:	12e78c63          	beq	a5,a4,18c6 <memset+0x19e>
    1792:	00b502a3          	sb	a1,5(a0)
    1796:	471d                	li	a4,7
    1798:	00650e93          	addi	t4,a0,6
    179c:	12e79763          	bne	a5,a4,18ca <memset+0x1a2>
    17a0:	00750e93          	addi	t4,a0,7
    17a4:	00b50323          	sb	a1,6(a0)
    17a8:	4f1d                	li	t5,7
    17aa:	00859713          	slli	a4,a1,0x8
    17ae:	8f4d                	or	a4,a4,a1
    17b0:	01059e13          	slli	t3,a1,0x10
    17b4:	01c76e33          	or	t3,a4,t3
    17b8:	01859313          	slli	t1,a1,0x18
    17bc:	006e6333          	or	t1,t3,t1
    17c0:	02059893          	slli	a7,a1,0x20
    17c4:	011368b3          	or	a7,t1,a7
    17c8:	02859813          	slli	a6,a1,0x28
    17cc:	40f60333          	sub	t1,a2,a5
    17d0:	0108e833          	or	a6,a7,a6
    17d4:	03059693          	slli	a3,a1,0x30
    17d8:	00d866b3          	or	a3,a6,a3
    17dc:	03859713          	slli	a4,a1,0x38
    17e0:	97aa                	add	a5,a5,a0
    17e2:	ff837813          	andi	a6,t1,-8
    17e6:	8f55                	or	a4,a4,a3
    17e8:	00f806b3          	add	a3,a6,a5
    17ec:	e398                	sd	a4,0(a5)
    17ee:	07a1                	addi	a5,a5,8
    17f0:	fed79ee3          	bne	a5,a3,17ec <memset+0xc4>
    17f4:	ff837693          	andi	a3,t1,-8
    17f8:	00de87b3          	add	a5,t4,a3
    17fc:	01e6873b          	addw	a4,a3,t5
    1800:	0ad30663          	beq	t1,a3,18ac <memset+0x184>
    1804:	00b78023          	sb	a1,0(a5)
    1808:	0017069b          	addiw	a3,a4,1
    180c:	08c6fb63          	bgeu	a3,a2,18a2 <memset+0x17a>
    1810:	00b780a3          	sb	a1,1(a5)
    1814:	0027069b          	addiw	a3,a4,2
    1818:	08c6f563          	bgeu	a3,a2,18a2 <memset+0x17a>
    181c:	00b78123          	sb	a1,2(a5)
    1820:	0037069b          	addiw	a3,a4,3
    1824:	06c6ff63          	bgeu	a3,a2,18a2 <memset+0x17a>
    1828:	00b781a3          	sb	a1,3(a5)
    182c:	0047069b          	addiw	a3,a4,4
    1830:	06c6f963          	bgeu	a3,a2,18a2 <memset+0x17a>
    1834:	00b78223          	sb	a1,4(a5)
    1838:	0057069b          	addiw	a3,a4,5
    183c:	06c6f363          	bgeu	a3,a2,18a2 <memset+0x17a>
    1840:	00b782a3          	sb	a1,5(a5)
    1844:	0067069b          	addiw	a3,a4,6
    1848:	04c6fd63          	bgeu	a3,a2,18a2 <memset+0x17a>
    184c:	00b78323          	sb	a1,6(a5)
    1850:	0077069b          	addiw	a3,a4,7
    1854:	04c6f763          	bgeu	a3,a2,18a2 <memset+0x17a>
    1858:	00b783a3          	sb	a1,7(a5)
    185c:	0087069b          	addiw	a3,a4,8
    1860:	04c6f163          	bgeu	a3,a2,18a2 <memset+0x17a>
    1864:	00b78423          	sb	a1,8(a5)
    1868:	0097069b          	addiw	a3,a4,9
    186c:	02c6fb63          	bgeu	a3,a2,18a2 <memset+0x17a>
    1870:	00b784a3          	sb	a1,9(a5)
    1874:	00a7069b          	addiw	a3,a4,10
    1878:	02c6f563          	bgeu	a3,a2,18a2 <memset+0x17a>
    187c:	00b78523          	sb	a1,10(a5)
    1880:	00b7069b          	addiw	a3,a4,11
    1884:	00c6ff63          	bgeu	a3,a2,18a2 <memset+0x17a>
    1888:	00b785a3          	sb	a1,11(a5)
    188c:	00c7069b          	addiw	a3,a4,12
    1890:	00c6f963          	bgeu	a3,a2,18a2 <memset+0x17a>
    1894:	00b78623          	sb	a1,12(a5)
    1898:	2735                	addiw	a4,a4,13
    189a:	00c77463          	bgeu	a4,a2,18a2 <memset+0x17a>
    189e:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    18a2:	8082                	ret
    18a4:	472d                	li	a4,11
    18a6:	bd79                	j	1744 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    18a8:	4f0d                	li	t5,3
    18aa:	b701                	j	17aa <memset+0x82>
    18ac:	8082                	ret
    18ae:	4f05                	li	t5,1
    18b0:	bded                	j	17aa <memset+0x82>
    18b2:	8eaa                	mv	t4,a0
    18b4:	4f01                	li	t5,0
    18b6:	bdd5                	j	17aa <memset+0x82>
    18b8:	87aa                	mv	a5,a0
    18ba:	4701                	li	a4,0
    18bc:	b7a1                	j	1804 <memset+0xdc>
    18be:	4f09                	li	t5,2
    18c0:	b5ed                	j	17aa <memset+0x82>
    18c2:	4f11                	li	t5,4
    18c4:	b5dd                	j	17aa <memset+0x82>
    18c6:	4f15                	li	t5,5
    18c8:	b5cd                	j	17aa <memset+0x82>
    18ca:	4f19                	li	t5,6
    18cc:	bdf9                	j	17aa <memset+0x82>

00000000000018ce <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    18ce:	00054783          	lbu	a5,0(a0)
    18d2:	0005c703          	lbu	a4,0(a1)
    18d6:	00e79863          	bne	a5,a4,18e6 <strcmp+0x18>
    18da:	0505                	addi	a0,a0,1
    18dc:	0585                	addi	a1,a1,1
    18de:	fbe5                	bnez	a5,18ce <strcmp>
    18e0:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    18e2:	9d19                	subw	a0,a0,a4
    18e4:	8082                	ret
    18e6:	0007851b          	sext.w	a0,a5
    18ea:	bfe5                	j	18e2 <strcmp+0x14>

00000000000018ec <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    18ec:	87aa                	mv	a5,a0
    18ee:	0005c703          	lbu	a4,0(a1)
    18f2:	0785                	addi	a5,a5,1
    18f4:	0585                	addi	a1,a1,1
    18f6:	fee78fa3          	sb	a4,-1(a5)
    18fa:	fb75                	bnez	a4,18ee <strcpy+0x2>
        ;
    return os;
}
    18fc:	8082                	ret

00000000000018fe <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    18fe:	ce05                	beqz	a2,1936 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1900:	00054703          	lbu	a4,0(a0)
    1904:	0005c783          	lbu	a5,0(a1)
    1908:	cb0d                	beqz	a4,193a <strncmp+0x3c>
    if (!n--)
    190a:	167d                	addi	a2,a2,-1
    190c:	00c506b3          	add	a3,a0,a2
    1910:	a819                	j	1926 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1912:	00a68e63          	beq	a3,a0,192e <strncmp+0x30>
    1916:	0505                	addi	a0,a0,1
    1918:	00e79b63          	bne	a5,a4,192e <strncmp+0x30>
    191c:	00054703          	lbu	a4,0(a0)
    1920:	0005c783          	lbu	a5,0(a1)
    1924:	cb19                	beqz	a4,193a <strncmp+0x3c>
    1926:	0005c783          	lbu	a5,0(a1)
    192a:	0585                	addi	a1,a1,1
    192c:	f3fd                	bnez	a5,1912 <strncmp+0x14>
        ;
    return *l - *r;
    192e:	0007051b          	sext.w	a0,a4
    1932:	9d1d                	subw	a0,a0,a5
    1934:	8082                	ret
        return 0;
    1936:	4501                	li	a0,0
}
    1938:	8082                	ret
    193a:	4501                	li	a0,0
    return *l - *r;
    193c:	9d1d                	subw	a0,a0,a5
    193e:	8082                	ret

0000000000001940 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    1940:	00757793          	andi	a5,a0,7
    1944:	cf89                	beqz	a5,195e <strlen+0x1e>
    1946:	87aa                	mv	a5,a0
    1948:	a029                	j	1952 <strlen+0x12>
    194a:	0785                	addi	a5,a5,1
    194c:	0077f713          	andi	a4,a5,7
    1950:	cb01                	beqz	a4,1960 <strlen+0x20>
        if (!*s)
    1952:	0007c703          	lbu	a4,0(a5)
    1956:	fb75                	bnez	a4,194a <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1958:	40a78533          	sub	a0,a5,a0
}
    195c:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    195e:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    1960:	6394                	ld	a3,0(a5)
    1962:	00000597          	auipc	a1,0x0
    1966:	50e5b583          	ld	a1,1294(a1) # 1e70 <memmove+0x18a>
    196a:	00000617          	auipc	a2,0x0
    196e:	50e63603          	ld	a2,1294(a2) # 1e78 <memmove+0x192>
    1972:	a019                	j	1978 <strlen+0x38>
    1974:	6794                	ld	a3,8(a5)
    1976:	07a1                	addi	a5,a5,8
    1978:	00b68733          	add	a4,a3,a1
    197c:	fff6c693          	not	a3,a3
    1980:	8f75                	and	a4,a4,a3
    1982:	8f71                	and	a4,a4,a2
    1984:	db65                	beqz	a4,1974 <strlen+0x34>
    for (; *s; s++)
    1986:	0007c703          	lbu	a4,0(a5)
    198a:	d779                	beqz	a4,1958 <strlen+0x18>
    198c:	0017c703          	lbu	a4,1(a5)
    1990:	0785                	addi	a5,a5,1
    1992:	d379                	beqz	a4,1958 <strlen+0x18>
    1994:	0017c703          	lbu	a4,1(a5)
    1998:	0785                	addi	a5,a5,1
    199a:	fb6d                	bnez	a4,198c <strlen+0x4c>
    199c:	bf75                	j	1958 <strlen+0x18>

000000000000199e <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    199e:	00757713          	andi	a4,a0,7
{
    19a2:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    19a4:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    19a8:	cb19                	beqz	a4,19be <memchr+0x20>
    19aa:	ce25                	beqz	a2,1a22 <memchr+0x84>
    19ac:	0007c703          	lbu	a4,0(a5)
    19b0:	04b70e63          	beq	a4,a1,1a0c <memchr+0x6e>
    19b4:	0785                	addi	a5,a5,1
    19b6:	0077f713          	andi	a4,a5,7
    19ba:	167d                	addi	a2,a2,-1
    19bc:	f77d                	bnez	a4,19aa <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    19be:	4501                	li	a0,0
    if (n && *s != c) {
    19c0:	c235                	beqz	a2,1a24 <memchr+0x86>
    19c2:	0007c703          	lbu	a4,0(a5)
    19c6:	04b70363          	beq	a4,a1,1a0c <memchr+0x6e>
        size_t k = ONES * c;
    19ca:	00000517          	auipc	a0,0x0
    19ce:	4b653503          	ld	a0,1206(a0) # 1e80 <memmove+0x19a>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    19d2:	471d                	li	a4,7
        size_t k = ONES * c;
    19d4:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    19d8:	02c77a63          	bgeu	a4,a2,1a0c <memchr+0x6e>
    19dc:	00000897          	auipc	a7,0x0
    19e0:	4948b883          	ld	a7,1172(a7) # 1e70 <memmove+0x18a>
    19e4:	00000817          	auipc	a6,0x0
    19e8:	49483803          	ld	a6,1172(a6) # 1e78 <memmove+0x192>
    19ec:	431d                	li	t1,7
    19ee:	a029                	j	19f8 <memchr+0x5a>
    19f0:	1661                	addi	a2,a2,-8
    19f2:	07a1                	addi	a5,a5,8
    19f4:	02c37963          	bgeu	t1,a2,1a26 <memchr+0x88>
    19f8:	6398                	ld	a4,0(a5)
    19fa:	8f29                	xor	a4,a4,a0
    19fc:	011706b3          	add	a3,a4,a7
    1a00:	fff74713          	not	a4,a4
    1a04:	8f75                	and	a4,a4,a3
    1a06:	01077733          	and	a4,a4,a6
    1a0a:	d37d                	beqz	a4,19f0 <memchr+0x52>
    1a0c:	853e                	mv	a0,a5
    1a0e:	97b2                	add	a5,a5,a2
    1a10:	a021                	j	1a18 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1a12:	0505                	addi	a0,a0,1
    1a14:	00f50763          	beq	a0,a5,1a22 <memchr+0x84>
    1a18:	00054703          	lbu	a4,0(a0)
    1a1c:	feb71be3          	bne	a4,a1,1a12 <memchr+0x74>
    1a20:	8082                	ret
    return n ? (void*)s : 0;
    1a22:	4501                	li	a0,0
}
    1a24:	8082                	ret
    return n ? (void*)s : 0;
    1a26:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1a28:	f275                	bnez	a2,1a0c <memchr+0x6e>
}
    1a2a:	8082                	ret

0000000000001a2c <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1a2c:	1101                	addi	sp,sp,-32
    1a2e:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1a30:	862e                	mv	a2,a1
{
    1a32:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1a34:	4581                	li	a1,0
{
    1a36:	e426                	sd	s1,8(sp)
    1a38:	ec06                	sd	ra,24(sp)
    1a3a:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1a3c:	f63ff0ef          	jal	ra,199e <memchr>
    return p ? p - s : n;
    1a40:	c519                	beqz	a0,1a4e <strnlen+0x22>
}
    1a42:	60e2                	ld	ra,24(sp)
    1a44:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1a46:	8d05                	sub	a0,a0,s1
}
    1a48:	64a2                	ld	s1,8(sp)
    1a4a:	6105                	addi	sp,sp,32
    1a4c:	8082                	ret
    1a4e:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1a50:	8522                	mv	a0,s0
}
    1a52:	6442                	ld	s0,16(sp)
    1a54:	64a2                	ld	s1,8(sp)
    1a56:	6105                	addi	sp,sp,32
    1a58:	8082                	ret

0000000000001a5a <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1a5a:	00b547b3          	xor	a5,a0,a1
    1a5e:	8b9d                	andi	a5,a5,7
    1a60:	eb95                	bnez	a5,1a94 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1a62:	0075f793          	andi	a5,a1,7
    1a66:	e7b1                	bnez	a5,1ab2 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a68:	6198                	ld	a4,0(a1)
    1a6a:	00000617          	auipc	a2,0x0
    1a6e:	40663603          	ld	a2,1030(a2) # 1e70 <memmove+0x18a>
    1a72:	00000817          	auipc	a6,0x0
    1a76:	40683803          	ld	a6,1030(a6) # 1e78 <memmove+0x192>
    1a7a:	a029                	j	1a84 <stpcpy+0x2a>
    1a7c:	e118                	sd	a4,0(a0)
    1a7e:	6598                	ld	a4,8(a1)
    1a80:	05a1                	addi	a1,a1,8
    1a82:	0521                	addi	a0,a0,8
    1a84:	00c707b3          	add	a5,a4,a2
    1a88:	fff74693          	not	a3,a4
    1a8c:	8ff5                	and	a5,a5,a3
    1a8e:	0107f7b3          	and	a5,a5,a6
    1a92:	d7ed                	beqz	a5,1a7c <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1a94:	0005c783          	lbu	a5,0(a1)
    1a98:	00f50023          	sb	a5,0(a0)
    1a9c:	c785                	beqz	a5,1ac4 <stpcpy+0x6a>
    1a9e:	0015c783          	lbu	a5,1(a1)
    1aa2:	0505                	addi	a0,a0,1
    1aa4:	0585                	addi	a1,a1,1
    1aa6:	00f50023          	sb	a5,0(a0)
    1aaa:	fbf5                	bnez	a5,1a9e <stpcpy+0x44>
        ;
    return d;
}
    1aac:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1aae:	0505                	addi	a0,a0,1
    1ab0:	df45                	beqz	a4,1a68 <stpcpy+0xe>
            if (!(*d = *s))
    1ab2:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1ab6:	0585                	addi	a1,a1,1
    1ab8:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1abc:	00f50023          	sb	a5,0(a0)
    1ac0:	f7fd                	bnez	a5,1aae <stpcpy+0x54>
}
    1ac2:	8082                	ret
    1ac4:	8082                	ret

0000000000001ac6 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1ac6:	00b547b3          	xor	a5,a0,a1
    1aca:	8b9d                	andi	a5,a5,7
    1acc:	1a079863          	bnez	a5,1c7c <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1ad0:	0075f793          	andi	a5,a1,7
    1ad4:	16078463          	beqz	a5,1c3c <stpncpy+0x176>
    1ad8:	ea01                	bnez	a2,1ae8 <stpncpy+0x22>
    1ada:	a421                	j	1ce2 <stpncpy+0x21c>
    1adc:	167d                	addi	a2,a2,-1
    1ade:	0505                	addi	a0,a0,1
    1ae0:	14070e63          	beqz	a4,1c3c <stpncpy+0x176>
    1ae4:	1a060863          	beqz	a2,1c94 <stpncpy+0x1ce>
    1ae8:	0005c783          	lbu	a5,0(a1)
    1aec:	0585                	addi	a1,a1,1
    1aee:	0075f713          	andi	a4,a1,7
    1af2:	00f50023          	sb	a5,0(a0)
    1af6:	f3fd                	bnez	a5,1adc <stpncpy+0x16>
    1af8:	4805                	li	a6,1
    1afa:	1a061863          	bnez	a2,1caa <stpncpy+0x1e4>
    1afe:	40a007b3          	neg	a5,a0
    1b02:	8b9d                	andi	a5,a5,7
    1b04:	4681                	li	a3,0
    1b06:	18061a63          	bnez	a2,1c9a <stpncpy+0x1d4>
    1b0a:	00778713          	addi	a4,a5,7
    1b0e:	45ad                	li	a1,11
    1b10:	18b76363          	bltu	a4,a1,1c96 <stpncpy+0x1d0>
    1b14:	1ae6eb63          	bltu	a3,a4,1cca <stpncpy+0x204>
    1b18:	1a078363          	beqz	a5,1cbe <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1b1c:	00050023          	sb	zero,0(a0)
    1b20:	4685                	li	a3,1
    1b22:	00150713          	addi	a4,a0,1
    1b26:	18d78f63          	beq	a5,a3,1cc4 <stpncpy+0x1fe>
    1b2a:	000500a3          	sb	zero,1(a0)
    1b2e:	4689                	li	a3,2
    1b30:	00250713          	addi	a4,a0,2
    1b34:	18d78e63          	beq	a5,a3,1cd0 <stpncpy+0x20a>
    1b38:	00050123          	sb	zero,2(a0)
    1b3c:	468d                	li	a3,3
    1b3e:	00350713          	addi	a4,a0,3
    1b42:	16d78c63          	beq	a5,a3,1cba <stpncpy+0x1f4>
    1b46:	000501a3          	sb	zero,3(a0)
    1b4a:	4691                	li	a3,4
    1b4c:	00450713          	addi	a4,a0,4
    1b50:	18d78263          	beq	a5,a3,1cd4 <stpncpy+0x20e>
    1b54:	00050223          	sb	zero,4(a0)
    1b58:	4695                	li	a3,5
    1b5a:	00550713          	addi	a4,a0,5
    1b5e:	16d78d63          	beq	a5,a3,1cd8 <stpncpy+0x212>
    1b62:	000502a3          	sb	zero,5(a0)
    1b66:	469d                	li	a3,7
    1b68:	00650713          	addi	a4,a0,6
    1b6c:	16d79863          	bne	a5,a3,1cdc <stpncpy+0x216>
    1b70:	00750713          	addi	a4,a0,7
    1b74:	00050323          	sb	zero,6(a0)
    1b78:	40f80833          	sub	a6,a6,a5
    1b7c:	ff887593          	andi	a1,a6,-8
    1b80:	97aa                	add	a5,a5,a0
    1b82:	95be                	add	a1,a1,a5
    1b84:	0007b023          	sd	zero,0(a5)
    1b88:	07a1                	addi	a5,a5,8
    1b8a:	feb79de3          	bne	a5,a1,1b84 <stpncpy+0xbe>
    1b8e:	ff887593          	andi	a1,a6,-8
    1b92:	9ead                	addw	a3,a3,a1
    1b94:	00b707b3          	add	a5,a4,a1
    1b98:	12b80863          	beq	a6,a1,1cc8 <stpncpy+0x202>
    1b9c:	00078023          	sb	zero,0(a5)
    1ba0:	0016871b          	addiw	a4,a3,1
    1ba4:	0ec77863          	bgeu	a4,a2,1c94 <stpncpy+0x1ce>
    1ba8:	000780a3          	sb	zero,1(a5)
    1bac:	0026871b          	addiw	a4,a3,2
    1bb0:	0ec77263          	bgeu	a4,a2,1c94 <stpncpy+0x1ce>
    1bb4:	00078123          	sb	zero,2(a5)
    1bb8:	0036871b          	addiw	a4,a3,3
    1bbc:	0cc77c63          	bgeu	a4,a2,1c94 <stpncpy+0x1ce>
    1bc0:	000781a3          	sb	zero,3(a5)
    1bc4:	0046871b          	addiw	a4,a3,4
    1bc8:	0cc77663          	bgeu	a4,a2,1c94 <stpncpy+0x1ce>
    1bcc:	00078223          	sb	zero,4(a5)
    1bd0:	0056871b          	addiw	a4,a3,5
    1bd4:	0cc77063          	bgeu	a4,a2,1c94 <stpncpy+0x1ce>
    1bd8:	000782a3          	sb	zero,5(a5)
    1bdc:	0066871b          	addiw	a4,a3,6
    1be0:	0ac77a63          	bgeu	a4,a2,1c94 <stpncpy+0x1ce>
    1be4:	00078323          	sb	zero,6(a5)
    1be8:	0076871b          	addiw	a4,a3,7
    1bec:	0ac77463          	bgeu	a4,a2,1c94 <stpncpy+0x1ce>
    1bf0:	000783a3          	sb	zero,7(a5)
    1bf4:	0086871b          	addiw	a4,a3,8
    1bf8:	08c77e63          	bgeu	a4,a2,1c94 <stpncpy+0x1ce>
    1bfc:	00078423          	sb	zero,8(a5)
    1c00:	0096871b          	addiw	a4,a3,9
    1c04:	08c77863          	bgeu	a4,a2,1c94 <stpncpy+0x1ce>
    1c08:	000784a3          	sb	zero,9(a5)
    1c0c:	00a6871b          	addiw	a4,a3,10
    1c10:	08c77263          	bgeu	a4,a2,1c94 <stpncpy+0x1ce>
    1c14:	00078523          	sb	zero,10(a5)
    1c18:	00b6871b          	addiw	a4,a3,11
    1c1c:	06c77c63          	bgeu	a4,a2,1c94 <stpncpy+0x1ce>
    1c20:	000785a3          	sb	zero,11(a5)
    1c24:	00c6871b          	addiw	a4,a3,12
    1c28:	06c77663          	bgeu	a4,a2,1c94 <stpncpy+0x1ce>
    1c2c:	00078623          	sb	zero,12(a5)
    1c30:	26b5                	addiw	a3,a3,13
    1c32:	06c6f163          	bgeu	a3,a2,1c94 <stpncpy+0x1ce>
    1c36:	000786a3          	sb	zero,13(a5)
    1c3a:	8082                	ret
            ;
        if (!n || !*s)
    1c3c:	c645                	beqz	a2,1ce4 <stpncpy+0x21e>
    1c3e:	0005c783          	lbu	a5,0(a1)
    1c42:	ea078be3          	beqz	a5,1af8 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c46:	479d                	li	a5,7
    1c48:	02c7ff63          	bgeu	a5,a2,1c86 <stpncpy+0x1c0>
    1c4c:	00000897          	auipc	a7,0x0
    1c50:	2248b883          	ld	a7,548(a7) # 1e70 <memmove+0x18a>
    1c54:	00000817          	auipc	a6,0x0
    1c58:	22483803          	ld	a6,548(a6) # 1e78 <memmove+0x192>
    1c5c:	431d                	li	t1,7
    1c5e:	6198                	ld	a4,0(a1)
    1c60:	011707b3          	add	a5,a4,a7
    1c64:	fff74693          	not	a3,a4
    1c68:	8ff5                	and	a5,a5,a3
    1c6a:	0107f7b3          	and	a5,a5,a6
    1c6e:	ef81                	bnez	a5,1c86 <stpncpy+0x1c0>
            *wd = *ws;
    1c70:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c72:	1661                	addi	a2,a2,-8
    1c74:	05a1                	addi	a1,a1,8
    1c76:	0521                	addi	a0,a0,8
    1c78:	fec363e3          	bltu	t1,a2,1c5e <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c7c:	e609                	bnez	a2,1c86 <stpncpy+0x1c0>
    1c7e:	a08d                	j	1ce0 <stpncpy+0x21a>
    1c80:	167d                	addi	a2,a2,-1
    1c82:	0505                	addi	a0,a0,1
    1c84:	ca01                	beqz	a2,1c94 <stpncpy+0x1ce>
    1c86:	0005c783          	lbu	a5,0(a1)
    1c8a:	0585                	addi	a1,a1,1
    1c8c:	00f50023          	sb	a5,0(a0)
    1c90:	fbe5                	bnez	a5,1c80 <stpncpy+0x1ba>
        ;
tail:
    1c92:	b59d                	j	1af8 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c94:	8082                	ret
    1c96:	472d                	li	a4,11
    1c98:	bdb5                	j	1b14 <stpncpy+0x4e>
    1c9a:	00778713          	addi	a4,a5,7
    1c9e:	45ad                	li	a1,11
    1ca0:	fff60693          	addi	a3,a2,-1
    1ca4:	e6b778e3          	bgeu	a4,a1,1b14 <stpncpy+0x4e>
    1ca8:	b7fd                	j	1c96 <stpncpy+0x1d0>
    1caa:	40a007b3          	neg	a5,a0
    1cae:	8832                	mv	a6,a2
    1cb0:	8b9d                	andi	a5,a5,7
    1cb2:	4681                	li	a3,0
    1cb4:	e4060be3          	beqz	a2,1b0a <stpncpy+0x44>
    1cb8:	b7cd                	j	1c9a <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1cba:	468d                	li	a3,3
    1cbc:	bd75                	j	1b78 <stpncpy+0xb2>
    1cbe:	872a                	mv	a4,a0
    1cc0:	4681                	li	a3,0
    1cc2:	bd5d                	j	1b78 <stpncpy+0xb2>
    1cc4:	4685                	li	a3,1
    1cc6:	bd4d                	j	1b78 <stpncpy+0xb2>
    1cc8:	8082                	ret
    1cca:	87aa                	mv	a5,a0
    1ccc:	4681                	li	a3,0
    1cce:	b5f9                	j	1b9c <stpncpy+0xd6>
    1cd0:	4689                	li	a3,2
    1cd2:	b55d                	j	1b78 <stpncpy+0xb2>
    1cd4:	4691                	li	a3,4
    1cd6:	b54d                	j	1b78 <stpncpy+0xb2>
    1cd8:	4695                	li	a3,5
    1cda:	bd79                	j	1b78 <stpncpy+0xb2>
    1cdc:	4699                	li	a3,6
    1cde:	bd69                	j	1b78 <stpncpy+0xb2>
    1ce0:	8082                	ret
    1ce2:	8082                	ret
    1ce4:	8082                	ret

0000000000001ce6 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1ce6:	fff6071b          	addiw	a4,a2,-1
    1cea:	0cb57063          	bgeu	a0,a1,1daa <memmove+0xc4>
        while (n-- > 0)
    1cee:	0ec05063          	blez	a2,1dce <memmove+0xe8>
    1cf2:	00750693          	addi	a3,a0,7
    1cf6:	8e8d                	sub	a3,a3,a1
    1cf8:	00b567b3          	or	a5,a0,a1
    1cfc:	00f6b693          	sltiu	a3,a3,15
    1d00:	8b9d                	andi	a5,a5,7
    1d02:	0016c693          	xori	a3,a3,1
    1d06:	0017b793          	seqz	a5,a5
    1d0a:	8ff5                	and	a5,a5,a3
    1d0c:	c3f1                	beqz	a5,1dd0 <memmove+0xea>
    1d0e:	0007079b          	sext.w	a5,a4
    1d12:	46a5                	li	a3,9
    1d14:	0af6fe63          	bgeu	a3,a5,1dd0 <memmove+0xea>
    1d18:	0036589b          	srliw	a7,a2,0x3
    1d1c:	088e                	slli	a7,a7,0x3
    1d1e:	2601                	sext.w	a2,a2
    1d20:	87ae                	mv	a5,a1
    1d22:	86aa                	mv	a3,a0
    1d24:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1d26:	0007b803          	ld	a6,0(a5)
    1d2a:	07a1                	addi	a5,a5,8
    1d2c:	06a1                	addi	a3,a3,8
    1d2e:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1d32:	ff179ae3          	bne	a5,a7,1d26 <memmove+0x40>
    1d36:	ff867813          	andi	a6,a2,-8
    1d3a:	02081793          	slli	a5,a6,0x20
    1d3e:	9381                	srli	a5,a5,0x20
    1d40:	00f506b3          	add	a3,a0,a5
    1d44:	95be                	add	a1,a1,a5
    1d46:	4107073b          	subw	a4,a4,a6
    1d4a:	09060263          	beq	a2,a6,1dce <memmove+0xe8>
            *dst++ = *src++;
    1d4e:	0005c783          	lbu	a5,0(a1)
    1d52:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1d56:	06e05c63          	blez	a4,1dce <memmove+0xe8>
            *dst++ = *src++;
    1d5a:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1d5e:	4785                	li	a5,1
            *dst++ = *src++;
    1d60:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1d64:	06e7d563          	bge	a5,a4,1dce <memmove+0xe8>
            *dst++ = *src++;
    1d68:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1d6c:	4789                	li	a5,2
            *dst++ = *src++;
    1d6e:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1d72:	04e7de63          	bge	a5,a4,1dce <memmove+0xe8>
            *dst++ = *src++;
    1d76:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1d7a:	478d                	li	a5,3
            *dst++ = *src++;
    1d7c:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1d80:	04e7d763          	bge	a5,a4,1dce <memmove+0xe8>
            *dst++ = *src++;
    1d84:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1d88:	4791                	li	a5,4
            *dst++ = *src++;
    1d8a:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1d8e:	04e7d063          	bge	a5,a4,1dce <memmove+0xe8>
            *dst++ = *src++;
    1d92:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1d96:	4795                	li	a5,5
            *dst++ = *src++;
    1d98:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1d9c:	02e7d963          	bge	a5,a4,1dce <memmove+0xe8>
            *dst++ = *src++;
    1da0:	0065c783          	lbu	a5,6(a1)
    1da4:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1da8:	8082                	ret
    } else {
        dst += n;
    1daa:	00c507b3          	add	a5,a0,a2
        src += n;
    1dae:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1db0:	00c05f63          	blez	a2,1dce <memmove+0xe8>
    1db4:	1702                	slli	a4,a4,0x20
    1db6:	9301                	srli	a4,a4,0x20
    1db8:	fff74713          	not	a4,a4
    1dbc:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1dbe:	fff5c683          	lbu	a3,-1(a1)
    1dc2:	17fd                	addi	a5,a5,-1
    1dc4:	15fd                	addi	a1,a1,-1
    1dc6:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1dca:	fee79ae3          	bne	a5,a4,1dbe <memmove+0xd8>
    }
    return vdst;
}
    1dce:	8082                	ret
    1dd0:	02071693          	slli	a3,a4,0x20
    1dd4:	9281                	srli	a3,a3,0x20
    1dd6:	0685                	addi	a3,a3,1
    1dd8:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1dda:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1ddc:	0005c703          	lbu	a4,0(a1)
    1de0:	0585                	addi	a1,a1,1
    1de2:	0785                	addi	a5,a5,1
    1de4:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1de8:	fed59ae3          	bne	a1,a3,1ddc <memmove+0xf6>
    1dec:	8082                	ret
