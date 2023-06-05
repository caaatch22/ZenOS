
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_getchar:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a80d                	j	1032 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <stdio.h>
#include <stdlib.h>
#include <ucore.h>

int main() {
    1002:	1141                	addi	sp,sp,-16
    printf("getchar 10:");
    1004:	00001517          	auipc	a0,0x1
    1008:	d2c50513          	addi	a0,a0,-724 # 1d30 <sharedmem+0xa>
int main() {
    100c:	e022                	sd	s0,0(sp)
    100e:	e406                	sd	ra,8(sp)
    printf("getchar 10:");
    1010:	4429                	li	s0,10
    1012:	0b6000ef          	jal	ra,10c8 <printf>
    for(int i = 0; i < 10; ++i) {
        int c = getchar();
    1016:	347d                	addiw	s0,s0,-1
    1018:	02a000ef          	jal	ra,1042 <getchar>
        putchar(c);
    101c:	044000ef          	jal	ra,1060 <putchar>
    for(int i = 0; i < 10; ++i) {
    1020:	f87d                	bnez	s0,1016 <main+0x14>
    }
    putchar('\n');
    1022:	4529                	li	a0,10
    1024:	03c000ef          	jal	ra,1060 <putchar>
    return 0;
    1028:	60a2                	ld	ra,8(sp)
    102a:	6402                	ld	s0,0(sp)
    102c:	4501                	li	a0,0
    102e:	0141                	addi	sp,sp,16
    1030:	8082                	ret

0000000000001032 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1032:	1141                	addi	sp,sp,-16
    1034:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    1036:	fcdff0ef          	jal	ra,1002 <main>
}
    103a:	60a2                	ld	ra,8(sp)
    103c:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    103e:	3830006f          	j	1bc0 <exit>

0000000000001042 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    1042:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    1044:	00f10593          	addi	a1,sp,15
    1048:	4605                	li	a2,1
    104a:	4501                	li	a0,0
int getchar() {
    104c:	ec06                	sd	ra,24(sp)
    char byte = 0;
    104e:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1052:	379000ef          	jal	ra,1bca <read>
    return byte;
}
    1056:	60e2                	ld	ra,24(sp)
    1058:	00f14503          	lbu	a0,15(sp)
    105c:	6105                	addi	sp,sp,32
    105e:	8082                	ret

0000000000001060 <putchar>:

int putchar(int c)
{
    1060:	1141                	addi	sp,sp,-16
    1062:	e406                	sd	ra,8(sp)
    1064:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    1066:	00001597          	auipc	a1,0x1
    106a:	cfa58593          	addi	a1,a1,-774 # 1d60 <put.1156>
    return write(stdout, put, 1);
    106e:	4605                	li	a2,1
    1070:	4505                	li	a0,1
    put[0] = c;
    1072:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1076:	35f000ef          	jal	ra,1bd4 <write>
}
    107a:	60a2                	ld	ra,8(sp)
    107c:	2501                	sext.w	a0,a0
    107e:	0141                	addi	sp,sp,16
    1080:	8082                	ret

0000000000001082 <puts>:

int puts(const char* s)
{
    1082:	1141                	addi	sp,sp,-16
    1084:	e022                	sd	s0,0(sp)
    1086:	e406                	sd	ra,8(sp)
    1088:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    108a:	66e000ef          	jal	ra,16f8 <strlen>
    108e:	862a                	mv	a2,a0
    1090:	85a2                	mv	a1,s0
    1092:	4505                	li	a0,1
    1094:	341000ef          	jal	ra,1bd4 <write>
    1098:	00055763          	bgez	a0,10a6 <puts+0x24>
    return r;
}
    109c:	60a2                	ld	ra,8(sp)
    109e:	6402                	ld	s0,0(sp)
    10a0:	557d                	li	a0,-1
    10a2:	0141                	addi	sp,sp,16
    10a4:	8082                	ret
    put[0] = c;
    10a6:	00001597          	auipc	a1,0x1
    10aa:	cba58593          	addi	a1,a1,-838 # 1d60 <put.1156>
    10ae:	47a9                	li	a5,10
    return write(stdout, put, 1);
    10b0:	4605                	li	a2,1
    10b2:	4505                	li	a0,1
    put[0] = c;
    10b4:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    10b8:	31d000ef          	jal	ra,1bd4 <write>
}
    10bc:	60a2                	ld	ra,8(sp)
    10be:	6402                	ld	s0,0(sp)
    10c0:	41f5551b          	sraiw	a0,a0,0x1f
    10c4:	0141                	addi	sp,sp,16
    10c6:	8082                	ret

00000000000010c8 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    10c8:	7115                	addi	sp,sp,-224
    10ca:	ed06                	sd	ra,152(sp)
    10cc:	e922                	sd	s0,144(sp)
    10ce:	e526                	sd	s1,136(sp)
    10d0:	e14a                	sd	s2,128(sp)
    10d2:	fcce                	sd	s3,120(sp)
    10d4:	f8d2                	sd	s4,112(sp)
    10d6:	f4d6                	sd	s5,104(sp)
    10d8:	f0da                	sd	s6,96(sp)
    10da:	ecde                	sd	s7,88(sp)
    10dc:	e8e2                	sd	s8,80(sp)
    10de:	e4e6                	sd	s9,72(sp)
    10e0:	e0ea                	sd	s10,64(sp)
    10e2:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    10e4:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    10e8:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    10ea:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    10ec:	f52e                	sd	a1,168(sp)
    10ee:	f932                	sd	a2,176(sp)
    10f0:	fd36                	sd	a3,184(sp)
    10f2:	e1ba                	sd	a4,192(sp)
    10f4:	e9c2                	sd	a6,208(sp)
    10f6:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    10f8:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    10fa:	0c030b63          	beqz	t1,11d0 <printf+0x108>
    10fe:	8aaa                	mv	s5,a0
    1100:	0003071b          	sext.w	a4,t1
    1104:	4481                	li	s1,0
        if (c != '%') {
    1106:	02500b93          	li	s7,37
    put[0] = c;
    110a:	00001417          	auipc	s0,0x1
    110e:	c5640413          	addi	s0,s0,-938 # 1d60 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    1112:	4c51                	li	s8,20
    put[0] = c;
    1114:	02500c93          	li	s9,37
    1118:	00001a17          	auipc	s4,0x1
    111c:	c50a0a13          	addi	s4,s4,-944 # 1d68 <put.1156+0x8>
    1120:	00001997          	auipc	s3,0x1
    1124:	ca098993          	addi	s3,s3,-864 # 1dc0 <digits>
    1128:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    112c:	0014879b          	addiw	a5,s1,1
    1130:	00fa8933          	add	s2,s5,a5
    1134:	13771163          	bne	a4,s7,1256 <printf+0x18e>
        c = fmt[++i] & 0xff;
    1138:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    113c:	080d0a63          	beqz	s10,11d0 <printf+0x108>
        switch (c) {
    1140:	2489                	addiw	s1,s1,2
    1142:	009a8933          	add	s2,s5,s1
    1146:	257d0e63          	beq	s10,s7,13a2 <printf+0x2da>
    114a:	f9cd079b          	addiw	a5,s10,-100
    114e:	0ff7f793          	andi	a5,a5,255
    1152:	0cfc6263          	bltu	s8,a5,1216 <printf+0x14e>
    1156:	078a                	slli	a5,a5,0x2
    1158:	97d2                	add	a5,a5,s4
    115a:	439c                	lw	a5,0(a5)
    115c:	97d2                	add	a5,a5,s4
    115e:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    1160:	67a2                	ld	a5,8(sp)
    1162:	4398                	lw	a4,0(a5)
    1164:	07a1                	addi	a5,a5,8
    1166:	e43e                	sd	a5,8(sp)
    1168:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    116c:	26074663          	bltz	a4,13d8 <printf+0x310>
        buf[i++] = digits[x % base];
    1170:	8bbd                	andi	a5,a5,15
    1172:	97ce                	add	a5,a5,s3
    1174:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1178:	40475d1b          	sraiw	s10,a4,0x4
    117c:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    1180:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    1184:	020d0163          	beqz	s10,11a6 <printf+0xde>
        buf[i++] = digits[x % base];
    1188:	9d4e                	add	s10,s10,s3
    118a:	000d4783          	lbu	a5,0(s10)
    118e:	4d05                	li	s10,1
    1190:	00f108a3          	sb	a5,17(sp)
    if (sign)
    1194:	00075963          	bgez	a4,11a6 <printf+0xde>
        buf[i++] = digits[x % base];
    1198:	4d09                	li	s10,2
        buf[i++] = '-';
    119a:	181c                	addi	a5,sp,48
    119c:	02d00713          	li	a4,45
    11a0:	97ea                	add	a5,a5,s10
    11a2:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    11a6:	9d5a                	add	s10,s10,s6
    11a8:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    11ac:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    11b0:	4605                	li	a2,1
    11b2:	1d7d                	addi	s10,s10,-1
    11b4:	85a2                	mv	a1,s0
    11b6:	4505                	li	a0,1
    put[0] = c;
    11b8:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    11bc:	219000ef          	jal	ra,1bd4 <write>
    while (--i >= 0)
    11c0:	ffbd16e3          	bne	s10,s11,11ac <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    11c4:	00094303          	lbu	t1,0(s2)
    11c8:	0003071b          	sext.w	a4,t1
    11cc:	f60310e3          	bnez	t1,112c <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    11d0:	60ea                	ld	ra,152(sp)
    11d2:	644a                	ld	s0,144(sp)
    11d4:	64aa                	ld	s1,136(sp)
    11d6:	690a                	ld	s2,128(sp)
    11d8:	79e6                	ld	s3,120(sp)
    11da:	7a46                	ld	s4,112(sp)
    11dc:	7aa6                	ld	s5,104(sp)
    11de:	7b06                	ld	s6,96(sp)
    11e0:	6be6                	ld	s7,88(sp)
    11e2:	6c46                	ld	s8,80(sp)
    11e4:	6ca6                	ld	s9,72(sp)
    11e6:	6d06                	ld	s10,64(sp)
    11e8:	7de2                	ld	s11,56(sp)
    11ea:	612d                	addi	sp,sp,224
    11ec:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    11ee:	67a2                	ld	a5,8(sp)
    11f0:	0007bd03          	ld	s10,0(a5)
    11f4:	07a1                	addi	a5,a5,8
    11f6:	e43e                	sd	a5,8(sp)
    11f8:	000d1b63          	bnez	s10,120e <printf+0x146>
    11fc:	aafd                	j	13fa <printf+0x332>
    return write(stdout, put, 1);
    11fe:	4605                	li	a2,1
    1200:	85a2                	mv	a1,s0
    1202:	4505                	li	a0,1
                for (; *s; s++)
    1204:	0d05                	addi	s10,s10,1
    put[0] = c;
    1206:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    120a:	1cb000ef          	jal	ra,1bd4 <write>
                for (; *s; s++)
    120e:	000d4783          	lbu	a5,0(s10)
    1212:	f7f5                	bnez	a5,11fe <printf+0x136>
    1214:	a02d                	j	123e <printf+0x176>
    return write(stdout, put, 1);
    1216:	4605                	li	a2,1
    1218:	00001597          	auipc	a1,0x1
    121c:	b4858593          	addi	a1,a1,-1208 # 1d60 <put.1156>
    1220:	4505                	li	a0,1
    put[0] = c;
    1222:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    1226:	1af000ef          	jal	ra,1bd4 <write>
    122a:	4605                	li	a2,1
    122c:	00001597          	auipc	a1,0x1
    1230:	b3458593          	addi	a1,a1,-1228 # 1d60 <put.1156>
    1234:	4505                	li	a0,1
    put[0] = c;
    1236:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    123a:	19b000ef          	jal	ra,1bd4 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    123e:	00094303          	lbu	t1,0(s2)
    1242:	0003071b          	sext.w	a4,t1
    1246:	f80305e3          	beqz	t1,11d0 <printf+0x108>
        if (c != '%') {
    124a:	0014879b          	addiw	a5,s1,1
    124e:	00fa8933          	add	s2,s5,a5
    1252:	ef7703e3          	beq	a4,s7,1138 <printf+0x70>
    return write(stdout, put, 1);
    1256:	4605                	li	a2,1
    1258:	00001597          	auipc	a1,0x1
    125c:	b0858593          	addi	a1,a1,-1272 # 1d60 <put.1156>
    1260:	4505                	li	a0,1
    put[0] = c;
    1262:	00640023          	sb	t1,0(s0)
            continue;
    1266:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    1268:	16d000ef          	jal	ra,1bd4 <write>
            continue;
    126c:	bfc9                	j	123e <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    126e:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    1270:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    1272:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    1274:	0007b883          	ld	a7,0(a5)
    1278:	07a1                	addi	a5,a5,8
    127a:	e43e                	sd	a5,8(sp)
        x = -xx;
    127c:	43f8d713          	srai	a4,a7,0x3f
    1280:	011747b3          	xor	a5,a4,a7
    1284:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    1286:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    1288:	02c7f733          	remu	a4,a5,a2
    128c:	8d36                	mv	s10,a3
    128e:	0685                	addi	a3,a3,1
    1290:	00db0533          	add	a0,s6,a3
    1294:	85be                	mv	a1,a5
    1296:	974e                	add	a4,a4,s3
    1298:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    129c:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    12a0:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    12a4:	feb862e3          	bltu	a6,a1,1288 <printf+0x1c0>
    if (sign)
    12a8:	1208c063          	bltz	a7,13c8 <printf+0x300>
    while (--i >= 0)
    12ac:	9d5a                	add	s10,s10,s6
    put[0] = c;
    12ae:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    12b2:	4605                	li	a2,1
    12b4:	85a2                	mv	a1,s0
    12b6:	4505                	li	a0,1
    put[0] = c;
    12b8:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    12bc:	119000ef          	jal	ra,1bd4 <write>
    while (--i >= 0)
    12c0:	87ea                	mv	a5,s10
    12c2:	1d7d                	addi	s10,s10,-1
    12c4:	fefb15e3          	bne	s6,a5,12ae <printf+0x1e6>
    12c8:	bf9d                	j	123e <printf+0x176>
                printptr(va_arg(ap, uint64));
    12ca:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    12cc:	4605                	li	a2,1
    12ce:	00001597          	auipc	a1,0x1
    12d2:	a9258593          	addi	a1,a1,-1390 # 1d60 <put.1156>
                printptr(va_arg(ap, uint64));
    12d6:	0007bd83          	ld	s11,0(a5)
    12da:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    12de:	4505                	li	a0,1
    put[0] = c;
    12e0:	03000793          	li	a5,48
    12e4:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    12e8:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    12ea:	0eb000ef          	jal	ra,1bd4 <write>
    put[0] = c;
    12ee:	07800793          	li	a5,120
    return write(stdout, put, 1);
    12f2:	4605                	li	a2,1
    12f4:	00001597          	auipc	a1,0x1
    12f8:	a6c58593          	addi	a1,a1,-1428 # 1d60 <put.1156>
    12fc:	4505                	li	a0,1
    put[0] = c;
    12fe:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1302:	4d41                	li	s10,16
    1304:	0d1000ef          	jal	ra,1bd4 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    1308:	03cdd793          	srli	a5,s11,0x3c
    130c:	97ce                	add	a5,a5,s3
    put[0] = c;
    130e:	0007c783          	lbu	a5,0(a5)
    1312:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    1314:	4605                	li	a2,1
    1316:	85a2                	mv	a1,s0
    1318:	4505                	li	a0,1
    put[0] = c;
    131a:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    131e:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1320:	0b5000ef          	jal	ra,1bd4 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1324:	fe0d12e3          	bnez	s10,1308 <printf+0x240>
    1328:	bf19                	j	123e <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    132a:	67a2                	ld	a5,8(sp)
    132c:	4394                	lw	a3,0(a5)
    132e:	07a1                	addi	a5,a5,8
    1330:	e43e                	sd	a5,8(sp)
    1332:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    1336:	0006d663          	bgez	a3,1342 <printf+0x27a>
        x = -xx;
    133a:	40f007bb          	negw	a5,a5
    133e:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    1342:	4729                	li	a4,10
    1344:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    1348:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    134c:	964e                	add	a2,a2,s3
    134e:	00064603          	lbu	a2,0(a2)
    1352:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    1356:	0a0d0963          	beqz	s10,1408 <printf+0x340>
        buf[i++] = digits[x % base];
    135a:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    135e:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    1362:	00c98733          	add	a4,s3,a2
    1366:	00074703          	lbu	a4,0(a4)
    136a:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    136e:	c3cd                	beqz	a5,1410 <printf+0x348>
        buf[i++] = digits[x % base];
    1370:	97ce                	add	a5,a5,s3
    1372:	0007c703          	lbu	a4,0(a5)
    1376:	4d09                	li	s10,2
    1378:	478d                	li	a5,3
    137a:	00e10923          	sb	a4,18(sp)
    if (sign)
    137e:	0206cd63          	bltz	a3,13b8 <printf+0x2f0>
    while (--i >= 0)
    1382:	9d5a                	add	s10,s10,s6
    1384:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1388:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    138c:	4605                	li	a2,1
    138e:	1d7d                	addi	s10,s10,-1
    1390:	85a2                	mv	a1,s0
    1392:	4505                	li	a0,1
    put[0] = c;
    1394:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1398:	03d000ef          	jal	ra,1bd4 <write>
    while (--i >= 0)
    139c:	ffbd16e3          	bne	s10,s11,1388 <printf+0x2c0>
    13a0:	bd79                	j	123e <printf+0x176>
    return write(stdout, put, 1);
    13a2:	4605                	li	a2,1
    13a4:	00001597          	auipc	a1,0x1
    13a8:	9bc58593          	addi	a1,a1,-1604 # 1d60 <put.1156>
    13ac:	4505                	li	a0,1
    put[0] = c;
    13ae:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    13b2:	023000ef          	jal	ra,1bd4 <write>
    13b6:	b561                	j	123e <printf+0x176>
        buf[i++] = '-';
    13b8:	1818                	addi	a4,sp,48
    13ba:	973e                	add	a4,a4,a5
    13bc:	02d00693          	li	a3,45
    13c0:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    13c4:	8d3e                	mv	s10,a5
    13c6:	bf75                	j	1382 <printf+0x2ba>
        buf[i++] = '-';
    13c8:	181c                	addi	a5,sp,48
    13ca:	97b6                	add	a5,a5,a3
    13cc:	02d00713          	li	a4,45
    13d0:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    13d4:	8d36                	mv	s10,a3
    13d6:	bdd9                	j	12ac <printf+0x1e4>
        x = -xx;
    13d8:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    13dc:	00f7f693          	andi	a3,a5,15
    13e0:	96ce                	add	a3,a3,s3
    13e2:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    13e6:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    13ea:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    13ee:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    13f2:	d80d1be3          	bnez	s10,1188 <printf+0xc0>
        buf[i++] = digits[x % base];
    13f6:	4d05                	li	s10,1
    13f8:	b34d                	j	119a <printf+0xd2>
                s = "(null)";
    13fa:	00001d17          	auipc	s10,0x1
    13fe:	946d0d13          	addi	s10,s10,-1722 # 1d40 <sharedmem+0x1a>
                for (; *s; s++)
    1402:	02800793          	li	a5,40
    1406:	bbe5                	j	11fe <printf+0x136>
        buf[i++] = digits[x % base];
    1408:	4785                	li	a5,1
    if (sign)
    140a:	f606dce3          	bgez	a3,1382 <printf+0x2ba>
    140e:	b76d                	j	13b8 <printf+0x2f0>
        buf[i++] = digits[x % base];
    1410:	4789                	li	a5,2
    1412:	4d05                	li	s10,1
    if (sign)
    1414:	f606d7e3          	bgez	a3,1382 <printf+0x2ba>
    1418:	b745                	j	13b8 <printf+0x2f0>

000000000000141a <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    141a:	02000793          	li	a5,32
    141e:	00f50663          	beq	a0,a5,142a <isspace+0x10>
    1422:	355d                	addiw	a0,a0,-9
    1424:	00553513          	sltiu	a0,a0,5
    1428:	8082                	ret
    142a:	4505                	li	a0,1
}
    142c:	8082                	ret

000000000000142e <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    142e:	fd05051b          	addiw	a0,a0,-48
}
    1432:	00a53513          	sltiu	a0,a0,10
    1436:	8082                	ret

0000000000001438 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1438:	02000613          	li	a2,32
    143c:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    143e:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1442:	ff77069b          	addiw	a3,a4,-9
    1446:	04c70d63          	beq	a4,a2,14a0 <atoi+0x68>
    144a:	0007079b          	sext.w	a5,a4
    144e:	04d5f963          	bgeu	a1,a3,14a0 <atoi+0x68>
        s++;
    switch (*s) {
    1452:	02b00693          	li	a3,43
    1456:	04d70a63          	beq	a4,a3,14aa <atoi+0x72>
    145a:	02d00693          	li	a3,45
    145e:	06d70463          	beq	a4,a3,14c6 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1462:	fd07859b          	addiw	a1,a5,-48
    1466:	4625                	li	a2,9
    1468:	873e                	mv	a4,a5
    146a:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    146c:	4e01                	li	t3,0
    while (isdigit(*s))
    146e:	04b66a63          	bltu	a2,a1,14c2 <atoi+0x8a>
    int n = 0, neg = 0;
    1472:	4501                	li	a0,0
    while (isdigit(*s))
    1474:	4825                	li	a6,9
    1476:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    147a:	0025179b          	slliw	a5,a0,0x2
    147e:	9d3d                	addw	a0,a0,a5
    1480:	fd07031b          	addiw	t1,a4,-48
    1484:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1488:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    148c:	0685                	addi	a3,a3,1
    148e:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1492:	0006071b          	sext.w	a4,a2
    1496:	feb870e3          	bgeu	a6,a1,1476 <atoi+0x3e>
    return neg ? n : -n;
    149a:	000e0563          	beqz	t3,14a4 <atoi+0x6c>
}
    149e:	8082                	ret
        s++;
    14a0:	0505                	addi	a0,a0,1
    14a2:	bf71                	j	143e <atoi+0x6>
    14a4:	4113053b          	subw	a0,t1,a7
    14a8:	8082                	ret
    while (isdigit(*s))
    14aa:	00154783          	lbu	a5,1(a0)
    14ae:	4625                	li	a2,9
        s++;
    14b0:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    14b4:	fd07859b          	addiw	a1,a5,-48
    14b8:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    14bc:	4e01                	li	t3,0
    while (isdigit(*s))
    14be:	fab67ae3          	bgeu	a2,a1,1472 <atoi+0x3a>
    14c2:	4501                	li	a0,0
}
    14c4:	8082                	ret
    while (isdigit(*s))
    14c6:	00154783          	lbu	a5,1(a0)
    14ca:	4625                	li	a2,9
        s++;
    14cc:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    14d0:	fd07859b          	addiw	a1,a5,-48
    14d4:	0007871b          	sext.w	a4,a5
    14d8:	feb665e3          	bltu	a2,a1,14c2 <atoi+0x8a>
        neg = 1;
    14dc:	4e05                	li	t3,1
    14de:	bf51                	j	1472 <atoi+0x3a>

00000000000014e0 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    14e0:	16060d63          	beqz	a2,165a <memset+0x17a>
    14e4:	40a007b3          	neg	a5,a0
    14e8:	8b9d                	andi	a5,a5,7
    14ea:	00778713          	addi	a4,a5,7
    14ee:	482d                	li	a6,11
    14f0:	0ff5f593          	andi	a1,a1,255
    14f4:	fff60693          	addi	a3,a2,-1
    14f8:	17076263          	bltu	a4,a6,165c <memset+0x17c>
    14fc:	16e6ea63          	bltu	a3,a4,1670 <memset+0x190>
    1500:	16078563          	beqz	a5,166a <memset+0x18a>
    1504:	00b50023          	sb	a1,0(a0)
    1508:	4705                	li	a4,1
    150a:	00150e93          	addi	t4,a0,1
    150e:	14e78c63          	beq	a5,a4,1666 <memset+0x186>
    1512:	00b500a3          	sb	a1,1(a0)
    1516:	4709                	li	a4,2
    1518:	00250e93          	addi	t4,a0,2
    151c:	14e78d63          	beq	a5,a4,1676 <memset+0x196>
    1520:	00b50123          	sb	a1,2(a0)
    1524:	470d                	li	a4,3
    1526:	00350e93          	addi	t4,a0,3
    152a:	12e78b63          	beq	a5,a4,1660 <memset+0x180>
    152e:	00b501a3          	sb	a1,3(a0)
    1532:	4711                	li	a4,4
    1534:	00450e93          	addi	t4,a0,4
    1538:	14e78163          	beq	a5,a4,167a <memset+0x19a>
    153c:	00b50223          	sb	a1,4(a0)
    1540:	4715                	li	a4,5
    1542:	00550e93          	addi	t4,a0,5
    1546:	12e78c63          	beq	a5,a4,167e <memset+0x19e>
    154a:	00b502a3          	sb	a1,5(a0)
    154e:	471d                	li	a4,7
    1550:	00650e93          	addi	t4,a0,6
    1554:	12e79763          	bne	a5,a4,1682 <memset+0x1a2>
    1558:	00750e93          	addi	t4,a0,7
    155c:	00b50323          	sb	a1,6(a0)
    1560:	4f1d                	li	t5,7
    1562:	00859713          	slli	a4,a1,0x8
    1566:	8f4d                	or	a4,a4,a1
    1568:	01059e13          	slli	t3,a1,0x10
    156c:	01c76e33          	or	t3,a4,t3
    1570:	01859313          	slli	t1,a1,0x18
    1574:	006e6333          	or	t1,t3,t1
    1578:	02059893          	slli	a7,a1,0x20
    157c:	011368b3          	or	a7,t1,a7
    1580:	02859813          	slli	a6,a1,0x28
    1584:	40f60333          	sub	t1,a2,a5
    1588:	0108e833          	or	a6,a7,a6
    158c:	03059693          	slli	a3,a1,0x30
    1590:	00d866b3          	or	a3,a6,a3
    1594:	03859713          	slli	a4,a1,0x38
    1598:	97aa                	add	a5,a5,a0
    159a:	ff837813          	andi	a6,t1,-8
    159e:	8f55                	or	a4,a4,a3
    15a0:	00f806b3          	add	a3,a6,a5
    15a4:	e398                	sd	a4,0(a5)
    15a6:	07a1                	addi	a5,a5,8
    15a8:	fed79ee3          	bne	a5,a3,15a4 <memset+0xc4>
    15ac:	ff837693          	andi	a3,t1,-8
    15b0:	00de87b3          	add	a5,t4,a3
    15b4:	01e6873b          	addw	a4,a3,t5
    15b8:	0ad30663          	beq	t1,a3,1664 <memset+0x184>
    15bc:	00b78023          	sb	a1,0(a5)
    15c0:	0017069b          	addiw	a3,a4,1
    15c4:	08c6fb63          	bgeu	a3,a2,165a <memset+0x17a>
    15c8:	00b780a3          	sb	a1,1(a5)
    15cc:	0027069b          	addiw	a3,a4,2
    15d0:	08c6f563          	bgeu	a3,a2,165a <memset+0x17a>
    15d4:	00b78123          	sb	a1,2(a5)
    15d8:	0037069b          	addiw	a3,a4,3
    15dc:	06c6ff63          	bgeu	a3,a2,165a <memset+0x17a>
    15e0:	00b781a3          	sb	a1,3(a5)
    15e4:	0047069b          	addiw	a3,a4,4
    15e8:	06c6f963          	bgeu	a3,a2,165a <memset+0x17a>
    15ec:	00b78223          	sb	a1,4(a5)
    15f0:	0057069b          	addiw	a3,a4,5
    15f4:	06c6f363          	bgeu	a3,a2,165a <memset+0x17a>
    15f8:	00b782a3          	sb	a1,5(a5)
    15fc:	0067069b          	addiw	a3,a4,6
    1600:	04c6fd63          	bgeu	a3,a2,165a <memset+0x17a>
    1604:	00b78323          	sb	a1,6(a5)
    1608:	0077069b          	addiw	a3,a4,7
    160c:	04c6f763          	bgeu	a3,a2,165a <memset+0x17a>
    1610:	00b783a3          	sb	a1,7(a5)
    1614:	0087069b          	addiw	a3,a4,8
    1618:	04c6f163          	bgeu	a3,a2,165a <memset+0x17a>
    161c:	00b78423          	sb	a1,8(a5)
    1620:	0097069b          	addiw	a3,a4,9
    1624:	02c6fb63          	bgeu	a3,a2,165a <memset+0x17a>
    1628:	00b784a3          	sb	a1,9(a5)
    162c:	00a7069b          	addiw	a3,a4,10
    1630:	02c6f563          	bgeu	a3,a2,165a <memset+0x17a>
    1634:	00b78523          	sb	a1,10(a5)
    1638:	00b7069b          	addiw	a3,a4,11
    163c:	00c6ff63          	bgeu	a3,a2,165a <memset+0x17a>
    1640:	00b785a3          	sb	a1,11(a5)
    1644:	00c7069b          	addiw	a3,a4,12
    1648:	00c6f963          	bgeu	a3,a2,165a <memset+0x17a>
    164c:	00b78623          	sb	a1,12(a5)
    1650:	2735                	addiw	a4,a4,13
    1652:	00c77463          	bgeu	a4,a2,165a <memset+0x17a>
    1656:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    165a:	8082                	ret
    165c:	472d                	li	a4,11
    165e:	bd79                	j	14fc <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1660:	4f0d                	li	t5,3
    1662:	b701                	j	1562 <memset+0x82>
    1664:	8082                	ret
    1666:	4f05                	li	t5,1
    1668:	bded                	j	1562 <memset+0x82>
    166a:	8eaa                	mv	t4,a0
    166c:	4f01                	li	t5,0
    166e:	bdd5                	j	1562 <memset+0x82>
    1670:	87aa                	mv	a5,a0
    1672:	4701                	li	a4,0
    1674:	b7a1                	j	15bc <memset+0xdc>
    1676:	4f09                	li	t5,2
    1678:	b5ed                	j	1562 <memset+0x82>
    167a:	4f11                	li	t5,4
    167c:	b5dd                	j	1562 <memset+0x82>
    167e:	4f15                	li	t5,5
    1680:	b5cd                	j	1562 <memset+0x82>
    1682:	4f19                	li	t5,6
    1684:	bdf9                	j	1562 <memset+0x82>

0000000000001686 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    1686:	00054783          	lbu	a5,0(a0)
    168a:	0005c703          	lbu	a4,0(a1)
    168e:	00e79863          	bne	a5,a4,169e <strcmp+0x18>
    1692:	0505                	addi	a0,a0,1
    1694:	0585                	addi	a1,a1,1
    1696:	fbe5                	bnez	a5,1686 <strcmp>
    1698:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    169a:	9d19                	subw	a0,a0,a4
    169c:	8082                	ret
    169e:	0007851b          	sext.w	a0,a5
    16a2:	bfe5                	j	169a <strcmp+0x14>

00000000000016a4 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    16a4:	87aa                	mv	a5,a0
    16a6:	0005c703          	lbu	a4,0(a1)
    16aa:	0785                	addi	a5,a5,1
    16ac:	0585                	addi	a1,a1,1
    16ae:	fee78fa3          	sb	a4,-1(a5)
    16b2:	fb75                	bnez	a4,16a6 <strcpy+0x2>
        ;
    return os;
}
    16b4:	8082                	ret

