
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_exit:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a0f9                	j	10ce <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <ucore.h>
const int max_child = 32;

const int MAGIC = 0x1234;

int main(void) {
    1002:	7179                	addi	sp,sp,-48
    puts("I am the parent. Forking the child...");
    1004:	00001517          	auipc	a0,0x1
    1008:	dcc50513          	addi	a0,a0,-564 # 1dd0 <sharedmem+0xe>
int main(void) {
    100c:	f406                	sd	ra,40(sp)
    100e:	ec26                	sd	s1,24(sp)
    1010:	f022                	sd	s0,32(sp)
    puts("I am the parent. Forking the child...");
    1012:	10c000ef          	jal	ra,111e <puts>
    int pid = fork();
    1016:	4df000ef          	jal	ra,1cf4 <fork>
    101a:	84aa                	mv	s1,a0
    if (pid == 0) {
    101c:	e959                	bnez	a0,10b2 <main+0xb0>
        puts("I am the child.");
    101e:	00001517          	auipc	a0,0x1
    1022:	dda50513          	addi	a0,a0,-550 # 1df8 <sharedmem+0x36>
    1026:	0f8000ef          	jal	ra,111e <puts>
    102a:	4421                	li	s0,8
        for(int i = 0; i < 8; ++i) {
            sched_yield();
    102c:	347d                	addiw	s0,s0,-1
    102e:	487000ef          	jal	ra,1cb4 <sched_yield>
        for(int i = 0; i < 8; ++i) {
    1032:	fc6d                	bnez	s0,102c <main+0x2a>
        }
        exit(MAGIC);
    1034:	6505                	lui	a0,0x1
    1036:	23450513          	addi	a0,a0,564 # 1234 <printf+0xd0>
    103a:	423000ef          	jal	ra,1c5c <exit>
    } else {
        printf("I am parent, fork a child pid %d\n", pid);
    }

    puts("I am the parent, waiting now..");
    103e:	00001517          	auipc	a0,0x1
    1042:	df250513          	addi	a0,a0,-526 # 1e30 <sharedmem+0x6e>
    1046:	0d8000ef          	jal	ra,111e <puts>
    int xstate = 0;
    if(waitpid(pid, &xstate) != pid || xstate != MAGIC) {
    104a:	006c                	addi	a1,sp,12
    104c:	8526                	mv	a0,s1
    int xstate = 0;
    104e:	c602                	sw	zero,12(sp)
    if(waitpid(pid, &xstate) != pid || xstate != MAGIC) {
    1050:	471000ef          	jal	ra,1cc0 <waitpid>
    1054:	00951863          	bne	a0,s1,1064 <main+0x62>
    1058:	4732                	lw	a4,12(sp)
    105a:	6785                	lui	a5,0x1
    105c:	23478793          	addi	a5,a5,564 # 1234 <printf+0xd0>
    1060:	00f70963          	beq	a4,a5,1072 <main+0x70>
        printf("wait %d fail\n", pid);
    1064:	85a6                	mv	a1,s1
    1066:	00001517          	auipc	a0,0x1
    106a:	dea50513          	addi	a0,a0,-534 # 1e50 <sharedmem+0x8e>
    106e:	0f6000ef          	jal	ra,1164 <printf>
    }
    if(waitpid(pid, &xstate) > 0 || wait( &xstate) > 0) {
    1072:	006c                	addi	a1,sp,12
    1074:	8526                	mv	a0,s1
    1076:	44b000ef          	jal	ra,1cc0 <waitpid>
    107a:	04a05463          	blez	a0,10c2 <main+0xc0>
        printf("wait should fail\n", pid);
    107e:	85a6                	mv	a1,s1
    1080:	00001517          	auipc	a0,0x1
    1084:	de050513          	addi	a0,a0,-544 # 1e60 <sharedmem+0x9e>
    1088:	0dc000ef          	jal	ra,1164 <printf>
    }
    printf("waitpid %d ok.\n", pid);
    108c:	85a6                	mv	a1,s1
    108e:	00001517          	auipc	a0,0x1
    1092:	dea50513          	addi	a0,a0,-534 # 1e78 <sharedmem+0xb6>
    1096:	0ce000ef          	jal	ra,1164 <printf>
    puts("exit pass.");
    109a:	00001517          	auipc	a0,0x1
    109e:	dee50513          	addi	a0,a0,-530 # 1e88 <sharedmem+0xc6>
    10a2:	07c000ef          	jal	ra,111e <puts>
    return 0;
}
    10a6:	70a2                	ld	ra,40(sp)
    10a8:	7402                	ld	s0,32(sp)
    10aa:	64e2                	ld	s1,24(sp)
    10ac:	4501                	li	a0,0
    10ae:	6145                	addi	sp,sp,48
    10b0:	8082                	ret
        printf("I am parent, fork a child pid %d\n", pid);
    10b2:	85aa                	mv	a1,a0
    10b4:	00001517          	auipc	a0,0x1
    10b8:	d5450513          	addi	a0,a0,-684 # 1e08 <sharedmem+0x46>
    10bc:	0a8000ef          	jal	ra,1164 <printf>
    10c0:	bfbd                	j	103e <main+0x3c>
    if(waitpid(pid, &xstate) > 0 || wait( &xstate) > 0) {
    10c2:	0068                	addi	a0,sp,12
    10c4:	409000ef          	jal	ra,1ccc <wait>
    10c8:	faa04be3          	bgtz	a0,107e <main+0x7c>
    10cc:	b7c1                	j	108c <main+0x8a>

00000000000010ce <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    10ce:	1141                	addi	sp,sp,-16
    10d0:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    10d2:	f31ff0ef          	jal	ra,1002 <main>
}
    10d6:	60a2                	ld	ra,8(sp)
    10d8:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    10da:	3830006f          	j	1c5c <exit>

00000000000010de <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    10de:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    10e0:	00f10593          	addi	a1,sp,15
    10e4:	4605                	li	a2,1
    10e6:	4501                	li	a0,0
int getchar() {
    10e8:	ec06                	sd	ra,24(sp)
    char byte = 0;
    10ea:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    10ee:	379000ef          	jal	ra,1c66 <read>
    return byte;
}
    10f2:	60e2                	ld	ra,24(sp)
    10f4:	00f14503          	lbu	a0,15(sp)
    10f8:	6105                	addi	sp,sp,32
    10fa:	8082                	ret

00000000000010fc <putchar>:

int putchar(int c)
{
    10fc:	1141                	addi	sp,sp,-16
    10fe:	e406                	sd	ra,8(sp)
    1100:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    1102:	00001597          	auipc	a1,0x1
    1106:	dbe58593          	addi	a1,a1,-578 # 1ec0 <put.1156>
    return write(stdout, put, 1);
    110a:	4605                	li	a2,1
    110c:	4505                	li	a0,1
    put[0] = c;
    110e:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1112:	35f000ef          	jal	ra,1c70 <write>
}
    1116:	60a2                	ld	ra,8(sp)
    1118:	2501                	sext.w	a0,a0
    111a:	0141                	addi	sp,sp,16
    111c:	8082                	ret

000000000000111e <puts>:

int puts(const char* s)
{
    111e:	1141                	addi	sp,sp,-16
    1120:	e022                	sd	s0,0(sp)
    1122:	e406                	sd	ra,8(sp)
    1124:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    1126:	66e000ef          	jal	ra,1794 <strlen>
    112a:	862a                	mv	a2,a0
    112c:	85a2                	mv	a1,s0
    112e:	4505                	li	a0,1
    1130:	341000ef          	jal	ra,1c70 <write>
    1134:	00055763          	bgez	a0,1142 <puts+0x24>
    return r;
}
    1138:	60a2                	ld	ra,8(sp)
    113a:	6402                	ld	s0,0(sp)
    113c:	557d                	li	a0,-1
    113e:	0141                	addi	sp,sp,16
    1140:	8082                	ret
    put[0] = c;
    1142:	00001597          	auipc	a1,0x1
    1146:	d7e58593          	addi	a1,a1,-642 # 1ec0 <put.1156>
    114a:	47a9                	li	a5,10
    return write(stdout, put, 1);
    114c:	4605                	li	a2,1
    114e:	4505                	li	a0,1
    put[0] = c;
    1150:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1154:	31d000ef          	jal	ra,1c70 <write>
}
    1158:	60a2                	ld	ra,8(sp)
    115a:	6402                	ld	s0,0(sp)
    115c:	41f5551b          	sraiw	a0,a0,0x1f
    1160:	0141                	addi	sp,sp,16
    1162:	8082                	ret

0000000000001164 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    1164:	7115                	addi	sp,sp,-224
    1166:	ed06                	sd	ra,152(sp)
    1168:	e922                	sd	s0,144(sp)
    116a:	e526                	sd	s1,136(sp)
    116c:	e14a                	sd	s2,128(sp)
    116e:	fcce                	sd	s3,120(sp)
    1170:	f8d2                	sd	s4,112(sp)
    1172:	f4d6                	sd	s5,104(sp)
    1174:	f0da                	sd	s6,96(sp)
    1176:	ecde                	sd	s7,88(sp)
    1178:	e8e2                	sd	s8,80(sp)
    117a:	e4e6                	sd	s9,72(sp)
    117c:	e0ea                	sd	s10,64(sp)
    117e:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1180:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    1184:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    1186:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    1188:	f52e                	sd	a1,168(sp)
    118a:	f932                	sd	a2,176(sp)
    118c:	fd36                	sd	a3,184(sp)
    118e:	e1ba                	sd	a4,192(sp)
    1190:	e9c2                	sd	a6,208(sp)
    1192:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    1194:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1196:	0c030b63          	beqz	t1,126c <printf+0x108>
    119a:	8aaa                	mv	s5,a0
    119c:	0003071b          	sext.w	a4,t1
    11a0:	4481                	li	s1,0
        if (c != '%') {
    11a2:	02500b93          	li	s7,37
    put[0] = c;
    11a6:	00001417          	auipc	s0,0x1
    11aa:	d1a40413          	addi	s0,s0,-742 # 1ec0 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    11ae:	4c51                	li	s8,20
    put[0] = c;
    11b0:	02500c93          	li	s9,37
    11b4:	00001a17          	auipc	s4,0x1
    11b8:	d14a0a13          	addi	s4,s4,-748 # 1ec8 <put.1156+0x8>
    11bc:	00001997          	auipc	s3,0x1
    11c0:	d6498993          	addi	s3,s3,-668 # 1f20 <digits>
    11c4:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    11c8:	0014879b          	addiw	a5,s1,1
    11cc:	00fa8933          	add	s2,s5,a5
    11d0:	13771163          	bne	a4,s7,12f2 <printf+0x18e>
        c = fmt[++i] & 0xff;
    11d4:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    11d8:	080d0a63          	beqz	s10,126c <printf+0x108>
        switch (c) {
    11dc:	2489                	addiw	s1,s1,2
    11de:	009a8933          	add	s2,s5,s1
    11e2:	257d0e63          	beq	s10,s7,143e <printf+0x2da>
    11e6:	f9cd079b          	addiw	a5,s10,-100
    11ea:	0ff7f793          	andi	a5,a5,255
    11ee:	0cfc6263          	bltu	s8,a5,12b2 <printf+0x14e>
    11f2:	078a                	slli	a5,a5,0x2
    11f4:	97d2                	add	a5,a5,s4
    11f6:	439c                	lw	a5,0(a5)
    11f8:	97d2                	add	a5,a5,s4
    11fa:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    11fc:	67a2                	ld	a5,8(sp)
    11fe:	4398                	lw	a4,0(a5)
    1200:	07a1                	addi	a5,a5,8
    1202:	e43e                	sd	a5,8(sp)
    1204:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    1208:	26074663          	bltz	a4,1474 <printf+0x310>
        buf[i++] = digits[x % base];
    120c:	8bbd                	andi	a5,a5,15
    120e:	97ce                	add	a5,a5,s3
    1210:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1214:	40475d1b          	sraiw	s10,a4,0x4
    1218:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    121c:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    1220:	020d0163          	beqz	s10,1242 <printf+0xde>
        buf[i++] = digits[x % base];
    1224:	9d4e                	add	s10,s10,s3
    1226:	000d4783          	lbu	a5,0(s10)
    122a:	4d05                	li	s10,1
    122c:	00f108a3          	sb	a5,17(sp)
    if (sign)
    1230:	00075963          	bgez	a4,1242 <printf+0xde>
        buf[i++] = digits[x % base];
    1234:	4d09                	li	s10,2
        buf[i++] = '-';
    1236:	181c                	addi	a5,sp,48
    1238:	02d00713          	li	a4,45
    123c:	97ea                	add	a5,a5,s10
    123e:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    1242:	9d5a                	add	s10,s10,s6
    1244:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1248:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    124c:	4605                	li	a2,1
    124e:	1d7d                	addi	s10,s10,-1
    1250:	85a2                	mv	a1,s0
    1252:	4505                	li	a0,1
    put[0] = c;
    1254:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1258:	219000ef          	jal	ra,1c70 <write>
    while (--i >= 0)
    125c:	ffbd16e3          	bne	s10,s11,1248 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1260:	00094303          	lbu	t1,0(s2)
    1264:	0003071b          	sext.w	a4,t1
    1268:	f60310e3          	bnez	t1,11c8 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    126c:	60ea                	ld	ra,152(sp)
    126e:	644a                	ld	s0,144(sp)
    1270:	64aa                	ld	s1,136(sp)
    1272:	690a                	ld	s2,128(sp)
    1274:	79e6                	ld	s3,120(sp)
    1276:	7a46                	ld	s4,112(sp)
    1278:	7aa6                	ld	s5,104(sp)
    127a:	7b06                	ld	s6,96(sp)
    127c:	6be6                	ld	s7,88(sp)
    127e:	6c46                	ld	s8,80(sp)
    1280:	6ca6                	ld	s9,72(sp)
    1282:	6d06                	ld	s10,64(sp)
    1284:	7de2                	ld	s11,56(sp)
    1286:	612d                	addi	sp,sp,224
    1288:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    128a:	67a2                	ld	a5,8(sp)
    128c:	0007bd03          	ld	s10,0(a5)
    1290:	07a1                	addi	a5,a5,8
    1292:	e43e                	sd	a5,8(sp)
    1294:	000d1b63          	bnez	s10,12aa <printf+0x146>
    1298:	aafd                	j	1496 <printf+0x332>
    return write(stdout, put, 1);
    129a:	4605                	li	a2,1
    129c:	85a2                	mv	a1,s0
    129e:	4505                	li	a0,1
                for (; *s; s++)
    12a0:	0d05                	addi	s10,s10,1
    put[0] = c;
    12a2:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    12a6:	1cb000ef          	jal	ra,1c70 <write>
                for (; *s; s++)
    12aa:	000d4783          	lbu	a5,0(s10)
    12ae:	f7f5                	bnez	a5,129a <printf+0x136>
    12b0:	a02d                	j	12da <printf+0x176>
    return write(stdout, put, 1);
    12b2:	4605                	li	a2,1
    12b4:	00001597          	auipc	a1,0x1
    12b8:	c0c58593          	addi	a1,a1,-1012 # 1ec0 <put.1156>
    12bc:	4505                	li	a0,1
    put[0] = c;
    12be:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    12c2:	1af000ef          	jal	ra,1c70 <write>
    12c6:	4605                	li	a2,1
    12c8:	00001597          	auipc	a1,0x1
    12cc:	bf858593          	addi	a1,a1,-1032 # 1ec0 <put.1156>
    12d0:	4505                	li	a0,1
    put[0] = c;
    12d2:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    12d6:	19b000ef          	jal	ra,1c70 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    12da:	00094303          	lbu	t1,0(s2)
    12de:	0003071b          	sext.w	a4,t1
    12e2:	f80305e3          	beqz	t1,126c <printf+0x108>
        if (c != '%') {
    12e6:	0014879b          	addiw	a5,s1,1
    12ea:	00fa8933          	add	s2,s5,a5
    12ee:	ef7703e3          	beq	a4,s7,11d4 <printf+0x70>
    return write(stdout, put, 1);
    12f2:	4605                	li	a2,1
    12f4:	00001597          	auipc	a1,0x1
    12f8:	bcc58593          	addi	a1,a1,-1076 # 1ec0 <put.1156>
    12fc:	4505                	li	a0,1
    put[0] = c;
    12fe:	00640023          	sb	t1,0(s0)
            continue;
    1302:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    1304:	16d000ef          	jal	ra,1c70 <write>
            continue;
    1308:	bfc9                	j	12da <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    130a:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    130c:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    130e:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    1310:	0007b883          	ld	a7,0(a5)
    1314:	07a1                	addi	a5,a5,8
    1316:	e43e                	sd	a5,8(sp)
        x = -xx;
    1318:	43f8d713          	srai	a4,a7,0x3f
    131c:	011747b3          	xor	a5,a4,a7
    1320:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    1322:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    1324:	02c7f733          	remu	a4,a5,a2
    1328:	8d36                	mv	s10,a3
    132a:	0685                	addi	a3,a3,1
    132c:	00db0533          	add	a0,s6,a3
    1330:	85be                	mv	a1,a5
    1332:	974e                	add	a4,a4,s3
    1334:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    1338:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    133c:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    1340:	feb862e3          	bltu	a6,a1,1324 <printf+0x1c0>
    if (sign)
    1344:	1208c063          	bltz	a7,1464 <printf+0x300>
    while (--i >= 0)
    1348:	9d5a                	add	s10,s10,s6
    put[0] = c;
    134a:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    134e:	4605                	li	a2,1
    1350:	85a2                	mv	a1,s0
    1352:	4505                	li	a0,1
    put[0] = c;
    1354:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1358:	119000ef          	jal	ra,1c70 <write>
    while (--i >= 0)
    135c:	87ea                	mv	a5,s10
    135e:	1d7d                	addi	s10,s10,-1
    1360:	fefb15e3          	bne	s6,a5,134a <printf+0x1e6>
    1364:	bf9d                	j	12da <printf+0x176>
                printptr(va_arg(ap, uint64));
    1366:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    1368:	4605                	li	a2,1
    136a:	00001597          	auipc	a1,0x1
    136e:	b5658593          	addi	a1,a1,-1194 # 1ec0 <put.1156>
                printptr(va_arg(ap, uint64));
    1372:	0007bd83          	ld	s11,0(a5)
    1376:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    137a:	4505                	li	a0,1
    put[0] = c;
    137c:	03000793          	li	a5,48
    1380:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    1384:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    1386:	0eb000ef          	jal	ra,1c70 <write>
    put[0] = c;
    138a:	07800793          	li	a5,120
    return write(stdout, put, 1);
    138e:	4605                	li	a2,1
    1390:	00001597          	auipc	a1,0x1
    1394:	b3058593          	addi	a1,a1,-1232 # 1ec0 <put.1156>
    1398:	4505                	li	a0,1
    put[0] = c;
    139a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    139e:	4d41                	li	s10,16
    13a0:	0d1000ef          	jal	ra,1c70 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    13a4:	03cdd793          	srli	a5,s11,0x3c
    13a8:	97ce                	add	a5,a5,s3
    put[0] = c;
    13aa:	0007c783          	lbu	a5,0(a5)
    13ae:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    13b0:	4605                	li	a2,1
    13b2:	85a2                	mv	a1,s0
    13b4:	4505                	li	a0,1
    put[0] = c;
    13b6:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    13ba:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    13bc:	0b5000ef          	jal	ra,1c70 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    13c0:	fe0d12e3          	bnez	s10,13a4 <printf+0x240>
    13c4:	bf19                	j	12da <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    13c6:	67a2                	ld	a5,8(sp)
    13c8:	4394                	lw	a3,0(a5)
    13ca:	07a1                	addi	a5,a5,8
    13cc:	e43e                	sd	a5,8(sp)
    13ce:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    13d2:	0006d663          	bgez	a3,13de <printf+0x27a>
        x = -xx;
    13d6:	40f007bb          	negw	a5,a5
    13da:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    13de:	4729                	li	a4,10
    13e0:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    13e4:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    13e8:	964e                	add	a2,a2,s3
    13ea:	00064603          	lbu	a2,0(a2)
    13ee:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    13f2:	0a0d0963          	beqz	s10,14a4 <printf+0x340>
        buf[i++] = digits[x % base];
    13f6:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    13fa:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    13fe:	00c98733          	add	a4,s3,a2
    1402:	00074703          	lbu	a4,0(a4)
    1406:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    140a:	c3cd                	beqz	a5,14ac <printf+0x348>
        buf[i++] = digits[x % base];
    140c:	97ce                	add	a5,a5,s3
    140e:	0007c703          	lbu	a4,0(a5)
    1412:	4d09                	li	s10,2
    1414:	478d                	li	a5,3
    1416:	00e10923          	sb	a4,18(sp)
    if (sign)
    141a:	0206cd63          	bltz	a3,1454 <printf+0x2f0>
    while (--i >= 0)
    141e:	9d5a                	add	s10,s10,s6
    1420:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1424:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1428:	4605                	li	a2,1
    142a:	1d7d                	addi	s10,s10,-1
    142c:	85a2                	mv	a1,s0
    142e:	4505                	li	a0,1
    put[0] = c;
    1430:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1434:	03d000ef          	jal	ra,1c70 <write>
    while (--i >= 0)
    1438:	ffbd16e3          	bne	s10,s11,1424 <printf+0x2c0>
    143c:	bd79                	j	12da <printf+0x176>
    return write(stdout, put, 1);
    143e:	4605                	li	a2,1
    1440:	00001597          	auipc	a1,0x1
    1444:	a8058593          	addi	a1,a1,-1408 # 1ec0 <put.1156>
    1448:	4505                	li	a0,1
    put[0] = c;
    144a:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    144e:	023000ef          	jal	ra,1c70 <write>
    1452:	b561                	j	12da <printf+0x176>
        buf[i++] = '-';
    1454:	1818                	addi	a4,sp,48
    1456:	973e                	add	a4,a4,a5
    1458:	02d00693          	li	a3,45
    145c:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    1460:	8d3e                	mv	s10,a5
    1462:	bf75                	j	141e <printf+0x2ba>
        buf[i++] = '-';
    1464:	181c                	addi	a5,sp,48
    1466:	97b6                	add	a5,a5,a3
    1468:	02d00713          	li	a4,45
    146c:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    1470:	8d36                	mv	s10,a3
    1472:	bdd9                	j	1348 <printf+0x1e4>
        x = -xx;
    1474:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    1478:	00f7f693          	andi	a3,a5,15
    147c:	96ce                	add	a3,a3,s3
    147e:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    1482:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    1486:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    148a:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    148e:	d80d1be3          	bnez	s10,1224 <printf+0xc0>
        buf[i++] = digits[x % base];
    1492:	4d05                	li	s10,1
    1494:	b34d                	j	1236 <printf+0xd2>
                s = "(null)";
    1496:	00001d17          	auipc	s10,0x1
    149a:	a02d0d13          	addi	s10,s10,-1534 # 1e98 <sharedmem+0xd6>
                for (; *s; s++)
    149e:	02800793          	li	a5,40
    14a2:	bbe5                	j	129a <printf+0x136>
        buf[i++] = digits[x % base];
    14a4:	4785                	li	a5,1
    if (sign)
    14a6:	f606dce3          	bgez	a3,141e <printf+0x2ba>
    14aa:	b76d                	j	1454 <printf+0x2f0>
        buf[i++] = digits[x % base];
    14ac:	4789                	li	a5,2
    14ae:	4d05                	li	s10,1
    if (sign)
    14b0:	f606d7e3          	bgez	a3,141e <printf+0x2ba>
    14b4:	b745                	j	1454 <printf+0x2f0>

00000000000014b6 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    14b6:	02000793          	li	a5,32
    14ba:	00f50663          	beq	a0,a5,14c6 <isspace+0x10>
    14be:	355d                	addiw	a0,a0,-9
    14c0:	00553513          	sltiu	a0,a0,5
    14c4:	8082                	ret
    14c6:	4505                	li	a0,1
}
    14c8:	8082                	ret

00000000000014ca <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    14ca:	fd05051b          	addiw	a0,a0,-48
}
    14ce:	00a53513          	sltiu	a0,a0,10
    14d2:	8082                	ret

00000000000014d4 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    14d4:	02000613          	li	a2,32
    14d8:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    14da:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    14de:	ff77069b          	addiw	a3,a4,-9
    14e2:	04c70d63          	beq	a4,a2,153c <atoi+0x68>
    14e6:	0007079b          	sext.w	a5,a4
    14ea:	04d5f963          	bgeu	a1,a3,153c <atoi+0x68>
        s++;
    switch (*s) {
    14ee:	02b00693          	li	a3,43
    14f2:	04d70a63          	beq	a4,a3,1546 <atoi+0x72>
    14f6:	02d00693          	li	a3,45
    14fa:	06d70463          	beq	a4,a3,1562 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    14fe:	fd07859b          	addiw	a1,a5,-48
    1502:	4625                	li	a2,9
    1504:	873e                	mv	a4,a5
    1506:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1508:	4e01                	li	t3,0
    while (isdigit(*s))
    150a:	04b66a63          	bltu	a2,a1,155e <atoi+0x8a>
    int n = 0, neg = 0;
    150e:	4501                	li	a0,0
    while (isdigit(*s))
    1510:	4825                	li	a6,9
    1512:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1516:	0025179b          	slliw	a5,a0,0x2
    151a:	9d3d                	addw	a0,a0,a5
    151c:	fd07031b          	addiw	t1,a4,-48
    1520:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1524:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1528:	0685                	addi	a3,a3,1
    152a:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    152e:	0006071b          	sext.w	a4,a2
    1532:	feb870e3          	bgeu	a6,a1,1512 <atoi+0x3e>
    return neg ? n : -n;
    1536:	000e0563          	beqz	t3,1540 <atoi+0x6c>
}
    153a:	8082                	ret
        s++;
    153c:	0505                	addi	a0,a0,1
    153e:	bf71                	j	14da <atoi+0x6>
    1540:	4113053b          	subw	a0,t1,a7
    1544:	8082                	ret
    while (isdigit(*s))
    1546:	00154783          	lbu	a5,1(a0)
    154a:	4625                	li	a2,9
        s++;
    154c:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1550:	fd07859b          	addiw	a1,a5,-48
    1554:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1558:	4e01                	li	t3,0
    while (isdigit(*s))
    155a:	fab67ae3          	bgeu	a2,a1,150e <atoi+0x3a>
    155e:	4501                	li	a0,0
}
    1560:	8082                	ret
    while (isdigit(*s))
    1562:	00154783          	lbu	a5,1(a0)
    1566:	4625                	li	a2,9
        s++;
    1568:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    156c:	fd07859b          	addiw	a1,a5,-48
    1570:	0007871b          	sext.w	a4,a5
    1574:	feb665e3          	bltu	a2,a1,155e <atoi+0x8a>
        neg = 1;
    1578:	4e05                	li	t3,1
    157a:	bf51                	j	150e <atoi+0x3a>

000000000000157c <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    157c:	16060d63          	beqz	a2,16f6 <memset+0x17a>
    1580:	40a007b3          	neg	a5,a0
    1584:	8b9d                	andi	a5,a5,7
    1586:	00778713          	addi	a4,a5,7
    158a:	482d                	li	a6,11
    158c:	0ff5f593          	andi	a1,a1,255
    1590:	fff60693          	addi	a3,a2,-1
    1594:	17076263          	bltu	a4,a6,16f8 <memset+0x17c>
    1598:	16e6ea63          	bltu	a3,a4,170c <memset+0x190>
    159c:	16078563          	beqz	a5,1706 <memset+0x18a>
    15a0:	00b50023          	sb	a1,0(a0)
    15a4:	4705                	li	a4,1
    15a6:	00150e93          	addi	t4,a0,1
    15aa:	14e78c63          	beq	a5,a4,1702 <memset+0x186>
    15ae:	00b500a3          	sb	a1,1(a0)
    15b2:	4709                	li	a4,2
    15b4:	00250e93          	addi	t4,a0,2
    15b8:	14e78d63          	beq	a5,a4,1712 <memset+0x196>
    15bc:	00b50123          	sb	a1,2(a0)
    15c0:	470d                	li	a4,3
    15c2:	00350e93          	addi	t4,a0,3
    15c6:	12e78b63          	beq	a5,a4,16fc <memset+0x180>
    15ca:	00b501a3          	sb	a1,3(a0)
    15ce:	4711                	li	a4,4
    15d0:	00450e93          	addi	t4,a0,4
    15d4:	14e78163          	beq	a5,a4,1716 <memset+0x19a>
    15d8:	00b50223          	sb	a1,4(a0)
    15dc:	4715                	li	a4,5
    15de:	00550e93          	addi	t4,a0,5
    15e2:	12e78c63          	beq	a5,a4,171a <memset+0x19e>
    15e6:	00b502a3          	sb	a1,5(a0)
    15ea:	471d                	li	a4,7
    15ec:	00650e93          	addi	t4,a0,6
    15f0:	12e79763          	bne	a5,a4,171e <memset+0x1a2>
    15f4:	00750e93          	addi	t4,a0,7
    15f8:	00b50323          	sb	a1,6(a0)
    15fc:	4f1d                	li	t5,7
    15fe:	00859713          	slli	a4,a1,0x8
    1602:	8f4d                	or	a4,a4,a1
    1604:	01059e13          	slli	t3,a1,0x10
    1608:	01c76e33          	or	t3,a4,t3
    160c:	01859313          	slli	t1,a1,0x18
    1610:	006e6333          	or	t1,t3,t1
    1614:	02059893          	slli	a7,a1,0x20
    1618:	011368b3          	or	a7,t1,a7
    161c:	02859813          	slli	a6,a1,0x28
    1620:	40f60333          	sub	t1,a2,a5
    1624:	0108e833          	or	a6,a7,a6
    1628:	03059693          	slli	a3,a1,0x30
    162c:	00d866b3          	or	a3,a6,a3
    1630:	03859713          	slli	a4,a1,0x38
    1634:	97aa                	add	a5,a5,a0
    1636:	ff837813          	andi	a6,t1,-8
    163a:	8f55                	or	a4,a4,a3
    163c:	00f806b3          	add	a3,a6,a5
    1640:	e398                	sd	a4,0(a5)
    1642:	07a1                	addi	a5,a5,8
    1644:	fed79ee3          	bne	a5,a3,1640 <memset+0xc4>
    1648:	ff837693          	andi	a3,t1,-8
    164c:	00de87b3          	add	a5,t4,a3
    1650:	01e6873b          	addw	a4,a3,t5
    1654:	0ad30663          	beq	t1,a3,1700 <memset+0x184>
    1658:	00b78023          	sb	a1,0(a5)
    165c:	0017069b          	addiw	a3,a4,1
    1660:	08c6fb63          	bgeu	a3,a2,16f6 <memset+0x17a>
    1664:	00b780a3          	sb	a1,1(a5)
    1668:	0027069b          	addiw	a3,a4,2
    166c:	08c6f563          	bgeu	a3,a2,16f6 <memset+0x17a>
    1670:	00b78123          	sb	a1,2(a5)
    1674:	0037069b          	addiw	a3,a4,3
    1678:	06c6ff63          	bgeu	a3,a2,16f6 <memset+0x17a>
    167c:	00b781a3          	sb	a1,3(a5)
    1680:	0047069b          	addiw	a3,a4,4
    1684:	06c6f963          	bgeu	a3,a2,16f6 <memset+0x17a>
    1688:	00b78223          	sb	a1,4(a5)
    168c:	0057069b          	addiw	a3,a4,5
    1690:	06c6f363          	bgeu	a3,a2,16f6 <memset+0x17a>
    1694:	00b782a3          	sb	a1,5(a5)
    1698:	0067069b          	addiw	a3,a4,6
    169c:	04c6fd63          	bgeu	a3,a2,16f6 <memset+0x17a>
    16a0:	00b78323          	sb	a1,6(a5)
    16a4:	0077069b          	addiw	a3,a4,7
    16a8:	04c6f763          	bgeu	a3,a2,16f6 <memset+0x17a>
    16ac:	00b783a3          	sb	a1,7(a5)
    16b0:	0087069b          	addiw	a3,a4,8
    16b4:	04c6f163          	bgeu	a3,a2,16f6 <memset+0x17a>
    16b8:	00b78423          	sb	a1,8(a5)
    16bc:	0097069b          	addiw	a3,a4,9
    16c0:	02c6fb63          	bgeu	a3,a2,16f6 <memset+0x17a>
    16c4:	00b784a3          	sb	a1,9(a5)
    16c8:	00a7069b          	addiw	a3,a4,10
    16cc:	02c6f563          	bgeu	a3,a2,16f6 <memset+0x17a>
    16d0:	00b78523          	sb	a1,10(a5)
    16d4:	00b7069b          	addiw	a3,a4,11
    16d8:	00c6ff63          	bgeu	a3,a2,16f6 <memset+0x17a>
    16dc:	00b785a3          	sb	a1,11(a5)
    16e0:	00c7069b          	addiw	a3,a4,12
    16e4:	00c6f963          	bgeu	a3,a2,16f6 <memset+0x17a>
    16e8:	00b78623          	sb	a1,12(a5)
    16ec:	2735                	addiw	a4,a4,13
    16ee:	00c77463          	bgeu	a4,a2,16f6 <memset+0x17a>
    16f2:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    16f6:	8082                	ret
    16f8:	472d                	li	a4,11
    16fa:	bd79                	j	1598 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    16fc:	4f0d                	li	t5,3
    16fe:	b701                	j	15fe <memset+0x82>
    1700:	8082                	ret
    1702:	4f05                	li	t5,1
    1704:	bded                	j	15fe <memset+0x82>
    1706:	8eaa                	mv	t4,a0
    1708:	4f01                	li	t5,0
    170a:	bdd5                	j	15fe <memset+0x82>
    170c:	87aa                	mv	a5,a0
    170e:	4701                	li	a4,0
    1710:	b7a1                	j	1658 <memset+0xdc>
    1712:	4f09                	li	t5,2
    1714:	b5ed                	j	15fe <memset+0x82>
    1716:	4f11                	li	t5,4
    1718:	b5dd                	j	15fe <memset+0x82>
    171a:	4f15                	li	t5,5
    171c:	b5cd                	j	15fe <memset+0x82>
    171e:	4f19                	li	t5,6
    1720:	bdf9                	j	15fe <memset+0x82>

0000000000001722 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    1722:	00054783          	lbu	a5,0(a0)
    1726:	0005c703          	lbu	a4,0(a1)
    172a:	00e79863          	bne	a5,a4,173a <strcmp+0x18>
    172e:	0505                	addi	a0,a0,1
    1730:	0585                	addi	a1,a1,1
    1732:	fbe5                	bnez	a5,1722 <strcmp>
    1734:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    1736:	9d19                	subw	a0,a0,a4
    1738:	8082                	ret
    173a:	0007851b          	sext.w	a0,a5
    173e:	bfe5                	j	1736 <strcmp+0x14>

0000000000001740 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1740:	87aa                	mv	a5,a0
    1742:	0005c703          	lbu	a4,0(a1)
    1746:	0785                	addi	a5,a5,1
    1748:	0585                	addi	a1,a1,1
    174a:	fee78fa3          	sb	a4,-1(a5)
    174e:	fb75                	bnez	a4,1742 <strcpy+0x2>
        ;
    return os;
}
    1750:	8082                	ret

0000000000001752 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    1752:	ce05                	beqz	a2,178a <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1754:	00054703          	lbu	a4,0(a0)
    1758:	0005c783          	lbu	a5,0(a1)
    175c:	cb0d                	beqz	a4,178e <strncmp+0x3c>
    if (!n--)
    175e:	167d                	addi	a2,a2,-1
    1760:	00c506b3          	add	a3,a0,a2
    1764:	a819                	j	177a <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1766:	00a68e63          	beq	a3,a0,1782 <strncmp+0x30>
    176a:	0505                	addi	a0,a0,1
    176c:	00e79b63          	bne	a5,a4,1782 <strncmp+0x30>
    1770:	00054703          	lbu	a4,0(a0)
    1774:	0005c783          	lbu	a5,0(a1)
    1778:	cb19                	beqz	a4,178e <strncmp+0x3c>
    177a:	0005c783          	lbu	a5,0(a1)
    177e:	0585                	addi	a1,a1,1
    1780:	f3fd                	bnez	a5,1766 <strncmp+0x14>
        ;
    return *l - *r;
    1782:	0007051b          	sext.w	a0,a4
    1786:	9d1d                	subw	a0,a0,a5
    1788:	8082                	ret
        return 0;
    178a:	4501                	li	a0,0
}
    178c:	8082                	ret
    178e:	4501                	li	a0,0
    return *l - *r;
    1790:	9d1d                	subw	a0,a0,a5
    1792:	8082                	ret

