
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_pid:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a079                	j	108e <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <ucore.h>
#include <fcntl.h>
#include <string.h>

int main()
{
    1002:	7179                	addi	sp,sp,-48
    1004:	f406                	sd	ra,40(sp)
    1006:	f022                	sd	s0,32(sp)
    1008:	ec26                	sd	s1,24(sp)
    100a:	e84a                	sd	s2,16(sp)
    int ppid;
    int cpid;
    ppid = getpid();
    100c:	477000ef          	jal	ra,1c82 <getpid>
    printf("parent get parent pid = %d\n", ppid);
    1010:	85aa                	mv	a1,a0
    ppid = getpid();
    1012:	842a                	mv	s0,a0
    printf("parent get parent pid = %d\n", ppid);
    1014:	00001517          	auipc	a0,0x1
    1018:	dc450513          	addi	a0,a0,-572 # 1dd8 <sharedmem+0xe>
    101c:	108000ef          	jal	ra,1124 <printf>
    int exit_code;
    cpid = fork();
    1020:	4dd000ef          	jal	ra,1cfc <fork>
    if (cpid == 0)
    1024:	e139                	bnez	a0,106a <main+0x68>
    {
        // child
        int t = getppid();
    1026:	469000ef          	jal	ra,1c8e <getppid>
    102a:	84aa                	mv	s1,a0
        int t2 = getpid();
    102c:	457000ef          	jal	ra,1c82 <getpid>
    1030:	892a                	mv	s2,a0
        printf("child get parent pid = %d\n", t);
    1032:	85a6                	mv	a1,s1
    1034:	00001517          	auipc	a0,0x1
    1038:	dc450513          	addi	a0,a0,-572 # 1df8 <sharedmem+0x2e>
    103c:	0e8000ef          	jal	ra,1124 <printf>
        printf("child get child pid = %d\n", t2);
    1040:	85ca                	mv	a1,s2
    1042:	00001517          	auipc	a0,0x1
    1046:	dd650513          	addi	a0,a0,-554 # 1e18 <sharedmem+0x4e>
    104a:	0da000ef          	jal	ra,1124 <printf>
        assert(t == ppid, -2);
    104e:	40940533          	sub	a0,s0,s1
    1052:	55f9                	li	a1,-2
    1054:	00153513          	seqz	a0,a0
    1058:	45e000ef          	jal	ra,14b6 <assert>
        printf("parent get child pid = %d\n", cpid);
        assert(exit_code == 0,-4);
    }

    return 0;
    105c:	70a2                	ld	ra,40(sp)
    105e:	7402                	ld	s0,32(sp)
    1060:	64e2                	ld	s1,24(sp)
    1062:	6942                	ld	s2,16(sp)
    1064:	4501                	li	a0,0
    1066:	6145                	addi	sp,sp,48
    1068:	8082                	ret
        wait(&exit_code);
    106a:	84aa                	mv	s1,a0
    106c:	0068                	addi	a0,sp,12
    106e:	467000ef          	jal	ra,1cd4 <wait>
        printf("parent get child pid = %d\n", cpid);
    1072:	85a6                	mv	a1,s1
    1074:	00001517          	auipc	a0,0x1
    1078:	dc450513          	addi	a0,a0,-572 # 1e38 <sharedmem+0x6e>
    107c:	0a8000ef          	jal	ra,1124 <printf>
        assert(exit_code == 0,-4);
    1080:	4532                	lw	a0,12(sp)
    1082:	55f1                	li	a1,-4
    1084:	00153513          	seqz	a0,a0
    1088:	42e000ef          	jal	ra,14b6 <assert>
    108c:	bfc1                	j	105c <main+0x5a>

000000000000108e <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    108e:	1141                	addi	sp,sp,-16
    1090:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    1092:	f71ff0ef          	jal	ra,1002 <main>
}
    1096:	60a2                	ld	ra,8(sp)
    1098:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    109a:	3cb0006f          	j	1c64 <exit>

000000000000109e <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    109e:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    10a0:	00f10593          	addi	a1,sp,15
    10a4:	4605                	li	a2,1
    10a6:	4501                	li	a0,0
int getchar() {
    10a8:	ec06                	sd	ra,24(sp)
    char byte = 0;
    10aa:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    10ae:	3c1000ef          	jal	ra,1c6e <read>
    return byte;
}
    10b2:	60e2                	ld	ra,24(sp)
    10b4:	00f14503          	lbu	a0,15(sp)
    10b8:	6105                	addi	sp,sp,32
    10ba:	8082                	ret

00000000000010bc <putchar>:

int putchar(int c)
{
    10bc:	1141                	addi	sp,sp,-16
    10be:	e406                	sd	ra,8(sp)
    10c0:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    10c2:	00001597          	auipc	a1,0x1
    10c6:	dbe58593          	addi	a1,a1,-578 # 1e80 <put.1156>
    return write(stdout, put, 1);
    10ca:	4605                	li	a2,1
    10cc:	4505                	li	a0,1
    put[0] = c;
    10ce:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    10d2:	3a7000ef          	jal	ra,1c78 <write>
}
    10d6:	60a2                	ld	ra,8(sp)
    10d8:	2501                	sext.w	a0,a0
    10da:	0141                	addi	sp,sp,16
    10dc:	8082                	ret

00000000000010de <puts>:

int puts(const char* s)
{
    10de:	1141                	addi	sp,sp,-16
    10e0:	e022                	sd	s0,0(sp)
    10e2:	e406                	sd	ra,8(sp)
    10e4:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    10e6:	6b6000ef          	jal	ra,179c <strlen>
    10ea:	862a                	mv	a2,a0
    10ec:	85a2                	mv	a1,s0
    10ee:	4505                	li	a0,1
    10f0:	389000ef          	jal	ra,1c78 <write>
    10f4:	00055763          	bgez	a0,1102 <puts+0x24>
    return r;
}
    10f8:	60a2                	ld	ra,8(sp)
    10fa:	6402                	ld	s0,0(sp)
    10fc:	557d                	li	a0,-1
    10fe:	0141                	addi	sp,sp,16
    1100:	8082                	ret
    put[0] = c;
    1102:	00001597          	auipc	a1,0x1
    1106:	d7e58593          	addi	a1,a1,-642 # 1e80 <put.1156>
    110a:	47a9                	li	a5,10
    return write(stdout, put, 1);
    110c:	4605                	li	a2,1
    110e:	4505                	li	a0,1
    put[0] = c;
    1110:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1114:	365000ef          	jal	ra,1c78 <write>
}
    1118:	60a2                	ld	ra,8(sp)
    111a:	6402                	ld	s0,0(sp)
    111c:	41f5551b          	sraiw	a0,a0,0x1f
    1120:	0141                	addi	sp,sp,16
    1122:	8082                	ret

