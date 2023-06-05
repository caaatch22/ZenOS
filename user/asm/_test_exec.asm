
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_exec:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a01d                	j	1026 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <stdio.h>
#include <stdlib.h>
#include <ucore.h>

int main() {
    1002:	1141                	addi	sp,sp,-16
    puts("execute hello");
    1004:	00001517          	auipc	a0,0x1
    1008:	d2450513          	addi	a0,a0,-732 # 1d28 <sharedmem+0xe>
int main() {
    100c:	e406                	sd	ra,8(sp)
    puts("execute hello");
    100e:	068000ef          	jal	ra,1076 <puts>
    exec("hello");
    1012:	00001517          	auipc	a0,0x1
    1016:	d1e50513          	addi	a0,a0,-738 # 1d30 <sharedmem+0x16>
    101a:	38d000ef          	jal	ra,1ba6 <exec>
    return 0;
    101e:	60a2                	ld	ra,8(sp)
    1020:	4501                	li	a0,0
    1022:	0141                	addi	sp,sp,16
    1024:	8082                	ret

0000000000001026 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1026:	1141                	addi	sp,sp,-16
    1028:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    102a:	fd9ff0ef          	jal	ra,1002 <main>
}
    102e:	60a2                	ld	ra,8(sp)
    1030:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    1032:	3830006f          	j	1bb4 <exit>

0000000000001036 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    1036:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    1038:	00f10593          	addi	a1,sp,15
    103c:	4605                	li	a2,1
    103e:	4501                	li	a0,0
int getchar() {
    1040:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1042:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1046:	379000ef          	jal	ra,1bbe <read>
    return byte;
}
    104a:	60e2                	ld	ra,24(sp)
    104c:	00f14503          	lbu	a0,15(sp)
    1050:	6105                	addi	sp,sp,32
    1052:	8082                	ret

0000000000001054 <putchar>:

int putchar(int c)
{
    1054:	1141                	addi	sp,sp,-16
    1056:	e406                	sd	ra,8(sp)
    1058:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    105a:	00001597          	auipc	a1,0x1
    105e:	cfe58593          	addi	a1,a1,-770 # 1d58 <put.1156>
    return write(stdout, put, 1);
    1062:	4605                	li	a2,1
    1064:	4505                	li	a0,1
    put[0] = c;
    1066:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    106a:	35f000ef          	jal	ra,1bc8 <write>
}
    106e:	60a2                	ld	ra,8(sp)
    1070:	2501                	sext.w	a0,a0
    1072:	0141                	addi	sp,sp,16
    1074:	8082                	ret

0000000000001076 <puts>:

int puts(const char* s)
{
    1076:	1141                	addi	sp,sp,-16
    1078:	e022                	sd	s0,0(sp)
    107a:	e406                	sd	ra,8(sp)
    107c:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    107e:	66e000ef          	jal	ra,16ec <strlen>
    1082:	862a                	mv	a2,a0
    1084:	85a2                	mv	a1,s0
    1086:	4505                	li	a0,1
    1088:	341000ef          	jal	ra,1bc8 <write>
    108c:	00055763          	bgez	a0,109a <puts+0x24>
    return r;
}
    1090:	60a2                	ld	ra,8(sp)
    1092:	6402                	ld	s0,0(sp)
    1094:	557d                	li	a0,-1
    1096:	0141                	addi	sp,sp,16
    1098:	8082                	ret
    put[0] = c;
    109a:	00001597          	auipc	a1,0x1
    109e:	cbe58593          	addi	a1,a1,-834 # 1d58 <put.1156>
    10a2:	47a9                	li	a5,10
    return write(stdout, put, 1);
    10a4:	4605                	li	a2,1
    10a6:	4505                	li	a0,1
    put[0] = c;
    10a8:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    10ac:	31d000ef          	jal	ra,1bc8 <write>
}
    10b0:	60a2                	ld	ra,8(sp)
    10b2:	6402                	ld	s0,0(sp)
    10b4:	41f5551b          	sraiw	a0,a0,0x1f
    10b8:	0141                	addi	sp,sp,16
    10ba:	8082                	ret

