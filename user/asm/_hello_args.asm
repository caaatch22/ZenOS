
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_hello_args:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a829                	j	101a <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <stdio.h>
#include <ucore.h>

int main(int argc, char* argv[]) {
    1002:	1141                	addi	sp,sp,-16
    puts("hello args!");
    1004:	00001517          	auipc	a0,0x1
    1008:	d1450513          	addi	a0,a0,-748 # 1d18 <sharedmem+0xa>
int main(int argc, char* argv[]) {
    100c:	e406                	sd	ra,8(sp)
    puts("hello args!");
    100e:	05c000ef          	jal	ra,106a <puts>
    return 0;
    1012:	60a2                	ld	ra,8(sp)
    1014:	4501                	li	a0,0
    1016:	0141                	addi	sp,sp,16
    1018:	8082                	ret

000000000000101a <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    101a:	1141                	addi	sp,sp,-16
    101c:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    101e:	fe5ff0ef          	jal	ra,1002 <main>
}
    1022:	60a2                	ld	ra,8(sp)
    1024:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    1026:	3830006f          	j	1ba8 <exit>

000000000000102a <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    102a:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    102c:	00f10593          	addi	a1,sp,15
    1030:	4605                	li	a2,1
    1032:	4501                	li	a0,0
int getchar() {
    1034:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1036:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    103a:	379000ef          	jal	ra,1bb2 <read>
    return byte;
}
    103e:	60e2                	ld	ra,24(sp)
    1040:	00f14503          	lbu	a0,15(sp)
    1044:	6105                	addi	sp,sp,32
    1046:	8082                	ret

0000000000001048 <putchar>:

int putchar(int c)
{
    1048:	1141                	addi	sp,sp,-16
    104a:	e406                	sd	ra,8(sp)
    104c:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    104e:	00001597          	auipc	a1,0x1
    1052:	cfa58593          	addi	a1,a1,-774 # 1d48 <put.1156>
    return write(stdout, put, 1);
    1056:	4605                	li	a2,1
    1058:	4505                	li	a0,1
    put[0] = c;
    105a:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    105e:	35f000ef          	jal	ra,1bbc <write>
}
    1062:	60a2                	ld	ra,8(sp)
    1064:	2501                	sext.w	a0,a0
    1066:	0141                	addi	sp,sp,16
    1068:	8082                	ret

000000000000106a <puts>:

int puts(const char* s)
{
    106a:	1141                	addi	sp,sp,-16
    106c:	e022                	sd	s0,0(sp)
    106e:	e406                	sd	ra,8(sp)
    1070:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    1072:	66e000ef          	jal	ra,16e0 <strlen>
    1076:	862a                	mv	a2,a0
    1078:	85a2                	mv	a1,s0
    107a:	4505                	li	a0,1
    107c:	341000ef          	jal	ra,1bbc <write>
    1080:	00055763          	bgez	a0,108e <puts+0x24>
    return r;
}
    1084:	60a2                	ld	ra,8(sp)
    1086:	6402                	ld	s0,0(sp)
    1088:	557d                	li	a0,-1
    108a:	0141                	addi	sp,sp,16
    108c:	8082                	ret
    put[0] = c;
    108e:	00001597          	auipc	a1,0x1
    1092:	cba58593          	addi	a1,a1,-838 # 1d48 <put.1156>
    1096:	47a9                	li	a5,10
    return write(stdout, put, 1);
    1098:	4605                	li	a2,1
    109a:	4505                	li	a0,1
    put[0] = c;
    109c:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    10a0:	31d000ef          	jal	ra,1bbc <write>
}
    10a4:	60a2                	ld	ra,8(sp)
    10a6:	6402                	ld	s0,0(sp)
    10a8:	41f5551b          	sraiw	a0,a0,0x1f
    10ac:	0141                	addi	sp,sp,16
    10ae:	8082                	ret

