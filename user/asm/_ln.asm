
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_ln:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a881                	j	1050 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <string.h>
#include <fcntl.h>

int
main(int argc, char *argv[])
{
    1002:	1141                	addi	sp,sp,-16
    1004:	e022                	sd	s0,0(sp)
    1006:	e406                	sd	ra,8(sp)
  if(argc != 3){
    1008:	478d                	li	a5,3
{
    100a:	842e                	mv	s0,a1
  if(argc != 3){
    100c:	00f50b63          	beq	a0,a5,1022 <main+0x20>
    printf( "Usage: ln old new\n");
    1010:	00001517          	auipc	a0,0x1
    1014:	d4050513          	addi	a0,a0,-704 # 1d50 <sharedmem+0xc>
    1018:	0ce000ef          	jal	ra,10e6 <printf>
    exit(1);
    101c:	4505                	li	a0,1
    101e:	3c1000ef          	jal	ra,1bde <exit>
  }
  if(link(argv[1], argv[2]) < 0)
    1022:	680c                	ld	a1,16(s0)
    1024:	6408                	ld	a0,8(s0)
    1026:	4f3000ef          	jal	ra,1d18 <link>
    102a:	00054a63          	bltz	a0,103e <main+0x3c>
    printf("link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
    102e:	4501                	li	a0,0
    1030:	3af000ef          	jal	ra,1bde <exit>
}
    1034:	60a2                	ld	ra,8(sp)
    1036:	6402                	ld	s0,0(sp)
    1038:	4501                	li	a0,0
    103a:	0141                	addi	sp,sp,16
    103c:	8082                	ret
    printf("link %s %s: failed\n", argv[1], argv[2]);
    103e:	6810                	ld	a2,16(s0)
    1040:	640c                	ld	a1,8(s0)
    1042:	00001517          	auipc	a0,0x1
    1046:	d2650513          	addi	a0,a0,-730 # 1d68 <sharedmem+0x24>
    104a:	09c000ef          	jal	ra,10e6 <printf>
    104e:	b7c5                	j	102e <main+0x2c>

0000000000001050 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1050:	1141                	addi	sp,sp,-16
    1052:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    1054:	fafff0ef          	jal	ra,1002 <main>
}
    1058:	60a2                	ld	ra,8(sp)
    105a:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    105c:	3830006f          	j	1bde <exit>

0000000000001060 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    1060:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    1062:	00f10593          	addi	a1,sp,15
    1066:	4605                	li	a2,1
    1068:	4501                	li	a0,0
int getchar() {
    106a:	ec06                	sd	ra,24(sp)
    char byte = 0;
    106c:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1070:	379000ef          	jal	ra,1be8 <read>
    return byte;
}
    1074:	60e2                	ld	ra,24(sp)
    1076:	00f14503          	lbu	a0,15(sp)
    107a:	6105                	addi	sp,sp,32
    107c:	8082                	ret

000000000000107e <putchar>:

int putchar(int c)
{
    107e:	1141                	addi	sp,sp,-16
    1080:	e406                	sd	ra,8(sp)
    1082:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    1084:	00001597          	auipc	a1,0x1
    1088:	d1c58593          	addi	a1,a1,-740 # 1da0 <put.1156>
    return write(stdout, put, 1);
    108c:	4605                	li	a2,1
    108e:	4505                	li	a0,1
    put[0] = c;
    1090:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1094:	35f000ef          	jal	ra,1bf2 <write>
}
    1098:	60a2                	ld	ra,8(sp)
    109a:	2501                	sext.w	a0,a0
    109c:	0141                	addi	sp,sp,16
    109e:	8082                	ret

00000000000010a0 <puts>:

int puts(const char* s)
{
    10a0:	1141                	addi	sp,sp,-16
    10a2:	e022                	sd	s0,0(sp)
    10a4:	e406                	sd	ra,8(sp)
    10a6:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    10a8:	66e000ef          	jal	ra,1716 <strlen>
    10ac:	862a                	mv	a2,a0
    10ae:	85a2                	mv	a1,s0
    10b0:	4505                	li	a0,1
    10b2:	341000ef          	jal	ra,1bf2 <write>
    10b6:	00055763          	bgez	a0,10c4 <puts+0x24>
    return r;
}
    10ba:	60a2                	ld	ra,8(sp)
    10bc:	6402                	ld	s0,0(sp)
    10be:	557d                	li	a0,-1
    10c0:	0141                	addi	sp,sp,16
    10c2:	8082                	ret
    put[0] = c;
    10c4:	00001597          	auipc	a1,0x1
    10c8:	cdc58593          	addi	a1,a1,-804 # 1da0 <put.1156>
    10cc:	47a9                	li	a5,10
    return write(stdout, put, 1);
    10ce:	4605                	li	a2,1
    10d0:	4505                	li	a0,1
    put[0] = c;
    10d2:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    10d6:	31d000ef          	jal	ra,1bf2 <write>
}
    10da:	60a2                	ld	ra,8(sp)
    10dc:	6402                	ld	s0,0(sp)
    10de:	41f5551b          	sraiw	a0,a0,0x1f
    10e2:	0141                	addi	sp,sp,16
    10e4:	8082                	ret

00000000000010e6 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    10e6:	7115                	addi	sp,sp,-224
    10e8:	ed06                	sd	ra,152(sp)
    10ea:	e922                	sd	s0,144(sp)
    10ec:	e526                	sd	s1,136(sp)
    10ee:	e14a                	sd	s2,128(sp)
    10f0:	fcce                	sd	s3,120(sp)
    10f2:	f8d2                	sd	s4,112(sp)
    10f4:	f4d6                	sd	s5,104(sp)
    10f6:	f0da                	sd	s6,96(sp)
    10f8:	ecde                	sd	s7,88(sp)
    10fa:	e8e2                	sd	s8,80(sp)
    10fc:	e4e6                	sd	s9,72(sp)
    10fe:	e0ea                	sd	s10,64(sp)
    1100:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1102:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    1106:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    1108:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    110a:	f52e                	sd	a1,168(sp)
    110c:	f932                	sd	a2,176(sp)
    110e:	fd36                	sd	a3,184(sp)
    1110:	e1ba                	sd	a4,192(sp)
    1112:	e9c2                	sd	a6,208(sp)
    1114:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    1116:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1118:	0c030b63          	beqz	t1,11ee <printf+0x108>
    111c:	8aaa                	mv	s5,a0
    111e:	0003071b          	sext.w	a4,t1
    1122:	4481                	li	s1,0
        if (c != '%') {
    1124:	02500b93          	li	s7,37
    put[0] = c;
    1128:	00001417          	auipc	s0,0x1
    112c:	c7840413          	addi	s0,s0,-904 # 1da0 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    1130:	4c51                	li	s8,20
    put[0] = c;
    1132:	02500c93          	li	s9,37
    1136:	00001a17          	auipc	s4,0x1
    113a:	c72a0a13          	addi	s4,s4,-910 # 1da8 <put.1156+0x8>
    113e:	00001997          	auipc	s3,0x1
    1142:	cc298993          	addi	s3,s3,-830 # 1e00 <digits>
    1146:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    114a:	0014879b          	addiw	a5,s1,1
    114e:	00fa8933          	add	s2,s5,a5
    1152:	13771163          	bne	a4,s7,1274 <printf+0x18e>
        c = fmt[++i] & 0xff;
    1156:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    115a:	080d0a63          	beqz	s10,11ee <printf+0x108>
        switch (c) {
    115e:	2489                	addiw	s1,s1,2
    1160:	009a8933          	add	s2,s5,s1
    1164:	257d0e63          	beq	s10,s7,13c0 <printf+0x2da>
    1168:	f9cd079b          	addiw	a5,s10,-100
    116c:	0ff7f793          	andi	a5,a5,255
    1170:	0cfc6263          	bltu	s8,a5,1234 <printf+0x14e>
    1174:	078a                	slli	a5,a5,0x2
    1176:	97d2                	add	a5,a5,s4
    1178:	439c                	lw	a5,0(a5)
    117a:	97d2                	add	a5,a5,s4
    117c:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    117e:	67a2                	ld	a5,8(sp)
    1180:	4398                	lw	a4,0(a5)
    1182:	07a1                	addi	a5,a5,8
    1184:	e43e                	sd	a5,8(sp)
    1186:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    118a:	26074663          	bltz	a4,13f6 <printf+0x310>
        buf[i++] = digits[x % base];
    118e:	8bbd                	andi	a5,a5,15
    1190:	97ce                	add	a5,a5,s3
    1192:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1196:	40475d1b          	sraiw	s10,a4,0x4
    119a:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    119e:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    11a2:	020d0163          	beqz	s10,11c4 <printf+0xde>
        buf[i++] = digits[x % base];
    11a6:	9d4e                	add	s10,s10,s3
    11a8:	000d4783          	lbu	a5,0(s10)
    11ac:	4d05                	li	s10,1
    11ae:	00f108a3          	sb	a5,17(sp)
    if (sign)
    11b2:	00075963          	bgez	a4,11c4 <printf+0xde>
        buf[i++] = digits[x % base];
    11b6:	4d09                	li	s10,2
        buf[i++] = '-';
    11b8:	181c                	addi	a5,sp,48
    11ba:	02d00713          	li	a4,45
    11be:	97ea                	add	a5,a5,s10
    11c0:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    11c4:	9d5a                	add	s10,s10,s6
    11c6:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    11ca:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    11ce:	4605                	li	a2,1
    11d0:	1d7d                	addi	s10,s10,-1
    11d2:	85a2                	mv	a1,s0
    11d4:	4505                	li	a0,1
    put[0] = c;
    11d6:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    11da:	219000ef          	jal	ra,1bf2 <write>
    while (--i >= 0)
    11de:	ffbd16e3          	bne	s10,s11,11ca <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    11e2:	00094303          	lbu	t1,0(s2)
    11e6:	0003071b          	sext.w	a4,t1
    11ea:	f60310e3          	bnez	t1,114a <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    11ee:	60ea                	ld	ra,152(sp)
    11f0:	644a                	ld	s0,144(sp)
    11f2:	64aa                	ld	s1,136(sp)
    11f4:	690a                	ld	s2,128(sp)
    11f6:	79e6                	ld	s3,120(sp)
    11f8:	7a46                	ld	s4,112(sp)
    11fa:	7aa6                	ld	s5,104(sp)
    11fc:	7b06                	ld	s6,96(sp)
    11fe:	6be6                	ld	s7,88(sp)
    1200:	6c46                	ld	s8,80(sp)
    1202:	6ca6                	ld	s9,72(sp)
    1204:	6d06                	ld	s10,64(sp)
    1206:	7de2                	ld	s11,56(sp)
    1208:	612d                	addi	sp,sp,224
    120a:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    120c:	67a2                	ld	a5,8(sp)
    120e:	0007bd03          	ld	s10,0(a5)
    1212:	07a1                	addi	a5,a5,8
    1214:	e43e                	sd	a5,8(sp)
    1216:	000d1b63          	bnez	s10,122c <printf+0x146>
    121a:	aafd                	j	1418 <printf+0x332>
    return write(stdout, put, 1);
    121c:	4605                	li	a2,1
    121e:	85a2                	mv	a1,s0
    1220:	4505                	li	a0,1
                for (; *s; s++)
    1222:	0d05                	addi	s10,s10,1
    put[0] = c;
    1224:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1228:	1cb000ef          	jal	ra,1bf2 <write>
                for (; *s; s++)
    122c:	000d4783          	lbu	a5,0(s10)
    1230:	f7f5                	bnez	a5,121c <printf+0x136>
    1232:	a02d                	j	125c <printf+0x176>
    return write(stdout, put, 1);
    1234:	4605                	li	a2,1
    1236:	00001597          	auipc	a1,0x1
    123a:	b6a58593          	addi	a1,a1,-1174 # 1da0 <put.1156>
    123e:	4505                	li	a0,1
    put[0] = c;
    1240:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    1244:	1af000ef          	jal	ra,1bf2 <write>
    1248:	4605                	li	a2,1
    124a:	00001597          	auipc	a1,0x1
    124e:	b5658593          	addi	a1,a1,-1194 # 1da0 <put.1156>
    1252:	4505                	li	a0,1
    put[0] = c;
    1254:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    1258:	19b000ef          	jal	ra,1bf2 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    125c:	00094303          	lbu	t1,0(s2)
    1260:	0003071b          	sext.w	a4,t1
    1264:	f80305e3          	beqz	t1,11ee <printf+0x108>
        if (c != '%') {
    1268:	0014879b          	addiw	a5,s1,1
    126c:	00fa8933          	add	s2,s5,a5
    1270:	ef7703e3          	beq	a4,s7,1156 <printf+0x70>
    return write(stdout, put, 1);
    1274:	4605                	li	a2,1
    1276:	00001597          	auipc	a1,0x1
    127a:	b2a58593          	addi	a1,a1,-1238 # 1da0 <put.1156>
    127e:	4505                	li	a0,1
    put[0] = c;
    1280:	00640023          	sb	t1,0(s0)
            continue;
    1284:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    1286:	16d000ef          	jal	ra,1bf2 <write>
            continue;
    128a:	bfc9                	j	125c <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    128c:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    128e:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    1290:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    1292:	0007b883          	ld	a7,0(a5)
    1296:	07a1                	addi	a5,a5,8
    1298:	e43e                	sd	a5,8(sp)
        x = -xx;
    129a:	43f8d713          	srai	a4,a7,0x3f
    129e:	011747b3          	xor	a5,a4,a7
    12a2:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    12a4:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    12a6:	02c7f733          	remu	a4,a5,a2
    12aa:	8d36                	mv	s10,a3
    12ac:	0685                	addi	a3,a3,1
    12ae:	00db0533          	add	a0,s6,a3
    12b2:	85be                	mv	a1,a5
    12b4:	974e                	add	a4,a4,s3
    12b6:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    12ba:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    12be:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    12c2:	feb862e3          	bltu	a6,a1,12a6 <printf+0x1c0>
    if (sign)
    12c6:	1208c063          	bltz	a7,13e6 <printf+0x300>
    while (--i >= 0)
    12ca:	9d5a                	add	s10,s10,s6
    put[0] = c;
    12cc:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    12d0:	4605                	li	a2,1
    12d2:	85a2                	mv	a1,s0
    12d4:	4505                	li	a0,1
    put[0] = c;
    12d6:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    12da:	119000ef          	jal	ra,1bf2 <write>
    while (--i >= 0)
    12de:	87ea                	mv	a5,s10
    12e0:	1d7d                	addi	s10,s10,-1
    12e2:	fefb15e3          	bne	s6,a5,12cc <printf+0x1e6>
    12e6:	bf9d                	j	125c <printf+0x176>
                printptr(va_arg(ap, uint64));
    12e8:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    12ea:	4605                	li	a2,1
    12ec:	00001597          	auipc	a1,0x1
    12f0:	ab458593          	addi	a1,a1,-1356 # 1da0 <put.1156>
                printptr(va_arg(ap, uint64));
    12f4:	0007bd83          	ld	s11,0(a5)
    12f8:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    12fc:	4505                	li	a0,1
    put[0] = c;
    12fe:	03000793          	li	a5,48
    1302:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    1306:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    1308:	0eb000ef          	jal	ra,1bf2 <write>
    put[0] = c;
    130c:	07800793          	li	a5,120
    return write(stdout, put, 1);
    1310:	4605                	li	a2,1
    1312:	00001597          	auipc	a1,0x1
    1316:	a8e58593          	addi	a1,a1,-1394 # 1da0 <put.1156>
    131a:	4505                	li	a0,1
    put[0] = c;
    131c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1320:	4d41                	li	s10,16
    1322:	0d1000ef          	jal	ra,1bf2 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    1326:	03cdd793          	srli	a5,s11,0x3c
    132a:	97ce                	add	a5,a5,s3
    put[0] = c;
    132c:	0007c783          	lbu	a5,0(a5)
    1330:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    1332:	4605                	li	a2,1
    1334:	85a2                	mv	a1,s0
    1336:	4505                	li	a0,1
    put[0] = c;
    1338:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    133c:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    133e:	0b5000ef          	jal	ra,1bf2 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1342:	fe0d12e3          	bnez	s10,1326 <printf+0x240>
    1346:	bf19                	j	125c <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    1348:	67a2                	ld	a5,8(sp)
    134a:	4394                	lw	a3,0(a5)
    134c:	07a1                	addi	a5,a5,8
    134e:	e43e                	sd	a5,8(sp)
    1350:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    1354:	0006d663          	bgez	a3,1360 <printf+0x27a>
        x = -xx;
    1358:	40f007bb          	negw	a5,a5
    135c:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    1360:	4729                	li	a4,10
    1362:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    1366:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    136a:	964e                	add	a2,a2,s3
    136c:	00064603          	lbu	a2,0(a2)
    1370:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    1374:	0a0d0963          	beqz	s10,1426 <printf+0x340>
        buf[i++] = digits[x % base];
    1378:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    137c:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    1380:	00c98733          	add	a4,s3,a2
    1384:	00074703          	lbu	a4,0(a4)
    1388:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    138c:	c3cd                	beqz	a5,142e <printf+0x348>
        buf[i++] = digits[x % base];
    138e:	97ce                	add	a5,a5,s3
    1390:	0007c703          	lbu	a4,0(a5)
    1394:	4d09                	li	s10,2
    1396:	478d                	li	a5,3
    1398:	00e10923          	sb	a4,18(sp)
    if (sign)
    139c:	0206cd63          	bltz	a3,13d6 <printf+0x2f0>
    while (--i >= 0)
    13a0:	9d5a                	add	s10,s10,s6
    13a2:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    13a6:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    13aa:	4605                	li	a2,1
    13ac:	1d7d                	addi	s10,s10,-1
    13ae:	85a2                	mv	a1,s0
    13b0:	4505                	li	a0,1
    put[0] = c;
    13b2:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    13b6:	03d000ef          	jal	ra,1bf2 <write>
    while (--i >= 0)
    13ba:	ffbd16e3          	bne	s10,s11,13a6 <printf+0x2c0>
    13be:	bd79                	j	125c <printf+0x176>
    return write(stdout, put, 1);
    13c0:	4605                	li	a2,1
    13c2:	00001597          	auipc	a1,0x1
    13c6:	9de58593          	addi	a1,a1,-1570 # 1da0 <put.1156>
    13ca:	4505                	li	a0,1
    put[0] = c;
    13cc:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    13d0:	023000ef          	jal	ra,1bf2 <write>
    13d4:	b561                	j	125c <printf+0x176>
        buf[i++] = '-';
    13d6:	1818                	addi	a4,sp,48
    13d8:	973e                	add	a4,a4,a5
    13da:	02d00693          	li	a3,45
    13de:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    13e2:	8d3e                	mv	s10,a5
    13e4:	bf75                	j	13a0 <printf+0x2ba>
        buf[i++] = '-';
    13e6:	181c                	addi	a5,sp,48
    13e8:	97b6                	add	a5,a5,a3
    13ea:	02d00713          	li	a4,45
    13ee:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    13f2:	8d36                	mv	s10,a3
    13f4:	bdd9                	j	12ca <printf+0x1e4>
        x = -xx;
    13f6:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    13fa:	00f7f693          	andi	a3,a5,15
    13fe:	96ce                	add	a3,a3,s3
    1400:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    1404:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    1408:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    140c:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1410:	d80d1be3          	bnez	s10,11a6 <printf+0xc0>
        buf[i++] = digits[x % base];
    1414:	4d05                	li	s10,1
    1416:	b34d                	j	11b8 <printf+0xd2>
                s = "(null)";
    1418:	00001d17          	auipc	s10,0x1
    141c:	968d0d13          	addi	s10,s10,-1688 # 1d80 <sharedmem+0x3c>
                for (; *s; s++)
    1420:	02800793          	li	a5,40
    1424:	bbe5                	j	121c <printf+0x136>
        buf[i++] = digits[x % base];
    1426:	4785                	li	a5,1
    if (sign)
    1428:	f606dce3          	bgez	a3,13a0 <printf+0x2ba>
    142c:	b76d                	j	13d6 <printf+0x2f0>
        buf[i++] = digits[x % base];
    142e:	4789                	li	a5,2
    1430:	4d05                	li	s10,1
    if (sign)
    1432:	f606d7e3          	bgez	a3,13a0 <printf+0x2ba>
    1436:	b745                	j	13d6 <printf+0x2f0>

0000000000001438 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1438:	02000793          	li	a5,32
    143c:	00f50663          	beq	a0,a5,1448 <isspace+0x10>
    1440:	355d                	addiw	a0,a0,-9
    1442:	00553513          	sltiu	a0,a0,5
    1446:	8082                	ret
    1448:	4505                	li	a0,1
}
    144a:	8082                	ret

000000000000144c <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    144c:	fd05051b          	addiw	a0,a0,-48
}
    1450:	00a53513          	sltiu	a0,a0,10
    1454:	8082                	ret

0000000000001456 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1456:	02000613          	li	a2,32
    145a:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    145c:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1460:	ff77069b          	addiw	a3,a4,-9
    1464:	04c70d63          	beq	a4,a2,14be <atoi+0x68>
    1468:	0007079b          	sext.w	a5,a4
    146c:	04d5f963          	bgeu	a1,a3,14be <atoi+0x68>
        s++;
    switch (*s) {
    1470:	02b00693          	li	a3,43
    1474:	04d70a63          	beq	a4,a3,14c8 <atoi+0x72>
    1478:	02d00693          	li	a3,45
    147c:	06d70463          	beq	a4,a3,14e4 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1480:	fd07859b          	addiw	a1,a5,-48
    1484:	4625                	li	a2,9
    1486:	873e                	mv	a4,a5
    1488:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    148a:	4e01                	li	t3,0
    while (isdigit(*s))
    148c:	04b66a63          	bltu	a2,a1,14e0 <atoi+0x8a>
    int n = 0, neg = 0;
    1490:	4501                	li	a0,0
    while (isdigit(*s))
    1492:	4825                	li	a6,9
    1494:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1498:	0025179b          	slliw	a5,a0,0x2
    149c:	9d3d                	addw	a0,a0,a5
    149e:	fd07031b          	addiw	t1,a4,-48
    14a2:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    14a6:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    14aa:	0685                	addi	a3,a3,1
    14ac:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    14b0:	0006071b          	sext.w	a4,a2
    14b4:	feb870e3          	bgeu	a6,a1,1494 <atoi+0x3e>
    return neg ? n : -n;
    14b8:	000e0563          	beqz	t3,14c2 <atoi+0x6c>
}
    14bc:	8082                	ret
        s++;
    14be:	0505                	addi	a0,a0,1
    14c0:	bf71                	j	145c <atoi+0x6>
    14c2:	4113053b          	subw	a0,t1,a7
    14c6:	8082                	ret
    while (isdigit(*s))
    14c8:	00154783          	lbu	a5,1(a0)
    14cc:	4625                	li	a2,9
        s++;
    14ce:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    14d2:	fd07859b          	addiw	a1,a5,-48
    14d6:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    14da:	4e01                	li	t3,0
    while (isdigit(*s))
    14dc:	fab67ae3          	bgeu	a2,a1,1490 <atoi+0x3a>
    14e0:	4501                	li	a0,0
}
    14e2:	8082                	ret
    while (isdigit(*s))
    14e4:	00154783          	lbu	a5,1(a0)
    14e8:	4625                	li	a2,9
        s++;
    14ea:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    14ee:	fd07859b          	addiw	a1,a5,-48
    14f2:	0007871b          	sext.w	a4,a5
    14f6:	feb665e3          	bltu	a2,a1,14e0 <atoi+0x8a>
        neg = 1;
    14fa:	4e05                	li	t3,1
    14fc:	bf51                	j	1490 <atoi+0x3a>

00000000000014fe <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    14fe:	16060d63          	beqz	a2,1678 <memset+0x17a>
    1502:	40a007b3          	neg	a5,a0
    1506:	8b9d                	andi	a5,a5,7
    1508:	00778713          	addi	a4,a5,7
    150c:	482d                	li	a6,11
    150e:	0ff5f593          	andi	a1,a1,255
    1512:	fff60693          	addi	a3,a2,-1
    1516:	17076263          	bltu	a4,a6,167a <memset+0x17c>
    151a:	16e6ea63          	bltu	a3,a4,168e <memset+0x190>
    151e:	16078563          	beqz	a5,1688 <memset+0x18a>
    1522:	00b50023          	sb	a1,0(a0)
    1526:	4705                	li	a4,1
    1528:	00150e93          	addi	t4,a0,1
    152c:	14e78c63          	beq	a5,a4,1684 <memset+0x186>
    1530:	00b500a3          	sb	a1,1(a0)
    1534:	4709                	li	a4,2
    1536:	00250e93          	addi	t4,a0,2
    153a:	14e78d63          	beq	a5,a4,1694 <memset+0x196>
    153e:	00b50123          	sb	a1,2(a0)
    1542:	470d                	li	a4,3
    1544:	00350e93          	addi	t4,a0,3
    1548:	12e78b63          	beq	a5,a4,167e <memset+0x180>
    154c:	00b501a3          	sb	a1,3(a0)
    1550:	4711                	li	a4,4
    1552:	00450e93          	addi	t4,a0,4
    1556:	14e78163          	beq	a5,a4,1698 <memset+0x19a>
    155a:	00b50223          	sb	a1,4(a0)
    155e:	4715                	li	a4,5
    1560:	00550e93          	addi	t4,a0,5
    1564:	12e78c63          	beq	a5,a4,169c <memset+0x19e>
    1568:	00b502a3          	sb	a1,5(a0)
    156c:	471d                	li	a4,7
    156e:	00650e93          	addi	t4,a0,6
    1572:	12e79763          	bne	a5,a4,16a0 <memset+0x1a2>
    1576:	00750e93          	addi	t4,a0,7
    157a:	00b50323          	sb	a1,6(a0)
    157e:	4f1d                	li	t5,7
    1580:	00859713          	slli	a4,a1,0x8
    1584:	8f4d                	or	a4,a4,a1
    1586:	01059e13          	slli	t3,a1,0x10
    158a:	01c76e33          	or	t3,a4,t3
    158e:	01859313          	slli	t1,a1,0x18
    1592:	006e6333          	or	t1,t3,t1
    1596:	02059893          	slli	a7,a1,0x20
    159a:	011368b3          	or	a7,t1,a7
    159e:	02859813          	slli	a6,a1,0x28
    15a2:	40f60333          	sub	t1,a2,a5
    15a6:	0108e833          	or	a6,a7,a6
    15aa:	03059693          	slli	a3,a1,0x30
    15ae:	00d866b3          	or	a3,a6,a3
    15b2:	03859713          	slli	a4,a1,0x38
    15b6:	97aa                	add	a5,a5,a0
    15b8:	ff837813          	andi	a6,t1,-8
    15bc:	8f55                	or	a4,a4,a3
    15be:	00f806b3          	add	a3,a6,a5
    15c2:	e398                	sd	a4,0(a5)
    15c4:	07a1                	addi	a5,a5,8
    15c6:	fed79ee3          	bne	a5,a3,15c2 <memset+0xc4>
    15ca:	ff837693          	andi	a3,t1,-8
    15ce:	00de87b3          	add	a5,t4,a3
    15d2:	01e6873b          	addw	a4,a3,t5
    15d6:	0ad30663          	beq	t1,a3,1682 <memset+0x184>
    15da:	00b78023          	sb	a1,0(a5)
    15de:	0017069b          	addiw	a3,a4,1
    15e2:	08c6fb63          	bgeu	a3,a2,1678 <memset+0x17a>
    15e6:	00b780a3          	sb	a1,1(a5)
    15ea:	0027069b          	addiw	a3,a4,2
    15ee:	08c6f563          	bgeu	a3,a2,1678 <memset+0x17a>
    15f2:	00b78123          	sb	a1,2(a5)
    15f6:	0037069b          	addiw	a3,a4,3
    15fa:	06c6ff63          	bgeu	a3,a2,1678 <memset+0x17a>
    15fe:	00b781a3          	sb	a1,3(a5)
    1602:	0047069b          	addiw	a3,a4,4
    1606:	06c6f963          	bgeu	a3,a2,1678 <memset+0x17a>
    160a:	00b78223          	sb	a1,4(a5)
    160e:	0057069b          	addiw	a3,a4,5
    1612:	06c6f363          	bgeu	a3,a2,1678 <memset+0x17a>
    1616:	00b782a3          	sb	a1,5(a5)
    161a:	0067069b          	addiw	a3,a4,6
    161e:	04c6fd63          	bgeu	a3,a2,1678 <memset+0x17a>
    1622:	00b78323          	sb	a1,6(a5)
    1626:	0077069b          	addiw	a3,a4,7
    162a:	04c6f763          	bgeu	a3,a2,1678 <memset+0x17a>
    162e:	00b783a3          	sb	a1,7(a5)
    1632:	0087069b          	addiw	a3,a4,8
    1636:	04c6f163          	bgeu	a3,a2,1678 <memset+0x17a>
    163a:	00b78423          	sb	a1,8(a5)
    163e:	0097069b          	addiw	a3,a4,9
    1642:	02c6fb63          	bgeu	a3,a2,1678 <memset+0x17a>
    1646:	00b784a3          	sb	a1,9(a5)
    164a:	00a7069b          	addiw	a3,a4,10
    164e:	02c6f563          	bgeu	a3,a2,1678 <memset+0x17a>
    1652:	00b78523          	sb	a1,10(a5)
    1656:	00b7069b          	addiw	a3,a4,11
    165a:	00c6ff63          	bgeu	a3,a2,1678 <memset+0x17a>
    165e:	00b785a3          	sb	a1,11(a5)
    1662:	00c7069b          	addiw	a3,a4,12
    1666:	00c6f963          	bgeu	a3,a2,1678 <memset+0x17a>
    166a:	00b78623          	sb	a1,12(a5)
    166e:	2735                	addiw	a4,a4,13
    1670:	00c77463          	bgeu	a4,a2,1678 <memset+0x17a>
    1674:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    1678:	8082                	ret
    167a:	472d                	li	a4,11
    167c:	bd79                	j	151a <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    167e:	4f0d                	li	t5,3
    1680:	b701                	j	1580 <memset+0x82>
    1682:	8082                	ret
    1684:	4f05                	li	t5,1
    1686:	bded                	j	1580 <memset+0x82>
    1688:	8eaa                	mv	t4,a0
    168a:	4f01                	li	t5,0
    168c:	bdd5                	j	1580 <memset+0x82>
    168e:	87aa                	mv	a5,a0
    1690:	4701                	li	a4,0
    1692:	b7a1                	j	15da <memset+0xdc>
    1694:	4f09                	li	t5,2
    1696:	b5ed                	j	1580 <memset+0x82>
    1698:	4f11                	li	t5,4
    169a:	b5dd                	j	1580 <memset+0x82>
    169c:	4f15                	li	t5,5
    169e:	b5cd                	j	1580 <memset+0x82>
    16a0:	4f19                	li	t5,6
    16a2:	bdf9                	j	1580 <memset+0x82>

00000000000016a4 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    16a4:	00054783          	lbu	a5,0(a0)
    16a8:	0005c703          	lbu	a4,0(a1)
    16ac:	00e79863          	bne	a5,a4,16bc <strcmp+0x18>
    16b0:	0505                	addi	a0,a0,1
    16b2:	0585                	addi	a1,a1,1
    16b4:	fbe5                	bnez	a5,16a4 <strcmp>
    16b6:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    16b8:	9d19                	subw	a0,a0,a4
    16ba:	8082                	ret
    16bc:	0007851b          	sext.w	a0,a5
    16c0:	bfe5                	j	16b8 <strcmp+0x14>

00000000000016c2 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    16c2:	87aa                	mv	a5,a0
    16c4:	0005c703          	lbu	a4,0(a1)
    16c8:	0785                	addi	a5,a5,1
    16ca:	0585                	addi	a1,a1,1
    16cc:	fee78fa3          	sb	a4,-1(a5)
    16d0:	fb75                	bnez	a4,16c4 <strcpy+0x2>
        ;
    return os;
}
    16d2:	8082                	ret