00000000000016b6 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    16b6:	ce05                	beqz	a2,16ee <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    16b8:	00054703          	lbu	a4,0(a0)
    16bc:	0005c783          	lbu	a5,0(a1)
    16c0:	cb0d                	beqz	a4,16f2 <strncmp+0x3c>
    if (!n--)
    16c2:	167d                	addi	a2,a2,-1
    16c4:	00c506b3          	add	a3,a0,a2
    16c8:	a819                	j	16de <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    16ca:	00a68e63          	beq	a3,a0,16e6 <strncmp+0x30>
    16ce:	0505                	addi	a0,a0,1
    16d0:	00e79b63          	bne	a5,a4,16e6 <strncmp+0x30>
    16d4:	00054703          	lbu	a4,0(a0)
    16d8:	0005c783          	lbu	a5,0(a1)
    16dc:	cb19                	beqz	a4,16f2 <strncmp+0x3c>
    16de:	0005c783          	lbu	a5,0(a1)
    16e2:	0585                	addi	a1,a1,1
    16e4:	f3fd                	bnez	a5,16ca <strncmp+0x14>
        ;
    return *l - *r;
    16e6:	0007051b          	sext.w	a0,a4
    16ea:	9d1d                	subw	a0,a0,a5
    16ec:	8082                	ret
        return 0;
    16ee:	4501                	li	a0,0
}
    16f0:	8082                	ret
    16f2:	4501                	li	a0,0
    return *l - *r;
    16f4:	9d1d                	subw	a0,a0,a5
    16f6:	8082                	ret

