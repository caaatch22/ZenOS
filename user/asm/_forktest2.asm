
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_forktest2:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a045                	j	10a0 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <stdlib.h>
#include <ucore.h>

const int NUM = 30;

int main() {
    1002:	7179                	addi	sp,sp,-48
    1004:	f022                	sd	s0,32(sp)
    1006:	ec26                	sd	s1,24(sp)
    1008:	e84a                	sd	s2,16(sp)
    100a:	f406                	sd	ra,40(sp)
    100c:	4479                	li	s0,30
    for(int i = 0; i < NUM; ++i) {
        int pid = fork();
        if(pid == 0) {
            int current_time = time_ms();
            unsigned long long sleep_length = current_time * current_time % 1000 + 1000;
    100e:	3e800913          	li	s2,1000
            sleep(sleep_length);
            printf("pid %d OK!\n", getpid());
    1012:	00001497          	auipc	s1,0x1
    1016:	dd648493          	addi	s1,s1,-554 # 1de8 <sharedmem+0xc>
        int pid = fork();
    101a:	4f5000ef          	jal	ra,1d0e <fork>
        if(pid == 0) {
    101e:	347d                	addiw	s0,s0,-1
    1020:	c939                	beqz	a0,1076 <main+0x74>
    for(int i = 0; i < NUM; ++i) {
    1022:	fc65                	bnez	s0,101a <main+0x18>
            exit(0);
        }
    }
    
    int xstate = 0;
    1024:	c602                	sw	zero,12(sp)
    1026:	4479                	li	s0,30
    for(int i = 0; i < NUM; ++i) {
        assert(waitpid(-1, &xstate) > 0, -1);
    1028:	006c                	addi	a1,sp,12
    102a:	557d                	li	a0,-1
    102c:	4af000ef          	jal	ra,1cda <waitpid>
    1030:	55fd                	li	a1,-1
    1032:	00a02533          	sgtz	a0,a0
    1036:	492000ef          	jal	ra,14c8 <assert>
        assert(xstate == 0, -2);
    103a:	4532                	lw	a0,12(sp)
    103c:	347d                	addiw	s0,s0,-1
    103e:	55f9                	li	a1,-2
    1040:	00153513          	seqz	a0,a0
    1044:	484000ef          	jal	ra,14c8 <assert>
    for(int i = 0; i < NUM; ++i) {
    1048:	f065                	bnez	s0,1028 <main+0x26>
    }
    assert(waitpid(-1, &xstate) < 0, -3);
    104a:	006c                	addi	a1,sp,12
    104c:	557d                	li	a0,-1
    104e:	48d000ef          	jal	ra,1cda <waitpid>
    1052:	55f5                	li	a1,-3
    1054:	01f5551b          	srliw	a0,a0,0x1f
    1058:	470000ef          	jal	ra,14c8 <assert>
    printf("forktest2 test passed!\n");
    105c:	00001517          	auipc	a0,0x1
    1060:	d9c50513          	addi	a0,a0,-612 # 1df8 <sharedmem+0x1c>
    1064:	0d2000ef          	jal	ra,1136 <printf>
    return 0;
}
    1068:	70a2                	ld	ra,40(sp)
    106a:	7402                	ld	s0,32(sp)
    106c:	64e2                	ld	s1,24(sp)
    106e:	6942                	ld	s2,16(sp)
    1070:	4501                	li	a0,0
    1072:	6145                	addi	sp,sp,48
    1074:	8082                	ret
            int current_time = time_ms();
    1076:	4a5000ef          	jal	ra,1d1a <time_ms>
            unsigned long long sleep_length = current_time * current_time % 1000 + 1000;
    107a:	02a5053b          	mulw	a0,a0,a0
    107e:	0325653b          	remw	a0,a0,s2
            sleep(sleep_length);
    1082:	3e85051b          	addiw	a0,a0,1000
    1086:	49f000ef          	jal	ra,1d24 <sleep>
            printf("pid %d OK!\n", getpid());
    108a:	40b000ef          	jal	ra,1c94 <getpid>
    108e:	85aa                	mv	a1,a0
    1090:	8526                	mv	a0,s1
    1092:	0a4000ef          	jal	ra,1136 <printf>
            exit(0);
    1096:	4501                	li	a0,0
    1098:	3df000ef          	jal	ra,1c76 <exit>
    for(int i = 0; i < NUM; ++i) {
    109c:	fc3d                	bnez	s0,101a <main+0x18>
    109e:	b759                	j	1024 <main+0x22>

00000000000010a0 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    10a0:	1141                	addi	sp,sp,-16
    10a2:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    10a4:	f5fff0ef          	jal	ra,1002 <main>
}
    10a8:	60a2                	ld	ra,8(sp)
    10aa:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    10ac:	3cb0006f          	j	1c76 <exit>

00000000000010b0 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    10b0:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    10b2:	00f10593          	addi	a1,sp,15
    10b6:	4605                	li	a2,1
    10b8:	4501                	li	a0,0
int getchar() {
    10ba:	ec06                	sd	ra,24(sp)
    char byte = 0;
    10bc:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    10c0:	3c1000ef          	jal	ra,1c80 <read>
    return byte;
}
    10c4:	60e2                	ld	ra,24(sp)
    10c6:	00f14503          	lbu	a0,15(sp)
    10ca:	6105                	addi	sp,sp,32
    10cc:	8082                	ret

00000000000010ce <putchar>:

int putchar(int c)
{
    10ce:	1141                	addi	sp,sp,-16
    10d0:	e406                	sd	ra,8(sp)
    10d2:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    10d4:	00001597          	auipc	a1,0x1
    10d8:	d6c58593          	addi	a1,a1,-660 # 1e40 <put.1156>
    return write(stdout, put, 1);
    10dc:	4605                	li	a2,1
    10de:	4505                	li	a0,1
    put[0] = c;
    10e0:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    10e4:	3a7000ef          	jal	ra,1c8a <write>
}
    10e8:	60a2                	ld	ra,8(sp)
    10ea:	2501                	sext.w	a0,a0
    10ec:	0141                	addi	sp,sp,16
    10ee:	8082                	ret

00000000000010f0 <puts>:

int puts(const char* s)
{
    10f0:	1141                	addi	sp,sp,-16
    10f2:	e022                	sd	s0,0(sp)
    10f4:	e406                	sd	ra,8(sp)
    10f6:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    10f8:	6b6000ef          	jal	ra,17ae <strlen>
    10fc:	862a                	mv	a2,a0
    10fe:	85a2                	mv	a1,s0
    1100:	4505                	li	a0,1
    1102:	389000ef          	jal	ra,1c8a <write>
    1106:	00055763          	bgez	a0,1114 <puts+0x24>
    return r;
}
    110a:	60a2                	ld	ra,8(sp)
    110c:	6402                	ld	s0,0(sp)
    110e:	557d                	li	a0,-1
    1110:	0141                	addi	sp,sp,16
    1112:	8082                	ret
    put[0] = c;
    1114:	00001597          	auipc	a1,0x1
    1118:	d2c58593          	addi	a1,a1,-724 # 1e40 <put.1156>
    111c:	47a9                	li	a5,10
    return write(stdout, put, 1);
    111e:	4605                	li	a2,1
    1120:	4505                	li	a0,1
    put[0] = c;
    1122:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1126:	365000ef          	jal	ra,1c8a <write>
}
    112a:	60a2                	ld	ra,8(sp)
    112c:	6402                	ld	s0,0(sp)
    112e:	41f5551b          	sraiw	a0,a0,0x1f
    1132:	0141                	addi	sp,sp,16
    1134:	8082                	ret

0000000000001136 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    1136:	7115                	addi	sp,sp,-224
    1138:	ed06                	sd	ra,152(sp)
    113a:	e922                	sd	s0,144(sp)
    113c:	e526                	sd	s1,136(sp)
    113e:	e14a                	sd	s2,128(sp)
    1140:	fcce                	sd	s3,120(sp)
    1142:	f8d2                	sd	s4,112(sp)
    1144:	f4d6                	sd	s5,104(sp)
    1146:	f0da                	sd	s6,96(sp)
    1148:	ecde                	sd	s7,88(sp)
    114a:	e8e2                	sd	s8,80(sp)
    114c:	e4e6                	sd	s9,72(sp)
    114e:	e0ea                	sd	s10,64(sp)
    1150:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1152:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    1156:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    1158:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    115a:	f52e                	sd	a1,168(sp)
    115c:	f932                	sd	a2,176(sp)
    115e:	fd36                	sd	a3,184(sp)
    1160:	e1ba                	sd	a4,192(sp)
    1162:	e9c2                	sd	a6,208(sp)
    1164:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    1166:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1168:	0c030b63          	beqz	t1,123e <printf+0x108>
    116c:	8aaa                	mv	s5,a0
    116e:	0003071b          	sext.w	a4,t1
    1172:	4481                	li	s1,0
        if (c != '%') {
    1174:	02500b93          	li	s7,37
    put[0] = c;
    1178:	00001417          	auipc	s0,0x1
    117c:	cc840413          	addi	s0,s0,-824 # 1e40 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    1180:	4c51                	li	s8,20
    put[0] = c;
    1182:	02500c93          	li	s9,37
    1186:	00001a17          	auipc	s4,0x1
    118a:	ccaa0a13          	addi	s4,s4,-822 # 1e50 <seed+0x8>
    118e:	00001997          	auipc	s3,0x1
    1192:	d1a98993          	addi	s3,s3,-742 # 1ea8 <digits>
    1196:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    119a:	0014879b          	addiw	a5,s1,1
    119e:	00fa8933          	add	s2,s5,a5
    11a2:	13771163          	bne	a4,s7,12c4 <printf+0x18e>
        c = fmt[++i] & 0xff;
    11a6:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    11aa:	080d0a63          	beqz	s10,123e <printf+0x108>
        switch (c) {
    11ae:	2489                	addiw	s1,s1,2
    11b0:	009a8933          	add	s2,s5,s1
    11b4:	257d0e63          	beq	s10,s7,1410 <printf+0x2da>
    11b8:	f9cd079b          	addiw	a5,s10,-100
    11bc:	0ff7f793          	andi	a5,a5,255
    11c0:	0cfc6263          	bltu	s8,a5,1284 <printf+0x14e>
    11c4:	078a                	slli	a5,a5,0x2
    11c6:	97d2                	add	a5,a5,s4
    11c8:	439c                	lw	a5,0(a5)
    11ca:	97d2                	add	a5,a5,s4
    11cc:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    11ce:	67a2                	ld	a5,8(sp)
    11d0:	4398                	lw	a4,0(a5)
    11d2:	07a1                	addi	a5,a5,8
    11d4:	e43e                	sd	a5,8(sp)
    11d6:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    11da:	26074663          	bltz	a4,1446 <printf+0x310>
        buf[i++] = digits[x % base];
    11de:	8bbd                	andi	a5,a5,15
    11e0:	97ce                	add	a5,a5,s3
    11e2:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    11e6:	40475d1b          	sraiw	s10,a4,0x4
    11ea:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    11ee:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    11f2:	020d0163          	beqz	s10,1214 <printf+0xde>
        buf[i++] = digits[x % base];
    11f6:	9d4e                	add	s10,s10,s3
    11f8:	000d4783          	lbu	a5,0(s10)
    11fc:	4d05                	li	s10,1
    11fe:	00f108a3          	sb	a5,17(sp)
    if (sign)
    1202:	00075963          	bgez	a4,1214 <printf+0xde>
        buf[i++] = digits[x % base];
    1206:	4d09                	li	s10,2
        buf[i++] = '-';
    1208:	181c                	addi	a5,sp,48
    120a:	02d00713          	li	a4,45
    120e:	97ea                	add	a5,a5,s10
    1210:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    1214:	9d5a                	add	s10,s10,s6
    1216:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    121a:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    121e:	4605                	li	a2,1
    1220:	1d7d                	addi	s10,s10,-1
    1222:	85a2                	mv	a1,s0
    1224:	4505                	li	a0,1
    put[0] = c;
    1226:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    122a:	261000ef          	jal	ra,1c8a <write>
    while (--i >= 0)
    122e:	ffbd16e3          	bne	s10,s11,121a <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1232:	00094303          	lbu	t1,0(s2)
    1236:	0003071b          	sext.w	a4,t1
    123a:	f60310e3          	bnez	t1,119a <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    123e:	60ea                	ld	ra,152(sp)
    1240:	644a                	ld	s0,144(sp)
    1242:	64aa                	ld	s1,136(sp)
    1244:	690a                	ld	s2,128(sp)
    1246:	79e6                	ld	s3,120(sp)
    1248:	7a46                	ld	s4,112(sp)
    124a:	7aa6                	ld	s5,104(sp)
    124c:	7b06                	ld	s6,96(sp)
    124e:	6be6                	ld	s7,88(sp)
    1250:	6c46                	ld	s8,80(sp)
    1252:	6ca6                	ld	s9,72(sp)
    1254:	6d06                	ld	s10,64(sp)
    1256:	7de2                	ld	s11,56(sp)
    1258:	612d                	addi	sp,sp,224
    125a:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    125c:	67a2                	ld	a5,8(sp)
    125e:	0007bd03          	ld	s10,0(a5)
    1262:	07a1                	addi	a5,a5,8
    1264:	e43e                	sd	a5,8(sp)
    1266:	000d1b63          	bnez	s10,127c <printf+0x146>
    126a:	aafd                	j	1468 <printf+0x332>
    return write(stdout, put, 1);
    126c:	4605                	li	a2,1
    126e:	85a2                	mv	a1,s0
    1270:	4505                	li	a0,1
                for (; *s; s++)
    1272:	0d05                	addi	s10,s10,1
    put[0] = c;
    1274:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1278:	213000ef          	jal	ra,1c8a <write>
                for (; *s; s++)
    127c:	000d4783          	lbu	a5,0(s10)
    1280:	f7f5                	bnez	a5,126c <printf+0x136>
    1282:	a02d                	j	12ac <printf+0x176>
    return write(stdout, put, 1);
    1284:	4605                	li	a2,1
    1286:	00001597          	auipc	a1,0x1
    128a:	bba58593          	addi	a1,a1,-1094 # 1e40 <put.1156>
    128e:	4505                	li	a0,1
    put[0] = c;
    1290:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    1294:	1f7000ef          	jal	ra,1c8a <write>
    1298:	4605                	li	a2,1
    129a:	00001597          	auipc	a1,0x1
    129e:	ba658593          	addi	a1,a1,-1114 # 1e40 <put.1156>
    12a2:	4505                	li	a0,1
    put[0] = c;
    12a4:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    12a8:	1e3000ef          	jal	ra,1c8a <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    12ac:	00094303          	lbu	t1,0(s2)
    12b0:	0003071b          	sext.w	a4,t1
    12b4:	f80305e3          	beqz	t1,123e <printf+0x108>
        if (c != '%') {
    12b8:	0014879b          	addiw	a5,s1,1
    12bc:	00fa8933          	add	s2,s5,a5
    12c0:	ef7703e3          	beq	a4,s7,11a6 <printf+0x70>
    return write(stdout, put, 1);
    12c4:	4605                	li	a2,1
    12c6:	00001597          	auipc	a1,0x1
    12ca:	b7a58593          	addi	a1,a1,-1158 # 1e40 <put.1156>
    12ce:	4505                	li	a0,1
    put[0] = c;
    12d0:	00640023          	sb	t1,0(s0)
            continue;
    12d4:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    12d6:	1b5000ef          	jal	ra,1c8a <write>
            continue;
    12da:	bfc9                	j	12ac <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    12dc:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    12de:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    12e0:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    12e2:	0007b883          	ld	a7,0(a5)
    12e6:	07a1                	addi	a5,a5,8
    12e8:	e43e                	sd	a5,8(sp)
        x = -xx;
    12ea:	43f8d713          	srai	a4,a7,0x3f
    12ee:	011747b3          	xor	a5,a4,a7
    12f2:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    12f4:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    12f6:	02c7f733          	remu	a4,a5,a2
    12fa:	8d36                	mv	s10,a3
    12fc:	0685                	addi	a3,a3,1
    12fe:	00db0533          	add	a0,s6,a3
    1302:	85be                	mv	a1,a5
    1304:	974e                	add	a4,a4,s3
    1306:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    130a:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    130e:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    1312:	feb862e3          	bltu	a6,a1,12f6 <printf+0x1c0>
    if (sign)
    1316:	1208c063          	bltz	a7,1436 <printf+0x300>
    while (--i >= 0)
    131a:	9d5a                	add	s10,s10,s6
    put[0] = c;
    131c:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1320:	4605                	li	a2,1
    1322:	85a2                	mv	a1,s0
    1324:	4505                	li	a0,1
    put[0] = c;
    1326:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    132a:	161000ef          	jal	ra,1c8a <write>
    while (--i >= 0)
    132e:	87ea                	mv	a5,s10
    1330:	1d7d                	addi	s10,s10,-1
    1332:	fefb15e3          	bne	s6,a5,131c <printf+0x1e6>
    1336:	bf9d                	j	12ac <printf+0x176>
                printptr(va_arg(ap, uint64));
    1338:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    133a:	4605                	li	a2,1
    133c:	00001597          	auipc	a1,0x1
    1340:	b0458593          	addi	a1,a1,-1276 # 1e40 <put.1156>
                printptr(va_arg(ap, uint64));
    1344:	0007bd83          	ld	s11,0(a5)
    1348:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    134c:	4505                	li	a0,1
    put[0] = c;
    134e:	03000793          	li	a5,48
    1352:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    1356:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    1358:	133000ef          	jal	ra,1c8a <write>
    put[0] = c;
    135c:	07800793          	li	a5,120
    return write(stdout, put, 1);
    1360:	4605                	li	a2,1
    1362:	00001597          	auipc	a1,0x1
    1366:	ade58593          	addi	a1,a1,-1314 # 1e40 <put.1156>
    136a:	4505                	li	a0,1
    put[0] = c;
    136c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1370:	4d41                	li	s10,16
    1372:	119000ef          	jal	ra,1c8a <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    1376:	03cdd793          	srli	a5,s11,0x3c
    137a:	97ce                	add	a5,a5,s3
    put[0] = c;
    137c:	0007c783          	lbu	a5,0(a5)
    1380:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    1382:	4605                	li	a2,1
    1384:	85a2                	mv	a1,s0
    1386:	4505                	li	a0,1
    put[0] = c;
    1388:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    138c:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    138e:	0fd000ef          	jal	ra,1c8a <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1392:	fe0d12e3          	bnez	s10,1376 <printf+0x240>
    1396:	bf19                	j	12ac <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    1398:	67a2                	ld	a5,8(sp)
    139a:	4394                	lw	a3,0(a5)
    139c:	07a1                	addi	a5,a5,8
    139e:	e43e                	sd	a5,8(sp)
    13a0:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    13a4:	0006d663          	bgez	a3,13b0 <printf+0x27a>
        x = -xx;
    13a8:	40f007bb          	negw	a5,a5
    13ac:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    13b0:	4729                	li	a4,10
    13b2:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    13b6:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    13ba:	964e                	add	a2,a2,s3
    13bc:	00064603          	lbu	a2,0(a2)
    13c0:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    13c4:	0a0d0963          	beqz	s10,1476 <printf+0x340>
        buf[i++] = digits[x % base];
    13c8:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    13cc:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    13d0:	00c98733          	add	a4,s3,a2
    13d4:	00074703          	lbu	a4,0(a4)
    13d8:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    13dc:	c3cd                	beqz	a5,147e <printf+0x348>
        buf[i++] = digits[x % base];
    13de:	97ce                	add	a5,a5,s3
    13e0:	0007c703          	lbu	a4,0(a5)
    13e4:	4d09                	li	s10,2
    13e6:	478d                	li	a5,3
    13e8:	00e10923          	sb	a4,18(sp)
    if (sign)
    13ec:	0206cd63          	bltz	a3,1426 <printf+0x2f0>
    while (--i >= 0)
    13f0:	9d5a                	add	s10,s10,s6
    13f2:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    13f6:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    13fa:	4605                	li	a2,1
    13fc:	1d7d                	addi	s10,s10,-1
    13fe:	85a2                	mv	a1,s0
    1400:	4505                	li	a0,1
    put[0] = c;
    1402:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1406:	085000ef          	jal	ra,1c8a <write>
    while (--i >= 0)
    140a:	ffbd16e3          	bne	s10,s11,13f6 <printf+0x2c0>
    140e:	bd79                	j	12ac <printf+0x176>
    return write(stdout, put, 1);
    1410:	4605                	li	a2,1
    1412:	00001597          	auipc	a1,0x1
    1416:	a2e58593          	addi	a1,a1,-1490 # 1e40 <put.1156>
    141a:	4505                	li	a0,1
    put[0] = c;
    141c:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    1420:	06b000ef          	jal	ra,1c8a <write>
    1424:	b561                	j	12ac <printf+0x176>
        buf[i++] = '-';
    1426:	1818                	addi	a4,sp,48
    1428:	973e                	add	a4,a4,a5
    142a:	02d00693          	li	a3,45
    142e:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    1432:	8d3e                	mv	s10,a5
    1434:	bf75                	j	13f0 <printf+0x2ba>
        buf[i++] = '-';
    1436:	181c                	addi	a5,sp,48
    1438:	97b6                	add	a5,a5,a3
    143a:	02d00713          	li	a4,45
    143e:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    1442:	8d36                	mv	s10,a3
    1444:	bdd9                	j	131a <printf+0x1e4>
        x = -xx;
    1446:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    144a:	00f7f693          	andi	a3,a5,15
    144e:	96ce                	add	a3,a3,s3
    1450:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    1454:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    1458:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    145c:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1460:	d80d1be3          	bnez	s10,11f6 <printf+0xc0>
        buf[i++] = digits[x % base];
    1464:	4d05                	li	s10,1
    1466:	b34d                	j	1208 <printf+0xd2>
                s = "(null)";
    1468:	00001d17          	auipc	s10,0x1
    146c:	9a8d0d13          	addi	s10,s10,-1624 # 1e10 <sharedmem+0x34>
                for (; *s; s++)
    1470:	02800793          	li	a5,40
    1474:	bbe5                	j	126c <printf+0x136>
        buf[i++] = digits[x % base];
    1476:	4785                	li	a5,1
    if (sign)
    1478:	f606dce3          	bgez	a3,13f0 <printf+0x2ba>
    147c:	b76d                	j	1426 <printf+0x2f0>
        buf[i++] = digits[x % base];
    147e:	4789                	li	a5,2
    1480:	4d05                	li	s10,1
    if (sign)
    1482:	f606d7e3          	bgez	a3,13f0 <printf+0x2ba>
    1486:	b745                	j	1426 <printf+0x2f0>

0000000000001488 <srand>:
#include <ucore.h>

static uint64 seed;

void srand(unsigned s) {
    seed = s - 1;
    1488:	357d                	addiw	a0,a0,-1
    148a:	1502                	slli	a0,a0,0x20
    148c:	9101                	srli	a0,a0,0x20
    148e:	00001797          	auipc	a5,0x1
    1492:	9aa7bd23          	sd	a0,-1606(a5) # 1e48 <seed>
}
    1496:	8082                	ret

0000000000001498 <rand>:

int rand(void) {
    seed = 6364136223846793005ULL * seed + 1;
    1498:	00001797          	auipc	a5,0x1
    149c:	9b078793          	addi	a5,a5,-1616 # 1e48 <seed>
    14a0:	6388                	ld	a0,0(a5)
    14a2:	00001717          	auipc	a4,0x1
    14a6:	97e73703          	ld	a4,-1666(a4) # 1e20 <NUM+0x8>
    14aa:	02e50533          	mul	a0,a0,a4
    14ae:	0505                	addi	a0,a0,1
    14b0:	e388                	sd	a0,0(a5)
    return seed >> 33;
}
    14b2:	9105                	srli	a0,a0,0x21
    14b4:	8082                	ret

00000000000014b6 <panic>:

void panic(char* m) {
    14b6:	1141                	addi	sp,sp,-16
    14b8:	e406                	sd	ra,8(sp)
    puts(m);
    14ba:	c37ff0ef          	jal	ra,10f0 <puts>
    exit(-100);
}
    14be:	60a2                	ld	ra,8(sp)
    exit(-100);
    14c0:	f9c00513          	li	a0,-100
}
    14c4:	0141                	addi	sp,sp,16
    exit(-100);
    14c6:	af45                	j	1c76 <exit>

00000000000014c8 <assert>:

void assert(int f, int code) {
    if(!f) {
    14c8:	c111                	beqz	a0,14cc <assert+0x4>
        exit(code);
    }
    14ca:	8082                	ret
        exit(code);
    14cc:	852e                	mv	a0,a1
    14ce:	a765                	j	1c76 <exit>

00000000000014d0 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    14d0:	02000793          	li	a5,32
    14d4:	00f50663          	beq	a0,a5,14e0 <isspace+0x10>
    14d8:	355d                	addiw	a0,a0,-9
    14da:	00553513          	sltiu	a0,a0,5
    14de:	8082                	ret
    14e0:	4505                	li	a0,1
}
    14e2:	8082                	ret

00000000000014e4 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    14e4:	fd05051b          	addiw	a0,a0,-48
}
    14e8:	00a53513          	sltiu	a0,a0,10
    14ec:	8082                	ret

00000000000014ee <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    14ee:	02000613          	li	a2,32
    14f2:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    14f4:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    14f8:	ff77069b          	addiw	a3,a4,-9
    14fc:	04c70d63          	beq	a4,a2,1556 <atoi+0x68>
    1500:	0007079b          	sext.w	a5,a4
    1504:	04d5f963          	bgeu	a1,a3,1556 <atoi+0x68>
        s++;
    switch (*s) {
    1508:	02b00693          	li	a3,43
    150c:	04d70a63          	beq	a4,a3,1560 <atoi+0x72>
    1510:	02d00693          	li	a3,45
    1514:	06d70463          	beq	a4,a3,157c <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1518:	fd07859b          	addiw	a1,a5,-48
    151c:	4625                	li	a2,9
    151e:	873e                	mv	a4,a5
    1520:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1522:	4e01                	li	t3,0
    while (isdigit(*s))
    1524:	04b66a63          	bltu	a2,a1,1578 <atoi+0x8a>
    int n = 0, neg = 0;
    1528:	4501                	li	a0,0
    while (isdigit(*s))
    152a:	4825                	li	a6,9
    152c:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1530:	0025179b          	slliw	a5,a0,0x2
    1534:	9d3d                	addw	a0,a0,a5
    1536:	fd07031b          	addiw	t1,a4,-48
    153a:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    153e:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1542:	0685                	addi	a3,a3,1
    1544:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1548:	0006071b          	sext.w	a4,a2
    154c:	feb870e3          	bgeu	a6,a1,152c <atoi+0x3e>
    return neg ? n : -n;
    1550:	000e0563          	beqz	t3,155a <atoi+0x6c>
}
    1554:	8082                	ret
        s++;
    1556:	0505                	addi	a0,a0,1
    1558:	bf71                	j	14f4 <atoi+0x6>
    155a:	4113053b          	subw	a0,t1,a7
    155e:	8082                	ret
    while (isdigit(*s))
    1560:	00154783          	lbu	a5,1(a0)
    1564:	4625                	li	a2,9
        s++;
    1566:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    156a:	fd07859b          	addiw	a1,a5,-48
    156e:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1572:	4e01                	li	t3,0
    while (isdigit(*s))
    1574:	fab67ae3          	bgeu	a2,a1,1528 <atoi+0x3a>
    1578:	4501                	li	a0,0
}
    157a:	8082                	ret
    while (isdigit(*s))
    157c:	00154783          	lbu	a5,1(a0)
    1580:	4625                	li	a2,9
        s++;
    1582:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1586:	fd07859b          	addiw	a1,a5,-48
    158a:	0007871b          	sext.w	a4,a5
    158e:	feb665e3          	bltu	a2,a1,1578 <atoi+0x8a>
        neg = 1;
    1592:	4e05                	li	t3,1
    1594:	bf51                	j	1528 <atoi+0x3a>

0000000000001596 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    1596:	16060d63          	beqz	a2,1710 <memset+0x17a>
    159a:	40a007b3          	neg	a5,a0
    159e:	8b9d                	andi	a5,a5,7
    15a0:	00778713          	addi	a4,a5,7
    15a4:	482d                	li	a6,11
    15a6:	0ff5f593          	andi	a1,a1,255
    15aa:	fff60693          	addi	a3,a2,-1
    15ae:	17076263          	bltu	a4,a6,1712 <memset+0x17c>
    15b2:	16e6ea63          	bltu	a3,a4,1726 <memset+0x190>
    15b6:	16078563          	beqz	a5,1720 <memset+0x18a>
    15ba:	00b50023          	sb	a1,0(a0)
    15be:	4705                	li	a4,1
    15c0:	00150e93          	addi	t4,a0,1
    15c4:	14e78c63          	beq	a5,a4,171c <memset+0x186>
    15c8:	00b500a3          	sb	a1,1(a0)
    15cc:	4709                	li	a4,2
    15ce:	00250e93          	addi	t4,a0,2
    15d2:	14e78d63          	beq	a5,a4,172c <memset+0x196>
    15d6:	00b50123          	sb	a1,2(a0)
    15da:	470d                	li	a4,3
    15dc:	00350e93          	addi	t4,a0,3
    15e0:	12e78b63          	beq	a5,a4,1716 <memset+0x180>
    15e4:	00b501a3          	sb	a1,3(a0)
    15e8:	4711                	li	a4,4
    15ea:	00450e93          	addi	t4,a0,4
    15ee:	14e78163          	beq	a5,a4,1730 <memset+0x19a>
    15f2:	00b50223          	sb	a1,4(a0)
    15f6:	4715                	li	a4,5
    15f8:	00550e93          	addi	t4,a0,5
    15fc:	12e78c63          	beq	a5,a4,1734 <memset+0x19e>
    1600:	00b502a3          	sb	a1,5(a0)
    1604:	471d                	li	a4,7
    1606:	00650e93          	addi	t4,a0,6
    160a:	12e79763          	bne	a5,a4,1738 <memset+0x1a2>
    160e:	00750e93          	addi	t4,a0,7
    1612:	00b50323          	sb	a1,6(a0)
    1616:	4f1d                	li	t5,7
    1618:	00859713          	slli	a4,a1,0x8
    161c:	8f4d                	or	a4,a4,a1
    161e:	01059e13          	slli	t3,a1,0x10
    1622:	01c76e33          	or	t3,a4,t3
    1626:	01859313          	slli	t1,a1,0x18
    162a:	006e6333          	or	t1,t3,t1
    162e:	02059893          	slli	a7,a1,0x20
    1632:	011368b3          	or	a7,t1,a7
    1636:	02859813          	slli	a6,a1,0x28
    163a:	40f60333          	sub	t1,a2,a5
    163e:	0108e833          	or	a6,a7,a6
    1642:	03059693          	slli	a3,a1,0x30
    1646:	00d866b3          	or	a3,a6,a3
    164a:	03859713          	slli	a4,a1,0x38
    164e:	97aa                	add	a5,a5,a0
    1650:	ff837813          	andi	a6,t1,-8
    1654:	8f55                	or	a4,a4,a3
    1656:	00f806b3          	add	a3,a6,a5
    165a:	e398                	sd	a4,0(a5)
    165c:	07a1                	addi	a5,a5,8
    165e:	fed79ee3          	bne	a5,a3,165a <memset+0xc4>
    1662:	ff837693          	andi	a3,t1,-8
    1666:	00de87b3          	add	a5,t4,a3
    166a:	01e6873b          	addw	a4,a3,t5
    166e:	0ad30663          	beq	t1,a3,171a <memset+0x184>
    1672:	00b78023          	sb	a1,0(a5)
    1676:	0017069b          	addiw	a3,a4,1
    167a:	08c6fb63          	bgeu	a3,a2,1710 <memset+0x17a>
    167e:	00b780a3          	sb	a1,1(a5)
    1682:	0027069b          	addiw	a3,a4,2
    1686:	08c6f563          	bgeu	a3,a2,1710 <memset+0x17a>
    168a:	00b78123          	sb	a1,2(a5)
    168e:	0037069b          	addiw	a3,a4,3
    1692:	06c6ff63          	bgeu	a3,a2,1710 <memset+0x17a>
    1696:	00b781a3          	sb	a1,3(a5)
    169a:	0047069b          	addiw	a3,a4,4
    169e:	06c6f963          	bgeu	a3,a2,1710 <memset+0x17a>
    16a2:	00b78223          	sb	a1,4(a5)
    16a6:	0057069b          	addiw	a3,a4,5
    16aa:	06c6f363          	bgeu	a3,a2,1710 <memset+0x17a>
    16ae:	00b782a3          	sb	a1,5(a5)
    16b2:	0067069b          	addiw	a3,a4,6
    16b6:	04c6fd63          	bgeu	a3,a2,1710 <memset+0x17a>
    16ba:	00b78323          	sb	a1,6(a5)
    16be:	0077069b          	addiw	a3,a4,7
    16c2:	04c6f763          	bgeu	a3,a2,1710 <memset+0x17a>
    16c6:	00b783a3          	sb	a1,7(a5)
    16ca:	0087069b          	addiw	a3,a4,8
    16ce:	04c6f163          	bgeu	a3,a2,1710 <memset+0x17a>
    16d2:	00b78423          	sb	a1,8(a5)
    16d6:	0097069b          	addiw	a3,a4,9
    16da:	02c6fb63          	bgeu	a3,a2,1710 <memset+0x17a>
    16de:	00b784a3          	sb	a1,9(a5)
    16e2:	00a7069b          	addiw	a3,a4,10
    16e6:	02c6f563          	bgeu	a3,a2,1710 <memset+0x17a>
    16ea:	00b78523          	sb	a1,10(a5)
    16ee:	00b7069b          	addiw	a3,a4,11
    16f2:	00c6ff63          	bgeu	a3,a2,1710 <memset+0x17a>
    16f6:	00b785a3          	sb	a1,11(a5)
    16fa:	00c7069b          	addiw	a3,a4,12
    16fe:	00c6f963          	bgeu	a3,a2,1710 <memset+0x17a>
    1702:	00b78623          	sb	a1,12(a5)
    1706:	2735                	addiw	a4,a4,13
    1708:	00c77463          	bgeu	a4,a2,1710 <memset+0x17a>
    170c:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    1710:	8082                	ret
    1712:	472d                	li	a4,11
    1714:	bd79                	j	15b2 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1716:	4f0d                	li	t5,3
    1718:	b701                	j	1618 <memset+0x82>
    171a:	8082                	ret
    171c:	4f05                	li	t5,1
    171e:	bded                	j	1618 <memset+0x82>
    1720:	8eaa                	mv	t4,a0
    1722:	4f01                	li	t5,0
    1724:	bdd5                	j	1618 <memset+0x82>
    1726:	87aa                	mv	a5,a0
    1728:	4701                	li	a4,0
    172a:	b7a1                	j	1672 <memset+0xdc>
    172c:	4f09                	li	t5,2
    172e:	b5ed                	j	1618 <memset+0x82>
    1730:	4f11                	li	t5,4
    1732:	b5dd                	j	1618 <memset+0x82>
    1734:	4f15                	li	t5,5
    1736:	b5cd                	j	1618 <memset+0x82>
    1738:	4f19                	li	t5,6
    173a:	bdf9                	j	1618 <memset+0x82>

000000000000173c <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    173c:	00054783          	lbu	a5,0(a0)
    1740:	0005c703          	lbu	a4,0(a1)
    1744:	00e79863          	bne	a5,a4,1754 <strcmp+0x18>
    1748:	0505                	addi	a0,a0,1
    174a:	0585                	addi	a1,a1,1
    174c:	fbe5                	bnez	a5,173c <strcmp>
    174e:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    1750:	9d19                	subw	a0,a0,a4
    1752:	8082                	ret
    1754:	0007851b          	sext.w	a0,a5
    1758:	bfe5                	j	1750 <strcmp+0x14>

000000000000175a <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    175a:	87aa                	mv	a5,a0
    175c:	0005c703          	lbu	a4,0(a1)
    1760:	0785                	addi	a5,a5,1
    1762:	0585                	addi	a1,a1,1
    1764:	fee78fa3          	sb	a4,-1(a5)
    1768:	fb75                	bnez	a4,175c <strcpy+0x2>
        ;
    return os;
}
    176a:	8082                	ret

000000000000176c <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    176c:	ce05                	beqz	a2,17a4 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    176e:	00054703          	lbu	a4,0(a0)
    1772:	0005c783          	lbu	a5,0(a1)
    1776:	cb0d                	beqz	a4,17a8 <strncmp+0x3c>
    if (!n--)
    1778:	167d                	addi	a2,a2,-1
    177a:	00c506b3          	add	a3,a0,a2
    177e:	a819                	j	1794 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1780:	00a68e63          	beq	a3,a0,179c <strncmp+0x30>
    1784:	0505                	addi	a0,a0,1
    1786:	00e79b63          	bne	a5,a4,179c <strncmp+0x30>
    178a:	00054703          	lbu	a4,0(a0)
    178e:	0005c783          	lbu	a5,0(a1)
    1792:	cb19                	beqz	a4,17a8 <strncmp+0x3c>
    1794:	0005c783          	lbu	a5,0(a1)
    1798:	0585                	addi	a1,a1,1
    179a:	f3fd                	bnez	a5,1780 <strncmp+0x14>
        ;
    return *l - *r;
    179c:	0007051b          	sext.w	a0,a4
    17a0:	9d1d                	subw	a0,a0,a5
    17a2:	8082                	ret
        return 0;
    17a4:	4501                	li	a0,0
}
    17a6:	8082                	ret
    17a8:	4501                	li	a0,0
    return *l - *r;
    17aa:	9d1d                	subw	a0,a0,a5
    17ac:	8082                	ret