00000000000016d4 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    16d4:	ce05                	beqz	a2,170c <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    16d6:	00054703          	lbu	a4,0(a0)
    16da:	0005c783          	lbu	a5,0(a1)
    16de:	cb0d                	beqz	a4,1710 <strncmp+0x3c>
    if (!n--)
    16e0:	167d                	addi	a2,a2,-1
    16e2:	00c506b3          	add	a3,a0,a2
    16e6:	a819                	j	16fc <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    16e8:	00a68e63          	beq	a3,a0,1704 <strncmp+0x30>
    16ec:	0505                	addi	a0,a0,1
    16ee:	00e79b63          	bne	a5,a4,1704 <strncmp+0x30>
    16f2:	00054703          	lbu	a4,0(a0)
    16f6:	0005c783          	lbu	a5,0(a1)
    16fa:	cb19                	beqz	a4,1710 <strncmp+0x3c>
    16fc:	0005c783          	lbu	a5,0(a1)
    1700:	0585                	addi	a1,a1,1
    1702:	f3fd                	bnez	a5,16e8 <strncmp+0x14>
        ;
    return *l - *r;
    1704:	0007051b          	sext.w	a0,a4
    1708:	9d1d                	subw	a0,a0,a5
    170a:	8082                	ret
        return 0;
    170c:	4501                	li	a0,0
}
    170e:	8082                	ret
    1710:	4501                	li	a0,0
    return *l - *r;
    1712:	9d1d                	subw	a0,a0,a5
    1714:	8082                	ret