00000000000010bc <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    10bc:	7115                	addi	sp,sp,-224
    10be:	ed06                	sd	ra,152(sp)
    10c0:	e922                	sd	s0,144(sp)
    10c2:	e526                	sd	s1,136(sp)
    10c4:	e14a                	sd	s2,128(sp)
    10c6:	fcce                	sd	s3,120(sp)
    10c8:	f8d2                	sd	s4,112(sp)
    10ca:	f4d6                	sd	s5,104(sp)
    10cc:	f0da                	sd	s6,96(sp)
    10ce:	ecde                	sd	s7,88(sp)
    10d0:	e8e2                	sd	s8,80(sp)
    10d2:	e4e6                	sd	s9,72(sp)
    10d4:	e0ea                	sd	s10,64(sp)
    10d6:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    10d8:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    10dc:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    10de:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    10e0:	f52e                	sd	a1,168(sp)
    10e2:	f932                	sd	a2,176(sp)
    10e4:	fd36                	sd	a3,184(sp)
    10e6:	e1ba                	sd	a4,192(sp)
    10e8:	e9c2                	sd	a6,208(sp)
    10ea:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    10ec:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    10ee:	0c030b63          	beqz	t1,11c4 <printf+0x108>
    10f2:	8aaa                	mv	s5,a0
    10f4:	0003071b          	sext.w	a4,t1
    10f8:	4481                	li	s1,0
        if (c != '%') {
    10fa:	02500b93          	li	s7,37
    put[0] = c;
    10fe:	00001417          	auipc	s0,0x1
    1102:	c5a40413          	addi	s0,s0,-934 # 1d58 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    1106:	4c51                	li	s8,20
    put[0] = c;
    1108:	02500c93          	li	s9,37
    110c:	00001a17          	auipc	s4,0x1
    1110:	c54a0a13          	addi	s4,s4,-940 # 1d60 <put.1156+0x8>
    1114:	00001997          	auipc	s3,0x1
    1118:	ca498993          	addi	s3,s3,-860 # 1db8 <digits>
    111c:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    1120:	0014879b          	addiw	a5,s1,1
    1124:	00fa8933          	add	s2,s5,a5
    1128:	13771163          	bne	a4,s7,124a <printf+0x18e>
        c = fmt[++i] & 0xff;
    112c:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    1130:	080d0a63          	beqz	s10,11c4 <printf+0x108>
        switch (c) {
    1134:	2489                	addiw	s1,s1,2
    1136:	009a8933          	add	s2,s5,s1
    113a:	257d0e63          	beq	s10,s7,1396 <printf+0x2da>
    113e:	f9cd079b          	addiw	a5,s10,-100
    1142:	0ff7f793          	andi	a5,a5,255
    1146:	0cfc6263          	bltu	s8,a5,120a <printf+0x14e>
    114a:	078a                	slli	a5,a5,0x2
    114c:	97d2                	add	a5,a5,s4
    114e:	439c                	lw	a5,0(a5)
    1150:	97d2                	add	a5,a5,s4
    1152:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    1154:	67a2                	ld	a5,8(sp)
    1156:	4398                	lw	a4,0(a5)
    1158:	07a1                	addi	a5,a5,8
    115a:	e43e                	sd	a5,8(sp)
    115c:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    1160:	26074663          	bltz	a4,13cc <printf+0x310>
        buf[i++] = digits[x % base];
    1164:	8bbd                	andi	a5,a5,15
    1166:	97ce                	add	a5,a5,s3
    1168:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    116c:	40475d1b          	sraiw	s10,a4,0x4
    1170:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    1174:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    1178:	020d0163          	beqz	s10,119a <printf+0xde>
        buf[i++] = digits[x % base];
    117c:	9d4e                	add	s10,s10,s3
    117e:	000d4783          	lbu	a5,0(s10)
    1182:	4d05                	li	s10,1
    1184:	00f108a3          	sb	a5,17(sp)
    if (sign)
    1188:	00075963          	bgez	a4,119a <printf+0xde>
        buf[i++] = digits[x % base];
    118c:	4d09                	li	s10,2
        buf[i++] = '-';
    118e:	181c                	addi	a5,sp,48
    1190:	02d00713          	li	a4,45
    1194:	97ea                	add	a5,a5,s10
    1196:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    119a:	9d5a                	add	s10,s10,s6
    119c:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    11a0:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    11a4:	4605                	li	a2,1
    11a6:	1d7d                	addi	s10,s10,-1
    11a8:	85a2                	mv	a1,s0
    11aa:	4505                	li	a0,1
    put[0] = c;
    11ac:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    11b0:	219000ef          	jal	ra,1bc8 <write>
    while (--i >= 0)
    11b4:	ffbd16e3          	bne	s10,s11,11a0 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    11b8:	00094303          	lbu	t1,0(s2)
    11bc:	0003071b          	sext.w	a4,t1
    11c0:	f60310e3          	bnez	t1,1120 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    11c4:	60ea                	ld	ra,152(sp)
    11c6:	644a                	ld	s0,144(sp)
    11c8:	64aa                	ld	s1,136(sp)
    11ca:	690a                	ld	s2,128(sp)
    11cc:	79e6                	ld	s3,120(sp)
    11ce:	7a46                	ld	s4,112(sp)
    11d0:	7aa6                	ld	s5,104(sp)
    11d2:	7b06                	ld	s6,96(sp)
    11d4:	6be6                	ld	s7,88(sp)
    11d6:	6c46                	ld	s8,80(sp)
    11d8:	6ca6                	ld	s9,72(sp)
    11da:	6d06                	ld	s10,64(sp)
    11dc:	7de2                	ld	s11,56(sp)
    11de:	612d                	addi	sp,sp,224
    11e0:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    11e2:	67a2                	ld	a5,8(sp)
    11e4:	0007bd03          	ld	s10,0(a5)
    11e8:	07a1                	addi	a5,a5,8
    11ea:	e43e                	sd	a5,8(sp)
    11ec:	000d1b63          	bnez	s10,1202 <printf+0x146>
    11f0:	aafd                	j	13ee <printf+0x332>
    return write(stdout, put, 1);
    11f2:	4605                	li	a2,1
    11f4:	85a2                	mv	a1,s0
    11f6:	4505                	li	a0,1
                for (; *s; s++)
    11f8:	0d05                	addi	s10,s10,1
    put[0] = c;
    11fa:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    11fe:	1cb000ef          	jal	ra,1bc8 <write>
                for (; *s; s++)
    1202:	000d4783          	lbu	a5,0(s10)
    1206:	f7f5                	bnez	a5,11f2 <printf+0x136>
    1208:	a02d                	j	1232 <printf+0x176>
    return write(stdout, put, 1);
    120a:	4605                	li	a2,1
    120c:	00001597          	auipc	a1,0x1
    1210:	b4c58593          	addi	a1,a1,-1204 # 1d58 <put.1156>
    1214:	4505                	li	a0,1
    put[0] = c;
    1216:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    121a:	1af000ef          	jal	ra,1bc8 <write>
    121e:	4605                	li	a2,1
    1220:	00001597          	auipc	a1,0x1
    1224:	b3858593          	addi	a1,a1,-1224 # 1d58 <put.1156>
    1228:	4505                	li	a0,1
    put[0] = c;
    122a:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    122e:	19b000ef          	jal	ra,1bc8 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1232:	00094303          	lbu	t1,0(s2)
    1236:	0003071b          	sext.w	a4,t1
    123a:	f80305e3          	beqz	t1,11c4 <printf+0x108>
        if (c != '%') {
    123e:	0014879b          	addiw	a5,s1,1
    1242:	00fa8933          	add	s2,s5,a5
    1246:	ef7703e3          	beq	a4,s7,112c <printf+0x70>
    return write(stdout, put, 1);
    124a:	4605                	li	a2,1
    124c:	00001597          	auipc	a1,0x1
    1250:	b0c58593          	addi	a1,a1,-1268 # 1d58 <put.1156>
    1254:	4505                	li	a0,1
    put[0] = c;
    1256:	00640023          	sb	t1,0(s0)
            continue;
    125a:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    125c:	16d000ef          	jal	ra,1bc8 <write>
            continue;
    1260:	bfc9                	j	1232 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    1262:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    1264:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    1266:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    1268:	0007b883          	ld	a7,0(a5)
    126c:	07a1                	addi	a5,a5,8
    126e:	e43e                	sd	a5,8(sp)
        x = -xx;
    1270:	43f8d713          	srai	a4,a7,0x3f
    1274:	011747b3          	xor	a5,a4,a7
    1278:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    127a:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    127c:	02c7f733          	remu	a4,a5,a2
    1280:	8d36                	mv	s10,a3
    1282:	0685                	addi	a3,a3,1
    1284:	00db0533          	add	a0,s6,a3
    1288:	85be                	mv	a1,a5
    128a:	974e                	add	a4,a4,s3
    128c:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    1290:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    1294:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    1298:	feb862e3          	bltu	a6,a1,127c <printf+0x1c0>
    if (sign)
    129c:	1208c063          	bltz	a7,13bc <printf+0x300>
    while (--i >= 0)
    12a0:	9d5a                	add	s10,s10,s6
    put[0] = c;
    12a2:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    12a6:	4605                	li	a2,1
    12a8:	85a2                	mv	a1,s0
    12aa:	4505                	li	a0,1
    put[0] = c;
    12ac:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    12b0:	119000ef          	jal	ra,1bc8 <write>
    while (--i >= 0)
    12b4:	87ea                	mv	a5,s10
    12b6:	1d7d                	addi	s10,s10,-1
    12b8:	fefb15e3          	bne	s6,a5,12a2 <printf+0x1e6>
    12bc:	bf9d                	j	1232 <printf+0x176>
                printptr(va_arg(ap, uint64));
    12be:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    12c0:	4605                	li	a2,1
    12c2:	00001597          	auipc	a1,0x1
    12c6:	a9658593          	addi	a1,a1,-1386 # 1d58 <put.1156>
                printptr(va_arg(ap, uint64));
    12ca:	0007bd83          	ld	s11,0(a5)
    12ce:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    12d2:	4505                	li	a0,1
    put[0] = c;
    12d4:	03000793          	li	a5,48
    12d8:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    12dc:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    12de:	0eb000ef          	jal	ra,1bc8 <write>
    put[0] = c;
    12e2:	07800793          	li	a5,120
    return write(stdout, put, 1);
    12e6:	4605                	li	a2,1
    12e8:	00001597          	auipc	a1,0x1
    12ec:	a7058593          	addi	a1,a1,-1424 # 1d58 <put.1156>
    12f0:	4505                	li	a0,1
    put[0] = c;
    12f2:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    12f6:	4d41                	li	s10,16
    12f8:	0d1000ef          	jal	ra,1bc8 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    12fc:	03cdd793          	srli	a5,s11,0x3c
    1300:	97ce                	add	a5,a5,s3
    put[0] = c;
    1302:	0007c783          	lbu	a5,0(a5)
    1306:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    1308:	4605                	li	a2,1
    130a:	85a2                	mv	a1,s0
    130c:	4505                	li	a0,1
    put[0] = c;
    130e:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1312:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1314:	0b5000ef          	jal	ra,1bc8 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1318:	fe0d12e3          	bnez	s10,12fc <printf+0x240>
    131c:	bf19                	j	1232 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    131e:	67a2                	ld	a5,8(sp)
    1320:	4394                	lw	a3,0(a5)
    1322:	07a1                	addi	a5,a5,8
    1324:	e43e                	sd	a5,8(sp)
    1326:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    132a:	0006d663          	bgez	a3,1336 <printf+0x27a>
        x = -xx;
    132e:	40f007bb          	negw	a5,a5
    1332:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    1336:	4729                	li	a4,10
    1338:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    133c:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    1340:	964e                	add	a2,a2,s3
    1342:	00064603          	lbu	a2,0(a2)
    1346:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    134a:	0a0d0963          	beqz	s10,13fc <printf+0x340>
        buf[i++] = digits[x % base];
    134e:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    1352:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    1356:	00c98733          	add	a4,s3,a2
    135a:	00074703          	lbu	a4,0(a4)
    135e:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    1362:	c3cd                	beqz	a5,1404 <printf+0x348>
        buf[i++] = digits[x % base];
    1364:	97ce                	add	a5,a5,s3
    1366:	0007c703          	lbu	a4,0(a5)
    136a:	4d09                	li	s10,2
    136c:	478d                	li	a5,3
    136e:	00e10923          	sb	a4,18(sp)
    if (sign)
    1372:	0206cd63          	bltz	a3,13ac <printf+0x2f0>
    while (--i >= 0)
    1376:	9d5a                	add	s10,s10,s6
    1378:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    137c:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1380:	4605                	li	a2,1
    1382:	1d7d                	addi	s10,s10,-1
    1384:	85a2                	mv	a1,s0
    1386:	4505                	li	a0,1
    put[0] = c;
    1388:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    138c:	03d000ef          	jal	ra,1bc8 <write>
    while (--i >= 0)
    1390:	ffbd16e3          	bne	s10,s11,137c <printf+0x2c0>
    1394:	bd79                	j	1232 <printf+0x176>
    return write(stdout, put, 1);
    1396:	4605                	li	a2,1
    1398:	00001597          	auipc	a1,0x1
    139c:	9c058593          	addi	a1,a1,-1600 # 1d58 <put.1156>
    13a0:	4505                	li	a0,1
    put[0] = c;
    13a2:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    13a6:	023000ef          	jal	ra,1bc8 <write>
    13aa:	b561                	j	1232 <printf+0x176>
        buf[i++] = '-';
    13ac:	1818                	addi	a4,sp,48
    13ae:	973e                	add	a4,a4,a5
    13b0:	02d00693          	li	a3,45
    13b4:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    13b8:	8d3e                	mv	s10,a5
    13ba:	bf75                	j	1376 <printf+0x2ba>
        buf[i++] = '-';
    13bc:	181c                	addi	a5,sp,48
    13be:	97b6                	add	a5,a5,a3
    13c0:	02d00713          	li	a4,45
    13c4:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    13c8:	8d36                	mv	s10,a3
    13ca:	bdd9                	j	12a0 <printf+0x1e4>
        x = -xx;
    13cc:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    13d0:	00f7f693          	andi	a3,a5,15
    13d4:	96ce                	add	a3,a3,s3
    13d6:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    13da:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    13de:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    13e2:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    13e6:	d80d1be3          	bnez	s10,117c <printf+0xc0>
        buf[i++] = digits[x % base];
    13ea:	4d05                	li	s10,1
    13ec:	b34d                	j	118e <printf+0xd2>
                s = "(null)";
    13ee:	00001d17          	auipc	s10,0x1
    13f2:	94ad0d13          	addi	s10,s10,-1718 # 1d38 <sharedmem+0x1e>
                for (; *s; s++)
    13f6:	02800793          	li	a5,40
    13fa:	bbe5                	j	11f2 <printf+0x136>
        buf[i++] = digits[x % base];
    13fc:	4785                	li	a5,1
    if (sign)
    13fe:	f606dce3          	bgez	a3,1376 <printf+0x2ba>
    1402:	b76d                	j	13ac <printf+0x2f0>
        buf[i++] = digits[x % base];
    1404:	4789                	li	a5,2
    1406:	4d05                	li	s10,1
    if (sign)
    1408:	f606d7e3          	bgez	a3,1376 <printf+0x2ba>
    140c:	b745                	j	13ac <printf+0x2f0>

000000000000140e <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    140e:	02000793          	li	a5,32
    1412:	00f50663          	beq	a0,a5,141e <isspace+0x10>
    1416:	355d                	addiw	a0,a0,-9
    1418:	00553513          	sltiu	a0,a0,5
    141c:	8082                	ret
    141e:	4505                	li	a0,1
}
    1420:	8082                	ret

0000000000001422 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1422:	fd05051b          	addiw	a0,a0,-48
}
    1426:	00a53513          	sltiu	a0,a0,10
    142a:	8082                	ret

000000000000142c <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    142c:	02000613          	li	a2,32
    1430:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1432:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1436:	ff77069b          	addiw	a3,a4,-9
    143a:	04c70d63          	beq	a4,a2,1494 <atoi+0x68>
    143e:	0007079b          	sext.w	a5,a4
    1442:	04d5f963          	bgeu	a1,a3,1494 <atoi+0x68>
        s++;
    switch (*s) {
    1446:	02b00693          	li	a3,43
    144a:	04d70a63          	beq	a4,a3,149e <atoi+0x72>
    144e:	02d00693          	li	a3,45
    1452:	06d70463          	beq	a4,a3,14ba <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1456:	fd07859b          	addiw	a1,a5,-48
    145a:	4625                	li	a2,9
    145c:	873e                	mv	a4,a5
    145e:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1460:	4e01                	li	t3,0
    while (isdigit(*s))
    1462:	04b66a63          	bltu	a2,a1,14b6 <atoi+0x8a>
    int n = 0, neg = 0;
    1466:	4501                	li	a0,0
    while (isdigit(*s))
    1468:	4825                	li	a6,9
    146a:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    146e:	0025179b          	slliw	a5,a0,0x2
    1472:	9d3d                	addw	a0,a0,a5
    1474:	fd07031b          	addiw	t1,a4,-48
    1478:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    147c:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1480:	0685                	addi	a3,a3,1
    1482:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1486:	0006071b          	sext.w	a4,a2
    148a:	feb870e3          	bgeu	a6,a1,146a <atoi+0x3e>
    return neg ? n : -n;
    148e:	000e0563          	beqz	t3,1498 <atoi+0x6c>
}
    1492:	8082                	ret
        s++;
    1494:	0505                	addi	a0,a0,1
    1496:	bf71                	j	1432 <atoi+0x6>
    1498:	4113053b          	subw	a0,t1,a7
    149c:	8082                	ret
    while (isdigit(*s))
    149e:	00154783          	lbu	a5,1(a0)
    14a2:	4625                	li	a2,9
        s++;
    14a4:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    14a8:	fd07859b          	addiw	a1,a5,-48
    14ac:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    14b0:	4e01                	li	t3,0
    while (isdigit(*s))
    14b2:	fab67ae3          	bgeu	a2,a1,1466 <atoi+0x3a>
    14b6:	4501                	li	a0,0
}
    14b8:	8082                	ret
    while (isdigit(*s))
    14ba:	00154783          	lbu	a5,1(a0)
    14be:	4625                	li	a2,9
        s++;
    14c0:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    14c4:	fd07859b          	addiw	a1,a5,-48
    14c8:	0007871b          	sext.w	a4,a5
    14cc:	feb665e3          	bltu	a2,a1,14b6 <atoi+0x8a>
        neg = 1;
    14d0:	4e05                	li	t3,1
    14d2:	bf51                	j	1466 <atoi+0x3a>