00000000000017ae <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    17ae:	00757793          	andi	a5,a0,7
    17b2:	cf89                	beqz	a5,17cc <strlen+0x1e>
    17b4:	87aa                	mv	a5,a0
    17b6:	a029                	j	17c0 <strlen+0x12>
    17b8:	0785                	addi	a5,a5,1
    17ba:	0077f713          	andi	a4,a5,7
    17be:	cb01                	beqz	a4,17ce <strlen+0x20>
        if (!*s)
    17c0:	0007c703          	lbu	a4,0(a5)
    17c4:	fb75                	bnez	a4,17b8 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    17c6:	40a78533          	sub	a0,a5,a0
}
    17ca:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    17cc:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    17ce:	6394                	ld	a3,0(a5)
    17d0:	00000597          	auipc	a1,0x0
    17d4:	6585b583          	ld	a1,1624(a1) # 1e28 <NUM+0x10>
    17d8:	00000617          	auipc	a2,0x0
    17dc:	65863603          	ld	a2,1624(a2) # 1e30 <NUM+0x18>
    17e0:	a019                	j	17e6 <strlen+0x38>
    17e2:	6794                	ld	a3,8(a5)
    17e4:	07a1                	addi	a5,a5,8
    17e6:	00b68733          	add	a4,a3,a1
    17ea:	fff6c693          	not	a3,a3
    17ee:	8f75                	and	a4,a4,a3
    17f0:	8f71                	and	a4,a4,a2
    17f2:	db65                	beqz	a4,17e2 <strlen+0x34>
    for (; *s; s++)
    17f4:	0007c703          	lbu	a4,0(a5)
    17f8:	d779                	beqz	a4,17c6 <strlen+0x18>
    17fa:	0017c703          	lbu	a4,1(a5)
    17fe:	0785                	addi	a5,a5,1
    1800:	d379                	beqz	a4,17c6 <strlen+0x18>
    1802:	0017c703          	lbu	a4,1(a5)
    1806:	0785                	addi	a5,a5,1
    1808:	fb6d                	bnez	a4,17fa <strlen+0x4c>
    180a:	bf75                	j	17c6 <strlen+0x18>