00000000000010b0 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    10b0:	7115                	addi	sp,sp,-224
    10b2:	ed06                	sd	ra,152(sp)
    10b4:	e922                	sd	s0,144(sp)
    10b6:	e526                	sd	s1,136(sp)
    10b8:	e14a                	sd	s2,128(sp)
    10ba:	fcce                	sd	s3,120(sp)
    10bc:	f8d2                	sd	s4,112(sp)
    10be:	f4d6                	sd	s5,104(sp)
    10c0:	f0da                	sd	s6,96(sp)
    10c2:	ecde                	sd	s7,88(sp)
    10c4:	e8e2                	sd	s8,80(sp)
    10c6:	e4e6                	sd	s9,72(sp)
    10c8:	e0ea                	sd	s10,64(sp)
    10ca:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    10cc:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    10d0:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    10d2:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    10d4:	f52e                	sd	a1,168(sp)
    10d6:	f932                	sd	a2,176(sp)
    10d8:	fd36                	sd	a3,184(sp)
    10da:	e1ba                	sd	a4,192(sp)
    10dc:	e9c2                	sd	a6,208(sp)
    10de:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    10e0:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    10e2:	0c030b63          	beqz	t1,11b8 <printf+0x108>
    10e6:	8aaa                	mv	s5,a0
    10e8:	0003071b          	sext.w	a4,t1
    10ec:	4481                	li	s1,0
        if (c != '%') {
    10ee:	02500b93          	li	s7,37
    put[0] = c;
    10f2:	00001417          	auipc	s0,0x1
    10f6:	c5640413          	addi	s0,s0,-938 # 1d48 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    10fa:	4c51                	li	s8,20
    put[0] = c;
    10fc:	02500c93          	li	s9,37
    1100:	00001a17          	auipc	s4,0x1
    1104:	c50a0a13          	addi	s4,s4,-944 # 1d50 <put.1156+0x8>
    1108:	00001997          	auipc	s3,0x1
    110c:	ca098993          	addi	s3,s3,-864 # 1da8 <digits>
    1110:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    1114:	0014879b          	addiw	a5,s1,1
    1118:	00fa8933          	add	s2,s5,a5
    111c:	13771163          	bne	a4,s7,123e <printf+0x18e>
        c = fmt[++i] & 0xff;
    1120:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    1124:	080d0a63          	beqz	s10,11b8 <printf+0x108>
        switch (c) {
    1128:	2489                	addiw	s1,s1,2
    112a:	009a8933          	add	s2,s5,s1
    112e:	257d0e63          	beq	s10,s7,138a <printf+0x2da>
    1132:	f9cd079b          	addiw	a5,s10,-100
    1136:	0ff7f793          	andi	a5,a5,255
    113a:	0cfc6263          	bltu	s8,a5,11fe <printf+0x14e>
    113e:	078a                	slli	a5,a5,0x2
    1140:	97d2                	add	a5,a5,s4
    1142:	439c                	lw	a5,0(a5)
    1144:	97d2                	add	a5,a5,s4
    1146:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    1148:	67a2                	ld	a5,8(sp)
    114a:	4398                	lw	a4,0(a5)
    114c:	07a1                	addi	a5,a5,8
    114e:	e43e                	sd	a5,8(sp)
    1150:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    1154:	26074663          	bltz	a4,13c0 <printf+0x310>
        buf[i++] = digits[x % base];
    1158:	8bbd                	andi	a5,a5,15
    115a:	97ce                	add	a5,a5,s3
    115c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1160:	40475d1b          	sraiw	s10,a4,0x4
    1164:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    1168:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    116c:	020d0163          	beqz	s10,118e <printf+0xde>
        buf[i++] = digits[x % base];
    1170:	9d4e                	add	s10,s10,s3
    1172:	000d4783          	lbu	a5,0(s10)
    1176:	4d05                	li	s10,1
    1178:	00f108a3          	sb	a5,17(sp)
    if (sign)
    117c:	00075963          	bgez	a4,118e <printf+0xde>
        buf[i++] = digits[x % base];
    1180:	4d09                	li	s10,2
        buf[i++] = '-';
    1182:	181c                	addi	a5,sp,48
    1184:	02d00713          	li	a4,45
    1188:	97ea                	add	a5,a5,s10
    118a:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    118e:	9d5a                	add	s10,s10,s6
    1190:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1194:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1198:	4605                	li	a2,1
    119a:	1d7d                	addi	s10,s10,-1
    119c:	85a2                	mv	a1,s0
    119e:	4505                	li	a0,1
    put[0] = c;
    11a0:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    11a4:	219000ef          	jal	ra,1bbc <write>
    while (--i >= 0)
    11a8:	ffbd16e3          	bne	s10,s11,1194 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    11ac:	00094303          	lbu	t1,0(s2)
    11b0:	0003071b          	sext.w	a4,t1
    11b4:	f60310e3          	bnez	t1,1114 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    11b8:	60ea                	ld	ra,152(sp)
    11ba:	644a                	ld	s0,144(sp)
    11bc:	64aa                	ld	s1,136(sp)
    11be:	690a                	ld	s2,128(sp)
    11c0:	79e6                	ld	s3,120(sp)
    11c2:	7a46                	ld	s4,112(sp)
    11c4:	7aa6                	ld	s5,104(sp)
    11c6:	7b06                	ld	s6,96(sp)
    11c8:	6be6                	ld	s7,88(sp)
    11ca:	6c46                	ld	s8,80(sp)
    11cc:	6ca6                	ld	s9,72(sp)
    11ce:	6d06                	ld	s10,64(sp)
    11d0:	7de2                	ld	s11,56(sp)
    11d2:	612d                	addi	sp,sp,224
    11d4:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    11d6:	67a2                	ld	a5,8(sp)
    11d8:	0007bd03          	ld	s10,0(a5)
    11dc:	07a1                	addi	a5,a5,8
    11de:	e43e                	sd	a5,8(sp)
    11e0:	000d1b63          	bnez	s10,11f6 <printf+0x146>
    11e4:	aafd                	j	13e2 <printf+0x332>
    return write(stdout, put, 1);
    11e6:	4605                	li	a2,1
    11e8:	85a2                	mv	a1,s0
    11ea:	4505                	li	a0,1
                for (; *s; s++)
    11ec:	0d05                	addi	s10,s10,1
    put[0] = c;
    11ee:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    11f2:	1cb000ef          	jal	ra,1bbc <write>
                for (; *s; s++)
    11f6:	000d4783          	lbu	a5,0(s10)
    11fa:	f7f5                	bnez	a5,11e6 <printf+0x136>
    11fc:	a02d                	j	1226 <printf+0x176>
    return write(stdout, put, 1);
    11fe:	4605                	li	a2,1
    1200:	00001597          	auipc	a1,0x1
    1204:	b4858593          	addi	a1,a1,-1208 # 1d48 <put.1156>
    1208:	4505                	li	a0,1
    put[0] = c;
    120a:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    120e:	1af000ef          	jal	ra,1bbc <write>
    1212:	4605                	li	a2,1
    1214:	00001597          	auipc	a1,0x1
    1218:	b3458593          	addi	a1,a1,-1228 # 1d48 <put.1156>
    121c:	4505                	li	a0,1
    put[0] = c;
    121e:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    1222:	19b000ef          	jal	ra,1bbc <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1226:	00094303          	lbu	t1,0(s2)
    122a:	0003071b          	sext.w	a4,t1
    122e:	f80305e3          	beqz	t1,11b8 <printf+0x108>
        if (c != '%') {
    1232:	0014879b          	addiw	a5,s1,1
    1236:	00fa8933          	add	s2,s5,a5
    123a:	ef7703e3          	beq	a4,s7,1120 <printf+0x70>
    return write(stdout, put, 1);
    123e:	4605                	li	a2,1
    1240:	00001597          	auipc	a1,0x1
    1244:	b0858593          	addi	a1,a1,-1272 # 1d48 <put.1156>
    1248:	4505                	li	a0,1
    put[0] = c;
    124a:	00640023          	sb	t1,0(s0)
            continue;
    124e:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    1250:	16d000ef          	jal	ra,1bbc <write>
            continue;
    1254:	bfc9                	j	1226 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    1256:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    1258:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    125a:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    125c:	0007b883          	ld	a7,0(a5)
    1260:	07a1                	addi	a5,a5,8
    1262:	e43e                	sd	a5,8(sp)
        x = -xx;
    1264:	43f8d713          	srai	a4,a7,0x3f
    1268:	011747b3          	xor	a5,a4,a7
    126c:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    126e:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    1270:	02c7f733          	remu	a4,a5,a2
    1274:	8d36                	mv	s10,a3
    1276:	0685                	addi	a3,a3,1
    1278:	00db0533          	add	a0,s6,a3
    127c:	85be                	mv	a1,a5
    127e:	974e                	add	a4,a4,s3
    1280:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    1284:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    1288:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    128c:	feb862e3          	bltu	a6,a1,1270 <printf+0x1c0>
    if (sign)
    1290:	1208c063          	bltz	a7,13b0 <printf+0x300>
    while (--i >= 0)
    1294:	9d5a                	add	s10,s10,s6
    put[0] = c;
    1296:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    129a:	4605                	li	a2,1
    129c:	85a2                	mv	a1,s0
    129e:	4505                	li	a0,1
    put[0] = c;
    12a0:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    12a4:	119000ef          	jal	ra,1bbc <write>
    while (--i >= 0)
    12a8:	87ea                	mv	a5,s10
    12aa:	1d7d                	addi	s10,s10,-1
    12ac:	fefb15e3          	bne	s6,a5,1296 <printf+0x1e6>
    12b0:	bf9d                	j	1226 <printf+0x176>
                printptr(va_arg(ap, uint64));
    12b2:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    12b4:	4605                	li	a2,1
    12b6:	00001597          	auipc	a1,0x1
    12ba:	a9258593          	addi	a1,a1,-1390 # 1d48 <put.1156>
                printptr(va_arg(ap, uint64));
    12be:	0007bd83          	ld	s11,0(a5)
    12c2:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    12c6:	4505                	li	a0,1
    put[0] = c;
    12c8:	03000793          	li	a5,48
    12cc:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    12d0:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    12d2:	0eb000ef          	jal	ra,1bbc <write>
    put[0] = c;
    12d6:	07800793          	li	a5,120
    return write(stdout, put, 1);
    12da:	4605                	li	a2,1
    12dc:	00001597          	auipc	a1,0x1
    12e0:	a6c58593          	addi	a1,a1,-1428 # 1d48 <put.1156>
    12e4:	4505                	li	a0,1
    put[0] = c;
    12e6:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    12ea:	4d41                	li	s10,16
    12ec:	0d1000ef          	jal	ra,1bbc <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    12f0:	03cdd793          	srli	a5,s11,0x3c
    12f4:	97ce                	add	a5,a5,s3
    put[0] = c;
    12f6:	0007c783          	lbu	a5,0(a5)
    12fa:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    12fc:	4605                	li	a2,1
    12fe:	85a2                	mv	a1,s0
    1300:	4505                	li	a0,1
    put[0] = c;
    1302:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1306:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1308:	0b5000ef          	jal	ra,1bbc <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    130c:	fe0d12e3          	bnez	s10,12f0 <printf+0x240>
    1310:	bf19                	j	1226 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    1312:	67a2                	ld	a5,8(sp)
    1314:	4394                	lw	a3,0(a5)
    1316:	07a1                	addi	a5,a5,8
    1318:	e43e                	sd	a5,8(sp)
    131a:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    131e:	0006d663          	bgez	a3,132a <printf+0x27a>
        x = -xx;
    1322:	40f007bb          	negw	a5,a5
    1326:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    132a:	4729                	li	a4,10
    132c:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    1330:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    1334:	964e                	add	a2,a2,s3
    1336:	00064603          	lbu	a2,0(a2)
    133a:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    133e:	0a0d0963          	beqz	s10,13f0 <printf+0x340>
        buf[i++] = digits[x % base];
    1342:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    1346:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    134a:	00c98733          	add	a4,s3,a2
    134e:	00074703          	lbu	a4,0(a4)
    1352:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    1356:	c3cd                	beqz	a5,13f8 <printf+0x348>
        buf[i++] = digits[x % base];
    1358:	97ce                	add	a5,a5,s3
    135a:	0007c703          	lbu	a4,0(a5)
    135e:	4d09                	li	s10,2
    1360:	478d                	li	a5,3
    1362:	00e10923          	sb	a4,18(sp)
    if (sign)
    1366:	0206cd63          	bltz	a3,13a0 <printf+0x2f0>
    while (--i >= 0)
    136a:	9d5a                	add	s10,s10,s6
    136c:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1370:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1374:	4605                	li	a2,1
    1376:	1d7d                	addi	s10,s10,-1
    1378:	85a2                	mv	a1,s0
    137a:	4505                	li	a0,1
    put[0] = c;
    137c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1380:	03d000ef          	jal	ra,1bbc <write>
    while (--i >= 0)
    1384:	ffbd16e3          	bne	s10,s11,1370 <printf+0x2c0>
    1388:	bd79                	j	1226 <printf+0x176>
    return write(stdout, put, 1);
    138a:	4605                	li	a2,1
    138c:	00001597          	auipc	a1,0x1
    1390:	9bc58593          	addi	a1,a1,-1604 # 1d48 <put.1156>
    1394:	4505                	li	a0,1
    put[0] = c;
    1396:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    139a:	023000ef          	jal	ra,1bbc <write>
    139e:	b561                	j	1226 <printf+0x176>
        buf[i++] = '-';
    13a0:	1818                	addi	a4,sp,48
    13a2:	973e                	add	a4,a4,a5
    13a4:	02d00693          	li	a3,45
    13a8:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    13ac:	8d3e                	mv	s10,a5
    13ae:	bf75                	j	136a <printf+0x2ba>
        buf[i++] = '-';
    13b0:	181c                	addi	a5,sp,48
    13b2:	97b6                	add	a5,a5,a3
    13b4:	02d00713          	li	a4,45
    13b8:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    13bc:	8d36                	mv	s10,a3
    13be:	bdd9                	j	1294 <printf+0x1e4>
        x = -xx;
    13c0:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    13c4:	00f7f693          	andi	a3,a5,15
    13c8:	96ce                	add	a3,a3,s3
    13ca:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    13ce:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    13d2:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    13d6:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    13da:	d80d1be3          	bnez	s10,1170 <printf+0xc0>
        buf[i++] = digits[x % base];
    13de:	4d05                	li	s10,1
    13e0:	b34d                	j	1182 <printf+0xd2>
                s = "(null)";
    13e2:	00001d17          	auipc	s10,0x1
    13e6:	946d0d13          	addi	s10,s10,-1722 # 1d28 <sharedmem+0x1a>
                for (; *s; s++)
    13ea:	02800793          	li	a5,40
    13ee:	bbe5                	j	11e6 <printf+0x136>
        buf[i++] = digits[x % base];
    13f0:	4785                	li	a5,1
    if (sign)
    13f2:	f606dce3          	bgez	a3,136a <printf+0x2ba>
    13f6:	b76d                	j	13a0 <printf+0x2f0>
        buf[i++] = digits[x % base];
    13f8:	4789                	li	a5,2
    13fa:	4d05                	li	s10,1
    if (sign)
    13fc:	f606d7e3          	bgez	a3,136a <printf+0x2ba>
    1400:	b745                	j	13a0 <printf+0x2f0>

0000000000001402 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1402:	02000793          	li	a5,32
    1406:	00f50663          	beq	a0,a5,1412 <isspace+0x10>
    140a:	355d                	addiw	a0,a0,-9
    140c:	00553513          	sltiu	a0,a0,5
    1410:	8082                	ret
    1412:	4505                	li	a0,1
}
    1414:	8082                	ret

0000000000001416 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1416:	fd05051b          	addiw	a0,a0,-48
}
    141a:	00a53513          	sltiu	a0,a0,10
    141e:	8082                	ret

0000000000001420 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1420:	02000613          	li	a2,32
    1424:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1426:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    142a:	ff77069b          	addiw	a3,a4,-9
    142e:	04c70d63          	beq	a4,a2,1488 <atoi+0x68>
    1432:	0007079b          	sext.w	a5,a4
    1436:	04d5f963          	bgeu	a1,a3,1488 <atoi+0x68>
        s++;
    switch (*s) {
    143a:	02b00693          	li	a3,43
    143e:	04d70a63          	beq	a4,a3,1492 <atoi+0x72>
    1442:	02d00693          	li	a3,45
    1446:	06d70463          	beq	a4,a3,14ae <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    144a:	fd07859b          	addiw	a1,a5,-48
    144e:	4625                	li	a2,9
    1450:	873e                	mv	a4,a5
    1452:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1454:	4e01                	li	t3,0
    while (isdigit(*s))
    1456:	04b66a63          	bltu	a2,a1,14aa <atoi+0x8a>
    int n = 0, neg = 0;
    145a:	4501                	li	a0,0
    while (isdigit(*s))
    145c:	4825                	li	a6,9
    145e:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1462:	0025179b          	slliw	a5,a0,0x2
    1466:	9d3d                	addw	a0,a0,a5
    1468:	fd07031b          	addiw	t1,a4,-48
    146c:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1470:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1474:	0685                	addi	a3,a3,1
    1476:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    147a:	0006071b          	sext.w	a4,a2
    147e:	feb870e3          	bgeu	a6,a1,145e <atoi+0x3e>
    return neg ? n : -n;
    1482:	000e0563          	beqz	t3,148c <atoi+0x6c>
}
    1486:	8082                	ret
        s++;
    1488:	0505                	addi	a0,a0,1
    148a:	bf71                	j	1426 <atoi+0x6>
    148c:	4113053b          	subw	a0,t1,a7
    1490:	8082                	ret
    while (isdigit(*s))
    1492:	00154783          	lbu	a5,1(a0)
    1496:	4625                	li	a2,9
        s++;
    1498:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    149c:	fd07859b          	addiw	a1,a5,-48
    14a0:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    14a4:	4e01                	li	t3,0
    while (isdigit(*s))
    14a6:	fab67ae3          	bgeu	a2,a1,145a <atoi+0x3a>
    14aa:	4501                	li	a0,0
}
    14ac:	8082                	ret
    while (isdigit(*s))
    14ae:	00154783          	lbu	a5,1(a0)
    14b2:	4625                	li	a2,9
        s++;
    14b4:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    14b8:	fd07859b          	addiw	a1,a5,-48
    14bc:	0007871b          	sext.w	a4,a5
    14c0:	feb665e3          	bltu	a2,a1,14aa <atoi+0x8a>
        neg = 1;
    14c4:	4e05                	li	t3,1
    14c6:	bf51                	j	145a <atoi+0x3a>

