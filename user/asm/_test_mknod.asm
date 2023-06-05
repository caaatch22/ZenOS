
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_mknod:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a091                	j	1044 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <ucore.h>
#include <string.h>
#include <fcntl.h>

int main(int argc, char *argv[])
{
    1002:	1141                	addi	sp,sp,-16
    int err;
    int fd;

    err = mknod("console2", 1, 0);
    1004:	4601                	li	a2,0
    1006:	4585                	li	a1,1
    1008:	00001517          	auipc	a0,0x1
    100c:	d8050513          	addi	a0,a0,-640 # 1d88 <memmove+0x108>
{
    1010:	e406                	sd	ra,8(sp)
    err = mknod("console2", 1, 0);
    1012:	0e4000ef          	jal	ra,10f6 <mknod>
    assert(err==0, -1);
    1016:	55fd                	li	a1,-1
    1018:	00153513          	seqz	a0,a0
    101c:	076000ef          	jal	ra,1092 <assert>

    fd = open("console2", O_RDWR);
    1020:	4589                	li	a1,2
    1022:	00001517          	auipc	a0,0x1
    1026:	d6650513          	addi	a0,a0,-666 # 1d88 <memmove+0x108>
    102a:	0c0000ef          	jal	ra,10ea <open>

    assert(fd>=0, -2);
    102e:	fff54513          	not	a0,a0
    1032:	01f5551b          	srliw	a0,a0,0x1f
    1036:	55f9                	li	a1,-2
    1038:	05a000ef          	jal	ra,1092 <assert>

    return 0;
    103c:	60a2                	ld	ra,8(sp)
    103e:	4501                	li	a0,0
    1040:	0141                	addi	sp,sp,16
    1042:	8082                	ret

0000000000001044 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1044:	1141                	addi	sp,sp,-16
    1046:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    1048:	fbbff0ef          	jal	ra,1002 <main>
}
    104c:	60a2                	ld	ra,8(sp)
    104e:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    1050:	a095                	j	10b4 <exit>

0000000000001052 <srand>:
#include <ucore.h>

static uint64 seed;

void srand(unsigned s) {
    seed = s - 1;
    1052:	357d                	addiw	a0,a0,-1
    1054:	1502                	slli	a0,a0,0x20
    1056:	9101                	srli	a0,a0,0x20
    1058:	00001797          	auipc	a5,0x1
    105c:	d6a7b423          	sd	a0,-664(a5) # 1dc0 <seed>
}
    1060:	8082                	ret

0000000000001062 <rand>:

int rand(void) {
    seed = 6364136223846793005ULL * seed + 1;
    1062:	00001797          	auipc	a5,0x1
    1066:	d5e78793          	addi	a5,a5,-674 # 1dc0 <seed>
    106a:	6388                	ld	a0,0(a5)
    106c:	00001717          	auipc	a4,0x1
    1070:	d3473703          	ld	a4,-716(a4) # 1da0 <memmove+0x120>
    1074:	02e50533          	mul	a0,a0,a4
    1078:	0505                	addi	a0,a0,1
    107a:	e388                	sd	a0,0(a5)
    return seed >> 33;
}
    107c:	9105                	srli	a0,a0,0x21
    107e:	8082                	ret

0000000000001080 <panic>:

void panic(char* m) {
    1080:	1141                	addi	sp,sp,-16
    1082:	e406                	sd	ra,8(sp)
    puts(m);
    1084:	1e0000ef          	jal	ra,1264 <puts>
    exit(-100);
}
    1088:	60a2                	ld	ra,8(sp)
    exit(-100);
    108a:	f9c00513          	li	a0,-100
}
    108e:	0141                	addi	sp,sp,16
    exit(-100);
    1090:	a015                	j	10b4 <exit>

0000000000001092 <assert>:

void assert(int f, int code) {
    if(!f) {
    1092:	c111                	beqz	a0,1096 <assert+0x4>
        exit(code);
    }
    1094:	8082                	ret
        exit(code);
    1096:	852e                	mv	a0,a1
    1098:	a831                	j	10b4 <exit>

000000000000109a <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    109a:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    109e:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    10a2:	2501                	sext.w	a0,a0
    10a4:	8082                	ret

00000000000010a6 <exec>:
    register long a7 __asm__("a7") = n;
    10a6:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    10aa:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    10ac:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    10b0:	2501                	sext.w	a0,a0
    10b2:	8082                	ret

00000000000010b4 <exit>:
    register long a7 __asm__("a7") = n;
    10b4:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    10b8:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    10bc:	8082                	ret

00000000000010be <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    10be:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    10c2:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    10c6:	8082                	ret

00000000000010c8 <write>:
    register long a7 __asm__("a7") = n;
    10c8:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    10cc:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    10d0:	8082                	ret

00000000000010d2 <getpid>:
    register long a7 __asm__("a7") = n;
    10d2:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    10d6:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    10da:	2501                	sext.w	a0,a0
    10dc:	8082                	ret

00000000000010de <getppid>:
    register long a7 __asm__("a7") = n;
    10de:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    10e2:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    10e6:	2501                	sext.w	a0,a0
    10e8:	8082                	ret

00000000000010ea <open>:
    register long a7 __asm__("a7") = n;
    10ea:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    10ee:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    10f2:	2501                	sext.w	a0,a0
    10f4:	8082                	ret

00000000000010f6 <mknod>:
    register long a7 __asm__("a7") = n;
    10f6:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    10fa:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    10fe:	2501                	sext.w	a0,a0
    1100:	8082                	ret

0000000000001102 <dup>:
    register long a7 __asm__("a7") = n;
    1102:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1104:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1108:	2501                	sext.w	a0,a0
    110a:	8082                	ret

000000000000110c <sched_yield>:
    register long a7 __asm__("a7") = n;
    110c:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1110:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1114:	2501                	sext.w	a0,a0
    1116:	8082                	ret

0000000000001118 <waitpid>:
    register long a7 __asm__("a7") = n;
    1118:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    111c:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1120:	2501                	sext.w	a0,a0
    1122:	8082                	ret

0000000000001124 <wait>:

pid_t wait(int *wstatus)
{
    1124:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1126:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    112a:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    112c:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1130:	2501                	sext.w	a0,a0
    1132:	8082                	ret

0000000000001134 <mkdir>:
    register long a7 __asm__("a7") = n;
    1134:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1138:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    113c:	2501                	sext.w	a0,a0
    113e:	8082                	ret

0000000000001140 <close>:
    register long a7 __asm__("a7") = n;
    1140:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1144:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1148:	2501                	sext.w	a0,a0
    114a:	8082                	ret

000000000000114c <fork>:
    register long a7 __asm__("a7") = n;
    114c:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1150:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1154:	2501                	sext.w	a0,a0
    1156:	8082                	ret

0000000000001158 <time_ms>:
    register long a7 __asm__("a7") = n;
    1158:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    115c:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1160:	8082                	ret

0000000000001162 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1162:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1164:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1168:	00000073          	ecall
    116c:	87aa                	mv	a5,a0
    116e:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1172:	97ba                	add	a5,a5,a4
    1174:	00f57c63          	bgeu	a0,a5,118c <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1178:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    117c:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1180:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1184:	00000073          	ecall
    1188:	fef568e3          	bltu	a0,a5,1178 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    118c:	4501                	li	a0,0
    118e:	8082                	ret

0000000000001190 <pipe>:
    register long a7 __asm__("a7") = n;
    1190:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1194:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1198:	2501                	sext.w	a0,a0
    119a:	8082                	ret

000000000000119c <fstat>:
    register long a7 __asm__("a7") = n;
    119c:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    11a0:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    11a4:	2501                	sext.w	a0,a0
    11a6:	8082                	ret

00000000000011a8 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    11a8:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    11aa:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    11ae:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    11b0:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    11b4:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    11b8:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    11bc:	0206c163          	bltz	a3,11de <stat+0x36>
    register long a7 __asm__("a7") = n;
    11c0:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    11c4:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    11c6:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    11c8:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    11cc:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    11d0:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    11d4:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    11d6:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    11da:	853e                	mv	a0,a5
    11dc:	8082                	ret
        return -1;
    11de:	57fd                	li	a5,-1
    11e0:	bfed                	j	11da <stat+0x32>

00000000000011e2 <chdir>:
    register long a7 __asm__("a7") = n;
    11e2:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    11e6:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    11ea:	2501                	sext.w	a0,a0
    11ec:	8082                	ret

00000000000011ee <link>:
    register long a7 __asm__("a7") = n;
    11ee:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    11f2:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    11f6:	2501                	sext.w	a0,a0
    11f8:	8082                	ret

00000000000011fa <unlink>:
    register long a7 __asm__("a7") = n;
    11fa:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    11fe:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1202:	2501                	sext.w	a0,a0
    1204:	8082                	ret

0000000000001206 <setpriority>:
    register long a7 __asm__("a7") = n;
    1206:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    120a:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    120e:	8082                	ret

0000000000001210 <getpriority>:
    register long a7 __asm__("a7") = n;
    1210:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1214:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1218:	8082                	ret

000000000000121a <sharedmem>:
    register long a7 __asm__("a7") = n;
    121a:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    121e:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1222:	8082                	ret

0000000000001224 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    1224:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    1226:	00f10593          	addi	a1,sp,15
    122a:	4605                	li	a2,1
    122c:	4501                	li	a0,0
int getchar() {
    122e:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1230:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1234:	e8bff0ef          	jal	ra,10be <read>
    return byte;
}
    1238:	60e2                	ld	ra,24(sp)
    123a:	00f14503          	lbu	a0,15(sp)
    123e:	6105                	addi	sp,sp,32
    1240:	8082                	ret

0000000000001242 <putchar>:

int putchar(int c)
{
    1242:	1141                	addi	sp,sp,-16
    1244:	e406                	sd	ra,8(sp)
    1246:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    1248:	00001597          	auipc	a1,0x1
    124c:	b8058593          	addi	a1,a1,-1152 # 1dc8 <put.1156>
    return write(stdout, put, 1);
    1250:	4605                	li	a2,1
    1252:	4505                	li	a0,1
    put[0] = c;
    1254:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1258:	e71ff0ef          	jal	ra,10c8 <write>
}
    125c:	60a2                	ld	ra,8(sp)
    125e:	2501                	sext.w	a0,a0
    1260:	0141                	addi	sp,sp,16
    1262:	8082                	ret

0000000000001264 <puts>:

int puts(const char* s)
{
    1264:	1141                	addi	sp,sp,-16
    1266:	e022                	sd	s0,0(sp)
    1268:	e406                	sd	ra,8(sp)
    126a:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    126c:	66e000ef          	jal	ra,18da <strlen>
    1270:	862a                	mv	a2,a0
    1272:	85a2                	mv	a1,s0
    1274:	4505                	li	a0,1
    1276:	e53ff0ef          	jal	ra,10c8 <write>
    127a:	00055763          	bgez	a0,1288 <puts+0x24>
    return r;
}
    127e:	60a2                	ld	ra,8(sp)
    1280:	6402                	ld	s0,0(sp)
    1282:	557d                	li	a0,-1
    1284:	0141                	addi	sp,sp,16
    1286:	8082                	ret
    put[0] = c;
    1288:	00001597          	auipc	a1,0x1
    128c:	b4058593          	addi	a1,a1,-1216 # 1dc8 <put.1156>
    1290:	47a9                	li	a5,10
    return write(stdout, put, 1);
    1292:	4605                	li	a2,1
    1294:	4505                	li	a0,1
    put[0] = c;
    1296:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    129a:	e2fff0ef          	jal	ra,10c8 <write>
}
    129e:	60a2                	ld	ra,8(sp)
    12a0:	6402                	ld	s0,0(sp)
    12a2:	41f5551b          	sraiw	a0,a0,0x1f
    12a6:	0141                	addi	sp,sp,16
    12a8:	8082                	ret

00000000000012aa <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    12aa:	7115                	addi	sp,sp,-224
    12ac:	ed06                	sd	ra,152(sp)
    12ae:	e922                	sd	s0,144(sp)
    12b0:	e526                	sd	s1,136(sp)
    12b2:	e14a                	sd	s2,128(sp)
    12b4:	fcce                	sd	s3,120(sp)
    12b6:	f8d2                	sd	s4,112(sp)
    12b8:	f4d6                	sd	s5,104(sp)
    12ba:	f0da                	sd	s6,96(sp)
    12bc:	ecde                	sd	s7,88(sp)
    12be:	e8e2                	sd	s8,80(sp)
    12c0:	e4e6                	sd	s9,72(sp)
    12c2:	e0ea                	sd	s10,64(sp)
    12c4:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    12c6:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    12ca:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    12cc:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    12ce:	f52e                	sd	a1,168(sp)
    12d0:	f932                	sd	a2,176(sp)
    12d2:	fd36                	sd	a3,184(sp)
    12d4:	e1ba                	sd	a4,192(sp)
    12d6:	e9c2                	sd	a6,208(sp)
    12d8:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    12da:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    12dc:	0c030b63          	beqz	t1,13b2 <printf+0x108>
    12e0:	8aaa                	mv	s5,a0
    12e2:	0003071b          	sext.w	a4,t1
    12e6:	4481                	li	s1,0
        if (c != '%') {
    12e8:	02500b93          	li	s7,37
    put[0] = c;
    12ec:	00001417          	auipc	s0,0x1
    12f0:	adc40413          	addi	s0,s0,-1316 # 1dc8 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    12f4:	4c51                	li	s8,20
    put[0] = c;
    12f6:	02500c93          	li	s9,37
    12fa:	00001a17          	auipc	s4,0x1
    12fe:	ad6a0a13          	addi	s4,s4,-1322 # 1dd0 <put.1156+0x8>
    1302:	00001997          	auipc	s3,0x1
    1306:	b2698993          	addi	s3,s3,-1242 # 1e28 <digits>
    130a:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    130e:	0014879b          	addiw	a5,s1,1
    1312:	00fa8933          	add	s2,s5,a5
    1316:	13771163          	bne	a4,s7,1438 <printf+0x18e>
        c = fmt[++i] & 0xff;
    131a:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    131e:	080d0a63          	beqz	s10,13b2 <printf+0x108>
        switch (c) {
    1322:	2489                	addiw	s1,s1,2
    1324:	009a8933          	add	s2,s5,s1
    1328:	257d0e63          	beq	s10,s7,1584 <printf+0x2da>
    132c:	f9cd079b          	addiw	a5,s10,-100
    1330:	0ff7f793          	andi	a5,a5,255
    1334:	0cfc6263          	bltu	s8,a5,13f8 <printf+0x14e>
    1338:	078a                	slli	a5,a5,0x2
    133a:	97d2                	add	a5,a5,s4
    133c:	439c                	lw	a5,0(a5)
    133e:	97d2                	add	a5,a5,s4
    1340:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    1342:	67a2                	ld	a5,8(sp)
    1344:	4398                	lw	a4,0(a5)
    1346:	07a1                	addi	a5,a5,8
    1348:	e43e                	sd	a5,8(sp)
    134a:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    134e:	26074663          	bltz	a4,15ba <printf+0x310>
        buf[i++] = digits[x % base];
    1352:	8bbd                	andi	a5,a5,15
    1354:	97ce                	add	a5,a5,s3
    1356:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    135a:	40475d1b          	sraiw	s10,a4,0x4
    135e:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    1362:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    1366:	020d0163          	beqz	s10,1388 <printf+0xde>
        buf[i++] = digits[x % base];
    136a:	9d4e                	add	s10,s10,s3
    136c:	000d4783          	lbu	a5,0(s10)
    1370:	4d05                	li	s10,1
    1372:	00f108a3          	sb	a5,17(sp)
    if (sign)
    1376:	00075963          	bgez	a4,1388 <printf+0xde>
        buf[i++] = digits[x % base];
    137a:	4d09                	li	s10,2
        buf[i++] = '-';
    137c:	181c                	addi	a5,sp,48
    137e:	02d00713          	li	a4,45
    1382:	97ea                	add	a5,a5,s10
    1384:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    1388:	9d5a                	add	s10,s10,s6
    138a:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    138e:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1392:	4605                	li	a2,1
    1394:	1d7d                	addi	s10,s10,-1
    1396:	85a2                	mv	a1,s0
    1398:	4505                	li	a0,1
    put[0] = c;
    139a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    139e:	d2bff0ef          	jal	ra,10c8 <write>
    while (--i >= 0)
    13a2:	ffbd16e3          	bne	s10,s11,138e <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    13a6:	00094303          	lbu	t1,0(s2)
    13aa:	0003071b          	sext.w	a4,t1
    13ae:	f60310e3          	bnez	t1,130e <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    13b2:	60ea                	ld	ra,152(sp)
    13b4:	644a                	ld	s0,144(sp)
    13b6:	64aa                	ld	s1,136(sp)
    13b8:	690a                	ld	s2,128(sp)
    13ba:	79e6                	ld	s3,120(sp)
    13bc:	7a46                	ld	s4,112(sp)
    13be:	7aa6                	ld	s5,104(sp)
    13c0:	7b06                	ld	s6,96(sp)
    13c2:	6be6                	ld	s7,88(sp)
    13c4:	6c46                	ld	s8,80(sp)
    13c6:	6ca6                	ld	s9,72(sp)
    13c8:	6d06                	ld	s10,64(sp)
    13ca:	7de2                	ld	s11,56(sp)
    13cc:	612d                	addi	sp,sp,224
    13ce:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    13d0:	67a2                	ld	a5,8(sp)
    13d2:	0007bd03          	ld	s10,0(a5)
    13d6:	07a1                	addi	a5,a5,8
    13d8:	e43e                	sd	a5,8(sp)
    13da:	000d1b63          	bnez	s10,13f0 <printf+0x146>
    13de:	aafd                	j	15dc <printf+0x332>
    return write(stdout, put, 1);
    13e0:	4605                	li	a2,1
    13e2:	85a2                	mv	a1,s0
    13e4:	4505                	li	a0,1
                for (; *s; s++)
    13e6:	0d05                	addi	s10,s10,1
    put[0] = c;
    13e8:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    13ec:	cddff0ef          	jal	ra,10c8 <write>
                for (; *s; s++)
    13f0:	000d4783          	lbu	a5,0(s10)
    13f4:	f7f5                	bnez	a5,13e0 <printf+0x136>
    13f6:	a02d                	j	1420 <printf+0x176>
    return write(stdout, put, 1);
    13f8:	4605                	li	a2,1
    13fa:	00001597          	auipc	a1,0x1
    13fe:	9ce58593          	addi	a1,a1,-1586 # 1dc8 <put.1156>
    1402:	4505                	li	a0,1
    put[0] = c;
    1404:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    1408:	cc1ff0ef          	jal	ra,10c8 <write>
    140c:	4605                	li	a2,1
    140e:	00001597          	auipc	a1,0x1
    1412:	9ba58593          	addi	a1,a1,-1606 # 1dc8 <put.1156>
    1416:	4505                	li	a0,1
    put[0] = c;
    1418:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    141c:	cadff0ef          	jal	ra,10c8 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1420:	00094303          	lbu	t1,0(s2)
    1424:	0003071b          	sext.w	a4,t1
    1428:	f80305e3          	beqz	t1,13b2 <printf+0x108>
        if (c != '%') {
    142c:	0014879b          	addiw	a5,s1,1
    1430:	00fa8933          	add	s2,s5,a5
    1434:	ef7703e3          	beq	a4,s7,131a <printf+0x70>
    return write(stdout, put, 1);
    1438:	4605                	li	a2,1
    143a:	00001597          	auipc	a1,0x1
    143e:	98e58593          	addi	a1,a1,-1650 # 1dc8 <put.1156>
    1442:	4505                	li	a0,1
    put[0] = c;
    1444:	00640023          	sb	t1,0(s0)
            continue;
    1448:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    144a:	c7fff0ef          	jal	ra,10c8 <write>
            continue;
    144e:	bfc9                	j	1420 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    1450:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    1452:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    1454:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    1456:	0007b883          	ld	a7,0(a5)
    145a:	07a1                	addi	a5,a5,8
    145c:	e43e                	sd	a5,8(sp)
        x = -xx;
    145e:	43f8d713          	srai	a4,a7,0x3f
    1462:	011747b3          	xor	a5,a4,a7
    1466:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    1468:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    146a:	02c7f733          	remu	a4,a5,a2
    146e:	8d36                	mv	s10,a3
    1470:	0685                	addi	a3,a3,1
    1472:	00db0533          	add	a0,s6,a3
    1476:	85be                	mv	a1,a5
    1478:	974e                	add	a4,a4,s3
    147a:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    147e:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    1482:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    1486:	feb862e3          	bltu	a6,a1,146a <printf+0x1c0>
    if (sign)
    148a:	1208c063          	bltz	a7,15aa <printf+0x300>
    while (--i >= 0)
    148e:	9d5a                	add	s10,s10,s6
    put[0] = c;
    1490:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1494:	4605                	li	a2,1
    1496:	85a2                	mv	a1,s0
    1498:	4505                	li	a0,1
    put[0] = c;
    149a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    149e:	c2bff0ef          	jal	ra,10c8 <write>
    while (--i >= 0)
    14a2:	87ea                	mv	a5,s10
    14a4:	1d7d                	addi	s10,s10,-1
    14a6:	fefb15e3          	bne	s6,a5,1490 <printf+0x1e6>
    14aa:	bf9d                	j	1420 <printf+0x176>
                printptr(va_arg(ap, uint64));
    14ac:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    14ae:	4605                	li	a2,1
    14b0:	00001597          	auipc	a1,0x1
    14b4:	91858593          	addi	a1,a1,-1768 # 1dc8 <put.1156>
                printptr(va_arg(ap, uint64));
    14b8:	0007bd83          	ld	s11,0(a5)
    14bc:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    14c0:	4505                	li	a0,1
    put[0] = c;
    14c2:	03000793          	li	a5,48
    14c6:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    14ca:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    14cc:	bfdff0ef          	jal	ra,10c8 <write>
    put[0] = c;
    14d0:	07800793          	li	a5,120
    return write(stdout, put, 1);
    14d4:	4605                	li	a2,1
    14d6:	00001597          	auipc	a1,0x1
    14da:	8f258593          	addi	a1,a1,-1806 # 1dc8 <put.1156>
    14de:	4505                	li	a0,1
    put[0] = c;
    14e0:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    14e4:	4d41                	li	s10,16
    14e6:	be3ff0ef          	jal	ra,10c8 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    14ea:	03cdd793          	srli	a5,s11,0x3c
    14ee:	97ce                	add	a5,a5,s3
    put[0] = c;
    14f0:	0007c783          	lbu	a5,0(a5)
    14f4:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    14f6:	4605                	li	a2,1
    14f8:	85a2                	mv	a1,s0
    14fa:	4505                	li	a0,1
    put[0] = c;
    14fc:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1500:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1502:	bc7ff0ef          	jal	ra,10c8 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1506:	fe0d12e3          	bnez	s10,14ea <printf+0x240>
    150a:	bf19                	j	1420 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    150c:	67a2                	ld	a5,8(sp)
    150e:	4394                	lw	a3,0(a5)
    1510:	07a1                	addi	a5,a5,8
    1512:	e43e                	sd	a5,8(sp)
    1514:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    1518:	0006d663          	bgez	a3,1524 <printf+0x27a>
        x = -xx;
    151c:	40f007bb          	negw	a5,a5
    1520:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    1524:	4729                	li	a4,10
    1526:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    152a:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    152e:	964e                	add	a2,a2,s3
    1530:	00064603          	lbu	a2,0(a2)
    1534:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    1538:	0a0d0963          	beqz	s10,15ea <printf+0x340>
        buf[i++] = digits[x % base];
    153c:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    1540:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    1544:	00c98733          	add	a4,s3,a2
    1548:	00074703          	lbu	a4,0(a4)
    154c:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    1550:	c3cd                	beqz	a5,15f2 <printf+0x348>
        buf[i++] = digits[x % base];
    1552:	97ce                	add	a5,a5,s3
    1554:	0007c703          	lbu	a4,0(a5)
    1558:	4d09                	li	s10,2
    155a:	478d                	li	a5,3
    155c:	00e10923          	sb	a4,18(sp)
    if (sign)
    1560:	0206cd63          	bltz	a3,159a <printf+0x2f0>
    while (--i >= 0)
    1564:	9d5a                	add	s10,s10,s6
    1566:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    156a:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    156e:	4605                	li	a2,1
    1570:	1d7d                	addi	s10,s10,-1
    1572:	85a2                	mv	a1,s0
    1574:	4505                	li	a0,1
    put[0] = c;
    1576:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    157a:	b4fff0ef          	jal	ra,10c8 <write>
    while (--i >= 0)
    157e:	ffbd16e3          	bne	s10,s11,156a <printf+0x2c0>
    1582:	bd79                	j	1420 <printf+0x176>
    return write(stdout, put, 1);
    1584:	4605                	li	a2,1
    1586:	00001597          	auipc	a1,0x1
    158a:	84258593          	addi	a1,a1,-1982 # 1dc8 <put.1156>
    158e:	4505                	li	a0,1
    put[0] = c;
    1590:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    1594:	b35ff0ef          	jal	ra,10c8 <write>
    1598:	b561                	j	1420 <printf+0x176>
        buf[i++] = '-';
    159a:	1818                	addi	a4,sp,48
    159c:	973e                	add	a4,a4,a5
    159e:	02d00693          	li	a3,45
    15a2:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    15a6:	8d3e                	mv	s10,a5
    15a8:	bf75                	j	1564 <printf+0x2ba>
        buf[i++] = '-';
    15aa:	181c                	addi	a5,sp,48
    15ac:	97b6                	add	a5,a5,a3
    15ae:	02d00713          	li	a4,45
    15b2:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    15b6:	8d36                	mv	s10,a3
    15b8:	bdd9                	j	148e <printf+0x1e4>
        x = -xx;
    15ba:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    15be:	00f7f693          	andi	a3,a5,15
    15c2:	96ce                	add	a3,a3,s3
    15c4:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    15c8:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    15cc:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    15d0:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    15d4:	d80d1be3          	bnez	s10,136a <printf+0xc0>
        buf[i++] = digits[x % base];
    15d8:	4d05                	li	s10,1
    15da:	b34d                	j	137c <printf+0xd2>
                s = "(null)";
    15dc:	00000d17          	auipc	s10,0x0
    15e0:	7bcd0d13          	addi	s10,s10,1980 # 1d98 <memmove+0x118>
                for (; *s; s++)
    15e4:	02800793          	li	a5,40
    15e8:	bbe5                	j	13e0 <printf+0x136>
        buf[i++] = digits[x % base];
    15ea:	4785                	li	a5,1
    if (sign)
    15ec:	f606dce3          	bgez	a3,1564 <printf+0x2ba>
    15f0:	b76d                	j	159a <printf+0x2f0>
        buf[i++] = digits[x % base];
    15f2:	4789                	li	a5,2
    15f4:	4d05                	li	s10,1
    if (sign)
    15f6:	f606d7e3          	bgez	a3,1564 <printf+0x2ba>
    15fa:	b745                	j	159a <printf+0x2f0>

00000000000015fc <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15fc:	02000793          	li	a5,32
    1600:	00f50663          	beq	a0,a5,160c <isspace+0x10>
    1604:	355d                	addiw	a0,a0,-9
    1606:	00553513          	sltiu	a0,a0,5
    160a:	8082                	ret
    160c:	4505                	li	a0,1
}
    160e:	8082                	ret

0000000000001610 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1610:	fd05051b          	addiw	a0,a0,-48
}
    1614:	00a53513          	sltiu	a0,a0,10
    1618:	8082                	ret

000000000000161a <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    161a:	02000613          	li	a2,32
    161e:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1620:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1624:	ff77069b          	addiw	a3,a4,-9
    1628:	04c70d63          	beq	a4,a2,1682 <atoi+0x68>
    162c:	0007079b          	sext.w	a5,a4
    1630:	04d5f963          	bgeu	a1,a3,1682 <atoi+0x68>
        s++;
    switch (*s) {
    1634:	02b00693          	li	a3,43
    1638:	04d70a63          	beq	a4,a3,168c <atoi+0x72>
    163c:	02d00693          	li	a3,45
    1640:	06d70463          	beq	a4,a3,16a8 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1644:	fd07859b          	addiw	a1,a5,-48
    1648:	4625                	li	a2,9
    164a:	873e                	mv	a4,a5
    164c:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    164e:	4e01                	li	t3,0
    while (isdigit(*s))
    1650:	04b66a63          	bltu	a2,a1,16a4 <atoi+0x8a>
    int n = 0, neg = 0;
    1654:	4501                	li	a0,0
    while (isdigit(*s))
    1656:	4825                	li	a6,9
    1658:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    165c:	0025179b          	slliw	a5,a0,0x2
    1660:	9d3d                	addw	a0,a0,a5
    1662:	fd07031b          	addiw	t1,a4,-48
    1666:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    166a:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    166e:	0685                	addi	a3,a3,1
    1670:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1674:	0006071b          	sext.w	a4,a2
    1678:	feb870e3          	bgeu	a6,a1,1658 <atoi+0x3e>
    return neg ? n : -n;
    167c:	000e0563          	beqz	t3,1686 <atoi+0x6c>
}
    1680:	8082                	ret
        s++;
    1682:	0505                	addi	a0,a0,1
    1684:	bf71                	j	1620 <atoi+0x6>
    1686:	4113053b          	subw	a0,t1,a7
    168a:	8082                	ret
    while (isdigit(*s))
    168c:	00154783          	lbu	a5,1(a0)
    1690:	4625                	li	a2,9
        s++;
    1692:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1696:	fd07859b          	addiw	a1,a5,-48
    169a:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    169e:	4e01                	li	t3,0
    while (isdigit(*s))
    16a0:	fab67ae3          	bgeu	a2,a1,1654 <atoi+0x3a>
    16a4:	4501                	li	a0,0
}
    16a6:	8082                	ret
    while (isdigit(*s))
    16a8:	00154783          	lbu	a5,1(a0)
    16ac:	4625                	li	a2,9
        s++;
    16ae:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    16b2:	fd07859b          	addiw	a1,a5,-48
    16b6:	0007871b          	sext.w	a4,a5
    16ba:	feb665e3          	bltu	a2,a1,16a4 <atoi+0x8a>
        neg = 1;
    16be:	4e05                	li	t3,1
    16c0:	bf51                	j	1654 <atoi+0x3a>

00000000000016c2 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    16c2:	16060d63          	beqz	a2,183c <memset+0x17a>
    16c6:	40a007b3          	neg	a5,a0
    16ca:	8b9d                	andi	a5,a5,7
    16cc:	00778713          	addi	a4,a5,7
    16d0:	482d                	li	a6,11
    16d2:	0ff5f593          	andi	a1,a1,255
    16d6:	fff60693          	addi	a3,a2,-1
    16da:	17076263          	bltu	a4,a6,183e <memset+0x17c>
    16de:	16e6ea63          	bltu	a3,a4,1852 <memset+0x190>
    16e2:	16078563          	beqz	a5,184c <memset+0x18a>
    16e6:	00b50023          	sb	a1,0(a0)
    16ea:	4705                	li	a4,1
    16ec:	00150e93          	addi	t4,a0,1
    16f0:	14e78c63          	beq	a5,a4,1848 <memset+0x186>
    16f4:	00b500a3          	sb	a1,1(a0)
    16f8:	4709                	li	a4,2
    16fa:	00250e93          	addi	t4,a0,2
    16fe:	14e78d63          	beq	a5,a4,1858 <memset+0x196>
    1702:	00b50123          	sb	a1,2(a0)
    1706:	470d                	li	a4,3
    1708:	00350e93          	addi	t4,a0,3
    170c:	12e78b63          	beq	a5,a4,1842 <memset+0x180>
    1710:	00b501a3          	sb	a1,3(a0)
    1714:	4711                	li	a4,4
    1716:	00450e93          	addi	t4,a0,4
    171a:	14e78163          	beq	a5,a4,185c <memset+0x19a>
    171e:	00b50223          	sb	a1,4(a0)
    1722:	4715                	li	a4,5
    1724:	00550e93          	addi	t4,a0,5
    1728:	12e78c63          	beq	a5,a4,1860 <memset+0x19e>
    172c:	00b502a3          	sb	a1,5(a0)
    1730:	471d                	li	a4,7
    1732:	00650e93          	addi	t4,a0,6
    1736:	12e79763          	bne	a5,a4,1864 <memset+0x1a2>
    173a:	00750e93          	addi	t4,a0,7
    173e:	00b50323          	sb	a1,6(a0)
    1742:	4f1d                	li	t5,7
    1744:	00859713          	slli	a4,a1,0x8
    1748:	8f4d                	or	a4,a4,a1
    174a:	01059e13          	slli	t3,a1,0x10
    174e:	01c76e33          	or	t3,a4,t3
    1752:	01859313          	slli	t1,a1,0x18
    1756:	006e6333          	or	t1,t3,t1
    175a:	02059893          	slli	a7,a1,0x20
    175e:	011368b3          	or	a7,t1,a7
    1762:	02859813          	slli	a6,a1,0x28
    1766:	40f60333          	sub	t1,a2,a5
    176a:	0108e833          	or	a6,a7,a6
    176e:	03059693          	slli	a3,a1,0x30
    1772:	00d866b3          	or	a3,a6,a3
    1776:	03859713          	slli	a4,a1,0x38
    177a:	97aa                	add	a5,a5,a0
    177c:	ff837813          	andi	a6,t1,-8
    1780:	8f55                	or	a4,a4,a3
    1782:	00f806b3          	add	a3,a6,a5
    1786:	e398                	sd	a4,0(a5)
    1788:	07a1                	addi	a5,a5,8
    178a:	fed79ee3          	bne	a5,a3,1786 <memset+0xc4>
    178e:	ff837693          	andi	a3,t1,-8
    1792:	00de87b3          	add	a5,t4,a3
    1796:	01e6873b          	addw	a4,a3,t5
    179a:	0ad30663          	beq	t1,a3,1846 <memset+0x184>
    179e:	00b78023          	sb	a1,0(a5)
    17a2:	0017069b          	addiw	a3,a4,1
    17a6:	08c6fb63          	bgeu	a3,a2,183c <memset+0x17a>
    17aa:	00b780a3          	sb	a1,1(a5)
    17ae:	0027069b          	addiw	a3,a4,2
    17b2:	08c6f563          	bgeu	a3,a2,183c <memset+0x17a>
    17b6:	00b78123          	sb	a1,2(a5)
    17ba:	0037069b          	addiw	a3,a4,3
    17be:	06c6ff63          	bgeu	a3,a2,183c <memset+0x17a>
    17c2:	00b781a3          	sb	a1,3(a5)
    17c6:	0047069b          	addiw	a3,a4,4
    17ca:	06c6f963          	bgeu	a3,a2,183c <memset+0x17a>
    17ce:	00b78223          	sb	a1,4(a5)
    17d2:	0057069b          	addiw	a3,a4,5
    17d6:	06c6f363          	bgeu	a3,a2,183c <memset+0x17a>
    17da:	00b782a3          	sb	a1,5(a5)
    17de:	0067069b          	addiw	a3,a4,6
    17e2:	04c6fd63          	bgeu	a3,a2,183c <memset+0x17a>
    17e6:	00b78323          	sb	a1,6(a5)
    17ea:	0077069b          	addiw	a3,a4,7
    17ee:	04c6f763          	bgeu	a3,a2,183c <memset+0x17a>
    17f2:	00b783a3          	sb	a1,7(a5)
    17f6:	0087069b          	addiw	a3,a4,8
    17fa:	04c6f163          	bgeu	a3,a2,183c <memset+0x17a>
    17fe:	00b78423          	sb	a1,8(a5)
    1802:	0097069b          	addiw	a3,a4,9
    1806:	02c6fb63          	bgeu	a3,a2,183c <memset+0x17a>
    180a:	00b784a3          	sb	a1,9(a5)
    180e:	00a7069b          	addiw	a3,a4,10
    1812:	02c6f563          	bgeu	a3,a2,183c <memset+0x17a>
    1816:	00b78523          	sb	a1,10(a5)
    181a:	00b7069b          	addiw	a3,a4,11
    181e:	00c6ff63          	bgeu	a3,a2,183c <memset+0x17a>
    1822:	00b785a3          	sb	a1,11(a5)
    1826:	00c7069b          	addiw	a3,a4,12
    182a:	00c6f963          	bgeu	a3,a2,183c <memset+0x17a>
    182e:	00b78623          	sb	a1,12(a5)
    1832:	2735                	addiw	a4,a4,13
    1834:	00c77463          	bgeu	a4,a2,183c <memset+0x17a>
    1838:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    183c:	8082                	ret
    183e:	472d                	li	a4,11
    1840:	bd79                	j	16de <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1842:	4f0d                	li	t5,3
    1844:	b701                	j	1744 <memset+0x82>
    1846:	8082                	ret
    1848:	4f05                	li	t5,1
    184a:	bded                	j	1744 <memset+0x82>
    184c:	8eaa                	mv	t4,a0
    184e:	4f01                	li	t5,0
    1850:	bdd5                	j	1744 <memset+0x82>
    1852:	87aa                	mv	a5,a0
    1854:	4701                	li	a4,0
    1856:	b7a1                	j	179e <memset+0xdc>
    1858:	4f09                	li	t5,2
    185a:	b5ed                	j	1744 <memset+0x82>
    185c:	4f11                	li	t5,4
    185e:	b5dd                	j	1744 <memset+0x82>
    1860:	4f15                	li	t5,5
    1862:	b5cd                	j	1744 <memset+0x82>
    1864:	4f19                	li	t5,6
    1866:	bdf9                	j	1744 <memset+0x82>

0000000000001868 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    1868:	00054783          	lbu	a5,0(a0)
    186c:	0005c703          	lbu	a4,0(a1)
    1870:	00e79863          	bne	a5,a4,1880 <strcmp+0x18>
    1874:	0505                	addi	a0,a0,1
    1876:	0585                	addi	a1,a1,1
    1878:	fbe5                	bnez	a5,1868 <strcmp>
    187a:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    187c:	9d19                	subw	a0,a0,a4
    187e:	8082                	ret
    1880:	0007851b          	sext.w	a0,a5
    1884:	bfe5                	j	187c <strcmp+0x14>

0000000000001886 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1886:	87aa                	mv	a5,a0
    1888:	0005c703          	lbu	a4,0(a1)
    188c:	0785                	addi	a5,a5,1
    188e:	0585                	addi	a1,a1,1
    1890:	fee78fa3          	sb	a4,-1(a5)
    1894:	fb75                	bnez	a4,1888 <strcpy+0x2>
        ;
    return os;
}
    1896:	8082                	ret