000000000000180c <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    180c:	00757713          	andi	a4,a0,7
{
    1810:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1812:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1816:	cb19                	beqz	a4,182c <memchr+0x20>
    1818:	ce25                	beqz	a2,1890 <memchr+0x84>
    181a:	0007c703          	lbu	a4,0(a5)
    181e:	04b70e63          	beq	a4,a1,187a <memchr+0x6e>
    1822:	0785                	addi	a5,a5,1
    1824:	0077f713          	andi	a4,a5,7
    1828:	167d                	addi	a2,a2,-1
    182a:	f77d                	bnez	a4,1818 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    182c:	4501                	li	a0,0
    if (n && *s != c) {
    182e:	c235                	beqz	a2,1892 <memchr+0x86>
    1830:	0007c703          	lbu	a4,0(a5)
    1834:	04b70363          	beq	a4,a1,187a <memchr+0x6e>
        size_t k = ONES * c;
    1838:	00000517          	auipc	a0,0x0
    183c:	60053503          	ld	a0,1536(a0) # 1e38 <NUM+0x20>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1840:	471d                	li	a4,7
        size_t k = ONES * c;
    1842:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1846:	02c77a63          	bgeu	a4,a2,187a <memchr+0x6e>
    184a:	00000897          	auipc	a7,0x0
    184e:	5de8b883          	ld	a7,1502(a7) # 1e28 <NUM+0x10>
    1852:	00000817          	auipc	a6,0x0
    1856:	5de83803          	ld	a6,1502(a6) # 1e30 <NUM+0x18>
    185a:	431d                	li	t1,7
    185c:	a029                	j	1866 <memchr+0x5a>
    185e:	1661                	addi	a2,a2,-8
    1860:	07a1                	addi	a5,a5,8
    1862:	02c37963          	bgeu	t1,a2,1894 <memchr+0x88>
    1866:	6398                	ld	a4,0(a5)
    1868:	8f29                	xor	a4,a4,a0
    186a:	011706b3          	add	a3,a4,a7
    186e:	fff74713          	not	a4,a4
    1872:	8f75                	and	a4,a4,a3
    1874:	01077733          	and	a4,a4,a6
    1878:	d37d                	beqz	a4,185e <memchr+0x52>
    187a:	853e                	mv	a0,a5
    187c:	97b2                	add	a5,a5,a2
    187e:	a021                	j	1886 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1880:	0505                	addi	a0,a0,1
    1882:	00f50763          	beq	a0,a5,1890 <memchr+0x84>
    1886:	00054703          	lbu	a4,0(a0)
    188a:	feb71be3          	bne	a4,a1,1880 <memchr+0x74>
    188e:	8082                	ret
    return n ? (void*)s : 0;
    1890:	4501                	li	a0,0
}
    1892:	8082                	ret
    return n ? (void*)s : 0;
    1894:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1896:	f275                	bnez	a2,187a <memchr+0x6e>
}
    1898:	8082                	ret