00000000000016f8 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    16f8:	00757793          	andi	a5,a0,7
    16fc:	cf89                	beqz	a5,1716 <strlen+0x1e>
    16fe:	87aa                	mv	a5,a0
    1700:	a029                	j	170a <strlen+0x12>
    1702:	0785                	addi	a5,a5,1
    1704:	0077f713          	andi	a4,a5,7
    1708:	cb01                	beqz	a4,1718 <strlen+0x20>
        if (!*s)
    170a:	0007c703          	lbu	a4,0(a5)
    170e:	fb75                	bnez	a4,1702 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1710:	40a78533          	sub	a0,a5,a0
}
    1714:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1716:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    1718:	6394                	ld	a3,0(a5)
    171a:	00000597          	auipc	a1,0x0
    171e:	62e5b583          	ld	a1,1582(a1) # 1d48 <sharedmem+0x22>
    1722:	00000617          	auipc	a2,0x0
    1726:	62e63603          	ld	a2,1582(a2) # 1d50 <sharedmem+0x2a>
    172a:	a019                	j	1730 <strlen+0x38>
    172c:	6794                	ld	a3,8(a5)
    172e:	07a1                	addi	a5,a5,8
    1730:	00b68733          	add	a4,a3,a1
    1734:	fff6c693          	not	a3,a3
    1738:	8f75                	and	a4,a4,a3
    173a:	8f71                	and	a4,a4,a2
    173c:	db65                	beqz	a4,172c <strlen+0x34>
    for (; *s; s++)
    173e:	0007c703          	lbu	a4,0(a5)
    1742:	d779                	beqz	a4,1710 <strlen+0x18>
    1744:	0017c703          	lbu	a4,1(a5)
    1748:	0785                	addi	a5,a5,1
    174a:	d379                	beqz	a4,1710 <strlen+0x18>
    174c:	0017c703          	lbu	a4,1(a5)
    1750:	0785                	addi	a5,a5,1
    1752:	fb6d                	bnez	a4,1744 <strlen+0x4c>
    1754:	bf75                	j	1710 <strlen+0x18>