0000000000001794 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    1794:	00757793          	andi	a5,a0,7
    1798:	cf89                	beqz	a5,17b2 <strlen+0x1e>
    179a:	87aa                	mv	a5,a0
    179c:	a029                	j	17a6 <strlen+0x12>
    179e:	0785                	addi	a5,a5,1
    17a0:	0077f713          	andi	a4,a5,7
    17a4:	cb01                	beqz	a4,17b4 <strlen+0x20>
        if (!*s)
    17a6:	0007c703          	lbu	a4,0(a5)
    17aa:	fb75                	bnez	a4,179e <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    17ac:	40a78533          	sub	a0,a5,a0
}
    17b0:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    17b2:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    17b4:	6394                	ld	a3,0(a5)
    17b6:	00000597          	auipc	a1,0x0
    17ba:	6f25b583          	ld	a1,1778(a1) # 1ea8 <max_child+0x4>
    17be:	00000617          	auipc	a2,0x0
    17c2:	6f263603          	ld	a2,1778(a2) # 1eb0 <max_child+0xc>
    17c6:	a019                	j	17cc <strlen+0x38>
    17c8:	6794                	ld	a3,8(a5)
    17ca:	07a1                	addi	a5,a5,8
    17cc:	00b68733          	add	a4,a3,a1
    17d0:	fff6c693          	not	a3,a3
    17d4:	8f75                	and	a4,a4,a3
    17d6:	8f71                	and	a4,a4,a2
    17d8:	db65                	beqz	a4,17c8 <strlen+0x34>
    for (; *s; s++)
    17da:	0007c703          	lbu	a4,0(a5)
    17de:	d779                	beqz	a4,17ac <strlen+0x18>
    17e0:	0017c703          	lbu	a4,1(a5)
    17e4:	0785                	addi	a5,a5,1
    17e6:	d379                	beqz	a4,17ac <strlen+0x18>
    17e8:	0017c703          	lbu	a4,1(a5)
    17ec:	0785                	addi	a5,a5,1
    17ee:	fb6d                	bnez	a4,17e0 <strlen+0x4c>
    17f0:	bf75                	j	17ac <strlen+0x18>