00000000000014c8 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    14c8:	16060d63          	beqz	a2,1642 <memset+0x17a>
    14cc:	40a007b3          	neg	a5,a0
    14d0:	8b9d                	andi	a5,a5,7
    14d2:	00778713          	addi	a4,a5,7
    14d6:	482d                	li	a6,11
    14d8:	0ff5f593          	andi	a1,a1,255
    14dc:	fff60693          	addi	a3,a2,-1
    14e0:	17076263          	bltu	a4,a6,1644 <memset+0x17c>
    14e4:	16e6ea63          	bltu	a3,a4,1658 <memset+0x190>
    14e8:	16078563          	beqz	a5,1652 <memset+0x18a>
    14ec:	00b50023          	sb	a1,0(a0)
    14f0:	4705                	li	a4,1
    14f2:	00150e93          	addi	t4,a0,1
    14f6:	14e78c63          	beq	a5,a4,164e <memset+0x186>
    14fa:	00b500a3          	sb	a1,1(a0)
    14fe:	4709                	li	a4,2
    1500:	00250e93          	addi	t4,a0,2
    1504:	14e78d63          	beq	a5,a4,165e <memset+0x196>
    1508:	00b50123          	sb	a1,2(a0)
    150c:	470d                	li	a4,3
    150e:	00350e93          	addi	t4,a0,3
    1512:	12e78b63          	beq	a5,a4,1648 <memset+0x180>
    1516:	00b501a3          	sb	a1,3(a0)
    151a:	4711                	li	a4,4
    151c:	00450e93          	addi	t4,a0,4
    1520:	14e78163          	beq	a5,a4,1662 <memset+0x19a>
    1524:	00b50223          	sb	a1,4(a0)
    1528:	4715                	li	a4,5
    152a:	00550e93          	addi	t4,a0,5
    152e:	12e78c63          	beq	a5,a4,1666 <memset+0x19e>
    1532:	00b502a3          	sb	a1,5(a0)
    1536:	471d                	li	a4,7
    1538:	00650e93          	addi	t4,a0,6
    153c:	12e79763          	bne	a5,a4,166a <memset+0x1a2>
    1540:	00750e93          	addi	t4,a0,7
    1544:	00b50323          	sb	a1,6(a0)
    1548:	4f1d                	li	t5,7
    154a:	00859713          	slli	a4,a1,0x8
    154e:	8f4d                	or	a4,a4,a1
    1550:	01059e13          	slli	t3,a1,0x10
    1554:	01c76e33          	or	t3,a4,t3
    1558:	01859313          	slli	t1,a1,0x18
    155c:	006e6333          	or	t1,t3,t1
    1560:	02059893          	slli	a7,a1,0x20
    1564:	011368b3          	or	a7,t1,a7
    1568:	02859813          	slli	a6,a1,0x28
    156c:	40f60333          	sub	t1,a2,a5
    1570:	0108e833          	or	a6,a7,a6
    1574:	03059693          	slli	a3,a1,0x30
    1578:	00d866b3          	or	a3,a6,a3
    157c:	03859713          	slli	a4,a1,0x38
    1580:	97aa                	add	a5,a5,a0
    1582:	ff837813          	andi	a6,t1,-8
    1586:	8f55                	or	a4,a4,a3
    1588:	00f806b3          	add	a3,a6,a5
    158c:	e398                	sd	a4,0(a5)
    158e:	07a1                	addi	a5,a5,8
    1590:	fed79ee3          	bne	a5,a3,158c <memset+0xc4>
    1594:	ff837693          	andi	a3,t1,-8
    1598:	00de87b3          	add	a5,t4,a3
    159c:	01e6873b          	addw	a4,a3,t5
    15a0:	0ad30663          	beq	t1,a3,164c <memset+0x184>
    15a4:	00b78023          	sb	a1,0(a5)
    15a8:	0017069b          	addiw	a3,a4,1
    15ac:	08c6fb63          	bgeu	a3,a2,1642 <memset+0x17a>
    15b0:	00b780a3          	sb	a1,1(a5)
    15b4:	0027069b          	addiw	a3,a4,2
    15b8:	08c6f563          	bgeu	a3,a2,1642 <memset+0x17a>
    15bc:	00b78123          	sb	a1,2(a5)
    15c0:	0037069b          	addiw	a3,a4,3
    15c4:	06c6ff63          	bgeu	a3,a2,1642 <memset+0x17a>
    15c8:	00b781a3          	sb	a1,3(a5)
    15cc:	0047069b          	addiw	a3,a4,4
    15d0:	06c6f963          	bgeu	a3,a2,1642 <memset+0x17a>
    15d4:	00b78223          	sb	a1,4(a5)
    15d8:	0057069b          	addiw	a3,a4,5
    15dc:	06c6f363          	bgeu	a3,a2,1642 <memset+0x17a>
    15e0:	00b782a3          	sb	a1,5(a5)
    15e4:	0067069b          	addiw	a3,a4,6
    15e8:	04c6fd63          	bgeu	a3,a2,1642 <memset+0x17a>
    15ec:	00b78323          	sb	a1,6(a5)
    15f0:	0077069b          	addiw	a3,a4,7
    15f4:	04c6f763          	bgeu	a3,a2,1642 <memset+0x17a>
    15f8:	00b783a3          	sb	a1,7(a5)
    15fc:	0087069b          	addiw	a3,a4,8
    1600:	04c6f163          	bgeu	a3,a2,1642 <memset+0x17a>
    1604:	00b78423          	sb	a1,8(a5)
    1608:	0097069b          	addiw	a3,a4,9
    160c:	02c6fb63          	bgeu	a3,a2,1642 <memset+0x17a>
    1610:	00b784a3          	sb	a1,9(a5)
    1614:	00a7069b          	addiw	a3,a4,10
    1618:	02c6f563          	bgeu	a3,a2,1642 <memset+0x17a>
    161c:	00b78523          	sb	a1,10(a5)
    1620:	00b7069b          	addiw	a3,a4,11
    1624:	00c6ff63          	bgeu	a3,a2,1642 <memset+0x17a>
    1628:	00b785a3          	sb	a1,11(a5)
    162c:	00c7069b          	addiw	a3,a4,12
    1630:	00c6f963          	bgeu	a3,a2,1642 <memset+0x17a>
    1634:	00b78623          	sb	a1,12(a5)
    1638:	2735                	addiw	a4,a4,13
    163a:	00c77463          	bgeu	a4,a2,1642 <memset+0x17a>
    163e:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    1642:	8082                	ret
    1644:	472d                	li	a4,11
    1646:	bd79                	j	14e4 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1648:	4f0d                	li	t5,3
    164a:	b701                	j	154a <memset+0x82>
    164c:	8082                	ret
    164e:	4f05                	li	t5,1
    1650:	bded                	j	154a <memset+0x82>
    1652:	8eaa                	mv	t4,a0
    1654:	4f01                	li	t5,0
    1656:	bdd5                	j	154a <memset+0x82>
    1658:	87aa                	mv	a5,a0
    165a:	4701                	li	a4,0
    165c:	b7a1                	j	15a4 <memset+0xdc>
    165e:	4f09                	li	t5,2
    1660:	b5ed                	j	154a <memset+0x82>
    1662:	4f11                	li	t5,4
    1664:	b5dd                	j	154a <memset+0x82>
    1666:	4f15                	li	t5,5
    1668:	b5cd                	j	154a <memset+0x82>
    166a:	4f19                	li	t5,6
    166c:	bdf9                	j	154a <memset+0x82>