0000000000001716 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    1716:	00757793          	andi	a5,a0,7
    171a:	cf89                	beqz	a5,1734 <strlen+0x1e>
    171c:	87aa                	mv	a5,a0
    171e:	a029                	j	1728 <strlen+0x12>
    1720:	0785                	addi	a5,a5,1
    1722:	0077f713          	andi	a4,a5,7
    1726:	cb01                	beqz	a4,1736 <strlen+0x20>
        if (!*s)
    1728:	0007c703          	lbu	a4,0(a5)
    172c:	fb75                	bnez	a4,1720 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    172e:	40a78533          	sub	a0,a5,a0
}
    1732:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1734:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    1736:	6394                	ld	a3,0(a5)
    1738:	00000597          	auipc	a1,0x0
    173c:	6505b583          	ld	a1,1616(a1) # 1d88 <sharedmem+0x44>
    1740:	00000617          	auipc	a2,0x0
    1744:	65063603          	ld	a2,1616(a2) # 1d90 <sharedmem+0x4c>
    1748:	a019                	j	174e <strlen+0x38>
    174a:	6794                	ld	a3,8(a5)
    174c:	07a1                	addi	a5,a5,8
    174e:	00b68733          	add	a4,a3,a1
    1752:	fff6c693          	not	a3,a3
    1756:	8f75                	and	a4,a4,a3
    1758:	8f71                	and	a4,a4,a2
    175a:	db65                	beqz	a4,174a <strlen+0x34>
    for (; *s; s++)
    175c:	0007c703          	lbu	a4,0(a5)
    1760:	d779                	beqz	a4,172e <strlen+0x18>
    1762:	0017c703          	lbu	a4,1(a5)
    1766:	0785                	addi	a5,a5,1
    1768:	d379                	beqz	a4,172e <strlen+0x18>
    176a:	0017c703          	lbu	a4,1(a5)
    176e:	0785                	addi	a5,a5,1
    1770:	fb6d                	bnez	a4,1762 <strlen+0x4c>
    1772:	bf75                	j	172e <strlen+0x18>