0000000000001898 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    1898:	ce05                	beqz	a2,18d0 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    189a:	00054703          	lbu	a4,0(a0)
    189e:	0005c783          	lbu	a5,0(a1)
    18a2:	cb0d                	beqz	a4,18d4 <strncmp+0x3c>
    if (!n--)
    18a4:	167d                	addi	a2,a2,-1
    18a6:	00c506b3          	add	a3,a0,a2
    18aa:	a819                	j	18c0 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    18ac:	00a68e63          	beq	a3,a0,18c8 <strncmp+0x30>
    18b0:	0505                	addi	a0,a0,1
    18b2:	00e79b63          	bne	a5,a4,18c8 <strncmp+0x30>
    18b6:	00054703          	lbu	a4,0(a0)
    18ba:	0005c783          	lbu	a5,0(a1)
    18be:	cb19                	beqz	a4,18d4 <strncmp+0x3c>
    18c0:	0005c783          	lbu	a5,0(a1)
    18c4:	0585                	addi	a1,a1,1
    18c6:	f3fd                	bnez	a5,18ac <strncmp+0x14>
        ;
    return *l - *r;
    18c8:	0007051b          	sext.w	a0,a4
    18cc:	9d1d                	subw	a0,a0,a5
    18ce:	8082                	ret
        return 0;
    18d0:	4501                	li	a0,0
}
    18d2:	8082                	ret
    18d4:	4501                	li	a0,0
    return *l - *r;
    18d6:	9d1d                	subw	a0,a0,a5
    18d8:	8082                	ret