0000000000001756 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1756:	00757713          	andi	a4,a0,7
{
    175a:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    175c:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1760:	cb19                	beqz	a4,1776 <memchr+0x20>
    1762:	ce25                	beqz	a2,17da <memchr+0x84>
    1764:	0007c703          	lbu	a4,0(a5)
    1768:	04b70e63          	beq	a4,a1,17c4 <memchr+0x6e>
    176c:	0785                	addi	a5,a5,1
    176e:	0077f713          	andi	a4,a5,7
    1772:	167d                	addi	a2,a2,-1
    1774:	f77d                	bnez	a4,1762 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    1776:	4501                	li	a0,0
    if (n && *s != c) {
    1778:	c235                	beqz	a2,17dc <memchr+0x86>
    177a:	0007c703          	lbu	a4,0(a5)
    177e:	04b70363          	beq	a4,a1,17c4 <memchr+0x6e>
        size_t k = ONES * c;
    1782:	00000517          	auipc	a0,0x0
    1786:	5d653503          	ld	a0,1494(a0) # 1d58 <sharedmem+0x32>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    178a:	471d                	li	a4,7
        size_t k = ONES * c;
    178c:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1790:	02c77a63          	bgeu	a4,a2,17c4 <memchr+0x6e>
    1794:	00000897          	auipc	a7,0x0
    1798:	5b48b883          	ld	a7,1460(a7) # 1d48 <sharedmem+0x22>
    179c:	00000817          	auipc	a6,0x0
    17a0:	5b483803          	ld	a6,1460(a6) # 1d50 <sharedmem+0x2a>
    17a4:	431d                	li	t1,7
    17a6:	a029                	j	17b0 <memchr+0x5a>
    17a8:	1661                	addi	a2,a2,-8
    17aa:	07a1                	addi	a5,a5,8
    17ac:	02c37963          	bgeu	t1,a2,17de <memchr+0x88>
    17b0:	6398                	ld	a4,0(a5)
    17b2:	8f29                	xor	a4,a4,a0
    17b4:	011706b3          	add	a3,a4,a7
    17b8:	fff74713          	not	a4,a4
    17bc:	8f75                	and	a4,a4,a3
    17be:	01077733          	and	a4,a4,a6
    17c2:	d37d                	beqz	a4,17a8 <memchr+0x52>
    17c4:	853e                	mv	a0,a5
    17c6:	97b2                	add	a5,a5,a2
    17c8:	a021                	j	17d0 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    17ca:	0505                	addi	a0,a0,1
    17cc:	00f50763          	beq	a0,a5,17da <memchr+0x84>
    17d0:	00054703          	lbu	a4,0(a0)
    17d4:	feb71be3          	bne	a4,a1,17ca <memchr+0x74>
    17d8:	8082                	ret
    return n ? (void*)s : 0;
    17da:	4501                	li	a0,0
}
    17dc:	8082                	ret
    return n ? (void*)s : 0;
    17de:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    17e0:	f275                	bnez	a2,17c4 <memchr+0x6e>
}
    17e2:	8082                	ret