0000000000001774 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1774:	00757713          	andi	a4,a0,7
{
    1778:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    177a:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    177e:	cb19                	beqz	a4,1794 <memchr+0x20>
    1780:	ce25                	beqz	a2,17f8 <memchr+0x84>
    1782:	0007c703          	lbu	a4,0(a5)
    1786:	04b70e63          	beq	a4,a1,17e2 <memchr+0x6e>
    178a:	0785                	addi	a5,a5,1
    178c:	0077f713          	andi	a4,a5,7
    1790:	167d                	addi	a2,a2,-1
    1792:	f77d                	bnez	a4,1780 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    1794:	4501                	li	a0,0
    if (n && *s != c) {
    1796:	c235                	beqz	a2,17fa <memchr+0x86>
    1798:	0007c703          	lbu	a4,0(a5)
    179c:	04b70363          	beq	a4,a1,17e2 <memchr+0x6e>
        size_t k = ONES * c;
    17a0:	00000517          	auipc	a0,0x0
    17a4:	5f853503          	ld	a0,1528(a0) # 1d98 <sharedmem+0x54>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    17a8:	471d                	li	a4,7
        size_t k = ONES * c;
    17aa:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    17ae:	02c77a63          	bgeu	a4,a2,17e2 <memchr+0x6e>
    17b2:	00000897          	auipc	a7,0x0
    17b6:	5d68b883          	ld	a7,1494(a7) # 1d88 <sharedmem+0x44>
    17ba:	00000817          	auipc	a6,0x0
    17be:	5d683803          	ld	a6,1494(a6) # 1d90 <sharedmem+0x4c>
    17c2:	431d                	li	t1,7
    17c4:	a029                	j	17ce <memchr+0x5a>
    17c6:	1661                	addi	a2,a2,-8
    17c8:	07a1                	addi	a5,a5,8
    17ca:	02c37963          	bgeu	t1,a2,17fc <memchr+0x88>
    17ce:	6398                	ld	a4,0(a5)
    17d0:	8f29                	xor	a4,a4,a0
    17d2:	011706b3          	add	a3,a4,a7
    17d6:	fff74713          	not	a4,a4
    17da:	8f75                	and	a4,a4,a3
    17dc:	01077733          	and	a4,a4,a6
    17e0:	d37d                	beqz	a4,17c6 <memchr+0x52>
    17e2:	853e                	mv	a0,a5
    17e4:	97b2                	add	a5,a5,a2
    17e6:	a021                	j	17ee <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    17e8:	0505                	addi	a0,a0,1
    17ea:	00f50763          	beq	a0,a5,17f8 <memchr+0x84>
    17ee:	00054703          	lbu	a4,0(a0)
    17f2:	feb71be3          	bne	a4,a1,17e8 <memchr+0x74>
    17f6:	8082                	ret
    return n ? (void*)s : 0;
    17f8:	4501                	li	a0,0
}
    17fa:	8082                	ret
    return n ? (void*)s : 0;
    17fc:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    17fe:	f275                	bnez	a2,17e2 <memchr+0x6e>
}
    1800:	8082                	ret