00000000000017f2 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    17f2:	00757713          	andi	a4,a0,7
{
    17f6:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    17f8:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    17fc:	cb19                	beqz	a4,1812 <memchr+0x20>
    17fe:	ce25                	beqz	a2,1876 <memchr+0x84>
    1800:	0007c703          	lbu	a4,0(a5)
    1804:	04b70e63          	beq	a4,a1,1860 <memchr+0x6e>
    1808:	0785                	addi	a5,a5,1
    180a:	0077f713          	andi	a4,a5,7
    180e:	167d                	addi	a2,a2,-1
    1810:	f77d                	bnez	a4,17fe <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    1812:	4501                	li	a0,0
    if (n && *s != c) {
    1814:	c235                	beqz	a2,1878 <memchr+0x86>
    1816:	0007c703          	lbu	a4,0(a5)
    181a:	04b70363          	beq	a4,a1,1860 <memchr+0x6e>
        size_t k = ONES * c;
    181e:	00000517          	auipc	a0,0x0
    1822:	69a53503          	ld	a0,1690(a0) # 1eb8 <max_child+0x14>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1826:	471d                	li	a4,7
        size_t k = ONES * c;
    1828:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    182c:	02c77a63          	bgeu	a4,a2,1860 <memchr+0x6e>
    1830:	00000897          	auipc	a7,0x0
    1834:	6788b883          	ld	a7,1656(a7) # 1ea8 <max_child+0x4>
    1838:	00000817          	auipc	a6,0x0
    183c:	67883803          	ld	a6,1656(a6) # 1eb0 <max_child+0xc>
    1840:	431d                	li	t1,7
    1842:	a029                	j	184c <memchr+0x5a>
    1844:	1661                	addi	a2,a2,-8
    1846:	07a1                	addi	a5,a5,8
    1848:	02c37963          	bgeu	t1,a2,187a <memchr+0x88>
    184c:	6398                	ld	a4,0(a5)
    184e:	8f29                	xor	a4,a4,a0
    1850:	011706b3          	add	a3,a4,a7
    1854:	fff74713          	not	a4,a4
    1858:	8f75                	and	a4,a4,a3
    185a:	01077733          	and	a4,a4,a6
    185e:	d37d                	beqz	a4,1844 <memchr+0x52>
    1860:	853e                	mv	a0,a5
    1862:	97b2                	add	a5,a5,a2
    1864:	a021                	j	186c <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1866:	0505                	addi	a0,a0,1
    1868:	00f50763          	beq	a0,a5,1876 <memchr+0x84>
    186c:	00054703          	lbu	a4,0(a0)
    1870:	feb71be3          	bne	a4,a1,1866 <memchr+0x74>
    1874:	8082                	ret
    return n ? (void*)s : 0;
    1876:	4501                	li	a0,0
}
    1878:	8082                	ret
    return n ? (void*)s : 0;
    187a:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    187c:	f275                	bnez	a2,1860 <memchr+0x6e>
}
    187e:	8082                	ret