0000000000001124 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    1124:	7115                	addi	sp,sp,-224
    1126:	ed06                	sd	ra,152(sp)
    1128:	e922                	sd	s0,144(sp)
    112a:	e526                	sd	s1,136(sp)
    112c:	e14a                	sd	s2,128(sp)
    112e:	fcce                	sd	s3,120(sp)
    1130:	f8d2                	sd	s4,112(sp)
    1132:	f4d6                	sd	s5,104(sp)
    1134:	f0da                	sd	s6,96(sp)
    1136:	ecde                	sd	s7,88(sp)
    1138:	e8e2                	sd	s8,80(sp)
    113a:	e4e6                	sd	s9,72(sp)
    113c:	e0ea                	sd	s10,64(sp)
    113e:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1140:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    1144:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    1146:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    1148:	f52e                	sd	a1,168(sp)
    114a:	f932                	sd	a2,176(sp)
    114c:	fd36                	sd	a3,184(sp)
    114e:	e1ba                	sd	a4,192(sp)
    1150:	e9c2                	sd	a6,208(sp)
    1152:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    1154:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1156:	0c030b63          	beqz	t1,122c <printf+0x108>
    115a:	8aaa                	mv	s5,a0
    115c:	0003071b          	sext.w	a4,t1
    1160:	4481                	li	s1,0
        if (c != '%') {
    1162:	02500b93          	li	s7,37
    put[0] = c;
    1166:	00001417          	auipc	s0,0x1
    116a:	d1a40413          	addi	s0,s0,-742 # 1e80 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    116e:	4c51                	li	s8,20
    put[0] = c;
    1170:	02500c93          	li	s9,37
    1174:	00001a17          	auipc	s4,0x1
    1178:	d1ca0a13          	addi	s4,s4,-740 # 1e90 <seed+0x8>
    117c:	00001997          	auipc	s3,0x1
    1180:	d6c98993          	addi	s3,s3,-660 # 1ee8 <digits>
    1184:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    1188:	0014879b          	addiw	a5,s1,1
    118c:	00fa8933          	add	s2,s5,a5
    1190:	13771163          	bne	a4,s7,12b2 <printf+0x18e>
        c = fmt[++i] & 0xff;
    1194:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    1198:	080d0a63          	beqz	s10,122c <printf+0x108>
        switch (c) {
    119c:	2489                	addiw	s1,s1,2
    119e:	009a8933          	add	s2,s5,s1
    11a2:	257d0e63          	beq	s10,s7,13fe <printf+0x2da>
    11a6:	f9cd079b          	addiw	a5,s10,-100
    11aa:	0ff7f793          	andi	a5,a5,255
    11ae:	0cfc6263          	bltu	s8,a5,1272 <printf+0x14e>
    11b2:	078a                	slli	a5,a5,0x2
    11b4:	97d2                	add	a5,a5,s4
    11b6:	439c                	lw	a5,0(a5)
    11b8:	97d2                	add	a5,a5,s4
    11ba:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    11bc:	67a2                	ld	a5,8(sp)
    11be:	4398                	lw	a4,0(a5)
    11c0:	07a1                	addi	a5,a5,8
    11c2:	e43e                	sd	a5,8(sp)
    11c4:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    11c8:	26074663          	bltz	a4,1434 <printf+0x310>
        buf[i++] = digits[x % base];
    11cc:	8bbd                	andi	a5,a5,15
    11ce:	97ce                	add	a5,a5,s3
    11d0:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    11d4:	40475d1b          	sraiw	s10,a4,0x4
    11d8:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    11dc:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    11e0:	020d0163          	beqz	s10,1202 <printf+0xde>
        buf[i++] = digits[x % base];
    11e4:	9d4e                	add	s10,s10,s3
    11e6:	000d4783          	lbu	a5,0(s10)
    11ea:	4d05                	li	s10,1
    11ec:	00f108a3          	sb	a5,17(sp)
    if (sign)
    11f0:	00075963          	bgez	a4,1202 <printf+0xde>
        buf[i++] = digits[x % base];
    11f4:	4d09                	li	s10,2
        buf[i++] = '-';
    11f6:	181c                	addi	a5,sp,48
    11f8:	02d00713          	li	a4,45
    11fc:	97ea                	add	a5,a5,s10
    11fe:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    1202:	9d5a                	add	s10,s10,s6
    1204:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1208:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    120c:	4605                	li	a2,1
    120e:	1d7d                	addi	s10,s10,-1
    1210:	85a2                	mv	a1,s0
    1212:	4505                	li	a0,1
    put[0] = c;
    1214:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1218:	261000ef          	jal	ra,1c78 <write>
    while (--i >= 0)
    121c:	ffbd16e3          	bne	s10,s11,1208 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1220:	00094303          	lbu	t1,0(s2)
    1224:	0003071b          	sext.w	a4,t1
    1228:	f60310e3          	bnez	t1,1188 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    122c:	60ea                	ld	ra,152(sp)
    122e:	644a                	ld	s0,144(sp)
    1230:	64aa                	ld	s1,136(sp)
    1232:	690a                	ld	s2,128(sp)
    1234:	79e6                	ld	s3,120(sp)
    1236:	7a46                	ld	s4,112(sp)
    1238:	7aa6                	ld	s5,104(sp)
    123a:	7b06                	ld	s6,96(sp)
    123c:	6be6                	ld	s7,88(sp)
    123e:	6c46                	ld	s8,80(sp)
    1240:	6ca6                	ld	s9,72(sp)
    1242:	6d06                	ld	s10,64(sp)
    1244:	7de2                	ld	s11,56(sp)
    1246:	612d                	addi	sp,sp,224
    1248:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    124a:	67a2                	ld	a5,8(sp)
    124c:	0007bd03          	ld	s10,0(a5)
    1250:	07a1                	addi	a5,a5,8
    1252:	e43e                	sd	a5,8(sp)
    1254:	000d1b63          	bnez	s10,126a <printf+0x146>
    1258:	aafd                	j	1456 <printf+0x332>
    return write(stdout, put, 1);
    125a:	4605                	li	a2,1
    125c:	85a2                	mv	a1,s0
    125e:	4505                	li	a0,1
                for (; *s; s++)
    1260:	0d05                	addi	s10,s10,1
    put[0] = c;
    1262:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1266:	213000ef          	jal	ra,1c78 <write>
                for (; *s; s++)
    126a:	000d4783          	lbu	a5,0(s10)
    126e:	f7f5                	bnez	a5,125a <printf+0x136>
    1270:	a02d                	j	129a <printf+0x176>
    return write(stdout, put, 1);
    1272:	4605                	li	a2,1
    1274:	00001597          	auipc	a1,0x1
    1278:	c0c58593          	addi	a1,a1,-1012 # 1e80 <put.1156>
    127c:	4505                	li	a0,1
    put[0] = c;
    127e:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    1282:	1f7000ef          	jal	ra,1c78 <write>
    1286:	4605                	li	a2,1
    1288:	00001597          	auipc	a1,0x1
    128c:	bf858593          	addi	a1,a1,-1032 # 1e80 <put.1156>
    1290:	4505                	li	a0,1
    put[0] = c;
    1292:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    1296:	1e3000ef          	jal	ra,1c78 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    129a:	00094303          	lbu	t1,0(s2)
    129e:	0003071b          	sext.w	a4,t1
    12a2:	f80305e3          	beqz	t1,122c <printf+0x108>
        if (c != '%') {
    12a6:	0014879b          	addiw	a5,s1,1
    12aa:	00fa8933          	add	s2,s5,a5
    12ae:	ef7703e3          	beq	a4,s7,1194 <printf+0x70>
    return write(stdout, put, 1);
    12b2:	4605                	li	a2,1
    12b4:	00001597          	auipc	a1,0x1
    12b8:	bcc58593          	addi	a1,a1,-1076 # 1e80 <put.1156>
    12bc:	4505                	li	a0,1
    put[0] = c;
    12be:	00640023          	sb	t1,0(s0)
            continue;
    12c2:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    12c4:	1b5000ef          	jal	ra,1c78 <write>
            continue;
    12c8:	bfc9                	j	129a <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    12ca:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    12cc:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    12ce:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    12d0:	0007b883          	ld	a7,0(a5)
    12d4:	07a1                	addi	a5,a5,8
    12d6:	e43e                	sd	a5,8(sp)
        x = -xx;
    12d8:	43f8d713          	srai	a4,a7,0x3f
    12dc:	011747b3          	xor	a5,a4,a7
    12e0:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    12e2:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    12e4:	02c7f733          	remu	a4,a5,a2
    12e8:	8d36                	mv	s10,a3
    12ea:	0685                	addi	a3,a3,1
    12ec:	00db0533          	add	a0,s6,a3
    12f0:	85be                	mv	a1,a5
    12f2:	974e                	add	a4,a4,s3
    12f4:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    12f8:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    12fc:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    1300:	feb862e3          	bltu	a6,a1,12e4 <printf+0x1c0>
    if (sign)
    1304:	1208c063          	bltz	a7,1424 <printf+0x300>
    while (--i >= 0)
    1308:	9d5a                	add	s10,s10,s6
    put[0] = c;
    130a:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    130e:	4605                	li	a2,1
    1310:	85a2                	mv	a1,s0
    1312:	4505                	li	a0,1
    put[0] = c;
    1314:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1318:	161000ef          	jal	ra,1c78 <write>
    while (--i >= 0)
    131c:	87ea                	mv	a5,s10
    131e:	1d7d                	addi	s10,s10,-1
    1320:	fefb15e3          	bne	s6,a5,130a <printf+0x1e6>
    1324:	bf9d                	j	129a <printf+0x176>
                printptr(va_arg(ap, uint64));
    1326:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    1328:	4605                	li	a2,1
    132a:	00001597          	auipc	a1,0x1
    132e:	b5658593          	addi	a1,a1,-1194 # 1e80 <put.1156>
                printptr(va_arg(ap, uint64));
    1332:	0007bd83          	ld	s11,0(a5)
    1336:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    133a:	4505                	li	a0,1
    put[0] = c;
    133c:	03000793          	li	a5,48
    1340:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    1344:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    1346:	133000ef          	jal	ra,1c78 <write>
    put[0] = c;
    134a:	07800793          	li	a5,120
    return write(stdout, put, 1);
    134e:	4605                	li	a2,1
    1350:	00001597          	auipc	a1,0x1
    1354:	b3058593          	addi	a1,a1,-1232 # 1e80 <put.1156>
    1358:	4505                	li	a0,1
    put[0] = c;
    135a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    135e:	4d41                	li	s10,16
    1360:	119000ef          	jal	ra,1c78 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    1364:	03cdd793          	srli	a5,s11,0x3c
    1368:	97ce                	add	a5,a5,s3
    put[0] = c;
    136a:	0007c783          	lbu	a5,0(a5)
    136e:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    1370:	4605                	li	a2,1
    1372:	85a2                	mv	a1,s0
    1374:	4505                	li	a0,1
    put[0] = c;
    1376:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    137a:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    137c:	0fd000ef          	jal	ra,1c78 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1380:	fe0d12e3          	bnez	s10,1364 <printf+0x240>
    1384:	bf19                	j	129a <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    1386:	67a2                	ld	a5,8(sp)
    1388:	4394                	lw	a3,0(a5)
    138a:	07a1                	addi	a5,a5,8
    138c:	e43e                	sd	a5,8(sp)
    138e:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    1392:	0006d663          	bgez	a3,139e <printf+0x27a>
        x = -xx;
    1396:	40f007bb          	negw	a5,a5
    139a:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    139e:	4729                	li	a4,10
    13a0:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    13a4:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    13a8:	964e                	add	a2,a2,s3
    13aa:	00064603          	lbu	a2,0(a2)
    13ae:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    13b2:	0a0d0963          	beqz	s10,1464 <printf+0x340>
        buf[i++] = digits[x % base];
    13b6:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    13ba:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    13be:	00c98733          	add	a4,s3,a2
    13c2:	00074703          	lbu	a4,0(a4)
    13c6:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    13ca:	c3cd                	beqz	a5,146c <printf+0x348>
        buf[i++] = digits[x % base];
    13cc:	97ce                	add	a5,a5,s3
    13ce:	0007c703          	lbu	a4,0(a5)
    13d2:	4d09                	li	s10,2
    13d4:	478d                	li	a5,3
    13d6:	00e10923          	sb	a4,18(sp)
    if (sign)
    13da:	0206cd63          	bltz	a3,1414 <printf+0x2f0>
    while (--i >= 0)
    13de:	9d5a                	add	s10,s10,s6
    13e0:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    13e4:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    13e8:	4605                	li	a2,1
    13ea:	1d7d                	addi	s10,s10,-1
    13ec:	85a2                	mv	a1,s0
    13ee:	4505                	li	a0,1
    put[0] = c;
    13f0:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    13f4:	085000ef          	jal	ra,1c78 <write>
    while (--i >= 0)
    13f8:	ffbd16e3          	bne	s10,s11,13e4 <printf+0x2c0>
    13fc:	bd79                	j	129a <printf+0x176>
    return write(stdout, put, 1);
    13fe:	4605                	li	a2,1
    1400:	00001597          	auipc	a1,0x1
    1404:	a8058593          	addi	a1,a1,-1408 # 1e80 <put.1156>
    1408:	4505                	li	a0,1
    put[0] = c;
    140a:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    140e:	06b000ef          	jal	ra,1c78 <write>
    1412:	b561                	j	129a <printf+0x176>
        buf[i++] = '-';
    1414:	1818                	addi	a4,sp,48
    1416:	973e                	add	a4,a4,a5
    1418:	02d00693          	li	a3,45
    141c:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    1420:	8d3e                	mv	s10,a5
    1422:	bf75                	j	13de <printf+0x2ba>
        buf[i++] = '-';
    1424:	181c                	addi	a5,sp,48
    1426:	97b6                	add	a5,a5,a3
    1428:	02d00713          	li	a4,45
    142c:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    1430:	8d36                	mv	s10,a3
    1432:	bdd9                	j	1308 <printf+0x1e4>
        x = -xx;
    1434:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    1438:	00f7f693          	andi	a3,a5,15
    143c:	96ce                	add	a3,a3,s3
    143e:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    1442:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    1446:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    144a:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    144e:	d80d1be3          	bnez	s10,11e4 <printf+0xc0>
        buf[i++] = digits[x % base];
    1452:	4d05                	li	s10,1
    1454:	b34d                	j	11f6 <printf+0xd2>
                s = "(null)";
    1456:	00001d17          	auipc	s10,0x1
    145a:	a02d0d13          	addi	s10,s10,-1534 # 1e58 <sharedmem+0x8e>
                for (; *s; s++)
    145e:	02800793          	li	a5,40
    1462:	bbe5                	j	125a <printf+0x136>
        buf[i++] = digits[x % base];
    1464:	4785                	li	a5,1
    if (sign)
    1466:	f606dce3          	bgez	a3,13de <printf+0x2ba>
    146a:	b76d                	j	1414 <printf+0x2f0>
        buf[i++] = digits[x % base];
    146c:	4789                	li	a5,2
    146e:	4d05                	li	s10,1
    if (sign)
    1470:	f606d7e3          	bgez	a3,13de <printf+0x2ba>
    1474:	b745                	j	1414 <printf+0x2f0>

0000000000001476 <srand>:
#include <ucore.h>

static uint64 seed;

void srand(unsigned s) {
    seed = s - 1;
    1476:	357d                	addiw	a0,a0,-1
    1478:	1502                	slli	a0,a0,0x20
    147a:	9101                	srli	a0,a0,0x20
    147c:	00001797          	auipc	a5,0x1
    1480:	a0a7b623          	sd	a0,-1524(a5) # 1e88 <seed>
}
    1484:	8082                	ret

0000000000001486 <rand>:

int rand(void) {
    seed = 6364136223846793005ULL * seed + 1;
    1486:	00001797          	auipc	a5,0x1
    148a:	a0278793          	addi	a5,a5,-1534 # 1e88 <seed>
    148e:	6388                	ld	a0,0(a5)
    1490:	00001717          	auipc	a4,0x1
    1494:	9d073703          	ld	a4,-1584(a4) # 1e60 <sharedmem+0x96>
    1498:	02e50533          	mul	a0,a0,a4
    149c:	0505                	addi	a0,a0,1
    149e:	e388                	sd	a0,0(a5)
    return seed >> 33;
}
    14a0:	9105                	srli	a0,a0,0x21
    14a2:	8082                	ret

00000000000014a4 <panic>:

void panic(char* m) {
    14a4:	1141                	addi	sp,sp,-16
    14a6:	e406                	sd	ra,8(sp)
    puts(m);
    14a8:	c37ff0ef          	jal	ra,10de <puts>
    exit(-100);
}
    14ac:	60a2                	ld	ra,8(sp)
    exit(-100);
    14ae:	f9c00513          	li	a0,-100
}
    14b2:	0141                	addi	sp,sp,16
    exit(-100);
    14b4:	af45                	j	1c64 <exit>

00000000000014b6 <assert>:

void assert(int f, int code) {
    if(!f) {
    14b6:	c111                	beqz	a0,14ba <assert+0x4>
        exit(code);
    }
    14b8:	8082                	ret
        exit(code);
    14ba:	852e                	mv	a0,a1
    14bc:	a765                	j	1c64 <exit>

00000000000014be <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    14be:	02000793          	li	a5,32
    14c2:	00f50663          	beq	a0,a5,14ce <isspace+0x10>
    14c6:	355d                	addiw	a0,a0,-9
    14c8:	00553513          	sltiu	a0,a0,5
    14cc:	8082                	ret
    14ce:	4505                	li	a0,1
}
    14d0:	8082                	ret

00000000000014d2 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    14d2:	fd05051b          	addiw	a0,a0,-48
}
    14d6:	00a53513          	sltiu	a0,a0,10
    14da:	8082                	ret

00000000000014dc <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    14dc:	02000613          	li	a2,32
    14e0:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    14e2:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    14e6:	ff77069b          	addiw	a3,a4,-9
    14ea:	04c70d63          	beq	a4,a2,1544 <atoi+0x68>
    14ee:	0007079b          	sext.w	a5,a4
    14f2:	04d5f963          	bgeu	a1,a3,1544 <atoi+0x68>
        s++;
    switch (*s) {
    14f6:	02b00693          	li	a3,43
    14fa:	04d70a63          	beq	a4,a3,154e <atoi+0x72>
    14fe:	02d00693          	li	a3,45
    1502:	06d70463          	beq	a4,a3,156a <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1506:	fd07859b          	addiw	a1,a5,-48
    150a:	4625                	li	a2,9
    150c:	873e                	mv	a4,a5
    150e:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1510:	4e01                	li	t3,0
    while (isdigit(*s))
    1512:	04b66a63          	bltu	a2,a1,1566 <atoi+0x8a>
    int n = 0, neg = 0;
    1516:	4501                	li	a0,0
    while (isdigit(*s))
    1518:	4825                	li	a6,9
    151a:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    151e:	0025179b          	slliw	a5,a0,0x2
    1522:	9d3d                	addw	a0,a0,a5
    1524:	fd07031b          	addiw	t1,a4,-48
    1528:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    152c:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1530:	0685                	addi	a3,a3,1
    1532:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1536:	0006071b          	sext.w	a4,a2
    153a:	feb870e3          	bgeu	a6,a1,151a <atoi+0x3e>
    return neg ? n : -n;
    153e:	000e0563          	beqz	t3,1548 <atoi+0x6c>
}
    1542:	8082                	ret
        s++;
    1544:	0505                	addi	a0,a0,1
    1546:	bf71                	j	14e2 <atoi+0x6>
    1548:	4113053b          	subw	a0,t1,a7
    154c:	8082                	ret
    while (isdigit(*s))
    154e:	00154783          	lbu	a5,1(a0)
    1552:	4625                	li	a2,9
        s++;
    1554:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1558:	fd07859b          	addiw	a1,a5,-48
    155c:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1560:	4e01                	li	t3,0
    while (isdigit(*s))
    1562:	fab67ae3          	bgeu	a2,a1,1516 <atoi+0x3a>
    1566:	4501                	li	a0,0
}
    1568:	8082                	ret
    while (isdigit(*s))
    156a:	00154783          	lbu	a5,1(a0)
    156e:	4625                	li	a2,9
        s++;
    1570:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1574:	fd07859b          	addiw	a1,a5,-48
    1578:	0007871b          	sext.w	a4,a5
    157c:	feb665e3          	bltu	a2,a1,1566 <atoi+0x8a>
        neg = 1;
    1580:	4e05                	li	t3,1
    1582:	bf51                	j	1516 <atoi+0x3a>