00000000000014d4 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    14d4:	16060d63          	beqz	a2,164e <memset+0x17a>
    14d8:	40a007b3          	neg	a5,a0
    14dc:	8b9d                	andi	a5,a5,7
    14de:	00778713          	addi	a4,a5,7
    14e2:	482d                	li	a6,11
    14e4:	0ff5f593          	andi	a1,a1,255
    14e8:	fff60693          	addi	a3,a2,-1
    14ec:	17076263          	bltu	a4,a6,1650 <memset+0x17c>
    14f0:	16e6ea63          	bltu	a3,a4,1664 <memset+0x190>
    14f4:	16078563          	beqz	a5,165e <memset+0x18a>
    14f8:	00b50023          	sb	a1,0(a0)
    14fc:	4705                	li	a4,1
    14fe:	00150e93          	addi	t4,a0,1
    1502:	14e78c63          	beq	a5,a4,165a <memset+0x186>
    1506:	00b500a3          	sb	a1,1(a0)
    150a:	4709                	li	a4,2
    150c:	00250e93          	addi	t4,a0,2
    1510:	14e78d63          	beq	a5,a4,166a <memset+0x196>
    1514:	00b50123          	sb	a1,2(a0)
    1518:	470d                	li	a4,3
    151a:	00350e93          	addi	t4,a0,3
    151e:	12e78b63          	beq	a5,a4,1654 <memset+0x180>
    1522:	00b501a3          	sb	a1,3(a0)
    1526:	4711                	li	a4,4
    1528:	00450e93          	addi	t4,a0,4
    152c:	14e78163          	beq	a5,a4,166e <memset+0x19a>
    1530:	00b50223          	sb	a1,4(a0)
    1534:	4715                	li	a4,5
    1536:	00550e93          	addi	t4,a0,5
    153a:	12e78c63          	beq	a5,a4,1672 <memset+0x19e>
    153e:	00b502a3          	sb	a1,5(a0)
    1542:	471d                	li	a4,7
    1544:	00650e93          	addi	t4,a0,6
    1548:	12e79763          	bne	a5,a4,1676 <memset+0x1a2>
    154c:	00750e93          	addi	t4,a0,7
    1550:	00b50323          	sb	a1,6(a0)
    1554:	4f1d                	li	t5,7
    1556:	00859713          	slli	a4,a1,0x8
    155a:	8f4d                	or	a4,a4,a1
    155c:	01059e13          	slli	t3,a1,0x10
    1560:	01c76e33          	or	t3,a4,t3
    1564:	01859313          	slli	t1,a1,0x18
    1568:	006e6333          	or	t1,t3,t1
    156c:	02059893          	slli	a7,a1,0x20
    1570:	011368b3          	or	a7,t1,a7
    1574:	02859813          	slli	a6,a1,0x28
    1578:	40f60333          	sub	t1,a2,a5
    157c:	0108e833          	or	a6,a7,a6
    1580:	03059693          	slli	a3,a1,0x30
    1584:	00d866b3          	or	a3,a6,a3
    1588:	03859713          	slli	a4,a1,0x38
    158c:	97aa                	add	a5,a5,a0
    158e:	ff837813          	andi	a6,t1,-8
    1592:	8f55                	or	a4,a4,a3
    1594:	00f806b3          	add	a3,a6,a5
    1598:	e398                	sd	a4,0(a5)
    159a:	07a1                	addi	a5,a5,8
    159c:	fed79ee3          	bne	a5,a3,1598 <memset+0xc4>
    15a0:	ff837693          	andi	a3,t1,-8
    15a4:	00de87b3          	add	a5,t4,a3
    15a8:	01e6873b          	addw	a4,a3,t5
    15ac:	0ad30663          	beq	t1,a3,1658 <memset+0x184>
    15b0:	00b78023          	sb	a1,0(a5)
    15b4:	0017069b          	addiw	a3,a4,1
    15b8:	08c6fb63          	bgeu	a3,a2,164e <memset+0x17a>
    15bc:	00b780a3          	sb	a1,1(a5)
    15c0:	0027069b          	addiw	a3,a4,2
    15c4:	08c6f563          	bgeu	a3,a2,164e <memset+0x17a>
    15c8:	00b78123          	sb	a1,2(a5)
    15cc:	0037069b          	addiw	a3,a4,3
    15d0:	06c6ff63          	bgeu	a3,a2,164e <memset+0x17a>
    15d4:	00b781a3          	sb	a1,3(a5)
    15d8:	0047069b          	addiw	a3,a4,4
    15dc:	06c6f963          	bgeu	a3,a2,164e <memset+0x17a>
    15e0:	00b78223          	sb	a1,4(a5)
    15e4:	0057069b          	addiw	a3,a4,5
    15e8:	06c6f363          	bgeu	a3,a2,164e <memset+0x17a>
    15ec:	00b782a3          	sb	a1,5(a5)
    15f0:	0067069b          	addiw	a3,a4,6
    15f4:	04c6fd63          	bgeu	a3,a2,164e <memset+0x17a>
    15f8:	00b78323          	sb	a1,6(a5)
    15fc:	0077069b          	addiw	a3,a4,7
    1600:	04c6f763          	bgeu	a3,a2,164e <memset+0x17a>
    1604:	00b783a3          	sb	a1,7(a5)
    1608:	0087069b          	addiw	a3,a4,8
    160c:	04c6f163          	bgeu	a3,a2,164e <memset+0x17a>
    1610:	00b78423          	sb	a1,8(a5)
    1614:	0097069b          	addiw	a3,a4,9
    1618:	02c6fb63          	bgeu	a3,a2,164e <memset+0x17a>
    161c:	00b784a3          	sb	a1,9(a5)
    1620:	00a7069b          	addiw	a3,a4,10
    1624:	02c6f563          	bgeu	a3,a2,164e <memset+0x17a>
    1628:	00b78523          	sb	a1,10(a5)
    162c:	00b7069b          	addiw	a3,a4,11
    1630:	00c6ff63          	bgeu	a3,a2,164e <memset+0x17a>
    1634:	00b785a3          	sb	a1,11(a5)
    1638:	00c7069b          	addiw	a3,a4,12
    163c:	00c6f963          	bgeu	a3,a2,164e <memset+0x17a>
    1640:	00b78623          	sb	a1,12(a5)
    1644:	2735                	addiw	a4,a4,13
    1646:	00c77463          	bgeu	a4,a2,164e <memset+0x17a>
    164a:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    164e:	8082                	ret
    1650:	472d                	li	a4,11
    1652:	bd79                	j	14f0 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1654:	4f0d                	li	t5,3
    1656:	b701                	j	1556 <memset+0x82>
    1658:	8082                	ret
    165a:	4f05                	li	t5,1
    165c:	bded                	j	1556 <memset+0x82>
    165e:	8eaa                	mv	t4,a0
    1660:	4f01                	li	t5,0
    1662:	bdd5                	j	1556 <memset+0x82>
    1664:	87aa                	mv	a5,a0
    1666:	4701                	li	a4,0
    1668:	b7a1                	j	15b0 <memset+0xdc>
    166a:	4f09                	li	t5,2
    166c:	b5ed                	j	1556 <memset+0x82>
    166e:	4f11                	li	t5,4
    1670:	b5dd                	j	1556 <memset+0x82>
    1672:	4f15                	li	t5,5
    1674:	b5cd                	j	1556 <memset+0x82>
    1676:	4f19                	li	t5,6
    1678:	bdf9                	j	1556 <memset+0x82>

