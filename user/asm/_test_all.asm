
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_all:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a2c9                	j	11c2 <__start_main>

Disassembly of section .text:

0000000000001002 <run_testcase>:
    "test_readwrite",
    "test_pid",
    "matrix",
};

int run_testcase(const char *testcase, int n, int all_cnt) {
    1002:	7139                	addi	sp,sp,-64
    1004:	f822                	sd	s0,48(sp)
    1006:	f426                	sd	s1,40(sp)
    1008:	f04a                	sd	s2,32(sp)
    100a:	fc06                	sd	ra,56(sp)
    100c:	ec4e                	sd	s3,24(sp)
    100e:	842a                	mv	s0,a0
    1010:	84ae                	mv	s1,a1
    1012:	8932                	mv	s2,a2
    int pid = fork();
    1014:	5d5000ef          	jal	ra,1de8 <fork>
    if (pid == 0) {
    1018:	c939                	beqz	a0,106e <run_testcase+0x6c>
        // child
        exec(testcase);
        printf("\x1b[31m[FAILED]\x1b[0m exec() error\n");
    } else if (pid < 0) {
    101a:	02054b63          	bltz	a0,1050 <run_testcase+0x4e>
        printf("fork() error\n");
    } else {
        // parent
        int exit_code;
        int wait_pid = waitpid(pid, &exit_code);
    101e:	006c                	addi	a1,sp,12
    1020:	595000ef          	jal	ra,1db4 <waitpid>
        if (wait_pid <= 0) {
    1024:	08a05663          	blez	a0,10b0 <run_testcase+0xae>
            printf("\x1b[31m[FAILED]\x1b[0m wait() error\n");
            return 1;
        }

        if (exit_code == 0) {
    1028:	49b2                	lw	s3,12(sp)
            printf("\x1b[32m[PASSED %d/%d]\x1b[0m %s\n", n, all_cnt, testcase);
    102a:	86a2                	mv	a3,s0
    102c:	864a                	mv	a2,s2
    102e:	85a6                	mv	a1,s1
        if (exit_code == 0) {
    1030:	06099163          	bnez	s3,1092 <run_testcase+0x90>
            printf("\x1b[32m[PASSED %d/%d]\x1b[0m %s\n", n, all_cnt, testcase);
    1034:	00001517          	auipc	a0,0x1
    1038:	edc50513          	addi	a0,a0,-292 # 1f10 <sharedmem+0x5a>
    103c:	21c000ef          	jal	ra,1258 <printf>
            printf("\x1b[31m[FAILED %d/%d]\x1b[0m %s\n", n, all_cnt, testcase);
            return 1;
        }
    }
    return 1;
}
    1040:	70e2                	ld	ra,56(sp)
    1042:	7442                	ld	s0,48(sp)
    1044:	74a2                	ld	s1,40(sp)
    1046:	7902                	ld	s2,32(sp)
    1048:	854e                	mv	a0,s3
    104a:	69e2                	ld	s3,24(sp)
    104c:	6121                	addi	sp,sp,64
    104e:	8082                	ret
        printf("fork() error\n");
    1050:	00001517          	auipc	a0,0x1
    1054:	e9050513          	addi	a0,a0,-368 # 1ee0 <sharedmem+0x2a>
    1058:	200000ef          	jal	ra,1258 <printf>
    return 1;
    105c:	4985                	li	s3,1
}
    105e:	70e2                	ld	ra,56(sp)
    1060:	7442                	ld	s0,48(sp)
    1062:	74a2                	ld	s1,40(sp)
    1064:	7902                	ld	s2,32(sp)
    1066:	854e                	mv	a0,s3
    1068:	69e2                	ld	s3,24(sp)
    106a:	6121                	addi	sp,sp,64
    106c:	8082                	ret
        exec(testcase);
    106e:	8522                	mv	a0,s0
    1070:	4d3000ef          	jal	ra,1d42 <exec>
        printf("\x1b[31m[FAILED]\x1b[0m exec() error\n");
    1074:	00001517          	auipc	a0,0x1
    1078:	e4c50513          	addi	a0,a0,-436 # 1ec0 <sharedmem+0xa>
    107c:	1dc000ef          	jal	ra,1258 <printf>
}
    1080:	70e2                	ld	ra,56(sp)
    1082:	7442                	ld	s0,48(sp)
        printf("\x1b[31m[FAILED]\x1b[0m exec() error\n");
    1084:	4985                	li	s3,1
}
    1086:	74a2                	ld	s1,40(sp)
    1088:	7902                	ld	s2,32(sp)
    108a:	854e                	mv	a0,s3
    108c:	69e2                	ld	s3,24(sp)
    108e:	6121                	addi	sp,sp,64
    1090:	8082                	ret
            printf("\x1b[31m[FAILED %d/%d]\x1b[0m %s\n", n, all_cnt, testcase);
    1092:	00001517          	auipc	a0,0x1
    1096:	e9e50513          	addi	a0,a0,-354 # 1f30 <sharedmem+0x7a>
    109a:	1be000ef          	jal	ra,1258 <printf>
}
    109e:	70e2                	ld	ra,56(sp)
    10a0:	7442                	ld	s0,48(sp)
            return 1;
    10a2:	4985                	li	s3,1
}
    10a4:	74a2                	ld	s1,40(sp)
    10a6:	7902                	ld	s2,32(sp)
    10a8:	854e                	mv	a0,s3
    10aa:	69e2                	ld	s3,24(sp)
    10ac:	6121                	addi	sp,sp,64
    10ae:	8082                	ret
            printf("\x1b[31m[FAILED]\x1b[0m wait() error\n");
    10b0:	00001517          	auipc	a0,0x1
    10b4:	e4050513          	addi	a0,a0,-448 # 1ef0 <sharedmem+0x3a>
    10b8:	1a0000ef          	jal	ra,1258 <printf>
            return 1;
    10bc:	4985                	li	s3,1
    10be:	b745                	j	105e <run_testcase+0x5c>

00000000000010c0 <main>:

int main(int argc, char *argv[]) {
    10c0:	711d                	addi	sp,sp,-96
    printf("Running all tests on uCore-SMP\n");
    10c2:	00001517          	auipc	a0,0x1
    10c6:	e8e50513          	addi	a0,a0,-370 # 1f50 <sharedmem+0x9a>
int main(int argc, char *argv[]) {
    10ca:	e8a2                	sd	s0,80(sp)
    10cc:	e4a6                	sd	s1,72(sp)
    10ce:	e0ca                	sd	s2,64(sp)
    10d0:	f852                	sd	s4,48(sp)
    10d2:	f456                	sd	s5,40(sp)
    10d4:	f05a                	sd	s6,32(sp)
    10d6:	ec5e                	sd	s7,24(sp)
    10d8:	e862                	sd	s8,16(sp)
    10da:	ec86                	sd	ra,88(sp)
    10dc:	fc4e                	sd	s3,56(sp)
    10de:	00001497          	auipc	s1,0x1
    10e2:	fa248493          	addi	s1,s1,-94 # 2080 <testcases>
    printf("Running all tests on uCore-SMP\n");
    10e6:	172000ef          	jal	ra,1258 <printf>

    int n_testcase = sizeof(testcases) / sizeof(testcases[0]);
    int failed = 0;
    for (int i = 0; i < n_testcase; i++) {
    10ea:	4401                	li	s0,0
    int failed = 0;
    10ec:	4901                	li	s2,0
            printf("\x1b[31m[FAILED %d/%d]\x1b[0m %s\n", n, all_cnt, testcase);
    10ee:	00001b97          	auipc	s7,0x1
    10f2:	e42b8b93          	addi	s7,s7,-446 # 1f30 <sharedmem+0x7a>
            printf("\x1b[32m[PASSED %d/%d]\x1b[0m %s\n", n, all_cnt, testcase);
    10f6:	00001a17          	auipc	s4,0x1
    10fa:	e1aa0a13          	addi	s4,s4,-486 # 1f10 <sharedmem+0x5a>
            printf("\x1b[31m[FAILED]\x1b[0m wait() error\n");
    10fe:	00001c17          	auipc	s8,0x1
    1102:	df2c0c13          	addi	s8,s8,-526 # 1ef0 <sharedmem+0x3a>
        printf("fork() error\n");
    1106:	00001b17          	auipc	s6,0x1
    110a:	ddab0b13          	addi	s6,s6,-550 # 1ee0 <sharedmem+0x2a>
        printf("\x1b[31m[FAILED]\x1b[0m exec() error\n");
    110e:	00001a97          	auipc	s5,0x1
    1112:	db2a8a93          	addi	s5,s5,-590 # 1ec0 <sharedmem+0xa>
    1116:	a02d                	j	1140 <main+0x80>
        int wait_pid = waitpid(pid, &exit_code);
    1118:	006c                	addi	a1,sp,12
    } else if (pid < 0) {
    111a:	06054d63          	bltz	a0,1194 <main+0xd4>
        int wait_pid = waitpid(pid, &exit_code);
    111e:	497000ef          	jal	ra,1db4 <waitpid>
    1122:	87aa                	mv	a5,a0
            printf("\x1b[32m[PASSED %d/%d]\x1b[0m %s\n", n, all_cnt, testcase);
    1124:	86ce                	mv	a3,s3
    1126:	462d                	li	a2,11
    1128:	85a2                	mv	a1,s0
    112a:	8552                	mv	a0,s4
        if (wait_pid <= 0) {
    112c:	06f05f63          	blez	a5,11aa <main+0xea>
        if (exit_code == 0) {
    1130:	47b2                	lw	a5,12(sp)
    1132:	e7b5                	bnez	a5,119e <main+0xde>
            printf("\x1b[32m[PASSED %d/%d]\x1b[0m %s\n", n, all_cnt, testcase);
    1134:	124000ef          	jal	ra,1258 <printf>
    for (int i = 0; i < n_testcase; i++) {
    1138:	47ad                	li	a5,11
    113a:	04a1                	addi	s1,s1,8
    113c:	02f40363          	beq	s0,a5,1162 <main+0xa2>
        failed += run_testcase(testcases[i], i + 1, n_testcase);
    1140:	0004b983          	ld	s3,0(s1)
    int pid = fork();
    1144:	4a5000ef          	jal	ra,1de8 <fork>
        failed += run_testcase(testcases[i], i + 1, n_testcase);
    1148:	2405                	addiw	s0,s0,1
    if (pid == 0) {
    114a:	f579                	bnez	a0,1118 <main+0x58>
        exec(testcase);
    114c:	854e                	mv	a0,s3
    114e:	3f5000ef          	jal	ra,1d42 <exec>
        printf("\x1b[31m[FAILED]\x1b[0m exec() error\n");
    1152:	8556                	mv	a0,s5
    1154:	104000ef          	jal	ra,1258 <printf>
    for (int i = 0; i < n_testcase; i++) {
    1158:	47ad                	li	a5,11
    115a:	2905                	addiw	s2,s2,1
    115c:	04a1                	addi	s1,s1,8
    115e:	fef411e3          	bne	s0,a5,1140 <main+0x80>
    }
    if (failed > 0) {
    1162:	04090963          	beqz	s2,11b4 <main+0xf4>
        printf("Tests passed: %d/%d\n", n_testcase - failed, n_testcase);
    1166:	45ad                	li	a1,11
    1168:	462d                	li	a2,11
    116a:	412585bb          	subw	a1,a1,s2
    116e:	00001517          	auipc	a0,0x1
    1172:	e0250513          	addi	a0,a0,-510 # 1f70 <sharedmem+0xba>
    1176:	0e2000ef          	jal	ra,1258 <printf>
    } else {
        printf("\x1b[32m[PASSED]\x1b[0m All tests passed\n");
    }
    return 0;
}
    117a:	60e6                	ld	ra,88(sp)
    117c:	6446                	ld	s0,80(sp)
    117e:	64a6                	ld	s1,72(sp)
    1180:	6906                	ld	s2,64(sp)
    1182:	79e2                	ld	s3,56(sp)
    1184:	7a42                	ld	s4,48(sp)
    1186:	7aa2                	ld	s5,40(sp)
    1188:	7b02                	ld	s6,32(sp)
    118a:	6be2                	ld	s7,24(sp)
    118c:	6c42                	ld	s8,16(sp)
    118e:	4501                	li	a0,0
    1190:	6125                	addi	sp,sp,96
    1192:	8082                	ret
        printf("fork() error\n");
    1194:	855a                	mv	a0,s6
    1196:	0c2000ef          	jal	ra,1258 <printf>
    119a:	2905                	addiw	s2,s2,1
    119c:	bf71                	j	1138 <main+0x78>
            printf("\x1b[31m[FAILED %d/%d]\x1b[0m %s\n", n, all_cnt, testcase);
    119e:	462d                	li	a2,11
    11a0:	855e                	mv	a0,s7
    11a2:	0b6000ef          	jal	ra,1258 <printf>
            return 1;
    11a6:	2905                	addiw	s2,s2,1
    11a8:	bf41                	j	1138 <main+0x78>
            printf("\x1b[31m[FAILED]\x1b[0m wait() error\n");
    11aa:	8562                	mv	a0,s8
    11ac:	0ac000ef          	jal	ra,1258 <printf>
            return 1;
    11b0:	2905                	addiw	s2,s2,1
    11b2:	b759                	j	1138 <main+0x78>
        printf("\x1b[32m[PASSED]\x1b[0m All tests passed\n");
    11b4:	00001517          	auipc	a0,0x1
    11b8:	dd450513          	addi	a0,a0,-556 # 1f88 <sharedmem+0xd2>
    11bc:	09c000ef          	jal	ra,1258 <printf>
    11c0:	bf6d                	j	117a <main+0xba>

00000000000011c2 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    11c2:	1141                	addi	sp,sp,-16
    11c4:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    11c6:	efbff0ef          	jal	ra,10c0 <main>
}
    11ca:	60a2                	ld	ra,8(sp)
    11cc:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    11ce:	3830006f          	j	1d50 <exit>

00000000000011d2 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    11d2:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    11d4:	00f10593          	addi	a1,sp,15
    11d8:	4605                	li	a2,1
    11da:	4501                	li	a0,0
int getchar() {
    11dc:	ec06                	sd	ra,24(sp)
    char byte = 0;
    11de:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    11e2:	379000ef          	jal	ra,1d5a <read>
    return byte;
}
    11e6:	60e2                	ld	ra,24(sp)
    11e8:	00f14503          	lbu	a0,15(sp)
    11ec:	6105                	addi	sp,sp,32
    11ee:	8082                	ret

00000000000011f0 <putchar>:

int putchar(int c)
{
    11f0:	1141                	addi	sp,sp,-16
    11f2:	e406                	sd	ra,8(sp)
    11f4:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    11f6:	00001597          	auipc	a1,0x1
    11fa:	e8258593          	addi	a1,a1,-382 # 2078 <put.1156>
    return write(stdout, put, 1);
    11fe:	4605                	li	a2,1
    1200:	4505                	li	a0,1
    put[0] = c;
    1202:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1206:	35f000ef          	jal	ra,1d64 <write>
}
    120a:	60a2                	ld	ra,8(sp)
    120c:	2501                	sext.w	a0,a0
    120e:	0141                	addi	sp,sp,16
    1210:	8082                	ret

0000000000001212 <puts>:

int puts(const char* s)
{
    1212:	1141                	addi	sp,sp,-16
    1214:	e022                	sd	s0,0(sp)
    1216:	e406                	sd	ra,8(sp)
    1218:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    121a:	66e000ef          	jal	ra,1888 <strlen>
    121e:	862a                	mv	a2,a0
    1220:	85a2                	mv	a1,s0
    1222:	4505                	li	a0,1
    1224:	341000ef          	jal	ra,1d64 <write>
    1228:	00055763          	bgez	a0,1236 <puts+0x24>
    return r;
}
    122c:	60a2                	ld	ra,8(sp)
    122e:	6402                	ld	s0,0(sp)
    1230:	557d                	li	a0,-1
    1232:	0141                	addi	sp,sp,16
    1234:	8082                	ret
    put[0] = c;
    1236:	00001597          	auipc	a1,0x1
    123a:	e4258593          	addi	a1,a1,-446 # 2078 <put.1156>
    123e:	47a9                	li	a5,10
    return write(stdout, put, 1);
    1240:	4605                	li	a2,1
    1242:	4505                	li	a0,1
    put[0] = c;
    1244:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1248:	31d000ef          	jal	ra,1d64 <write>
}
    124c:	60a2                	ld	ra,8(sp)
    124e:	6402                	ld	s0,0(sp)
    1250:	41f5551b          	sraiw	a0,a0,0x1f
    1254:	0141                	addi	sp,sp,16
    1256:	8082                	ret

0000000000001258 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    1258:	7115                	addi	sp,sp,-224
    125a:	ed06                	sd	ra,152(sp)
    125c:	e922                	sd	s0,144(sp)
    125e:	e526                	sd	s1,136(sp)
    1260:	e14a                	sd	s2,128(sp)
    1262:	fcce                	sd	s3,120(sp)
    1264:	f8d2                	sd	s4,112(sp)
    1266:	f4d6                	sd	s5,104(sp)
    1268:	f0da                	sd	s6,96(sp)
    126a:	ecde                	sd	s7,88(sp)
    126c:	e8e2                	sd	s8,80(sp)
    126e:	e4e6                	sd	s9,72(sp)
    1270:	e0ea                	sd	s10,64(sp)
    1272:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1274:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    1278:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    127a:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    127c:	f52e                	sd	a1,168(sp)
    127e:	f932                	sd	a2,176(sp)
    1280:	fd36                	sd	a3,184(sp)
    1282:	e1ba                	sd	a4,192(sp)
    1284:	e9c2                	sd	a6,208(sp)
    1286:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    1288:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    128a:	0c030b63          	beqz	t1,1360 <printf+0x108>
    128e:	8aaa                	mv	s5,a0
    1290:	0003071b          	sext.w	a4,t1
    1294:	4481                	li	s1,0
        if (c != '%') {
    1296:	02500b93          	li	s7,37
    put[0] = c;
    129a:	00001417          	auipc	s0,0x1
    129e:	dde40413          	addi	s0,s0,-546 # 2078 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    12a2:	4c51                	li	s8,20
    put[0] = c;
    12a4:	02500c93          	li	s9,37
    12a8:	00001a17          	auipc	s4,0x1
    12ac:	e30a0a13          	addi	s4,s4,-464 # 20d8 <testcases+0x58>
    12b0:	00001997          	auipc	s3,0x1
    12b4:	e8098993          	addi	s3,s3,-384 # 2130 <digits>
    12b8:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    12bc:	0014879b          	addiw	a5,s1,1
    12c0:	00fa8933          	add	s2,s5,a5
    12c4:	13771163          	bne	a4,s7,13e6 <printf+0x18e>
        c = fmt[++i] & 0xff;
    12c8:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    12cc:	080d0a63          	beqz	s10,1360 <printf+0x108>
        switch (c) {
    12d0:	2489                	addiw	s1,s1,2
    12d2:	009a8933          	add	s2,s5,s1
    12d6:	257d0e63          	beq	s10,s7,1532 <printf+0x2da>
    12da:	f9cd079b          	addiw	a5,s10,-100
    12de:	0ff7f793          	andi	a5,a5,255
    12e2:	0cfc6263          	bltu	s8,a5,13a6 <printf+0x14e>
    12e6:	078a                	slli	a5,a5,0x2
    12e8:	97d2                	add	a5,a5,s4
    12ea:	439c                	lw	a5,0(a5)
    12ec:	97d2                	add	a5,a5,s4
    12ee:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    12f0:	67a2                	ld	a5,8(sp)
    12f2:	4398                	lw	a4,0(a5)
    12f4:	07a1                	addi	a5,a5,8
    12f6:	e43e                	sd	a5,8(sp)
    12f8:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    12fc:	26074663          	bltz	a4,1568 <printf+0x310>
        buf[i++] = digits[x % base];
    1300:	8bbd                	andi	a5,a5,15
    1302:	97ce                	add	a5,a5,s3
    1304:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1308:	40475d1b          	sraiw	s10,a4,0x4
    130c:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    1310:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    1314:	020d0163          	beqz	s10,1336 <printf+0xde>
        buf[i++] = digits[x % base];
    1318:	9d4e                	add	s10,s10,s3
    131a:	000d4783          	lbu	a5,0(s10)
    131e:	4d05                	li	s10,1
    1320:	00f108a3          	sb	a5,17(sp)
    if (sign)
    1324:	00075963          	bgez	a4,1336 <printf+0xde>
        buf[i++] = digits[x % base];
    1328:	4d09                	li	s10,2
        buf[i++] = '-';
    132a:	181c                	addi	a5,sp,48
    132c:	02d00713          	li	a4,45
    1330:	97ea                	add	a5,a5,s10
    1332:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    1336:	9d5a                	add	s10,s10,s6
    1338:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    133c:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1340:	4605                	li	a2,1
    1342:	1d7d                	addi	s10,s10,-1
    1344:	85a2                	mv	a1,s0
    1346:	4505                	li	a0,1
    put[0] = c;
    1348:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    134c:	219000ef          	jal	ra,1d64 <write>
    while (--i >= 0)
    1350:	ffbd16e3          	bne	s10,s11,133c <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1354:	00094303          	lbu	t1,0(s2)
    1358:	0003071b          	sext.w	a4,t1
    135c:	f60310e3          	bnez	t1,12bc <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    1360:	60ea                	ld	ra,152(sp)
    1362:	644a                	ld	s0,144(sp)
    1364:	64aa                	ld	s1,136(sp)
    1366:	690a                	ld	s2,128(sp)
    1368:	79e6                	ld	s3,120(sp)
    136a:	7a46                	ld	s4,112(sp)
    136c:	7aa6                	ld	s5,104(sp)
    136e:	7b06                	ld	s6,96(sp)
    1370:	6be6                	ld	s7,88(sp)
    1372:	6c46                	ld	s8,80(sp)
    1374:	6ca6                	ld	s9,72(sp)
    1376:	6d06                	ld	s10,64(sp)
    1378:	7de2                	ld	s11,56(sp)
    137a:	612d                	addi	sp,sp,224
    137c:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    137e:	67a2                	ld	a5,8(sp)
    1380:	0007bd03          	ld	s10,0(a5)
    1384:	07a1                	addi	a5,a5,8
    1386:	e43e                	sd	a5,8(sp)
    1388:	000d1b63          	bnez	s10,139e <printf+0x146>
    138c:	aafd                	j	158a <printf+0x332>
    return write(stdout, put, 1);
    138e:	4605                	li	a2,1
    1390:	85a2                	mv	a1,s0
    1392:	4505                	li	a0,1
                for (; *s; s++)
    1394:	0d05                	addi	s10,s10,1
    put[0] = c;
    1396:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    139a:	1cb000ef          	jal	ra,1d64 <write>
                for (; *s; s++)
    139e:	000d4783          	lbu	a5,0(s10)
    13a2:	f7f5                	bnez	a5,138e <printf+0x136>
    13a4:	a02d                	j	13ce <printf+0x176>
    return write(stdout, put, 1);
    13a6:	4605                	li	a2,1
    13a8:	00001597          	auipc	a1,0x1
    13ac:	cd058593          	addi	a1,a1,-816 # 2078 <put.1156>
    13b0:	4505                	li	a0,1
    put[0] = c;
    13b2:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    13b6:	1af000ef          	jal	ra,1d64 <write>
    13ba:	4605                	li	a2,1
    13bc:	00001597          	auipc	a1,0x1
    13c0:	cbc58593          	addi	a1,a1,-836 # 2078 <put.1156>
    13c4:	4505                	li	a0,1
    put[0] = c;
    13c6:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    13ca:	19b000ef          	jal	ra,1d64 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    13ce:	00094303          	lbu	t1,0(s2)
    13d2:	0003071b          	sext.w	a4,t1
    13d6:	f80305e3          	beqz	t1,1360 <printf+0x108>
        if (c != '%') {
    13da:	0014879b          	addiw	a5,s1,1
    13de:	00fa8933          	add	s2,s5,a5
    13e2:	ef7703e3          	beq	a4,s7,12c8 <printf+0x70>
    return write(stdout, put, 1);
    13e6:	4605                	li	a2,1
    13e8:	00001597          	auipc	a1,0x1
    13ec:	c9058593          	addi	a1,a1,-880 # 2078 <put.1156>
    13f0:	4505                	li	a0,1
    put[0] = c;
    13f2:	00640023          	sb	t1,0(s0)
            continue;
    13f6:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    13f8:	16d000ef          	jal	ra,1d64 <write>
            continue;
    13fc:	bfc9                	j	13ce <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    13fe:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    1400:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    1402:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    1404:	0007b883          	ld	a7,0(a5)
    1408:	07a1                	addi	a5,a5,8
    140a:	e43e                	sd	a5,8(sp)
        x = -xx;
    140c:	43f8d713          	srai	a4,a7,0x3f
    1410:	011747b3          	xor	a5,a4,a7
    1414:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    1416:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    1418:	02c7f733          	remu	a4,a5,a2
    141c:	8d36                	mv	s10,a3
    141e:	0685                	addi	a3,a3,1
    1420:	00db0533          	add	a0,s6,a3
    1424:	85be                	mv	a1,a5
    1426:	974e                	add	a4,a4,s3
    1428:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    142c:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    1430:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    1434:	feb862e3          	bltu	a6,a1,1418 <printf+0x1c0>
    if (sign)
    1438:	1208c063          	bltz	a7,1558 <printf+0x300>
    while (--i >= 0)
    143c:	9d5a                	add	s10,s10,s6
    put[0] = c;
    143e:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1442:	4605                	li	a2,1
    1444:	85a2                	mv	a1,s0
    1446:	4505                	li	a0,1
    put[0] = c;
    1448:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    144c:	119000ef          	jal	ra,1d64 <write>
    while (--i >= 0)
    1450:	87ea                	mv	a5,s10
    1452:	1d7d                	addi	s10,s10,-1
    1454:	fefb15e3          	bne	s6,a5,143e <printf+0x1e6>
    1458:	bf9d                	j	13ce <printf+0x176>
                printptr(va_arg(ap, uint64));
    145a:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    145c:	4605                	li	a2,1
    145e:	00001597          	auipc	a1,0x1
    1462:	c1a58593          	addi	a1,a1,-998 # 2078 <put.1156>
                printptr(va_arg(ap, uint64));
    1466:	0007bd83          	ld	s11,0(a5)
    146a:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    146e:	4505                	li	a0,1
    put[0] = c;
    1470:	03000793          	li	a5,48
    1474:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    1478:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    147a:	0eb000ef          	jal	ra,1d64 <write>
    put[0] = c;
    147e:	07800793          	li	a5,120
    return write(stdout, put, 1);
    1482:	4605                	li	a2,1
    1484:	00001597          	auipc	a1,0x1
    1488:	bf458593          	addi	a1,a1,-1036 # 2078 <put.1156>
    148c:	4505                	li	a0,1
    put[0] = c;
    148e:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1492:	4d41                	li	s10,16
    1494:	0d1000ef          	jal	ra,1d64 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    1498:	03cdd793          	srli	a5,s11,0x3c
    149c:	97ce                	add	a5,a5,s3
    put[0] = c;
    149e:	0007c783          	lbu	a5,0(a5)
    14a2:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    14a4:	4605                	li	a2,1
    14a6:	85a2                	mv	a1,s0
    14a8:	4505                	li	a0,1
    put[0] = c;
    14aa:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    14ae:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    14b0:	0b5000ef          	jal	ra,1d64 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    14b4:	fe0d12e3          	bnez	s10,1498 <printf+0x240>
    14b8:	bf19                	j	13ce <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    14ba:	67a2                	ld	a5,8(sp)
    14bc:	4394                	lw	a3,0(a5)
    14be:	07a1                	addi	a5,a5,8
    14c0:	e43e                	sd	a5,8(sp)
    14c2:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    14c6:	0006d663          	bgez	a3,14d2 <printf+0x27a>
        x = -xx;
    14ca:	40f007bb          	negw	a5,a5
    14ce:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    14d2:	4729                	li	a4,10
    14d4:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    14d8:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    14dc:	964e                	add	a2,a2,s3
    14de:	00064603          	lbu	a2,0(a2)
    14e2:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    14e6:	0a0d0963          	beqz	s10,1598 <printf+0x340>
        buf[i++] = digits[x % base];
    14ea:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    14ee:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    14f2:	00c98733          	add	a4,s3,a2
    14f6:	00074703          	lbu	a4,0(a4)
    14fa:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    14fe:	c3cd                	beqz	a5,15a0 <printf+0x348>
        buf[i++] = digits[x % base];
    1500:	97ce                	add	a5,a5,s3
    1502:	0007c703          	lbu	a4,0(a5)
    1506:	4d09                	li	s10,2
    1508:	478d                	li	a5,3
    150a:	00e10923          	sb	a4,18(sp)
    if (sign)
    150e:	0206cd63          	bltz	a3,1548 <printf+0x2f0>
    while (--i >= 0)
    1512:	9d5a                	add	s10,s10,s6
    1514:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1518:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    151c:	4605                	li	a2,1
    151e:	1d7d                	addi	s10,s10,-1
    1520:	85a2                	mv	a1,s0
    1522:	4505                	li	a0,1
    put[0] = c;
    1524:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1528:	03d000ef          	jal	ra,1d64 <write>
    while (--i >= 0)
    152c:	ffbd16e3          	bne	s10,s11,1518 <printf+0x2c0>
    1530:	bd79                	j	13ce <printf+0x176>
    return write(stdout, put, 1);
    1532:	4605                	li	a2,1
    1534:	00001597          	auipc	a1,0x1
    1538:	b4458593          	addi	a1,a1,-1212 # 2078 <put.1156>
    153c:	4505                	li	a0,1
    put[0] = c;
    153e:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    1542:	023000ef          	jal	ra,1d64 <write>
    1546:	b561                	j	13ce <printf+0x176>
        buf[i++] = '-';
    1548:	1818                	addi	a4,sp,48
    154a:	973e                	add	a4,a4,a5
    154c:	02d00693          	li	a3,45
    1550:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    1554:	8d3e                	mv	s10,a5
    1556:	bf75                	j	1512 <printf+0x2ba>
        buf[i++] = '-';
    1558:	181c                	addi	a5,sp,48
    155a:	97b6                	add	a5,a5,a3
    155c:	02d00713          	li	a4,45
    1560:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    1564:	8d36                	mv	s10,a3
    1566:	bdd9                	j	143c <printf+0x1e4>
        x = -xx;
    1568:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    156c:	00f7f693          	andi	a3,a5,15
    1570:	96ce                	add	a3,a3,s3
    1572:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    1576:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    157a:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    157e:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1582:	d80d1be3          	bnez	s10,1318 <printf+0xc0>
        buf[i++] = digits[x % base];
    1586:	4d05                	li	s10,1
    1588:	b34d                	j	132a <printf+0xd2>
                s = "(null)";
    158a:	00001d17          	auipc	s10,0x1
    158e:	aced0d13          	addi	s10,s10,-1330 # 2058 <sharedmem+0x1a2>
                for (; *s; s++)
    1592:	02800793          	li	a5,40
    1596:	bbe5                	j	138e <printf+0x136>
        buf[i++] = digits[x % base];
    1598:	4785                	li	a5,1
    if (sign)
    159a:	f606dce3          	bgez	a3,1512 <printf+0x2ba>
    159e:	b76d                	j	1548 <printf+0x2f0>
        buf[i++] = digits[x % base];
    15a0:	4789                	li	a5,2
    15a2:	4d05                	li	s10,1
    if (sign)
    15a4:	f606d7e3          	bgez	a3,1512 <printf+0x2ba>
    15a8:	b745                	j	1548 <printf+0x2f0>

00000000000015aa <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    15aa:	02000793          	li	a5,32
    15ae:	00f50663          	beq	a0,a5,15ba <isspace+0x10>
    15b2:	355d                	addiw	a0,a0,-9
    15b4:	00553513          	sltiu	a0,a0,5
    15b8:	8082                	ret
    15ba:	4505                	li	a0,1
}
    15bc:	8082                	ret

00000000000015be <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    15be:	fd05051b          	addiw	a0,a0,-48
}
    15c2:	00a53513          	sltiu	a0,a0,10
    15c6:	8082                	ret

00000000000015c8 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    15c8:	02000613          	li	a2,32
    15cc:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    15ce:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    15d2:	ff77069b          	addiw	a3,a4,-9
    15d6:	04c70d63          	beq	a4,a2,1630 <atoi+0x68>
    15da:	0007079b          	sext.w	a5,a4
    15de:	04d5f963          	bgeu	a1,a3,1630 <atoi+0x68>
        s++;
    switch (*s) {
    15e2:	02b00693          	li	a3,43
    15e6:	04d70a63          	beq	a4,a3,163a <atoi+0x72>
    15ea:	02d00693          	li	a3,45
    15ee:	06d70463          	beq	a4,a3,1656 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    15f2:	fd07859b          	addiw	a1,a5,-48
    15f6:	4625                	li	a2,9
    15f8:	873e                	mv	a4,a5
    15fa:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    15fc:	4e01                	li	t3,0
    while (isdigit(*s))
    15fe:	04b66a63          	bltu	a2,a1,1652 <atoi+0x8a>
    int n = 0, neg = 0;
    1602:	4501                	li	a0,0
    while (isdigit(*s))
    1604:	4825                	li	a6,9
    1606:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    160a:	0025179b          	slliw	a5,a0,0x2
    160e:	9d3d                	addw	a0,a0,a5
    1610:	fd07031b          	addiw	t1,a4,-48
    1614:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1618:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    161c:	0685                	addi	a3,a3,1
    161e:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1622:	0006071b          	sext.w	a4,a2
    1626:	feb870e3          	bgeu	a6,a1,1606 <atoi+0x3e>
    return neg ? n : -n;
    162a:	000e0563          	beqz	t3,1634 <atoi+0x6c>
}
    162e:	8082                	ret
        s++;
    1630:	0505                	addi	a0,a0,1
    1632:	bf71                	j	15ce <atoi+0x6>
    1634:	4113053b          	subw	a0,t1,a7
    1638:	8082                	ret
    while (isdigit(*s))
    163a:	00154783          	lbu	a5,1(a0)
    163e:	4625                	li	a2,9
        s++;
    1640:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1644:	fd07859b          	addiw	a1,a5,-48
    1648:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    164c:	4e01                	li	t3,0
    while (isdigit(*s))
    164e:	fab67ae3          	bgeu	a2,a1,1602 <atoi+0x3a>
    1652:	4501                	li	a0,0
}
    1654:	8082                	ret
    while (isdigit(*s))
    1656:	00154783          	lbu	a5,1(a0)
    165a:	4625                	li	a2,9
        s++;
    165c:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1660:	fd07859b          	addiw	a1,a5,-48
    1664:	0007871b          	sext.w	a4,a5
    1668:	feb665e3          	bltu	a2,a1,1652 <atoi+0x8a>
        neg = 1;
    166c:	4e05                	li	t3,1
    166e:	bf51                	j	1602 <atoi+0x3a>

0000000000001670 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    1670:	16060d63          	beqz	a2,17ea <memset+0x17a>
    1674:	40a007b3          	neg	a5,a0
    1678:	8b9d                	andi	a5,a5,7
    167a:	00778713          	addi	a4,a5,7
    167e:	482d                	li	a6,11
    1680:	0ff5f593          	andi	a1,a1,255
    1684:	fff60693          	addi	a3,a2,-1
    1688:	17076263          	bltu	a4,a6,17ec <memset+0x17c>
    168c:	16e6ea63          	bltu	a3,a4,1800 <memset+0x190>
    1690:	16078563          	beqz	a5,17fa <memset+0x18a>
    1694:	00b50023          	sb	a1,0(a0)
    1698:	4705                	li	a4,1
    169a:	00150e93          	addi	t4,a0,1
    169e:	14e78c63          	beq	a5,a4,17f6 <memset+0x186>
    16a2:	00b500a3          	sb	a1,1(a0)
    16a6:	4709                	li	a4,2
    16a8:	00250e93          	addi	t4,a0,2
    16ac:	14e78d63          	beq	a5,a4,1806 <memset+0x196>
    16b0:	00b50123          	sb	a1,2(a0)
    16b4:	470d                	li	a4,3
    16b6:	00350e93          	addi	t4,a0,3
    16ba:	12e78b63          	beq	a5,a4,17f0 <memset+0x180>
    16be:	00b501a3          	sb	a1,3(a0)
    16c2:	4711                	li	a4,4
    16c4:	00450e93          	addi	t4,a0,4
    16c8:	14e78163          	beq	a5,a4,180a <memset+0x19a>
    16cc:	00b50223          	sb	a1,4(a0)
    16d0:	4715                	li	a4,5
    16d2:	00550e93          	addi	t4,a0,5
    16d6:	12e78c63          	beq	a5,a4,180e <memset+0x19e>
    16da:	00b502a3          	sb	a1,5(a0)
    16de:	471d                	li	a4,7
    16e0:	00650e93          	addi	t4,a0,6
    16e4:	12e79763          	bne	a5,a4,1812 <memset+0x1a2>
    16e8:	00750e93          	addi	t4,a0,7
    16ec:	00b50323          	sb	a1,6(a0)
    16f0:	4f1d                	li	t5,7
    16f2:	00859713          	slli	a4,a1,0x8
    16f6:	8f4d                	or	a4,a4,a1
    16f8:	01059e13          	slli	t3,a1,0x10
    16fc:	01c76e33          	or	t3,a4,t3
    1700:	01859313          	slli	t1,a1,0x18
    1704:	006e6333          	or	t1,t3,t1
    1708:	02059893          	slli	a7,a1,0x20
    170c:	011368b3          	or	a7,t1,a7
    1710:	02859813          	slli	a6,a1,0x28
    1714:	40f60333          	sub	t1,a2,a5
    1718:	0108e833          	or	a6,a7,a6
    171c:	03059693          	slli	a3,a1,0x30
    1720:	00d866b3          	or	a3,a6,a3
    1724:	03859713          	slli	a4,a1,0x38
    1728:	97aa                	add	a5,a5,a0
    172a:	ff837813          	andi	a6,t1,-8
    172e:	8f55                	or	a4,a4,a3
    1730:	00f806b3          	add	a3,a6,a5
    1734:	e398                	sd	a4,0(a5)
    1736:	07a1                	addi	a5,a5,8
    1738:	fed79ee3          	bne	a5,a3,1734 <memset+0xc4>
    173c:	ff837693          	andi	a3,t1,-8
    1740:	00de87b3          	add	a5,t4,a3
    1744:	01e6873b          	addw	a4,a3,t5
    1748:	0ad30663          	beq	t1,a3,17f4 <memset+0x184>
    174c:	00b78023          	sb	a1,0(a5)
    1750:	0017069b          	addiw	a3,a4,1
    1754:	08c6fb63          	bgeu	a3,a2,17ea <memset+0x17a>
    1758:	00b780a3          	sb	a1,1(a5)
    175c:	0027069b          	addiw	a3,a4,2
    1760:	08c6f563          	bgeu	a3,a2,17ea <memset+0x17a>
    1764:	00b78123          	sb	a1,2(a5)
    1768:	0037069b          	addiw	a3,a4,3
    176c:	06c6ff63          	bgeu	a3,a2,17ea <memset+0x17a>
    1770:	00b781a3          	sb	a1,3(a5)
    1774:	0047069b          	addiw	a3,a4,4
    1778:	06c6f963          	bgeu	a3,a2,17ea <memset+0x17a>
    177c:	00b78223          	sb	a1,4(a5)
    1780:	0057069b          	addiw	a3,a4,5
    1784:	06c6f363          	bgeu	a3,a2,17ea <memset+0x17a>
    1788:	00b782a3          	sb	a1,5(a5)
    178c:	0067069b          	addiw	a3,a4,6
    1790:	04c6fd63          	bgeu	a3,a2,17ea <memset+0x17a>
    1794:	00b78323          	sb	a1,6(a5)
    1798:	0077069b          	addiw	a3,a4,7
    179c:	04c6f763          	bgeu	a3,a2,17ea <memset+0x17a>
    17a0:	00b783a3          	sb	a1,7(a5)
    17a4:	0087069b          	addiw	a3,a4,8
    17a8:	04c6f163          	bgeu	a3,a2,17ea <memset+0x17a>
    17ac:	00b78423          	sb	a1,8(a5)
    17b0:	0097069b          	addiw	a3,a4,9
    17b4:	02c6fb63          	bgeu	a3,a2,17ea <memset+0x17a>
    17b8:	00b784a3          	sb	a1,9(a5)
    17bc:	00a7069b          	addiw	a3,a4,10
    17c0:	02c6f563          	bgeu	a3,a2,17ea <memset+0x17a>
    17c4:	00b78523          	sb	a1,10(a5)
    17c8:	00b7069b          	addiw	a3,a4,11
    17cc:	00c6ff63          	bgeu	a3,a2,17ea <memset+0x17a>
    17d0:	00b785a3          	sb	a1,11(a5)
    17d4:	00c7069b          	addiw	a3,a4,12
    17d8:	00c6f963          	bgeu	a3,a2,17ea <memset+0x17a>
    17dc:	00b78623          	sb	a1,12(a5)
    17e0:	2735                	addiw	a4,a4,13
    17e2:	00c77463          	bgeu	a4,a2,17ea <memset+0x17a>
    17e6:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    17ea:	8082                	ret
    17ec:	472d                	li	a4,11
    17ee:	bd79                	j	168c <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    17f0:	4f0d                	li	t5,3
    17f2:	b701                	j	16f2 <memset+0x82>
    17f4:	8082                	ret
    17f6:	4f05                	li	t5,1
    17f8:	bded                	j	16f2 <memset+0x82>
    17fa:	8eaa                	mv	t4,a0
    17fc:	4f01                	li	t5,0
    17fe:	bdd5                	j	16f2 <memset+0x82>
    1800:	87aa                	mv	a5,a0
    1802:	4701                	li	a4,0
    1804:	b7a1                	j	174c <memset+0xdc>
    1806:	4f09                	li	t5,2
    1808:	b5ed                	j	16f2 <memset+0x82>
    180a:	4f11                	li	t5,4
    180c:	b5dd                	j	16f2 <memset+0x82>
    180e:	4f15                	li	t5,5
    1810:	b5cd                	j	16f2 <memset+0x82>
    1812:	4f19                	li	t5,6
    1814:	bdf9                	j	16f2 <memset+0x82>

0000000000001816 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    1816:	00054783          	lbu	a5,0(a0)
    181a:	0005c703          	lbu	a4,0(a1)
    181e:	00e79863          	bne	a5,a4,182e <strcmp+0x18>
    1822:	0505                	addi	a0,a0,1
    1824:	0585                	addi	a1,a1,1
    1826:	fbe5                	bnez	a5,1816 <strcmp>
    1828:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    182a:	9d19                	subw	a0,a0,a4
    182c:	8082                	ret
    182e:	0007851b          	sext.w	a0,a5
    1832:	bfe5                	j	182a <strcmp+0x14>

0000000000001834 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1834:	87aa                	mv	a5,a0
    1836:	0005c703          	lbu	a4,0(a1)
    183a:	0785                	addi	a5,a5,1
    183c:	0585                	addi	a1,a1,1
    183e:	fee78fa3          	sb	a4,-1(a5)
    1842:	fb75                	bnez	a4,1836 <strcpy+0x2>
        ;
    return os;
}
    1844:	8082                	ret

0000000000001846 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    1846:	ce05                	beqz	a2,187e <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1848:	00054703          	lbu	a4,0(a0)
    184c:	0005c783          	lbu	a5,0(a1)
    1850:	cb0d                	beqz	a4,1882 <strncmp+0x3c>
    if (!n--)
    1852:	167d                	addi	a2,a2,-1
    1854:	00c506b3          	add	a3,a0,a2
    1858:	a819                	j	186e <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    185a:	00a68e63          	beq	a3,a0,1876 <strncmp+0x30>
    185e:	0505                	addi	a0,a0,1
    1860:	00e79b63          	bne	a5,a4,1876 <strncmp+0x30>
    1864:	00054703          	lbu	a4,0(a0)
    1868:	0005c783          	lbu	a5,0(a1)
    186c:	cb19                	beqz	a4,1882 <strncmp+0x3c>
    186e:	0005c783          	lbu	a5,0(a1)
    1872:	0585                	addi	a1,a1,1
    1874:	f3fd                	bnez	a5,185a <strncmp+0x14>
        ;
    return *l - *r;
    1876:	0007051b          	sext.w	a0,a4
    187a:	9d1d                	subw	a0,a0,a5
    187c:	8082                	ret
        return 0;
    187e:	4501                	li	a0,0
}
    1880:	8082                	ret
    1882:	4501                	li	a0,0
    return *l - *r;
    1884:	9d1d                	subw	a0,a0,a5
    1886:	8082                	ret

0000000000001888 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    1888:	00757793          	andi	a5,a0,7
    188c:	cf89                	beqz	a5,18a6 <strlen+0x1e>
    188e:	87aa                	mv	a5,a0
    1890:	a029                	j	189a <strlen+0x12>
    1892:	0785                	addi	a5,a5,1
    1894:	0077f713          	andi	a4,a5,7
    1898:	cb01                	beqz	a4,18a8 <strlen+0x20>
        if (!*s)
    189a:	0007c703          	lbu	a4,0(a5)
    189e:	fb75                	bnez	a4,1892 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    18a0:	40a78533          	sub	a0,a5,a0
}
    18a4:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    18a6:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    18a8:	6394                	ld	a3,0(a5)
    18aa:	00000597          	auipc	a1,0x0
    18ae:	7b65b583          	ld	a1,1974(a1) # 2060 <sharedmem+0x1aa>
    18b2:	00000617          	auipc	a2,0x0
    18b6:	7b663603          	ld	a2,1974(a2) # 2068 <sharedmem+0x1b2>
    18ba:	a019                	j	18c0 <strlen+0x38>
    18bc:	6794                	ld	a3,8(a5)
    18be:	07a1                	addi	a5,a5,8
    18c0:	00b68733          	add	a4,a3,a1
    18c4:	fff6c693          	not	a3,a3
    18c8:	8f75                	and	a4,a4,a3
    18ca:	8f71                	and	a4,a4,a2
    18cc:	db65                	beqz	a4,18bc <strlen+0x34>
    for (; *s; s++)
    18ce:	0007c703          	lbu	a4,0(a5)
    18d2:	d779                	beqz	a4,18a0 <strlen+0x18>
    18d4:	0017c703          	lbu	a4,1(a5)
    18d8:	0785                	addi	a5,a5,1
    18da:	d379                	beqz	a4,18a0 <strlen+0x18>
    18dc:	0017c703          	lbu	a4,1(a5)
    18e0:	0785                	addi	a5,a5,1
    18e2:	fb6d                	bnez	a4,18d4 <strlen+0x4c>
    18e4:	bf75                	j	18a0 <strlen+0x18>

00000000000018e6 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18e6:	00757713          	andi	a4,a0,7
{
    18ea:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    18ec:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18f0:	cb19                	beqz	a4,1906 <memchr+0x20>
    18f2:	ce25                	beqz	a2,196a <memchr+0x84>
    18f4:	0007c703          	lbu	a4,0(a5)
    18f8:	04b70e63          	beq	a4,a1,1954 <memchr+0x6e>
    18fc:	0785                	addi	a5,a5,1
    18fe:	0077f713          	andi	a4,a5,7
    1902:	167d                	addi	a2,a2,-1
    1904:	f77d                	bnez	a4,18f2 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    1906:	4501                	li	a0,0
    if (n && *s != c) {
    1908:	c235                	beqz	a2,196c <memchr+0x86>
    190a:	0007c703          	lbu	a4,0(a5)
    190e:	04b70363          	beq	a4,a1,1954 <memchr+0x6e>
        size_t k = ONES * c;
    1912:	00000517          	auipc	a0,0x0
    1916:	75e53503          	ld	a0,1886(a0) # 2070 <sharedmem+0x1ba>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    191a:	471d                	li	a4,7
        size_t k = ONES * c;
    191c:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1920:	02c77a63          	bgeu	a4,a2,1954 <memchr+0x6e>
    1924:	00000897          	auipc	a7,0x0
    1928:	73c8b883          	ld	a7,1852(a7) # 2060 <sharedmem+0x1aa>
    192c:	00000817          	auipc	a6,0x0
    1930:	73c83803          	ld	a6,1852(a6) # 2068 <sharedmem+0x1b2>
    1934:	431d                	li	t1,7
    1936:	a029                	j	1940 <memchr+0x5a>
    1938:	1661                	addi	a2,a2,-8
    193a:	07a1                	addi	a5,a5,8
    193c:	02c37963          	bgeu	t1,a2,196e <memchr+0x88>
    1940:	6398                	ld	a4,0(a5)
    1942:	8f29                	xor	a4,a4,a0
    1944:	011706b3          	add	a3,a4,a7
    1948:	fff74713          	not	a4,a4
    194c:	8f75                	and	a4,a4,a3
    194e:	01077733          	and	a4,a4,a6
    1952:	d37d                	beqz	a4,1938 <memchr+0x52>
    1954:	853e                	mv	a0,a5
    1956:	97b2                	add	a5,a5,a2
    1958:	a021                	j	1960 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    195a:	0505                	addi	a0,a0,1
    195c:	00f50763          	beq	a0,a5,196a <memchr+0x84>
    1960:	00054703          	lbu	a4,0(a0)
    1964:	feb71be3          	bne	a4,a1,195a <memchr+0x74>
    1968:	8082                	ret
    return n ? (void*)s : 0;
    196a:	4501                	li	a0,0
}
    196c:	8082                	ret
    return n ? (void*)s : 0;
    196e:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1970:	f275                	bnez	a2,1954 <memchr+0x6e>
}
    1972:	8082                	ret

0000000000001974 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1974:	1101                	addi	sp,sp,-32
    1976:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1978:	862e                	mv	a2,a1
{
    197a:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    197c:	4581                	li	a1,0
{
    197e:	e426                	sd	s1,8(sp)
    1980:	ec06                	sd	ra,24(sp)
    1982:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1984:	f63ff0ef          	jal	ra,18e6 <memchr>
    return p ? p - s : n;
    1988:	c519                	beqz	a0,1996 <strnlen+0x22>
}
    198a:	60e2                	ld	ra,24(sp)
    198c:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    198e:	8d05                	sub	a0,a0,s1
}
    1990:	64a2                	ld	s1,8(sp)
    1992:	6105                	addi	sp,sp,32
    1994:	8082                	ret
    1996:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1998:	8522                	mv	a0,s0
}
    199a:	6442                	ld	s0,16(sp)
    199c:	64a2                	ld	s1,8(sp)
    199e:	6105                	addi	sp,sp,32
    19a0:	8082                	ret