0000000000001880 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1880:	1101                	addi	sp,sp,-32
    1882:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1884:	862e                	mv	a2,a1
{
    1886:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1888:	4581                	li	a1,0
{
    188a:	e426                	sd	s1,8(sp)
    188c:	ec06                	sd	ra,24(sp)
    188e:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1890:	f63ff0ef          	jal	ra,17f2 <memchr>
    return p ? p - s : n;
    1894:	c519                	beqz	a0,18a2 <strnlen+0x22>
}
    1896:	60e2                	ld	ra,24(sp)
    1898:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    189a:	8d05                	sub	a0,a0,s1
}
    189c:	64a2                	ld	s1,8(sp)
    189e:	6105                	addi	sp,sp,32
    18a0:	8082                	ret
    18a2:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    18a4:	8522                	mv	a0,s0
}
    18a6:	6442                	ld	s0,16(sp)
    18a8:	64a2                	ld	s1,8(sp)
    18aa:	6105                	addi	sp,sp,32
    18ac:	8082                	ret

00000000000018ae <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    18ae:	00b547b3          	xor	a5,a0,a1
    18b2:	8b9d                	andi	a5,a5,7
    18b4:	eb95                	bnez	a5,18e8 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    18b6:	0075f793          	andi	a5,a1,7
    18ba:	e7b1                	bnez	a5,1906 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    18bc:	6198                	ld	a4,0(a1)
    18be:	00000617          	auipc	a2,0x0
    18c2:	5ea63603          	ld	a2,1514(a2) # 1ea8 <max_child+0x4>
    18c6:	00000817          	auipc	a6,0x0
    18ca:	5ea83803          	ld	a6,1514(a6) # 1eb0 <max_child+0xc>
    18ce:	a029                	j	18d8 <stpcpy+0x2a>
    18d0:	e118                	sd	a4,0(a0)
    18d2:	6598                	ld	a4,8(a1)
    18d4:	05a1                	addi	a1,a1,8
    18d6:	0521                	addi	a0,a0,8
    18d8:	00c707b3          	add	a5,a4,a2
    18dc:	fff74693          	not	a3,a4
    18e0:	8ff5                	and	a5,a5,a3
    18e2:	0107f7b3          	and	a5,a5,a6
    18e6:	d7ed                	beqz	a5,18d0 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    18e8:	0005c783          	lbu	a5,0(a1)
    18ec:	00f50023          	sb	a5,0(a0)
    18f0:	c785                	beqz	a5,1918 <stpcpy+0x6a>
    18f2:	0015c783          	lbu	a5,1(a1)
    18f6:	0505                	addi	a0,a0,1
    18f8:	0585                	addi	a1,a1,1
    18fa:	00f50023          	sb	a5,0(a0)
    18fe:	fbf5                	bnez	a5,18f2 <stpcpy+0x44>
        ;
    return d;
}
    1900:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1902:	0505                	addi	a0,a0,1
    1904:	df45                	beqz	a4,18bc <stpcpy+0xe>
            if (!(*d = *s))
    1906:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    190a:	0585                	addi	a1,a1,1
    190c:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1910:	00f50023          	sb	a5,0(a0)
    1914:	f7fd                	bnez	a5,1902 <stpcpy+0x54>
}
    1916:	8082                	ret
    1918:	8082                	ret