00000000000017e4 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    17e4:	1101                	addi	sp,sp,-32
    17e6:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    17e8:	862e                	mv	a2,a1
{
    17ea:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    17ec:	4581                	li	a1,0
{
    17ee:	e426                	sd	s1,8(sp)
    17f0:	ec06                	sd	ra,24(sp)
    17f2:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    17f4:	f63ff0ef          	jal	ra,1756 <memchr>
    return p ? p - s : n;
    17f8:	c519                	beqz	a0,1806 <strnlen+0x22>
}
    17fa:	60e2                	ld	ra,24(sp)
    17fc:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    17fe:	8d05                	sub	a0,a0,s1
}
    1800:	64a2                	ld	s1,8(sp)
    1802:	6105                	addi	sp,sp,32
    1804:	8082                	ret
    1806:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1808:	8522                	mv	a0,s0
}
    180a:	6442                	ld	s0,16(sp)
    180c:	64a2                	ld	s1,8(sp)
    180e:	6105                	addi	sp,sp,32
    1810:	8082                	ret

0000000000001812 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1812:	00b547b3          	xor	a5,a0,a1
    1816:	8b9d                	andi	a5,a5,7
    1818:	eb95                	bnez	a5,184c <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    181a:	0075f793          	andi	a5,a1,7
    181e:	e7b1                	bnez	a5,186a <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1820:	6198                	ld	a4,0(a1)
    1822:	00000617          	auipc	a2,0x0
    1826:	52663603          	ld	a2,1318(a2) # 1d48 <sharedmem+0x22>
    182a:	00000817          	auipc	a6,0x0
    182e:	52683803          	ld	a6,1318(a6) # 1d50 <sharedmem+0x2a>
    1832:	a029                	j	183c <stpcpy+0x2a>
    1834:	e118                	sd	a4,0(a0)
    1836:	6598                	ld	a4,8(a1)
    1838:	05a1                	addi	a1,a1,8
    183a:	0521                	addi	a0,a0,8
    183c:	00c707b3          	add	a5,a4,a2
    1840:	fff74693          	not	a3,a4
    1844:	8ff5                	and	a5,a5,a3
    1846:	0107f7b3          	and	a5,a5,a6
    184a:	d7ed                	beqz	a5,1834 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    184c:	0005c783          	lbu	a5,0(a1)
    1850:	00f50023          	sb	a5,0(a0)
    1854:	c785                	beqz	a5,187c <stpcpy+0x6a>
    1856:	0015c783          	lbu	a5,1(a1)
    185a:	0505                	addi	a0,a0,1
    185c:	0585                	addi	a1,a1,1
    185e:	00f50023          	sb	a5,0(a0)
    1862:	fbf5                	bnez	a5,1856 <stpcpy+0x44>
        ;
    return d;
}
    1864:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1866:	0505                	addi	a0,a0,1
    1868:	df45                	beqz	a4,1820 <stpcpy+0xe>
            if (!(*d = *s))
    186a:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    186e:	0585                	addi	a1,a1,1
    1870:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1874:	00f50023          	sb	a5,0(a0)
    1878:	f7fd                	bnez	a5,1866 <stpcpy+0x54>
}
    187a:	8082                	ret
    187c:	8082                	ret