00000000000019a2 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    19a2:	00b547b3          	xor	a5,a0,a1
    19a6:	8b9d                	andi	a5,a5,7
    19a8:	eb95                	bnez	a5,19dc <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    19aa:	0075f793          	andi	a5,a1,7
    19ae:	e7b1                	bnez	a5,19fa <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    19b0:	6198                	ld	a4,0(a1)
    19b2:	00000617          	auipc	a2,0x0
    19b6:	6ae63603          	ld	a2,1710(a2) # 2060 <sharedmem+0x1aa>
    19ba:	00000817          	auipc	a6,0x0
    19be:	6ae83803          	ld	a6,1710(a6) # 2068 <sharedmem+0x1b2>
    19c2:	a029                	j	19cc <stpcpy+0x2a>
    19c4:	e118                	sd	a4,0(a0)
    19c6:	6598                	ld	a4,8(a1)
    19c8:	05a1                	addi	a1,a1,8
    19ca:	0521                	addi	a0,a0,8
    19cc:	00c707b3          	add	a5,a4,a2
    19d0:	fff74693          	not	a3,a4
    19d4:	8ff5                	and	a5,a5,a3
    19d6:	0107f7b3          	and	a5,a5,a6
    19da:	d7ed                	beqz	a5,19c4 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    19dc:	0005c783          	lbu	a5,0(a1)
    19e0:	00f50023          	sb	a5,0(a0)
    19e4:	c785                	beqz	a5,1a0c <stpcpy+0x6a>
    19e6:	0015c783          	lbu	a5,1(a1)
    19ea:	0505                	addi	a0,a0,1
    19ec:	0585                	addi	a1,a1,1
    19ee:	00f50023          	sb	a5,0(a0)
    19f2:	fbf5                	bnez	a5,19e6 <stpcpy+0x44>
        ;
    return d;
}
    19f4:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    19f6:	0505                	addi	a0,a0,1
    19f8:	df45                	beqz	a4,19b0 <stpcpy+0xe>
            if (!(*d = *s))
    19fa:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    19fe:	0585                	addi	a1,a1,1
    1a00:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1a04:	00f50023          	sb	a5,0(a0)
    1a08:	f7fd                	bnez	a5,19f6 <stpcpy+0x54>
}
    1a0a:	8082                	ret
    1a0c:	8082                	ret