00000000000018da <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    18da:	00757793          	andi	a5,a0,7
    18de:	cf89                	beqz	a5,18f8 <strlen+0x1e>
    18e0:	87aa                	mv	a5,a0
    18e2:	a029                	j	18ec <strlen+0x12>
    18e4:	0785                	addi	a5,a5,1
    18e6:	0077f713          	andi	a4,a5,7
    18ea:	cb01                	beqz	a4,18fa <strlen+0x20>
        if (!*s)
    18ec:	0007c703          	lbu	a4,0(a5)
    18f0:	fb75                	bnez	a4,18e4 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    18f2:	40a78533          	sub	a0,a5,a0
}
    18f6:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18f8:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    18fa:	6394                	ld	a3,0(a5)
    18fc:	00000597          	auipc	a1,0x0
    1900:	4ac5b583          	ld	a1,1196(a1) # 1da8 <memmove+0x128>
    1904:	00000617          	auipc	a2,0x0
    1908:	4ac63603          	ld	a2,1196(a2) # 1db0 <memmove+0x130>
    190c:	a019                	j	1912 <strlen+0x38>
    190e:	6794                	ld	a3,8(a5)
    1910:	07a1                	addi	a5,a5,8
    1912:	00b68733          	add	a4,a3,a1
    1916:	fff6c693          	not	a3,a3
    191a:	8f75                	and	a4,a4,a3
    191c:	8f71                	and	a4,a4,a2
    191e:	db65                	beqz	a4,190e <strlen+0x34>
    for (; *s; s++)
    1920:	0007c703          	lbu	a4,0(a5)
    1924:	d779                	beqz	a4,18f2 <strlen+0x18>
    1926:	0017c703          	lbu	a4,1(a5)
    192a:	0785                	addi	a5,a5,1
    192c:	d379                	beqz	a4,18f2 <strlen+0x18>
    192e:	0017c703          	lbu	a4,1(a5)
    1932:	0785                	addi	a5,a5,1
    1934:	fb6d                	bnez	a4,1926 <strlen+0x4c>
    1936:	bf75                	j	18f2 <strlen+0x18>