000000000000191a <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    191a:	00b547b3          	xor	a5,a0,a1
    191e:	8b9d                	andi	a5,a5,7
    1920:	1a079863          	bnez	a5,1ad0 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1924:	0075f793          	andi	a5,a1,7
    1928:	16078463          	beqz	a5,1a90 <stpncpy+0x176>
    192c:	ea01                	bnez	a2,193c <stpncpy+0x22>
    192e:	a421                	j	1b36 <stpncpy+0x21c>
    1930:	167d                	addi	a2,a2,-1
    1932:	0505                	addi	a0,a0,1
    1934:	14070e63          	beqz	a4,1a90 <stpncpy+0x176>
    1938:	1a060863          	beqz	a2,1ae8 <stpncpy+0x1ce>
    193c:	0005c783          	lbu	a5,0(a1)
    1940:	0585                	addi	a1,a1,1
    1942:	0075f713          	andi	a4,a1,7
    1946:	00f50023          	sb	a5,0(a0)
    194a:	f3fd                	bnez	a5,1930 <stpncpy+0x16>
    194c:	4805                	li	a6,1
    194e:	1a061863          	bnez	a2,1afe <stpncpy+0x1e4>
    1952:	40a007b3          	neg	a5,a0
    1956:	8b9d                	andi	a5,a5,7
    1958:	4681                	li	a3,0
    195a:	18061a63          	bnez	a2,1aee <stpncpy+0x1d4>
    195e:	00778713          	addi	a4,a5,7
    1962:	45ad                	li	a1,11
    1964:	18b76363          	bltu	a4,a1,1aea <stpncpy+0x1d0>
    1968:	1ae6eb63          	bltu	a3,a4,1b1e <stpncpy+0x204>
    196c:	1a078363          	beqz	a5,1b12 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1970:	00050023          	sb	zero,0(a0)
    1974:	4685                	li	a3,1
    1976:	00150713          	addi	a4,a0,1
    197a:	18d78f63          	beq	a5,a3,1b18 <stpncpy+0x1fe>
    197e:	000500a3          	sb	zero,1(a0)
    1982:	4689                	li	a3,2
    1984:	00250713          	addi	a4,a0,2
    1988:	18d78e63          	beq	a5,a3,1b24 <stpncpy+0x20a>
    198c:	00050123          	sb	zero,2(a0)
    1990:	468d                	li	a3,3
    1992:	00350713          	addi	a4,a0,3
    1996:	16d78c63          	beq	a5,a3,1b0e <stpncpy+0x1f4>
    199a:	000501a3          	sb	zero,3(a0)
    199e:	4691                	li	a3,4
    19a0:	00450713          	addi	a4,a0,4
    19a4:	18d78263          	beq	a5,a3,1b28 <stpncpy+0x20e>
    19a8:	00050223          	sb	zero,4(a0)
    19ac:	4695                	li	a3,5
    19ae:	00550713          	addi	a4,a0,5
    19b2:	16d78d63          	beq	a5,a3,1b2c <stpncpy+0x212>
    19b6:	000502a3          	sb	zero,5(a0)
    19ba:	469d                	li	a3,7
    19bc:	00650713          	addi	a4,a0,6
    19c0:	16d79863          	bne	a5,a3,1b30 <stpncpy+0x216>
    19c4:	00750713          	addi	a4,a0,7
    19c8:	00050323          	sb	zero,6(a0)
    19cc:	40f80833          	sub	a6,a6,a5
    19d0:	ff887593          	andi	a1,a6,-8
    19d4:	97aa                	add	a5,a5,a0
    19d6:	95be                	add	a1,a1,a5
    19d8:	0007b023          	sd	zero,0(a5)
    19dc:	07a1                	addi	a5,a5,8
    19de:	feb79de3          	bne	a5,a1,19d8 <stpncpy+0xbe>
    19e2:	ff887593          	andi	a1,a6,-8
    19e6:	9ead                	addw	a3,a3,a1
    19e8:	00b707b3          	add	a5,a4,a1
    19ec:	12b80863          	beq	a6,a1,1b1c <stpncpy+0x202>
    19f0:	00078023          	sb	zero,0(a5)
    19f4:	0016871b          	addiw	a4,a3,1
    19f8:	0ec77863          	bgeu	a4,a2,1ae8 <stpncpy+0x1ce>
    19fc:	000780a3          	sb	zero,1(a5)
    1a00:	0026871b          	addiw	a4,a3,2
    1a04:	0ec77263          	bgeu	a4,a2,1ae8 <stpncpy+0x1ce>
    1a08:	00078123          	sb	zero,2(a5)
    1a0c:	0036871b          	addiw	a4,a3,3
    1a10:	0cc77c63          	bgeu	a4,a2,1ae8 <stpncpy+0x1ce>
    1a14:	000781a3          	sb	zero,3(a5)
    1a18:	0046871b          	addiw	a4,a3,4
    1a1c:	0cc77663          	bgeu	a4,a2,1ae8 <stpncpy+0x1ce>
    1a20:	00078223          	sb	zero,4(a5)
    1a24:	0056871b          	addiw	a4,a3,5
    1a28:	0cc77063          	bgeu	a4,a2,1ae8 <stpncpy+0x1ce>
    1a2c:	000782a3          	sb	zero,5(a5)
    1a30:	0066871b          	addiw	a4,a3,6
    1a34:	0ac77a63          	bgeu	a4,a2,1ae8 <stpncpy+0x1ce>
    1a38:	00078323          	sb	zero,6(a5)
    1a3c:	0076871b          	addiw	a4,a3,7
    1a40:	0ac77463          	bgeu	a4,a2,1ae8 <stpncpy+0x1ce>
    1a44:	000783a3          	sb	zero,7(a5)
    1a48:	0086871b          	addiw	a4,a3,8
    1a4c:	08c77e63          	bgeu	a4,a2,1ae8 <stpncpy+0x1ce>
    1a50:	00078423          	sb	zero,8(a5)
    1a54:	0096871b          	addiw	a4,a3,9
    1a58:	08c77863          	bgeu	a4,a2,1ae8 <stpncpy+0x1ce>
    1a5c:	000784a3          	sb	zero,9(a5)
    1a60:	00a6871b          	addiw	a4,a3,10
    1a64:	08c77263          	bgeu	a4,a2,1ae8 <stpncpy+0x1ce>
    1a68:	00078523          	sb	zero,10(a5)
    1a6c:	00b6871b          	addiw	a4,a3,11
    1a70:	06c77c63          	bgeu	a4,a2,1ae8 <stpncpy+0x1ce>
    1a74:	000785a3          	sb	zero,11(a5)
    1a78:	00c6871b          	addiw	a4,a3,12
    1a7c:	06c77663          	bgeu	a4,a2,1ae8 <stpncpy+0x1ce>
    1a80:	00078623          	sb	zero,12(a5)
    1a84:	26b5                	addiw	a3,a3,13
    1a86:	06c6f163          	bgeu	a3,a2,1ae8 <stpncpy+0x1ce>
    1a8a:	000786a3          	sb	zero,13(a5)
    1a8e:	8082                	ret
            ;
        if (!n || !*s)
    1a90:	c645                	beqz	a2,1b38 <stpncpy+0x21e>
    1a92:	0005c783          	lbu	a5,0(a1)
    1a96:	ea078be3          	beqz	a5,194c <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1a9a:	479d                	li	a5,7
    1a9c:	02c7ff63          	bgeu	a5,a2,1ada <stpncpy+0x1c0>
    1aa0:	00000897          	auipc	a7,0x0
    1aa4:	4088b883          	ld	a7,1032(a7) # 1ea8 <max_child+0x4>
    1aa8:	00000817          	auipc	a6,0x0
    1aac:	40883803          	ld	a6,1032(a6) # 1eb0 <max_child+0xc>
    1ab0:	431d                	li	t1,7
    1ab2:	6198                	ld	a4,0(a1)
    1ab4:	011707b3          	add	a5,a4,a7
    1ab8:	fff74693          	not	a3,a4
    1abc:	8ff5                	and	a5,a5,a3
    1abe:	0107f7b3          	and	a5,a5,a6
    1ac2:	ef81                	bnez	a5,1ada <stpncpy+0x1c0>
            *wd = *ws;
    1ac4:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1ac6:	1661                	addi	a2,a2,-8
    1ac8:	05a1                	addi	a1,a1,8
    1aca:	0521                	addi	a0,a0,8
    1acc:	fec363e3          	bltu	t1,a2,1ab2 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1ad0:	e609                	bnez	a2,1ada <stpncpy+0x1c0>
    1ad2:	a08d                	j	1b34 <stpncpy+0x21a>
    1ad4:	167d                	addi	a2,a2,-1
    1ad6:	0505                	addi	a0,a0,1
    1ad8:	ca01                	beqz	a2,1ae8 <stpncpy+0x1ce>
    1ada:	0005c783          	lbu	a5,0(a1)
    1ade:	0585                	addi	a1,a1,1
    1ae0:	00f50023          	sb	a5,0(a0)
    1ae4:	fbe5                	bnez	a5,1ad4 <stpncpy+0x1ba>
        ;