0000000000001a0e <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1a0e:	00b547b3          	xor	a5,a0,a1
    1a12:	8b9d                	andi	a5,a5,7
    1a14:	1a079863          	bnez	a5,1bc4 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1a18:	0075f793          	andi	a5,a1,7
    1a1c:	16078463          	beqz	a5,1b84 <stpncpy+0x176>
    1a20:	ea01                	bnez	a2,1a30 <stpncpy+0x22>
    1a22:	a421                	j	1c2a <stpncpy+0x21c>
    1a24:	167d                	addi	a2,a2,-1
    1a26:	0505                	addi	a0,a0,1
    1a28:	14070e63          	beqz	a4,1b84 <stpncpy+0x176>
    1a2c:	1a060863          	beqz	a2,1bdc <stpncpy+0x1ce>
    1a30:	0005c783          	lbu	a5,0(a1)
    1a34:	0585                	addi	a1,a1,1
    1a36:	0075f713          	andi	a4,a1,7
    1a3a:	00f50023          	sb	a5,0(a0)
    1a3e:	f3fd                	bnez	a5,1a24 <stpncpy+0x16>
    1a40:	4805                	li	a6,1
    1a42:	1a061863          	bnez	a2,1bf2 <stpncpy+0x1e4>
    1a46:	40a007b3          	neg	a5,a0
    1a4a:	8b9d                	andi	a5,a5,7
    1a4c:	4681                	li	a3,0
    1a4e:	18061a63          	bnez	a2,1be2 <stpncpy+0x1d4>
    1a52:	00778713          	addi	a4,a5,7
    1a56:	45ad                	li	a1,11
    1a58:	18b76363          	bltu	a4,a1,1bde <stpncpy+0x1d0>
    1a5c:	1ae6eb63          	bltu	a3,a4,1c12 <stpncpy+0x204>
    1a60:	1a078363          	beqz	a5,1c06 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1a64:	00050023          	sb	zero,0(a0)
    1a68:	4685                	li	a3,1
    1a6a:	00150713          	addi	a4,a0,1
    1a6e:	18d78f63          	beq	a5,a3,1c0c <stpncpy+0x1fe>
    1a72:	000500a3          	sb	zero,1(a0)
    1a76:	4689                	li	a3,2
    1a78:	00250713          	addi	a4,a0,2
    1a7c:	18d78e63          	beq	a5,a3,1c18 <stpncpy+0x20a>
    1a80:	00050123          	sb	zero,2(a0)
    1a84:	468d                	li	a3,3
    1a86:	00350713          	addi	a4,a0,3
    1a8a:	16d78c63          	beq	a5,a3,1c02 <stpncpy+0x1f4>
    1a8e:	000501a3          	sb	zero,3(a0)
    1a92:	4691                	li	a3,4
    1a94:	00450713          	addi	a4,a0,4
    1a98:	18d78263          	beq	a5,a3,1c1c <stpncpy+0x20e>
    1a9c:	00050223          	sb	zero,4(a0)
    1aa0:	4695                	li	a3,5
    1aa2:	00550713          	addi	a4,a0,5
    1aa6:	16d78d63          	beq	a5,a3,1c20 <stpncpy+0x212>
    1aaa:	000502a3          	sb	zero,5(a0)
    1aae:	469d                	li	a3,7
    1ab0:	00650713          	addi	a4,a0,6
    1ab4:	16d79863          	bne	a5,a3,1c24 <stpncpy+0x216>
    1ab8:	00750713          	addi	a4,a0,7
    1abc:	00050323          	sb	zero,6(a0)
    1ac0:	40f80833          	sub	a6,a6,a5
    1ac4:	ff887593          	andi	a1,a6,-8
    1ac8:	97aa                	add	a5,a5,a0
    1aca:	95be                	add	a1,a1,a5
    1acc:	0007b023          	sd	zero,0(a5)
    1ad0:	07a1                	addi	a5,a5,8
    1ad2:	feb79de3          	bne	a5,a1,1acc <stpncpy+0xbe>
    1ad6:	ff887593          	andi	a1,a6,-8
    1ada:	9ead                	addw	a3,a3,a1
    1adc:	00b707b3          	add	a5,a4,a1
    1ae0:	12b80863          	beq	a6,a1,1c10 <stpncpy+0x202>
    1ae4:	00078023          	sb	zero,0(a5)
    1ae8:	0016871b          	addiw	a4,a3,1
    1aec:	0ec77863          	bgeu	a4,a2,1bdc <stpncpy+0x1ce>
    1af0:	000780a3          	sb	zero,1(a5)
    1af4:	0026871b          	addiw	a4,a3,2
    1af8:	0ec77263          	bgeu	a4,a2,1bdc <stpncpy+0x1ce>
    1afc:	00078123          	sb	zero,2(a5)
    1b00:	0036871b          	addiw	a4,a3,3
    1b04:	0cc77c63          	bgeu	a4,a2,1bdc <stpncpy+0x1ce>
    1b08:	000781a3          	sb	zero,3(a5)
    1b0c:	0046871b          	addiw	a4,a3,4
    1b10:	0cc77663          	bgeu	a4,a2,1bdc <stpncpy+0x1ce>
    1b14:	00078223          	sb	zero,4(a5)
    1b18:	0056871b          	addiw	a4,a3,5
    1b1c:	0cc77063          	bgeu	a4,a2,1bdc <stpncpy+0x1ce>
    1b20:	000782a3          	sb	zero,5(a5)
    1b24:	0066871b          	addiw	a4,a3,6
    1b28:	0ac77a63          	bgeu	a4,a2,1bdc <stpncpy+0x1ce>
    1b2c:	00078323          	sb	zero,6(a5)
    1b30:	0076871b          	addiw	a4,a3,7
    1b34:	0ac77463          	bgeu	a4,a2,1bdc <stpncpy+0x1ce>
    1b38:	000783a3          	sb	zero,7(a5)
    1b3c:	0086871b          	addiw	a4,a3,8
    1b40:	08c77e63          	bgeu	a4,a2,1bdc <stpncpy+0x1ce>
    1b44:	00078423          	sb	zero,8(a5)
    1b48:	0096871b          	addiw	a4,a3,9
    1b4c:	08c77863          	bgeu	a4,a2,1bdc <stpncpy+0x1ce>
    1b50:	000784a3          	sb	zero,9(a5)
    1b54:	00a6871b          	addiw	a4,a3,10
    1b58:	08c77263          	bgeu	a4,a2,1bdc <stpncpy+0x1ce>
    1b5c:	00078523          	sb	zero,10(a5)
    1b60:	00b6871b          	addiw	a4,a3,11
    1b64:	06c77c63          	bgeu	a4,a2,1bdc <stpncpy+0x1ce>
    1b68:	000785a3          	sb	zero,11(a5)
    1b6c:	00c6871b          	addiw	a4,a3,12
    1b70:	06c77663          	bgeu	a4,a2,1bdc <stpncpy+0x1ce>
    1b74:	00078623          	sb	zero,12(a5)
    1b78:	26b5                	addiw	a3,a3,13
    1b7a:	06c6f163          	bgeu	a3,a2,1bdc <stpncpy+0x1ce>
    1b7e:	000786a3          	sb	zero,13(a5)
    1b82:	8082                	ret
            ;
        if (!n || !*s)
    1b84:	c645                	beqz	a2,1c2c <stpncpy+0x21e>
    1b86:	0005c783          	lbu	a5,0(a1)
    1b8a:	ea078be3          	beqz	a5,1a40 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b8e:	479d                	li	a5,7
    1b90:	02c7ff63          	bgeu	a5,a2,1bce <stpncpy+0x1c0>
    1b94:	00000897          	auipc	a7,0x0
    1b98:	4cc8b883          	ld	a7,1228(a7) # 2060 <sharedmem+0x1aa>
    1b9c:	00000817          	auipc	a6,0x0
    1ba0:	4cc83803          	ld	a6,1228(a6) # 2068 <sharedmem+0x1b2>
    1ba4:	431d                	li	t1,7
    1ba6:	6198                	ld	a4,0(a1)
    1ba8:	011707b3          	add	a5,a4,a7
    1bac:	fff74693          	not	a3,a4
    1bb0:	8ff5                	and	a5,a5,a3
    1bb2:	0107f7b3          	and	a5,a5,a6
    1bb6:	ef81                	bnez	a5,1bce <stpncpy+0x1c0>
            *wd = *ws;
    1bb8:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1bba:	1661                	addi	a2,a2,-8
    1bbc:	05a1                	addi	a1,a1,8
    1bbe:	0521                	addi	a0,a0,8
    1bc0:	fec363e3          	bltu	t1,a2,1ba6 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1bc4:	e609                	bnez	a2,1bce <stpncpy+0x1c0>
    1bc6:	a08d                	j	1c28 <stpncpy+0x21a>
    1bc8:	167d                	addi	a2,a2,-1
    1bca:	0505                	addi	a0,a0,1
    1bcc:	ca01                	beqz	a2,1bdc <stpncpy+0x1ce>
    1bce:	0005c783          	lbu	a5,0(a1)
    1bd2:	0585                	addi	a1,a1,1
    1bd4:	00f50023          	sb	a5,0(a0)
    1bd8:	fbe5                	bnez	a5,1bc8 <stpncpy+0x1ba>
        ;