000000000000167a <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    167a:	00054783          	lbu	a5,0(a0)
    167e:	0005c703          	lbu	a4,0(a1)
    1682:	00e79863          	bne	a5,a4,1692 <strcmp+0x18>
    1686:	0505                	addi	a0,a0,1
    1688:	0585                	addi	a1,a1,1
    168a:	fbe5                	bnez	a5,167a <strcmp>
    168c:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    168e:	9d19                	subw	a0,a0,a4
    1690:	8082                	ret
    1692:	0007851b          	sext.w	a0,a5
    1696:	bfe5                	j	168e <strcmp+0x14>

0000000000001698 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1698:	87aa                	mv	a5,a0
    169a:	0005c703          	lbu	a4,0(a1)
    169e:	0785                	addi	a5,a5,1
    16a0:	0585                	addi	a1,a1,1
    16a2:	fee78fa3          	sb	a4,-1(a5)
    16a6:	fb75                	bnez	a4,169a <strcpy+0x2>
        ;
    return os;
}
    16a8:	8082                	ret

00000000000016aa <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    16aa:	ce05                	beqz	a2,16e2 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    16ac:	00054703          	lbu	a4,0(a0)
    16b0:	0005c783          	lbu	a5,0(a1)
    16b4:	cb0d                	beqz	a4,16e6 <strncmp+0x3c>
    if (!n--)
    16b6:	167d                	addi	a2,a2,-1
    16b8:	00c506b3          	add	a3,a0,a2
    16bc:	a819                	j	16d2 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    16be:	00a68e63          	beq	a3,a0,16da <strncmp+0x30>
    16c2:	0505                	addi	a0,a0,1
    16c4:	00e79b63          	bne	a5,a4,16da <strncmp+0x30>
    16c8:	00054703          	lbu	a4,0(a0)
    16cc:	0005c783          	lbu	a5,0(a1)
    16d0:	cb19                	beqz	a4,16e6 <strncmp+0x3c>
    16d2:	0005c783          	lbu	a5,0(a1)
    16d6:	0585                	addi	a1,a1,1
    16d8:	f3fd                	bnez	a5,16be <strncmp+0x14>
        ;
    return *l - *r;
    16da:	0007051b          	sext.w	a0,a4
    16de:	9d1d                	subw	a0,a0,a5
    16e0:	8082                	ret
        return 0;
    16e2:	4501                	li	a0,0
}
    16e4:	8082                	ret
    16e6:	4501                	li	a0,0
    return *l - *r;
    16e8:	9d1d                	subw	a0,a0,a5
    16ea:	8082                	ret