000000000000166e <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    166e:	00054783          	lbu	a5,0(a0)
    1672:	0005c703          	lbu	a4,0(a1)
    1676:	00e79863          	bne	a5,a4,1686 <strcmp+0x18>
    167a:	0505                	addi	a0,a0,1
    167c:	0585                	addi	a1,a1,1
    167e:	fbe5                	bnez	a5,166e <strcmp>
    1680:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    1682:	9d19                	subw	a0,a0,a4
    1684:	8082                	ret
    1686:	0007851b          	sext.w	a0,a5
    168a:	bfe5                	j	1682 <strcmp+0x14>

000000000000168c <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    168c:	87aa                	mv	a5,a0
    168e:	0005c703          	lbu	a4,0(a1)
    1692:	0785                	addi	a5,a5,1
    1694:	0585                	addi	a1,a1,1
    1696:	fee78fa3          	sb	a4,-1(a5)
    169a:	fb75                	bnez	a4,168e <strcpy+0x2>
        ;
    return os;
}
    169c:	8082                	ret

000000000000169e <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    169e:	ce05                	beqz	a2,16d6 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    16a0:	00054703          	lbu	a4,0(a0)
    16a4:	0005c783          	lbu	a5,0(a1)
    16a8:	cb0d                	beqz	a4,16da <strncmp+0x3c>
    if (!n--)
    16aa:	167d                	addi	a2,a2,-1
    16ac:	00c506b3          	add	a3,a0,a2
    16b0:	a819                	j	16c6 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    16b2:	00a68e63          	beq	a3,a0,16ce <strncmp+0x30>
    16b6:	0505                	addi	a0,a0,1
    16b8:	00e79b63          	bne	a5,a4,16ce <strncmp+0x30>
    16bc:	00054703          	lbu	a4,0(a0)
    16c0:	0005c783          	lbu	a5,0(a1)
    16c4:	cb19                	beqz	a4,16da <strncmp+0x3c>
    16c6:	0005c783          	lbu	a5,0(a1)
    16ca:	0585                	addi	a1,a1,1
    16cc:	f3fd                	bnez	a5,16b2 <strncmp+0x14>
        ;
    return *l - *r;
    16ce:	0007051b          	sext.w	a0,a4
    16d2:	9d1d                	subw	a0,a0,a5
    16d4:	8082                	ret
        return 0;
    16d6:	4501                	li	a0,0
}
    16d8:	8082                	ret
    16da:	4501                	li	a0,0
    return *l - *r;
    16dc:	9d1d                	subw	a0,a0,a5
    16de:	8082                	ret