0000000000001938 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1938:	00757713          	andi	a4,a0,7
{
    193c:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    193e:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1942:	cb19                	beqz	a4,1958 <memchr+0x20>
    1944:	ce25                	beqz	a2,19bc <memchr+0x84>
    1946:	0007c703          	lbu	a4,0(a5)
    194a:	04b70e63          	beq	a4,a1,19a6 <memchr+0x6e>
    194e:	0785                	addi	a5,a5,1
    1950:	0077f713          	andi	a4,a5,7
    1954:	167d                	addi	a2,a2,-1
    1956:	f77d                	bnez	a4,1944 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    1958:	4501                	li	a0,0
    if (n && *s != c) {
    195a:	c235                	beqz	a2,19be <memchr+0x86>
    195c:	0007c703          	lbu	a4,0(a5)
    1960:	04b70363          	beq	a4,a1,19a6 <memchr+0x6e>
        size_t k = ONES * c;
    1964:	00000517          	auipc	a0,0x0
    1968:	45453503          	ld	a0,1108(a0) # 1db8 <memmove+0x138>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    196c:	471d                	li	a4,7
        size_t k = ONES * c;
    196e:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1972:	02c77a63          	bgeu	a4,a2,19a6 <memchr+0x6e>
    1976:	00000897          	auipc	a7,0x0
    197a:	4328b883          	ld	a7,1074(a7) # 1da8 <memmove+0x128>
    197e:	00000817          	auipc	a6,0x0
    1982:	43283803          	ld	a6,1074(a6) # 1db0 <memmove+0x130>
    1986:	431d                	li	t1,7
    1988:	a029                	j	1992 <memchr+0x5a>
    198a:	1661                	addi	a2,a2,-8
    198c:	07a1                	addi	a5,a5,8
    198e:	02c37963          	bgeu	t1,a2,19c0 <memchr+0x88>
    1992:	6398                	ld	a4,0(a5)
    1994:	8f29                	xor	a4,a4,a0
    1996:	011706b3          	add	a3,a4,a7
    199a:	fff74713          	not	a4,a4
    199e:	8f75                	and	a4,a4,a3
    19a0:	01077733          	and	a4,a4,a6
    19a4:	d37d                	beqz	a4,198a <memchr+0x52>
    19a6:	853e                	mv	a0,a5
    19a8:	97b2                	add	a5,a5,a2
    19aa:	a021                	j	19b2 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    19ac:	0505                	addi	a0,a0,1
    19ae:	00f50763          	beq	a0,a5,19bc <memchr+0x84>
    19b2:	00054703          	lbu	a4,0(a0)
    19b6:	feb71be3          	bne	a4,a1,19ac <memchr+0x74>
    19ba:	8082                	ret
    return n ? (void*)s : 0;
    19bc:	4501                	li	a0,0
}
    19be:	8082                	ret
    return n ? (void*)s : 0;
    19c0:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    19c2:	f275                	bnez	a2,19a6 <memchr+0x6e>
}
    19c4:	8082                	ret