00000000000016ec <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    16ec:	00757793          	andi	a5,a0,7
    16f0:	cf89                	beqz	a5,170a <strlen+0x1e>
    16f2:	87aa                	mv	a5,a0
    16f4:	a029                	j	16fe <strlen+0x12>
    16f6:	0785                	addi	a5,a5,1
    16f8:	0077f713          	andi	a4,a5,7
    16fc:	cb01                	beqz	a4,170c <strlen+0x20>
        if (!*s)
    16fe:	0007c703          	lbu	a4,0(a5)
    1702:	fb75                	bnez	a4,16f6 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1704:	40a78533          	sub	a0,a5,a0
}
    1708:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    170a:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    170c:	6394                	ld	a3,0(a5)
    170e:	00000597          	auipc	a1,0x0
    1712:	6325b583          	ld	a1,1586(a1) # 1d40 <sharedmem+0x26>
    1716:	00000617          	auipc	a2,0x0
    171a:	63263603          	ld	a2,1586(a2) # 1d48 <sharedmem+0x2e>
    171e:	a019                	j	1724 <strlen+0x38>
    1720:	6794                	ld	a3,8(a5)
    1722:	07a1                	addi	a5,a5,8
    1724:	00b68733          	add	a4,a3,a1
    1728:	fff6c693          	not	a3,a3
    172c:	8f75                	and	a4,a4,a3
    172e:	8f71                	and	a4,a4,a2
    1730:	db65                	beqz	a4,1720 <strlen+0x34>
    for (; *s; s++)
    1732:	0007c703          	lbu	a4,0(a5)
    1736:	d779                	beqz	a4,1704 <strlen+0x18>
    1738:	0017c703          	lbu	a4,1(a5)
    173c:	0785                	addi	a5,a5,1
    173e:	d379                	beqz	a4,1704 <strlen+0x18>
    1740:	0017c703          	lbu	a4,1(a5)
    1744:	0785                	addi	a5,a5,1
    1746:	fb6d                	bnez	a4,1738 <strlen+0x4c>
    1748:	bf75                	j	1704 <strlen+0x18>

000000000000174a <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    174a:	00757713          	andi	a4,a0,7
{
    174e:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1750:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1754:	cb19                	beqz	a4,176a <memchr+0x20>
    1756:	ce25                	beqz	a2,17ce <memchr+0x84>
    1758:	0007c703          	lbu	a4,0(a5)
    175c:	04b70e63          	beq	a4,a1,17b8 <memchr+0x6e>
    1760:	0785                	addi	a5,a5,1
    1762:	0077f713          	andi	a4,a5,7
    1766:	167d                	addi	a2,a2,-1
    1768:	f77d                	bnez	a4,1756 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    176a:	4501                	li	a0,0
    if (n && *s != c) {
    176c:	c235                	beqz	a2,17d0 <memchr+0x86>
    176e:	0007c703          	lbu	a4,0(a5)
    1772:	04b70363          	beq	a4,a1,17b8 <memchr+0x6e>
        size_t k = ONES * c;
    1776:	00000517          	auipc	a0,0x0
    177a:	5da53503          	ld	a0,1498(a0) # 1d50 <sharedmem+0x36>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    177e:	471d                	li	a4,7
        size_t k = ONES * c;
    1780:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1784:	02c77a63          	bgeu	a4,a2,17b8 <memchr+0x6e>
    1788:	00000897          	auipc	a7,0x0
    178c:	5b88b883          	ld	a7,1464(a7) # 1d40 <sharedmem+0x26>
    1790:	00000817          	auipc	a6,0x0
    1794:	5b883803          	ld	a6,1464(a6) # 1d48 <sharedmem+0x2e>
    1798:	431d                	li	t1,7
    179a:	a029                	j	17a4 <memchr+0x5a>
    179c:	1661                	addi	a2,a2,-8
    179e:	07a1                	addi	a5,a5,8
    17a0:	02c37963          	bgeu	t1,a2,17d2 <memchr+0x88>
    17a4:	6398                	ld	a4,0(a5)
    17a6:	8f29                	xor	a4,a4,a0
    17a8:	011706b3          	add	a3,a4,a7
    17ac:	fff74713          	not	a4,a4
    17b0:	8f75                	and	a4,a4,a3
    17b2:	01077733          	and	a4,a4,a6
    17b6:	d37d                	beqz	a4,179c <memchr+0x52>
    17b8:	853e                	mv	a0,a5
    17ba:	97b2                	add	a5,a5,a2
    17bc:	a021                	j	17c4 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    17be:	0505                	addi	a0,a0,1
    17c0:	00f50763          	beq	a0,a5,17ce <memchr+0x84>
    17c4:	00054703          	lbu	a4,0(a0)
    17c8:	feb71be3          	bne	a4,a1,17be <memchr+0x74>
    17cc:	8082                	ret
    return n ? (void*)s : 0;
    17ce:	4501                	li	a0,0
}
    17d0:	8082                	ret
    return n ? (void*)s : 0;
    17d2:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    17d4:	f275                	bnez	a2,17b8 <memchr+0x6e>
}
    17d6:	8082                	ret

00000000000017d8 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    17d8:	1101                	addi	sp,sp,-32
    17da:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    17dc:	862e                	mv	a2,a1
{
    17de:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    17e0:	4581                	li	a1,0
{
    17e2:	e426                	sd	s1,8(sp)
    17e4:	ec06                	sd	ra,24(sp)
    17e6:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    17e8:	f63ff0ef          	jal	ra,174a <memchr>
    return p ? p - s : n;
    17ec:	c519                	beqz	a0,17fa <strnlen+0x22>
}
    17ee:	60e2                	ld	ra,24(sp)
    17f0:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    17f2:	8d05                	sub	a0,a0,s1
}
    17f4:	64a2                	ld	s1,8(sp)
    17f6:	6105                	addi	sp,sp,32
    17f8:	8082                	ret
    17fa:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    17fc:	8522                	mv	a0,s0
}
    17fe:	6442                	ld	s0,16(sp)
    1800:	64a2                	ld	s1,8(sp)
    1802:	6105                	addi	sp,sp,32
    1804:	8082                	ret