00000000000016e0 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    16e0:	00757793          	andi	a5,a0,7
    16e4:	cf89                	beqz	a5,16fe <strlen+0x1e>
    16e6:	87aa                	mv	a5,a0
    16e8:	a029                	j	16f2 <strlen+0x12>
    16ea:	0785                	addi	a5,a5,1
    16ec:	0077f713          	andi	a4,a5,7
    16f0:	cb01                	beqz	a4,1700 <strlen+0x20>
        if (!*s)
    16f2:	0007c703          	lbu	a4,0(a5)
    16f6:	fb75                	bnez	a4,16ea <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    16f8:	40a78533          	sub	a0,a5,a0
}
    16fc:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    16fe:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    1700:	6394                	ld	a3,0(a5)
    1702:	00000597          	auipc	a1,0x0
    1706:	62e5b583          	ld	a1,1582(a1) # 1d30 <sharedmem+0x22>
    170a:	00000617          	auipc	a2,0x0
    170e:	62e63603          	ld	a2,1582(a2) # 1d38 <sharedmem+0x2a>
    1712:	a019                	j	1718 <strlen+0x38>
    1714:	6794                	ld	a3,8(a5)
    1716:	07a1                	addi	a5,a5,8
    1718:	00b68733          	add	a4,a3,a1
    171c:	fff6c693          	not	a3,a3
    1720:	8f75                	and	a4,a4,a3
    1722:	8f71                	and	a4,a4,a2
    1724:	db65                	beqz	a4,1714 <strlen+0x34>
    for (; *s; s++)
    1726:	0007c703          	lbu	a4,0(a5)
    172a:	d779                	beqz	a4,16f8 <strlen+0x18>
    172c:	0017c703          	lbu	a4,1(a5)
    1730:	0785                	addi	a5,a5,1
    1732:	d379                	beqz	a4,16f8 <strlen+0x18>
    1734:	0017c703          	lbu	a4,1(a5)
    1738:	0785                	addi	a5,a5,1
    173a:	fb6d                	bnez	a4,172c <strlen+0x4c>
    173c:	bf75                	j	16f8 <strlen+0x18>

000000000000173e <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    173e:	00757713          	andi	a4,a0,7
{
    1742:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1744:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1748:	cb19                	beqz	a4,175e <memchr+0x20>
    174a:	ce25                	beqz	a2,17c2 <memchr+0x84>
    174c:	0007c703          	lbu	a4,0(a5)
    1750:	04b70e63          	beq	a4,a1,17ac <memchr+0x6e>
    1754:	0785                	addi	a5,a5,1
    1756:	0077f713          	andi	a4,a5,7
    175a:	167d                	addi	a2,a2,-1
    175c:	f77d                	bnez	a4,174a <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    175e:	4501                	li	a0,0
    if (n && *s != c) {
    1760:	c235                	beqz	a2,17c4 <memchr+0x86>
    1762:	0007c703          	lbu	a4,0(a5)
    1766:	04b70363          	beq	a4,a1,17ac <memchr+0x6e>
        size_t k = ONES * c;
    176a:	00000517          	auipc	a0,0x0
    176e:	5d653503          	ld	a0,1494(a0) # 1d40 <sharedmem+0x32>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1772:	471d                	li	a4,7
        size_t k = ONES * c;
    1774:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1778:	02c77a63          	bgeu	a4,a2,17ac <memchr+0x6e>
    177c:	00000897          	auipc	a7,0x0
    1780:	5b48b883          	ld	a7,1460(a7) # 1d30 <sharedmem+0x22>
    1784:	00000817          	auipc	a6,0x0
    1788:	5b483803          	ld	a6,1460(a6) # 1d38 <sharedmem+0x2a>
    178c:	431d                	li	t1,7
    178e:	a029                	j	1798 <memchr+0x5a>
    1790:	1661                	addi	a2,a2,-8
    1792:	07a1                	addi	a5,a5,8
    1794:	02c37963          	bgeu	t1,a2,17c6 <memchr+0x88>
    1798:	6398                	ld	a4,0(a5)
    179a:	8f29                	xor	a4,a4,a0
    179c:	011706b3          	add	a3,a4,a7
    17a0:	fff74713          	not	a4,a4
    17a4:	8f75                	and	a4,a4,a3
    17a6:	01077733          	and	a4,a4,a6
    17aa:	d37d                	beqz	a4,1790 <memchr+0x52>
    17ac:	853e                	mv	a0,a5
    17ae:	97b2                	add	a5,a5,a2
    17b0:	a021                	j	17b8 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    17b2:	0505                	addi	a0,a0,1
    17b4:	00f50763          	beq	a0,a5,17c2 <memchr+0x84>
    17b8:	00054703          	lbu	a4,0(a0)
    17bc:	feb71be3          	bne	a4,a1,17b2 <memchr+0x74>
    17c0:	8082                	ret
    return n ? (void*)s : 0;
    17c2:	4501                	li	a0,0
}
    17c4:	8082                	ret
    return n ? (void*)s : 0;
    17c6:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    17c8:	f275                	bnez	a2,17ac <memchr+0x6e>
}
    17ca:	8082                	ret

00000000000017cc <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    17cc:	1101                	addi	sp,sp,-32
    17ce:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    17d0:	862e                	mv	a2,a1
{
    17d2:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    17d4:	4581                	li	a1,0
{
    17d6:	e426                	sd	s1,8(sp)
    17d8:	ec06                	sd	ra,24(sp)
    17da:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    17dc:	f63ff0ef          	jal	ra,173e <memchr>
    return p ? p - s : n;
    17e0:	c519                	beqz	a0,17ee <strnlen+0x22>
}
    17e2:	60e2                	ld	ra,24(sp)
    17e4:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    17e6:	8d05                	sub	a0,a0,s1
}
    17e8:	64a2                	ld	s1,8(sp)
    17ea:	6105                	addi	sp,sp,32
    17ec:	8082                	ret
    17ee:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    17f0:	8522                	mv	a0,s0
}
    17f2:	6442                	ld	s0,16(sp)
    17f4:	64a2                	ld	s1,8(sp)
    17f6:	6105                	addi	sp,sp,32
    17f8:	8082                	ret