0000000000001802 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1802:	1101                	addi	sp,sp,-32
    1804:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1806:	862e                	mv	a2,a1
{
    1808:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    180a:	4581                	li	a1,0
{
    180c:	e426                	sd	s1,8(sp)
    180e:	ec06                	sd	ra,24(sp)
    1810:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1812:	f63ff0ef          	jal	ra,1774 <memchr>
    return p ? p - s : n;
    1816:	c519                	beqz	a0,1824 <strnlen+0x22>
}
    1818:	60e2                	ld	ra,24(sp)
    181a:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    181c:	8d05                	sub	a0,a0,s1
}
    181e:	64a2                	ld	s1,8(sp)
    1820:	6105                	addi	sp,sp,32
    1822:	8082                	ret
    1824:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1826:	8522                	mv	a0,s0
}
    1828:	6442                	ld	s0,16(sp)
    182a:	64a2                	ld	s1,8(sp)
    182c:	6105                	addi	sp,sp,32
    182e:	8082                	ret

0000000000001830 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1830:	00b547b3          	xor	a5,a0,a1
    1834:	8b9d                	andi	a5,a5,7
    1836:	eb95                	bnez	a5,186a <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1838:	0075f793          	andi	a5,a1,7
    183c:	e7b1                	bnez	a5,1888 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    183e:	6198                	ld	a4,0(a1)
    1840:	00000617          	auipc	a2,0x0
    1844:	54863603          	ld	a2,1352(a2) # 1d88 <sharedmem+0x44>
    1848:	00000817          	auipc	a6,0x0
    184c:	54883803          	ld	a6,1352(a6) # 1d90 <sharedmem+0x4c>
    1850:	a029                	j	185a <stpcpy+0x2a>
    1852:	e118                	sd	a4,0(a0)
    1854:	6598                	ld	a4,8(a1)
    1856:	05a1                	addi	a1,a1,8
    1858:	0521                	addi	a0,a0,8
    185a:	00c707b3          	add	a5,a4,a2
    185e:	fff74693          	not	a3,a4
    1862:	8ff5                	and	a5,a5,a3
    1864:	0107f7b3          	and	a5,a5,a6
    1868:	d7ed                	beqz	a5,1852 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    186a:	0005c783          	lbu	a5,0(a1)
    186e:	00f50023          	sb	a5,0(a0)
    1872:	c785                	beqz	a5,189a <stpcpy+0x6a>
    1874:	0015c783          	lbu	a5,1(a1)
    1878:	0505                	addi	a0,a0,1
    187a:	0585                	addi	a1,a1,1
    187c:	00f50023          	sb	a5,0(a0)
    1880:	fbf5                	bnez	a5,1874 <stpcpy+0x44>
        ;
    return d;
}
    1882:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1884:	0505                	addi	a0,a0,1
    1886:	df45                	beqz	a4,183e <stpcpy+0xe>
            if (!(*d = *s))
    1888:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    188c:	0585                	addi	a1,a1,1
    188e:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1892:	00f50023          	sb	a5,0(a0)
    1896:	f7fd                	bnez	a5,1884 <stpcpy+0x54>
}
    1898:	8082                	ret
    189a:	8082                	ret