tail:
    1bda:	b59d                	j	1a40 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1bdc:	8082                	ret
    1bde:	472d                	li	a4,11
    1be0:	bdb5                	j	1a5c <stpncpy+0x4e>
    1be2:	00778713          	addi	a4,a5,7
    1be6:	45ad                	li	a1,11
    1be8:	fff60693          	addi	a3,a2,-1
    1bec:	e6b778e3          	bgeu	a4,a1,1a5c <stpncpy+0x4e>
    1bf0:	b7fd                	j	1bde <stpncpy+0x1d0>
    1bf2:	40a007b3          	neg	a5,a0
    1bf6:	8832                	mv	a6,a2
    1bf8:	8b9d                	andi	a5,a5,7
    1bfa:	4681                	li	a3,0
    1bfc:	e4060be3          	beqz	a2,1a52 <stpncpy+0x44>
    1c00:	b7cd                	j	1be2 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1c02:	468d                	li	a3,3
    1c04:	bd75                	j	1ac0 <stpncpy+0xb2>
    1c06:	872a                	mv	a4,a0
    1c08:	4681                	li	a3,0
    1c0a:	bd5d                	j	1ac0 <stpncpy+0xb2>
    1c0c:	4685                	li	a3,1
    1c0e:	bd4d                	j	1ac0 <stpncpy+0xb2>
    1c10:	8082                	ret
    1c12:	87aa                	mv	a5,a0
    1c14:	4681                	li	a3,0
    1c16:	b5f9                	j	1ae4 <stpncpy+0xd6>
    1c18:	4689                	li	a3,2
    1c1a:	b55d                	j	1ac0 <stpncpy+0xb2>
    1c1c:	4691                	li	a3,4
    1c1e:	b54d                	j	1ac0 <stpncpy+0xb2>
    1c20:	4695                	li	a3,5
    1c22:	bd79                	j	1ac0 <stpncpy+0xb2>
    1c24:	4699                	li	a3,6
    1c26:	bd69                	j	1ac0 <stpncpy+0xb2>
    1c28:	8082                	ret
    1c2a:	8082                	ret
    1c2c:	8082                	ret