00000000000019c6 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    19c6:	1101                	addi	sp,sp,-32
    19c8:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    19ca:	862e                	mv	a2,a1
{
    19cc:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    19ce:	4581                	li	a1,0
{
    19d0:	e426                	sd	s1,8(sp)
    19d2:	ec06                	sd	ra,24(sp)
    19d4:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    19d6:	f63ff0ef          	jal	ra,1938 <memchr>
    return p ? p - s : n;
    19da:	c519                	beqz	a0,19e8 <strnlen+0x22>
}
    19dc:	60e2                	ld	ra,24(sp)
    19de:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    19e0:	8d05                	sub	a0,a0,s1
}
    19e2:	64a2                	ld	s1,8(sp)
    19e4:	6105                	addi	sp,sp,32
    19e6:	8082                	ret
    19e8:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    19ea:	8522                	mv	a0,s0
}
    19ec:	6442                	ld	s0,16(sp)
    19ee:	64a2                	ld	s1,8(sp)
    19f0:	6105                	addi	sp,sp,32
    19f2:	8082                	ret

00000000000019f4 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    19f4:	00b547b3          	xor	a5,a0,a1
    19f8:	8b9d                	andi	a5,a5,7
    19fa:	eb95                	bnez	a5,1a2e <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    19fc:	0075f793          	andi	a5,a1,7
    1a00:	e7b1                	bnez	a5,1a4c <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1a02:	6198                	ld	a4,0(a1)
    1a04:	00000617          	auipc	a2,0x0
    1a08:	3a463603          	ld	a2,932(a2) # 1da8 <memmove+0x128>
    1a0c:	00000817          	auipc	a6,0x0
    1a10:	3a483803          	ld	a6,932(a6) # 1db0 <memmove+0x130>
    1a14:	a029                	j	1a1e <stpcpy+0x2a>
    1a16:	e118                	sd	a4,0(a0)
    1a18:	6598                	ld	a4,8(a1)
    1a1a:	05a1                	addi	a1,a1,8
    1a1c:	0521                	addi	a0,a0,8
    1a1e:	00c707b3          	add	a5,a4,a2
    1a22:	fff74693          	not	a3,a4
    1a26:	8ff5                	and	a5,a5,a3
    1a28:	0107f7b3          	and	a5,a5,a6
    1a2c:	d7ed                	beqz	a5,1a16 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1a2e:	0005c783          	lbu	a5,0(a1)
    1a32:	00f50023          	sb	a5,0(a0)
    1a36:	c785                	beqz	a5,1a5e <stpcpy+0x6a>
    1a38:	0015c783          	lbu	a5,1(a1)
    1a3c:	0505                	addi	a0,a0,1
    1a3e:	0585                	addi	a1,a1,1
    1a40:	00f50023          	sb	a5,0(a0)
    1a44:	fbf5                	bnez	a5,1a38 <stpcpy+0x44>
        ;
    return d;
}
    1a46:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1a48:	0505                	addi	a0,a0,1
    1a4a:	df45                	beqz	a4,1a02 <stpcpy+0xe>
            if (!(*d = *s))
    1a4c:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1a50:	0585                	addi	a1,a1,1
    1a52:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a56:	00f50023          	sb	a5,0(a0)
    1a5a:	f7fd                	bnez	a5,1a48 <stpcpy+0x54>
}
    1a5c:	8082                	ret
    1a5e:	8082                	ret