0000000000001584 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    1584:	16060d63          	beqz	a2,16fe <memset+0x17a>
    1588:	40a007b3          	neg	a5,a0
    158c:	8b9d                	andi	a5,a5,7
    158e:	00778713          	addi	a4,a5,7
    1592:	482d                	li	a6,11
    1594:	0ff5f593          	andi	a1,a1,255
    1598:	fff60693          	addi	a3,a2,-1
    159c:	17076263          	bltu	a4,a6,1700 <memset+0x17c>
    15a0:	16e6ea63          	bltu	a3,a4,1714 <memset+0x190>
    15a4:	16078563          	beqz	a5,170e <memset+0x18a>
    15a8:	00b50023          	sb	a1,0(a0)
    15ac:	4705                	li	a4,1
    15ae:	00150e93          	addi	t4,a0,1
    15b2:	14e78c63          	beq	a5,a4,170a <memset+0x186>
    15b6:	00b500a3          	sb	a1,1(a0)
    15ba:	4709                	li	a4,2
    15bc:	00250e93          	addi	t4,a0,2
    15c0:	14e78d63          	beq	a5,a4,171a <memset+0x196>
    15c4:	00b50123          	sb	a1,2(a0)
    15c8:	470d                	li	a4,3
    15ca:	00350e93          	addi	t4,a0,3
    15ce:	12e78b63          	beq	a5,a4,1704 <memset+0x180>
    15d2:	00b501a3          	sb	a1,3(a0)
    15d6:	4711                	li	a4,4
    15d8:	00450e93          	addi	t4,a0,4
    15dc:	14e78163          	beq	a5,a4,171e <memset+0x19a>
    15e0:	00b50223          	sb	a1,4(a0)
    15e4:	4715                	li	a4,5
    15e6:	00550e93          	addi	t4,a0,5
    15ea:	12e78c63          	beq	a5,a4,1722 <memset+0x19e>
    15ee:	00b502a3          	sb	a1,5(a0)
    15f2:	471d                	li	a4,7
    15f4:	00650e93          	addi	t4,a0,6
    15f8:	12e79763          	bne	a5,a4,1726 <memset+0x1a2>
    15fc:	00750e93          	addi	t4,a0,7
    1600:	00b50323          	sb	a1,6(a0)
    1604:	4f1d                	li	t5,7
    1606:	00859713          	slli	a4,a1,0x8
    160a:	8f4d                	or	a4,a4,a1
    160c:	01059e13          	slli	t3,a1,0x10
    1610:	01c76e33          	or	t3,a4,t3
    1614:	01859313          	slli	t1,a1,0x18
    1618:	006e6333          	or	t1,t3,t1
    161c:	02059893          	slli	a7,a1,0x20
    1620:	011368b3          	or	a7,t1,a7
    1624:	02859813          	slli	a6,a1,0x28
    1628:	40f60333          	sub	t1,a2,a5
    162c:	0108e833          	or	a6,a7,a6
    1630:	03059693          	slli	a3,a1,0x30
    1634:	00d866b3          	or	a3,a6,a3
    1638:	03859713          	slli	a4,a1,0x38
    163c:	97aa                	add	a5,a5,a0
    163e:	ff837813          	andi	a6,t1,-8
    1642:	8f55                	or	a4,a4,a3
    1644:	00f806b3          	add	a3,a6,a5
    1648:	e398                	sd	a4,0(a5)
    164a:	07a1                	addi	a5,a5,8
    164c:	fed79ee3          	bne	a5,a3,1648 <memset+0xc4>
    1650:	ff837693          	andi	a3,t1,-8
    1654:	00de87b3          	add	a5,t4,a3
    1658:	01e6873b          	addw	a4,a3,t5
    165c:	0ad30663          	beq	t1,a3,1708 <memset+0x184>
    1660:	00b78023          	sb	a1,0(a5)
    1664:	0017069b          	addiw	a3,a4,1
    1668:	08c6fb63          	bgeu	a3,a2,16fe <memset+0x17a>
    166c:	00b780a3          	sb	a1,1(a5)
    1670:	0027069b          	addiw	a3,a4,2
    1674:	08c6f563          	bgeu	a3,a2,16fe <memset+0x17a>
    1678:	00b78123          	sb	a1,2(a5)
    167c:	0037069b          	addiw	a3,a4,3
    1680:	06c6ff63          	bgeu	a3,a2,16fe <memset+0x17a>
    1684:	00b781a3          	sb	a1,3(a5)
    1688:	0047069b          	addiw	a3,a4,4
    168c:	06c6f963          	bgeu	a3,a2,16fe <memset+0x17a>
    1690:	00b78223          	sb	a1,4(a5)
    1694:	0057069b          	addiw	a3,a4,5
    1698:	06c6f363          	bgeu	a3,a2,16fe <memset+0x17a>
    169c:	00b782a3          	sb	a1,5(a5)
    16a0:	0067069b          	addiw	a3,a4,6
    16a4:	04c6fd63          	bgeu	a3,a2,16fe <memset+0x17a>
    16a8:	00b78323          	sb	a1,6(a5)
    16ac:	0077069b          	addiw	a3,a4,7
    16b0:	04c6f763          	bgeu	a3,a2,16fe <memset+0x17a>
    16b4:	00b783a3          	sb	a1,7(a5)
    16b8:	0087069b          	addiw	a3,a4,8
    16bc:	04c6f163          	bgeu	a3,a2,16fe <memset+0x17a>
    16c0:	00b78423          	sb	a1,8(a5)
    16c4:	0097069b          	addiw	a3,a4,9
    16c8:	02c6fb63          	bgeu	a3,a2,16fe <memset+0x17a>
    16cc:	00b784a3          	sb	a1,9(a5)
    16d0:	00a7069b          	addiw	a3,a4,10
    16d4:	02c6f563          	bgeu	a3,a2,16fe <memset+0x17a>
    16d8:	00b78523          	sb	a1,10(a5)
    16dc:	00b7069b          	addiw	a3,a4,11
    16e0:	00c6ff63          	bgeu	a3,a2,16fe <memset+0x17a>
    16e4:	00b785a3          	sb	a1,11(a5)
    16e8:	00c7069b          	addiw	a3,a4,12
    16ec:	00c6f963          	bgeu	a3,a2,16fe <memset+0x17a>
    16f0:	00b78623          	sb	a1,12(a5)
    16f4:	2735                	addiw	a4,a4,13
    16f6:	00c77463          	bgeu	a4,a2,16fe <memset+0x17a>
    16fa:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    16fe:	8082                	ret
    1700:	472d                	li	a4,11
    1702:	bd79                	j	15a0 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1704:	4f0d                	li	t5,3
    1706:	b701                	j	1606 <memset+0x82>
    1708:	8082                	ret
    170a:	4f05                	li	t5,1
    170c:	bded                	j	1606 <memset+0x82>
    170e:	8eaa                	mv	t4,a0
    1710:	4f01                	li	t5,0
    1712:	bdd5                	j	1606 <memset+0x82>
    1714:	87aa                	mv	a5,a0
    1716:	4701                	li	a4,0
    1718:	b7a1                	j	1660 <memset+0xdc>
    171a:	4f09                	li	t5,2
    171c:	b5ed                	j	1606 <memset+0x82>
    171e:	4f11                	li	t5,4
    1720:	b5dd                	j	1606 <memset+0x82>
    1722:	4f15                	li	t5,5
    1724:	b5cd                	j	1606 <memset+0x82>
    1726:	4f19                	li	t5,6
    1728:	bdf9                	j	1606 <memset+0x82>