0000000000001c2e <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1c2e:	fff6071b          	addiw	a4,a2,-1
    1c32:	0cb57063          	bgeu	a0,a1,1cf2 <memmove+0xc4>
        while (n-- > 0)
    1c36:	0ec05063          	blez	a2,1d16 <memmove+0xe8>
    1c3a:	00750693          	addi	a3,a0,7
    1c3e:	8e8d                	sub	a3,a3,a1
    1c40:	00b567b3          	or	a5,a0,a1
    1c44:	00f6b693          	sltiu	a3,a3,15
    1c48:	8b9d                	andi	a5,a5,7
    1c4a:	0016c693          	xori	a3,a3,1
    1c4e:	0017b793          	seqz	a5,a5
    1c52:	8ff5                	and	a5,a5,a3
    1c54:	c3f1                	beqz	a5,1d18 <memmove+0xea>
    1c56:	0007079b          	sext.w	a5,a4
    1c5a:	46a5                	li	a3,9
    1c5c:	0af6fe63          	bgeu	a3,a5,1d18 <memmove+0xea>
    1c60:	0036589b          	srliw	a7,a2,0x3
    1c64:	088e                	slli	a7,a7,0x3
    1c66:	2601                	sext.w	a2,a2
    1c68:	87ae                	mv	a5,a1
    1c6a:	86aa                	mv	a3,a0
    1c6c:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1c6e:	0007b803          	ld	a6,0(a5)
    1c72:	07a1                	addi	a5,a5,8
    1c74:	06a1                	addi	a3,a3,8
    1c76:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1c7a:	ff179ae3          	bne	a5,a7,1c6e <memmove+0x40>
    1c7e:	ff867813          	andi	a6,a2,-8
    1c82:	02081793          	slli	a5,a6,0x20
    1c86:	9381                	srli	a5,a5,0x20
    1c88:	00f506b3          	add	a3,a0,a5
    1c8c:	95be                	add	a1,a1,a5
    1c8e:	4107073b          	subw	a4,a4,a6
    1c92:	09060263          	beq	a2,a6,1d16 <memmove+0xe8>
            *dst++ = *src++;
    1c96:	0005c783          	lbu	a5,0(a1)
    1c9a:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1c9e:	06e05c63          	blez	a4,1d16 <memmove+0xe8>
            *dst++ = *src++;
    1ca2:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1ca6:	4785                	li	a5,1
            *dst++ = *src++;
    1ca8:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1cac:	06e7d563          	bge	a5,a4,1d16 <memmove+0xe8>
            *dst++ = *src++;
    1cb0:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1cb4:	4789                	li	a5,2
            *dst++ = *src++;
    1cb6:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1cba:	04e7de63          	bge	a5,a4,1d16 <memmove+0xe8>
            *dst++ = *src++;
    1cbe:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1cc2:	478d                	li	a5,3
            *dst++ = *src++;
    1cc4:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1cc8:	04e7d763          	bge	a5,a4,1d16 <memmove+0xe8>
            *dst++ = *src++;
    1ccc:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1cd0:	4791                	li	a5,4
            *dst++ = *src++;
    1cd2:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1cd6:	04e7d063          	bge	a5,a4,1d16 <memmove+0xe8>
            *dst++ = *src++;
    1cda:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1cde:	4795                	li	a5,5
            *dst++ = *src++;
    1ce0:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1ce4:	02e7d963          	bge	a5,a4,1d16 <memmove+0xe8>
            *dst++ = *src++;
    1ce8:	0065c783          	lbu	a5,6(a1)
    1cec:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1cf0:	8082                	ret
    } else {
        dst += n;
    1cf2:	00c507b3          	add	a5,a0,a2
        src += n;
    1cf6:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1cf8:	00c05f63          	blez	a2,1d16 <memmove+0xe8>
    1cfc:	1702                	slli	a4,a4,0x20
    1cfe:	9301                	srli	a4,a4,0x20
    1d00:	fff74713          	not	a4,a4
    1d04:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1d06:	fff5c683          	lbu	a3,-1(a1)
    1d0a:	17fd                	addi	a5,a5,-1
    1d0c:	15fd                	addi	a1,a1,-1
    1d0e:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1d12:	fee79ae3          	bne	a5,a4,1d06 <memmove+0xd8>
    }
    return vdst;
}
    1d16:	8082                	ret
    1d18:	02071693          	slli	a3,a4,0x20
    1d1c:	9281                	srli	a3,a3,0x20
    1d1e:	0685                	addi	a3,a3,1
    1d20:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1d22:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1d24:	0005c703          	lbu	a4,0(a1)
    1d28:	0585                	addi	a1,a1,1
    1d2a:	0785                	addi	a5,a5,1
    1d2c:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1d30:	fed59ae3          	bne	a1,a3,1d24 <memmove+0xf6>
    1d34:	8082                	ret

