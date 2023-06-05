
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_forktest0:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a869                	j	109a <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <stdio.h>
#include <ucore.h>
#include <stdlib.h>

int main() {
    1002:	1101                	addi	sp,sp,-32
    assert(wait( NULL) < 0, -1);
    1004:	4501                	li	a0,0
int main() {
    1006:	ec06                	sd	ra,24(sp)
    1008:	e822                	sd	s0,16(sp)
    assert(wait( NULL) < 0, -1);
    100a:	4d7000ef          	jal	ra,1ce0 <wait>
    100e:	55fd                	li	a1,-1
    1010:	01f5551b          	srliw	a0,a0,0x1f
    1014:	4ae000ef          	jal	ra,14c2 <assert>
    printf("sys_wait without child process test passed!\n");
    1018:	00001517          	auipc	a0,0x1
    101c:	dc850513          	addi	a0,a0,-568 # 1de0 <sharedmem+0xa>
    1020:	110000ef          	jal	ra,1130 <printf>
    printf("parent start, pid = %d!\n", getpid());
    1024:	46b000ef          	jal	ra,1c8e <getpid>
    1028:	85aa                	mv	a1,a0
    102a:	00001517          	auipc	a0,0x1
    102e:	de650513          	addi	a0,a0,-538 # 1e10 <sharedmem+0x3a>
    1032:	0fe000ef          	jal	ra,1130 <printf>
    int pid = fork();
    1036:	4d3000ef          	jal	ra,1d08 <fork>
    if(pid == 0) {
    103a:	c539                	beqz	a0,1088 <main+0x86>
        // child process
        printf("hello child process!\n");
        return 100;
    } else {
        // parent process
        int xstate = 0;
    103c:	842a                	mv	s0,a0
        printf("ready waiting on parent process!\n");
    103e:	00001517          	auipc	a0,0x1
    1042:	e0a50513          	addi	a0,a0,-502 # 1e48 <sharedmem+0x72>
        int xstate = 0;
    1046:	c602                	sw	zero,12(sp)
        printf("ready waiting on parent process!\n");
    1048:	0e8000ef          	jal	ra,1130 <printf>
        assert(pid == wait( &xstate), -2);
    104c:	0068                	addi	a0,sp,12
    104e:	493000ef          	jal	ra,1ce0 <wait>
    1052:	8d01                	sub	a0,a0,s0
    1054:	55f9                	li	a1,-2
    1056:	00153513          	seqz	a0,a0
    105a:	468000ef          	jal	ra,14c2 <assert>
        assert(xstate == 100, -3);
    105e:	4532                	lw	a0,12(sp)
    1060:	55f5                	li	a1,-3
    1062:	f9c50513          	addi	a0,a0,-100
    1066:	00153513          	seqz	a0,a0
    106a:	458000ef          	jal	ra,14c2 <assert>
        printf("child process pid = %d, exit code = %d\n", pid, xstate);
    106e:	4632                	lw	a2,12(sp)
    1070:	00001517          	auipc	a0,0x1
    1074:	e0050513          	addi	a0,a0,-512 # 1e70 <sharedmem+0x9a>
    1078:	85a2                	mv	a1,s0
    107a:	0b6000ef          	jal	ra,1130 <printf>
    }
    return 0;
    107e:	4501                	li	a0,0
    1080:	60e2                	ld	ra,24(sp)
    1082:	6442                	ld	s0,16(sp)
    1084:	6105                	addi	sp,sp,32
    1086:	8082                	ret
        printf("hello child process!\n");
    1088:	00001517          	auipc	a0,0x1
    108c:	da850513          	addi	a0,a0,-600 # 1e30 <sharedmem+0x5a>
    1090:	0a0000ef          	jal	ra,1130 <printf>
        return 100;
    1094:	06400513          	li	a0,100
    1098:	b7e5                	j	1080 <main+0x7e>

000000000000109a <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    109a:	1141                	addi	sp,sp,-16
    109c:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    109e:	f65ff0ef          	jal	ra,1002 <main>
}
    10a2:	60a2                	ld	ra,8(sp)
    10a4:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    10a6:	3cb0006f          	j	1c70 <exit>

00000000000010aa <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    10aa:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    10ac:	00f10593          	addi	a1,sp,15
    10b0:	4605                	li	a2,1
    10b2:	4501                	li	a0,0
int getchar() {
    10b4:	ec06                	sd	ra,24(sp)
    char byte = 0;
    10b6:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    10ba:	3c1000ef          	jal	ra,1c7a <read>
    return byte;
}
    10be:	60e2                	ld	ra,24(sp)
    10c0:	00f14503          	lbu	a0,15(sp)
    10c4:	6105                	addi	sp,sp,32
    10c6:	8082                	ret

00000000000010c8 <putchar>:

int putchar(int c)
{
    10c8:	1141                	addi	sp,sp,-16
    10ca:	e406                	sd	ra,8(sp)
    10cc:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    10ce:	00001597          	auipc	a1,0x1
    10d2:	df258593          	addi	a1,a1,-526 # 1ec0 <put.1156>
    return write(stdout, put, 1);
    10d6:	4605                	li	a2,1
    10d8:	4505                	li	a0,1
    put[0] = c;
    10da:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    10de:	3a7000ef          	jal	ra,1c84 <write>
}
    10e2:	60a2                	ld	ra,8(sp)
    10e4:	2501                	sext.w	a0,a0
    10e6:	0141                	addi	sp,sp,16
    10e8:	8082                	ret

00000000000010ea <puts>:

int puts(const char* s)
{
    10ea:	1141                	addi	sp,sp,-16
    10ec:	e022                	sd	s0,0(sp)
    10ee:	e406                	sd	ra,8(sp)
    10f0:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    10f2:	6b6000ef          	jal	ra,17a8 <strlen>
    10f6:	862a                	mv	a2,a0
    10f8:	85a2                	mv	a1,s0
    10fa:	4505                	li	a0,1
    10fc:	389000ef          	jal	ra,1c84 <write>
    1100:	00055763          	bgez	a0,110e <puts+0x24>
    return r;
}
    1104:	60a2                	ld	ra,8(sp)
    1106:	6402                	ld	s0,0(sp)
    1108:	557d                	li	a0,-1
    110a:	0141                	addi	sp,sp,16
    110c:	8082                	ret
    put[0] = c;
    110e:	00001597          	auipc	a1,0x1
    1112:	db258593          	addi	a1,a1,-590 # 1ec0 <put.1156>
    1116:	47a9                	li	a5,10
    return write(stdout, put, 1);
    1118:	4605                	li	a2,1
    111a:	4505                	li	a0,1
    put[0] = c;
    111c:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1120:	365000ef          	jal	ra,1c84 <write>
}
    1124:	60a2                	ld	ra,8(sp)
    1126:	6402                	ld	s0,0(sp)
    1128:	41f5551b          	sraiw	a0,a0,0x1f
    112c:	0141                	addi	sp,sp,16
    112e:	8082                	ret