00000000000017fa <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    17fa:	00b547b3          	xor	a5,a0,a1
    17fe:	8b9d                	andi	a5,a5,7
    1800:	eb95                	bnez	a5,1834 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1802:	0075f793          	andi	a5,a1,7
    1806:	e7b1                	bnez	a5,1852 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1808:	6198                	ld	a4,0(a1)
    180a:	00000617          	auipc	a2,0x0
    180e:	52663603          	ld	a2,1318(a2) # 1d30 <sharedmem+0x22>
    1812:	00000817          	auipc	a6,0x0
    1816:	52683803          	ld	a6,1318(a6) # 1d38 <sharedmem+0x2a>
    181a:	a029                	j	1824 <stpcpy+0x2a>
    181c:	e118                	sd	a4,0(a0)
    181e:	6598                	ld	a4,8(a1)
    1820:	05a1                	addi	a1,a1,8
    1822:	0521                	addi	a0,a0,8
    1824:	00c707b3          	add	a5,a4,a2
    1828:	fff74693          	not	a3,a4
    182c:	8ff5                	and	a5,a5,a3
    182e:	0107f7b3          	and	a5,a5,a6
    1832:	d7ed                	beqz	a5,181c <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1834:	0005c783          	lbu	a5,0(a1)
    1838:	00f50023          	sb	a5,0(a0)
    183c:	c785                	beqz	a5,1864 <stpcpy+0x6a>
    183e:	0015c783          	lbu	a5,1(a1)
    1842:	0505                	addi	a0,a0,1
    1844:	0585                	addi	a1,a1,1
    1846:	00f50023          	sb	a5,0(a0)
    184a:	fbf5                	bnez	a5,183e <stpcpy+0x44>
        ;
    return d;
}
    184c:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    184e:	0505                	addi	a0,a0,1
    1850:	df45                	beqz	a4,1808 <stpcpy+0xe>
            if (!(*d = *s))
    1852:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1856:	0585                	addi	a1,a1,1
    1858:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    185c:	00f50023          	sb	a5,0(a0)
    1860:	f7fd                	bnez	a5,184e <stpcpy+0x54>
}
    1862:	8082                	ret
    1864:	8082                	ret

0000000000001866 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1866:	00b547b3          	xor	a5,a0,a1
    186a:	8b9d                	andi	a5,a5,7
    186c:	1a079863          	bnez	a5,1a1c <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1870:	0075f793          	andi	a5,a1,7
    1874:	16078463          	beqz	a5,19dc <stpncpy+0x176>
    1878:	ea01                	bnez	a2,1888 <stpncpy+0x22>
    187a:	a421                	j	1a82 <stpncpy+0x21c>
    187c:	167d                	addi	a2,a2,-1
    187e:	0505                	addi	a0,a0,1
    1880:	14070e63          	beqz	a4,19dc <stpncpy+0x176>
    1884:	1a060863          	beqz	a2,1a34 <stpncpy+0x1ce>
    1888:	0005c783          	lbu	a5,0(a1)
    188c:	0585                	addi	a1,a1,1
    188e:	0075f713          	andi	a4,a1,7
    1892:	00f50023          	sb	a5,0(a0)
    1896:	f3fd                	bnez	a5,187c <stpncpy+0x16>
    1898:	4805                	li	a6,1
    189a:	1a061863          	bnez	a2,1a4a <stpncpy+0x1e4>
    189e:	40a007b3          	neg	a5,a0
    18a2:	8b9d                	andi	a5,a5,7
    18a4:	4681                	li	a3,0
    18a6:	18061a63          	bnez	a2,1a3a <stpncpy+0x1d4>
    18aa:	00778713          	addi	a4,a5,7
    18ae:	45ad                	li	a1,11
    18b0:	18b76363          	bltu	a4,a1,1a36 <stpncpy+0x1d0>
    18b4:	1ae6eb63          	bltu	a3,a4,1a6a <stpncpy+0x204>
    18b8:	1a078363          	beqz	a5,1a5e <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    18bc:	00050023          	sb	zero,0(a0)
    18c0:	4685                	li	a3,1
    18c2:	00150713          	addi	a4,a0,1
    18c6:	18d78f63          	beq	a5,a3,1a64 <stpncpy+0x1fe>
    18ca:	000500a3          	sb	zero,1(a0)
    18ce:	4689                	li	a3,2
    18d0:	00250713          	addi	a4,a0,2
    18d4:	18d78e63          	beq	a5,a3,1a70 <stpncpy+0x20a>
    18d8:	00050123          	sb	zero,2(a0)
    18dc:	468d                	li	a3,3
    18de:	00350713          	addi	a4,a0,3
    18e2:	16d78c63          	beq	a5,a3,1a5a <stpncpy+0x1f4>
    18e6:	000501a3          	sb	zero,3(a0)
    18ea:	4691                	li	a3,4
    18ec:	00450713          	addi	a4,a0,4
    18f0:	18d78263          	beq	a5,a3,1a74 <stpncpy+0x20e>
    18f4:	00050223          	sb	zero,4(a0)
    18f8:	4695                	li	a3,5
    18fa:	00550713          	addi	a4,a0,5
    18fe:	16d78d63          	beq	a5,a3,1a78 <stpncpy+0x212>
    1902:	000502a3          	sb	zero,5(a0)
    1906:	469d                	li	a3,7
    1908:	00650713          	addi	a4,a0,6
    190c:	16d79863          	bne	a5,a3,1a7c <stpncpy+0x216>
    1910:	00750713          	addi	a4,a0,7
    1914:	00050323          	sb	zero,6(a0)
    1918:	40f80833          	sub	a6,a6,a5
    191c:	ff887593          	andi	a1,a6,-8
    1920:	97aa                	add	a5,a5,a0
    1922:	95be                	add	a1,a1,a5
    1924:	0007b023          	sd	zero,0(a5)
    1928:	07a1                	addi	a5,a5,8
    192a:	feb79de3          	bne	a5,a1,1924 <stpncpy+0xbe>
    192e:	ff887593          	andi	a1,a6,-8
    1932:	9ead                	addw	a3,a3,a1
    1934:	00b707b3          	add	a5,a4,a1
    1938:	12b80863          	beq	a6,a1,1a68 <stpncpy+0x202>
    193c:	00078023          	sb	zero,0(a5)
    1940:	0016871b          	addiw	a4,a3,1
    1944:	0ec77863          	bgeu	a4,a2,1a34 <stpncpy+0x1ce>
    1948:	000780a3          	sb	zero,1(a5)
    194c:	0026871b          	addiw	a4,a3,2
    1950:	0ec77263          	bgeu	a4,a2,1a34 <stpncpy+0x1ce>
    1954:	00078123          	sb	zero,2(a5)
    1958:	0036871b          	addiw	a4,a3,3
    195c:	0cc77c63          	bgeu	a4,a2,1a34 <stpncpy+0x1ce>
    1960:	000781a3          	sb	zero,3(a5)
    1964:	0046871b          	addiw	a4,a3,4
    1968:	0cc77663          	bgeu	a4,a2,1a34 <stpncpy+0x1ce>
    196c:	00078223          	sb	zero,4(a5)
    1970:	0056871b          	addiw	a4,a3,5
    1974:	0cc77063          	bgeu	a4,a2,1a34 <stpncpy+0x1ce>
    1978:	000782a3          	sb	zero,5(a5)
    197c:	0066871b          	addiw	a4,a3,6
    1980:	0ac77a63          	bgeu	a4,a2,1a34 <stpncpy+0x1ce>
    1984:	00078323          	sb	zero,6(a5)
    1988:	0076871b          	addiw	a4,a3,7
    198c:	0ac77463          	bgeu	a4,a2,1a34 <stpncpy+0x1ce>
    1990:	000783a3          	sb	zero,7(a5)
    1994:	0086871b          	addiw	a4,a3,8
    1998:	08c77e63          	bgeu	a4,a2,1a34 <stpncpy+0x1ce>
    199c:	00078423          	sb	zero,8(a5)
    19a0:	0096871b          	addiw	a4,a3,9
    19a4:	08c77863          	bgeu	a4,a2,1a34 <stpncpy+0x1ce>
    19a8:	000784a3          	sb	zero,9(a5)
    19ac:	00a6871b          	addiw	a4,a3,10
    19b0:	08c77263          	bgeu	a4,a2,1a34 <stpncpy+0x1ce>
    19b4:	00078523          	sb	zero,10(a5)
    19b8:	00b6871b          	addiw	a4,a3,11
    19bc:	06c77c63          	bgeu	a4,a2,1a34 <stpncpy+0x1ce>
    19c0:	000785a3          	sb	zero,11(a5)
    19c4:	00c6871b          	addiw	a4,a3,12
    19c8:	06c77663          	bgeu	a4,a2,1a34 <stpncpy+0x1ce>
    19cc:	00078623          	sb	zero,12(a5)
    19d0:	26b5                	addiw	a3,a3,13
    19d2:	06c6f163          	bgeu	a3,a2,1a34 <stpncpy+0x1ce>
    19d6:	000786a3          	sb	zero,13(a5)
    19da:	8082                	ret
            ;
        if (!n || !*s)
    19dc:	c645                	beqz	a2,1a84 <stpncpy+0x21e>
    19de:	0005c783          	lbu	a5,0(a1)
    19e2:	ea078be3          	beqz	a5,1898 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    19e6:	479d                	li	a5,7
    19e8:	02c7ff63          	bgeu	a5,a2,1a26 <stpncpy+0x1c0>
    19ec:	00000897          	auipc	a7,0x0
    19f0:	3448b883          	ld	a7,836(a7) # 1d30 <sharedmem+0x22>
    19f4:	00000817          	auipc	a6,0x0
    19f8:	34483803          	ld	a6,836(a6) # 1d38 <sharedmem+0x2a>
    19fc:	431d                	li	t1,7
    19fe:	6198                	ld	a4,0(a1)
    1a00:	011707b3          	add	a5,a4,a7
    1a04:	fff74693          	not	a3,a4
    1a08:	8ff5                	and	a5,a5,a3
    1a0a:	0107f7b3          	and	a5,a5,a6
    1a0e:	ef81                	bnez	a5,1a26 <stpncpy+0x1c0>
            *wd = *ws;
    1a10:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1a12:	1661                	addi	a2,a2,-8
    1a14:	05a1                	addi	a1,a1,8
    1a16:	0521                	addi	a0,a0,8
    1a18:	fec363e3          	bltu	t1,a2,19fe <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1a1c:	e609                	bnez	a2,1a26 <stpncpy+0x1c0>
    1a1e:	a08d                	j	1a80 <stpncpy+0x21a>
    1a20:	167d                	addi	a2,a2,-1
    1a22:	0505                	addi	a0,a0,1
    1a24:	ca01                	beqz	a2,1a34 <stpncpy+0x1ce>
    1a26:	0005c783          	lbu	a5,0(a1)
    1a2a:	0585                	addi	a1,a1,1
    1a2c:	00f50023          	sb	a5,0(a0)
    1a30:	fbe5                	bnez	a5,1a20 <stpncpy+0x1ba>
        ;