000000000000189c <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    189c:	00b547b3          	xor	a5,a0,a1
    18a0:	8b9d                	andi	a5,a5,7
    18a2:	1a079863          	bnez	a5,1a52 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    18a6:	0075f793          	andi	a5,a1,7
    18aa:	16078463          	beqz	a5,1a12 <stpncpy+0x176>
    18ae:	ea01                	bnez	a2,18be <stpncpy+0x22>
    18b0:	a421                	j	1ab8 <stpncpy+0x21c>
    18b2:	167d                	addi	a2,a2,-1
    18b4:	0505                	addi	a0,a0,1
    18b6:	14070e63          	beqz	a4,1a12 <stpncpy+0x176>
    18ba:	1a060863          	beqz	a2,1a6a <stpncpy+0x1ce>
    18be:	0005c783          	lbu	a5,0(a1)
    18c2:	0585                	addi	a1,a1,1
    18c4:	0075f713          	andi	a4,a1,7
    18c8:	00f50023          	sb	a5,0(a0)
    18cc:	f3fd                	bnez	a5,18b2 <stpncpy+0x16>
    18ce:	4805                	li	a6,1
    18d0:	1a061863          	bnez	a2,1a80 <stpncpy+0x1e4>
    18d4:	40a007b3          	neg	a5,a0
    18d8:	8b9d                	andi	a5,a5,7
    18da:	4681                	li	a3,0
    18dc:	18061a63          	bnez	a2,1a70 <stpncpy+0x1d4>
    18e0:	00778713          	addi	a4,a5,7
    18e4:	45ad                	li	a1,11
    18e6:	18b76363          	bltu	a4,a1,1a6c <stpncpy+0x1d0>
    18ea:	1ae6eb63          	bltu	a3,a4,1aa0 <stpncpy+0x204>
    18ee:	1a078363          	beqz	a5,1a94 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    18f2:	00050023          	sb	zero,0(a0)
    18f6:	4685                	li	a3,1
    18f8:	00150713          	addi	a4,a0,1
    18fc:	18d78f63          	beq	a5,a3,1a9a <stpncpy+0x1fe>
    1900:	000500a3          	sb	zero,1(a0)
    1904:	4689                	li	a3,2
    1906:	00250713          	addi	a4,a0,2
    190a:	18d78e63          	beq	a5,a3,1aa6 <stpncpy+0x20a>
    190e:	00050123          	sb	zero,2(a0)
    1912:	468d                	li	a3,3
    1914:	00350713          	addi	a4,a0,3
    1918:	16d78c63          	beq	a5,a3,1a90 <stpncpy+0x1f4>
    191c:	000501a3          	sb	zero,3(a0)
    1920:	4691                	li	a3,4
    1922:	00450713          	addi	a4,a0,4
    1926:	18d78263          	beq	a5,a3,1aaa <stpncpy+0x20e>
    192a:	00050223          	sb	zero,4(a0)
    192e:	4695                	li	a3,5
    1930:	00550713          	addi	a4,a0,5
    1934:	16d78d63          	beq	a5,a3,1aae <stpncpy+0x212>
    1938:	000502a3          	sb	zero,5(a0)
    193c:	469d                	li	a3,7
    193e:	00650713          	addi	a4,a0,6
    1942:	16d79863          	bne	a5,a3,1ab2 <stpncpy+0x216>
    1946:	00750713          	addi	a4,a0,7
    194a:	00050323          	sb	zero,6(a0)
    194e:	40f80833          	sub	a6,a6,a5
    1952:	ff887593          	andi	a1,a6,-8
    1956:	97aa                	add	a5,a5,a0
    1958:	95be                	add	a1,a1,a5
    195a:	0007b023          	sd	zero,0(a5)
    195e:	07a1                	addi	a5,a5,8
    1960:	feb79de3          	bne	a5,a1,195a <stpncpy+0xbe>
    1964:	ff887593          	andi	a1,a6,-8
    1968:	9ead                	addw	a3,a3,a1
    196a:	00b707b3          	add	a5,a4,a1
    196e:	12b80863          	beq	a6,a1,1a9e <stpncpy+0x202>
    1972:	00078023          	sb	zero,0(a5)
    1976:	0016871b          	addiw	a4,a3,1
    197a:	0ec77863          	bgeu	a4,a2,1a6a <stpncpy+0x1ce>
    197e:	000780a3          	sb	zero,1(a5)
    1982:	0026871b          	addiw	a4,a3,2
    1986:	0ec77263          	bgeu	a4,a2,1a6a <stpncpy+0x1ce>
    198a:	00078123          	sb	zero,2(a5)
    198e:	0036871b          	addiw	a4,a3,3
    1992:	0cc77c63          	bgeu	a4,a2,1a6a <stpncpy+0x1ce>
    1996:	000781a3          	sb	zero,3(a5)
    199a:	0046871b          	addiw	a4,a3,4
    199e:	0cc77663          	bgeu	a4,a2,1a6a <stpncpy+0x1ce>
    19a2:	00078223          	sb	zero,4(a5)
    19a6:	0056871b          	addiw	a4,a3,5
    19aa:	0cc77063          	bgeu	a4,a2,1a6a <stpncpy+0x1ce>
    19ae:	000782a3          	sb	zero,5(a5)
    19b2:	0066871b          	addiw	a4,a3,6
    19b6:	0ac77a63          	bgeu	a4,a2,1a6a <stpncpy+0x1ce>
    19ba:	00078323          	sb	zero,6(a5)
    19be:	0076871b          	addiw	a4,a3,7
    19c2:	0ac77463          	bgeu	a4,a2,1a6a <stpncpy+0x1ce>
    19c6:	000783a3          	sb	zero,7(a5)
    19ca:	0086871b          	addiw	a4,a3,8
    19ce:	08c77e63          	bgeu	a4,a2,1a6a <stpncpy+0x1ce>
    19d2:	00078423          	sb	zero,8(a5)
    19d6:	0096871b          	addiw	a4,a3,9
    19da:	08c77863          	bgeu	a4,a2,1a6a <stpncpy+0x1ce>
    19de:	000784a3          	sb	zero,9(a5)
    19e2:	00a6871b          	addiw	a4,a3,10
    19e6:	08c77263          	bgeu	a4,a2,1a6a <stpncpy+0x1ce>
    19ea:	00078523          	sb	zero,10(a5)
    19ee:	00b6871b          	addiw	a4,a3,11
    19f2:	06c77c63          	bgeu	a4,a2,1a6a <stpncpy+0x1ce>
    19f6:	000785a3          	sb	zero,11(a5)
    19fa:	00c6871b          	addiw	a4,a3,12
    19fe:	06c77663          	bgeu	a4,a2,1a6a <stpncpy+0x1ce>
    1a02:	00078623          	sb	zero,12(a5)
    1a06:	26b5                	addiw	a3,a3,13
    1a08:	06c6f163          	bgeu	a3,a2,1a6a <stpncpy+0x1ce>
    1a0c:	000786a3          	sb	zero,13(a5)
    1a10:	8082                	ret
            ;
        if (!n || !*s)
    1a12:	c645                	beqz	a2,1aba <stpncpy+0x21e>
    1a14:	0005c783          	lbu	a5,0(a1)
    1a18:	ea078be3          	beqz	a5,18ce <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1a1c:	479d                	li	a5,7
    1a1e:	02c7ff63          	bgeu	a5,a2,1a5c <stpncpy+0x1c0>
    1a22:	00000897          	auipc	a7,0x0
    1a26:	3668b883          	ld	a7,870(a7) # 1d88 <sharedmem+0x44>
    1a2a:	00000817          	auipc	a6,0x0
    1a2e:	36683803          	ld	a6,870(a6) # 1d90 <sharedmem+0x4c>
    1a32:	431d                	li	t1,7
    1a34:	6198                	ld	a4,0(a1)
    1a36:	011707b3          	add	a5,a4,a7
    1a3a:	fff74693          	not	a3,a4
    1a3e:	8ff5                	and	a5,a5,a3
    1a40:	0107f7b3          	and	a5,a5,a6
    1a44:	ef81                	bnez	a5,1a5c <stpncpy+0x1c0>
            *wd = *ws;
    1a46:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1a48:	1661                	addi	a2,a2,-8
    1a4a:	05a1                	addi	a1,a1,8
    1a4c:	0521                	addi	a0,a0,8
    1a4e:	fec363e3          	bltu	t1,a2,1a34 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1a52:	e609                	bnez	a2,1a5c <stpncpy+0x1c0>
    1a54:	a08d                	j	1ab6 <stpncpy+0x21a>
    1a56:	167d                	addi	a2,a2,-1
    1a58:	0505                	addi	a0,a0,1
    1a5a:	ca01                	beqz	a2,1a6a <stpncpy+0x1ce>
    1a5c:	0005c783          	lbu	a5,0(a1)
    1a60:	0585                	addi	a1,a1,1
    1a62:	00f50023          	sb	a5,0(a0)
    1a66:	fbe5                	bnez	a5,1a56 <stpncpy+0x1ba>
        ;