tail:
    1ae6:	b59d                	j	194c <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1ae8:	8082                	ret
    1aea:	472d                	li	a4,11
    1aec:	bdb5                	j	1968 <stpncpy+0x4e>
    1aee:	00778713          	addi	a4,a5,7
    1af2:	45ad                	li	a1,11
    1af4:	fff60693          	addi	a3,a2,-1
    1af8:	e6b778e3          	bgeu	a4,a1,1968 <stpncpy+0x4e>
    1afc:	b7fd                	j	1aea <stpncpy+0x1d0>
    1afe:	40a007b3          	neg	a5,a0
    1b02:	8832                	mv	a6,a2
    1b04:	8b9d                	andi	a5,a5,7
    1b06:	4681                	li	a3,0
    1b08:	e4060be3          	beqz	a2,195e <stpncpy+0x44>
    1b0c:	b7cd                	j	1aee <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1b0e:	468d                	li	a3,3
    1b10:	bd75                	j	19cc <stpncpy+0xb2>
    1b12:	872a                	mv	a4,a0
    1b14:	4681                	li	a3,0
    1b16:	bd5d                	j	19cc <stpncpy+0xb2>
    1b18:	4685                	li	a3,1
    1b1a:	bd4d                	j	19cc <stpncpy+0xb2>
    1b1c:	8082                	ret
    1b1e:	87aa                	mv	a5,a0
    1b20:	4681                	li	a3,0
    1b22:	b5f9                	j	19f0 <stpncpy+0xd6>
    1b24:	4689                	li	a3,2
    1b26:	b55d                	j	19cc <stpncpy+0xb2>
    1b28:	4691                	li	a3,4
    1b2a:	b54d                	j	19cc <stpncpy+0xb2>
    1b2c:	4695                	li	a3,5
    1b2e:	bd79                	j	19cc <stpncpy+0xb2>
    1b30:	4699                	li	a3,6
    1b32:	bd69                	j	19cc <stpncpy+0xb2>
    1b34:	8082                	ret
    1b36:	8082                	ret
    1b38:	8082                	ret