000000000000172a <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    172a:	00054783          	lbu	a5,0(a0)
    172e:	0005c703          	lbu	a4,0(a1)
    1732:	00e79863          	bne	a5,a4,1742 <strcmp+0x18>
    1736:	0505                	addi	a0,a0,1
    1738:	0585                	addi	a1,a1,1
    173a:	fbe5                	bnez	a5,172a <strcmp>
    173c:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    173e:	9d19                	subw	a0,a0,a4
    1740:	8082                	ret
    1742:	0007851b          	sext.w	a0,a5
    1746:	bfe5                	j	173e <strcmp+0x14>

0000000000001748 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1748:	87aa                	mv	a5,a0
    174a:	0005c703          	lbu	a4,0(a1)
    174e:	0785                	addi	a5,a5,1
    1750:	0585                	addi	a1,a1,1
    1752:	fee78fa3          	sb	a4,-1(a5)
    1756:	fb75                	bnez	a4,174a <strcpy+0x2>
        ;
    return os;
}
    1758:	8082                	ret

000000000000175a <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    175a:	ce05                	beqz	a2,1792 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    175c:	00054703          	lbu	a4,0(a0)
    1760:	0005c783          	lbu	a5,0(a1)
    1764:	cb0d                	beqz	a4,1796 <strncmp+0x3c>
    if (!n--)
    1766:	167d                	addi	a2,a2,-1
    1768:	00c506b3          	add	a3,a0,a2
    176c:	a819                	j	1782 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    176e:	00a68e63          	beq	a3,a0,178a <strncmp+0x30>
    1772:	0505                	addi	a0,a0,1
    1774:	00e79b63          	bne	a5,a4,178a <strncmp+0x30>
    1778:	00054703          	lbu	a4,0(a0)
    177c:	0005c783          	lbu	a5,0(a1)
    1780:	cb19                	beqz	a4,1796 <strncmp+0x3c>
    1782:	0005c783          	lbu	a5,0(a1)
    1786:	0585                	addi	a1,a1,1
    1788:	f3fd                	bnez	a5,176e <strncmp+0x14>
        ;
    return *l - *r;
    178a:	0007051b          	sext.w	a0,a4
    178e:	9d1d                	subw	a0,a0,a5
    1790:	8082                	ret
        return 0;
    1792:	4501                	li	a0,0
}
    1794:	8082                	ret
    1796:	4501                	li	a0,0
    return *l - *r;
    1798:	9d1d                	subw	a0,a0,a5
    179a:	8082                	ret