000000000000189a <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    189a:	1101                	addi	sp,sp,-32
    189c:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    189e:	862e                	mv	a2,a1
{
    18a0:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    18a2:	4581                	li	a1,0
{
    18a4:	e426                	sd	s1,8(sp)
    18a6:	ec06                	sd	ra,24(sp)
    18a8:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    18aa:	f63ff0ef          	jal	ra,180c <memchr>
    return p ? p - s : n;
    18ae:	c519                	beqz	a0,18bc <strnlen+0x22>
}
    18b0:	60e2                	ld	ra,24(sp)
    18b2:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    18b4:	8d05                	sub	a0,a0,s1
}
    18b6:	64a2                	ld	s1,8(sp)
    18b8:	6105                	addi	sp,sp,32
    18ba:	8082                	ret
    18bc:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    18be:	8522                	mv	a0,s0
}
    18c0:	6442                	ld	s0,16(sp)
    18c2:	64a2                	ld	s1,8(sp)
    18c4:	6105                	addi	sp,sp,32
    18c6:	8082                	ret

00000000000018c8 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    18c8:	00b547b3          	xor	a5,a0,a1
    18cc:	8b9d                	andi	a5,a5,7
    18ce:	eb95                	bnez	a5,1902 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    18d0:	0075f793          	andi	a5,a1,7
    18d4:	e7b1                	bnez	a5,1920 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    18d6:	6198                	ld	a4,0(a1)
    18d8:	00000617          	auipc	a2,0x0
    18dc:	55063603          	ld	a2,1360(a2) # 1e28 <NUM+0x10>
    18e0:	00000817          	auipc	a6,0x0
    18e4:	55083803          	ld	a6,1360(a6) # 1e30 <NUM+0x18>
    18e8:	a029                	j	18f2 <stpcpy+0x2a>
    18ea:	e118                	sd	a4,0(a0)
    18ec:	6598                	ld	a4,8(a1)
    18ee:	05a1                	addi	a1,a1,8
    18f0:	0521                	addi	a0,a0,8
    18f2:	00c707b3          	add	a5,a4,a2
    18f6:	fff74693          	not	a3,a4
    18fa:	8ff5                	and	a5,a5,a3
    18fc:	0107f7b3          	and	a5,a5,a6
    1900:	d7ed                	beqz	a5,18ea <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1902:	0005c783          	lbu	a5,0(a1)
    1906:	00f50023          	sb	a5,0(a0)
    190a:	c785                	beqz	a5,1932 <stpcpy+0x6a>
    190c:	0015c783          	lbu	a5,1(a1)
    1910:	0505                	addi	a0,a0,1
    1912:	0585                	addi	a1,a1,1
    1914:	00f50023          	sb	a5,0(a0)
    1918:	fbf5                	bnez	a5,190c <stpcpy+0x44>
        ;
    return d;
}
    191a:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    191c:	0505                	addi	a0,a0,1
    191e:	df45                	beqz	a4,18d6 <stpcpy+0xe>
            if (!(*d = *s))
    1920:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1924:	0585                	addi	a1,a1,1
    1926:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    192a:	00f50023          	sb	a5,0(a0)
    192e:	f7fd                	bnez	a5,191c <stpcpy+0x54>
}
    1930:	8082                	ret
    1932:	8082                	ret