0000000000001d36 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1d36:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d3a:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1d3e:	2501                	sext.w	a0,a0
    1d40:	8082                	ret

0000000000001d42 <exec>:
    register long a7 __asm__("a7") = n;
    1d42:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1d46:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d48:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1d4c:	2501                	sext.w	a0,a0
    1d4e:	8082                	ret

0000000000001d50 <exit>:
    register long a7 __asm__("a7") = n;
    1d50:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d54:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1d58:	8082                	ret

0000000000001d5a <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1d5a:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d5e:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1d62:	8082                	ret

0000000000001d64 <write>:
    register long a7 __asm__("a7") = n;
    1d64:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d68:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1d6c:	8082                	ret

0000000000001d6e <getpid>:
    register long a7 __asm__("a7") = n;
    1d6e:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1d72:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1d76:	2501                	sext.w	a0,a0
    1d78:	8082                	ret

0000000000001d7a <getppid>:
    register long a7 __asm__("a7") = n;
    1d7a:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1d7e:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1d82:	2501                	sext.w	a0,a0
    1d84:	8082                	ret

0000000000001d86 <open>:
    register long a7 __asm__("a7") = n;
    1d86:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d8a:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1d8e:	2501                	sext.w	a0,a0
    1d90:	8082                	ret

0000000000001d92 <mknod>:
    register long a7 __asm__("a7") = n;
    1d92:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d96:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1d9a:	2501                	sext.w	a0,a0
    1d9c:	8082                	ret