tail:
    1a32:	b59d                	j	1898 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1a34:	8082                	ret
    1a36:	472d                	li	a4,11
    1a38:	bdb5                	j	18b4 <stpncpy+0x4e>
    1a3a:	00778713          	addi	a4,a5,7
    1a3e:	45ad                	li	a1,11
    1a40:	fff60693          	addi	a3,a2,-1
    1a44:	e6b778e3          	bgeu	a4,a1,18b4 <stpncpy+0x4e>
    1a48:	b7fd                	j	1a36 <stpncpy+0x1d0>
    1a4a:	40a007b3          	neg	a5,a0
    1a4e:	8832                	mv	a6,a2
    1a50:	8b9d                	andi	a5,a5,7
    1a52:	4681                	li	a3,0
    1a54:	e4060be3          	beqz	a2,18aa <stpncpy+0x44>
    1a58:	b7cd                	j	1a3a <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1a5a:	468d                	li	a3,3
    1a5c:	bd75                	j	1918 <stpncpy+0xb2>
    1a5e:	872a                	mv	a4,a0
    1a60:	4681                	li	a3,0
    1a62:	bd5d                	j	1918 <stpncpy+0xb2>
    1a64:	4685                	li	a3,1
    1a66:	bd4d                	j	1918 <stpncpy+0xb2>
    1a68:	8082                	ret
    1a6a:	87aa                	mv	a5,a0
    1a6c:	4681                	li	a3,0
    1a6e:	b5f9                	j	193c <stpncpy+0xd6>
    1a70:	4689                	li	a3,2
    1a72:	b55d                	j	1918 <stpncpy+0xb2>
    1a74:	4691                	li	a3,4
    1a76:	b54d                	j	1918 <stpncpy+0xb2>
    1a78:	4695                	li	a3,5
    1a7a:	bd79                	j	1918 <stpncpy+0xb2>
    1a7c:	4699                	li	a3,6
    1a7e:	bd69                	j	1918 <stpncpy+0xb2>
    1a80:	8082                	ret
    1a82:	8082                	ret
    1a84:	8082                	ret