0000000000001b3a <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1b3a:	fff6071b          	addiw	a4,a2,-1
    1b3e:	0cb57063          	bgeu	a0,a1,1bfe <memmove+0xc4>
        while (n-- > 0)
    1b42:	0ec05063          	blez	a2,1c22 <memmove+0xe8>
    1b46:	00750693          	addi	a3,a0,7
    1b4a:	8e8d                	sub	a3,a3,a1
    1b4c:	00b567b3          	or	a5,a0,a1
    1b50:	00f6b693          	sltiu	a3,a3,15
    1b54:	8b9d                	andi	a5,a5,7
    1b56:	0016c693          	xori	a3,a3,1
    1b5a:	0017b793          	seqz	a5,a5
    1b5e:	8ff5                	and	a5,a5,a3
    1b60:	c3f1                	beqz	a5,1c24 <memmove+0xea>
    1b62:	0007079b          	sext.w	a5,a4
    1b66:	46a5                	li	a3,9
    1b68:	0af6fe63          	bgeu	a3,a5,1c24 <memmove+0xea>
    1b6c:	0036589b          	srliw	a7,a2,0x3
    1b70:	088e                	slli	a7,a7,0x3
    1b72:	2601                	sext.w	a2,a2
    1b74:	87ae                	mv	a5,a1
    1b76:	86aa                	mv	a3,a0
    1b78:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1b7a:	0007b803          	ld	a6,0(a5)
    1b7e:	07a1                	addi	a5,a5,8
    1b80:	06a1                	addi	a3,a3,8
    1b82:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1b86:	ff179ae3          	bne	a5,a7,1b7a <memmove+0x40>
    1b8a:	ff867813          	andi	a6,a2,-8
    1b8e:	02081793          	slli	a5,a6,0x20
    1b92:	9381                	srli	a5,a5,0x20
    1b94:	00f506b3          	add	a3,a0,a5
    1b98:	95be                	add	a1,a1,a5
    1b9a:	4107073b          	subw	a4,a4,a6
    1b9e:	09060263          	beq	a2,a6,1c22 <memmove+0xe8>
            *dst++ = *src++;
    1ba2:	0005c783          	lbu	a5,0(a1)
    1ba6:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1baa:	06e05c63          	blez	a4,1c22 <memmove+0xe8>
            *dst++ = *src++;
    1bae:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1bb2:	4785                	li	a5,1
            *dst++ = *src++;
    1bb4:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1bb8:	06e7d563          	bge	a5,a4,1c22 <memmove+0xe8>
            *dst++ = *src++;
    1bbc:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1bc0:	4789                	li	a5,2
            *dst++ = *src++;
    1bc2:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1bc6:	04e7de63          	bge	a5,a4,1c22 <memmove+0xe8>
            *dst++ = *src++;
    1bca:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1bce:	478d                	li	a5,3
            *dst++ = *src++;
    1bd0:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1bd4:	04e7d763          	bge	a5,a4,1c22 <memmove+0xe8>
            *dst++ = *src++;
    1bd8:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1bdc:	4791                	li	a5,4
            *dst++ = *src++;
    1bde:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1be2:	04e7d063          	bge	a5,a4,1c22 <memmove+0xe8>
            *dst++ = *src++;
    1be6:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1bea:	4795                	li	a5,5
            *dst++ = *src++;
    1bec:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1bf0:	02e7d963          	bge	a5,a4,1c22 <memmove+0xe8>
            *dst++ = *src++;
    1bf4:	0065c783          	lbu	a5,6(a1)
    1bf8:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1bfc:	8082                	ret
    } else {
        dst += n;
    1bfe:	00c507b3          	add	a5,a0,a2
        src += n;
    1c02:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1c04:	00c05f63          	blez	a2,1c22 <memmove+0xe8>
    1c08:	1702                	slli	a4,a4,0x20
    1c0a:	9301                	srli	a4,a4,0x20
    1c0c:	fff74713          	not	a4,a4
    1c10:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1c12:	fff5c683          	lbu	a3,-1(a1)
    1c16:	17fd                	addi	a5,a5,-1
    1c18:	15fd                	addi	a1,a1,-1
    1c1a:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1c1e:	fee79ae3          	bne	a5,a4,1c12 <memmove+0xd8>
    }
    return vdst;
}
    1c22:	8082                	ret
    1c24:	02071693          	slli	a3,a4,0x20
    1c28:	9281                	srli	a3,a3,0x20
    1c2a:	0685                	addi	a3,a3,1
    1c2c:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1c2e:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1c30:	0005c703          	lbu	a4,0(a1)
    1c34:	0585                	addi	a1,a1,1
    1c36:	0785                	addi	a5,a5,1
    1c38:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1c3c:	fed59ae3          	bne	a1,a3,1c30 <memmove+0xf6>
    1c40:	8082                	ret