0000000000001a60 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1a60:	00b547b3          	xor	a5,a0,a1
    1a64:	8b9d                	andi	a5,a5,7
    1a66:	1a079863          	bnez	a5,1c16 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a6a:	0075f793          	andi	a5,a1,7
    1a6e:	16078463          	beqz	a5,1bd6 <stpncpy+0x176>
    1a72:	ea01                	bnez	a2,1a82 <stpncpy+0x22>
    1a74:	a421                	j	1c7c <stpncpy+0x21c>
    1a76:	167d                	addi	a2,a2,-1
    1a78:	0505                	addi	a0,a0,1
    1a7a:	14070e63          	beqz	a4,1bd6 <stpncpy+0x176>
    1a7e:	1a060863          	beqz	a2,1c2e <stpncpy+0x1ce>
    1a82:	0005c783          	lbu	a5,0(a1)
    1a86:	0585                	addi	a1,a1,1
    1a88:	0075f713          	andi	a4,a1,7
    1a8c:	00f50023          	sb	a5,0(a0)
    1a90:	f3fd                	bnez	a5,1a76 <stpncpy+0x16>
    1a92:	4805                	li	a6,1
    1a94:	1a061863          	bnez	a2,1c44 <stpncpy+0x1e4>
    1a98:	40a007b3          	neg	a5,a0
    1a9c:	8b9d                	andi	a5,a5,7
    1a9e:	4681                	li	a3,0
    1aa0:	18061a63          	bnez	a2,1c34 <stpncpy+0x1d4>
    1aa4:	00778713          	addi	a4,a5,7
    1aa8:	45ad                	li	a1,11
    1aaa:	18b76363          	bltu	a4,a1,1c30 <stpncpy+0x1d0>
    1aae:	1ae6eb63          	bltu	a3,a4,1c64 <stpncpy+0x204>
    1ab2:	1a078363          	beqz	a5,1c58 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1ab6:	00050023          	sb	zero,0(a0)
    1aba:	4685                	li	a3,1
    1abc:	00150713          	addi	a4,a0,1
    1ac0:	18d78f63          	beq	a5,a3,1c5e <stpncpy+0x1fe>
    1ac4:	000500a3          	sb	zero,1(a0)
    1ac8:	4689                	li	a3,2
    1aca:	00250713          	addi	a4,a0,2
    1ace:	18d78e63          	beq	a5,a3,1c6a <stpncpy+0x20a>
    1ad2:	00050123          	sb	zero,2(a0)
    1ad6:	468d                	li	a3,3
    1ad8:	00350713          	addi	a4,a0,3
    1adc:	16d78c63          	beq	a5,a3,1c54 <stpncpy+0x1f4>
    1ae0:	000501a3          	sb	zero,3(a0)
    1ae4:	4691                	li	a3,4
    1ae6:	00450713          	addi	a4,a0,4
    1aea:	18d78263          	beq	a5,a3,1c6e <stpncpy+0x20e>
    1aee:	00050223          	sb	zero,4(a0)
    1af2:	4695                	li	a3,5
    1af4:	00550713          	addi	a4,a0,5
    1af8:	16d78d63          	beq	a5,a3,1c72 <stpncpy+0x212>
    1afc:	000502a3          	sb	zero,5(a0)
    1b00:	469d                	li	a3,7
    1b02:	00650713          	addi	a4,a0,6
    1b06:	16d79863          	bne	a5,a3,1c76 <stpncpy+0x216>
    1b0a:	00750713          	addi	a4,a0,7
    1b0e:	00050323          	sb	zero,6(a0)
    1b12:	40f80833          	sub	a6,a6,a5
    1b16:	ff887593          	andi	a1,a6,-8
    1b1a:	97aa                	add	a5,a5,a0
    1b1c:	95be                	add	a1,a1,a5
    1b1e:	0007b023          	sd	zero,0(a5)
    1b22:	07a1                	addi	a5,a5,8
    1b24:	feb79de3          	bne	a5,a1,1b1e <stpncpy+0xbe>
    1b28:	ff887593          	andi	a1,a6,-8
    1b2c:	9ead                	addw	a3,a3,a1
    1b2e:	00b707b3          	add	a5,a4,a1
    1b32:	12b80863          	beq	a6,a1,1c62 <stpncpy+0x202>
    1b36:	00078023          	sb	zero,0(a5)
    1b3a:	0016871b          	addiw	a4,a3,1
    1b3e:	0ec77863          	bgeu	a4,a2,1c2e <stpncpy+0x1ce>
    1b42:	000780a3          	sb	zero,1(a5)
    1b46:	0026871b          	addiw	a4,a3,2
    1b4a:	0ec77263          	bgeu	a4,a2,1c2e <stpncpy+0x1ce>
    1b4e:	00078123          	sb	zero,2(a5)
    1b52:	0036871b          	addiw	a4,a3,3
    1b56:	0cc77c63          	bgeu	a4,a2,1c2e <stpncpy+0x1ce>
    1b5a:	000781a3          	sb	zero,3(a5)
    1b5e:	0046871b          	addiw	a4,a3,4
    1b62:	0cc77663          	bgeu	a4,a2,1c2e <stpncpy+0x1ce>
    1b66:	00078223          	sb	zero,4(a5)
    1b6a:	0056871b          	addiw	a4,a3,5
    1b6e:	0cc77063          	bgeu	a4,a2,1c2e <stpncpy+0x1ce>
    1b72:	000782a3          	sb	zero,5(a5)
    1b76:	0066871b          	addiw	a4,a3,6
    1b7a:	0ac77a63          	bgeu	a4,a2,1c2e <stpncpy+0x1ce>
    1b7e:	00078323          	sb	zero,6(a5)
    1b82:	0076871b          	addiw	a4,a3,7
    1b86:	0ac77463          	bgeu	a4,a2,1c2e <stpncpy+0x1ce>
    1b8a:	000783a3          	sb	zero,7(a5)
    1b8e:	0086871b          	addiw	a4,a3,8
    1b92:	08c77e63          	bgeu	a4,a2,1c2e <stpncpy+0x1ce>
    1b96:	00078423          	sb	zero,8(a5)
    1b9a:	0096871b          	addiw	a4,a3,9
    1b9e:	08c77863          	bgeu	a4,a2,1c2e <stpncpy+0x1ce>
    1ba2:	000784a3          	sb	zero,9(a5)
    1ba6:	00a6871b          	addiw	a4,a3,10
    1baa:	08c77263          	bgeu	a4,a2,1c2e <stpncpy+0x1ce>
    1bae:	00078523          	sb	zero,10(a5)
    1bb2:	00b6871b          	addiw	a4,a3,11
    1bb6:	06c77c63          	bgeu	a4,a2,1c2e <stpncpy+0x1ce>
    1bba:	000785a3          	sb	zero,11(a5)
    1bbe:	00c6871b          	addiw	a4,a3,12
    1bc2:	06c77663          	bgeu	a4,a2,1c2e <stpncpy+0x1ce>
    1bc6:	00078623          	sb	zero,12(a5)
    1bca:	26b5                	addiw	a3,a3,13
    1bcc:	06c6f163          	bgeu	a3,a2,1c2e <stpncpy+0x1ce>
    1bd0:	000786a3          	sb	zero,13(a5)
    1bd4:	8082                	ret
            ;
        if (!n || !*s)
    1bd6:	c645                	beqz	a2,1c7e <stpncpy+0x21e>
    1bd8:	0005c783          	lbu	a5,0(a1)
    1bdc:	ea078be3          	beqz	a5,1a92 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1be0:	479d                	li	a5,7
    1be2:	02c7ff63          	bgeu	a5,a2,1c20 <stpncpy+0x1c0>
    1be6:	00000897          	auipc	a7,0x0
    1bea:	1c28b883          	ld	a7,450(a7) # 1da8 <memmove+0x128>
    1bee:	00000817          	auipc	a6,0x0
    1bf2:	1c283803          	ld	a6,450(a6) # 1db0 <memmove+0x130>
    1bf6:	431d                	li	t1,7
    1bf8:	6198                	ld	a4,0(a1)
    1bfa:	011707b3          	add	a5,a4,a7
    1bfe:	fff74693          	not	a3,a4
    1c02:	8ff5                	and	a5,a5,a3
    1c04:	0107f7b3          	and	a5,a5,a6
    1c08:	ef81                	bnez	a5,1c20 <stpncpy+0x1c0>
            *wd = *ws;
    1c0a:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1c0c:	1661                	addi	a2,a2,-8
    1c0e:	05a1                	addi	a1,a1,8
    1c10:	0521                	addi	a0,a0,8
    1c12:	fec363e3          	bltu	t1,a2,1bf8 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1c16:	e609                	bnez	a2,1c20 <stpncpy+0x1c0>
    1c18:	a08d                	j	1c7a <stpncpy+0x21a>
    1c1a:	167d                	addi	a2,a2,-1
    1c1c:	0505                	addi	a0,a0,1
    1c1e:	ca01                	beqz	a2,1c2e <stpncpy+0x1ce>
    1c20:	0005c783          	lbu	a5,0(a1)
    1c24:	0585                	addi	a1,a1,1
    1c26:	00f50023          	sb	a5,0(a0)
    1c2a:	fbe5                	bnez	a5,1c1a <stpncpy+0x1ba>
        ;