0000000000001130 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    1130:	7115                	addi	sp,sp,-224
    1132:	ed06                	sd	ra,152(sp)
    1134:	e922                	sd	s0,144(sp)
    1136:	e526                	sd	s1,136(sp)
    1138:	e14a                	sd	s2,128(sp)
    113a:	fcce                	sd	s3,120(sp)
    113c:	f8d2                	sd	s4,112(sp)
    113e:	f4d6                	sd	s5,104(sp)
    1140:	f0da                	sd	s6,96(sp)
    1142:	ecde                	sd	s7,88(sp)
    1144:	e8e2                	sd	s8,80(sp)
    1146:	e4e6                	sd	s9,72(sp)
    1148:	e0ea                	sd	s10,64(sp)
    114a:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    114c:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    1150:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    1152:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    1154:	f52e                	sd	a1,168(sp)
    1156:	f932                	sd	a2,176(sp)
    1158:	fd36                	sd	a3,184(sp)
    115a:	e1ba                	sd	a4,192(sp)
    115c:	e9c2                	sd	a6,208(sp)
    115e:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    1160:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1162:	0c030b63          	beqz	t1,1238 <printf+0x108>
    1166:	8aaa                	mv	s5,a0
    1168:	0003071b          	sext.w	a4,t1
    116c:	4481                	li	s1,0
        if (c != '%') {
    116e:	02500b93          	li	s7,37
    put[0] = c;
    1172:	00001417          	auipc	s0,0x1
    1176:	d4e40413          	addi	s0,s0,-690 # 1ec0 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    117a:	4c51                	li	s8,20
    put[0] = c;
    117c:	02500c93          	li	s9,37
    1180:	00001a17          	auipc	s4,0x1
    1184:	d50a0a13          	addi	s4,s4,-688 # 1ed0 <seed+0x8>
    1188:	00001997          	auipc	s3,0x1
    118c:	da098993          	addi	s3,s3,-608 # 1f28 <digits>
    1190:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    1194:	0014879b          	addiw	a5,s1,1
    1198:	00fa8933          	add	s2,s5,a5
    119c:	13771163          	bne	a4,s7,12be <printf+0x18e>
        c = fmt[++i] & 0xff;
    11a0:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    11a4:	080d0a63          	beqz	s10,1238 <printf+0x108>
        switch (c) {
    11a8:	2489                	addiw	s1,s1,2
    11aa:	009a8933          	add	s2,s5,s1
    11ae:	257d0e63          	beq	s10,s7,140a <printf+0x2da>
    11b2:	f9cd079b          	addiw	a5,s10,-100
    11b6:	0ff7f793          	andi	a5,a5,255
    11ba:	0cfc6263          	bltu	s8,a5,127e <printf+0x14e>
    11be:	078a                	slli	a5,a5,0x2
    11c0:	97d2                	add	a5,a5,s4
    11c2:	439c                	lw	a5,0(a5)
    11c4:	97d2                	add	a5,a5,s4
    11c6:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    11c8:	67a2                	ld	a5,8(sp)
    11ca:	4398                	lw	a4,0(a5)
    11cc:	07a1                	addi	a5,a5,8
    11ce:	e43e                	sd	a5,8(sp)
    11d0:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    11d4:	26074663          	bltz	a4,1440 <printf+0x310>
        buf[i++] = digits[x % base];
    11d8:	8bbd                	andi	a5,a5,15
    11da:	97ce                	add	a5,a5,s3
    11dc:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    11e0:	40475d1b          	sraiw	s10,a4,0x4
    11e4:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    11e8:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    11ec:	020d0163          	beqz	s10,120e <printf+0xde>
        buf[i++] = digits[x % base];
    11f0:	9d4e                	add	s10,s10,s3
    11f2:	000d4783          	lbu	a5,0(s10)
    11f6:	4d05                	li	s10,1
    11f8:	00f108a3          	sb	a5,17(sp)
    if (sign)
    11fc:	00075963          	bgez	a4,120e <printf+0xde>
        buf[i++] = digits[x % base];
    1200:	4d09                	li	s10,2
        buf[i++] = '-';
    1202:	181c                	addi	a5,sp,48
    1204:	02d00713          	li	a4,45
    1208:	97ea                	add	a5,a5,s10
    120a:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    120e:	9d5a                	add	s10,s10,s6
    1210:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1214:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1218:	4605                	li	a2,1
    121a:	1d7d                	addi	s10,s10,-1
    121c:	85a2                	mv	a1,s0
    121e:	4505                	li	a0,1
    put[0] = c;
    1220:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1224:	261000ef          	jal	ra,1c84 <write>
    while (--i >= 0)
    1228:	ffbd16e3          	bne	s10,s11,1214 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    122c:	00094303          	lbu	t1,0(s2)
    1230:	0003071b          	sext.w	a4,t1
    1234:	f60310e3          	bnez	t1,1194 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    1238:	60ea                	ld	ra,152(sp)
    123a:	644a                	ld	s0,144(sp)
    123c:	64aa                	ld	s1,136(sp)
    123e:	690a                	ld	s2,128(sp)
    1240:	79e6                	ld	s3,120(sp)
    1242:	7a46                	ld	s4,112(sp)
    1244:	7aa6                	ld	s5,104(sp)
    1246:	7b06                	ld	s6,96(sp)
    1248:	6be6                	ld	s7,88(sp)
    124a:	6c46                	ld	s8,80(sp)
    124c:	6ca6                	ld	s9,72(sp)
    124e:	6d06                	ld	s10,64(sp)
    1250:	7de2                	ld	s11,56(sp)
    1252:	612d                	addi	sp,sp,224
    1254:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    1256:	67a2                	ld	a5,8(sp)
    1258:	0007bd03          	ld	s10,0(a5)
    125c:	07a1                	addi	a5,a5,8
    125e:	e43e                	sd	a5,8(sp)
    1260:	000d1b63          	bnez	s10,1276 <printf+0x146>
    1264:	aafd                	j	1462 <printf+0x332>
    return write(stdout, put, 1);
    1266:	4605                	li	a2,1
    1268:	85a2                	mv	a1,s0
    126a:	4505                	li	a0,1
                for (; *s; s++)
    126c:	0d05                	addi	s10,s10,1
    put[0] = c;
    126e:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1272:	213000ef          	jal	ra,1c84 <write>
                for (; *s; s++)
    1276:	000d4783          	lbu	a5,0(s10)
    127a:	f7f5                	bnez	a5,1266 <printf+0x136>
    127c:	a02d                	j	12a6 <printf+0x176>
    return write(stdout, put, 1);
    127e:	4605                	li	a2,1
    1280:	00001597          	auipc	a1,0x1
    1284:	c4058593          	addi	a1,a1,-960 # 1ec0 <put.1156>
    1288:	4505                	li	a0,1
    put[0] = c;
    128a:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    128e:	1f7000ef          	jal	ra,1c84 <write>
    1292:	4605                	li	a2,1
    1294:	00001597          	auipc	a1,0x1
    1298:	c2c58593          	addi	a1,a1,-980 # 1ec0 <put.1156>
    129c:	4505                	li	a0,1
    put[0] = c;
    129e:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    12a2:	1e3000ef          	jal	ra,1c84 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    12a6:	00094303          	lbu	t1,0(s2)
    12aa:	0003071b          	sext.w	a4,t1
    12ae:	f80305e3          	beqz	t1,1238 <printf+0x108>
        if (c != '%') {
    12b2:	0014879b          	addiw	a5,s1,1
    12b6:	00fa8933          	add	s2,s5,a5
    12ba:	ef7703e3          	beq	a4,s7,11a0 <printf+0x70>
    return write(stdout, put, 1);
    12be:	4605                	li	a2,1
    12c0:	00001597          	auipc	a1,0x1
    12c4:	c0058593          	addi	a1,a1,-1024 # 1ec0 <put.1156>
    12c8:	4505                	li	a0,1
    put[0] = c;
    12ca:	00640023          	sb	t1,0(s0)
            continue;
    12ce:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    12d0:	1b5000ef          	jal	ra,1c84 <write>
            continue;
    12d4:	bfc9                	j	12a6 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    12d6:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    12d8:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    12da:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    12dc:	0007b883          	ld	a7,0(a5)
    12e0:	07a1                	addi	a5,a5,8
    12e2:	e43e                	sd	a5,8(sp)
        x = -xx;
    12e4:	43f8d713          	srai	a4,a7,0x3f
    12e8:	011747b3          	xor	a5,a4,a7
    12ec:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    12ee:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    12f0:	02c7f733          	remu	a4,a5,a2
    12f4:	8d36                	mv	s10,a3
    12f6:	0685                	addi	a3,a3,1
    12f8:	00db0533          	add	a0,s6,a3
    12fc:	85be                	mv	a1,a5
    12fe:	974e                	add	a4,a4,s3
    1300:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    1304:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    1308:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    130c:	feb862e3          	bltu	a6,a1,12f0 <printf+0x1c0>
    if (sign)
    1310:	1208c063          	bltz	a7,1430 <printf+0x300>
    while (--i >= 0)
    1314:	9d5a                	add	s10,s10,s6
    put[0] = c;
    1316:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    131a:	4605                	li	a2,1
    131c:	85a2                	mv	a1,s0
    131e:	4505                	li	a0,1
    put[0] = c;
    1320:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1324:	161000ef          	jal	ra,1c84 <write>
    while (--i >= 0)
    1328:	87ea                	mv	a5,s10
    132a:	1d7d                	addi	s10,s10,-1
    132c:	fefb15e3          	bne	s6,a5,1316 <printf+0x1e6>
    1330:	bf9d                	j	12a6 <printf+0x176>
                printptr(va_arg(ap, uint64));
    1332:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    1334:	4605                	li	a2,1
    1336:	00001597          	auipc	a1,0x1
    133a:	b8a58593          	addi	a1,a1,-1142 # 1ec0 <put.1156>
                printptr(va_arg(ap, uint64));
    133e:	0007bd83          	ld	s11,0(a5)
    1342:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    1346:	4505                	li	a0,1
    put[0] = c;
    1348:	03000793          	li	a5,48
    134c:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    1350:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    1352:	133000ef          	jal	ra,1c84 <write>
    put[0] = c;
    1356:	07800793          	li	a5,120
    return write(stdout, put, 1);
    135a:	4605                	li	a2,1
    135c:	00001597          	auipc	a1,0x1
    1360:	b6458593          	addi	a1,a1,-1180 # 1ec0 <put.1156>
    1364:	4505                	li	a0,1
    put[0] = c;
    1366:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    136a:	4d41                	li	s10,16
    136c:	119000ef          	jal	ra,1c84 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    1370:	03cdd793          	srli	a5,s11,0x3c
    1374:	97ce                	add	a5,a5,s3
    put[0] = c;
    1376:	0007c783          	lbu	a5,0(a5)
    137a:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    137c:	4605                	li	a2,1
    137e:	85a2                	mv	a1,s0
    1380:	4505                	li	a0,1
    put[0] = c;
    1382:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1386:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1388:	0fd000ef          	jal	ra,1c84 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    138c:	fe0d12e3          	bnez	s10,1370 <printf+0x240>
    1390:	bf19                	j	12a6 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    1392:	67a2                	ld	a5,8(sp)
    1394:	4394                	lw	a3,0(a5)
    1396:	07a1                	addi	a5,a5,8
    1398:	e43e                	sd	a5,8(sp)
    139a:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    139e:	0006d663          	bgez	a3,13aa <printf+0x27a>
        x = -xx;
    13a2:	40f007bb          	negw	a5,a5
    13a6:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    13aa:	4729                	li	a4,10
    13ac:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    13b0:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    13b4:	964e                	add	a2,a2,s3
    13b6:	00064603          	lbu	a2,0(a2)
    13ba:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    13be:	0a0d0963          	beqz	s10,1470 <printf+0x340>
        buf[i++] = digits[x % base];
    13c2:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    13c6:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    13ca:	00c98733          	add	a4,s3,a2
    13ce:	00074703          	lbu	a4,0(a4)
    13d2:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    13d6:	c3cd                	beqz	a5,1478 <printf+0x348>
        buf[i++] = digits[x % base];
    13d8:	97ce                	add	a5,a5,s3
    13da:	0007c703          	lbu	a4,0(a5)
    13de:	4d09                	li	s10,2
    13e0:	478d                	li	a5,3
    13e2:	00e10923          	sb	a4,18(sp)
    if (sign)
    13e6:	0206cd63          	bltz	a3,1420 <printf+0x2f0>
    while (--i >= 0)
    13ea:	9d5a                	add	s10,s10,s6
    13ec:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    13f0:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    13f4:	4605                	li	a2,1
    13f6:	1d7d                	addi	s10,s10,-1
    13f8:	85a2                	mv	a1,s0
    13fa:	4505                	li	a0,1
    put[0] = c;
    13fc:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1400:	085000ef          	jal	ra,1c84 <write>
    while (--i >= 0)
    1404:	ffbd16e3          	bne	s10,s11,13f0 <printf+0x2c0>
    1408:	bd79                	j	12a6 <printf+0x176>
    return write(stdout, put, 1);
    140a:	4605                	li	a2,1
    140c:	00001597          	auipc	a1,0x1
    1410:	ab458593          	addi	a1,a1,-1356 # 1ec0 <put.1156>
    1414:	4505                	li	a0,1
    put[0] = c;
    1416:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    141a:	06b000ef          	jal	ra,1c84 <write>
    141e:	b561                	j	12a6 <printf+0x176>
        buf[i++] = '-';
    1420:	1818                	addi	a4,sp,48
    1422:	973e                	add	a4,a4,a5
    1424:	02d00693          	li	a3,45
    1428:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    142c:	8d3e                	mv	s10,a5
    142e:	bf75                	j	13ea <printf+0x2ba>
        buf[i++] = '-';
    1430:	181c                	addi	a5,sp,48
    1432:	97b6                	add	a5,a5,a3
    1434:	02d00713          	li	a4,45
    1438:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    143c:	8d36                	mv	s10,a3
    143e:	bdd9                	j	1314 <printf+0x1e4>
        x = -xx;
    1440:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    1444:	00f7f693          	andi	a3,a5,15
    1448:	96ce                	add	a3,a3,s3
    144a:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    144e:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    1452:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    1456:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    145a:	d80d1be3          	bnez	s10,11f0 <printf+0xc0>
        buf[i++] = digits[x % base];
    145e:	4d05                	li	s10,1
    1460:	b34d                	j	1202 <printf+0xd2>
                s = "(null)";
    1462:	00001d17          	auipc	s10,0x1
    1466:	a36d0d13          	addi	s10,s10,-1482 # 1e98 <sharedmem+0xc2>
                for (; *s; s++)
    146a:	02800793          	li	a5,40
    146e:	bbe5                	j	1266 <printf+0x136>
        buf[i++] = digits[x % base];
    1470:	4785                	li	a5,1
    if (sign)
    1472:	f606dce3          	bgez	a3,13ea <printf+0x2ba>
    1476:	b76d                	j	1420 <printf+0x2f0>
        buf[i++] = digits[x % base];
    1478:	4789                	li	a5,2
    147a:	4d05                	li	s10,1
    if (sign)
    147c:	f606d7e3          	bgez	a3,13ea <printf+0x2ba>
    1480:	b745                	j	1420 <printf+0x2f0>

0000000000001482 <srand>:
#include <ucore.h>

static uint64 seed;

void srand(unsigned s) {
    seed = s - 1;
    1482:	357d                	addiw	a0,a0,-1
    1484:	1502                	slli	a0,a0,0x20
    1486:	9101                	srli	a0,a0,0x20
    1488:	00001797          	auipc	a5,0x1
    148c:	a4a7b023          	sd	a0,-1472(a5) # 1ec8 <seed>
}
    1490:	8082                	ret

0000000000001492 <rand>:

int rand(void) {
    seed = 6364136223846793005ULL * seed + 1;
    1492:	00001797          	auipc	a5,0x1
    1496:	a3678793          	addi	a5,a5,-1482 # 1ec8 <seed>
    149a:	6388                	ld	a0,0(a5)
    149c:	00001717          	auipc	a4,0x1
    14a0:	a0473703          	ld	a4,-1532(a4) # 1ea0 <sharedmem+0xca>
    14a4:	02e50533          	mul	a0,a0,a4
    14a8:	0505                	addi	a0,a0,1
    14aa:	e388                	sd	a0,0(a5)
    return seed >> 33;
}
    14ac:	9105                	srli	a0,a0,0x21
    14ae:	8082                	ret

00000000000014b0 <panic>:

void panic(char* m) {
    14b0:	1141                	addi	sp,sp,-16
    14b2:	e406                	sd	ra,8(sp)
    puts(m);
    14b4:	c37ff0ef          	jal	ra,10ea <puts>
    exit(-100);
}
    14b8:	60a2                	ld	ra,8(sp)
    exit(-100);
    14ba:	f9c00513          	li	a0,-100
}
    14be:	0141                	addi	sp,sp,16
    exit(-100);
    14c0:	af45                	j	1c70 <exit>

00000000000014c2 <assert>:

void assert(int f, int code) {
    if(!f) {
    14c2:	c111                	beqz	a0,14c6 <assert+0x4>
        exit(code);
    }
    14c4:	8082                	ret
        exit(code);
    14c6:	852e                	mv	a0,a1
    14c8:	a765                	j	1c70 <exit>

00000000000014ca <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    14ca:	02000793          	li	a5,32
    14ce:	00f50663          	beq	a0,a5,14da <isspace+0x10>
    14d2:	355d                	addiw	a0,a0,-9
    14d4:	00553513          	sltiu	a0,a0,5
    14d8:	8082                	ret
    14da:	4505                	li	a0,1
}
    14dc:	8082                	ret

00000000000014de <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    14de:	fd05051b          	addiw	a0,a0,-48
}
    14e2:	00a53513          	sltiu	a0,a0,10
    14e6:	8082                	ret

00000000000014e8 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    14e8:	02000613          	li	a2,32
    14ec:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    14ee:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    14f2:	ff77069b          	addiw	a3,a4,-9
    14f6:	04c70d63          	beq	a4,a2,1550 <atoi+0x68>
    14fa:	0007079b          	sext.w	a5,a4
    14fe:	04d5f963          	bgeu	a1,a3,1550 <atoi+0x68>
        s++;
    switch (*s) {
    1502:	02b00693          	li	a3,43
    1506:	04d70a63          	beq	a4,a3,155a <atoi+0x72>
    150a:	02d00693          	li	a3,45
    150e:	06d70463          	beq	a4,a3,1576 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1512:	fd07859b          	addiw	a1,a5,-48
    1516:	4625                	li	a2,9
    1518:	873e                	mv	a4,a5
    151a:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    151c:	4e01                	li	t3,0
    while (isdigit(*s))
    151e:	04b66a63          	bltu	a2,a1,1572 <atoi+0x8a>
    int n = 0, neg = 0;
    1522:	4501                	li	a0,0
    while (isdigit(*s))
    1524:	4825                	li	a6,9
    1526:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    152a:	0025179b          	slliw	a5,a0,0x2
    152e:	9d3d                	addw	a0,a0,a5
    1530:	fd07031b          	addiw	t1,a4,-48
    1534:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1538:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    153c:	0685                	addi	a3,a3,1
    153e:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1542:	0006071b          	sext.w	a4,a2
    1546:	feb870e3          	bgeu	a6,a1,1526 <atoi+0x3e>
    return neg ? n : -n;
    154a:	000e0563          	beqz	t3,1554 <atoi+0x6c>
}
    154e:	8082                	ret
        s++;
    1550:	0505                	addi	a0,a0,1
    1552:	bf71                	j	14ee <atoi+0x6>
    1554:	4113053b          	subw	a0,t1,a7
    1558:	8082                	ret
    while (isdigit(*s))
    155a:	00154783          	lbu	a5,1(a0)
    155e:	4625                	li	a2,9
        s++;
    1560:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1564:	fd07859b          	addiw	a1,a5,-48
    1568:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    156c:	4e01                	li	t3,0
    while (isdigit(*s))
    156e:	fab67ae3          	bgeu	a2,a1,1522 <atoi+0x3a>
    1572:	4501                	li	a0,0
}
    1574:	8082                	ret
    while (isdigit(*s))
    1576:	00154783          	lbu	a5,1(a0)
    157a:	4625                	li	a2,9
        s++;
    157c:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1580:	fd07859b          	addiw	a1,a5,-48
    1584:	0007871b          	sext.w	a4,a5
    1588:	feb665e3          	bltu	a2,a1,1572 <atoi+0x8a>
        neg = 1;
    158c:	4e05                	li	t3,1
    158e:	bf51                	j	1522 <atoi+0x3a>