0000000000001c42 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1c42:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c46:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1c4a:	2501                	sext.w	a0,a0
    1c4c:	8082                	ret

0000000000001c4e <exec>:
    register long a7 __asm__("a7") = n;
    1c4e:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1c52:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c54:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1c58:	2501                	sext.w	a0,a0
    1c5a:	8082                	ret

0000000000001c5c <exit>:
    register long a7 __asm__("a7") = n;
    1c5c:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1c60:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1c64:	8082                	ret

0000000000001c66 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1c66:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c6a:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1c6e:	8082                	ret

0000000000001c70 <write>:
    register long a7 __asm__("a7") = n;
    1c70:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c74:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1c78:	8082                	ret

0000000000001c7a <getpid>:
    register long a7 __asm__("a7") = n;
    1c7a:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c7e:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c82:	2501                	sext.w	a0,a0
    1c84:	8082                	ret

0000000000001c86 <getppid>:
    register long a7 __asm__("a7") = n;
    1c86:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c8a:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c8e:	2501                	sext.w	a0,a0
    1c90:	8082                	ret

0000000000001c92 <open>:
    register long a7 __asm__("a7") = n;
    1c92:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c96:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1c9a:	2501                	sext.w	a0,a0
    1c9c:	8082                	ret

0000000000001c9e <mknod>:
    register long a7 __asm__("a7") = n;
    1c9e:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ca2:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1ca6:	2501                	sext.w	a0,a0
    1ca8:	8082                	ret

0000000000001caa <dup>:
    register long a7 __asm__("a7") = n;
    1caa:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1cac:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1cb0:	2501                	sext.w	a0,a0
    1cb2:	8082                	ret

0000000000001cb4 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cb4:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cb8:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cbc:	2501                	sext.w	a0,a0
    1cbe:	8082                	ret

0000000000001cc0 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cc0:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cc4:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1cc8:	2501                	sext.w	a0,a0
    1cca:	8082                	ret

0000000000001ccc <wait>:

pid_t wait(int *wstatus)
{
    1ccc:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1cce:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1cd2:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cd4:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1cd8:	2501                	sext.w	a0,a0
    1cda:	8082                	ret

0000000000001cdc <mkdir>:
    register long a7 __asm__("a7") = n;
    1cdc:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1ce0:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1ce4:	2501                	sext.w	a0,a0
    1ce6:	8082                	ret

0000000000001ce8 <close>:
    register long a7 __asm__("a7") = n;
    1ce8:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1cec:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1cf0:	2501                	sext.w	a0,a0
    1cf2:	8082                	ret

0000000000001cf4 <fork>:
    register long a7 __asm__("a7") = n;
    1cf4:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1cf8:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1cfc:	2501                	sext.w	a0,a0
    1cfe:	8082                	ret

0000000000001d00 <time_ms>:
    register long a7 __asm__("a7") = n;
    1d00:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d04:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1d08:	8082                	ret

0000000000001d0a <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1d0a:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1d0c:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d10:	00000073          	ecall
    1d14:	87aa                	mv	a5,a0
    1d16:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1d1a:	97ba                	add	a5,a5,a4
    1d1c:	00f57c63          	bgeu	a0,a5,1d34 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1d20:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1d24:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d28:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d2c:	00000073          	ecall
    1d30:	fef568e3          	bltu	a0,a5,1d20 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1d34:	4501                	li	a0,0
    1d36:	8082                	ret

0000000000001d38 <pipe>:
    register long a7 __asm__("a7") = n;
    1d38:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1d3c:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1d40:	2501                	sext.w	a0,a0
    1d42:	8082                	ret

0000000000001d44 <fstat>:
    register long a7 __asm__("a7") = n;
    1d44:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d48:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1d4c:	2501                	sext.w	a0,a0
    1d4e:	8082                	ret

0000000000001d50 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1d50:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1d52:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1d56:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d58:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1d5c:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1d60:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1d64:	0206c163          	bltz	a3,1d86 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1d68:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1d6c:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1d6e:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d70:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d74:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1d78:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1d7c:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1d7e:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1d82:	853e                	mv	a0,a5
    1d84:	8082                	ret
        return -1;
    1d86:	57fd                	li	a5,-1
    1d88:	bfed                	j	1d82 <stat+0x32>

0000000000001d8a <chdir>:
    register long a7 __asm__("a7") = n;
    1d8a:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1d8e:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1d92:	2501                	sext.w	a0,a0
    1d94:	8082                	ret

0000000000001d96 <link>:
    register long a7 __asm__("a7") = n;
    1d96:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d9a:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1d9e:	2501                	sext.w	a0,a0
    1da0:	8082                	ret

0000000000001da2 <unlink>:
    register long a7 __asm__("a7") = n;
    1da2:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1da6:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1daa:	2501                	sext.w	a0,a0
    1dac:	8082                	ret

0000000000001dae <setpriority>:
    register long a7 __asm__("a7") = n;
    1dae:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1db2:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1db6:	8082                	ret

0000000000001db8 <getpriority>:
    register long a7 __asm__("a7") = n;
    1db8:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1dbc:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1dc0:	8082                	ret

0000000000001dc2 <sharedmem>:
    register long a7 __asm__("a7") = n;
    1dc2:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dc6:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1dca:	8082                	ret
