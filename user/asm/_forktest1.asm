
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_forktest1:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a0e1                	j	10c8 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <stdlib.h>
#include <ucore.h>

const int MAX_CHILD = 40;

int main() {
    1002:	715d                	addi	sp,sp,-80
    1004:	e0a2                	sd	s0,64(sp)
    1006:	fc26                	sd	s1,56(sp)
    1008:	f84a                	sd	s2,48(sp)
    100a:	f44e                	sd	s3,40(sp)
    100c:	e486                	sd	ra,72(sp)
    for (int i = 0; i < MAX_CHILD; ++i) {
    100e:	4401                	li	s0,0
        int pid = fork();
        if (pid == 0) {
            printf("I am child %d\n", i);
            exit(0);
        } else {
            printf("forked child pid = %d\n", pid);
    1010:	00001997          	auipc	s3,0x1
    1014:	e1098993          	addi	s3,s3,-496 # 1e20 <sharedmem+0x1c>
            printf("I am child %d\n", i);
    1018:	00001917          	auipc	s2,0x1
    101c:	df890913          	addi	s2,s2,-520 # 1e10 <sharedmem+0xc>
    for (int i = 0; i < MAX_CHILD; ++i) {
    1020:	02800493          	li	s1,40
    1024:	a809                	j	1036 <main+0x34>
            printf("I am child %d\n", i);
    1026:	138000ef          	jal	ra,115e <printf>
            exit(0);
    102a:	4501                	li	a0,0
    for (int i = 0; i < MAX_CHILD; ++i) {
    102c:	2405                	addiw	s0,s0,1
            exit(0);
    102e:	471000ef          	jal	ra,1c9e <exit>
    for (int i = 0; i < MAX_CHILD; ++i) {
    1032:	00940f63          	beq	s0,s1,1050 <main+0x4e>
        int pid = fork();
    1036:	501000ef          	jal	ra,1d36 <fork>
    103a:	87aa                	mv	a5,a0
            printf("I am child %d\n", i);
    103c:	85a2                	mv	a1,s0
    103e:	854a                	mv	a0,s2
        if (pid == 0) {
    1040:	d3fd                	beqz	a5,1026 <main+0x24>
            printf("forked child pid = %d\n", pid);
    1042:	85be                	mv	a1,a5
    1044:	854e                	mv	a0,s3
    for (int i = 0; i < MAX_CHILD; ++i) {
    1046:	2405                	addiw	s0,s0,1
            printf("forked child pid = %d\n", pid);
    1048:	116000ef          	jal	ra,115e <printf>
    for (int i = 0; i < MAX_CHILD; ++i) {
    104c:	fe9415e3          	bne	s0,s1,1036 <main+0x34>
        }
    }

    int exit_code = 0;
    1050:	ce02                	sw	zero,28(sp)
    1052:	02800413          	li	s0,40
    for (int i = 0; i < MAX_CHILD; ++i) {
        pid_t p = wait(&exit_code);
        if (p <= 0) {
            panic("wait stopped early");
        }
        printf("child %d exited with code %d\n", p, exit_code);
    1056:	00001497          	auipc	s1,0x1
    105a:	dfa48493          	addi	s1,s1,-518 # 1e50 <sharedmem+0x4c>
            panic("wait stopped early");
    105e:	00001917          	auipc	s2,0x1
    1062:	dda90913          	addi	s2,s2,-550 # 1e38 <sharedmem+0x34>
        pid_t p = wait(&exit_code);
    1066:	0868                	addi	a0,sp,28
    1068:	4a7000ef          	jal	ra,1d0e <wait>
    106c:	85aa                	mv	a1,a0
        printf("child %d exited with code %d\n", p, exit_code);
    106e:	8526                	mv	a0,s1
        if (p <= 0) {
    1070:	04b05063          	blez	a1,10b0 <main+0xae>
        printf("child %d exited with code %d\n", p, exit_code);
    1074:	4672                	lw	a2,28(sp)
    1076:	347d                	addiw	s0,s0,-1
    1078:	0e6000ef          	jal	ra,115e <printf>
    for (int i = 0; i < MAX_CHILD; ++i) {
    107c:	f46d                	bnez	s0,1066 <main+0x64>
    }
    if (wait(&exit_code) > 0) {
    107e:	0868                	addi	a0,sp,28
    1080:	48f000ef          	jal	ra,1d0e <wait>
    1084:	00a05863          	blez	a0,1094 <main+0x92>
        panic("wait got too many");
    1088:	00001517          	auipc	a0,0x1
    108c:	de850513          	addi	a0,a0,-536 # 1e70 <sharedmem+0x6c>
    1090:	44e000ef          	jal	ra,14de <panic>
    }
    printf("forktest pass.\n");
    1094:	00001517          	auipc	a0,0x1
    1098:	df450513          	addi	a0,a0,-524 # 1e88 <sharedmem+0x84>
    109c:	0c2000ef          	jal	ra,115e <printf>
    return 0;
    10a0:	60a6                	ld	ra,72(sp)
    10a2:	6406                	ld	s0,64(sp)
    10a4:	74e2                	ld	s1,56(sp)
    10a6:	7942                	ld	s2,48(sp)
    10a8:	79a2                	ld	s3,40(sp)
    10aa:	4501                	li	a0,0
    10ac:	6161                	addi	sp,sp,80
    10ae:	8082                	ret
            panic("wait stopped early");
    10b0:	854a                	mv	a0,s2
    10b2:	e42e                	sd	a1,8(sp)
    10b4:	42a000ef          	jal	ra,14de <panic>
        printf("child %d exited with code %d\n", p, exit_code);
    10b8:	4672                	lw	a2,28(sp)
    10ba:	65a2                	ld	a1,8(sp)
    10bc:	347d                	addiw	s0,s0,-1
    10be:	8526                	mv	a0,s1
    10c0:	09e000ef          	jal	ra,115e <printf>
    for (int i = 0; i < MAX_CHILD; ++i) {
    10c4:	f04d                	bnez	s0,1066 <main+0x64>
    10c6:	bf65                	j	107e <main+0x7c>

00000000000010c8 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    10c8:	1141                	addi	sp,sp,-16
    10ca:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    10cc:	f37ff0ef          	jal	ra,1002 <main>
}
    10d0:	60a2                	ld	ra,8(sp)
    10d2:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    10d4:	3cb0006f          	j	1c9e <exit>

00000000000010d8 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    10d8:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    10da:	00f10593          	addi	a1,sp,15
    10de:	4605                	li	a2,1
    10e0:	4501                	li	a0,0
int getchar() {
    10e2:	ec06                	sd	ra,24(sp)
    char byte = 0;
    10e4:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    10e8:	3c1000ef          	jal	ra,1ca8 <read>
    return byte;
}
    10ec:	60e2                	ld	ra,24(sp)
    10ee:	00f14503          	lbu	a0,15(sp)
    10f2:	6105                	addi	sp,sp,32
    10f4:	8082                	ret

00000000000010f6 <putchar>:

int putchar(int c)
{
    10f6:	1141                	addi	sp,sp,-16
    10f8:	e406                	sd	ra,8(sp)
    10fa:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    10fc:	00001597          	auipc	a1,0x1
    1100:	dcc58593          	addi	a1,a1,-564 # 1ec8 <put.1156>
    return write(stdout, put, 1);
    1104:	4605                	li	a2,1
    1106:	4505                	li	a0,1
    put[0] = c;
    1108:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    110c:	3a7000ef          	jal	ra,1cb2 <write>
}
    1110:	60a2                	ld	ra,8(sp)
    1112:	2501                	sext.w	a0,a0
    1114:	0141                	addi	sp,sp,16
    1116:	8082                	ret

0000000000001118 <puts>:

int puts(const char* s)
{
    1118:	1141                	addi	sp,sp,-16
    111a:	e022                	sd	s0,0(sp)
    111c:	e406                	sd	ra,8(sp)
    111e:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    1120:	6b6000ef          	jal	ra,17d6 <strlen>
    1124:	862a                	mv	a2,a0
    1126:	85a2                	mv	a1,s0
    1128:	4505                	li	a0,1
    112a:	389000ef          	jal	ra,1cb2 <write>
    112e:	00055763          	bgez	a0,113c <puts+0x24>
    return r;
}
    1132:	60a2                	ld	ra,8(sp)
    1134:	6402                	ld	s0,0(sp)
    1136:	557d                	li	a0,-1
    1138:	0141                	addi	sp,sp,16
    113a:	8082                	ret
    put[0] = c;
    113c:	00001597          	auipc	a1,0x1
    1140:	d8c58593          	addi	a1,a1,-628 # 1ec8 <put.1156>
    1144:	47a9                	li	a5,10
    return write(stdout, put, 1);
    1146:	4605                	li	a2,1
    1148:	4505                	li	a0,1
    put[0] = c;
    114a:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    114e:	365000ef          	jal	ra,1cb2 <write>
}
    1152:	60a2                	ld	ra,8(sp)
    1154:	6402                	ld	s0,0(sp)
    1156:	41f5551b          	sraiw	a0,a0,0x1f
    115a:	0141                	addi	sp,sp,16
    115c:	8082                	ret

000000000000115e <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    115e:	7115                	addi	sp,sp,-224
    1160:	ed06                	sd	ra,152(sp)
    1162:	e922                	sd	s0,144(sp)
    1164:	e526                	sd	s1,136(sp)
    1166:	e14a                	sd	s2,128(sp)
    1168:	fcce                	sd	s3,120(sp)
    116a:	f8d2                	sd	s4,112(sp)
    116c:	f4d6                	sd	s5,104(sp)
    116e:	f0da                	sd	s6,96(sp)
    1170:	ecde                	sd	s7,88(sp)
    1172:	e8e2                	sd	s8,80(sp)
    1174:	e4e6                	sd	s9,72(sp)
    1176:	e0ea                	sd	s10,64(sp)
    1178:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    117a:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    117e:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    1180:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    1182:	f52e                	sd	a1,168(sp)
    1184:	f932                	sd	a2,176(sp)
    1186:	fd36                	sd	a3,184(sp)
    1188:	e1ba                	sd	a4,192(sp)
    118a:	e9c2                	sd	a6,208(sp)
    118c:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    118e:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1190:	0c030b63          	beqz	t1,1266 <printf+0x108>
    1194:	8aaa                	mv	s5,a0
    1196:	0003071b          	sext.w	a4,t1
    119a:	4481                	li	s1,0
        if (c != '%') {
    119c:	02500b93          	li	s7,37
    put[0] = c;
    11a0:	00001417          	auipc	s0,0x1
    11a4:	d2840413          	addi	s0,s0,-728 # 1ec8 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    11a8:	4c51                	li	s8,20
    put[0] = c;
    11aa:	02500c93          	li	s9,37
    11ae:	00001a17          	auipc	s4,0x1
    11b2:	d2aa0a13          	addi	s4,s4,-726 # 1ed8 <seed+0x8>
    11b6:	00001997          	auipc	s3,0x1
    11ba:	d7a98993          	addi	s3,s3,-646 # 1f30 <digits>
    11be:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    11c2:	0014879b          	addiw	a5,s1,1
    11c6:	00fa8933          	add	s2,s5,a5
    11ca:	13771163          	bne	a4,s7,12ec <printf+0x18e>
        c = fmt[++i] & 0xff;
    11ce:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    11d2:	080d0a63          	beqz	s10,1266 <printf+0x108>
        switch (c) {
    11d6:	2489                	addiw	s1,s1,2
    11d8:	009a8933          	add	s2,s5,s1
    11dc:	257d0e63          	beq	s10,s7,1438 <printf+0x2da>
    11e0:	f9cd079b          	addiw	a5,s10,-100
    11e4:	0ff7f793          	andi	a5,a5,255
    11e8:	0cfc6263          	bltu	s8,a5,12ac <printf+0x14e>
    11ec:	078a                	slli	a5,a5,0x2
    11ee:	97d2                	add	a5,a5,s4
    11f0:	439c                	lw	a5,0(a5)
    11f2:	97d2                	add	a5,a5,s4
    11f4:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    11f6:	67a2                	ld	a5,8(sp)
    11f8:	4398                	lw	a4,0(a5)
    11fa:	07a1                	addi	a5,a5,8
    11fc:	e43e                	sd	a5,8(sp)
    11fe:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    1202:	26074663          	bltz	a4,146e <printf+0x310>
        buf[i++] = digits[x % base];
    1206:	8bbd                	andi	a5,a5,15
    1208:	97ce                	add	a5,a5,s3
    120a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    120e:	40475d1b          	sraiw	s10,a4,0x4
    1212:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    1216:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    121a:	020d0163          	beqz	s10,123c <printf+0xde>
        buf[i++] = digits[x % base];
    121e:	9d4e                	add	s10,s10,s3
    1220:	000d4783          	lbu	a5,0(s10)
    1224:	4d05                	li	s10,1
    1226:	00f108a3          	sb	a5,17(sp)
    if (sign)
    122a:	00075963          	bgez	a4,123c <printf+0xde>
        buf[i++] = digits[x % base];
    122e:	4d09                	li	s10,2
        buf[i++] = '-';
    1230:	181c                	addi	a5,sp,48
    1232:	02d00713          	li	a4,45
    1236:	97ea                	add	a5,a5,s10
    1238:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    123c:	9d5a                	add	s10,s10,s6
    123e:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1242:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1246:	4605                	li	a2,1
    1248:	1d7d                	addi	s10,s10,-1
    124a:	85a2                	mv	a1,s0
    124c:	4505                	li	a0,1
    put[0] = c;
    124e:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1252:	261000ef          	jal	ra,1cb2 <write>
    while (--i >= 0)
    1256:	ffbd16e3          	bne	s10,s11,1242 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    125a:	00094303          	lbu	t1,0(s2)
    125e:	0003071b          	sext.w	a4,t1
    1262:	f60310e3          	bnez	t1,11c2 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    1266:	60ea                	ld	ra,152(sp)
    1268:	644a                	ld	s0,144(sp)
    126a:	64aa                	ld	s1,136(sp)
    126c:	690a                	ld	s2,128(sp)
    126e:	79e6                	ld	s3,120(sp)
    1270:	7a46                	ld	s4,112(sp)
    1272:	7aa6                	ld	s5,104(sp)
    1274:	7b06                	ld	s6,96(sp)
    1276:	6be6                	ld	s7,88(sp)
    1278:	6c46                	ld	s8,80(sp)
    127a:	6ca6                	ld	s9,72(sp)
    127c:	6d06                	ld	s10,64(sp)
    127e:	7de2                	ld	s11,56(sp)
    1280:	612d                	addi	sp,sp,224
    1282:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    1284:	67a2                	ld	a5,8(sp)
    1286:	0007bd03          	ld	s10,0(a5)
    128a:	07a1                	addi	a5,a5,8
    128c:	e43e                	sd	a5,8(sp)
    128e:	000d1b63          	bnez	s10,12a4 <printf+0x146>
    1292:	aafd                	j	1490 <printf+0x332>
    return write(stdout, put, 1);
    1294:	4605                	li	a2,1
    1296:	85a2                	mv	a1,s0
    1298:	4505                	li	a0,1
                for (; *s; s++)
    129a:	0d05                	addi	s10,s10,1
    put[0] = c;
    129c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    12a0:	213000ef          	jal	ra,1cb2 <write>
                for (; *s; s++)
    12a4:	000d4783          	lbu	a5,0(s10)
    12a8:	f7f5                	bnez	a5,1294 <printf+0x136>
    12aa:	a02d                	j	12d4 <printf+0x176>
    return write(stdout, put, 1);
    12ac:	4605                	li	a2,1
    12ae:	00001597          	auipc	a1,0x1
    12b2:	c1a58593          	addi	a1,a1,-998 # 1ec8 <put.1156>
    12b6:	4505                	li	a0,1
    put[0] = c;
    12b8:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    12bc:	1f7000ef          	jal	ra,1cb2 <write>
    12c0:	4605                	li	a2,1
    12c2:	00001597          	auipc	a1,0x1
    12c6:	c0658593          	addi	a1,a1,-1018 # 1ec8 <put.1156>
    12ca:	4505                	li	a0,1
    put[0] = c;
    12cc:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    12d0:	1e3000ef          	jal	ra,1cb2 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    12d4:	00094303          	lbu	t1,0(s2)
    12d8:	0003071b          	sext.w	a4,t1
    12dc:	f80305e3          	beqz	t1,1266 <printf+0x108>
        if (c != '%') {
    12e0:	0014879b          	addiw	a5,s1,1
    12e4:	00fa8933          	add	s2,s5,a5
    12e8:	ef7703e3          	beq	a4,s7,11ce <printf+0x70>
    return write(stdout, put, 1);
    12ec:	4605                	li	a2,1
    12ee:	00001597          	auipc	a1,0x1
    12f2:	bda58593          	addi	a1,a1,-1062 # 1ec8 <put.1156>
    12f6:	4505                	li	a0,1
    put[0] = c;
    12f8:	00640023          	sb	t1,0(s0)
            continue;
    12fc:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    12fe:	1b5000ef          	jal	ra,1cb2 <write>
            continue;
    1302:	bfc9                	j	12d4 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    1304:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    1306:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    1308:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    130a:	0007b883          	ld	a7,0(a5)
    130e:	07a1                	addi	a5,a5,8
    1310:	e43e                	sd	a5,8(sp)
        x = -xx;
    1312:	43f8d713          	srai	a4,a7,0x3f
    1316:	011747b3          	xor	a5,a4,a7
    131a:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    131c:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    131e:	02c7f733          	remu	a4,a5,a2
    1322:	8d36                	mv	s10,a3
    1324:	0685                	addi	a3,a3,1
    1326:	00db0533          	add	a0,s6,a3
    132a:	85be                	mv	a1,a5
    132c:	974e                	add	a4,a4,s3
    132e:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    1332:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    1336:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    133a:	feb862e3          	bltu	a6,a1,131e <printf+0x1c0>
    if (sign)
    133e:	1208c063          	bltz	a7,145e <printf+0x300>
    while (--i >= 0)
    1342:	9d5a                	add	s10,s10,s6
    put[0] = c;
    1344:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1348:	4605                	li	a2,1
    134a:	85a2                	mv	a1,s0
    134c:	4505                	li	a0,1
    put[0] = c;
    134e:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1352:	161000ef          	jal	ra,1cb2 <write>
    while (--i >= 0)
    1356:	87ea                	mv	a5,s10
    1358:	1d7d                	addi	s10,s10,-1
    135a:	fefb15e3          	bne	s6,a5,1344 <printf+0x1e6>
    135e:	bf9d                	j	12d4 <printf+0x176>
                printptr(va_arg(ap, uint64));
    1360:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    1362:	4605                	li	a2,1
    1364:	00001597          	auipc	a1,0x1
    1368:	b6458593          	addi	a1,a1,-1180 # 1ec8 <put.1156>
                printptr(va_arg(ap, uint64));
    136c:	0007bd83          	ld	s11,0(a5)
    1370:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    1374:	4505                	li	a0,1
    put[0] = c;
    1376:	03000793          	li	a5,48
    137a:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    137e:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    1380:	133000ef          	jal	ra,1cb2 <write>
    put[0] = c;
    1384:	07800793          	li	a5,120
    return write(stdout, put, 1);
    1388:	4605                	li	a2,1
    138a:	00001597          	auipc	a1,0x1
    138e:	b3e58593          	addi	a1,a1,-1218 # 1ec8 <put.1156>
    1392:	4505                	li	a0,1
    put[0] = c;
    1394:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1398:	4d41                	li	s10,16
    139a:	119000ef          	jal	ra,1cb2 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    139e:	03cdd793          	srli	a5,s11,0x3c
    13a2:	97ce                	add	a5,a5,s3
    put[0] = c;
    13a4:	0007c783          	lbu	a5,0(a5)
    13a8:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    13aa:	4605                	li	a2,1
    13ac:	85a2                	mv	a1,s0
    13ae:	4505                	li	a0,1
    put[0] = c;
    13b0:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    13b4:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    13b6:	0fd000ef          	jal	ra,1cb2 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    13ba:	fe0d12e3          	bnez	s10,139e <printf+0x240>
    13be:	bf19                	j	12d4 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    13c0:	67a2                	ld	a5,8(sp)
    13c2:	4394                	lw	a3,0(a5)
    13c4:	07a1                	addi	a5,a5,8
    13c6:	e43e                	sd	a5,8(sp)
    13c8:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    13cc:	0006d663          	bgez	a3,13d8 <printf+0x27a>
        x = -xx;
    13d0:	40f007bb          	negw	a5,a5
    13d4:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    13d8:	4729                	li	a4,10
    13da:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    13de:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    13e2:	964e                	add	a2,a2,s3
    13e4:	00064603          	lbu	a2,0(a2)
    13e8:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    13ec:	0a0d0963          	beqz	s10,149e <printf+0x340>
        buf[i++] = digits[x % base];
    13f0:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    13f4:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    13f8:	00c98733          	add	a4,s3,a2
    13fc:	00074703          	lbu	a4,0(a4)
    1400:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    1404:	c3cd                	beqz	a5,14a6 <printf+0x348>
        buf[i++] = digits[x % base];
    1406:	97ce                	add	a5,a5,s3
    1408:	0007c703          	lbu	a4,0(a5)
    140c:	4d09                	li	s10,2
    140e:	478d                	li	a5,3
    1410:	00e10923          	sb	a4,18(sp)
    if (sign)
    1414:	0206cd63          	bltz	a3,144e <printf+0x2f0>
    while (--i >= 0)
    1418:	9d5a                	add	s10,s10,s6
    141a:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    141e:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1422:	4605                	li	a2,1
    1424:	1d7d                	addi	s10,s10,-1
    1426:	85a2                	mv	a1,s0
    1428:	4505                	li	a0,1
    put[0] = c;
    142a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    142e:	085000ef          	jal	ra,1cb2 <write>
    while (--i >= 0)
    1432:	ffbd16e3          	bne	s10,s11,141e <printf+0x2c0>
    1436:	bd79                	j	12d4 <printf+0x176>
    return write(stdout, put, 1);
    1438:	4605                	li	a2,1
    143a:	00001597          	auipc	a1,0x1
    143e:	a8e58593          	addi	a1,a1,-1394 # 1ec8 <put.1156>
    1442:	4505                	li	a0,1
    put[0] = c;
    1444:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    1448:	06b000ef          	jal	ra,1cb2 <write>
    144c:	b561                	j	12d4 <printf+0x176>
        buf[i++] = '-';
    144e:	1818                	addi	a4,sp,48
    1450:	973e                	add	a4,a4,a5
    1452:	02d00693          	li	a3,45
    1456:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    145a:	8d3e                	mv	s10,a5
    145c:	bf75                	j	1418 <printf+0x2ba>
        buf[i++] = '-';
    145e:	181c                	addi	a5,sp,48
    1460:	97b6                	add	a5,a5,a3
    1462:	02d00713          	li	a4,45
    1466:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    146a:	8d36                	mv	s10,a3
    146c:	bdd9                	j	1342 <printf+0x1e4>
        x = -xx;
    146e:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    1472:	00f7f693          	andi	a3,a5,15
    1476:	96ce                	add	a3,a3,s3
    1478:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    147c:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    1480:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    1484:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1488:	d80d1be3          	bnez	s10,121e <printf+0xc0>
        buf[i++] = digits[x % base];
    148c:	4d05                	li	s10,1
    148e:	b34d                	j	1230 <printf+0xd2>
                s = "(null)";
    1490:	00001d17          	auipc	s10,0x1
    1494:	a08d0d13          	addi	s10,s10,-1528 # 1e98 <sharedmem+0x94>
                for (; *s; s++)
    1498:	02800793          	li	a5,40
    149c:	bbe5                	j	1294 <printf+0x136>
        buf[i++] = digits[x % base];
    149e:	4785                	li	a5,1
    if (sign)
    14a0:	f606dce3          	bgez	a3,1418 <printf+0x2ba>
    14a4:	b76d                	j	144e <printf+0x2f0>
        buf[i++] = digits[x % base];
    14a6:	4789                	li	a5,2
    14a8:	4d05                	li	s10,1
    if (sign)
    14aa:	f606d7e3          	bgez	a3,1418 <printf+0x2ba>
    14ae:	b745                	j	144e <printf+0x2f0>

00000000000014b0 <srand>:
#include <ucore.h>

static uint64 seed;

void srand(unsigned s) {
    seed = s - 1;
    14b0:	357d                	addiw	a0,a0,-1
    14b2:	1502                	slli	a0,a0,0x20
    14b4:	9101                	srli	a0,a0,0x20
    14b6:	00001797          	auipc	a5,0x1
    14ba:	a0a7bd23          	sd	a0,-1510(a5) # 1ed0 <seed>
}
    14be:	8082                	ret

00000000000014c0 <rand>:

int rand(void) {
    seed = 6364136223846793005ULL * seed + 1;
    14c0:	00001797          	auipc	a5,0x1
    14c4:	a1078793          	addi	a5,a5,-1520 # 1ed0 <seed>
    14c8:	6388                	ld	a0,0(a5)
    14ca:	00001717          	auipc	a4,0x1
    14ce:	9de73703          	ld	a4,-1570(a4) # 1ea8 <MAX_CHILD+0x8>
    14d2:	02e50533          	mul	a0,a0,a4
    14d6:	0505                	addi	a0,a0,1
    14d8:	e388                	sd	a0,0(a5)
    return seed >> 33;
}
    14da:	9105                	srli	a0,a0,0x21
    14dc:	8082                	ret

00000000000014de <panic>:

void panic(char* m) {
    14de:	1141                	addi	sp,sp,-16
    14e0:	e406                	sd	ra,8(sp)
    puts(m);
    14e2:	c37ff0ef          	jal	ra,1118 <puts>
    exit(-100);
}
    14e6:	60a2                	ld	ra,8(sp)
    exit(-100);
    14e8:	f9c00513          	li	a0,-100
}
    14ec:	0141                	addi	sp,sp,16
    exit(-100);
    14ee:	af45                	j	1c9e <exit>

00000000000014f0 <assert>:

void assert(int f, int code) {
    if(!f) {
    14f0:	c111                	beqz	a0,14f4 <assert+0x4>
        exit(code);
    }
    14f2:	8082                	ret
        exit(code);
    14f4:	852e                	mv	a0,a1
    14f6:	a765                	j	1c9e <exit>

00000000000014f8 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    14f8:	02000793          	li	a5,32
    14fc:	00f50663          	beq	a0,a5,1508 <isspace+0x10>
    1500:	355d                	addiw	a0,a0,-9
    1502:	00553513          	sltiu	a0,a0,5
    1506:	8082                	ret
    1508:	4505                	li	a0,1
}
    150a:	8082                	ret

000000000000150c <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    150c:	fd05051b          	addiw	a0,a0,-48
}
    1510:	00a53513          	sltiu	a0,a0,10
    1514:	8082                	ret

0000000000001516 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1516:	02000613          	li	a2,32
    151a:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    151c:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1520:	ff77069b          	addiw	a3,a4,-9
    1524:	04c70d63          	beq	a4,a2,157e <atoi+0x68>
    1528:	0007079b          	sext.w	a5,a4
    152c:	04d5f963          	bgeu	a1,a3,157e <atoi+0x68>
        s++;
    switch (*s) {
    1530:	02b00693          	li	a3,43
    1534:	04d70a63          	beq	a4,a3,1588 <atoi+0x72>
    1538:	02d00693          	li	a3,45
    153c:	06d70463          	beq	a4,a3,15a4 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1540:	fd07859b          	addiw	a1,a5,-48
    1544:	4625                	li	a2,9
    1546:	873e                	mv	a4,a5
    1548:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    154a:	4e01                	li	t3,0
    while (isdigit(*s))
    154c:	04b66a63          	bltu	a2,a1,15a0 <atoi+0x8a>
    int n = 0, neg = 0;
    1550:	4501                	li	a0,0
    while (isdigit(*s))
    1552:	4825                	li	a6,9
    1554:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1558:	0025179b          	slliw	a5,a0,0x2
    155c:	9d3d                	addw	a0,a0,a5
    155e:	fd07031b          	addiw	t1,a4,-48
    1562:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1566:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    156a:	0685                	addi	a3,a3,1
    156c:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1570:	0006071b          	sext.w	a4,a2
    1574:	feb870e3          	bgeu	a6,a1,1554 <atoi+0x3e>
    return neg ? n : -n;
    1578:	000e0563          	beqz	t3,1582 <atoi+0x6c>
}
    157c:	8082                	ret
        s++;
    157e:	0505                	addi	a0,a0,1
    1580:	bf71                	j	151c <atoi+0x6>
    1582:	4113053b          	subw	a0,t1,a7
    1586:	8082                	ret
    while (isdigit(*s))
    1588:	00154783          	lbu	a5,1(a0)
    158c:	4625                	li	a2,9
        s++;
    158e:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1592:	fd07859b          	addiw	a1,a5,-48
    1596:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    159a:	4e01                	li	t3,0
    while (isdigit(*s))
    159c:	fab67ae3          	bgeu	a2,a1,1550 <atoi+0x3a>
    15a0:	4501                	li	a0,0
}
    15a2:	8082                	ret
    while (isdigit(*s))
    15a4:	00154783          	lbu	a5,1(a0)
    15a8:	4625                	li	a2,9
        s++;
    15aa:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    15ae:	fd07859b          	addiw	a1,a5,-48
    15b2:	0007871b          	sext.w	a4,a5
    15b6:	feb665e3          	bltu	a2,a1,15a0 <atoi+0x8a>
        neg = 1;
    15ba:	4e05                	li	t3,1
    15bc:	bf51                	j	1550 <atoi+0x3a>

00000000000015be <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    15be:	16060d63          	beqz	a2,1738 <memset+0x17a>
    15c2:	40a007b3          	neg	a5,a0
    15c6:	8b9d                	andi	a5,a5,7
    15c8:	00778713          	addi	a4,a5,7
    15cc:	482d                	li	a6,11
    15ce:	0ff5f593          	andi	a1,a1,255
    15d2:	fff60693          	addi	a3,a2,-1
    15d6:	17076263          	bltu	a4,a6,173a <memset+0x17c>
    15da:	16e6ea63          	bltu	a3,a4,174e <memset+0x190>
    15de:	16078563          	beqz	a5,1748 <memset+0x18a>
    15e2:	00b50023          	sb	a1,0(a0)
    15e6:	4705                	li	a4,1
    15e8:	00150e93          	addi	t4,a0,1
    15ec:	14e78c63          	beq	a5,a4,1744 <memset+0x186>
    15f0:	00b500a3          	sb	a1,1(a0)
    15f4:	4709                	li	a4,2
    15f6:	00250e93          	addi	t4,a0,2
    15fa:	14e78d63          	beq	a5,a4,1754 <memset+0x196>
    15fe:	00b50123          	sb	a1,2(a0)
    1602:	470d                	li	a4,3
    1604:	00350e93          	addi	t4,a0,3
    1608:	12e78b63          	beq	a5,a4,173e <memset+0x180>
    160c:	00b501a3          	sb	a1,3(a0)
    1610:	4711                	li	a4,4
    1612:	00450e93          	addi	t4,a0,4
    1616:	14e78163          	beq	a5,a4,1758 <memset+0x19a>
    161a:	00b50223          	sb	a1,4(a0)
    161e:	4715                	li	a4,5
    1620:	00550e93          	addi	t4,a0,5
    1624:	12e78c63          	beq	a5,a4,175c <memset+0x19e>
    1628:	00b502a3          	sb	a1,5(a0)
    162c:	471d                	li	a4,7
    162e:	00650e93          	addi	t4,a0,6
    1632:	12e79763          	bne	a5,a4,1760 <memset+0x1a2>
    1636:	00750e93          	addi	t4,a0,7
    163a:	00b50323          	sb	a1,6(a0)
    163e:	4f1d                	li	t5,7
    1640:	00859713          	slli	a4,a1,0x8
    1644:	8f4d                	or	a4,a4,a1
    1646:	01059e13          	slli	t3,a1,0x10
    164a:	01c76e33          	or	t3,a4,t3
    164e:	01859313          	slli	t1,a1,0x18
    1652:	006e6333          	or	t1,t3,t1
    1656:	02059893          	slli	a7,a1,0x20
    165a:	011368b3          	or	a7,t1,a7
    165e:	02859813          	slli	a6,a1,0x28
    1662:	40f60333          	sub	t1,a2,a5
    1666:	0108e833          	or	a6,a7,a6
    166a:	03059693          	slli	a3,a1,0x30
    166e:	00d866b3          	or	a3,a6,a3
    1672:	03859713          	slli	a4,a1,0x38
    1676:	97aa                	add	a5,a5,a0
    1678:	ff837813          	andi	a6,t1,-8
    167c:	8f55                	or	a4,a4,a3
    167e:	00f806b3          	add	a3,a6,a5
    1682:	e398                	sd	a4,0(a5)
    1684:	07a1                	addi	a5,a5,8
    1686:	fed79ee3          	bne	a5,a3,1682 <memset+0xc4>
    168a:	ff837693          	andi	a3,t1,-8
    168e:	00de87b3          	add	a5,t4,a3
    1692:	01e6873b          	addw	a4,a3,t5
    1696:	0ad30663          	beq	t1,a3,1742 <memset+0x184>
    169a:	00b78023          	sb	a1,0(a5)
    169e:	0017069b          	addiw	a3,a4,1
    16a2:	08c6fb63          	bgeu	a3,a2,1738 <memset+0x17a>
    16a6:	00b780a3          	sb	a1,1(a5)
    16aa:	0027069b          	addiw	a3,a4,2
    16ae:	08c6f563          	bgeu	a3,a2,1738 <memset+0x17a>
    16b2:	00b78123          	sb	a1,2(a5)
    16b6:	0037069b          	addiw	a3,a4,3
    16ba:	06c6ff63          	bgeu	a3,a2,1738 <memset+0x17a>
    16be:	00b781a3          	sb	a1,3(a5)
    16c2:	0047069b          	addiw	a3,a4,4
    16c6:	06c6f963          	bgeu	a3,a2,1738 <memset+0x17a>
    16ca:	00b78223          	sb	a1,4(a5)
    16ce:	0057069b          	addiw	a3,a4,5
    16d2:	06c6f363          	bgeu	a3,a2,1738 <memset+0x17a>
    16d6:	00b782a3          	sb	a1,5(a5)
    16da:	0067069b          	addiw	a3,a4,6
    16de:	04c6fd63          	bgeu	a3,a2,1738 <memset+0x17a>
    16e2:	00b78323          	sb	a1,6(a5)
    16e6:	0077069b          	addiw	a3,a4,7
    16ea:	04c6f763          	bgeu	a3,a2,1738 <memset+0x17a>
    16ee:	00b783a3          	sb	a1,7(a5)
    16f2:	0087069b          	addiw	a3,a4,8
    16f6:	04c6f163          	bgeu	a3,a2,1738 <memset+0x17a>
    16fa:	00b78423          	sb	a1,8(a5)
    16fe:	0097069b          	addiw	a3,a4,9
    1702:	02c6fb63          	bgeu	a3,a2,1738 <memset+0x17a>
    1706:	00b784a3          	sb	a1,9(a5)
    170a:	00a7069b          	addiw	a3,a4,10
    170e:	02c6f563          	bgeu	a3,a2,1738 <memset+0x17a>
    1712:	00b78523          	sb	a1,10(a5)
    1716:	00b7069b          	addiw	a3,a4,11
    171a:	00c6ff63          	bgeu	a3,a2,1738 <memset+0x17a>
    171e:	00b785a3          	sb	a1,11(a5)
    1722:	00c7069b          	addiw	a3,a4,12
    1726:	00c6f963          	bgeu	a3,a2,1738 <memset+0x17a>
    172a:	00b78623          	sb	a1,12(a5)
    172e:	2735                	addiw	a4,a4,13
    1730:	00c77463          	bgeu	a4,a2,1738 <memset+0x17a>
    1734:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    1738:	8082                	ret
    173a:	472d                	li	a4,11
    173c:	bd79                	j	15da <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    173e:	4f0d                	li	t5,3
    1740:	b701                	j	1640 <memset+0x82>
    1742:	8082                	ret
    1744:	4f05                	li	t5,1
    1746:	bded                	j	1640 <memset+0x82>
    1748:	8eaa                	mv	t4,a0
    174a:	4f01                	li	t5,0
    174c:	bdd5                	j	1640 <memset+0x82>
    174e:	87aa                	mv	a5,a0
    1750:	4701                	li	a4,0
    1752:	b7a1                	j	169a <memset+0xdc>
    1754:	4f09                	li	t5,2
    1756:	b5ed                	j	1640 <memset+0x82>
    1758:	4f11                	li	t5,4
    175a:	b5dd                	j	1640 <memset+0x82>
    175c:	4f15                	li	t5,5
    175e:	b5cd                	j	1640 <memset+0x82>
    1760:	4f19                	li	t5,6
    1762:	bdf9                	j	1640 <memset+0x82>

0000000000001764 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    1764:	00054783          	lbu	a5,0(a0)
    1768:	0005c703          	lbu	a4,0(a1)
    176c:	00e79863          	bne	a5,a4,177c <strcmp+0x18>
    1770:	0505                	addi	a0,a0,1
    1772:	0585                	addi	a1,a1,1
    1774:	fbe5                	bnez	a5,1764 <strcmp>
    1776:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    1778:	9d19                	subw	a0,a0,a4
    177a:	8082                	ret
    177c:	0007851b          	sext.w	a0,a5
    1780:	bfe5                	j	1778 <strcmp+0x14>

0000000000001782 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1782:	87aa                	mv	a5,a0
    1784:	0005c703          	lbu	a4,0(a1)
    1788:	0785                	addi	a5,a5,1
    178a:	0585                	addi	a1,a1,1
    178c:	fee78fa3          	sb	a4,-1(a5)
    1790:	fb75                	bnez	a4,1784 <strcpy+0x2>
        ;
    return os;
}
    1792:	8082                	ret

0000000000001794 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    1794:	ce05                	beqz	a2,17cc <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1796:	00054703          	lbu	a4,0(a0)
    179a:	0005c783          	lbu	a5,0(a1)
    179e:	cb0d                	beqz	a4,17d0 <strncmp+0x3c>
    if (!n--)
    17a0:	167d                	addi	a2,a2,-1
    17a2:	00c506b3          	add	a3,a0,a2
    17a6:	a819                	j	17bc <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    17a8:	00a68e63          	beq	a3,a0,17c4 <strncmp+0x30>
    17ac:	0505                	addi	a0,a0,1
    17ae:	00e79b63          	bne	a5,a4,17c4 <strncmp+0x30>
    17b2:	00054703          	lbu	a4,0(a0)
    17b6:	0005c783          	lbu	a5,0(a1)
    17ba:	cb19                	beqz	a4,17d0 <strncmp+0x3c>
    17bc:	0005c783          	lbu	a5,0(a1)
    17c0:	0585                	addi	a1,a1,1
    17c2:	f3fd                	bnez	a5,17a8 <strncmp+0x14>
        ;
    return *l - *r;
    17c4:	0007051b          	sext.w	a0,a4
    17c8:	9d1d                	subw	a0,a0,a5
    17ca:	8082                	ret
        return 0;
    17cc:	4501                	li	a0,0
}
    17ce:	8082                	ret
    17d0:	4501                	li	a0,0
    return *l - *r;
    17d2:	9d1d                	subw	a0,a0,a5
    17d4:	8082                	ret

00000000000017d6 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    17d6:	00757793          	andi	a5,a0,7
    17da:	cf89                	beqz	a5,17f4 <strlen+0x1e>
    17dc:	87aa                	mv	a5,a0
    17de:	a029                	j	17e8 <strlen+0x12>
    17e0:	0785                	addi	a5,a5,1
    17e2:	0077f713          	andi	a4,a5,7
    17e6:	cb01                	beqz	a4,17f6 <strlen+0x20>
        if (!*s)
    17e8:	0007c703          	lbu	a4,0(a5)
    17ec:	fb75                	bnez	a4,17e0 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    17ee:	40a78533          	sub	a0,a5,a0
}
    17f2:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    17f4:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    17f6:	6394                	ld	a3,0(a5)
    17f8:	00000597          	auipc	a1,0x0
    17fc:	6b85b583          	ld	a1,1720(a1) # 1eb0 <MAX_CHILD+0x10>
    1800:	00000617          	auipc	a2,0x0
    1804:	6b863603          	ld	a2,1720(a2) # 1eb8 <MAX_CHILD+0x18>
    1808:	a019                	j	180e <strlen+0x38>
    180a:	6794                	ld	a3,8(a5)
    180c:	07a1                	addi	a5,a5,8
    180e:	00b68733          	add	a4,a3,a1
    1812:	fff6c693          	not	a3,a3
    1816:	8f75                	and	a4,a4,a3
    1818:	8f71                	and	a4,a4,a2
    181a:	db65                	beqz	a4,180a <strlen+0x34>
    for (; *s; s++)
    181c:	0007c703          	lbu	a4,0(a5)
    1820:	d779                	beqz	a4,17ee <strlen+0x18>
    1822:	0017c703          	lbu	a4,1(a5)
    1826:	0785                	addi	a5,a5,1
    1828:	d379                	beqz	a4,17ee <strlen+0x18>
    182a:	0017c703          	lbu	a4,1(a5)
    182e:	0785                	addi	a5,a5,1
    1830:	fb6d                	bnez	a4,1822 <strlen+0x4c>
    1832:	bf75                	j	17ee <strlen+0x18>

0000000000001834 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1834:	00757713          	andi	a4,a0,7
{
    1838:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    183a:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    183e:	cb19                	beqz	a4,1854 <memchr+0x20>
    1840:	ce25                	beqz	a2,18b8 <memchr+0x84>
    1842:	0007c703          	lbu	a4,0(a5)
    1846:	04b70e63          	beq	a4,a1,18a2 <memchr+0x6e>
    184a:	0785                	addi	a5,a5,1
    184c:	0077f713          	andi	a4,a5,7
    1850:	167d                	addi	a2,a2,-1
    1852:	f77d                	bnez	a4,1840 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    1854:	4501                	li	a0,0
    if (n && *s != c) {
    1856:	c235                	beqz	a2,18ba <memchr+0x86>
    1858:	0007c703          	lbu	a4,0(a5)
    185c:	04b70363          	beq	a4,a1,18a2 <memchr+0x6e>
        size_t k = ONES * c;
    1860:	00000517          	auipc	a0,0x0
    1864:	66053503          	ld	a0,1632(a0) # 1ec0 <MAX_CHILD+0x20>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1868:	471d                	li	a4,7
        size_t k = ONES * c;
    186a:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    186e:	02c77a63          	bgeu	a4,a2,18a2 <memchr+0x6e>
    1872:	00000897          	auipc	a7,0x0
    1876:	63e8b883          	ld	a7,1598(a7) # 1eb0 <MAX_CHILD+0x10>
    187a:	00000817          	auipc	a6,0x0
    187e:	63e83803          	ld	a6,1598(a6) # 1eb8 <MAX_CHILD+0x18>
    1882:	431d                	li	t1,7
    1884:	a029                	j	188e <memchr+0x5a>
    1886:	1661                	addi	a2,a2,-8
    1888:	07a1                	addi	a5,a5,8
    188a:	02c37963          	bgeu	t1,a2,18bc <memchr+0x88>
    188e:	6398                	ld	a4,0(a5)
    1890:	8f29                	xor	a4,a4,a0
    1892:	011706b3          	add	a3,a4,a7
    1896:	fff74713          	not	a4,a4
    189a:	8f75                	and	a4,a4,a3
    189c:	01077733          	and	a4,a4,a6
    18a0:	d37d                	beqz	a4,1886 <memchr+0x52>
    18a2:	853e                	mv	a0,a5
    18a4:	97b2                	add	a5,a5,a2
    18a6:	a021                	j	18ae <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    18a8:	0505                	addi	a0,a0,1
    18aa:	00f50763          	beq	a0,a5,18b8 <memchr+0x84>
    18ae:	00054703          	lbu	a4,0(a0)
    18b2:	feb71be3          	bne	a4,a1,18a8 <memchr+0x74>
    18b6:	8082                	ret
    return n ? (void*)s : 0;
    18b8:	4501                	li	a0,0
}
    18ba:	8082                	ret
    return n ? (void*)s : 0;
    18bc:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    18be:	f275                	bnez	a2,18a2 <memchr+0x6e>
}
    18c0:	8082                	ret

00000000000018c2 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    18c2:	1101                	addi	sp,sp,-32
    18c4:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    18c6:	862e                	mv	a2,a1
{
    18c8:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    18ca:	4581                	li	a1,0
{
    18cc:	e426                	sd	s1,8(sp)
    18ce:	ec06                	sd	ra,24(sp)
    18d0:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    18d2:	f63ff0ef          	jal	ra,1834 <memchr>
    return p ? p - s : n;
    18d6:	c519                	beqz	a0,18e4 <strnlen+0x22>
}
    18d8:	60e2                	ld	ra,24(sp)
    18da:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    18dc:	8d05                	sub	a0,a0,s1
}
    18de:	64a2                	ld	s1,8(sp)
    18e0:	6105                	addi	sp,sp,32
    18e2:	8082                	ret
    18e4:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    18e6:	8522                	mv	a0,s0
}
    18e8:	6442                	ld	s0,16(sp)
    18ea:	64a2                	ld	s1,8(sp)
    18ec:	6105                	addi	sp,sp,32
    18ee:	8082                	ret

00000000000018f0 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    18f0:	00b547b3          	xor	a5,a0,a1
    18f4:	8b9d                	andi	a5,a5,7
    18f6:	eb95                	bnez	a5,192a <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    18f8:	0075f793          	andi	a5,a1,7
    18fc:	e7b1                	bnez	a5,1948 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    18fe:	6198                	ld	a4,0(a1)
    1900:	00000617          	auipc	a2,0x0
    1904:	5b063603          	ld	a2,1456(a2) # 1eb0 <MAX_CHILD+0x10>
    1908:	00000817          	auipc	a6,0x0
    190c:	5b083803          	ld	a6,1456(a6) # 1eb8 <MAX_CHILD+0x18>
    1910:	a029                	j	191a <stpcpy+0x2a>
    1912:	e118                	sd	a4,0(a0)
    1914:	6598                	ld	a4,8(a1)
    1916:	05a1                	addi	a1,a1,8
    1918:	0521                	addi	a0,a0,8
    191a:	00c707b3          	add	a5,a4,a2
    191e:	fff74693          	not	a3,a4
    1922:	8ff5                	and	a5,a5,a3
    1924:	0107f7b3          	and	a5,a5,a6
    1928:	d7ed                	beqz	a5,1912 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    192a:	0005c783          	lbu	a5,0(a1)
    192e:	00f50023          	sb	a5,0(a0)
    1932:	c785                	beqz	a5,195a <stpcpy+0x6a>
    1934:	0015c783          	lbu	a5,1(a1)
    1938:	0505                	addi	a0,a0,1
    193a:	0585                	addi	a1,a1,1
    193c:	00f50023          	sb	a5,0(a0)
    1940:	fbf5                	bnez	a5,1934 <stpcpy+0x44>
        ;
    return d;
}
    1942:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1944:	0505                	addi	a0,a0,1
    1946:	df45                	beqz	a4,18fe <stpcpy+0xe>
            if (!(*d = *s))
    1948:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    194c:	0585                	addi	a1,a1,1
    194e:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1952:	00f50023          	sb	a5,0(a0)
    1956:	f7fd                	bnez	a5,1944 <stpcpy+0x54>
}
    1958:	8082                	ret
    195a:	8082                	ret

000000000000195c <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    195c:	00b547b3          	xor	a5,a0,a1
    1960:	8b9d                	andi	a5,a5,7
    1962:	1a079863          	bnez	a5,1b12 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1966:	0075f793          	andi	a5,a1,7
    196a:	16078463          	beqz	a5,1ad2 <stpncpy+0x176>
    196e:	ea01                	bnez	a2,197e <stpncpy+0x22>
    1970:	a421                	j	1b78 <stpncpy+0x21c>
    1972:	167d                	addi	a2,a2,-1
    1974:	0505                	addi	a0,a0,1
    1976:	14070e63          	beqz	a4,1ad2 <stpncpy+0x176>
    197a:	1a060863          	beqz	a2,1b2a <stpncpy+0x1ce>
    197e:	0005c783          	lbu	a5,0(a1)
    1982:	0585                	addi	a1,a1,1
    1984:	0075f713          	andi	a4,a1,7
    1988:	00f50023          	sb	a5,0(a0)
    198c:	f3fd                	bnez	a5,1972 <stpncpy+0x16>
    198e:	4805                	li	a6,1
    1990:	1a061863          	bnez	a2,1b40 <stpncpy+0x1e4>
    1994:	40a007b3          	neg	a5,a0
    1998:	8b9d                	andi	a5,a5,7
    199a:	4681                	li	a3,0
    199c:	18061a63          	bnez	a2,1b30 <stpncpy+0x1d4>
    19a0:	00778713          	addi	a4,a5,7
    19a4:	45ad                	li	a1,11
    19a6:	18b76363          	bltu	a4,a1,1b2c <stpncpy+0x1d0>
    19aa:	1ae6eb63          	bltu	a3,a4,1b60 <stpncpy+0x204>
    19ae:	1a078363          	beqz	a5,1b54 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    19b2:	00050023          	sb	zero,0(a0)
    19b6:	4685                	li	a3,1
    19b8:	00150713          	addi	a4,a0,1
    19bc:	18d78f63          	beq	a5,a3,1b5a <stpncpy+0x1fe>
    19c0:	000500a3          	sb	zero,1(a0)
    19c4:	4689                	li	a3,2
    19c6:	00250713          	addi	a4,a0,2
    19ca:	18d78e63          	beq	a5,a3,1b66 <stpncpy+0x20a>
    19ce:	00050123          	sb	zero,2(a0)
    19d2:	468d                	li	a3,3
    19d4:	00350713          	addi	a4,a0,3
    19d8:	16d78c63          	beq	a5,a3,1b50 <stpncpy+0x1f4>
    19dc:	000501a3          	sb	zero,3(a0)
    19e0:	4691                	li	a3,4
    19e2:	00450713          	addi	a4,a0,4
    19e6:	18d78263          	beq	a5,a3,1b6a <stpncpy+0x20e>
    19ea:	00050223          	sb	zero,4(a0)
    19ee:	4695                	li	a3,5
    19f0:	00550713          	addi	a4,a0,5
    19f4:	16d78d63          	beq	a5,a3,1b6e <stpncpy+0x212>
    19f8:	000502a3          	sb	zero,5(a0)
    19fc:	469d                	li	a3,7
    19fe:	00650713          	addi	a4,a0,6
    1a02:	16d79863          	bne	a5,a3,1b72 <stpncpy+0x216>
    1a06:	00750713          	addi	a4,a0,7
    1a0a:	00050323          	sb	zero,6(a0)
    1a0e:	40f80833          	sub	a6,a6,a5
    1a12:	ff887593          	andi	a1,a6,-8
    1a16:	97aa                	add	a5,a5,a0
    1a18:	95be                	add	a1,a1,a5
    1a1a:	0007b023          	sd	zero,0(a5)
    1a1e:	07a1                	addi	a5,a5,8
    1a20:	feb79de3          	bne	a5,a1,1a1a <stpncpy+0xbe>
    1a24:	ff887593          	andi	a1,a6,-8
    1a28:	9ead                	addw	a3,a3,a1
    1a2a:	00b707b3          	add	a5,a4,a1
    1a2e:	12b80863          	beq	a6,a1,1b5e <stpncpy+0x202>
    1a32:	00078023          	sb	zero,0(a5)
    1a36:	0016871b          	addiw	a4,a3,1
    1a3a:	0ec77863          	bgeu	a4,a2,1b2a <stpncpy+0x1ce>
    1a3e:	000780a3          	sb	zero,1(a5)
    1a42:	0026871b          	addiw	a4,a3,2
    1a46:	0ec77263          	bgeu	a4,a2,1b2a <stpncpy+0x1ce>
    1a4a:	00078123          	sb	zero,2(a5)
    1a4e:	0036871b          	addiw	a4,a3,3
    1a52:	0cc77c63          	bgeu	a4,a2,1b2a <stpncpy+0x1ce>
    1a56:	000781a3          	sb	zero,3(a5)
    1a5a:	0046871b          	addiw	a4,a3,4
    1a5e:	0cc77663          	bgeu	a4,a2,1b2a <stpncpy+0x1ce>
    1a62:	00078223          	sb	zero,4(a5)
    1a66:	0056871b          	addiw	a4,a3,5
    1a6a:	0cc77063          	bgeu	a4,a2,1b2a <stpncpy+0x1ce>
    1a6e:	000782a3          	sb	zero,5(a5)
    1a72:	0066871b          	addiw	a4,a3,6
    1a76:	0ac77a63          	bgeu	a4,a2,1b2a <stpncpy+0x1ce>
    1a7a:	00078323          	sb	zero,6(a5)
    1a7e:	0076871b          	addiw	a4,a3,7
    1a82:	0ac77463          	bgeu	a4,a2,1b2a <stpncpy+0x1ce>
    1a86:	000783a3          	sb	zero,7(a5)
    1a8a:	0086871b          	addiw	a4,a3,8
    1a8e:	08c77e63          	bgeu	a4,a2,1b2a <stpncpy+0x1ce>
    1a92:	00078423          	sb	zero,8(a5)
    1a96:	0096871b          	addiw	a4,a3,9
    1a9a:	08c77863          	bgeu	a4,a2,1b2a <stpncpy+0x1ce>
    1a9e:	000784a3          	sb	zero,9(a5)
    1aa2:	00a6871b          	addiw	a4,a3,10
    1aa6:	08c77263          	bgeu	a4,a2,1b2a <stpncpy+0x1ce>
    1aaa:	00078523          	sb	zero,10(a5)
    1aae:	00b6871b          	addiw	a4,a3,11
    1ab2:	06c77c63          	bgeu	a4,a2,1b2a <stpncpy+0x1ce>
    1ab6:	000785a3          	sb	zero,11(a5)
    1aba:	00c6871b          	addiw	a4,a3,12
    1abe:	06c77663          	bgeu	a4,a2,1b2a <stpncpy+0x1ce>
    1ac2:	00078623          	sb	zero,12(a5)
    1ac6:	26b5                	addiw	a3,a3,13
    1ac8:	06c6f163          	bgeu	a3,a2,1b2a <stpncpy+0x1ce>
    1acc:	000786a3          	sb	zero,13(a5)
    1ad0:	8082                	ret
            ;
        if (!n || !*s)
    1ad2:	c645                	beqz	a2,1b7a <stpncpy+0x21e>
    1ad4:	0005c783          	lbu	a5,0(a1)
    1ad8:	ea078be3          	beqz	a5,198e <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1adc:	479d                	li	a5,7
    1ade:	02c7ff63          	bgeu	a5,a2,1b1c <stpncpy+0x1c0>
    1ae2:	00000897          	auipc	a7,0x0
    1ae6:	3ce8b883          	ld	a7,974(a7) # 1eb0 <MAX_CHILD+0x10>
    1aea:	00000817          	auipc	a6,0x0
    1aee:	3ce83803          	ld	a6,974(a6) # 1eb8 <MAX_CHILD+0x18>
    1af2:	431d                	li	t1,7
    1af4:	6198                	ld	a4,0(a1)
    1af6:	011707b3          	add	a5,a4,a7
    1afa:	fff74693          	not	a3,a4
    1afe:	8ff5                	and	a5,a5,a3
    1b00:	0107f7b3          	and	a5,a5,a6
    1b04:	ef81                	bnez	a5,1b1c <stpncpy+0x1c0>
            *wd = *ws;
    1b06:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b08:	1661                	addi	a2,a2,-8
    1b0a:	05a1                	addi	a1,a1,8
    1b0c:	0521                	addi	a0,a0,8
    1b0e:	fec363e3          	bltu	t1,a2,1af4 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1b12:	e609                	bnez	a2,1b1c <stpncpy+0x1c0>
    1b14:	a08d                	j	1b76 <stpncpy+0x21a>
    1b16:	167d                	addi	a2,a2,-1
    1b18:	0505                	addi	a0,a0,1
    1b1a:	ca01                	beqz	a2,1b2a <stpncpy+0x1ce>
    1b1c:	0005c783          	lbu	a5,0(a1)
    1b20:	0585                	addi	a1,a1,1
    1b22:	00f50023          	sb	a5,0(a0)
    1b26:	fbe5                	bnez	a5,1b16 <stpncpy+0x1ba>
        ;
tail:
    1b28:	b59d                	j	198e <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1b2a:	8082                	ret
    1b2c:	472d                	li	a4,11
    1b2e:	bdb5                	j	19aa <stpncpy+0x4e>
    1b30:	00778713          	addi	a4,a5,7
    1b34:	45ad                	li	a1,11
    1b36:	fff60693          	addi	a3,a2,-1
    1b3a:	e6b778e3          	bgeu	a4,a1,19aa <stpncpy+0x4e>
    1b3e:	b7fd                	j	1b2c <stpncpy+0x1d0>
    1b40:	40a007b3          	neg	a5,a0
    1b44:	8832                	mv	a6,a2
    1b46:	8b9d                	andi	a5,a5,7
    1b48:	4681                	li	a3,0
    1b4a:	e4060be3          	beqz	a2,19a0 <stpncpy+0x44>
    1b4e:	b7cd                	j	1b30 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1b50:	468d                	li	a3,3
    1b52:	bd75                	j	1a0e <stpncpy+0xb2>
    1b54:	872a                	mv	a4,a0
    1b56:	4681                	li	a3,0
    1b58:	bd5d                	j	1a0e <stpncpy+0xb2>
    1b5a:	4685                	li	a3,1
    1b5c:	bd4d                	j	1a0e <stpncpy+0xb2>
    1b5e:	8082                	ret
    1b60:	87aa                	mv	a5,a0
    1b62:	4681                	li	a3,0
    1b64:	b5f9                	j	1a32 <stpncpy+0xd6>
    1b66:	4689                	li	a3,2
    1b68:	b55d                	j	1a0e <stpncpy+0xb2>
    1b6a:	4691                	li	a3,4
    1b6c:	b54d                	j	1a0e <stpncpy+0xb2>
    1b6e:	4695                	li	a3,5
    1b70:	bd79                	j	1a0e <stpncpy+0xb2>
    1b72:	4699                	li	a3,6
    1b74:	bd69                	j	1a0e <stpncpy+0xb2>
    1b76:	8082                	ret
    1b78:	8082                	ret
    1b7a:	8082                	ret

0000000000001b7c <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1b7c:	fff6071b          	addiw	a4,a2,-1
    1b80:	0cb57063          	bgeu	a0,a1,1c40 <memmove+0xc4>
        while (n-- > 0)
    1b84:	0ec05063          	blez	a2,1c64 <memmove+0xe8>
    1b88:	00750693          	addi	a3,a0,7
    1b8c:	8e8d                	sub	a3,a3,a1
    1b8e:	00b567b3          	or	a5,a0,a1
    1b92:	00f6b693          	sltiu	a3,a3,15
    1b96:	8b9d                	andi	a5,a5,7
    1b98:	0016c693          	xori	a3,a3,1
    1b9c:	0017b793          	seqz	a5,a5
    1ba0:	8ff5                	and	a5,a5,a3
    1ba2:	c3f1                	beqz	a5,1c66 <memmove+0xea>
    1ba4:	0007079b          	sext.w	a5,a4
    1ba8:	46a5                	li	a3,9
    1baa:	0af6fe63          	bgeu	a3,a5,1c66 <memmove+0xea>
    1bae:	0036589b          	srliw	a7,a2,0x3
    1bb2:	088e                	slli	a7,a7,0x3
    1bb4:	2601                	sext.w	a2,a2
    1bb6:	87ae                	mv	a5,a1
    1bb8:	86aa                	mv	a3,a0
    1bba:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1bbc:	0007b803          	ld	a6,0(a5)
    1bc0:	07a1                	addi	a5,a5,8
    1bc2:	06a1                	addi	a3,a3,8
    1bc4:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1bc8:	ff179ae3          	bne	a5,a7,1bbc <memmove+0x40>
    1bcc:	ff867813          	andi	a6,a2,-8
    1bd0:	02081793          	slli	a5,a6,0x20
    1bd4:	9381                	srli	a5,a5,0x20
    1bd6:	00f506b3          	add	a3,a0,a5
    1bda:	95be                	add	a1,a1,a5
    1bdc:	4107073b          	subw	a4,a4,a6
    1be0:	09060263          	beq	a2,a6,1c64 <memmove+0xe8>
            *dst++ = *src++;
    1be4:	0005c783          	lbu	a5,0(a1)
    1be8:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1bec:	06e05c63          	blez	a4,1c64 <memmove+0xe8>
            *dst++ = *src++;
    1bf0:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1bf4:	4785                	li	a5,1
            *dst++ = *src++;
    1bf6:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1bfa:	06e7d563          	bge	a5,a4,1c64 <memmove+0xe8>
            *dst++ = *src++;
    1bfe:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1c02:	4789                	li	a5,2
            *dst++ = *src++;
    1c04:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1c08:	04e7de63          	bge	a5,a4,1c64 <memmove+0xe8>
            *dst++ = *src++;
    1c0c:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1c10:	478d                	li	a5,3
            *dst++ = *src++;
    1c12:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1c16:	04e7d763          	bge	a5,a4,1c64 <memmove+0xe8>
            *dst++ = *src++;
    1c1a:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1c1e:	4791                	li	a5,4
            *dst++ = *src++;
    1c20:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1c24:	04e7d063          	bge	a5,a4,1c64 <memmove+0xe8>
            *dst++ = *src++;
    1c28:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1c2c:	4795                	li	a5,5
            *dst++ = *src++;
    1c2e:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1c32:	02e7d963          	bge	a5,a4,1c64 <memmove+0xe8>
            *dst++ = *src++;
    1c36:	0065c783          	lbu	a5,6(a1)
    1c3a:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1c3e:	8082                	ret
    } else {
        dst += n;
    1c40:	00c507b3          	add	a5,a0,a2
        src += n;
    1c44:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1c46:	00c05f63          	blez	a2,1c64 <memmove+0xe8>
    1c4a:	1702                	slli	a4,a4,0x20
    1c4c:	9301                	srli	a4,a4,0x20
    1c4e:	fff74713          	not	a4,a4
    1c52:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1c54:	fff5c683          	lbu	a3,-1(a1)
    1c58:	17fd                	addi	a5,a5,-1
    1c5a:	15fd                	addi	a1,a1,-1
    1c5c:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1c60:	fee79ae3          	bne	a5,a4,1c54 <memmove+0xd8>
    }
    return vdst;
}
    1c64:	8082                	ret
    1c66:	02071693          	slli	a3,a4,0x20
    1c6a:	9281                	srli	a3,a3,0x20
    1c6c:	0685                	addi	a3,a3,1
    1c6e:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1c70:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1c72:	0005c703          	lbu	a4,0(a1)
    1c76:	0585                	addi	a1,a1,1
    1c78:	0785                	addi	a5,a5,1
    1c7a:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1c7e:	fed59ae3          	bne	a1,a3,1c72 <memmove+0xf6>
    1c82:	8082                	ret