tail:
    1a68:	b59d                	j	18ce <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1a6a:	8082                	ret
    1a6c:	472d                	li	a4,11
    1a6e:	bdb5                	j	18ea <stpncpy+0x4e>
    1a70:	00778713          	addi	a4,a5,7
    1a74:	45ad                	li	a1,11
    1a76:	fff60693          	addi	a3,a2,-1
    1a7a:	e6b778e3          	bgeu	a4,a1,18ea <stpncpy+0x4e>
    1a7e:	b7fd                	j	1a6c <stpncpy+0x1d0>
    1a80:	40a007b3          	neg	a5,a0
    1a84:	8832                	mv	a6,a2
    1a86:	8b9d                	andi	a5,a5,7
    1a88:	4681                	li	a3,0
    1a8a:	e4060be3          	beqz	a2,18e0 <stpncpy+0x44>
    1a8e:	b7cd                	j	1a70 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1a90:	468d                	li	a3,3
    1a92:	bd75                	j	194e <stpncpy+0xb2>
    1a94:	872a                	mv	a4,a0
    1a96:	4681                	li	a3,0
    1a98:	bd5d                	j	194e <stpncpy+0xb2>
    1a9a:	4685                	li	a3,1
    1a9c:	bd4d                	j	194e <stpncpy+0xb2>
    1a9e:	8082                	ret
    1aa0:	87aa                	mv	a5,a0
    1aa2:	4681                	li	a3,0
    1aa4:	b5f9                	j	1972 <stpncpy+0xd6>
    1aa6:	4689                	li	a3,2
    1aa8:	b55d                	j	194e <stpncpy+0xb2>
    1aaa:	4691                	li	a3,4
    1aac:	b54d                	j	194e <stpncpy+0xb2>
    1aae:	4695                	li	a3,5
    1ab0:	bd79                	j	194e <stpncpy+0xb2>
    1ab2:	4699                	li	a3,6
    1ab4:	bd69                	j	194e <stpncpy+0xb2>
    1ab6:	8082                	ret
    1ab8:	8082                	ret
    1aba:	8082                	ret