0000000000001590 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    1590:	16060d63          	beqz	a2,170a <memset+0x17a>
    1594:	40a007b3          	neg	a5,a0
    1598:	8b9d                	andi	a5,a5,7
    159a:	00778713          	addi	a4,a5,7
    159e:	482d                	li	a6,11
    15a0:	0ff5f593          	andi	a1,a1,255
    15a4:	fff60693          	addi	a3,a2,-1
    15a8:	17076263          	bltu	a4,a6,170c <memset+0x17c>
    15ac:	16e6ea63          	bltu	a3,a4,1720 <memset+0x190>
    15b0:	16078563          	beqz	a5,171a <memset+0x18a>
    15b4:	00b50023          	sb	a1,0(a0)
    15b8:	4705                	li	a4,1
    15ba:	00150e93          	addi	t4,a0,1
    15be:	14e78c63          	beq	a5,a4,1716 <memset+0x186>
    15c2:	00b500a3          	sb	a1,1(a0)
    15c6:	4709                	li	a4,2
    15c8:	00250e93          	addi	t4,a0,2
    15cc:	14e78d63          	beq	a5,a4,1726 <memset+0x196>
    15d0:	00b50123          	sb	a1,2(a0)
    15d4:	470d                	li	a4,3
    15d6:	00350e93          	addi	t4,a0,3
    15da:	12e78b63          	beq	a5,a4,1710 <memset+0x180>
    15de:	00b501a3          	sb	a1,3(a0)
    15e2:	4711                	li	a4,4
    15e4:	00450e93          	addi	t4,a0,4
    15e8:	14e78163          	beq	a5,a4,172a <memset+0x19a>
    15ec:	00b50223          	sb	a1,4(a0)
    15f0:	4715                	li	a4,5
    15f2:	00550e93          	addi	t4,a0,5
    15f6:	12e78c63          	beq	a5,a4,172e <memset+0x19e>
    15fa:	00b502a3          	sb	a1,5(a0)
    15fe:	471d                	li	a4,7
    1600:	00650e93          	addi	t4,a0,6
    1604:	12e79763          	bne	a5,a4,1732 <memset+0x1a2>
    1608:	00750e93          	addi	t4,a0,7
    160c:	00b50323          	sb	a1,6(a0)
    1610:	4f1d                	li	t5,7
    1612:	00859713          	slli	a4,a1,0x8
    1616:	8f4d                	or	a4,a4,a1
    1618:	01059e13          	slli	t3,a1,0x10
    161c:	01c76e33          	or	t3,a4,t3
    1620:	01859313          	slli	t1,a1,0x18
    1624:	006e6333          	or	t1,t3,t1
    1628:	02059893          	slli	a7,a1,0x20
    162c:	011368b3          	or	a7,t1,a7
    1630:	02859813          	slli	a6,a1,0x28
    1634:	40f60333          	sub	t1,a2,a5
    1638:	0108e833          	or	a6,a7,a6
    163c:	03059693          	slli	a3,a1,0x30
    1640:	00d866b3          	or	a3,a6,a3
    1644:	03859713          	slli	a4,a1,0x38
    1648:	97aa                	add	a5,a5,a0
    164a:	ff837813          	andi	a6,t1,-8
    164e:	8f55                	or	a4,a4,a3
    1650:	00f806b3          	add	a3,a6,a5
    1654:	e398                	sd	a4,0(a5)
    1656:	07a1                	addi	a5,a5,8
    1658:	fed79ee3          	bne	a5,a3,1654 <memset+0xc4>
    165c:	ff837693          	andi	a3,t1,-8
    1660:	00de87b3          	add	a5,t4,a3
    1664:	01e6873b          	addw	a4,a3,t5
    1668:	0ad30663          	beq	t1,a3,1714 <memset+0x184>
    166c:	00b78023          	sb	a1,0(a5)
    1670:	0017069b          	addiw	a3,a4,1
    1674:	08c6fb63          	bgeu	a3,a2,170a <memset+0x17a>
    1678:	00b780a3          	sb	a1,1(a5)
    167c:	0027069b          	addiw	a3,a4,2
    1680:	08c6f563          	bgeu	a3,a2,170a <memset+0x17a>
    1684:	00b78123          	sb	a1,2(a5)
    1688:	0037069b          	addiw	a3,a4,3
    168c:	06c6ff63          	bgeu	a3,a2,170a <memset+0x17a>
    1690:	00b781a3          	sb	a1,3(a5)
    1694:	0047069b          	addiw	a3,a4,4
    1698:	06c6f963          	bgeu	a3,a2,170a <memset+0x17a>
    169c:	00b78223          	sb	a1,4(a5)
    16a0:	0057069b          	addiw	a3,a4,5
    16a4:	06c6f363          	bgeu	a3,a2,170a <memset+0x17a>
    16a8:	00b782a3          	sb	a1,5(a5)
    16ac:	0067069b          	addiw	a3,a4,6
    16b0:	04c6fd63          	bgeu	a3,a2,170a <memset+0x17a>
    16b4:	00b78323          	sb	a1,6(a5)
    16b8:	0077069b          	addiw	a3,a4,7
    16bc:	04c6f763          	bgeu	a3,a2,170a <memset+0x17a>
    16c0:	00b783a3          	sb	a1,7(a5)
    16c4:	0087069b          	addiw	a3,a4,8
    16c8:	04c6f163          	bgeu	a3,a2,170a <memset+0x17a>
    16cc:	00b78423          	sb	a1,8(a5)
    16d0:	0097069b          	addiw	a3,a4,9
    16d4:	02c6fb63          	bgeu	a3,a2,170a <memset+0x17a>
    16d8:	00b784a3          	sb	a1,9(a5)
    16dc:	00a7069b          	addiw	a3,a4,10
    16e0:	02c6f563          	bgeu	a3,a2,170a <memset+0x17a>
    16e4:	00b78523          	sb	a1,10(a5)
    16e8:	00b7069b          	addiw	a3,a4,11
    16ec:	00c6ff63          	bgeu	a3,a2,170a <memset+0x17a>
    16f0:	00b785a3          	sb	a1,11(a5)
    16f4:	00c7069b          	addiw	a3,a4,12
    16f8:	00c6f963          	bgeu	a3,a2,170a <memset+0x17a>
    16fc:	00b78623          	sb	a1,12(a5)
    1700:	2735                	addiw	a4,a4,13
    1702:	00c77463          	bgeu	a4,a2,170a <memset+0x17a>
    1706:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    170a:	8082                	ret
    170c:	472d                	li	a4,11
    170e:	bd79                	j	15ac <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1710:	4f0d                	li	t5,3
    1712:	b701                	j	1612 <memset+0x82>
    1714:	8082                	ret
    1716:	4f05                	li	t5,1
    1718:	bded                	j	1612 <memset+0x82>
    171a:	8eaa                	mv	t4,a0
    171c:	4f01                	li	t5,0
    171e:	bdd5                	j	1612 <memset+0x82>
    1720:	87aa                	mv	a5,a0
    1722:	4701                	li	a4,0
    1724:	b7a1                	j	166c <memset+0xdc>
    1726:	4f09                	li	t5,2
    1728:	b5ed                	j	1612 <memset+0x82>
    172a:	4f11                	li	t5,4
    172c:	b5dd                	j	1612 <memset+0x82>
    172e:	4f15                	li	t5,5
    1730:	b5cd                	j	1612 <memset+0x82>
    1732:	4f19                	li	t5,6
    1734:	bdf9                	j	1612 <memset+0x82>