0000000000001806 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1806:	00b547b3          	xor	a5,a0,a1
    180a:	8b9d                	andi	a5,a5,7
    180c:	eb95                	bnez	a5,1840 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    180e:	0075f793          	andi	a5,a1,7
    1812:	e7b1                	bnez	a5,185e <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1814:	6198                	ld	a4,0(a1)
    1816:	00000617          	auipc	a2,0x0
    181a:	52a63603          	ld	a2,1322(a2) # 1d40 <sharedmem+0x26>
    181e:	00000817          	auipc	a6,0x0
    1822:	52a83803          	ld	a6,1322(a6) # 1d48 <sharedmem+0x2e>
    1826:	a029                	j	1830 <stpcpy+0x2a>
    1828:	e118                	sd	a4,0(a0)
    182a:	6598                	ld	a4,8(a1)
    182c:	05a1                	addi	a1,a1,8
    182e:	0521                	addi	a0,a0,8
    1830:	00c707b3          	add	a5,a4,a2
    1834:	fff74693          	not	a3,a4
    1838:	8ff5                	and	a5,a5,a3
    183a:	0107f7b3          	and	a5,a5,a6
    183e:	d7ed                	beqz	a5,1828 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1840:	0005c783          	lbu	a5,0(a1)
    1844:	00f50023          	sb	a5,0(a0)
    1848:	c785                	beqz	a5,1870 <stpcpy+0x6a>
    184a:	0015c783          	lbu	a5,1(a1)
    184e:	0505                	addi	a0,a0,1
    1850:	0585                	addi	a1,a1,1
    1852:	00f50023          	sb	a5,0(a0)
    1856:	fbf5                	bnez	a5,184a <stpcpy+0x44>
        ;
    return d;
}
    1858:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    185a:	0505                	addi	a0,a0,1
    185c:	df45                	beqz	a4,1814 <stpcpy+0xe>
            if (!(*d = *s))
    185e:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1862:	0585                	addi	a1,a1,1
    1864:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1868:	00f50023          	sb	a5,0(a0)
    186c:	f7fd                	bnez	a5,185a <stpcpy+0x54>
}
    186e:	8082                	ret
    1870:	8082                	ret

0000000000001872 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1872:	00b547b3          	xor	a5,a0,a1
    1876:	8b9d                	andi	a5,a5,7
    1878:	1a079863          	bnez	a5,1a28 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    187c:	0075f793          	andi	a5,a1,7
    1880:	16078463          	beqz	a5,19e8 <stpncpy+0x176>
    1884:	ea01                	bnez	a2,1894 <stpncpy+0x22>
    1886:	a421                	j	1a8e <stpncpy+0x21c>
    1888:	167d                	addi	a2,a2,-1
    188a:	0505                	addi	a0,a0,1
    188c:	14070e63          	beqz	a4,19e8 <stpncpy+0x176>
    1890:	1a060863          	beqz	a2,1a40 <stpncpy+0x1ce>
    1894:	0005c783          	lbu	a5,0(a1)
    1898:	0585                	addi	a1,a1,1
    189a:	0075f713          	andi	a4,a1,7
    189e:	00f50023          	sb	a5,0(a0)
    18a2:	f3fd                	bnez	a5,1888 <stpncpy+0x16>
    18a4:	4805                	li	a6,1
    18a6:	1a061863          	bnez	a2,1a56 <stpncpy+0x1e4>
    18aa:	40a007b3          	neg	a5,a0
    18ae:	8b9d                	andi	a5,a5,7
    18b0:	4681                	li	a3,0
    18b2:	18061a63          	bnez	a2,1a46 <stpncpy+0x1d4>
    18b6:	00778713          	addi	a4,a5,7
    18ba:	45ad                	li	a1,11
    18bc:	18b76363          	bltu	a4,a1,1a42 <stpncpy+0x1d0>
    18c0:	1ae6eb63          	bltu	a3,a4,1a76 <stpncpy+0x204>
    18c4:	1a078363          	beqz	a5,1a6a <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    18c8:	00050023          	sb	zero,0(a0)
    18cc:	4685                	li	a3,1
    18ce:	00150713          	addi	a4,a0,1
    18d2:	18d78f63          	beq	a5,a3,1a70 <stpncpy+0x1fe>
    18d6:	000500a3          	sb	zero,1(a0)
    18da:	4689                	li	a3,2
    18dc:	00250713          	addi	a4,a0,2
    18e0:	18d78e63          	beq	a5,a3,1a7c <stpncpy+0x20a>
    18e4:	00050123          	sb	zero,2(a0)
    18e8:	468d                	li	a3,3
    18ea:	00350713          	addi	a4,a0,3
    18ee:	16d78c63          	beq	a5,a3,1a66 <stpncpy+0x1f4>
    18f2:	000501a3          	sb	zero,3(a0)
    18f6:	4691                	li	a3,4
    18f8:	00450713          	addi	a4,a0,4
    18fc:	18d78263          	beq	a5,a3,1a80 <stpncpy+0x20e>
    1900:	00050223          	sb	zero,4(a0)
    1904:	4695                	li	a3,5
    1906:	00550713          	addi	a4,a0,5
    190a:	16d78d63          	beq	a5,a3,1a84 <stpncpy+0x212>
    190e:	000502a3          	sb	zero,5(a0)
    1912:	469d                	li	a3,7
    1914:	00650713          	addi	a4,a0,6
    1918:	16d79863          	bne	a5,a3,1a88 <stpncpy+0x216>
    191c:	00750713          	addi	a4,a0,7
    1920:	00050323          	sb	zero,6(a0)
    1924:	40f80833          	sub	a6,a6,a5
    1928:	ff887593          	andi	a1,a6,-8
    192c:	97aa                	add	a5,a5,a0
    192e:	95be                	add	a1,a1,a5
    1930:	0007b023          	sd	zero,0(a5)
    1934:	07a1                	addi	a5,a5,8
    1936:	feb79de3          	bne	a5,a1,1930 <stpncpy+0xbe>
    193a:	ff887593          	andi	a1,a6,-8
    193e:	9ead                	addw	a3,a3,a1
    1940:	00b707b3          	add	a5,a4,a1
    1944:	12b80863          	beq	a6,a1,1a74 <stpncpy+0x202>
    1948:	00078023          	sb	zero,0(a5)
    194c:	0016871b          	addiw	a4,a3,1
    1950:	0ec77863          	bgeu	a4,a2,1a40 <stpncpy+0x1ce>
    1954:	000780a3          	sb	zero,1(a5)
    1958:	0026871b          	addiw	a4,a3,2
    195c:	0ec77263          	bgeu	a4,a2,1a40 <stpncpy+0x1ce>
    1960:	00078123          	sb	zero,2(a5)
    1964:	0036871b          	addiw	a4,a3,3
    1968:	0cc77c63          	bgeu	a4,a2,1a40 <stpncpy+0x1ce>
    196c:	000781a3          	sb	zero,3(a5)
    1970:	0046871b          	addiw	a4,a3,4
    1974:	0cc77663          	bgeu	a4,a2,1a40 <stpncpy+0x1ce>
    1978:	00078223          	sb	zero,4(a5)
    197c:	0056871b          	addiw	a4,a3,5
    1980:	0cc77063          	bgeu	a4,a2,1a40 <stpncpy+0x1ce>
    1984:	000782a3          	sb	zero,5(a5)
    1988:	0066871b          	addiw	a4,a3,6
    198c:	0ac77a63          	bgeu	a4,a2,1a40 <stpncpy+0x1ce>
    1990:	00078323          	sb	zero,6(a5)
    1994:	0076871b          	addiw	a4,a3,7
    1998:	0ac77463          	bgeu	a4,a2,1a40 <stpncpy+0x1ce>
    199c:	000783a3          	sb	zero,7(a5)
    19a0:	0086871b          	addiw	a4,a3,8
    19a4:	08c77e63          	bgeu	a4,a2,1a40 <stpncpy+0x1ce>
    19a8:	00078423          	sb	zero,8(a5)
    19ac:	0096871b          	addiw	a4,a3,9
    19b0:	08c77863          	bgeu	a4,a2,1a40 <stpncpy+0x1ce>
    19b4:	000784a3          	sb	zero,9(a5)
    19b8:	00a6871b          	addiw	a4,a3,10
    19bc:	08c77263          	bgeu	a4,a2,1a40 <stpncpy+0x1ce>
    19c0:	00078523          	sb	zero,10(a5)
    19c4:	00b6871b          	addiw	a4,a3,11
    19c8:	06c77c63          	bgeu	a4,a2,1a40 <stpncpy+0x1ce>
    19cc:	000785a3          	sb	zero,11(a5)
    19d0:	00c6871b          	addiw	a4,a3,12
    19d4:	06c77663          	bgeu	a4,a2,1a40 <stpncpy+0x1ce>
    19d8:	00078623          	sb	zero,12(a5)
    19dc:	26b5                	addiw	a3,a3,13
    19de:	06c6f163          	bgeu	a3,a2,1a40 <stpncpy+0x1ce>
    19e2:	000786a3          	sb	zero,13(a5)
    19e6:	8082                	ret
            ;
        if (!n || !*s)
    19e8:	c645                	beqz	a2,1a90 <stpncpy+0x21e>
    19ea:	0005c783          	lbu	a5,0(a1)
    19ee:	ea078be3          	beqz	a5,18a4 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    19f2:	479d                	li	a5,7
    19f4:	02c7ff63          	bgeu	a5,a2,1a32 <stpncpy+0x1c0>
    19f8:	00000897          	auipc	a7,0x0
    19fc:	3488b883          	ld	a7,840(a7) # 1d40 <sharedmem+0x26>
    1a00:	00000817          	auipc	a6,0x0
    1a04:	34883803          	ld	a6,840(a6) # 1d48 <sharedmem+0x2e>
    1a08:	431d                	li	t1,7
    1a0a:	6198                	ld	a4,0(a1)
    1a0c:	011707b3          	add	a5,a4,a7
    1a10:	fff74693          	not	a3,a4
    1a14:	8ff5                	and	a5,a5,a3
    1a16:	0107f7b3          	and	a5,a5,a6
    1a1a:	ef81                	bnez	a5,1a32 <stpncpy+0x1c0>
            *wd = *ws;
    1a1c:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1a1e:	1661                	addi	a2,a2,-8
    1a20:	05a1                	addi	a1,a1,8
    1a22:	0521                	addi	a0,a0,8
    1a24:	fec363e3          	bltu	t1,a2,1a0a <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1a28:	e609                	bnez	a2,1a32 <stpncpy+0x1c0>
    1a2a:	a08d                	j	1a8c <stpncpy+0x21a>
    1a2c:	167d                	addi	a2,a2,-1
    1a2e:	0505                	addi	a0,a0,1
    1a30:	ca01                	beqz	a2,1a40 <stpncpy+0x1ce>
    1a32:	0005c783          	lbu	a5,0(a1)
    1a36:	0585                	addi	a1,a1,1
    1a38:	00f50023          	sb	a5,0(a0)
    1a3c:	fbe5                	bnez	a5,1a2c <stpncpy+0x1ba>
        ;