0000000000001abc <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1abc:	fff6071b          	addiw	a4,a2,-1
    1ac0:	0cb57063          	bgeu	a0,a1,1b80 <memmove+0xc4>
        while (n-- > 0)
    1ac4:	0ec05063          	blez	a2,1ba4 <memmove+0xe8>
    1ac8:	00750693          	addi	a3,a0,7
    1acc:	8e8d                	sub	a3,a3,a1
    1ace:	00b567b3          	or	a5,a0,a1
    1ad2:	00f6b693          	sltiu	a3,a3,15
    1ad6:	8b9d                	andi	a5,a5,7
    1ad8:	0016c693          	xori	a3,a3,1
    1adc:	0017b793          	seqz	a5,a5
    1ae0:	8ff5                	and	a5,a5,a3
    1ae2:	c3f1                	beqz	a5,1ba6 <memmove+0xea>
    1ae4:	0007079b          	sext.w	a5,a4
    1ae8:	46a5                	li	a3,9
    1aea:	0af6fe63          	bgeu	a3,a5,1ba6 <memmove+0xea>
    1aee:	0036589b          	srliw	a7,a2,0x3
    1af2:	088e                	slli	a7,a7,0x3
    1af4:	2601                	sext.w	a2,a2
    1af6:	87ae                	mv	a5,a1
    1af8:	86aa                	mv	a3,a0
    1afa:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1afc:	0007b803          	ld	a6,0(a5)
    1b00:	07a1                	addi	a5,a5,8
    1b02:	06a1                	addi	a3,a3,8
    1b04:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1b08:	ff179ae3          	bne	a5,a7,1afc <memmove+0x40>
    1b0c:	ff867813          	andi	a6,a2,-8
    1b10:	02081793          	slli	a5,a6,0x20
    1b14:	9381                	srli	a5,a5,0x20
    1b16:	00f506b3          	add	a3,a0,a5
    1b1a:	95be                	add	a1,a1,a5
    1b1c:	4107073b          	subw	a4,a4,a6
    1b20:	09060263          	beq	a2,a6,1ba4 <memmove+0xe8>
            *dst++ = *src++;
    1b24:	0005c783          	lbu	a5,0(a1)
    1b28:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1b2c:	06e05c63          	blez	a4,1ba4 <memmove+0xe8>
            *dst++ = *src++;
    1b30:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1b34:	4785                	li	a5,1
            *dst++ = *src++;
    1b36:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1b3a:	06e7d563          	bge	a5,a4,1ba4 <memmove+0xe8>
            *dst++ = *src++;
    1b3e:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1b42:	4789                	li	a5,2
            *dst++ = *src++;
    1b44:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1b48:	04e7de63          	bge	a5,a4,1ba4 <memmove+0xe8>
            *dst++ = *src++;
    1b4c:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1b50:	478d                	li	a5,3
            *dst++ = *src++;
    1b52:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1b56:	04e7d763          	bge	a5,a4,1ba4 <memmove+0xe8>
            *dst++ = *src++;
    1b5a:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1b5e:	4791                	li	a5,4
            *dst++ = *src++;
    1b60:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1b64:	04e7d063          	bge	a5,a4,1ba4 <memmove+0xe8>
            *dst++ = *src++;
    1b68:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1b6c:	4795                	li	a5,5
            *dst++ = *src++;
    1b6e:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1b72:	02e7d963          	bge	a5,a4,1ba4 <memmove+0xe8>
            *dst++ = *src++;
    1b76:	0065c783          	lbu	a5,6(a1)
    1b7a:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1b7e:	8082                	ret
    } else {
        dst += n;
    1b80:	00c507b3          	add	a5,a0,a2
        src += n;
    1b84:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1b86:	00c05f63          	blez	a2,1ba4 <memmove+0xe8>
    1b8a:	1702                	slli	a4,a4,0x20
    1b8c:	9301                	srli	a4,a4,0x20
    1b8e:	fff74713          	not	a4,a4
    1b92:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1b94:	fff5c683          	lbu	a3,-1(a1)
    1b98:	17fd                	addi	a5,a5,-1
    1b9a:	15fd                	addi	a1,a1,-1
    1b9c:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1ba0:	fee79ae3          	bne	a5,a4,1b94 <memmove+0xd8>
    }
    return vdst;
}
    1ba4:	8082                	ret
    1ba6:	02071693          	slli	a3,a4,0x20
    1baa:	9281                	srli	a3,a3,0x20
    1bac:	0685                	addi	a3,a3,1
    1bae:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1bb0:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1bb2:	0005c703          	lbu	a4,0(a1)
    1bb6:	0585                	addi	a1,a1,1
    1bb8:	0785                	addi	a5,a5,1
    1bba:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1bbe:	fed59ae3          	bne	a1,a3,1bb2 <memmove+0xf6>
    1bc2:	8082                	ret

0000000000001bc4 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1bc4:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1bc8:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1bcc:	2501                	sext.w	a0,a0
    1bce:	8082                	ret

0000000000001bd0 <exec>:
    register long a7 __asm__("a7") = n;
    1bd0:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1bd4:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1bd6:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1bda:	2501                	sext.w	a0,a0
    1bdc:	8082                	ret

0000000000001bde <exit>:
    register long a7 __asm__("a7") = n;
    1bde:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1be2:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1be6:	8082                	ret

0000000000001be8 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1be8:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1bec:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1bf0:	8082                	ret

0000000000001bf2 <write>:
    register long a7 __asm__("a7") = n;
    1bf2:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1bf6:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1bfa:	8082                	ret

0000000000001bfc <getpid>:
    register long a7 __asm__("a7") = n;
    1bfc:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c00:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c04:	2501                	sext.w	a0,a0
    1c06:	8082                	ret

0000000000001c08 <getppid>:
    register long a7 __asm__("a7") = n;
    1c08:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c0c:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c10:	2501                	sext.w	a0,a0
    1c12:	8082                	ret

0000000000001c14 <open>:
    register long a7 __asm__("a7") = n;
    1c14:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c18:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1c1c:	2501                	sext.w	a0,a0
    1c1e:	8082                	ret

0000000000001c20 <mknod>:
    register long a7 __asm__("a7") = n;
    1c20:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c24:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1c28:	2501                	sext.w	a0,a0
    1c2a:	8082                	ret

0000000000001c2c <dup>:
    register long a7 __asm__("a7") = n;
    1c2c:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1c2e:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1c32:	2501                	sext.w	a0,a0
    1c34:	8082                	ret

0000000000001c36 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c36:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c3a:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c3e:	2501                	sext.w	a0,a0
    1c40:	8082                	ret

0000000000001c42 <waitpid>:
    register long a7 __asm__("a7") = n;
    1c42:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c46:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1c4a:	2501                	sext.w	a0,a0
    1c4c:	8082                	ret

0000000000001c4e <wait>:

pid_t wait(int *wstatus)
{
    1c4e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1c50:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1c54:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c56:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1c5a:	2501                	sext.w	a0,a0
    1c5c:	8082                	ret

0000000000001c5e <mkdir>:
    register long a7 __asm__("a7") = n;
    1c5e:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1c62:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1c66:	2501                	sext.w	a0,a0
    1c68:	8082                	ret

0000000000001c6a <close>:
    register long a7 __asm__("a7") = n;
    1c6a:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c6e:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c72:	2501                	sext.w	a0,a0
    1c74:	8082                	ret

0000000000001c76 <fork>:
    register long a7 __asm__("a7") = n;
    1c76:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1c7a:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1c7e:	2501                	sext.w	a0,a0
    1c80:	8082                	ret

0000000000001c82 <time_ms>:
    register long a7 __asm__("a7") = n;
    1c82:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c86:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1c8a:	8082                	ret

0000000000001c8c <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1c8c:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1c8e:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c92:	00000073          	ecall
    1c96:	87aa                	mv	a5,a0
    1c98:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1c9c:	97ba                	add	a5,a5,a4
    1c9e:	00f57c63          	bgeu	a0,a5,1cb6 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1ca2:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1ca6:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1caa:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1cae:	00000073          	ecall
    1cb2:	fef568e3          	bltu	a0,a5,1ca2 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1cb6:	4501                	li	a0,0
    1cb8:	8082                	ret

0000000000001cba <pipe>:
    register long a7 __asm__("a7") = n;
    1cba:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1cbe:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1cc2:	2501                	sext.w	a0,a0
    1cc4:	8082                	ret

0000000000001cc6 <fstat>:
    register long a7 __asm__("a7") = n;
    1cc6:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cca:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1cce:	2501                	sext.w	a0,a0
    1cd0:	8082                	ret

0000000000001cd2 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1cd2:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1cd4:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1cd8:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cda:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1cde:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1ce2:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1ce6:	0206c163          	bltz	a3,1d08 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1cea:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1cee:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1cf0:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cf2:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1cf6:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1cfa:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1cfe:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1d00:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1d04:	853e                	mv	a0,a5
    1d06:	8082                	ret
        return -1;
    1d08:	57fd                	li	a5,-1
    1d0a:	bfed                	j	1d04 <stat+0x32>

0000000000001d0c <chdir>:
    register long a7 __asm__("a7") = n;
    1d0c:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1d10:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1d14:	2501                	sext.w	a0,a0
    1d16:	8082                	ret

0000000000001d18 <link>:
    register long a7 __asm__("a7") = n;
    1d18:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d1c:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1d20:	2501                	sext.w	a0,a0
    1d22:	8082                	ret

0000000000001d24 <unlink>:
    register long a7 __asm__("a7") = n;
    1d24:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1d28:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1d2c:	2501                	sext.w	a0,a0
    1d2e:	8082                	ret

0000000000001d30 <setpriority>:
    register long a7 __asm__("a7") = n;
    1d30:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d34:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1d38:	8082                	ret

0000000000001d3a <getpriority>:
    register long a7 __asm__("a7") = n;
    1d3a:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1d3e:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1d42:	8082                	ret

0000000000001d44 <sharedmem>:
    register long a7 __asm__("a7") = n;
    1d44:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d48:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1d4c:	8082                	ret