000000000000179c <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    179c:	00757793          	andi	a5,a0,7
    17a0:	cf89                	beqz	a5,17ba <strlen+0x1e>
    17a2:	87aa                	mv	a5,a0
    17a4:	a029                	j	17ae <strlen+0x12>
    17a6:	0785                	addi	a5,a5,1
    17a8:	0077f713          	andi	a4,a5,7
    17ac:	cb01                	beqz	a4,17bc <strlen+0x20>
        if (!*s)
    17ae:	0007c703          	lbu	a4,0(a5)
    17b2:	fb75                	bnez	a4,17a6 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    17b4:	40a78533          	sub	a0,a5,a0
}
    17b8:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    17ba:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    17bc:	6394                	ld	a3,0(a5)
    17be:	00000597          	auipc	a1,0x0
    17c2:	6aa5b583          	ld	a1,1706(a1) # 1e68 <sharedmem+0x9e>
    17c6:	00000617          	auipc	a2,0x0
    17ca:	6aa63603          	ld	a2,1706(a2) # 1e70 <sharedmem+0xa6>
    17ce:	a019                	j	17d4 <strlen+0x38>
    17d0:	6794                	ld	a3,8(a5)
    17d2:	07a1                	addi	a5,a5,8
    17d4:	00b68733          	add	a4,a3,a1
    17d8:	fff6c693          	not	a3,a3
    17dc:	8f75                	and	a4,a4,a3
    17de:	8f71                	and	a4,a4,a2
    17e0:	db65                	beqz	a4,17d0 <strlen+0x34>
    for (; *s; s++)
    17e2:	0007c703          	lbu	a4,0(a5)
    17e6:	d779                	beqz	a4,17b4 <strlen+0x18>
    17e8:	0017c703          	lbu	a4,1(a5)
    17ec:	0785                	addi	a5,a5,1
    17ee:	d379                	beqz	a4,17b4 <strlen+0x18>
    17f0:	0017c703          	lbu	a4,1(a5)
    17f4:	0785                	addi	a5,a5,1
    17f6:	fb6d                	bnez	a4,17e8 <strlen+0x4c>
    17f8:	bf75                	j	17b4 <strlen+0x18>

00000000000017fa <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    17fa:	00757713          	andi	a4,a0,7
{
    17fe:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1800:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1804:	cb19                	beqz	a4,181a <memchr+0x20>
    1806:	ce25                	beqz	a2,187e <memchr+0x84>
    1808:	0007c703          	lbu	a4,0(a5)
    180c:	04b70e63          	beq	a4,a1,1868 <memchr+0x6e>
    1810:	0785                	addi	a5,a5,1
    1812:	0077f713          	andi	a4,a5,7
    1816:	167d                	addi	a2,a2,-1
    1818:	f77d                	bnez	a4,1806 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    181a:	4501                	li	a0,0
    if (n && *s != c) {
    181c:	c235                	beqz	a2,1880 <memchr+0x86>
    181e:	0007c703          	lbu	a4,0(a5)
    1822:	04b70363          	beq	a4,a1,1868 <memchr+0x6e>
        size_t k = ONES * c;
    1826:	00000517          	auipc	a0,0x0
    182a:	65253503          	ld	a0,1618(a0) # 1e78 <sharedmem+0xae>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    182e:	471d                	li	a4,7
        size_t k = ONES * c;
    1830:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1834:	02c77a63          	bgeu	a4,a2,1868 <memchr+0x6e>
    1838:	00000897          	auipc	a7,0x0
    183c:	6308b883          	ld	a7,1584(a7) # 1e68 <sharedmem+0x9e>
    1840:	00000817          	auipc	a6,0x0
    1844:	63083803          	ld	a6,1584(a6) # 1e70 <sharedmem+0xa6>
    1848:	431d                	li	t1,7
    184a:	a029                	j	1854 <memchr+0x5a>
    184c:	1661                	addi	a2,a2,-8
    184e:	07a1                	addi	a5,a5,8
    1850:	02c37963          	bgeu	t1,a2,1882 <memchr+0x88>
    1854:	6398                	ld	a4,0(a5)
    1856:	8f29                	xor	a4,a4,a0
    1858:	011706b3          	add	a3,a4,a7
    185c:	fff74713          	not	a4,a4
    1860:	8f75                	and	a4,a4,a3
    1862:	01077733          	and	a4,a4,a6
    1866:	d37d                	beqz	a4,184c <memchr+0x52>
    1868:	853e                	mv	a0,a5
    186a:	97b2                	add	a5,a5,a2
    186c:	a021                	j	1874 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    186e:	0505                	addi	a0,a0,1
    1870:	00f50763          	beq	a0,a5,187e <memchr+0x84>
    1874:	00054703          	lbu	a4,0(a0)
    1878:	feb71be3          	bne	a4,a1,186e <memchr+0x74>
    187c:	8082                	ret
    return n ? (void*)s : 0;
    187e:	4501                	li	a0,0
}
    1880:	8082                	ret
    return n ? (void*)s : 0;
    1882:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1884:	f275                	bnez	a2,1868 <memchr+0x6e>
}
    1886:	8082                	ret