0000000000001d9e <dup>:
    register long a7 __asm__("a7") = n;
    1d9e:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1da0:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1da4:	2501                	sext.w	a0,a0
    1da6:	8082                	ret

0000000000001da8 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1da8:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1dac:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1db0:	2501                	sext.w	a0,a0
    1db2:	8082                	ret

0000000000001db4 <waitpid>:
    register long a7 __asm__("a7") = n;
    1db4:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db8:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1dbc:	2501                	sext.w	a0,a0
    1dbe:	8082                	ret

0000000000001dc0 <wait>:

pid_t wait(int *wstatus)
{
    1dc0:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1dc2:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1dc6:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dc8:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1dcc:	2501                	sext.w	a0,a0
    1dce:	8082                	ret

0000000000001dd0 <mkdir>:
    register long a7 __asm__("a7") = n;
    1dd0:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1dd4:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1dd8:	2501                	sext.w	a0,a0
    1dda:	8082                	ret

0000000000001ddc <close>:
    register long a7 __asm__("a7") = n;
    1ddc:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1de0:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1de4:	2501                	sext.w	a0,a0
    1de6:	8082                	ret

0000000000001de8 <fork>:
    register long a7 __asm__("a7") = n;
    1de8:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1dec:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1df0:	2501                	sext.w	a0,a0
    1df2:	8082                	ret

0000000000001df4 <time_ms>:
    register long a7 __asm__("a7") = n;
    1df4:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1df8:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1dfc:	8082                	ret

0000000000001dfe <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1dfe:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1e00:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1e04:	00000073          	ecall
    1e08:	87aa                	mv	a5,a0
    1e0a:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1e0e:	97ba                	add	a5,a5,a4
    1e10:	00f57c63          	bgeu	a0,a5,1e28 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1e14:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1e18:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1e1c:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1e20:	00000073          	ecall
    1e24:	fef568e3          	bltu	a0,a5,1e14 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1e28:	4501                	li	a0,0
    1e2a:	8082                	ret

0000000000001e2c <pipe>:
    register long a7 __asm__("a7") = n;
    1e2c:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1e30:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1e34:	2501                	sext.w	a0,a0
    1e36:	8082                	ret

0000000000001e38 <fstat>:
    register long a7 __asm__("a7") = n;
    1e38:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e3c:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1e40:	2501                	sext.w	a0,a0
    1e42:	8082                	ret

0000000000001e44 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1e44:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1e46:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1e4a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e4c:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1e50:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1e54:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1e58:	0206c163          	bltz	a3,1e7a <stat+0x36>
    register long a7 __asm__("a7") = n;
    1e5c:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1e60:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1e62:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e64:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1e68:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1e6c:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1e70:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1e72:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1e76:	853e                	mv	a0,a5
    1e78:	8082                	ret
        return -1;
    1e7a:	57fd                	li	a5,-1
    1e7c:	bfed                	j	1e76 <stat+0x32>

0000000000001e7e <chdir>:
    register long a7 __asm__("a7") = n;
    1e7e:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e82:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e86:	2501                	sext.w	a0,a0
    1e88:	8082                	ret

0000000000001e8a <link>:
    register long a7 __asm__("a7") = n;
    1e8a:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e8e:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1e92:	2501                	sext.w	a0,a0
    1e94:	8082                	ret

0000000000001e96 <unlink>:
    register long a7 __asm__("a7") = n;
    1e96:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1e9a:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1e9e:	2501                	sext.w	a0,a0
    1ea0:	8082                	ret

0000000000001ea2 <setpriority>:
    register long a7 __asm__("a7") = n;
    1ea2:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1ea6:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1eaa:	8082                	ret

0000000000001eac <getpriority>:
    register long a7 __asm__("a7") = n;
    1eac:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1eb0:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1eb4:	8082                	ret

0000000000001eb6 <sharedmem>:
    register long a7 __asm__("a7") = n;
    1eb6:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1eba:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1ebe:	8082                	ret