0000000000001934 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1934:	00b547b3          	xor	a5,a0,a1
    1938:	8b9d                	andi	a5,a5,7
    193a:	1a079863          	bnez	a5,1aea <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    193e:	0075f793          	andi	a5,a1,7
    1942:	16078463          	beqz	a5,1aaa <stpncpy+0x176>
    1946:	ea01                	bnez	a2,1956 <stpncpy+0x22>
    1948:	a421                	j	1b50 <stpncpy+0x21c>
    194a:	167d                	addi	a2,a2,-1
    194c:	0505                	addi	a0,a0,1
    194e:	14070e63          	beqz	a4,1aaa <stpncpy+0x176>
    1952:	1a060863          	beqz	a2,1b02 <stpncpy+0x1ce>
    1956:	0005c783          	lbu	a5,0(a1)
    195a:	0585                	addi	a1,a1,1
    195c:	0075f713          	andi	a4,a1,7
    1960:	00f50023          	sb	a5,0(a0)
    1964:	f3fd                	bnez	a5,194a <stpncpy+0x16>
    1966:	4805                	li	a6,1
    1968:	1a061863          	bnez	a2,1b18 <stpncpy+0x1e4>
    196c:	40a007b3          	neg	a5,a0
    1970:	8b9d                	andi	a5,a5,7
    1972:	4681                	li	a3,0
    1974:	18061a63          	bnez	a2,1b08 <stpncpy+0x1d4>
    1978:	00778713          	addi	a4,a5,7
    197c:	45ad                	li	a1,11
    197e:	18b76363          	bltu	a4,a1,1b04 <stpncpy+0x1d0>
    1982:	1ae6eb63          	bltu	a3,a4,1b38 <stpncpy+0x204>
    1986:	1a078363          	beqz	a5,1b2c <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    198a:	00050023          	sb	zero,0(a0)
    198e:	4685                	li	a3,1
    1990:	00150713          	addi	a4,a0,1
    1994:	18d78f63          	beq	a5,a3,1b32 <stpncpy+0x1fe>
    1998:	000500a3          	sb	zero,1(a0)
    199c:	4689                	li	a3,2
    199e:	00250713          	addi	a4,a0,2
    19a2:	18d78e63          	beq	a5,a3,1b3e <stpncpy+0x20a>
    19a6:	00050123          	sb	zero,2(a0)
    19aa:	468d                	li	a3,3
    19ac:	00350713          	addi	a4,a0,3
    19b0:	16d78c63          	beq	a5,a3,1b28 <stpncpy+0x1f4>
    19b4:	000501a3          	sb	zero,3(a0)
    19b8:	4691                	li	a3,4
    19ba:	00450713          	addi	a4,a0,4
    19be:	18d78263          	beq	a5,a3,1b42 <stpncpy+0x20e>
    19c2:	00050223          	sb	zero,4(a0)
    19c6:	4695                	li	a3,5
    19c8:	00550713          	addi	a4,a0,5
    19cc:	16d78d63          	beq	a5,a3,1b46 <stpncpy+0x212>
    19d0:	000502a3          	sb	zero,5(a0)
    19d4:	469d                	li	a3,7
    19d6:	00650713          	addi	a4,a0,6
    19da:	16d79863          	bne	a5,a3,1b4a <stpncpy+0x216>
    19de:	00750713          	addi	a4,a0,7
    19e2:	00050323          	sb	zero,6(a0)
    19e6:	40f80833          	sub	a6,a6,a5
    19ea:	ff887593          	andi	a1,a6,-8
    19ee:	97aa                	add	a5,a5,a0
    19f0:	95be                	add	a1,a1,a5
    19f2:	0007b023          	sd	zero,0(a5)
    19f6:	07a1                	addi	a5,a5,8
    19f8:	feb79de3          	bne	a5,a1,19f2 <stpncpy+0xbe>
    19fc:	ff887593          	andi	a1,a6,-8
    1a00:	9ead                	addw	a3,a3,a1
    1a02:	00b707b3          	add	a5,a4,a1
    1a06:	12b80863          	beq	a6,a1,1b36 <stpncpy+0x202>
    1a0a:	00078023          	sb	zero,0(a5)
    1a0e:	0016871b          	addiw	a4,a3,1
    1a12:	0ec77863          	bgeu	a4,a2,1b02 <stpncpy+0x1ce>
    1a16:	000780a3          	sb	zero,1(a5)
    1a1a:	0026871b          	addiw	a4,a3,2
    1a1e:	0ec77263          	bgeu	a4,a2,1b02 <stpncpy+0x1ce>
    1a22:	00078123          	sb	zero,2(a5)
    1a26:	0036871b          	addiw	a4,a3,3
    1a2a:	0cc77c63          	bgeu	a4,a2,1b02 <stpncpy+0x1ce>
    1a2e:	000781a3          	sb	zero,3(a5)
    1a32:	0046871b          	addiw	a4,a3,4
    1a36:	0cc77663          	bgeu	a4,a2,1b02 <stpncpy+0x1ce>
    1a3a:	00078223          	sb	zero,4(a5)
    1a3e:	0056871b          	addiw	a4,a3,5
    1a42:	0cc77063          	bgeu	a4,a2,1b02 <stpncpy+0x1ce>
    1a46:	000782a3          	sb	zero,5(a5)
    1a4a:	0066871b          	addiw	a4,a3,6
    1a4e:	0ac77a63          	bgeu	a4,a2,1b02 <stpncpy+0x1ce>
    1a52:	00078323          	sb	zero,6(a5)
    1a56:	0076871b          	addiw	a4,a3,7
    1a5a:	0ac77463          	bgeu	a4,a2,1b02 <stpncpy+0x1ce>
    1a5e:	000783a3          	sb	zero,7(a5)
    1a62:	0086871b          	addiw	a4,a3,8
    1a66:	08c77e63          	bgeu	a4,a2,1b02 <stpncpy+0x1ce>
    1a6a:	00078423          	sb	zero,8(a5)
    1a6e:	0096871b          	addiw	a4,a3,9
    1a72:	08c77863          	bgeu	a4,a2,1b02 <stpncpy+0x1ce>
    1a76:	000784a3          	sb	zero,9(a5)
    1a7a:	00a6871b          	addiw	a4,a3,10
    1a7e:	08c77263          	bgeu	a4,a2,1b02 <stpncpy+0x1ce>
    1a82:	00078523          	sb	zero,10(a5)
    1a86:	00b6871b          	addiw	a4,a3,11
    1a8a:	06c77c63          	bgeu	a4,a2,1b02 <stpncpy+0x1ce>
    1a8e:	000785a3          	sb	zero,11(a5)
    1a92:	00c6871b          	addiw	a4,a3,12
    1a96:	06c77663          	bgeu	a4,a2,1b02 <stpncpy+0x1ce>
    1a9a:	00078623          	sb	zero,12(a5)
    1a9e:	26b5                	addiw	a3,a3,13
    1aa0:	06c6f163          	bgeu	a3,a2,1b02 <stpncpy+0x1ce>
    1aa4:	000786a3          	sb	zero,13(a5)
    1aa8:	8082                	ret
            ;
        if (!n || !*s)
    1aaa:	c645                	beqz	a2,1b52 <stpncpy+0x21e>
    1aac:	0005c783          	lbu	a5,0(a1)
    1ab0:	ea078be3          	beqz	a5,1966 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1ab4:	479d                	li	a5,7
    1ab6:	02c7ff63          	bgeu	a5,a2,1af4 <stpncpy+0x1c0>
    1aba:	00000897          	auipc	a7,0x0
    1abe:	36e8b883          	ld	a7,878(a7) # 1e28 <NUM+0x10>
    1ac2:	00000817          	auipc	a6,0x0
    1ac6:	36e83803          	ld	a6,878(a6) # 1e30 <NUM+0x18>
    1aca:	431d                	li	t1,7
    1acc:	6198                	ld	a4,0(a1)
    1ace:	011707b3          	add	a5,a4,a7
    1ad2:	fff74693          	not	a3,a4
    1ad6:	8ff5                	and	a5,a5,a3
    1ad8:	0107f7b3          	and	a5,a5,a6
    1adc:	ef81                	bnez	a5,1af4 <stpncpy+0x1c0>
            *wd = *ws;
    1ade:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1ae0:	1661                	addi	a2,a2,-8
    1ae2:	05a1                	addi	a1,a1,8
    1ae4:	0521                	addi	a0,a0,8
    1ae6:	fec363e3          	bltu	t1,a2,1acc <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1aea:	e609                	bnez	a2,1af4 <stpncpy+0x1c0>
    1aec:	a08d                	j	1b4e <stpncpy+0x21a>
    1aee:	167d                	addi	a2,a2,-1
    1af0:	0505                	addi	a0,a0,1
    1af2:	ca01                	beqz	a2,1b02 <stpncpy+0x1ce>
    1af4:	0005c783          	lbu	a5,0(a1)
    1af8:	0585                	addi	a1,a1,1
    1afa:	00f50023          	sb	a5,0(a0)
    1afe:	fbe5                	bnez	a5,1aee <stpncpy+0x1ba>
        ;