000000000000187e <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    187e:	00b547b3          	xor	a5,a0,a1
    1882:	8b9d                	andi	a5,a5,7
    1884:	1a079863          	bnez	a5,1a34 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1888:	0075f793          	andi	a5,a1,7
    188c:	16078463          	beqz	a5,19f4 <stpncpy+0x176>
    1890:	ea01                	bnez	a2,18a0 <stpncpy+0x22>
    1892:	a421                	j	1a9a <stpncpy+0x21c>
    1894:	167d                	addi	a2,a2,-1
    1896:	0505                	addi	a0,a0,1
    1898:	14070e63          	beqz	a4,19f4 <stpncpy+0x176>
    189c:	1a060863          	beqz	a2,1a4c <stpncpy+0x1ce>
    18a0:	0005c783          	lbu	a5,0(a1)
    18a4:	0585                	addi	a1,a1,1
    18a6:	0075f713          	andi	a4,a1,7
    18aa:	00f50023          	sb	a5,0(a0)
    18ae:	f3fd                	bnez	a5,1894 <stpncpy+0x16>
    18b0:	4805                	li	a6,1
    18b2:	1a061863          	bnez	a2,1a62 <stpncpy+0x1e4>
    18b6:	40a007b3          	neg	a5,a0
    18ba:	8b9d                	andi	a5,a5,7
    18bc:	4681                	li	a3,0
    18be:	18061a63          	bnez	a2,1a52 <stpncpy+0x1d4>
    18c2:	00778713          	addi	a4,a5,7
    18c6:	45ad                	li	a1,11
    18c8:	18b76363          	bltu	a4,a1,1a4e <stpncpy+0x1d0>
    18cc:	1ae6eb63          	bltu	a3,a4,1a82 <stpncpy+0x204>
    18d0:	1a078363          	beqz	a5,1a76 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    18d4:	00050023          	sb	zero,0(a0)
    18d8:	4685                	li	a3,1
    18da:	00150713          	addi	a4,a0,1
    18de:	18d78f63          	beq	a5,a3,1a7c <stpncpy+0x1fe>
    18e2:	000500a3          	sb	zero,1(a0)
    18e6:	4689                	li	a3,2
    18e8:	00250713          	addi	a4,a0,2
    18ec:	18d78e63          	beq	a5,a3,1a88 <stpncpy+0x20a>
    18f0:	00050123          	sb	zero,2(a0)
    18f4:	468d                	li	a3,3
    18f6:	00350713          	addi	a4,a0,3
    18fa:	16d78c63          	beq	a5,a3,1a72 <stpncpy+0x1f4>
    18fe:	000501a3          	sb	zero,3(a0)
    1902:	4691                	li	a3,4
    1904:	00450713          	addi	a4,a0,4
    1908:	18d78263          	beq	a5,a3,1a8c <stpncpy+0x20e>
    190c:	00050223          	sb	zero,4(a0)
    1910:	4695                	li	a3,5
    1912:	00550713          	addi	a4,a0,5
    1916:	16d78d63          	beq	a5,a3,1a90 <stpncpy+0x212>
    191a:	000502a3          	sb	zero,5(a0)
    191e:	469d                	li	a3,7
    1920:	00650713          	addi	a4,a0,6
    1924:	16d79863          	bne	a5,a3,1a94 <stpncpy+0x216>
    1928:	00750713          	addi	a4,a0,7
    192c:	00050323          	sb	zero,6(a0)
    1930:	40f80833          	sub	a6,a6,a5
    1934:	ff887593          	andi	a1,a6,-8
    1938:	97aa                	add	a5,a5,a0
    193a:	95be                	add	a1,a1,a5
    193c:	0007b023          	sd	zero,0(a5)
    1940:	07a1                	addi	a5,a5,8
    1942:	feb79de3          	bne	a5,a1,193c <stpncpy+0xbe>
    1946:	ff887593          	andi	a1,a6,-8
    194a:	9ead                	addw	a3,a3,a1
    194c:	00b707b3          	add	a5,a4,a1
    1950:	12b80863          	beq	a6,a1,1a80 <stpncpy+0x202>
    1954:	00078023          	sb	zero,0(a5)
    1958:	0016871b          	addiw	a4,a3,1
    195c:	0ec77863          	bgeu	a4,a2,1a4c <stpncpy+0x1ce>
    1960:	000780a3          	sb	zero,1(a5)
    1964:	0026871b          	addiw	a4,a3,2
    1968:	0ec77263          	bgeu	a4,a2,1a4c <stpncpy+0x1ce>
    196c:	00078123          	sb	zero,2(a5)
    1970:	0036871b          	addiw	a4,a3,3
    1974:	0cc77c63          	bgeu	a4,a2,1a4c <stpncpy+0x1ce>
    1978:	000781a3          	sb	zero,3(a5)
    197c:	0046871b          	addiw	a4,a3,4
    1980:	0cc77663          	bgeu	a4,a2,1a4c <stpncpy+0x1ce>
    1984:	00078223          	sb	zero,4(a5)
    1988:	0056871b          	addiw	a4,a3,5
    198c:	0cc77063          	bgeu	a4,a2,1a4c <stpncpy+0x1ce>
    1990:	000782a3          	sb	zero,5(a5)
    1994:	0066871b          	addiw	a4,a3,6
    1998:	0ac77a63          	bgeu	a4,a2,1a4c <stpncpy+0x1ce>
    199c:	00078323          	sb	zero,6(a5)
    19a0:	0076871b          	addiw	a4,a3,7
    19a4:	0ac77463          	bgeu	a4,a2,1a4c <stpncpy+0x1ce>
    19a8:	000783a3          	sb	zero,7(a5)
    19ac:	0086871b          	addiw	a4,a3,8
    19b0:	08c77e63          	bgeu	a4,a2,1a4c <stpncpy+0x1ce>
    19b4:	00078423          	sb	zero,8(a5)
    19b8:	0096871b          	addiw	a4,a3,9
    19bc:	08c77863          	bgeu	a4,a2,1a4c <stpncpy+0x1ce>
    19c0:	000784a3          	sb	zero,9(a5)
    19c4:	00a6871b          	addiw	a4,a3,10
    19c8:	08c77263          	bgeu	a4,a2,1a4c <stpncpy+0x1ce>
    19cc:	00078523          	sb	zero,10(a5)
    19d0:	00b6871b          	addiw	a4,a3,11
    19d4:	06c77c63          	bgeu	a4,a2,1a4c <stpncpy+0x1ce>
    19d8:	000785a3          	sb	zero,11(a5)
    19dc:	00c6871b          	addiw	a4,a3,12
    19e0:	06c77663          	bgeu	a4,a2,1a4c <stpncpy+0x1ce>
    19e4:	00078623          	sb	zero,12(a5)
    19e8:	26b5                	addiw	a3,a3,13
    19ea:	06c6f163          	bgeu	a3,a2,1a4c <stpncpy+0x1ce>
    19ee:	000786a3          	sb	zero,13(a5)
    19f2:	8082                	ret
            ;
        if (!n || !*s)
    19f4:	c645                	beqz	a2,1a9c <stpncpy+0x21e>
    19f6:	0005c783          	lbu	a5,0(a1)
    19fa:	ea078be3          	beqz	a5,18b0 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    19fe:	479d                	li	a5,7
    1a00:	02c7ff63          	bgeu	a5,a2,1a3e <stpncpy+0x1c0>
    1a04:	00000897          	auipc	a7,0x0
    1a08:	3448b883          	ld	a7,836(a7) # 1d48 <sharedmem+0x22>
    1a0c:	00000817          	auipc	a6,0x0
    1a10:	34483803          	ld	a6,836(a6) # 1d50 <sharedmem+0x2a>
    1a14:	431d                	li	t1,7
    1a16:	6198                	ld	a4,0(a1)
    1a18:	011707b3          	add	a5,a4,a7
    1a1c:	fff74693          	not	a3,a4
    1a20:	8ff5                	and	a5,a5,a3
    1a22:	0107f7b3          	and	a5,a5,a6
    1a26:	ef81                	bnez	a5,1a3e <stpncpy+0x1c0>
            *wd = *ws;
    1a28:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1a2a:	1661                	addi	a2,a2,-8
    1a2c:	05a1                	addi	a1,a1,8
    1a2e:	0521                	addi	a0,a0,8
    1a30:	fec363e3          	bltu	t1,a2,1a16 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1a34:	e609                	bnez	a2,1a3e <stpncpy+0x1c0>
    1a36:	a08d                	j	1a98 <stpncpy+0x21a>
    1a38:	167d                	addi	a2,a2,-1
    1a3a:	0505                	addi	a0,a0,1
    1a3c:	ca01                	beqz	a2,1a4c <stpncpy+0x1ce>
    1a3e:	0005c783          	lbu	a5,0(a1)
    1a42:	0585                	addi	a1,a1,1
    1a44:	00f50023          	sb	a5,0(a0)
    1a48:	fbe5                	bnez	a5,1a38 <stpncpy+0x1ba>
        ;