tail:
    1a3e:	b59d                	j	18a4 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1a40:	8082                	ret
    1a42:	472d                	li	a4,11
    1a44:	bdb5                	j	18c0 <stpncpy+0x4e>
    1a46:	00778713          	addi	a4,a5,7
    1a4a:	45ad                	li	a1,11
    1a4c:	fff60693          	addi	a3,a2,-1
    1a50:	e6b778e3          	bgeu	a4,a1,18c0 <stpncpy+0x4e>
    1a54:	b7fd                	j	1a42 <stpncpy+0x1d0>
    1a56:	40a007b3          	neg	a5,a0
    1a5a:	8832                	mv	a6,a2
    1a5c:	8b9d                	andi	a5,a5,7
    1a5e:	4681                	li	a3,0
    1a60:	e4060be3          	beqz	a2,18b6 <stpncpy+0x44>
    1a64:	b7cd                	j	1a46 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1a66:	468d                	li	a3,3
    1a68:	bd75                	j	1924 <stpncpy+0xb2>
    1a6a:	872a                	mv	a4,a0
    1a6c:	4681                	li	a3,0
    1a6e:	bd5d                	j	1924 <stpncpy+0xb2>
    1a70:	4685                	li	a3,1
    1a72:	bd4d                	j	1924 <stpncpy+0xb2>
    1a74:	8082                	ret
    1a76:	87aa                	mv	a5,a0
    1a78:	4681                	li	a3,0
    1a7a:	b5f9                	j	1948 <stpncpy+0xd6>
    1a7c:	4689                	li	a3,2
    1a7e:	b55d                	j	1924 <stpncpy+0xb2>
    1a80:	4691                	li	a3,4
    1a82:	b54d                	j	1924 <stpncpy+0xb2>
    1a84:	4695                	li	a3,5
    1a86:	bd79                	j	1924 <stpncpy+0xb2>
    1a88:	4699                	li	a3,6
    1a8a:	bd69                	j	1924 <stpncpy+0xb2>
    1a8c:	8082                	ret
    1a8e:	8082                	ret
    1a90:	8082                	ret