0000000000001c84 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1c84:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c88:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1c8c:	2501                	sext.w	a0,a0
    1c8e:	8082                	ret

0000000000001c90 <exec>:
    register long a7 __asm__("a7") = n;
    1c90:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1c94:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c96:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1c9a:	2501                	sext.w	a0,a0
    1c9c:	8082                	ret

0000000000001c9e <exit>:
    register long a7 __asm__("a7") = n;
    1c9e:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1ca2:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1ca6:	8082                	ret

0000000000001ca8 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1ca8:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cac:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1cb0:	8082                	ret

0000000000001cb2 <write>:
    register long a7 __asm__("a7") = n;
    1cb2:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cb6:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1cba:	8082                	ret

0000000000001cbc <getpid>:
    register long a7 __asm__("a7") = n;
    1cbc:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1cc0:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1cc4:	2501                	sext.w	a0,a0
    1cc6:	8082                	ret

0000000000001cc8 <getppid>:
    register long a7 __asm__("a7") = n;
    1cc8:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1ccc:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1cd0:	2501                	sext.w	a0,a0
    1cd2:	8082                	ret

0000000000001cd4 <open>:
    register long a7 __asm__("a7") = n;
    1cd4:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cd8:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1cdc:	2501                	sext.w	a0,a0
    1cde:	8082                	ret