0000000000001888 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1888:	1101                	addi	sp,sp,-32
    188a:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    188c:	862e                	mv	a2,a1
{
    188e:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1890:	4581                	li	a1,0
{
    1892:	e426                	sd	s1,8(sp)
    1894:	ec06                	sd	ra,24(sp)
    1896:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1898:	f63ff0ef          	jal	ra,17fa <memchr>
    return p ? p - s : n;
    189c:	c519                	beqz	a0,18aa <strnlen+0x22>
}
    189e:	60e2                	ld	ra,24(sp)
    18a0:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    18a2:	8d05                	sub	a0,a0,s1
}
    18a4:	64a2                	ld	s1,8(sp)
    18a6:	6105                	addi	sp,sp,32
    18a8:	8082                	ret
    18aa:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    18ac:	8522                	mv	a0,s0
}
    18ae:	6442                	ld	s0,16(sp)
    18b0:	64a2                	ld	s1,8(sp)
    18b2:	6105                	addi	sp,sp,32
    18b4:	8082                	ret

00000000000018b6 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    18b6:	00b547b3          	xor	a5,a0,a1
    18ba:	8b9d                	andi	a5,a5,7
    18bc:	eb95                	bnez	a5,18f0 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    18be:	0075f793          	andi	a5,a1,7
    18c2:	e7b1                	bnez	a5,190e <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    18c4:	6198                	ld	a4,0(a1)
    18c6:	00000617          	auipc	a2,0x0
    18ca:	5a263603          	ld	a2,1442(a2) # 1e68 <sharedmem+0x9e>
    18ce:	00000817          	auipc	a6,0x0
    18d2:	5a283803          	ld	a6,1442(a6) # 1e70 <sharedmem+0xa6>
    18d6:	a029                	j	18e0 <stpcpy+0x2a>
    18d8:	e118                	sd	a4,0(a0)
    18da:	6598                	ld	a4,8(a1)
    18dc:	05a1                	addi	a1,a1,8
    18de:	0521                	addi	a0,a0,8
    18e0:	00c707b3          	add	a5,a4,a2
    18e4:	fff74693          	not	a3,a4
    18e8:	8ff5                	and	a5,a5,a3
    18ea:	0107f7b3          	and	a5,a5,a6
    18ee:	d7ed                	beqz	a5,18d8 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    18f0:	0005c783          	lbu	a5,0(a1)
    18f4:	00f50023          	sb	a5,0(a0)
    18f8:	c785                	beqz	a5,1920 <stpcpy+0x6a>
    18fa:	0015c783          	lbu	a5,1(a1)
    18fe:	0505                	addi	a0,a0,1
    1900:	0585                	addi	a1,a1,1
    1902:	00f50023          	sb	a5,0(a0)
    1906:	fbf5                	bnez	a5,18fa <stpcpy+0x44>
        ;
    return d;
}
    1908:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    190a:	0505                	addi	a0,a0,1
    190c:	df45                	beqz	a4,18c4 <stpcpy+0xe>
            if (!(*d = *s))
    190e:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1912:	0585                	addi	a1,a1,1
    1914:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1918:	00f50023          	sb	a5,0(a0)
    191c:	f7fd                	bnez	a5,190a <stpcpy+0x54>
}
    191e:	8082                	ret
    1920:	8082                	ret