0000000000001736 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    1736:	00054783          	lbu	a5,0(a0)
    173a:	0005c703          	lbu	a4,0(a1)
    173e:	00e79863          	bne	a5,a4,174e <strcmp+0x18>
    1742:	0505                	addi	a0,a0,1
    1744:	0585                	addi	a1,a1,1
    1746:	fbe5                	bnez	a5,1736 <strcmp>
    1748:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    174a:	9d19                	subw	a0,a0,a4
    174c:	8082                	ret
    174e:	0007851b          	sext.w	a0,a5
    1752:	bfe5                	j	174a <strcmp+0x14>

0000000000001754 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1754:	87aa                	mv	a5,a0
    1756:	0005c703          	lbu	a4,0(a1)
    175a:	0785                	addi	a5,a5,1
    175c:	0585                	addi	a1,a1,1
    175e:	fee78fa3          	sb	a4,-1(a5)
    1762:	fb75                	bnez	a4,1756 <strcpy+0x2>
        ;
    return os;
}
    1764:	8082                	ret

0000000000001766 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    1766:	ce05                	beqz	a2,179e <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1768:	00054703          	lbu	a4,0(a0)
    176c:	0005c783          	lbu	a5,0(a1)
    1770:	cb0d                	beqz	a4,17a2 <strncmp+0x3c>
    if (!n--)
    1772:	167d                	addi	a2,a2,-1
    1774:	00c506b3          	add	a3,a0,a2
    1778:	a819                	j	178e <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    177a:	00a68e63          	beq	a3,a0,1796 <strncmp+0x30>
    177e:	0505                	addi	a0,a0,1
    1780:	00e79b63          	bne	a5,a4,1796 <strncmp+0x30>
    1784:	00054703          	lbu	a4,0(a0)
    1788:	0005c783          	lbu	a5,0(a1)
    178c:	cb19                	beqz	a4,17a2 <strncmp+0x3c>
    178e:	0005c783          	lbu	a5,0(a1)
    1792:	0585                	addi	a1,a1,1
    1794:	f3fd                	bnez	a5,177a <strncmp+0x14>
        ;
    return *l - *r;
    1796:	0007051b          	sext.w	a0,a4
    179a:	9d1d                	subw	a0,a0,a5
    179c:	8082                	ret
        return 0;
    179e:	4501                	li	a0,0
}
    17a0:	8082                	ret
    17a2:	4501                	li	a0,0
    return *l - *r;
    17a4:	9d1d                	subw	a0,a0,a5
    17a6:	8082                	ret