0000000000001a86 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1a86:	fff6071b          	addiw	a4,a2,-1
    1a8a:	0cb57063          	bgeu	a0,a1,1b4a <memmove+0xc4>
        while (n-- > 0)
    1a8e:	0ec05063          	blez	a2,1b6e <memmove+0xe8>
    1a92:	00750693          	addi	a3,a0,7
    1a96:	8e8d                	sub	a3,a3,a1
    1a98:	00b567b3          	or	a5,a0,a1
    1a9c:	00f6b693          	sltiu	a3,a3,15
    1aa0:	8b9d                	andi	a5,a5,7
    1aa2:	0016c693          	xori	a3,a3,1
    1aa6:	0017b793          	seqz	a5,a5
    1aaa:	8ff5                	and	a5,a5,a3
    1aac:	c3f1                	beqz	a5,1b70 <memmove+0xea>
    1aae:	0007079b          	sext.w	a5,a4
    1ab2:	46a5                	li	a3,9
    1ab4:	0af6fe63          	bgeu	a3,a5,1b70 <memmove+0xea>
    1ab8:	0036589b          	srliw	a7,a2,0x3
    1abc:	088e                	slli	a7,a7,0x3
    1abe:	2601                	sext.w	a2,a2
    1ac0:	87ae                	mv	a5,a1
    1ac2:	86aa                	mv	a3,a0
    1ac4:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1ac6:	0007b803          	ld	a6,0(a5)
    1aca:	07a1                	addi	a5,a5,8
    1acc:	06a1                	addi	a3,a3,8
    1ace:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1ad2:	ff179ae3          	bne	a5,a7,1ac6 <memmove+0x40>
    1ad6:	ff867813          	andi	a6,a2,-8
    1ada:	02081793          	slli	a5,a6,0x20
    1ade:	9381                	srli	a5,a5,0x20
    1ae0:	00f506b3          	add	a3,a0,a5
    1ae4:	95be                	add	a1,a1,a5
    1ae6:	4107073b          	subw	a4,a4,a6
    1aea:	09060263          	beq	a2,a6,1b6e <memmove+0xe8>
            *dst++ = *src++;
    1aee:	0005c783          	lbu	a5,0(a1)
    1af2:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1af6:	06e05c63          	blez	a4,1b6e <memmove+0xe8>
            *dst++ = *src++;
    1afa:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1afe:	4785                	li	a5,1
            *dst++ = *src++;
    1b00:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1b04:	06e7d563          	bge	a5,a4,1b6e <memmove+0xe8>
            *dst++ = *src++;
    1b08:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1b0c:	4789                	li	a5,2
            *dst++ = *src++;
    1b0e:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1b12:	04e7de63          	bge	a5,a4,1b6e <memmove+0xe8>
            *dst++ = *src++;
    1b16:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1b1a:	478d                	li	a5,3
            *dst++ = *src++;
    1b1c:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1b20:	04e7d763          	bge	a5,a4,1b6e <memmove+0xe8>
            *dst++ = *src++;
    1b24:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1b28:	4791                	li	a5,4
            *dst++ = *src++;
    1b2a:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1b2e:	04e7d063          	bge	a5,a4,1b6e <memmove+0xe8>
            *dst++ = *src++;
    1b32:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1b36:	4795                	li	a5,5
            *dst++ = *src++;
    1b38:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1b3c:	02e7d963          	bge	a5,a4,1b6e <memmove+0xe8>
            *dst++ = *src++;
    1b40:	0065c783          	lbu	a5,6(a1)
    1b44:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1b48:	8082                	ret
    } else {
        dst += n;
    1b4a:	00c507b3          	add	a5,a0,a2
        src += n;
    1b4e:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1b50:	00c05f63          	blez	a2,1b6e <memmove+0xe8>
    1b54:	1702                	slli	a4,a4,0x20
    1b56:	9301                	srli	a4,a4,0x20
    1b58:	fff74713          	not	a4,a4
    1b5c:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1b5e:	fff5c683          	lbu	a3,-1(a1)
    1b62:	17fd                	addi	a5,a5,-1
    1b64:	15fd                	addi	a1,a1,-1
    1b66:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1b6a:	fee79ae3          	bne	a5,a4,1b5e <memmove+0xd8>
    }
    return vdst;
}
    1b6e:	8082                	ret
    1b70:	02071693          	slli	a3,a4,0x20
    1b74:	9281                	srli	a3,a3,0x20
    1b76:	0685                	addi	a3,a3,1
    1b78:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1b7a:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1b7c:	0005c703          	lbu	a4,0(a1)
    1b80:	0585                	addi	a1,a1,1
    1b82:	0785                	addi	a5,a5,1
    1b84:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1b88:	fed59ae3          	bne	a1,a3,1b7c <memmove+0xf6>
    1b8c:	8082                	ret

0000000000001b8e <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1b8e:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1b92:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1b96:	2501                	sext.w	a0,a0
    1b98:	8082                	ret

0000000000001b9a <exec>:
    register long a7 __asm__("a7") = n;
    1b9a:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1b9e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ba0:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1ba4:	2501                	sext.w	a0,a0
    1ba6:	8082                	ret

0000000000001ba8 <exit>:
    register long a7 __asm__("a7") = n;
    1ba8:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1bac:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1bb0:	8082                	ret

0000000000001bb2 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1bb2:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1bb6:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1bba:	8082                	ret

0000000000001bbc <write>:
    register long a7 __asm__("a7") = n;
    1bbc:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1bc0:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1bc4:	8082                	ret

0000000000001bc6 <getpid>:
    register long a7 __asm__("a7") = n;
    1bc6:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1bca:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1bce:	2501                	sext.w	a0,a0
    1bd0:	8082                	ret

0000000000001bd2 <getppid>:
    register long a7 __asm__("a7") = n;
    1bd2:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1bd6:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1bda:	2501                	sext.w	a0,a0
    1bdc:	8082                	ret

0000000000001bde <open>:
    register long a7 __asm__("a7") = n;
    1bde:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1be2:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1be6:	2501                	sext.w	a0,a0
    1be8:	8082                	ret

0000000000001bea <mknod>:
    register long a7 __asm__("a7") = n;
    1bea:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1bee:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1bf2:	2501                	sext.w	a0,a0
    1bf4:	8082                	ret

0000000000001bf6 <dup>:
    register long a7 __asm__("a7") = n;
    1bf6:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1bf8:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1bfc:	2501                	sext.w	a0,a0
    1bfe:	8082                	ret

0000000000001c00 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c00:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c04:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c08:	2501                	sext.w	a0,a0
    1c0a:	8082                	ret

0000000000001c0c <waitpid>:
    register long a7 __asm__("a7") = n;
    1c0c:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c10:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1c14:	2501                	sext.w	a0,a0
    1c16:	8082                	ret

0000000000001c18 <wait>:

pid_t wait(int *wstatus)
{
    1c18:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1c1a:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1c1e:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c20:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1c24:	2501                	sext.w	a0,a0
    1c26:	8082                	ret

0000000000001c28 <mkdir>:
    register long a7 __asm__("a7") = n;
    1c28:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1c2c:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1c30:	2501                	sext.w	a0,a0
    1c32:	8082                	ret

0000000000001c34 <close>:
    register long a7 __asm__("a7") = n;
    1c34:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c38:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c3c:	2501                	sext.w	a0,a0
    1c3e:	8082                	ret

0000000000001c40 <fork>:
    register long a7 __asm__("a7") = n;
    1c40:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1c44:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1c48:	2501                	sext.w	a0,a0
    1c4a:	8082                	ret

0000000000001c4c <time_ms>:
    register long a7 __asm__("a7") = n;
    1c4c:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c50:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1c54:	8082                	ret

0000000000001c56 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1c56:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1c58:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c5c:	00000073          	ecall
    1c60:	87aa                	mv	a5,a0
    1c62:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1c66:	97ba                	add	a5,a5,a4
    1c68:	00f57c63          	bgeu	a0,a5,1c80 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1c6c:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c70:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1c74:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c78:	00000073          	ecall
    1c7c:	fef568e3          	bltu	a0,a5,1c6c <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1c80:	4501                	li	a0,0
    1c82:	8082                	ret

0000000000001c84 <pipe>:
    register long a7 __asm__("a7") = n;
    1c84:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1c88:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1c8c:	2501                	sext.w	a0,a0
    1c8e:	8082                	ret

0000000000001c90 <fstat>:
    register long a7 __asm__("a7") = n;
    1c90:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c94:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1c98:	2501                	sext.w	a0,a0
    1c9a:	8082                	ret

0000000000001c9c <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1c9c:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1c9e:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1ca2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ca4:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1ca8:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1cac:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1cb0:	0206c163          	bltz	a3,1cd2 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1cb4:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1cb8:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1cba:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cbc:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1cc0:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1cc4:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1cc8:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1cca:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1cce:	853e                	mv	a0,a5
    1cd0:	8082                	ret
        return -1;
    1cd2:	57fd                	li	a5,-1
    1cd4:	bfed                	j	1cce <stat+0x32>

0000000000001cd6 <chdir>:
    register long a7 __asm__("a7") = n;
    1cd6:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1cda:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1cde:	2501                	sext.w	a0,a0
    1ce0:	8082                	ret

0000000000001ce2 <link>:
    register long a7 __asm__("a7") = n;
    1ce2:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ce6:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1cea:	2501                	sext.w	a0,a0
    1cec:	8082                	ret

0000000000001cee <unlink>:
    register long a7 __asm__("a7") = n;
    1cee:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1cf2:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1cf6:	2501                	sext.w	a0,a0
    1cf8:	8082                	ret

0000000000001cfa <setpriority>:
    register long a7 __asm__("a7") = n;
    1cfa:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1cfe:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1d02:	8082                	ret

0000000000001d04 <getpriority>:
    register long a7 __asm__("a7") = n;
    1d04:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1d08:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1d0c:	8082                	ret

0000000000001d0e <sharedmem>:
    register long a7 __asm__("a7") = n;
    1d0e:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d12:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1d16:	8082                	ret