0000000000001ce0 <mknod>:
    register long a7 __asm__("a7") = n;
    1ce0:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1ce4:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1ce8:	2501                	sext.w	a0,a0
    1cea:	8082                	ret

0000000000001cec <dup>:
    register long a7 __asm__("a7") = n;
    1cec:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1cee:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1cf2:	2501                	sext.w	a0,a0
    1cf4:	8082                	ret

0000000000001cf6 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cf6:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cfa:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cfe:	2501                	sext.w	a0,a0
    1d00:	8082                	ret

0000000000001d02 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d02:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d06:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1d0a:	2501                	sext.w	a0,a0
    1d0c:	8082                	ret

0000000000001d0e <wait>:

pid_t wait(int *wstatus)
{
    1d0e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d10:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1d14:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d16:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1d1a:	2501                	sext.w	a0,a0
    1d1c:	8082                	ret

0000000000001d1e <mkdir>:
    register long a7 __asm__("a7") = n;
    1d1e:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1d22:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1d26:	2501                	sext.w	a0,a0
    1d28:	8082                	ret

0000000000001d2a <close>:
    register long a7 __asm__("a7") = n;
    1d2a:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1d2e:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1d32:	2501                	sext.w	a0,a0
    1d34:	8082                	ret

0000000000001d36 <fork>:
    register long a7 __asm__("a7") = n;
    1d36:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1d3a:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1d3e:	2501                	sext.w	a0,a0
    1d40:	8082                	ret

0000000000001d42 <time_ms>:
    register long a7 __asm__("a7") = n;
    1d42:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d46:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1d4a:	8082                	ret

0000000000001d4c <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1d4c:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1d4e:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d52:	00000073          	ecall
    1d56:	87aa                	mv	a5,a0
    1d58:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1d5c:	97ba                	add	a5,a5,a4
    1d5e:	00f57c63          	bgeu	a0,a5,1d76 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1d62:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1d66:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d6a:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d6e:	00000073          	ecall
    1d72:	fef568e3          	bltu	a0,a5,1d62 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1d76:	4501                	li	a0,0
    1d78:	8082                	ret

0000000000001d7a <pipe>:
    register long a7 __asm__("a7") = n;
    1d7a:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1d7e:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1d82:	2501                	sext.w	a0,a0
    1d84:	8082                	ret

0000000000001d86 <fstat>:
    register long a7 __asm__("a7") = n;
    1d86:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d8a:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1d8e:	2501                	sext.w	a0,a0
    1d90:	8082                	ret

0000000000001d92 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1d92:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1d94:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1d98:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d9a:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1d9e:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1da2:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1da6:	0206c163          	bltz	a3,1dc8 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1daa:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1dae:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1db0:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db2:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1db6:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1dba:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1dbe:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1dc0:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1dc4:	853e                	mv	a0,a5
    1dc6:	8082                	ret
        return -1;
    1dc8:	57fd                	li	a5,-1
    1dca:	bfed                	j	1dc4 <stat+0x32>

0000000000001dcc <chdir>:
    register long a7 __asm__("a7") = n;
    1dcc:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1dd0:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1dd4:	2501                	sext.w	a0,a0
    1dd6:	8082                	ret

0000000000001dd8 <link>:
    register long a7 __asm__("a7") = n;
    1dd8:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ddc:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1de0:	2501                	sext.w	a0,a0
    1de2:	8082                	ret

0000000000001de4 <unlink>:
    register long a7 __asm__("a7") = n;
    1de4:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1de8:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1dec:	2501                	sext.w	a0,a0
    1dee:	8082                	ret

0000000000001df0 <setpriority>:
    register long a7 __asm__("a7") = n;
    1df0:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1df4:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1df8:	8082                	ret

0000000000001dfa <getpriority>:
    register long a7 __asm__("a7") = n;
    1dfa:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1dfe:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1e02:	8082                	ret

0000000000001e04 <sharedmem>:
    register long a7 __asm__("a7") = n;
    1e04:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e08:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1e0c:	8082                	ret