00000000000017a8 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    17a8:	00757793          	andi	a5,a0,7
    17ac:	cf89                	beqz	a5,17c6 <strlen+0x1e>
    17ae:	87aa                	mv	a5,a0
    17b0:	a029                	j	17ba <strlen+0x12>
    17b2:	0785                	addi	a5,a5,1
    17b4:	0077f713          	andi	a4,a5,7
    17b8:	cb01                	beqz	a4,17c8 <strlen+0x20>
        if (!*s)
    17ba:	0007c703          	lbu	a4,0(a5)
    17be:	fb75                	bnez	a4,17b2 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    17c0:	40a78533          	sub	a0,a5,a0
}
    17c4:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    17c6:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    17c8:	6394                	ld	a3,0(a5)
    17ca:	00000597          	auipc	a1,0x0
    17ce:	6de5b583          	ld	a1,1758(a1) # 1ea8 <sharedmem+0xd2>
    17d2:	00000617          	auipc	a2,0x0
    17d6:	6de63603          	ld	a2,1758(a2) # 1eb0 <sharedmem+0xda>
    17da:	a019                	j	17e0 <strlen+0x38>
    17dc:	6794                	ld	a3,8(a5)
    17de:	07a1                	addi	a5,a5,8
    17e0:	00b68733          	add	a4,a3,a1
    17e4:	fff6c693          	not	a3,a3
    17e8:	8f75                	and	a4,a4,a3
    17ea:	8f71                	and	a4,a4,a2
    17ec:	db65                	beqz	a4,17dc <strlen+0x34>
    for (; *s; s++)
    17ee:	0007c703          	lbu	a4,0(a5)
    17f2:	d779                	beqz	a4,17c0 <strlen+0x18>
    17f4:	0017c703          	lbu	a4,1(a5)
    17f8:	0785                	addi	a5,a5,1
    17fa:	d379                	beqz	a4,17c0 <strlen+0x18>
    17fc:	0017c703          	lbu	a4,1(a5)
    1800:	0785                	addi	a5,a5,1
    1802:	fb6d                	bnez	a4,17f4 <strlen+0x4c>
    1804:	bf75                	j	17c0 <strlen+0x18>

0000000000001806 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1806:	00757713          	andi	a4,a0,7
{
    180a:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    180c:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1810:	cb19                	beqz	a4,1826 <memchr+0x20>
    1812:	ce25                	beqz	a2,188a <memchr+0x84>
    1814:	0007c703          	lbu	a4,0(a5)
    1818:	04b70e63          	beq	a4,a1,1874 <memchr+0x6e>
    181c:	0785                	addi	a5,a5,1
    181e:	0077f713          	andi	a4,a5,7
    1822:	167d                	addi	a2,a2,-1
    1824:	f77d                	bnez	a4,1812 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    1826:	4501                	li	a0,0
    if (n && *s != c) {
    1828:	c235                	beqz	a2,188c <memchr+0x86>
    182a:	0007c703          	lbu	a4,0(a5)
    182e:	04b70363          	beq	a4,a1,1874 <memchr+0x6e>
        size_t k = ONES * c;
    1832:	00000517          	auipc	a0,0x0
    1836:	68653503          	ld	a0,1670(a0) # 1eb8 <sharedmem+0xe2>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    183a:	471d                	li	a4,7
        size_t k = ONES * c;
    183c:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1840:	02c77a63          	bgeu	a4,a2,1874 <memchr+0x6e>
    1844:	00000897          	auipc	a7,0x0
    1848:	6648b883          	ld	a7,1636(a7) # 1ea8 <sharedmem+0xd2>
    184c:	00000817          	auipc	a6,0x0
    1850:	66483803          	ld	a6,1636(a6) # 1eb0 <sharedmem+0xda>
    1854:	431d                	li	t1,7
    1856:	a029                	j	1860 <memchr+0x5a>
    1858:	1661                	addi	a2,a2,-8
    185a:	07a1                	addi	a5,a5,8
    185c:	02c37963          	bgeu	t1,a2,188e <memchr+0x88>
    1860:	6398                	ld	a4,0(a5)
    1862:	8f29                	xor	a4,a4,a0
    1864:	011706b3          	add	a3,a4,a7
    1868:	fff74713          	not	a4,a4
    186c:	8f75                	and	a4,a4,a3
    186e:	01077733          	and	a4,a4,a6
    1872:	d37d                	beqz	a4,1858 <memchr+0x52>
    1874:	853e                	mv	a0,a5
    1876:	97b2                	add	a5,a5,a2
    1878:	a021                	j	1880 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    187a:	0505                	addi	a0,a0,1
    187c:	00f50763          	beq	a0,a5,188a <memchr+0x84>
    1880:	00054703          	lbu	a4,0(a0)
    1884:	feb71be3          	bne	a4,a1,187a <memchr+0x74>
    1888:	8082                	ret
    return n ? (void*)s : 0;
    188a:	4501                	li	a0,0
}
    188c:	8082                	ret
    return n ? (void*)s : 0;
    188e:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1890:	f275                	bnez	a2,1874 <memchr+0x6e>
}
    1892:	8082                	ret