0000000000001922 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1922:	00b547b3          	xor	a5,a0,a1
    1926:	8b9d                	andi	a5,a5,7
    1928:	1a079863          	bnez	a5,1ad8 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    192c:	0075f793          	andi	a5,a1,7
    1930:	16078463          	beqz	a5,1a98 <stpncpy+0x176>
    1934:	ea01                	bnez	a2,1944 <stpncpy+0x22>
    1936:	a421                	j	1b3e <stpncpy+0x21c>
    1938:	167d                	addi	a2,a2,-1
    193a:	0505                	addi	a0,a0,1
    193c:	14070e63          	beqz	a4,1a98 <stpncpy+0x176>
    1940:	1a060863          	beqz	a2,1af0 <stpncpy+0x1ce>
    1944:	0005c783          	lbu	a5,0(a1)
    1948:	0585                	addi	a1,a1,1
    194a:	0075f713          	andi	a4,a1,7
    194e:	00f50023          	sb	a5,0(a0)
    1952:	f3fd                	bnez	a5,1938 <stpncpy+0x16>
    1954:	4805                	li	a6,1
    1956:	1a061863          	bnez	a2,1b06 <stpncpy+0x1e4>
    195a:	40a007b3          	neg	a5,a0
    195e:	8b9d                	andi	a5,a5,7
    1960:	4681                	li	a3,0
    1962:	18061a63          	bnez	a2,1af6 <stpncpy+0x1d4>
    1966:	00778713          	addi	a4,a5,7
    196a:	45ad                	li	a1,11
    196c:	18b76363          	bltu	a4,a1,1af2 <stpncpy+0x1d0>
    1970:	1ae6eb63          	bltu	a3,a4,1b26 <stpncpy+0x204>
    1974:	1a078363          	beqz	a5,1b1a <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1978:	00050023          	sb	zero,0(a0)
    197c:	4685                	li	a3,1
    197e:	00150713          	addi	a4,a0,1
    1982:	18d78f63          	beq	a5,a3,1b20 <stpncpy+0x1fe>
    1986:	000500a3          	sb	zero,1(a0)
    198a:	4689                	li	a3,2
    198c:	00250713          	addi	a4,a0,2
    1990:	18d78e63          	beq	a5,a3,1b2c <stpncpy+0x20a>
    1994:	00050123          	sb	zero,2(a0)
    1998:	468d                	li	a3,3
    199a:	00350713          	addi	a4,a0,3
    199e:	16d78c63          	beq	a5,a3,1b16 <stpncpy+0x1f4>
    19a2:	000501a3          	sb	zero,3(a0)
    19a6:	4691                	li	a3,4
    19a8:	00450713          	addi	a4,a0,4
    19ac:	18d78263          	beq	a5,a3,1b30 <stpncpy+0x20e>
    19b0:	00050223          	sb	zero,4(a0)
    19b4:	4695                	li	a3,5
    19b6:	00550713          	addi	a4,a0,5
    19ba:	16d78d63          	beq	a5,a3,1b34 <stpncpy+0x212>
    19be:	000502a3          	sb	zero,5(a0)
    19c2:	469d                	li	a3,7
    19c4:	00650713          	addi	a4,a0,6
    19c8:	16d79863          	bne	a5,a3,1b38 <stpncpy+0x216>
    19cc:	00750713          	addi	a4,a0,7
    19d0:	00050323          	sb	zero,6(a0)
    19d4:	40f80833          	sub	a6,a6,a5
    19d8:	ff887593          	andi	a1,a6,-8
    19dc:	97aa                	add	a5,a5,a0
    19de:	95be                	add	a1,a1,a5
    19e0:	0007b023          	sd	zero,0(a5)
    19e4:	07a1                	addi	a5,a5,8
    19e6:	feb79de3          	bne	a5,a1,19e0 <stpncpy+0xbe>
    19ea:	ff887593          	andi	a1,a6,-8
    19ee:	9ead                	addw	a3,a3,a1
    19f0:	00b707b3          	add	a5,a4,a1
    19f4:	12b80863          	beq	a6,a1,1b24 <stpncpy+0x202>
    19f8:	00078023          	sb	zero,0(a5)
    19fc:	0016871b          	addiw	a4,a3,1
    1a00:	0ec77863          	bgeu	a4,a2,1af0 <stpncpy+0x1ce>
    1a04:	000780a3          	sb	zero,1(a5)
    1a08:	0026871b          	addiw	a4,a3,2
    1a0c:	0ec77263          	bgeu	a4,a2,1af0 <stpncpy+0x1ce>
    1a10:	00078123          	sb	zero,2(a5)
    1a14:	0036871b          	addiw	a4,a3,3
    1a18:	0cc77c63          	bgeu	a4,a2,1af0 <stpncpy+0x1ce>
    1a1c:	000781a3          	sb	zero,3(a5)
    1a20:	0046871b          	addiw	a4,a3,4
    1a24:	0cc77663          	bgeu	a4,a2,1af0 <stpncpy+0x1ce>
    1a28:	00078223          	sb	zero,4(a5)
    1a2c:	0056871b          	addiw	a4,a3,5
    1a30:	0cc77063          	bgeu	a4,a2,1af0 <stpncpy+0x1ce>
    1a34:	000782a3          	sb	zero,5(a5)
    1a38:	0066871b          	addiw	a4,a3,6
    1a3c:	0ac77a63          	bgeu	a4,a2,1af0 <stpncpy+0x1ce>
    1a40:	00078323          	sb	zero,6(a5)
    1a44:	0076871b          	addiw	a4,a3,7
    1a48:	0ac77463          	bgeu	a4,a2,1af0 <stpncpy+0x1ce>
    1a4c:	000783a3          	sb	zero,7(a5)
    1a50:	0086871b          	addiw	a4,a3,8
    1a54:	08c77e63          	bgeu	a4,a2,1af0 <stpncpy+0x1ce>
    1a58:	00078423          	sb	zero,8(a5)
    1a5c:	0096871b          	addiw	a4,a3,9
    1a60:	08c77863          	bgeu	a4,a2,1af0 <stpncpy+0x1ce>
    1a64:	000784a3          	sb	zero,9(a5)
    1a68:	00a6871b          	addiw	a4,a3,10
    1a6c:	08c77263          	bgeu	a4,a2,1af0 <stpncpy+0x1ce>
    1a70:	00078523          	sb	zero,10(a5)
    1a74:	00b6871b          	addiw	a4,a3,11
    1a78:	06c77c63          	bgeu	a4,a2,1af0 <stpncpy+0x1ce>
    1a7c:	000785a3          	sb	zero,11(a5)
    1a80:	00c6871b          	addiw	a4,a3,12
    1a84:	06c77663          	bgeu	a4,a2,1af0 <stpncpy+0x1ce>
    1a88:	00078623          	sb	zero,12(a5)
    1a8c:	26b5                	addiw	a3,a3,13
    1a8e:	06c6f163          	bgeu	a3,a2,1af0 <stpncpy+0x1ce>
    1a92:	000786a3          	sb	zero,13(a5)
    1a96:	8082                	ret
            ;
        if (!n || !*s)
    1a98:	c645                	beqz	a2,1b40 <stpncpy+0x21e>
    1a9a:	0005c783          	lbu	a5,0(a1)
    1a9e:	ea078be3          	beqz	a5,1954 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1aa2:	479d                	li	a5,7
    1aa4:	02c7ff63          	bgeu	a5,a2,1ae2 <stpncpy+0x1c0>
    1aa8:	00000897          	auipc	a7,0x0
    1aac:	3c08b883          	ld	a7,960(a7) # 1e68 <sharedmem+0x9e>
    1ab0:	00000817          	auipc	a6,0x0
    1ab4:	3c083803          	ld	a6,960(a6) # 1e70 <sharedmem+0xa6>
    1ab8:	431d                	li	t1,7
    1aba:	6198                	ld	a4,0(a1)
    1abc:	011707b3          	add	a5,a4,a7
    1ac0:	fff74693          	not	a3,a4
    1ac4:	8ff5                	and	a5,a5,a3
    1ac6:	0107f7b3          	and	a5,a5,a6
    1aca:	ef81                	bnez	a5,1ae2 <stpncpy+0x1c0>
            *wd = *ws;
    1acc:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1ace:	1661                	addi	a2,a2,-8
    1ad0:	05a1                	addi	a1,a1,8
    1ad2:	0521                	addi	a0,a0,8
    1ad4:	fec363e3          	bltu	t1,a2,1aba <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1ad8:	e609                	bnez	a2,1ae2 <stpncpy+0x1c0>
    1ada:	a08d                	j	1b3c <stpncpy+0x21a>
    1adc:	167d                	addi	a2,a2,-1
    1ade:	0505                	addi	a0,a0,1
    1ae0:	ca01                	beqz	a2,1af0 <stpncpy+0x1ce>
    1ae2:	0005c783          	lbu	a5,0(a1)
    1ae6:	0585                	addi	a1,a1,1
    1ae8:	00f50023          	sb	a5,0(a0)
    1aec:	fbe5                	bnez	a5,1adc <stpncpy+0x1ba>
        ;
tail:
    1aee:	b59d                	j	1954 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1af0:	8082                	ret
    1af2:	472d                	li	a4,11
    1af4:	bdb5                	j	1970 <stpncpy+0x4e>
    1af6:	00778713          	addi	a4,a5,7
    1afa:	45ad                	li	a1,11
    1afc:	fff60693          	addi	a3,a2,-1
    1b00:	e6b778e3          	bgeu	a4,a1,1970 <stpncpy+0x4e>
    1b04:	b7fd                	j	1af2 <stpncpy+0x1d0>
    1b06:	40a007b3          	neg	a5,a0
    1b0a:	8832                	mv	a6,a2
    1b0c:	8b9d                	andi	a5,a5,7
    1b0e:	4681                	li	a3,0
    1b10:	e4060be3          	beqz	a2,1966 <stpncpy+0x44>
    1b14:	b7cd                	j	1af6 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1b16:	468d                	li	a3,3
    1b18:	bd75                	j	19d4 <stpncpy+0xb2>
    1b1a:	872a                	mv	a4,a0
    1b1c:	4681                	li	a3,0
    1b1e:	bd5d                	j	19d4 <stpncpy+0xb2>
    1b20:	4685                	li	a3,1
    1b22:	bd4d                	j	19d4 <stpncpy+0xb2>
    1b24:	8082                	ret
    1b26:	87aa                	mv	a5,a0
    1b28:	4681                	li	a3,0
    1b2a:	b5f9                	j	19f8 <stpncpy+0xd6>
    1b2c:	4689                	li	a3,2
    1b2e:	b55d                	j	19d4 <stpncpy+0xb2>
    1b30:	4691                	li	a3,4
    1b32:	b54d                	j	19d4 <stpncpy+0xb2>
    1b34:	4695                	li	a3,5
    1b36:	bd79                	j	19d4 <stpncpy+0xb2>
    1b38:	4699                	li	a3,6
    1b3a:	bd69                	j	19d4 <stpncpy+0xb2>
    1b3c:	8082                	ret
    1b3e:	8082                	ret
    1b40:	8082                	ret