tail:
    1b00:	b59d                	j	1966 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1b02:	8082                	ret
    1b04:	472d                	li	a4,11
    1b06:	bdb5                	j	1982 <stpncpy+0x4e>
    1b08:	00778713          	addi	a4,a5,7
    1b0c:	45ad                	li	a1,11
    1b0e:	fff60693          	addi	a3,a2,-1
    1b12:	e6b778e3          	bgeu	a4,a1,1982 <stpncpy+0x4e>
    1b16:	b7fd                	j	1b04 <stpncpy+0x1d0>
    1b18:	40a007b3          	neg	a5,a0
    1b1c:	8832                	mv	a6,a2
    1b1e:	8b9d                	andi	a5,a5,7
    1b20:	4681                	li	a3,0
    1b22:	e4060be3          	beqz	a2,1978 <stpncpy+0x44>
    1b26:	b7cd                	j	1b08 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1b28:	468d                	li	a3,3
    1b2a:	bd75                	j	19e6 <stpncpy+0xb2>
    1b2c:	872a                	mv	a4,a0
    1b2e:	4681                	li	a3,0
    1b30:	bd5d                	j	19e6 <stpncpy+0xb2>
    1b32:	4685                	li	a3,1
    1b34:	bd4d                	j	19e6 <stpncpy+0xb2>
    1b36:	8082                	ret
    1b38:	87aa                	mv	a5,a0
    1b3a:	4681                	li	a3,0
    1b3c:	b5f9                	j	1a0a <stpncpy+0xd6>
    1b3e:	4689                	li	a3,2
    1b40:	b55d                	j	19e6 <stpncpy+0xb2>
    1b42:	4691                	li	a3,4
    1b44:	b54d                	j	19e6 <stpncpy+0xb2>
    1b46:	4695                	li	a3,5
    1b48:	bd79                	j	19e6 <stpncpy+0xb2>
    1b4a:	4699                	li	a3,6
    1b4c:	bd69                	j	19e6 <stpncpy+0xb2>
    1b4e:	8082                	ret
    1b50:	8082                	ret
    1b52:	8082                	ret