0000000000001894 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1894:	1101                	addi	sp,sp,-32
    1896:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1898:	862e                	mv	a2,a1
{
    189a:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    189c:	4581                	li	a1,0
{
    189e:	e426                	sd	s1,8(sp)
    18a0:	ec06                	sd	ra,24(sp)
    18a2:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    18a4:	f63ff0ef          	jal	ra,1806 <memchr>
    return p ? p - s : n;
    18a8:	c519                	beqz	a0,18b6 <strnlen+0x22>
}
    18aa:	60e2                	ld	ra,24(sp)
    18ac:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    18ae:	8d05                	sub	a0,a0,s1
}
    18b0:	64a2                	ld	s1,8(sp)
    18b2:	6105                	addi	sp,sp,32
    18b4:	8082                	ret
    18b6:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    18b8:	8522                	mv	a0,s0
}
    18ba:	6442                	ld	s0,16(sp)
    18bc:	64a2                	ld	s1,8(sp)
    18be:	6105                	addi	sp,sp,32
    18c0:	8082                	ret

00000000000018c2 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    18c2:	00b547b3          	xor	a5,a0,a1
    18c6:	8b9d                	andi	a5,a5,7
    18c8:	eb95                	bnez	a5,18fc <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    18ca:	0075f793          	andi	a5,a1,7
    18ce:	e7b1                	bnez	a5,191a <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    18d0:	6198                	ld	a4,0(a1)
    18d2:	00000617          	auipc	a2,0x0
    18d6:	5d663603          	ld	a2,1494(a2) # 1ea8 <sharedmem+0xd2>
    18da:	00000817          	auipc	a6,0x0
    18de:	5d683803          	ld	a6,1494(a6) # 1eb0 <sharedmem+0xda>
    18e2:	a029                	j	18ec <stpcpy+0x2a>
    18e4:	e118                	sd	a4,0(a0)
    18e6:	6598                	ld	a4,8(a1)
    18e8:	05a1                	addi	a1,a1,8
    18ea:	0521                	addi	a0,a0,8
    18ec:	00c707b3          	add	a5,a4,a2
    18f0:	fff74693          	not	a3,a4
    18f4:	8ff5                	and	a5,a5,a3
    18f6:	0107f7b3          	and	a5,a5,a6
    18fa:	d7ed                	beqz	a5,18e4 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    18fc:	0005c783          	lbu	a5,0(a1)
    1900:	00f50023          	sb	a5,0(a0)
    1904:	c785                	beqz	a5,192c <stpcpy+0x6a>
    1906:	0015c783          	lbu	a5,1(a1)
    190a:	0505                	addi	a0,a0,1
    190c:	0585                	addi	a1,a1,1
    190e:	00f50023          	sb	a5,0(a0)
    1912:	fbf5                	bnez	a5,1906 <stpcpy+0x44>
        ;
    return d;
}
    1914:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1916:	0505                	addi	a0,a0,1
    1918:	df45                	beqz	a4,18d0 <stpcpy+0xe>
            if (!(*d = *s))
    191a:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    191e:	0585                	addi	a1,a1,1
    1920:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1924:	00f50023          	sb	a5,0(a0)
    1928:	f7fd                	bnez	a5,1916 <stpcpy+0x54>
}
    192a:	8082                	ret
    192c:	8082                	ret