0000000000001a92 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1a92:	fff6071b          	addiw	a4,a2,-1
    1a96:	0cb57063          	bgeu	a0,a1,1b56 <memmove+0xc4>
        while (n-- > 0)
    1a9a:	0ec05063          	blez	a2,1b7a <memmove+0xe8>
    1a9e:	00750693          	addi	a3,a0,7
    1aa2:	8e8d                	sub	a3,a3,a1
    1aa4:	00b567b3          	or	a5,a0,a1
    1aa8:	00f6b693          	sltiu	a3,a3,15
    1aac:	8b9d                	andi	a5,a5,7
    1aae:	0016c693          	xori	a3,a3,1
    1ab2:	0017b793          	seqz	a5,a5
    1ab6:	8ff5                	and	a5,a5,a3
    1ab8:	c3f1                	beqz	a5,1b7c <memmove+0xea>
    1aba:	0007079b          	sext.w	a5,a4
    1abe:	46a5                	li	a3,9
    1ac0:	0af6fe63          	bgeu	a3,a5,1b7c <memmove+0xea>
    1ac4:	0036589b          	srliw	a7,a2,0x3
    1ac8:	088e                	slli	a7,a7,0x3
    1aca:	2601                	sext.w	a2,a2
    1acc:	87ae                	mv	a5,a1
    1ace:	86aa                	mv	a3,a0
    1ad0:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1ad2:	0007b803          	ld	a6,0(a5)
    1ad6:	07a1                	addi	a5,a5,8
    1ad8:	06a1                	addi	a3,a3,8
    1ada:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1ade:	ff179ae3          	bne	a5,a7,1ad2 <memmove+0x40>
    1ae2:	ff867813          	andi	a6,a2,-8
    1ae6:	02081793          	slli	a5,a6,0x20
    1aea:	9381                	srli	a5,a5,0x20
    1aec:	00f506b3          	add	a3,a0,a5
    1af0:	95be                	add	a1,a1,a5
    1af2:	4107073b          	subw	a4,a4,a6
    1af6:	09060263          	beq	a2,a6,1b7a <memmove+0xe8>
            *dst++ = *src++;
    1afa:	0005c783          	lbu	a5,0(a1)
    1afe:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1b02:	06e05c63          	blez	a4,1b7a <memmove+0xe8>
            *dst++ = *src++;
    1b06:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1b0a:	4785                	li	a5,1
            *dst++ = *src++;
    1b0c:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1b10:	06e7d563          	bge	a5,a4,1b7a <memmove+0xe8>
            *dst++ = *src++;
    1b14:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1b18:	4789                	li	a5,2
            *dst++ = *src++;
    1b1a:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1b1e:	04e7de63          	bge	a5,a4,1b7a <memmove+0xe8>
            *dst++ = *src++;
    1b22:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1b26:	478d                	li	a5,3
            *dst++ = *src++;
    1b28:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1b2c:	04e7d763          	bge	a5,a4,1b7a <memmove+0xe8>
            *dst++ = *src++;
    1b30:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1b34:	4791                	li	a5,4
            *dst++ = *src++;
    1b36:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1b3a:	04e7d063          	bge	a5,a4,1b7a <memmove+0xe8>
            *dst++ = *src++;
    1b3e:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1b42:	4795                	li	a5,5
            *dst++ = *src++;
    1b44:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1b48:	02e7d963          	bge	a5,a4,1b7a <memmove+0xe8>
            *dst++ = *src++;
    1b4c:	0065c783          	lbu	a5,6(a1)
    1b50:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1b54:	8082                	ret
    } else {
        dst += n;
    1b56:	00c507b3          	add	a5,a0,a2
        src += n;
    1b5a:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1b5c:	00c05f63          	blez	a2,1b7a <memmove+0xe8>
    1b60:	1702                	slli	a4,a4,0x20
    1b62:	9301                	srli	a4,a4,0x20
    1b64:	fff74713          	not	a4,a4
    1b68:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1b6a:	fff5c683          	lbu	a3,-1(a1)
    1b6e:	17fd                	addi	a5,a5,-1
    1b70:	15fd                	addi	a1,a1,-1
    1b72:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1b76:	fee79ae3          	bne	a5,a4,1b6a <memmove+0xd8>
    }
    return vdst;
}
    1b7a:	8082                	ret
    1b7c:	02071693          	slli	a3,a4,0x20
    1b80:	9281                	srli	a3,a3,0x20
    1b82:	0685                	addi	a3,a3,1
    1b84:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1b86:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1b88:	0005c703          	lbu	a4,0(a1)
    1b8c:	0585                	addi	a1,a1,1
    1b8e:	0785                	addi	a5,a5,1
    1b90:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1b94:	fed59ae3          	bne	a1,a3,1b88 <memmove+0xf6>
    1b98:	8082                	ret

0000000000001b9a <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1b9a:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1b9e:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1ba2:	2501                	sext.w	a0,a0
    1ba4:	8082                	ret

0000000000001ba6 <exec>:
    register long a7 __asm__("a7") = n;
    1ba6:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1baa:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1bac:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1bb0:	2501                	sext.w	a0,a0
    1bb2:	8082                	ret

0000000000001bb4 <exit>:
    register long a7 __asm__("a7") = n;
    1bb4:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1bb8:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1bbc:	8082                	ret

0000000000001bbe <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1bbe:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1bc2:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1bc6:	8082                	ret

0000000000001bc8 <write>:
    register long a7 __asm__("a7") = n;
    1bc8:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1bcc:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1bd0:	8082                	ret

0000000000001bd2 <getpid>:
    register long a7 __asm__("a7") = n;
    1bd2:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1bd6:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1bda:	2501                	sext.w	a0,a0
    1bdc:	8082                	ret

0000000000001bde <getppid>:
    register long a7 __asm__("a7") = n;
    1bde:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1be2:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1be6:	2501                	sext.w	a0,a0
    1be8:	8082                	ret

0000000000001bea <open>:
    register long a7 __asm__("a7") = n;
    1bea:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1bee:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1bf2:	2501                	sext.w	a0,a0
    1bf4:	8082                	ret

0000000000001bf6 <mknod>:
    register long a7 __asm__("a7") = n;
    1bf6:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1bfa:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1bfe:	2501                	sext.w	a0,a0
    1c00:	8082                	ret

0000000000001c02 <dup>:
    register long a7 __asm__("a7") = n;
    1c02:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1c04:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1c08:	2501                	sext.w	a0,a0
    1c0a:	8082                	ret

0000000000001c0c <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c0c:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c10:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c14:	2501                	sext.w	a0,a0
    1c16:	8082                	ret

0000000000001c18 <waitpid>:
    register long a7 __asm__("a7") = n;
    1c18:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c1c:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1c20:	2501                	sext.w	a0,a0
    1c22:	8082                	ret

0000000000001c24 <wait>:

pid_t wait(int *wstatus)
{
    1c24:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1c26:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1c2a:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c2c:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1c30:	2501                	sext.w	a0,a0
    1c32:	8082                	ret

0000000000001c34 <mkdir>:
    register long a7 __asm__("a7") = n;
    1c34:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1c38:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1c3c:	2501                	sext.w	a0,a0
    1c3e:	8082                	ret

0000000000001c40 <close>:
    register long a7 __asm__("a7") = n;
    1c40:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c44:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c48:	2501                	sext.w	a0,a0
    1c4a:	8082                	ret

0000000000001c4c <fork>:
    register long a7 __asm__("a7") = n;
    1c4c:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1c50:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1c54:	2501                	sext.w	a0,a0
    1c56:	8082                	ret

0000000000001c58 <time_ms>:
    register long a7 __asm__("a7") = n;
    1c58:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c5c:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1c60:	8082                	ret

0000000000001c62 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1c62:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1c64:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c68:	00000073          	ecall
    1c6c:	87aa                	mv	a5,a0
    1c6e:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1c72:	97ba                	add	a5,a5,a4
    1c74:	00f57c63          	bgeu	a0,a5,1c8c <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1c78:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c7c:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1c80:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c84:	00000073          	ecall
    1c88:	fef568e3          	bltu	a0,a5,1c78 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1c8c:	4501                	li	a0,0
    1c8e:	8082                	ret

0000000000001c90 <pipe>:
    register long a7 __asm__("a7") = n;
    1c90:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1c94:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1c98:	2501                	sext.w	a0,a0
    1c9a:	8082                	ret

0000000000001c9c <fstat>:
    register long a7 __asm__("a7") = n;
    1c9c:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ca0:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1ca4:	2501                	sext.w	a0,a0
    1ca6:	8082                	ret

0000000000001ca8 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1ca8:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1caa:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1cae:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cb0:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1cb4:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1cb8:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1cbc:	0206c163          	bltz	a3,1cde <stat+0x36>
    register long a7 __asm__("a7") = n;
    1cc0:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1cc4:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1cc6:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cc8:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1ccc:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1cd0:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1cd4:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1cd6:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1cda:	853e                	mv	a0,a5
    1cdc:	8082                	ret
        return -1;
    1cde:	57fd                	li	a5,-1
    1ce0:	bfed                	j	1cda <stat+0x32>

0000000000001ce2 <chdir>:
    register long a7 __asm__("a7") = n;
    1ce2:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1ce6:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1cea:	2501                	sext.w	a0,a0
    1cec:	8082                	ret

0000000000001cee <link>:
    register long a7 __asm__("a7") = n;
    1cee:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cf2:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1cf6:	2501                	sext.w	a0,a0
    1cf8:	8082                	ret

0000000000001cfa <unlink>:
    register long a7 __asm__("a7") = n;
    1cfa:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1cfe:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1d02:	2501                	sext.w	a0,a0
    1d04:	8082                	ret

0000000000001d06 <setpriority>:
    register long a7 __asm__("a7") = n;
    1d06:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d0a:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1d0e:	8082                	ret

0000000000001d10 <getpriority>:
    register long a7 __asm__("a7") = n;
    1d10:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1d14:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1d18:	8082                	ret

0000000000001d1a <sharedmem>:
    register long a7 __asm__("a7") = n;
    1d1a:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d1e:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1d22:	8082                	ret