0000000000001b54 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1b54:	fff6071b          	addiw	a4,a2,-1
    1b58:	0cb57063          	bgeu	a0,a1,1c18 <memmove+0xc4>
        while (n-- > 0)
    1b5c:	0ec05063          	blez	a2,1c3c <memmove+0xe8>
    1b60:	00750693          	addi	a3,a0,7
    1b64:	8e8d                	sub	a3,a3,a1
    1b66:	00b567b3          	or	a5,a0,a1
    1b6a:	00f6b693          	sltiu	a3,a3,15
    1b6e:	8b9d                	andi	a5,a5,7
    1b70:	0016c693          	xori	a3,a3,1
    1b74:	0017b793          	seqz	a5,a5
    1b78:	8ff5                	and	a5,a5,a3
    1b7a:	c3f1                	beqz	a5,1c3e <memmove+0xea>
    1b7c:	0007079b          	sext.w	a5,a4
    1b80:	46a5                	li	a3,9
    1b82:	0af6fe63          	bgeu	a3,a5,1c3e <memmove+0xea>
    1b86:	0036589b          	srliw	a7,a2,0x3
    1b8a:	088e                	slli	a7,a7,0x3
    1b8c:	2601                	sext.w	a2,a2
    1b8e:	87ae                	mv	a5,a1
    1b90:	86aa                	mv	a3,a0
    1b92:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1b94:	0007b803          	ld	a6,0(a5)
    1b98:	07a1                	addi	a5,a5,8
    1b9a:	06a1                	addi	a3,a3,8
    1b9c:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1ba0:	ff179ae3          	bne	a5,a7,1b94 <memmove+0x40>
    1ba4:	ff867813          	andi	a6,a2,-8
    1ba8:	02081793          	slli	a5,a6,0x20
    1bac:	9381                	srli	a5,a5,0x20
    1bae:	00f506b3          	add	a3,a0,a5
    1bb2:	95be                	add	a1,a1,a5
    1bb4:	4107073b          	subw	a4,a4,a6
    1bb8:	09060263          	beq	a2,a6,1c3c <memmove+0xe8>
            *dst++ = *src++;
    1bbc:	0005c783          	lbu	a5,0(a1)
    1bc0:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1bc4:	06e05c63          	blez	a4,1c3c <memmove+0xe8>
            *dst++ = *src++;
    1bc8:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1bcc:	4785                	li	a5,1
            *dst++ = *src++;
    1bce:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1bd2:	06e7d563          	bge	a5,a4,1c3c <memmove+0xe8>
            *dst++ = *src++;
    1bd6:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1bda:	4789                	li	a5,2
            *dst++ = *src++;
    1bdc:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1be0:	04e7de63          	bge	a5,a4,1c3c <memmove+0xe8>
            *dst++ = *src++;
    1be4:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1be8:	478d                	li	a5,3
            *dst++ = *src++;
    1bea:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1bee:	04e7d763          	bge	a5,a4,1c3c <memmove+0xe8>
            *dst++ = *src++;
    1bf2:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1bf6:	4791                	li	a5,4
            *dst++ = *src++;
    1bf8:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1bfc:	04e7d063          	bge	a5,a4,1c3c <memmove+0xe8>
            *dst++ = *src++;
    1c00:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1c04:	4795                	li	a5,5
            *dst++ = *src++;
    1c06:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1c0a:	02e7d963          	bge	a5,a4,1c3c <memmove+0xe8>
            *dst++ = *src++;
    1c0e:	0065c783          	lbu	a5,6(a1)
    1c12:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1c16:	8082                	ret
    } else {
        dst += n;
    1c18:	00c507b3          	add	a5,a0,a2
        src += n;
    1c1c:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1c1e:	00c05f63          	blez	a2,1c3c <memmove+0xe8>
    1c22:	1702                	slli	a4,a4,0x20
    1c24:	9301                	srli	a4,a4,0x20
    1c26:	fff74713          	not	a4,a4
    1c2a:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1c2c:	fff5c683          	lbu	a3,-1(a1)
    1c30:	17fd                	addi	a5,a5,-1
    1c32:	15fd                	addi	a1,a1,-1
    1c34:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1c38:	fee79ae3          	bne	a5,a4,1c2c <memmove+0xd8>
    }
    return vdst;
}
    1c3c:	8082                	ret
    1c3e:	02071693          	slli	a3,a4,0x20
    1c42:	9281                	srli	a3,a3,0x20
    1c44:	0685                	addi	a3,a3,1
    1c46:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1c48:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1c4a:	0005c703          	lbu	a4,0(a1)
    1c4e:	0585                	addi	a1,a1,1
    1c50:	0785                	addi	a5,a5,1
    1c52:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1c56:	fed59ae3          	bne	a1,a3,1c4a <memmove+0xf6>
    1c5a:	8082                	ret