000000000000192e <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    192e:	00b547b3          	xor	a5,a0,a1
    1932:	8b9d                	andi	a5,a5,7
    1934:	1a079863          	bnez	a5,1ae4 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1938:	0075f793          	andi	a5,a1,7
    193c:	16078463          	beqz	a5,1aa4 <stpncpy+0x176>
    1940:	ea01                	bnez	a2,1950 <stpncpy+0x22>
    1942:	a421                	j	1b4a <stpncpy+0x21c>
    1944:	167d                	addi	a2,a2,-1
    1946:	0505                	addi	a0,a0,1
    1948:	14070e63          	beqz	a4,1aa4 <stpncpy+0x176>
    194c:	1a060863          	beqz	a2,1afc <stpncpy+0x1ce>
    1950:	0005c783          	lbu	a5,0(a1)
    1954:	0585                	addi	a1,a1,1
    1956:	0075f713          	andi	a4,a1,7
    195a:	00f50023          	sb	a5,0(a0)
    195e:	f3fd                	bnez	a5,1944 <stpncpy+0x16>
    1960:	4805                	li	a6,1
    1962:	1a061863          	bnez	a2,1b12 <stpncpy+0x1e4>
    1966:	40a007b3          	neg	a5,a0
    196a:	8b9d                	andi	a5,a5,7
    196c:	4681                	li	a3,0
    196e:	18061a63          	bnez	a2,1b02 <stpncpy+0x1d4>
    1972:	00778713          	addi	a4,a5,7
    1976:	45ad                	li	a1,11
    1978:	18b76363          	bltu	a4,a1,1afe <stpncpy+0x1d0>
    197c:	1ae6eb63          	bltu	a3,a4,1b32 <stpncpy+0x204>
    1980:	1a078363          	beqz	a5,1b26 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1984:	00050023          	sb	zero,0(a0)
    1988:	4685                	li	a3,1
    198a:	00150713          	addi	a4,a0,1
    198e:	18d78f63          	beq	a5,a3,1b2c <stpncpy+0x1fe>
    1992:	000500a3          	sb	zero,1(a0)
    1996:	4689                	li	a3,2
    1998:	00250713          	addi	a4,a0,2
    199c:	18d78e63          	beq	a5,a3,1b38 <stpncpy+0x20a>
    19a0:	00050123          	sb	zero,2(a0)
    19a4:	468d                	li	a3,3
    19a6:	00350713          	addi	a4,a0,3
    19aa:	16d78c63          	beq	a5,a3,1b22 <stpncpy+0x1f4>
    19ae:	000501a3          	sb	zero,3(a0)
    19b2:	4691                	li	a3,4
    19b4:	00450713          	addi	a4,a0,4
    19b8:	18d78263          	beq	a5,a3,1b3c <stpncpy+0x20e>
    19bc:	00050223          	sb	zero,4(a0)
    19c0:	4695                	li	a3,5
    19c2:	00550713          	addi	a4,a0,5
    19c6:	16d78d63          	beq	a5,a3,1b40 <stpncpy+0x212>
    19ca:	000502a3          	sb	zero,5(a0)
    19ce:	469d                	li	a3,7
    19d0:	00650713          	addi	a4,a0,6
    19d4:	16d79863          	bne	a5,a3,1b44 <stpncpy+0x216>
    19d8:	00750713          	addi	a4,a0,7
    19dc:	00050323          	sb	zero,6(a0)
    19e0:	40f80833          	sub	a6,a6,a5
    19e4:	ff887593          	andi	a1,a6,-8
    19e8:	97aa                	add	a5,a5,a0
    19ea:	95be                	add	a1,a1,a5
    19ec:	0007b023          	sd	zero,0(a5)
    19f0:	07a1                	addi	a5,a5,8
    19f2:	feb79de3          	bne	a5,a1,19ec <stpncpy+0xbe>
    19f6:	ff887593          	andi	a1,a6,-8
    19fa:	9ead                	addw	a3,a3,a1
    19fc:	00b707b3          	add	a5,a4,a1
    1a00:	12b80863          	beq	a6,a1,1b30 <stpncpy+0x202>
    1a04:	00078023          	sb	zero,0(a5)
    1a08:	0016871b          	addiw	a4,a3,1
    1a0c:	0ec77863          	bgeu	a4,a2,1afc <stpncpy+0x1ce>
    1a10:	000780a3          	sb	zero,1(a5)
    1a14:	0026871b          	addiw	a4,a3,2
    1a18:	0ec77263          	bgeu	a4,a2,1afc <stpncpy+0x1ce>
    1a1c:	00078123          	sb	zero,2(a5)
    1a20:	0036871b          	addiw	a4,a3,3
    1a24:	0cc77c63          	bgeu	a4,a2,1afc <stpncpy+0x1ce>
    1a28:	000781a3          	sb	zero,3(a5)
    1a2c:	0046871b          	addiw	a4,a3,4
    1a30:	0cc77663          	bgeu	a4,a2,1afc <stpncpy+0x1ce>
    1a34:	00078223          	sb	zero,4(a5)
    1a38:	0056871b          	addiw	a4,a3,5
    1a3c:	0cc77063          	bgeu	a4,a2,1afc <stpncpy+0x1ce>
    1a40:	000782a3          	sb	zero,5(a5)
    1a44:	0066871b          	addiw	a4,a3,6
    1a48:	0ac77a63          	bgeu	a4,a2,1afc <stpncpy+0x1ce>
    1a4c:	00078323          	sb	zero,6(a5)
    1a50:	0076871b          	addiw	a4,a3,7
    1a54:	0ac77463          	bgeu	a4,a2,1afc <stpncpy+0x1ce>
    1a58:	000783a3          	sb	zero,7(a5)
    1a5c:	0086871b          	addiw	a4,a3,8
    1a60:	08c77e63          	bgeu	a4,a2,1afc <stpncpy+0x1ce>
    1a64:	00078423          	sb	zero,8(a5)
    1a68:	0096871b          	addiw	a4,a3,9
    1a6c:	08c77863          	bgeu	a4,a2,1afc <stpncpy+0x1ce>
    1a70:	000784a3          	sb	zero,9(a5)
    1a74:	00a6871b          	addiw	a4,a3,10
    1a78:	08c77263          	bgeu	a4,a2,1afc <stpncpy+0x1ce>
    1a7c:	00078523          	sb	zero,10(a5)
    1a80:	00b6871b          	addiw	a4,a3,11
    1a84:	06c77c63          	bgeu	a4,a2,1afc <stpncpy+0x1ce>
    1a88:	000785a3          	sb	zero,11(a5)
    1a8c:	00c6871b          	addiw	a4,a3,12
    1a90:	06c77663          	bgeu	a4,a2,1afc <stpncpy+0x1ce>
    1a94:	00078623          	sb	zero,12(a5)
    1a98:	26b5                	addiw	a3,a3,13
    1a9a:	06c6f163          	bgeu	a3,a2,1afc <stpncpy+0x1ce>
    1a9e:	000786a3          	sb	zero,13(a5)
    1aa2:	8082                	ret
            ;
        if (!n || !*s)
    1aa4:	c645                	beqz	a2,1b4c <stpncpy+0x21e>
    1aa6:	0005c783          	lbu	a5,0(a1)
    1aaa:	ea078be3          	beqz	a5,1960 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1aae:	479d                	li	a5,7
    1ab0:	02c7ff63          	bgeu	a5,a2,1aee <stpncpy+0x1c0>
    1ab4:	00000897          	auipc	a7,0x0
    1ab8:	3f48b883          	ld	a7,1012(a7) # 1ea8 <sharedmem+0xd2>
    1abc:	00000817          	auipc	a6,0x0
    1ac0:	3f483803          	ld	a6,1012(a6) # 1eb0 <sharedmem+0xda>
    1ac4:	431d                	li	t1,7
    1ac6:	6198                	ld	a4,0(a1)
    1ac8:	011707b3          	add	a5,a4,a7
    1acc:	fff74693          	not	a3,a4
    1ad0:	8ff5                	and	a5,a5,a3
    1ad2:	0107f7b3          	and	a5,a5,a6
    1ad6:	ef81                	bnez	a5,1aee <stpncpy+0x1c0>
            *wd = *ws;
    1ad8:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1ada:	1661                	addi	a2,a2,-8
    1adc:	05a1                	addi	a1,a1,8
    1ade:	0521                	addi	a0,a0,8
    1ae0:	fec363e3          	bltu	t1,a2,1ac6 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1ae4:	e609                	bnez	a2,1aee <stpncpy+0x1c0>
    1ae6:	a08d                	j	1b48 <stpncpy+0x21a>
    1ae8:	167d                	addi	a2,a2,-1
    1aea:	0505                	addi	a0,a0,1
    1aec:	ca01                	beqz	a2,1afc <stpncpy+0x1ce>
    1aee:	0005c783          	lbu	a5,0(a1)
    1af2:	0585                	addi	a1,a1,1
    1af4:	00f50023          	sb	a5,0(a0)
    1af8:	fbe5                	bnez	a5,1ae8 <stpncpy+0x1ba>
        ;
tail:
    1afa:	b59d                	j	1960 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1afc:	8082                	ret
    1afe:	472d                	li	a4,11
    1b00:	bdb5                	j	197c <stpncpy+0x4e>
    1b02:	00778713          	addi	a4,a5,7
    1b06:	45ad                	li	a1,11
    1b08:	fff60693          	addi	a3,a2,-1
    1b0c:	e6b778e3          	bgeu	a4,a1,197c <stpncpy+0x4e>
    1b10:	b7fd                	j	1afe <stpncpy+0x1d0>
    1b12:	40a007b3          	neg	a5,a0
    1b16:	8832                	mv	a6,a2
    1b18:	8b9d                	andi	a5,a5,7
    1b1a:	4681                	li	a3,0
    1b1c:	e4060be3          	beqz	a2,1972 <stpncpy+0x44>
    1b20:	b7cd                	j	1b02 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1b22:	468d                	li	a3,3
    1b24:	bd75                	j	19e0 <stpncpy+0xb2>
    1b26:	872a                	mv	a4,a0
    1b28:	4681                	li	a3,0
    1b2a:	bd5d                	j	19e0 <stpncpy+0xb2>
    1b2c:	4685                	li	a3,1
    1b2e:	bd4d                	j	19e0 <stpncpy+0xb2>
    1b30:	8082                	ret
    1b32:	87aa                	mv	a5,a0
    1b34:	4681                	li	a3,0
    1b36:	b5f9                	j	1a04 <stpncpy+0xd6>
    1b38:	4689                	li	a3,2
    1b3a:	b55d                	j	19e0 <stpncpy+0xb2>
    1b3c:	4691                	li	a3,4
    1b3e:	b54d                	j	19e0 <stpncpy+0xb2>
    1b40:	4695                	li	a3,5
    1b42:	bd79                	j	19e0 <stpncpy+0xb2>
    1b44:	4699                	li	a3,6
    1b46:	bd69                	j	19e0 <stpncpy+0xb2>
    1b48:	8082                	ret
    1b4a:	8082                	ret
    1b4c:	8082                	ret