tail:
    1c2c:	b59d                	j	1a92 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1c2e:	8082                	ret
    1c30:	472d                	li	a4,11
    1c32:	bdb5                	j	1aae <stpncpy+0x4e>
    1c34:	00778713          	addi	a4,a5,7
    1c38:	45ad                	li	a1,11
    1c3a:	fff60693          	addi	a3,a2,-1
    1c3e:	e6b778e3          	bgeu	a4,a1,1aae <stpncpy+0x4e>
    1c42:	b7fd                	j	1c30 <stpncpy+0x1d0>
    1c44:	40a007b3          	neg	a5,a0
    1c48:	8832                	mv	a6,a2
    1c4a:	8b9d                	andi	a5,a5,7
    1c4c:	4681                	li	a3,0
    1c4e:	e4060be3          	beqz	a2,1aa4 <stpncpy+0x44>
    1c52:	b7cd                	j	1c34 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1c54:	468d                	li	a3,3
    1c56:	bd75                	j	1b12 <stpncpy+0xb2>
    1c58:	872a                	mv	a4,a0
    1c5a:	4681                	li	a3,0
    1c5c:	bd5d                	j	1b12 <stpncpy+0xb2>
    1c5e:	4685                	li	a3,1
    1c60:	bd4d                	j	1b12 <stpncpy+0xb2>
    1c62:	8082                	ret
    1c64:	87aa                	mv	a5,a0
    1c66:	4681                	li	a3,0
    1c68:	b5f9                	j	1b36 <stpncpy+0xd6>
    1c6a:	4689                	li	a3,2
    1c6c:	b55d                	j	1b12 <stpncpy+0xb2>
    1c6e:	4691                	li	a3,4
    1c70:	b54d                	j	1b12 <stpncpy+0xb2>
    1c72:	4695                	li	a3,5
    1c74:	bd79                	j	1b12 <stpncpy+0xb2>
    1c76:	4699                	li	a3,6
    1c78:	bd69                	j	1b12 <stpncpy+0xb2>
    1c7a:	8082                	ret
    1c7c:	8082                	ret
    1c7e:	8082                	ret

0000000000001c80 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1c80:	fff6071b          	addiw	a4,a2,-1
    1c84:	0cb57063          	bgeu	a0,a1,1d44 <memmove+0xc4>
        while (n-- > 0)
    1c88:	0ec05063          	blez	a2,1d68 <memmove+0xe8>
    1c8c:	00750693          	addi	a3,a0,7
    1c90:	8e8d                	sub	a3,a3,a1
    1c92:	00b567b3          	or	a5,a0,a1
    1c96:	00f6b693          	sltiu	a3,a3,15
    1c9a:	8b9d                	andi	a5,a5,7
    1c9c:	0016c693          	xori	a3,a3,1
    1ca0:	0017b793          	seqz	a5,a5
    1ca4:	8ff5                	and	a5,a5,a3
    1ca6:	c3f1                	beqz	a5,1d6a <memmove+0xea>
    1ca8:	0007079b          	sext.w	a5,a4
    1cac:	46a5                	li	a3,9
    1cae:	0af6fe63          	bgeu	a3,a5,1d6a <memmove+0xea>
    1cb2:	0036589b          	srliw	a7,a2,0x3
    1cb6:	088e                	slli	a7,a7,0x3
    1cb8:	2601                	sext.w	a2,a2
    1cba:	87ae                	mv	a5,a1
    1cbc:	86aa                	mv	a3,a0
    1cbe:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1cc0:	0007b803          	ld	a6,0(a5)
    1cc4:	07a1                	addi	a5,a5,8
    1cc6:	06a1                	addi	a3,a3,8
    1cc8:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1ccc:	ff179ae3          	bne	a5,a7,1cc0 <memmove+0x40>
    1cd0:	ff867813          	andi	a6,a2,-8
    1cd4:	02081793          	slli	a5,a6,0x20
    1cd8:	9381                	srli	a5,a5,0x20
    1cda:	00f506b3          	add	a3,a0,a5
    1cde:	95be                	add	a1,a1,a5
    1ce0:	4107073b          	subw	a4,a4,a6
    1ce4:	09060263          	beq	a2,a6,1d68 <memmove+0xe8>
            *dst++ = *src++;
    1ce8:	0005c783          	lbu	a5,0(a1)
    1cec:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1cf0:	06e05c63          	blez	a4,1d68 <memmove+0xe8>
            *dst++ = *src++;
    1cf4:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1cf8:	4785                	li	a5,1
            *dst++ = *src++;
    1cfa:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1cfe:	06e7d563          	bge	a5,a4,1d68 <memmove+0xe8>
            *dst++ = *src++;
    1d02:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1d06:	4789                	li	a5,2
            *dst++ = *src++;
    1d08:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1d0c:	04e7de63          	bge	a5,a4,1d68 <memmove+0xe8>
            *dst++ = *src++;
    1d10:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1d14:	478d                	li	a5,3
            *dst++ = *src++;
    1d16:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1d1a:	04e7d763          	bge	a5,a4,1d68 <memmove+0xe8>
            *dst++ = *src++;
    1d1e:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1d22:	4791                	li	a5,4
            *dst++ = *src++;
    1d24:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1d28:	04e7d063          	bge	a5,a4,1d68 <memmove+0xe8>
            *dst++ = *src++;
    1d2c:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1d30:	4795                	li	a5,5
            *dst++ = *src++;
    1d32:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1d36:	02e7d963          	bge	a5,a4,1d68 <memmove+0xe8>
            *dst++ = *src++;
    1d3a:	0065c783          	lbu	a5,6(a1)
    1d3e:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1d42:	8082                	ret
    } else {
        dst += n;
    1d44:	00c507b3          	add	a5,a0,a2
        src += n;
    1d48:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1d4a:	00c05f63          	blez	a2,1d68 <memmove+0xe8>
    1d4e:	1702                	slli	a4,a4,0x20
    1d50:	9301                	srli	a4,a4,0x20
    1d52:	fff74713          	not	a4,a4
    1d56:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1d58:	fff5c683          	lbu	a3,-1(a1)
    1d5c:	17fd                	addi	a5,a5,-1
    1d5e:	15fd                	addi	a1,a1,-1
    1d60:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1d64:	fee79ae3          	bne	a5,a4,1d58 <memmove+0xd8>
    }
    return vdst;
}
    1d68:	8082                	ret
    1d6a:	02071693          	slli	a3,a4,0x20
    1d6e:	9281                	srli	a3,a3,0x20
    1d70:	0685                	addi	a3,a3,1
    1d72:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1d74:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1d76:	0005c703          	lbu	a4,0(a1)
    1d7a:	0585                	addi	a1,a1,1
    1d7c:	0785                	addi	a5,a5,1
    1d7e:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1d82:	fed59ae3          	bne	a1,a3,1d76 <memmove+0xf6>
    1d86:	8082                	ret