tail:
    1a4a:	b59d                	j	18b0 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1a4c:	8082                	ret
    1a4e:	472d                	li	a4,11
    1a50:	bdb5                	j	18cc <stpncpy+0x4e>
    1a52:	00778713          	addi	a4,a5,7
    1a56:	45ad                	li	a1,11
    1a58:	fff60693          	addi	a3,a2,-1
    1a5c:	e6b778e3          	bgeu	a4,a1,18cc <stpncpy+0x4e>
    1a60:	b7fd                	j	1a4e <stpncpy+0x1d0>
    1a62:	40a007b3          	neg	a5,a0
    1a66:	8832                	mv	a6,a2
    1a68:	8b9d                	andi	a5,a5,7
    1a6a:	4681                	li	a3,0
    1a6c:	e4060be3          	beqz	a2,18c2 <stpncpy+0x44>
    1a70:	b7cd                	j	1a52 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1a72:	468d                	li	a3,3
    1a74:	bd75                	j	1930 <stpncpy+0xb2>
    1a76:	872a                	mv	a4,a0
    1a78:	4681                	li	a3,0
    1a7a:	bd5d                	j	1930 <stpncpy+0xb2>
    1a7c:	4685                	li	a3,1
    1a7e:	bd4d                	j	1930 <stpncpy+0xb2>
    1a80:	8082                	ret
    1a82:	87aa                	mv	a5,a0
    1a84:	4681                	li	a3,0
    1a86:	b5f9                	j	1954 <stpncpy+0xd6>
    1a88:	4689                	li	a3,2
    1a8a:	b55d                	j	1930 <stpncpy+0xb2>
    1a8c:	4691                	li	a3,4
    1a8e:	b54d                	j	1930 <stpncpy+0xb2>
    1a90:	4695                	li	a3,5
    1a92:	bd79                	j	1930 <stpncpy+0xb2>
    1a94:	4699                	li	a3,6
    1a96:	bd69                	j	1930 <stpncpy+0xb2>
    1a98:	8082                	ret
    1a9a:	8082                	ret
    1a9c:	8082                	ret