0000000000001b4e <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1b4e:	fff6071b          	addiw	a4,a2,-1
    1b52:	0cb57063          	bgeu	a0,a1,1c12 <memmove+0xc4>
        while (n-- > 0)
    1b56:	0ec05063          	blez	a2,1c36 <memmove+0xe8>
    1b5a:	00750693          	addi	a3,a0,7
    1b5e:	8e8d                	sub	a3,a3,a1
    1b60:	00b567b3          	or	a5,a0,a1
    1b64:	00f6b693          	sltiu	a3,a3,15
    1b68:	8b9d                	andi	a5,a5,7
    1b6a:	0016c693          	xori	a3,a3,1
    1b6e:	0017b793          	seqz	a5,a5
    1b72:	8ff5                	and	a5,a5,a3
    1b74:	c3f1                	beqz	a5,1c38 <memmove+0xea>
    1b76:	0007079b          	sext.w	a5,a4
    1b7a:	46a5                	li	a3,9
    1b7c:	0af6fe63          	bgeu	a3,a5,1c38 <memmove+0xea>
    1b80:	0036589b          	srliw	a7,a2,0x3
    1b84:	088e                	slli	a7,a7,0x3
    1b86:	2601                	sext.w	a2,a2
    1b88:	87ae                	mv	a5,a1
    1b8a:	86aa                	mv	a3,a0
    1b8c:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1b8e:	0007b803          	ld	a6,0(a5)
    1b92:	07a1                	addi	a5,a5,8
    1b94:	06a1                	addi	a3,a3,8
    1b96:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1b9a:	ff179ae3          	bne	a5,a7,1b8e <memmove+0x40>
    1b9e:	ff867813          	andi	a6,a2,-8
    1ba2:	02081793          	slli	a5,a6,0x20
    1ba6:	9381                	srli	a5,a5,0x20
    1ba8:	00f506b3          	add	a3,a0,a5
    1bac:	95be                	add	a1,a1,a5
    1bae:	4107073b          	subw	a4,a4,a6
    1bb2:	09060263          	beq	a2,a6,1c36 <memmove+0xe8>
            *dst++ = *src++;
    1bb6:	0005c783          	lbu	a5,0(a1)
    1bba:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1bbe:	06e05c63          	blez	a4,1c36 <memmove+0xe8>
            *dst++ = *src++;
    1bc2:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1bc6:	4785                	li	a5,1
            *dst++ = *src++;
    1bc8:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1bcc:	06e7d563          	bge	a5,a4,1c36 <memmove+0xe8>
            *dst++ = *src++;
    1bd0:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1bd4:	4789                	li	a5,2
            *dst++ = *src++;
    1bd6:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1bda:	04e7de63          	bge	a5,a4,1c36 <memmove+0xe8>
            *dst++ = *src++;
    1bde:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1be2:	478d                	li	a5,3
            *dst++ = *src++;
    1be4:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1be8:	04e7d763          	bge	a5,a4,1c36 <memmove+0xe8>
            *dst++ = *src++;
    1bec:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1bf0:	4791                	li	a5,4
            *dst++ = *src++;
    1bf2:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1bf6:	04e7d063          	bge	a5,a4,1c36 <memmove+0xe8>
            *dst++ = *src++;
    1bfa:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1bfe:	4795                	li	a5,5
            *dst++ = *src++;
    1c00:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1c04:	02e7d963          	bge	a5,a4,1c36 <memmove+0xe8>
            *dst++ = *src++;
    1c08:	0065c783          	lbu	a5,6(a1)
    1c0c:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1c10:	8082                	ret
    } else {
        dst += n;
    1c12:	00c507b3          	add	a5,a0,a2
        src += n;
    1c16:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1c18:	00c05f63          	blez	a2,1c36 <memmove+0xe8>
    1c1c:	1702                	slli	a4,a4,0x20
    1c1e:	9301                	srli	a4,a4,0x20
    1c20:	fff74713          	not	a4,a4
    1c24:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1c26:	fff5c683          	lbu	a3,-1(a1)
    1c2a:	17fd                	addi	a5,a5,-1
    1c2c:	15fd                	addi	a1,a1,-1
    1c2e:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1c32:	fee79ae3          	bne	a5,a4,1c26 <memmove+0xd8>
    }
    return vdst;
}
    1c36:	8082                	ret
    1c38:	02071693          	slli	a3,a4,0x20
    1c3c:	9281                	srli	a3,a3,0x20
    1c3e:	0685                	addi	a3,a3,1
    1c40:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1c42:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1c44:	0005c703          	lbu	a4,0(a1)
    1c48:	0585                	addi	a1,a1,1
    1c4a:	0785                	addi	a5,a5,1
    1c4c:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1c50:	fed59ae3          	bne	a1,a3,1c44 <memmove+0xf6>
    1c54:	8082                	ret

0000000000001c56 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1c56:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c5a:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1c5e:	2501                	sext.w	a0,a0
    1c60:	8082                	ret

0000000000001c62 <exec>:
    register long a7 __asm__("a7") = n;
    1c62:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1c66:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c68:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1c6c:	2501                	sext.w	a0,a0
    1c6e:	8082                	ret

0000000000001c70 <exit>:
    register long a7 __asm__("a7") = n;
    1c70:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1c74:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1c78:	8082                	ret

0000000000001c7a <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1c7a:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c7e:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1c82:	8082                	ret

0000000000001c84 <write>:
    register long a7 __asm__("a7") = n;
    1c84:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c88:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1c8c:	8082                	ret

0000000000001c8e <getpid>:
    register long a7 __asm__("a7") = n;
    1c8e:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c92:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c96:	2501                	sext.w	a0,a0
    1c98:	8082                	ret

0000000000001c9a <getppid>:
    register long a7 __asm__("a7") = n;
    1c9a:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c9e:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1ca2:	2501                	sext.w	a0,a0
    1ca4:	8082                	ret

0000000000001ca6 <open>:
    register long a7 __asm__("a7") = n;
    1ca6:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1caa:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1cae:	2501                	sext.w	a0,a0
    1cb0:	8082                	ret

0000000000001cb2 <mknod>:
    register long a7 __asm__("a7") = n;
    1cb2:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cb6:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1cba:	2501                	sext.w	a0,a0
    1cbc:	8082                	ret

0000000000001cbe <dup>:
    register long a7 __asm__("a7") = n;
    1cbe:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1cc0:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1cc4:	2501                	sext.w	a0,a0
    1cc6:	8082                	ret

0000000000001cc8 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cc8:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1ccc:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cd0:	2501                	sext.w	a0,a0
    1cd2:	8082                	ret

0000000000001cd4 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cd4:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cd8:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1cdc:	2501                	sext.w	a0,a0
    1cde:	8082                	ret

0000000000001ce0 <wait>:

pid_t wait(int *wstatus)
{
    1ce0:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1ce2:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1ce6:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ce8:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1cec:	2501                	sext.w	a0,a0
    1cee:	8082                	ret

0000000000001cf0 <mkdir>:
    register long a7 __asm__("a7") = n;
    1cf0:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1cf4:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1cf8:	2501                	sext.w	a0,a0
    1cfa:	8082                	ret

0000000000001cfc <close>:
    register long a7 __asm__("a7") = n;
    1cfc:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1d00:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1d04:	2501                	sext.w	a0,a0
    1d06:	8082                	ret

0000000000001d08 <fork>:
    register long a7 __asm__("a7") = n;
    1d08:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1d0c:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1d10:	2501                	sext.w	a0,a0
    1d12:	8082                	ret

0000000000001d14 <time_ms>:
    register long a7 __asm__("a7") = n;
    1d14:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d18:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1d1c:	8082                	ret

0000000000001d1e <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1d1e:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1d20:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d24:	00000073          	ecall
    1d28:	87aa                	mv	a5,a0
    1d2a:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1d2e:	97ba                	add	a5,a5,a4
    1d30:	00f57c63          	bgeu	a0,a5,1d48 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1d34:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1d38:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d3c:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d40:	00000073          	ecall
    1d44:	fef568e3          	bltu	a0,a5,1d34 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1d48:	4501                	li	a0,0
    1d4a:	8082                	ret

0000000000001d4c <pipe>:
    register long a7 __asm__("a7") = n;
    1d4c:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1d50:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1d54:	2501                	sext.w	a0,a0
    1d56:	8082                	ret

0000000000001d58 <fstat>:
    register long a7 __asm__("a7") = n;
    1d58:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d5c:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1d60:	2501                	sext.w	a0,a0
    1d62:	8082                	ret

0000000000001d64 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1d64:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1d66:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1d6a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d6c:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1d70:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1d74:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1d78:	0206c163          	bltz	a3,1d9a <stat+0x36>
    register long a7 __asm__("a7") = n;
    1d7c:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1d80:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1d82:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d84:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d88:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1d8c:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1d90:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1d92:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1d96:	853e                	mv	a0,a5
    1d98:	8082                	ret
        return -1;
    1d9a:	57fd                	li	a5,-1
    1d9c:	bfed                	j	1d96 <stat+0x32>

0000000000001d9e <chdir>:
    register long a7 __asm__("a7") = n;
    1d9e:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1da2:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1da6:	2501                	sext.w	a0,a0
    1da8:	8082                	ret

0000000000001daa <link>:
    register long a7 __asm__("a7") = n;
    1daa:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dae:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1db2:	2501                	sext.w	a0,a0
    1db4:	8082                	ret

0000000000001db6 <unlink>:
    register long a7 __asm__("a7") = n;
    1db6:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1dba:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1dbe:	2501                	sext.w	a0,a0
    1dc0:	8082                	ret

0000000000001dc2 <setpriority>:
    register long a7 __asm__("a7") = n;
    1dc2:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1dc6:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1dca:	8082                	ret

0000000000001dcc <getpriority>:
    register long a7 __asm__("a7") = n;
    1dcc:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1dd0:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1dd4:	8082                	ret

0000000000001dd6 <sharedmem>:
    register long a7 __asm__("a7") = n;
    1dd6:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dda:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1dde:	8082                	ret