0000000000001c5c <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1c5c:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c60:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1c64:	2501                	sext.w	a0,a0
    1c66:	8082                	ret

0000000000001c68 <exec>:
    register long a7 __asm__("a7") = n;
    1c68:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1c6c:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c6e:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1c72:	2501                	sext.w	a0,a0
    1c74:	8082                	ret

0000000000001c76 <exit>:
    register long a7 __asm__("a7") = n;
    1c76:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1c7a:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1c7e:	8082                	ret

0000000000001c80 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1c80:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c84:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1c88:	8082                	ret

0000000000001c8a <write>:
    register long a7 __asm__("a7") = n;
    1c8a:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c8e:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1c92:	8082                	ret

0000000000001c94 <getpid>:
    register long a7 __asm__("a7") = n;
    1c94:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c98:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c9c:	2501                	sext.w	a0,a0
    1c9e:	8082                	ret

0000000000001ca0 <getppid>:
    register long a7 __asm__("a7") = n;
    1ca0:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1ca4:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1ca8:	2501                	sext.w	a0,a0
    1caa:	8082                	ret

0000000000001cac <open>:
    register long a7 __asm__("a7") = n;
    1cac:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cb0:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1cb4:	2501                	sext.w	a0,a0
    1cb6:	8082                	ret

0000000000001cb8 <mknod>:
    register long a7 __asm__("a7") = n;
    1cb8:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cbc:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1cc0:	2501                	sext.w	a0,a0
    1cc2:	8082                	ret

0000000000001cc4 <dup>:
    register long a7 __asm__("a7") = n;
    1cc4:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1cc6:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1cca:	2501                	sext.w	a0,a0
    1ccc:	8082                	ret

0000000000001cce <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cce:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cd2:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cd6:	2501                	sext.w	a0,a0
    1cd8:	8082                	ret

0000000000001cda <waitpid>:
    register long a7 __asm__("a7") = n;
    1cda:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cde:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1ce2:	2501                	sext.w	a0,a0
    1ce4:	8082                	ret

0000000000001ce6 <wait>:

pid_t wait(int *wstatus)
{
    1ce6:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1ce8:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1cec:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cee:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1cf2:	2501                	sext.w	a0,a0
    1cf4:	8082                	ret

0000000000001cf6 <mkdir>:
    register long a7 __asm__("a7") = n;
    1cf6:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1cfa:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1cfe:	2501                	sext.w	a0,a0
    1d00:	8082                	ret

0000000000001d02 <close>:
    register long a7 __asm__("a7") = n;
    1d02:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1d06:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1d0a:	2501                	sext.w	a0,a0
    1d0c:	8082                	ret

0000000000001d0e <fork>:
    register long a7 __asm__("a7") = n;
    1d0e:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1d12:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1d16:	2501                	sext.w	a0,a0
    1d18:	8082                	ret

0000000000001d1a <time_ms>:
    register long a7 __asm__("a7") = n;
    1d1a:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d1e:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1d22:	8082                	ret

0000000000001d24 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1d24:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1d26:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d2a:	00000073          	ecall
    1d2e:	87aa                	mv	a5,a0
    1d30:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1d34:	97ba                	add	a5,a5,a4
    1d36:	00f57c63          	bgeu	a0,a5,1d4e <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1d3a:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1d3e:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d42:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d46:	00000073          	ecall
    1d4a:	fef568e3          	bltu	a0,a5,1d3a <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1d4e:	4501                	li	a0,0
    1d50:	8082                	ret

0000000000001d52 <pipe>:
    register long a7 __asm__("a7") = n;
    1d52:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1d56:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1d5a:	2501                	sext.w	a0,a0
    1d5c:	8082                	ret

0000000000001d5e <fstat>:
    register long a7 __asm__("a7") = n;
    1d5e:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d62:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1d66:	2501                	sext.w	a0,a0
    1d68:	8082                	ret

0000000000001d6a <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1d6a:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1d6c:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1d70:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d72:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1d76:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1d7a:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1d7e:	0206c163          	bltz	a3,1da0 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1d82:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1d86:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1d88:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d8a:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d8e:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1d92:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1d96:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1d98:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1d9c:	853e                	mv	a0,a5
    1d9e:	8082                	ret
        return -1;
    1da0:	57fd                	li	a5,-1
    1da2:	bfed                	j	1d9c <stat+0x32>

0000000000001da4 <chdir>:
    register long a7 __asm__("a7") = n;
    1da4:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1da8:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1dac:	2501                	sext.w	a0,a0
    1dae:	8082                	ret

0000000000001db0 <link>:
    register long a7 __asm__("a7") = n;
    1db0:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1db4:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1db8:	2501                	sext.w	a0,a0
    1dba:	8082                	ret

0000000000001dbc <unlink>:
    register long a7 __asm__("a7") = n;
    1dbc:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1dc0:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1dc4:	2501                	sext.w	a0,a0
    1dc6:	8082                	ret

0000000000001dc8 <setpriority>:
    register long a7 __asm__("a7") = n;
    1dc8:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1dcc:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1dd0:	8082                	ret

0000000000001dd2 <getpriority>:
    register long a7 __asm__("a7") = n;
    1dd2:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1dd6:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1dda:	8082                	ret

0000000000001ddc <sharedmem>:
    register long a7 __asm__("a7") = n;
    1ddc:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1de0:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1de4:	8082                	ret