0000000000001a9e <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1a9e:	fff6071b          	addiw	a4,a2,-1
    1aa2:	0cb57063          	bgeu	a0,a1,1b62 <memmove+0xc4>
        while (n-- > 0)
    1aa6:	0ec05063          	blez	a2,1b86 <memmove+0xe8>
    1aaa:	00750693          	addi	a3,a0,7
    1aae:	8e8d                	sub	a3,a3,a1
    1ab0:	00b567b3          	or	a5,a0,a1
    1ab4:	00f6b693          	sltiu	a3,a3,15
    1ab8:	8b9d                	andi	a5,a5,7
    1aba:	0016c693          	xori	a3,a3,1
    1abe:	0017b793          	seqz	a5,a5
    1ac2:	8ff5                	and	a5,a5,a3
    1ac4:	c3f1                	beqz	a5,1b88 <memmove+0xea>
    1ac6:	0007079b          	sext.w	a5,a4
    1aca:	46a5                	li	a3,9
    1acc:	0af6fe63          	bgeu	a3,a5,1b88 <memmove+0xea>
    1ad0:	0036589b          	srliw	a7,a2,0x3
    1ad4:	088e                	slli	a7,a7,0x3
    1ad6:	2601                	sext.w	a2,a2
    1ad8:	87ae                	mv	a5,a1
    1ada:	86aa                	mv	a3,a0
    1adc:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1ade:	0007b803          	ld	a6,0(a5)
    1ae2:	07a1                	addi	a5,a5,8
    1ae4:	06a1                	addi	a3,a3,8
    1ae6:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1aea:	ff179ae3          	bne	a5,a7,1ade <memmove+0x40>
    1aee:	ff867813          	andi	a6,a2,-8
    1af2:	02081793          	slli	a5,a6,0x20
    1af6:	9381                	srli	a5,a5,0x20
    1af8:	00f506b3          	add	a3,a0,a5
    1afc:	95be                	add	a1,a1,a5
    1afe:	4107073b          	subw	a4,a4,a6
    1b02:	09060263          	beq	a2,a6,1b86 <memmove+0xe8>
            *dst++ = *src++;
    1b06:	0005c783          	lbu	a5,0(a1)
    1b0a:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1b0e:	06e05c63          	blez	a4,1b86 <memmove+0xe8>
            *dst++ = *src++;
    1b12:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1b16:	4785                	li	a5,1
            *dst++ = *src++;
    1b18:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1b1c:	06e7d563          	bge	a5,a4,1b86 <memmove+0xe8>
            *dst++ = *src++;
    1b20:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1b24:	4789                	li	a5,2
            *dst++ = *src++;
    1b26:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1b2a:	04e7de63          	bge	a5,a4,1b86 <memmove+0xe8>
            *dst++ = *src++;
    1b2e:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1b32:	478d                	li	a5,3
            *dst++ = *src++;
    1b34:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1b38:	04e7d763          	bge	a5,a4,1b86 <memmove+0xe8>
            *dst++ = *src++;
    1b3c:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1b40:	4791                	li	a5,4
            *dst++ = *src++;
    1b42:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1b46:	04e7d063          	bge	a5,a4,1b86 <memmove+0xe8>
            *dst++ = *src++;
    1b4a:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1b4e:	4795                	li	a5,5
            *dst++ = *src++;
    1b50:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1b54:	02e7d963          	bge	a5,a4,1b86 <memmove+0xe8>
            *dst++ = *src++;
    1b58:	0065c783          	lbu	a5,6(a1)
    1b5c:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1b60:	8082                	ret
    } else {
        dst += n;
    1b62:	00c507b3          	add	a5,a0,a2
        src += n;
    1b66:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1b68:	00c05f63          	blez	a2,1b86 <memmove+0xe8>
    1b6c:	1702                	slli	a4,a4,0x20
    1b6e:	9301                	srli	a4,a4,0x20
    1b70:	fff74713          	not	a4,a4
    1b74:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1b76:	fff5c683          	lbu	a3,-1(a1)
    1b7a:	17fd                	addi	a5,a5,-1
    1b7c:	15fd                	addi	a1,a1,-1
    1b7e:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1b82:	fee79ae3          	bne	a5,a4,1b76 <memmove+0xd8>
    }
    return vdst;
}
    1b86:	8082                	ret
    1b88:	02071693          	slli	a3,a4,0x20
    1b8c:	9281                	srli	a3,a3,0x20
    1b8e:	0685                	addi	a3,a3,1
    1b90:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1b92:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1b94:	0005c703          	lbu	a4,0(a1)
    1b98:	0585                	addi	a1,a1,1
    1b9a:	0785                	addi	a5,a5,1
    1b9c:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1ba0:	fed59ae3          	bne	a1,a3,1b94 <memmove+0xf6>
    1ba4:	8082                	ret

0000000000001ba6 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1ba6:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1baa:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1bae:	2501                	sext.w	a0,a0
    1bb0:	8082                	ret

0000000000001bb2 <exec>:
    register long a7 __asm__("a7") = n;
    1bb2:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1bb6:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1bb8:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1bbc:	2501                	sext.w	a0,a0
    1bbe:	8082                	ret

0000000000001bc0 <exit>:
    register long a7 __asm__("a7") = n;
    1bc0:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1bc4:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1bc8:	8082                	ret

0000000000001bca <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1bca:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1bce:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1bd2:	8082                	ret

0000000000001bd4 <write>:
    register long a7 __asm__("a7") = n;
    1bd4:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1bd8:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1bdc:	8082                	ret

0000000000001bde <getpid>:
    register long a7 __asm__("a7") = n;
    1bde:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1be2:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1be6:	2501                	sext.w	a0,a0
    1be8:	8082                	ret

0000000000001bea <getppid>:
    register long a7 __asm__("a7") = n;
    1bea:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1bee:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1bf2:	2501                	sext.w	a0,a0
    1bf4:	8082                	ret

0000000000001bf6 <open>:
    register long a7 __asm__("a7") = n;
    1bf6:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1bfa:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1bfe:	2501                	sext.w	a0,a0
    1c00:	8082                	ret

0000000000001c02 <mknod>:
    register long a7 __asm__("a7") = n;
    1c02:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c06:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1c0a:	2501                	sext.w	a0,a0
    1c0c:	8082                	ret

0000000000001c0e <dup>:
    register long a7 __asm__("a7") = n;
    1c0e:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1c10:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1c14:	2501                	sext.w	a0,a0
    1c16:	8082                	ret

0000000000001c18 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c18:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c1c:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c20:	2501                	sext.w	a0,a0
    1c22:	8082                	ret

0000000000001c24 <waitpid>:
    register long a7 __asm__("a7") = n;
    1c24:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c28:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1c2c:	2501                	sext.w	a0,a0
    1c2e:	8082                	ret

0000000000001c30 <wait>:

pid_t wait(int *wstatus)
{
    1c30:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1c32:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1c36:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c38:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1c3c:	2501                	sext.w	a0,a0
    1c3e:	8082                	ret

0000000000001c40 <mkdir>:
    register long a7 __asm__("a7") = n;
    1c40:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1c44:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1c48:	2501                	sext.w	a0,a0
    1c4a:	8082                	ret

0000000000001c4c <close>:
    register long a7 __asm__("a7") = n;
    1c4c:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c50:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c54:	2501                	sext.w	a0,a0
    1c56:	8082                	ret

0000000000001c58 <fork>:
    register long a7 __asm__("a7") = n;
    1c58:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1c5c:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1c60:	2501                	sext.w	a0,a0
    1c62:	8082                	ret

0000000000001c64 <time_ms>:
    register long a7 __asm__("a7") = n;
    1c64:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c68:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1c6c:	8082                	ret

0000000000001c6e <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1c6e:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1c70:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c74:	00000073          	ecall
    1c78:	87aa                	mv	a5,a0
    1c7a:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1c7e:	97ba                	add	a5,a5,a4
    1c80:	00f57c63          	bgeu	a0,a5,1c98 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1c84:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c88:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1c8c:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c90:	00000073          	ecall
    1c94:	fef568e3          	bltu	a0,a5,1c84 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1c98:	4501                	li	a0,0
    1c9a:	8082                	ret

0000000000001c9c <pipe>:
    register long a7 __asm__("a7") = n;
    1c9c:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1ca0:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1ca4:	2501                	sext.w	a0,a0
    1ca6:	8082                	ret

0000000000001ca8 <fstat>:
    register long a7 __asm__("a7") = n;
    1ca8:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cac:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1cb0:	2501                	sext.w	a0,a0
    1cb2:	8082                	ret

0000000000001cb4 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1cb4:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1cb6:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1cba:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cbc:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1cc0:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1cc4:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1cc8:	0206c163          	bltz	a3,1cea <stat+0x36>
    register long a7 __asm__("a7") = n;
    1ccc:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1cd0:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1cd2:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cd4:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1cd8:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1cdc:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1ce0:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1ce2:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1ce6:	853e                	mv	a0,a5
    1ce8:	8082                	ret
        return -1;
    1cea:	57fd                	li	a5,-1
    1cec:	bfed                	j	1ce6 <stat+0x32>

0000000000001cee <chdir>:
    register long a7 __asm__("a7") = n;
    1cee:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1cf2:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1cf6:	2501                	sext.w	a0,a0
    1cf8:	8082                	ret

0000000000001cfa <link>:
    register long a7 __asm__("a7") = n;
    1cfa:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cfe:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1d02:	2501                	sext.w	a0,a0
    1d04:	8082                	ret

0000000000001d06 <unlink>:
    register long a7 __asm__("a7") = n;
    1d06:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1d0a:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1d0e:	2501                	sext.w	a0,a0
    1d10:	8082                	ret

0000000000001d12 <setpriority>:
    register long a7 __asm__("a7") = n;
    1d12:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d16:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1d1a:	8082                	ret

0000000000001d1c <getpriority>:
    register long a7 __asm__("a7") = n;
    1d1c:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1d20:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1d24:	8082                	ret

0000000000001d26 <sharedmem>:
    register long a7 __asm__("a7") = n;
    1d26:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d2a:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1d2e:	8082                	ret