0000000000001b42 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1b42:	fff6071b          	addiw	a4,a2,-1
    1b46:	0cb57063          	bgeu	a0,a1,1c06 <memmove+0xc4>
        while (n-- > 0)
    1b4a:	0ec05063          	blez	a2,1c2a <memmove+0xe8>
    1b4e:	00750693          	addi	a3,a0,7
    1b52:	8e8d                	sub	a3,a3,a1
    1b54:	00b567b3          	or	a5,a0,a1
    1b58:	00f6b693          	sltiu	a3,a3,15
    1b5c:	8b9d                	andi	a5,a5,7
    1b5e:	0016c693          	xori	a3,a3,1
    1b62:	0017b793          	seqz	a5,a5
    1b66:	8ff5                	and	a5,a5,a3
    1b68:	c3f1                	beqz	a5,1c2c <memmove+0xea>
    1b6a:	0007079b          	sext.w	a5,a4
    1b6e:	46a5                	li	a3,9
    1b70:	0af6fe63          	bgeu	a3,a5,1c2c <memmove+0xea>
    1b74:	0036589b          	srliw	a7,a2,0x3
    1b78:	088e                	slli	a7,a7,0x3
    1b7a:	2601                	sext.w	a2,a2
    1b7c:	87ae                	mv	a5,a1
    1b7e:	86aa                	mv	a3,a0
    1b80:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1b82:	0007b803          	ld	a6,0(a5)
    1b86:	07a1                	addi	a5,a5,8
    1b88:	06a1                	addi	a3,a3,8
    1b8a:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1b8e:	ff179ae3          	bne	a5,a7,1b82 <memmove+0x40>
    1b92:	ff867813          	andi	a6,a2,-8
    1b96:	02081793          	slli	a5,a6,0x20
    1b9a:	9381                	srli	a5,a5,0x20
    1b9c:	00f506b3          	add	a3,a0,a5
    1ba0:	95be                	add	a1,a1,a5
    1ba2:	4107073b          	subw	a4,a4,a6
    1ba6:	09060263          	beq	a2,a6,1c2a <memmove+0xe8>
            *dst++ = *src++;
    1baa:	0005c783          	lbu	a5,0(a1)
    1bae:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1bb2:	06e05c63          	blez	a4,1c2a <memmove+0xe8>
            *dst++ = *src++;
    1bb6:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1bba:	4785                	li	a5,1
            *dst++ = *src++;
    1bbc:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1bc0:	06e7d563          	bge	a5,a4,1c2a <memmove+0xe8>
            *dst++ = *src++;
    1bc4:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1bc8:	4789                	li	a5,2
            *dst++ = *src++;
    1bca:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1bce:	04e7de63          	bge	a5,a4,1c2a <memmove+0xe8>
            *dst++ = *src++;
    1bd2:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1bd6:	478d                	li	a5,3
            *dst++ = *src++;
    1bd8:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1bdc:	04e7d763          	bge	a5,a4,1c2a <memmove+0xe8>
            *dst++ = *src++;
    1be0:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1be4:	4791                	li	a5,4
            *dst++ = *src++;
    1be6:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1bea:	04e7d063          	bge	a5,a4,1c2a <memmove+0xe8>
            *dst++ = *src++;
    1bee:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1bf2:	4795                	li	a5,5
            *dst++ = *src++;
    1bf4:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1bf8:	02e7d963          	bge	a5,a4,1c2a <memmove+0xe8>
            *dst++ = *src++;
    1bfc:	0065c783          	lbu	a5,6(a1)
    1c00:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1c04:	8082                	ret
    } else {
        dst += n;
    1c06:	00c507b3          	add	a5,a0,a2
        src += n;
    1c0a:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1c0c:	00c05f63          	blez	a2,1c2a <memmove+0xe8>
    1c10:	1702                	slli	a4,a4,0x20
    1c12:	9301                	srli	a4,a4,0x20
    1c14:	fff74713          	not	a4,a4
    1c18:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1c1a:	fff5c683          	lbu	a3,-1(a1)
    1c1e:	17fd                	addi	a5,a5,-1
    1c20:	15fd                	addi	a1,a1,-1
    1c22:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1c26:	fee79ae3          	bne	a5,a4,1c1a <memmove+0xd8>
    }
    return vdst;
}
    1c2a:	8082                	ret
    1c2c:	02071693          	slli	a3,a4,0x20
    1c30:	9281                	srli	a3,a3,0x20
    1c32:	0685                	addi	a3,a3,1
    1c34:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1c36:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1c38:	0005c703          	lbu	a4,0(a1)
    1c3c:	0585                	addi	a1,a1,1
    1c3e:	0785                	addi	a5,a5,1
    1c40:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1c44:	fed59ae3          	bne	a1,a3,1c38 <memmove+0xf6>
    1c48:	8082                	ret

0000000000001c4a <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1c4a:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c4e:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1c52:	2501                	sext.w	a0,a0
    1c54:	8082                	ret

0000000000001c56 <exec>:
    register long a7 __asm__("a7") = n;
    1c56:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1c5a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c5c:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1c60:	2501                	sext.w	a0,a0
    1c62:	8082                	ret

0000000000001c64 <exit>:
    register long a7 __asm__("a7") = n;
    1c64:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1c68:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1c6c:	8082                	ret

0000000000001c6e <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1c6e:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c72:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1c76:	8082                	ret

0000000000001c78 <write>:
    register long a7 __asm__("a7") = n;
    1c78:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c7c:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1c80:	8082                	ret

0000000000001c82 <getpid>:
    register long a7 __asm__("a7") = n;
    1c82:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c86:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c8a:	2501                	sext.w	a0,a0
    1c8c:	8082                	ret

0000000000001c8e <getppid>:
    register long a7 __asm__("a7") = n;
    1c8e:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c92:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c96:	2501                	sext.w	a0,a0
    1c98:	8082                	ret

0000000000001c9a <open>:
    register long a7 __asm__("a7") = n;
    1c9a:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c9e:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1ca2:	2501                	sext.w	a0,a0
    1ca4:	8082                	ret

0000000000001ca6 <mknod>:
    register long a7 __asm__("a7") = n;
    1ca6:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1caa:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1cae:	2501                	sext.w	a0,a0
    1cb0:	8082                	ret

0000000000001cb2 <dup>:
    register long a7 __asm__("a7") = n;
    1cb2:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1cb4:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1cb8:	2501                	sext.w	a0,a0
    1cba:	8082                	ret

0000000000001cbc <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cbc:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cc0:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cc4:	2501                	sext.w	a0,a0
    1cc6:	8082                	ret

0000000000001cc8 <waitpid>:
    register long a7 __asm__("a7") = n;
    1cc8:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ccc:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1cd0:	2501                	sext.w	a0,a0
    1cd2:	8082                	ret

0000000000001cd4 <wait>:

pid_t wait(int *wstatus)
{
    1cd4:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1cd6:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1cda:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cdc:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1ce0:	2501                	sext.w	a0,a0
    1ce2:	8082                	ret

0000000000001ce4 <mkdir>:
    register long a7 __asm__("a7") = n;
    1ce4:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1ce8:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1cec:	2501                	sext.w	a0,a0
    1cee:	8082                	ret

0000000000001cf0 <close>:
    register long a7 __asm__("a7") = n;
    1cf0:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1cf4:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1cf8:	2501                	sext.w	a0,a0
    1cfa:	8082                	ret

0000000000001cfc <fork>:
    register long a7 __asm__("a7") = n;
    1cfc:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1d00:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1d04:	2501                	sext.w	a0,a0
    1d06:	8082                	ret

0000000000001d08 <time_ms>:
    register long a7 __asm__("a7") = n;
    1d08:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d0c:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1d10:	8082                	ret

0000000000001d12 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1d12:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1d14:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d18:	00000073          	ecall
    1d1c:	87aa                	mv	a5,a0
    1d1e:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1d22:	97ba                	add	a5,a5,a4
    1d24:	00f57c63          	bgeu	a0,a5,1d3c <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1d28:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1d2c:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d30:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d34:	00000073          	ecall
    1d38:	fef568e3          	bltu	a0,a5,1d28 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1d3c:	4501                	li	a0,0
    1d3e:	8082                	ret

0000000000001d40 <pipe>:
    register long a7 __asm__("a7") = n;
    1d40:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1d44:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1d48:	2501                	sext.w	a0,a0
    1d4a:	8082                	ret

0000000000001d4c <fstat>:
    register long a7 __asm__("a7") = n;
    1d4c:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d50:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1d54:	2501                	sext.w	a0,a0
    1d56:	8082                	ret

0000000000001d58 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1d58:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1d5a:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1d5e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d60:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1d64:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1d68:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1d6c:	0206c163          	bltz	a3,1d8e <stat+0x36>
    register long a7 __asm__("a7") = n;
    1d70:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1d74:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1d76:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d78:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d7c:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1d80:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1d84:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1d86:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1d8a:	853e                	mv	a0,a5
    1d8c:	8082                	ret
        return -1;
    1d8e:	57fd                	li	a5,-1
    1d90:	bfed                	j	1d8a <stat+0x32>

0000000000001d92 <chdir>:
    register long a7 __asm__("a7") = n;
    1d92:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1d96:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1d9a:	2501                	sext.w	a0,a0
    1d9c:	8082                	ret

0000000000001d9e <link>:
    register long a7 __asm__("a7") = n;
    1d9e:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1da2:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1da6:	2501                	sext.w	a0,a0
    1da8:	8082                	ret

0000000000001daa <unlink>:
    register long a7 __asm__("a7") = n;
    1daa:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1dae:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1db2:	2501                	sext.w	a0,a0
    1db4:	8082                	ret

0000000000001db6 <setpriority>:
    register long a7 __asm__("a7") = n;
    1db6:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1dba:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1dbe:	8082                	ret

0000000000001dc0 <getpriority>:
    register long a7 __asm__("a7") = n;
    1dc0:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1dc4:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1dc8:	8082                	ret

0000000000001dca <sharedmem>:
    register long a7 __asm__("a7") = n;
    1dca:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dce:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1dd2:	8082                	ret
