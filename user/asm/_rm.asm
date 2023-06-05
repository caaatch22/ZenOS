
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_rm:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a0a5                	j	1068 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <string.h>
#include <ucore.h>

int
main(int argc, char *argv[])
{
    1002:	1101                	addi	sp,sp,-32
    1004:	ec06                	sd	ra,24(sp)
    1006:	e822                	sd	s0,16(sp)
    1008:	e426                	sd	s1,8(sp)
  int i;

  if(argc < 2){
    100a:	4785                	li	a5,1
    100c:	04a7d463          	bge	a5,a0,1054 <main+0x52>
    1010:	ffe5049b          	addiw	s1,a0,-2
    1014:	1482                	slli	s1,s1,0x20
    1016:	80f5                	srli	s1,s1,0x1d
    1018:	01058793          	addi	a5,a1,16
    101c:	00858413          	addi	s0,a1,8
    1020:	94be                	add	s1,s1,a5
    1022:	a021                	j	102a <main+0x28>
    1024:	0421                	addi	s0,s0,8
    printf( "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    1026:	00940e63          	beq	s0,s1,1042 <main+0x40>
    if(unlink(argv[i]) < 0){
    102a:	6008                	ld	a0,0(s0)
    102c:	511000ef          	jal	ra,1d3c <unlink>
    1030:	fe055ae3          	bgez	a0,1024 <main+0x22>
      printf( "rm: %s failed to delete\n", argv[i]);
    1034:	600c                	ld	a1,0(s0)
    1036:	00001517          	auipc	a0,0x1
    103a:	d4a50513          	addi	a0,a0,-694 # 1d80 <sharedmem+0x24>
    103e:	0c0000ef          	jal	ra,10fe <printf>
      break;
    }
  }

  exit(0);
    1042:	4501                	li	a0,0
    1044:	3b3000ef          	jal	ra,1bf6 <exit>
}
    1048:	60e2                	ld	ra,24(sp)
    104a:	6442                	ld	s0,16(sp)
    104c:	64a2                	ld	s1,8(sp)
    104e:	4501                	li	a0,0
    1050:	6105                	addi	sp,sp,32
    1052:	8082                	ret
    printf( "Usage: rm files...\n");
    1054:	00001517          	auipc	a0,0x1
    1058:	d1450513          	addi	a0,a0,-748 # 1d68 <sharedmem+0xc>
    105c:	0a2000ef          	jal	ra,10fe <printf>
    exit(1);
    1060:	4505                	li	a0,1
    1062:	395000ef          	jal	ra,1bf6 <exit>
  for(i = 1; i < argc; i++){
    1066:	bff1                	j	1042 <main+0x40>

0000000000001068 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1068:	1141                	addi	sp,sp,-16
    106a:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    106c:	f97ff0ef          	jal	ra,1002 <main>
}
    1070:	60a2                	ld	ra,8(sp)
    1072:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    1074:	3830006f          	j	1bf6 <exit>

0000000000001078 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    1078:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    107a:	00f10593          	addi	a1,sp,15
    107e:	4605                	li	a2,1
    1080:	4501                	li	a0,0
int getchar() {
    1082:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1084:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1088:	379000ef          	jal	ra,1c00 <read>
    return byte;
}
    108c:	60e2                	ld	ra,24(sp)
    108e:	00f14503          	lbu	a0,15(sp)
    1092:	6105                	addi	sp,sp,32
    1094:	8082                	ret

0000000000001096 <putchar>:

int putchar(int c)
{
    1096:	1141                	addi	sp,sp,-16
    1098:	e406                	sd	ra,8(sp)
    109a:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    109c:	00001597          	auipc	a1,0x1
    10a0:	d2458593          	addi	a1,a1,-732 # 1dc0 <put.1156>
    return write(stdout, put, 1);
    10a4:	4605                	li	a2,1
    10a6:	4505                	li	a0,1
    put[0] = c;
    10a8:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    10ac:	35f000ef          	jal	ra,1c0a <write>
}
    10b0:	60a2                	ld	ra,8(sp)
    10b2:	2501                	sext.w	a0,a0
    10b4:	0141                	addi	sp,sp,16
    10b6:	8082                	ret

00000000000010b8 <puts>:

int puts(const char* s)
{
    10b8:	1141                	addi	sp,sp,-16
    10ba:	e022                	sd	s0,0(sp)
    10bc:	e406                	sd	ra,8(sp)
    10be:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    10c0:	66e000ef          	jal	ra,172e <strlen>
    10c4:	862a                	mv	a2,a0
    10c6:	85a2                	mv	a1,s0
    10c8:	4505                	li	a0,1
    10ca:	341000ef          	jal	ra,1c0a <write>
    10ce:	00055763          	bgez	a0,10dc <puts+0x24>
    return r;
}
    10d2:	60a2                	ld	ra,8(sp)
    10d4:	6402                	ld	s0,0(sp)
    10d6:	557d                	li	a0,-1
    10d8:	0141                	addi	sp,sp,16
    10da:	8082                	ret
    put[0] = c;
    10dc:	00001597          	auipc	a1,0x1
    10e0:	ce458593          	addi	a1,a1,-796 # 1dc0 <put.1156>
    10e4:	47a9                	li	a5,10
    return write(stdout, put, 1);
    10e6:	4605                	li	a2,1
    10e8:	4505                	li	a0,1
    put[0] = c;
    10ea:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    10ee:	31d000ef          	jal	ra,1c0a <write>
}
    10f2:	60a2                	ld	ra,8(sp)
    10f4:	6402                	ld	s0,0(sp)
    10f6:	41f5551b          	sraiw	a0,a0,0x1f
    10fa:	0141                	addi	sp,sp,16
    10fc:	8082                	ret

00000000000010fe <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    10fe:	7115                	addi	sp,sp,-224
    1100:	ed06                	sd	ra,152(sp)
    1102:	e922                	sd	s0,144(sp)
    1104:	e526                	sd	s1,136(sp)
    1106:	e14a                	sd	s2,128(sp)
    1108:	fcce                	sd	s3,120(sp)
    110a:	f8d2                	sd	s4,112(sp)
    110c:	f4d6                	sd	s5,104(sp)
    110e:	f0da                	sd	s6,96(sp)
    1110:	ecde                	sd	s7,88(sp)
    1112:	e8e2                	sd	s8,80(sp)
    1114:	e4e6                	sd	s9,72(sp)
    1116:	e0ea                	sd	s10,64(sp)
    1118:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    111a:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    111e:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    1120:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    1122:	f52e                	sd	a1,168(sp)
    1124:	f932                	sd	a2,176(sp)
    1126:	fd36                	sd	a3,184(sp)
    1128:	e1ba                	sd	a4,192(sp)
    112a:	e9c2                	sd	a6,208(sp)
    112c:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    112e:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1130:	0c030b63          	beqz	t1,1206 <printf+0x108>
    1134:	8aaa                	mv	s5,a0
    1136:	0003071b          	sext.w	a4,t1
    113a:	4481                	li	s1,0
        if (c != '%') {
    113c:	02500b93          	li	s7,37
    put[0] = c;
    1140:	00001417          	auipc	s0,0x1
    1144:	c8040413          	addi	s0,s0,-896 # 1dc0 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    1148:	4c51                	li	s8,20
    put[0] = c;
    114a:	02500c93          	li	s9,37
    114e:	00001a17          	auipc	s4,0x1
    1152:	c7aa0a13          	addi	s4,s4,-902 # 1dc8 <put.1156+0x8>
    1156:	00001997          	auipc	s3,0x1
    115a:	cca98993          	addi	s3,s3,-822 # 1e20 <digits>
    115e:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    1162:	0014879b          	addiw	a5,s1,1
    1166:	00fa8933          	add	s2,s5,a5
    116a:	13771163          	bne	a4,s7,128c <printf+0x18e>
        c = fmt[++i] & 0xff;
    116e:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    1172:	080d0a63          	beqz	s10,1206 <printf+0x108>
        switch (c) {
    1176:	2489                	addiw	s1,s1,2
    1178:	009a8933          	add	s2,s5,s1
    117c:	257d0e63          	beq	s10,s7,13d8 <printf+0x2da>
    1180:	f9cd079b          	addiw	a5,s10,-100
    1184:	0ff7f793          	andi	a5,a5,255
    1188:	0cfc6263          	bltu	s8,a5,124c <printf+0x14e>
    118c:	078a                	slli	a5,a5,0x2
    118e:	97d2                	add	a5,a5,s4
    1190:	439c                	lw	a5,0(a5)
    1192:	97d2                	add	a5,a5,s4
    1194:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    1196:	67a2                	ld	a5,8(sp)
    1198:	4398                	lw	a4,0(a5)
    119a:	07a1                	addi	a5,a5,8
    119c:	e43e                	sd	a5,8(sp)
    119e:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    11a2:	26074663          	bltz	a4,140e <printf+0x310>
        buf[i++] = digits[x % base];
    11a6:	8bbd                	andi	a5,a5,15
    11a8:	97ce                	add	a5,a5,s3
    11aa:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    11ae:	40475d1b          	sraiw	s10,a4,0x4
    11b2:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    11b6:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    11ba:	020d0163          	beqz	s10,11dc <printf+0xde>
        buf[i++] = digits[x % base];
    11be:	9d4e                	add	s10,s10,s3
    11c0:	000d4783          	lbu	a5,0(s10)
    11c4:	4d05                	li	s10,1
    11c6:	00f108a3          	sb	a5,17(sp)
    if (sign)
    11ca:	00075963          	bgez	a4,11dc <printf+0xde>
        buf[i++] = digits[x % base];
    11ce:	4d09                	li	s10,2
        buf[i++] = '-';
    11d0:	181c                	addi	a5,sp,48
    11d2:	02d00713          	li	a4,45
    11d6:	97ea                	add	a5,a5,s10
    11d8:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    11dc:	9d5a                	add	s10,s10,s6
    11de:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    11e2:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    11e6:	4605                	li	a2,1
    11e8:	1d7d                	addi	s10,s10,-1
    11ea:	85a2                	mv	a1,s0
    11ec:	4505                	li	a0,1
    put[0] = c;
    11ee:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    11f2:	219000ef          	jal	ra,1c0a <write>
    while (--i >= 0)
    11f6:	ffbd16e3          	bne	s10,s11,11e2 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    11fa:	00094303          	lbu	t1,0(s2)
    11fe:	0003071b          	sext.w	a4,t1
    1202:	f60310e3          	bnez	t1,1162 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    1206:	60ea                	ld	ra,152(sp)
    1208:	644a                	ld	s0,144(sp)
    120a:	64aa                	ld	s1,136(sp)
    120c:	690a                	ld	s2,128(sp)
    120e:	79e6                	ld	s3,120(sp)
    1210:	7a46                	ld	s4,112(sp)
    1212:	7aa6                	ld	s5,104(sp)
    1214:	7b06                	ld	s6,96(sp)
    1216:	6be6                	ld	s7,88(sp)
    1218:	6c46                	ld	s8,80(sp)
    121a:	6ca6                	ld	s9,72(sp)
    121c:	6d06                	ld	s10,64(sp)
    121e:	7de2                	ld	s11,56(sp)
    1220:	612d                	addi	sp,sp,224
    1222:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    1224:	67a2                	ld	a5,8(sp)
    1226:	0007bd03          	ld	s10,0(a5)
    122a:	07a1                	addi	a5,a5,8
    122c:	e43e                	sd	a5,8(sp)
    122e:	000d1b63          	bnez	s10,1244 <printf+0x146>
    1232:	aafd                	j	1430 <printf+0x332>
    return write(stdout, put, 1);
    1234:	4605                	li	a2,1
    1236:	85a2                	mv	a1,s0
    1238:	4505                	li	a0,1
                for (; *s; s++)
    123a:	0d05                	addi	s10,s10,1
    put[0] = c;
    123c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1240:	1cb000ef          	jal	ra,1c0a <write>
                for (; *s; s++)
    1244:	000d4783          	lbu	a5,0(s10)
    1248:	f7f5                	bnez	a5,1234 <printf+0x136>
    124a:	a02d                	j	1274 <printf+0x176>
    return write(stdout, put, 1);
    124c:	4605                	li	a2,1
    124e:	00001597          	auipc	a1,0x1
    1252:	b7258593          	addi	a1,a1,-1166 # 1dc0 <put.1156>
    1256:	4505                	li	a0,1
    put[0] = c;
    1258:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    125c:	1af000ef          	jal	ra,1c0a <write>
    1260:	4605                	li	a2,1
    1262:	00001597          	auipc	a1,0x1
    1266:	b5e58593          	addi	a1,a1,-1186 # 1dc0 <put.1156>
    126a:	4505                	li	a0,1
    put[0] = c;
    126c:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    1270:	19b000ef          	jal	ra,1c0a <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1274:	00094303          	lbu	t1,0(s2)
    1278:	0003071b          	sext.w	a4,t1
    127c:	f80305e3          	beqz	t1,1206 <printf+0x108>
        if (c != '%') {
    1280:	0014879b          	addiw	a5,s1,1
    1284:	00fa8933          	add	s2,s5,a5
    1288:	ef7703e3          	beq	a4,s7,116e <printf+0x70>
    return write(stdout, put, 1);
    128c:	4605                	li	a2,1
    128e:	00001597          	auipc	a1,0x1
    1292:	b3258593          	addi	a1,a1,-1230 # 1dc0 <put.1156>
    1296:	4505                	li	a0,1
    put[0] = c;
    1298:	00640023          	sb	t1,0(s0)
            continue;
    129c:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    129e:	16d000ef          	jal	ra,1c0a <write>
            continue;
    12a2:	bfc9                	j	1274 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    12a4:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    12a6:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    12a8:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    12aa:	0007b883          	ld	a7,0(a5)
    12ae:	07a1                	addi	a5,a5,8
    12b0:	e43e                	sd	a5,8(sp)
        x = -xx;
    12b2:	43f8d713          	srai	a4,a7,0x3f
    12b6:	011747b3          	xor	a5,a4,a7
    12ba:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    12bc:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    12be:	02c7f733          	remu	a4,a5,a2
    12c2:	8d36                	mv	s10,a3
    12c4:	0685                	addi	a3,a3,1
    12c6:	00db0533          	add	a0,s6,a3
    12ca:	85be                	mv	a1,a5
    12cc:	974e                	add	a4,a4,s3
    12ce:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    12d2:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    12d6:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    12da:	feb862e3          	bltu	a6,a1,12be <printf+0x1c0>
    if (sign)
    12de:	1208c063          	bltz	a7,13fe <printf+0x300>
    while (--i >= 0)
    12e2:	9d5a                	add	s10,s10,s6
    put[0] = c;
    12e4:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    12e8:	4605                	li	a2,1
    12ea:	85a2                	mv	a1,s0
    12ec:	4505                	li	a0,1
    put[0] = c;
    12ee:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    12f2:	119000ef          	jal	ra,1c0a <write>
    while (--i >= 0)
    12f6:	87ea                	mv	a5,s10
    12f8:	1d7d                	addi	s10,s10,-1
    12fa:	fefb15e3          	bne	s6,a5,12e4 <printf+0x1e6>
    12fe:	bf9d                	j	1274 <printf+0x176>
                printptr(va_arg(ap, uint64));
    1300:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    1302:	4605                	li	a2,1
    1304:	00001597          	auipc	a1,0x1
    1308:	abc58593          	addi	a1,a1,-1348 # 1dc0 <put.1156>
                printptr(va_arg(ap, uint64));
    130c:	0007bd83          	ld	s11,0(a5)
    1310:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    1314:	4505                	li	a0,1
    put[0] = c;
    1316:	03000793          	li	a5,48
    131a:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    131e:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    1320:	0eb000ef          	jal	ra,1c0a <write>
    put[0] = c;
    1324:	07800793          	li	a5,120
    return write(stdout, put, 1);
    1328:	4605                	li	a2,1
    132a:	00001597          	auipc	a1,0x1
    132e:	a9658593          	addi	a1,a1,-1386 # 1dc0 <put.1156>
    1332:	4505                	li	a0,1
    put[0] = c;
    1334:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1338:	4d41                	li	s10,16
    133a:	0d1000ef          	jal	ra,1c0a <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    133e:	03cdd793          	srli	a5,s11,0x3c
    1342:	97ce                	add	a5,a5,s3
    put[0] = c;
    1344:	0007c783          	lbu	a5,0(a5)
    1348:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    134a:	4605                	li	a2,1
    134c:	85a2                	mv	a1,s0
    134e:	4505                	li	a0,1
    put[0] = c;
    1350:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1354:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1356:	0b5000ef          	jal	ra,1c0a <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    135a:	fe0d12e3          	bnez	s10,133e <printf+0x240>
    135e:	bf19                	j	1274 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    1360:	67a2                	ld	a5,8(sp)
    1362:	4394                	lw	a3,0(a5)
    1364:	07a1                	addi	a5,a5,8
    1366:	e43e                	sd	a5,8(sp)
    1368:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    136c:	0006d663          	bgez	a3,1378 <printf+0x27a>
        x = -xx;
    1370:	40f007bb          	negw	a5,a5
    1374:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    1378:	4729                	li	a4,10
    137a:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    137e:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    1382:	964e                	add	a2,a2,s3
    1384:	00064603          	lbu	a2,0(a2)
    1388:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    138c:	0a0d0963          	beqz	s10,143e <printf+0x340>
        buf[i++] = digits[x % base];
    1390:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    1394:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    1398:	00c98733          	add	a4,s3,a2
    139c:	00074703          	lbu	a4,0(a4)
    13a0:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    13a4:	c3cd                	beqz	a5,1446 <printf+0x348>
        buf[i++] = digits[x % base];
    13a6:	97ce                	add	a5,a5,s3
    13a8:	0007c703          	lbu	a4,0(a5)
    13ac:	4d09                	li	s10,2
    13ae:	478d                	li	a5,3
    13b0:	00e10923          	sb	a4,18(sp)
    if (sign)
    13b4:	0206cd63          	bltz	a3,13ee <printf+0x2f0>
    while (--i >= 0)
    13b8:	9d5a                	add	s10,s10,s6
    13ba:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    13be:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    13c2:	4605                	li	a2,1
    13c4:	1d7d                	addi	s10,s10,-1
    13c6:	85a2                	mv	a1,s0
    13c8:	4505                	li	a0,1
    put[0] = c;
    13ca:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    13ce:	03d000ef          	jal	ra,1c0a <write>
    while (--i >= 0)
    13d2:	ffbd16e3          	bne	s10,s11,13be <printf+0x2c0>
    13d6:	bd79                	j	1274 <printf+0x176>
    return write(stdout, put, 1);
    13d8:	4605                	li	a2,1
    13da:	00001597          	auipc	a1,0x1
    13de:	9e658593          	addi	a1,a1,-1562 # 1dc0 <put.1156>
    13e2:	4505                	li	a0,1
    put[0] = c;
    13e4:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    13e8:	023000ef          	jal	ra,1c0a <write>
    13ec:	b561                	j	1274 <printf+0x176>
        buf[i++] = '-';
    13ee:	1818                	addi	a4,sp,48
    13f0:	973e                	add	a4,a4,a5
    13f2:	02d00693          	li	a3,45
    13f6:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    13fa:	8d3e                	mv	s10,a5
    13fc:	bf75                	j	13b8 <printf+0x2ba>
        buf[i++] = '-';
    13fe:	181c                	addi	a5,sp,48
    1400:	97b6                	add	a5,a5,a3
    1402:	02d00713          	li	a4,45
    1406:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    140a:	8d36                	mv	s10,a3
    140c:	bdd9                	j	12e2 <printf+0x1e4>
        x = -xx;
    140e:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    1412:	00f7f693          	andi	a3,a5,15
    1416:	96ce                	add	a3,a3,s3
    1418:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    141c:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    1420:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    1424:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1428:	d80d1be3          	bnez	s10,11be <printf+0xc0>
        buf[i++] = digits[x % base];
    142c:	4d05                	li	s10,1
    142e:	b34d                	j	11d0 <printf+0xd2>
                s = "(null)";
    1430:	00001d17          	auipc	s10,0x1
    1434:	970d0d13          	addi	s10,s10,-1680 # 1da0 <sharedmem+0x44>
                for (; *s; s++)
    1438:	02800793          	li	a5,40
    143c:	bbe5                	j	1234 <printf+0x136>
        buf[i++] = digits[x % base];
    143e:	4785                	li	a5,1
    if (sign)
    1440:	f606dce3          	bgez	a3,13b8 <printf+0x2ba>
    1444:	b76d                	j	13ee <printf+0x2f0>
        buf[i++] = digits[x % base];
    1446:	4789                	li	a5,2
    1448:	4d05                	li	s10,1
    if (sign)
    144a:	f606d7e3          	bgez	a3,13b8 <printf+0x2ba>
    144e:	b745                	j	13ee <printf+0x2f0>

0000000000001450 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1450:	02000793          	li	a5,32
    1454:	00f50663          	beq	a0,a5,1460 <isspace+0x10>
    1458:	355d                	addiw	a0,a0,-9
    145a:	00553513          	sltiu	a0,a0,5
    145e:	8082                	ret
    1460:	4505                	li	a0,1
}
    1462:	8082                	ret

0000000000001464 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1464:	fd05051b          	addiw	a0,a0,-48
}
    1468:	00a53513          	sltiu	a0,a0,10
    146c:	8082                	ret

000000000000146e <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    146e:	02000613          	li	a2,32
    1472:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1474:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1478:	ff77069b          	addiw	a3,a4,-9
    147c:	04c70d63          	beq	a4,a2,14d6 <atoi+0x68>
    1480:	0007079b          	sext.w	a5,a4
    1484:	04d5f963          	bgeu	a1,a3,14d6 <atoi+0x68>
        s++;
    switch (*s) {
    1488:	02b00693          	li	a3,43
    148c:	04d70a63          	beq	a4,a3,14e0 <atoi+0x72>
    1490:	02d00693          	li	a3,45
    1494:	06d70463          	beq	a4,a3,14fc <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1498:	fd07859b          	addiw	a1,a5,-48
    149c:	4625                	li	a2,9
    149e:	873e                	mv	a4,a5
    14a0:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    14a2:	4e01                	li	t3,0
    while (isdigit(*s))
    14a4:	04b66a63          	bltu	a2,a1,14f8 <atoi+0x8a>
    int n = 0, neg = 0;
    14a8:	4501                	li	a0,0
    while (isdigit(*s))
    14aa:	4825                	li	a6,9
    14ac:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    14b0:	0025179b          	slliw	a5,a0,0x2
    14b4:	9d3d                	addw	a0,a0,a5
    14b6:	fd07031b          	addiw	t1,a4,-48
    14ba:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    14be:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    14c2:	0685                	addi	a3,a3,1
    14c4:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    14c8:	0006071b          	sext.w	a4,a2
    14cc:	feb870e3          	bgeu	a6,a1,14ac <atoi+0x3e>
    return neg ? n : -n;
    14d0:	000e0563          	beqz	t3,14da <atoi+0x6c>
}
    14d4:	8082                	ret
        s++;
    14d6:	0505                	addi	a0,a0,1
    14d8:	bf71                	j	1474 <atoi+0x6>
    14da:	4113053b          	subw	a0,t1,a7
    14de:	8082                	ret
    while (isdigit(*s))
    14e0:	00154783          	lbu	a5,1(a0)
    14e4:	4625                	li	a2,9
        s++;
    14e6:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    14ea:	fd07859b          	addiw	a1,a5,-48
    14ee:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    14f2:	4e01                	li	t3,0
    while (isdigit(*s))
    14f4:	fab67ae3          	bgeu	a2,a1,14a8 <atoi+0x3a>
    14f8:	4501                	li	a0,0
}
    14fa:	8082                	ret
    while (isdigit(*s))
    14fc:	00154783          	lbu	a5,1(a0)
    1500:	4625                	li	a2,9
        s++;
    1502:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1506:	fd07859b          	addiw	a1,a5,-48
    150a:	0007871b          	sext.w	a4,a5
    150e:	feb665e3          	bltu	a2,a1,14f8 <atoi+0x8a>
        neg = 1;
    1512:	4e05                	li	t3,1
    1514:	bf51                	j	14a8 <atoi+0x3a>

0000000000001516 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    1516:	16060d63          	beqz	a2,1690 <memset+0x17a>
    151a:	40a007b3          	neg	a5,a0
    151e:	8b9d                	andi	a5,a5,7
    1520:	00778713          	addi	a4,a5,7
    1524:	482d                	li	a6,11
    1526:	0ff5f593          	andi	a1,a1,255
    152a:	fff60693          	addi	a3,a2,-1
    152e:	17076263          	bltu	a4,a6,1692 <memset+0x17c>
    1532:	16e6ea63          	bltu	a3,a4,16a6 <memset+0x190>
    1536:	16078563          	beqz	a5,16a0 <memset+0x18a>
    153a:	00b50023          	sb	a1,0(a0)
    153e:	4705                	li	a4,1
    1540:	00150e93          	addi	t4,a0,1
    1544:	14e78c63          	beq	a5,a4,169c <memset+0x186>
    1548:	00b500a3          	sb	a1,1(a0)
    154c:	4709                	li	a4,2
    154e:	00250e93          	addi	t4,a0,2
    1552:	14e78d63          	beq	a5,a4,16ac <memset+0x196>
    1556:	00b50123          	sb	a1,2(a0)
    155a:	470d                	li	a4,3
    155c:	00350e93          	addi	t4,a0,3
    1560:	12e78b63          	beq	a5,a4,1696 <memset+0x180>
    1564:	00b501a3          	sb	a1,3(a0)
    1568:	4711                	li	a4,4
    156a:	00450e93          	addi	t4,a0,4
    156e:	14e78163          	beq	a5,a4,16b0 <memset+0x19a>
    1572:	00b50223          	sb	a1,4(a0)
    1576:	4715                	li	a4,5
    1578:	00550e93          	addi	t4,a0,5
    157c:	12e78c63          	beq	a5,a4,16b4 <memset+0x19e>
    1580:	00b502a3          	sb	a1,5(a0)
    1584:	471d                	li	a4,7
    1586:	00650e93          	addi	t4,a0,6
    158a:	12e79763          	bne	a5,a4,16b8 <memset+0x1a2>
    158e:	00750e93          	addi	t4,a0,7
    1592:	00b50323          	sb	a1,6(a0)
    1596:	4f1d                	li	t5,7
    1598:	00859713          	slli	a4,a1,0x8
    159c:	8f4d                	or	a4,a4,a1
    159e:	01059e13          	slli	t3,a1,0x10
    15a2:	01c76e33          	or	t3,a4,t3
    15a6:	01859313          	slli	t1,a1,0x18
    15aa:	006e6333          	or	t1,t3,t1
    15ae:	02059893          	slli	a7,a1,0x20
    15b2:	011368b3          	or	a7,t1,a7
    15b6:	02859813          	slli	a6,a1,0x28
    15ba:	40f60333          	sub	t1,a2,a5
    15be:	0108e833          	or	a6,a7,a6
    15c2:	03059693          	slli	a3,a1,0x30
    15c6:	00d866b3          	or	a3,a6,a3
    15ca:	03859713          	slli	a4,a1,0x38
    15ce:	97aa                	add	a5,a5,a0
    15d0:	ff837813          	andi	a6,t1,-8
    15d4:	8f55                	or	a4,a4,a3
    15d6:	00f806b3          	add	a3,a6,a5
    15da:	e398                	sd	a4,0(a5)
    15dc:	07a1                	addi	a5,a5,8
    15de:	fed79ee3          	bne	a5,a3,15da <memset+0xc4>
    15e2:	ff837693          	andi	a3,t1,-8
    15e6:	00de87b3          	add	a5,t4,a3
    15ea:	01e6873b          	addw	a4,a3,t5
    15ee:	0ad30663          	beq	t1,a3,169a <memset+0x184>
    15f2:	00b78023          	sb	a1,0(a5)
    15f6:	0017069b          	addiw	a3,a4,1
    15fa:	08c6fb63          	bgeu	a3,a2,1690 <memset+0x17a>
    15fe:	00b780a3          	sb	a1,1(a5)
    1602:	0027069b          	addiw	a3,a4,2
    1606:	08c6f563          	bgeu	a3,a2,1690 <memset+0x17a>
    160a:	00b78123          	sb	a1,2(a5)
    160e:	0037069b          	addiw	a3,a4,3
    1612:	06c6ff63          	bgeu	a3,a2,1690 <memset+0x17a>
    1616:	00b781a3          	sb	a1,3(a5)
    161a:	0047069b          	addiw	a3,a4,4
    161e:	06c6f963          	bgeu	a3,a2,1690 <memset+0x17a>
    1622:	00b78223          	sb	a1,4(a5)
    1626:	0057069b          	addiw	a3,a4,5
    162a:	06c6f363          	bgeu	a3,a2,1690 <memset+0x17a>
    162e:	00b782a3          	sb	a1,5(a5)
    1632:	0067069b          	addiw	a3,a4,6
    1636:	04c6fd63          	bgeu	a3,a2,1690 <memset+0x17a>
    163a:	00b78323          	sb	a1,6(a5)
    163e:	0077069b          	addiw	a3,a4,7
    1642:	04c6f763          	bgeu	a3,a2,1690 <memset+0x17a>
    1646:	00b783a3          	sb	a1,7(a5)
    164a:	0087069b          	addiw	a3,a4,8
    164e:	04c6f163          	bgeu	a3,a2,1690 <memset+0x17a>
    1652:	00b78423          	sb	a1,8(a5)
    1656:	0097069b          	addiw	a3,a4,9
    165a:	02c6fb63          	bgeu	a3,a2,1690 <memset+0x17a>
    165e:	00b784a3          	sb	a1,9(a5)
    1662:	00a7069b          	addiw	a3,a4,10
    1666:	02c6f563          	bgeu	a3,a2,1690 <memset+0x17a>
    166a:	00b78523          	sb	a1,10(a5)
    166e:	00b7069b          	addiw	a3,a4,11
    1672:	00c6ff63          	bgeu	a3,a2,1690 <memset+0x17a>
    1676:	00b785a3          	sb	a1,11(a5)
    167a:	00c7069b          	addiw	a3,a4,12
    167e:	00c6f963          	bgeu	a3,a2,1690 <memset+0x17a>
    1682:	00b78623          	sb	a1,12(a5)
    1686:	2735                	addiw	a4,a4,13
    1688:	00c77463          	bgeu	a4,a2,1690 <memset+0x17a>
    168c:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    1690:	8082                	ret
    1692:	472d                	li	a4,11
    1694:	bd79                	j	1532 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1696:	4f0d                	li	t5,3
    1698:	b701                	j	1598 <memset+0x82>
    169a:	8082                	ret
    169c:	4f05                	li	t5,1
    169e:	bded                	j	1598 <memset+0x82>
    16a0:	8eaa                	mv	t4,a0
    16a2:	4f01                	li	t5,0
    16a4:	bdd5                	j	1598 <memset+0x82>
    16a6:	87aa                	mv	a5,a0
    16a8:	4701                	li	a4,0
    16aa:	b7a1                	j	15f2 <memset+0xdc>
    16ac:	4f09                	li	t5,2
    16ae:	b5ed                	j	1598 <memset+0x82>
    16b0:	4f11                	li	t5,4
    16b2:	b5dd                	j	1598 <memset+0x82>
    16b4:	4f15                	li	t5,5
    16b6:	b5cd                	j	1598 <memset+0x82>
    16b8:	4f19                	li	t5,6
    16ba:	bdf9                	j	1598 <memset+0x82>

00000000000016bc <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    16bc:	00054783          	lbu	a5,0(a0)
    16c0:	0005c703          	lbu	a4,0(a1)
    16c4:	00e79863          	bne	a5,a4,16d4 <strcmp+0x18>
    16c8:	0505                	addi	a0,a0,1
    16ca:	0585                	addi	a1,a1,1
    16cc:	fbe5                	bnez	a5,16bc <strcmp>
    16ce:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    16d0:	9d19                	subw	a0,a0,a4
    16d2:	8082                	ret
    16d4:	0007851b          	sext.w	a0,a5
    16d8:	bfe5                	j	16d0 <strcmp+0x14>

00000000000016da <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    16da:	87aa                	mv	a5,a0
    16dc:	0005c703          	lbu	a4,0(a1)
    16e0:	0785                	addi	a5,a5,1
    16e2:	0585                	addi	a1,a1,1
    16e4:	fee78fa3          	sb	a4,-1(a5)
    16e8:	fb75                	bnez	a4,16dc <strcpy+0x2>
        ;
    return os;
}
    16ea:	8082                	ret

00000000000016ec <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    16ec:	ce05                	beqz	a2,1724 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    16ee:	00054703          	lbu	a4,0(a0)
    16f2:	0005c783          	lbu	a5,0(a1)
    16f6:	cb0d                	beqz	a4,1728 <strncmp+0x3c>
    if (!n--)
    16f8:	167d                	addi	a2,a2,-1
    16fa:	00c506b3          	add	a3,a0,a2
    16fe:	a819                	j	1714 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1700:	00a68e63          	beq	a3,a0,171c <strncmp+0x30>
    1704:	0505                	addi	a0,a0,1
    1706:	00e79b63          	bne	a5,a4,171c <strncmp+0x30>
    170a:	00054703          	lbu	a4,0(a0)
    170e:	0005c783          	lbu	a5,0(a1)
    1712:	cb19                	beqz	a4,1728 <strncmp+0x3c>
    1714:	0005c783          	lbu	a5,0(a1)
    1718:	0585                	addi	a1,a1,1
    171a:	f3fd                	bnez	a5,1700 <strncmp+0x14>
        ;
    return *l - *r;
    171c:	0007051b          	sext.w	a0,a4
    1720:	9d1d                	subw	a0,a0,a5
    1722:	8082                	ret
        return 0;
    1724:	4501                	li	a0,0
}
    1726:	8082                	ret
    1728:	4501                	li	a0,0
    return *l - *r;
    172a:	9d1d                	subw	a0,a0,a5
    172c:	8082                	ret

000000000000172e <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    172e:	00757793          	andi	a5,a0,7
    1732:	cf89                	beqz	a5,174c <strlen+0x1e>
    1734:	87aa                	mv	a5,a0
    1736:	a029                	j	1740 <strlen+0x12>
    1738:	0785                	addi	a5,a5,1
    173a:	0077f713          	andi	a4,a5,7
    173e:	cb01                	beqz	a4,174e <strlen+0x20>
        if (!*s)
    1740:	0007c703          	lbu	a4,0(a5)
    1744:	fb75                	bnez	a4,1738 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1746:	40a78533          	sub	a0,a5,a0
}
    174a:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    174c:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    174e:	6394                	ld	a3,0(a5)
    1750:	00000597          	auipc	a1,0x0
    1754:	6585b583          	ld	a1,1624(a1) # 1da8 <sharedmem+0x4c>
    1758:	00000617          	auipc	a2,0x0
    175c:	65863603          	ld	a2,1624(a2) # 1db0 <sharedmem+0x54>
    1760:	a019                	j	1766 <strlen+0x38>
    1762:	6794                	ld	a3,8(a5)
    1764:	07a1                	addi	a5,a5,8
    1766:	00b68733          	add	a4,a3,a1
    176a:	fff6c693          	not	a3,a3
    176e:	8f75                	and	a4,a4,a3
    1770:	8f71                	and	a4,a4,a2
    1772:	db65                	beqz	a4,1762 <strlen+0x34>
    for (; *s; s++)
    1774:	0007c703          	lbu	a4,0(a5)
    1778:	d779                	beqz	a4,1746 <strlen+0x18>
    177a:	0017c703          	lbu	a4,1(a5)
    177e:	0785                	addi	a5,a5,1
    1780:	d379                	beqz	a4,1746 <strlen+0x18>
    1782:	0017c703          	lbu	a4,1(a5)
    1786:	0785                	addi	a5,a5,1
    1788:	fb6d                	bnez	a4,177a <strlen+0x4c>
    178a:	bf75                	j	1746 <strlen+0x18>

000000000000178c <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    178c:	00757713          	andi	a4,a0,7
{
    1790:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1792:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1796:	cb19                	beqz	a4,17ac <memchr+0x20>
    1798:	ce25                	beqz	a2,1810 <memchr+0x84>
    179a:	0007c703          	lbu	a4,0(a5)
    179e:	04b70e63          	beq	a4,a1,17fa <memchr+0x6e>
    17a2:	0785                	addi	a5,a5,1
    17a4:	0077f713          	andi	a4,a5,7
    17a8:	167d                	addi	a2,a2,-1
    17aa:	f77d                	bnez	a4,1798 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    17ac:	4501                	li	a0,0
    if (n && *s != c) {
    17ae:	c235                	beqz	a2,1812 <memchr+0x86>
    17b0:	0007c703          	lbu	a4,0(a5)
    17b4:	04b70363          	beq	a4,a1,17fa <memchr+0x6e>
        size_t k = ONES * c;
    17b8:	00000517          	auipc	a0,0x0
    17bc:	60053503          	ld	a0,1536(a0) # 1db8 <sharedmem+0x5c>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    17c0:	471d                	li	a4,7
        size_t k = ONES * c;
    17c2:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    17c6:	02c77a63          	bgeu	a4,a2,17fa <memchr+0x6e>
    17ca:	00000897          	auipc	a7,0x0
    17ce:	5de8b883          	ld	a7,1502(a7) # 1da8 <sharedmem+0x4c>
    17d2:	00000817          	auipc	a6,0x0
    17d6:	5de83803          	ld	a6,1502(a6) # 1db0 <sharedmem+0x54>
    17da:	431d                	li	t1,7
    17dc:	a029                	j	17e6 <memchr+0x5a>
    17de:	1661                	addi	a2,a2,-8
    17e0:	07a1                	addi	a5,a5,8
    17e2:	02c37963          	bgeu	t1,a2,1814 <memchr+0x88>
    17e6:	6398                	ld	a4,0(a5)
    17e8:	8f29                	xor	a4,a4,a0
    17ea:	011706b3          	add	a3,a4,a7
    17ee:	fff74713          	not	a4,a4
    17f2:	8f75                	and	a4,a4,a3
    17f4:	01077733          	and	a4,a4,a6
    17f8:	d37d                	beqz	a4,17de <memchr+0x52>
    17fa:	853e                	mv	a0,a5
    17fc:	97b2                	add	a5,a5,a2
    17fe:	a021                	j	1806 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1800:	0505                	addi	a0,a0,1
    1802:	00f50763          	beq	a0,a5,1810 <memchr+0x84>
    1806:	00054703          	lbu	a4,0(a0)
    180a:	feb71be3          	bne	a4,a1,1800 <memchr+0x74>
    180e:	8082                	ret
    return n ? (void*)s : 0;
    1810:	4501                	li	a0,0
}
    1812:	8082                	ret
    return n ? (void*)s : 0;
    1814:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1816:	f275                	bnez	a2,17fa <memchr+0x6e>
}
    1818:	8082                	ret

000000000000181a <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    181a:	1101                	addi	sp,sp,-32
    181c:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    181e:	862e                	mv	a2,a1
{
    1820:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1822:	4581                	li	a1,0
{
    1824:	e426                	sd	s1,8(sp)
    1826:	ec06                	sd	ra,24(sp)
    1828:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    182a:	f63ff0ef          	jal	ra,178c <memchr>
    return p ? p - s : n;
    182e:	c519                	beqz	a0,183c <strnlen+0x22>
}
    1830:	60e2                	ld	ra,24(sp)
    1832:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1834:	8d05                	sub	a0,a0,s1
}
    1836:	64a2                	ld	s1,8(sp)
    1838:	6105                	addi	sp,sp,32
    183a:	8082                	ret
    183c:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    183e:	8522                	mv	a0,s0
}
    1840:	6442                	ld	s0,16(sp)
    1842:	64a2                	ld	s1,8(sp)
    1844:	6105                	addi	sp,sp,32
    1846:	8082                	ret

0000000000001848 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1848:	00b547b3          	xor	a5,a0,a1
    184c:	8b9d                	andi	a5,a5,7
    184e:	eb95                	bnez	a5,1882 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1850:	0075f793          	andi	a5,a1,7
    1854:	e7b1                	bnez	a5,18a0 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1856:	6198                	ld	a4,0(a1)
    1858:	00000617          	auipc	a2,0x0
    185c:	55063603          	ld	a2,1360(a2) # 1da8 <sharedmem+0x4c>
    1860:	00000817          	auipc	a6,0x0
    1864:	55083803          	ld	a6,1360(a6) # 1db0 <sharedmem+0x54>
    1868:	a029                	j	1872 <stpcpy+0x2a>
    186a:	e118                	sd	a4,0(a0)
    186c:	6598                	ld	a4,8(a1)
    186e:	05a1                	addi	a1,a1,8
    1870:	0521                	addi	a0,a0,8
    1872:	00c707b3          	add	a5,a4,a2
    1876:	fff74693          	not	a3,a4
    187a:	8ff5                	and	a5,a5,a3
    187c:	0107f7b3          	and	a5,a5,a6
    1880:	d7ed                	beqz	a5,186a <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1882:	0005c783          	lbu	a5,0(a1)
    1886:	00f50023          	sb	a5,0(a0)
    188a:	c785                	beqz	a5,18b2 <stpcpy+0x6a>
    188c:	0015c783          	lbu	a5,1(a1)
    1890:	0505                	addi	a0,a0,1
    1892:	0585                	addi	a1,a1,1
    1894:	00f50023          	sb	a5,0(a0)
    1898:	fbf5                	bnez	a5,188c <stpcpy+0x44>
        ;
    return d;
}
    189a:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    189c:	0505                	addi	a0,a0,1
    189e:	df45                	beqz	a4,1856 <stpcpy+0xe>
            if (!(*d = *s))
    18a0:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    18a4:	0585                	addi	a1,a1,1
    18a6:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    18aa:	00f50023          	sb	a5,0(a0)
    18ae:	f7fd                	bnez	a5,189c <stpcpy+0x54>
}
    18b0:	8082                	ret
    18b2:	8082                	ret

00000000000018b4 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    18b4:	00b547b3          	xor	a5,a0,a1
    18b8:	8b9d                	andi	a5,a5,7
    18ba:	1a079863          	bnez	a5,1a6a <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    18be:	0075f793          	andi	a5,a1,7
    18c2:	16078463          	beqz	a5,1a2a <stpncpy+0x176>
    18c6:	ea01                	bnez	a2,18d6 <stpncpy+0x22>
    18c8:	a421                	j	1ad0 <stpncpy+0x21c>
    18ca:	167d                	addi	a2,a2,-1
    18cc:	0505                	addi	a0,a0,1
    18ce:	14070e63          	beqz	a4,1a2a <stpncpy+0x176>
    18d2:	1a060863          	beqz	a2,1a82 <stpncpy+0x1ce>
    18d6:	0005c783          	lbu	a5,0(a1)
    18da:	0585                	addi	a1,a1,1
    18dc:	0075f713          	andi	a4,a1,7
    18e0:	00f50023          	sb	a5,0(a0)
    18e4:	f3fd                	bnez	a5,18ca <stpncpy+0x16>
    18e6:	4805                	li	a6,1
    18e8:	1a061863          	bnez	a2,1a98 <stpncpy+0x1e4>
    18ec:	40a007b3          	neg	a5,a0
    18f0:	8b9d                	andi	a5,a5,7
    18f2:	4681                	li	a3,0
    18f4:	18061a63          	bnez	a2,1a88 <stpncpy+0x1d4>
    18f8:	00778713          	addi	a4,a5,7
    18fc:	45ad                	li	a1,11
    18fe:	18b76363          	bltu	a4,a1,1a84 <stpncpy+0x1d0>
    1902:	1ae6eb63          	bltu	a3,a4,1ab8 <stpncpy+0x204>
    1906:	1a078363          	beqz	a5,1aac <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    190a:	00050023          	sb	zero,0(a0)
    190e:	4685                	li	a3,1
    1910:	00150713          	addi	a4,a0,1
    1914:	18d78f63          	beq	a5,a3,1ab2 <stpncpy+0x1fe>
    1918:	000500a3          	sb	zero,1(a0)
    191c:	4689                	li	a3,2
    191e:	00250713          	addi	a4,a0,2
    1922:	18d78e63          	beq	a5,a3,1abe <stpncpy+0x20a>
    1926:	00050123          	sb	zero,2(a0)
    192a:	468d                	li	a3,3
    192c:	00350713          	addi	a4,a0,3
    1930:	16d78c63          	beq	a5,a3,1aa8 <stpncpy+0x1f4>
    1934:	000501a3          	sb	zero,3(a0)
    1938:	4691                	li	a3,4
    193a:	00450713          	addi	a4,a0,4
    193e:	18d78263          	beq	a5,a3,1ac2 <stpncpy+0x20e>
    1942:	00050223          	sb	zero,4(a0)
    1946:	4695                	li	a3,5
    1948:	00550713          	addi	a4,a0,5
    194c:	16d78d63          	beq	a5,a3,1ac6 <stpncpy+0x212>
    1950:	000502a3          	sb	zero,5(a0)
    1954:	469d                	li	a3,7
    1956:	00650713          	addi	a4,a0,6
    195a:	16d79863          	bne	a5,a3,1aca <stpncpy+0x216>
    195e:	00750713          	addi	a4,a0,7
    1962:	00050323          	sb	zero,6(a0)
    1966:	40f80833          	sub	a6,a6,a5
    196a:	ff887593          	andi	a1,a6,-8
    196e:	97aa                	add	a5,a5,a0
    1970:	95be                	add	a1,a1,a5
    1972:	0007b023          	sd	zero,0(a5)
    1976:	07a1                	addi	a5,a5,8
    1978:	feb79de3          	bne	a5,a1,1972 <stpncpy+0xbe>
    197c:	ff887593          	andi	a1,a6,-8
    1980:	9ead                	addw	a3,a3,a1
    1982:	00b707b3          	add	a5,a4,a1
    1986:	12b80863          	beq	a6,a1,1ab6 <stpncpy+0x202>
    198a:	00078023          	sb	zero,0(a5)
    198e:	0016871b          	addiw	a4,a3,1
    1992:	0ec77863          	bgeu	a4,a2,1a82 <stpncpy+0x1ce>
    1996:	000780a3          	sb	zero,1(a5)
    199a:	0026871b          	addiw	a4,a3,2
    199e:	0ec77263          	bgeu	a4,a2,1a82 <stpncpy+0x1ce>
    19a2:	00078123          	sb	zero,2(a5)
    19a6:	0036871b          	addiw	a4,a3,3
    19aa:	0cc77c63          	bgeu	a4,a2,1a82 <stpncpy+0x1ce>
    19ae:	000781a3          	sb	zero,3(a5)
    19b2:	0046871b          	addiw	a4,a3,4
    19b6:	0cc77663          	bgeu	a4,a2,1a82 <stpncpy+0x1ce>
    19ba:	00078223          	sb	zero,4(a5)
    19be:	0056871b          	addiw	a4,a3,5
    19c2:	0cc77063          	bgeu	a4,a2,1a82 <stpncpy+0x1ce>
    19c6:	000782a3          	sb	zero,5(a5)
    19ca:	0066871b          	addiw	a4,a3,6
    19ce:	0ac77a63          	bgeu	a4,a2,1a82 <stpncpy+0x1ce>
    19d2:	00078323          	sb	zero,6(a5)
    19d6:	0076871b          	addiw	a4,a3,7
    19da:	0ac77463          	bgeu	a4,a2,1a82 <stpncpy+0x1ce>
    19de:	000783a3          	sb	zero,7(a5)
    19e2:	0086871b          	addiw	a4,a3,8
    19e6:	08c77e63          	bgeu	a4,a2,1a82 <stpncpy+0x1ce>
    19ea:	00078423          	sb	zero,8(a5)
    19ee:	0096871b          	addiw	a4,a3,9
    19f2:	08c77863          	bgeu	a4,a2,1a82 <stpncpy+0x1ce>
    19f6:	000784a3          	sb	zero,9(a5)
    19fa:	00a6871b          	addiw	a4,a3,10
    19fe:	08c77263          	bgeu	a4,a2,1a82 <stpncpy+0x1ce>
    1a02:	00078523          	sb	zero,10(a5)
    1a06:	00b6871b          	addiw	a4,a3,11
    1a0a:	06c77c63          	bgeu	a4,a2,1a82 <stpncpy+0x1ce>
    1a0e:	000785a3          	sb	zero,11(a5)
    1a12:	00c6871b          	addiw	a4,a3,12
    1a16:	06c77663          	bgeu	a4,a2,1a82 <stpncpy+0x1ce>
    1a1a:	00078623          	sb	zero,12(a5)
    1a1e:	26b5                	addiw	a3,a3,13
    1a20:	06c6f163          	bgeu	a3,a2,1a82 <stpncpy+0x1ce>
    1a24:	000786a3          	sb	zero,13(a5)
    1a28:	8082                	ret
            ;
        if (!n || !*s)
    1a2a:	c645                	beqz	a2,1ad2 <stpncpy+0x21e>
    1a2c:	0005c783          	lbu	a5,0(a1)
    1a30:	ea078be3          	beqz	a5,18e6 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1a34:	479d                	li	a5,7
    1a36:	02c7ff63          	bgeu	a5,a2,1a74 <stpncpy+0x1c0>
    1a3a:	00000897          	auipc	a7,0x0
    1a3e:	36e8b883          	ld	a7,878(a7) # 1da8 <sharedmem+0x4c>
    1a42:	00000817          	auipc	a6,0x0
    1a46:	36e83803          	ld	a6,878(a6) # 1db0 <sharedmem+0x54>
    1a4a:	431d                	li	t1,7
    1a4c:	6198                	ld	a4,0(a1)
    1a4e:	011707b3          	add	a5,a4,a7
    1a52:	fff74693          	not	a3,a4
    1a56:	8ff5                	and	a5,a5,a3
    1a58:	0107f7b3          	and	a5,a5,a6
    1a5c:	ef81                	bnez	a5,1a74 <stpncpy+0x1c0>
            *wd = *ws;
    1a5e:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1a60:	1661                	addi	a2,a2,-8
    1a62:	05a1                	addi	a1,a1,8
    1a64:	0521                	addi	a0,a0,8
    1a66:	fec363e3          	bltu	t1,a2,1a4c <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1a6a:	e609                	bnez	a2,1a74 <stpncpy+0x1c0>
    1a6c:	a08d                	j	1ace <stpncpy+0x21a>
    1a6e:	167d                	addi	a2,a2,-1
    1a70:	0505                	addi	a0,a0,1
    1a72:	ca01                	beqz	a2,1a82 <stpncpy+0x1ce>
    1a74:	0005c783          	lbu	a5,0(a1)
    1a78:	0585                	addi	a1,a1,1
    1a7a:	00f50023          	sb	a5,0(a0)
    1a7e:	fbe5                	bnez	a5,1a6e <stpncpy+0x1ba>
        ;
tail:
    1a80:	b59d                	j	18e6 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1a82:	8082                	ret
    1a84:	472d                	li	a4,11
    1a86:	bdb5                	j	1902 <stpncpy+0x4e>
    1a88:	00778713          	addi	a4,a5,7
    1a8c:	45ad                	li	a1,11
    1a8e:	fff60693          	addi	a3,a2,-1
    1a92:	e6b778e3          	bgeu	a4,a1,1902 <stpncpy+0x4e>
    1a96:	b7fd                	j	1a84 <stpncpy+0x1d0>
    1a98:	40a007b3          	neg	a5,a0
    1a9c:	8832                	mv	a6,a2
    1a9e:	8b9d                	andi	a5,a5,7
    1aa0:	4681                	li	a3,0
    1aa2:	e4060be3          	beqz	a2,18f8 <stpncpy+0x44>
    1aa6:	b7cd                	j	1a88 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1aa8:	468d                	li	a3,3
    1aaa:	bd75                	j	1966 <stpncpy+0xb2>
    1aac:	872a                	mv	a4,a0
    1aae:	4681                	li	a3,0
    1ab0:	bd5d                	j	1966 <stpncpy+0xb2>
    1ab2:	4685                	li	a3,1
    1ab4:	bd4d                	j	1966 <stpncpy+0xb2>
    1ab6:	8082                	ret
    1ab8:	87aa                	mv	a5,a0
    1aba:	4681                	li	a3,0
    1abc:	b5f9                	j	198a <stpncpy+0xd6>
    1abe:	4689                	li	a3,2
    1ac0:	b55d                	j	1966 <stpncpy+0xb2>
    1ac2:	4691                	li	a3,4
    1ac4:	b54d                	j	1966 <stpncpy+0xb2>
    1ac6:	4695                	li	a3,5
    1ac8:	bd79                	j	1966 <stpncpy+0xb2>
    1aca:	4699                	li	a3,6
    1acc:	bd69                	j	1966 <stpncpy+0xb2>
    1ace:	8082                	ret
    1ad0:	8082                	ret
    1ad2:	8082                	ret

0000000000001ad4 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1ad4:	fff6071b          	addiw	a4,a2,-1
    1ad8:	0cb57063          	bgeu	a0,a1,1b98 <memmove+0xc4>
        while (n-- > 0)
    1adc:	0ec05063          	blez	a2,1bbc <memmove+0xe8>
    1ae0:	00750693          	addi	a3,a0,7
    1ae4:	8e8d                	sub	a3,a3,a1
    1ae6:	00b567b3          	or	a5,a0,a1
    1aea:	00f6b693          	sltiu	a3,a3,15
    1aee:	8b9d                	andi	a5,a5,7
    1af0:	0016c693          	xori	a3,a3,1
    1af4:	0017b793          	seqz	a5,a5
    1af8:	8ff5                	and	a5,a5,a3
    1afa:	c3f1                	beqz	a5,1bbe <memmove+0xea>
    1afc:	0007079b          	sext.w	a5,a4
    1b00:	46a5                	li	a3,9
    1b02:	0af6fe63          	bgeu	a3,a5,1bbe <memmove+0xea>
    1b06:	0036589b          	srliw	a7,a2,0x3
    1b0a:	088e                	slli	a7,a7,0x3
    1b0c:	2601                	sext.w	a2,a2
    1b0e:	87ae                	mv	a5,a1
    1b10:	86aa                	mv	a3,a0
    1b12:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1b14:	0007b803          	ld	a6,0(a5)
    1b18:	07a1                	addi	a5,a5,8
    1b1a:	06a1                	addi	a3,a3,8
    1b1c:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1b20:	ff179ae3          	bne	a5,a7,1b14 <memmove+0x40>
    1b24:	ff867813          	andi	a6,a2,-8
    1b28:	02081793          	slli	a5,a6,0x20
    1b2c:	9381                	srli	a5,a5,0x20
    1b2e:	00f506b3          	add	a3,a0,a5
    1b32:	95be                	add	a1,a1,a5
    1b34:	4107073b          	subw	a4,a4,a6
    1b38:	09060263          	beq	a2,a6,1bbc <memmove+0xe8>
            *dst++ = *src++;
    1b3c:	0005c783          	lbu	a5,0(a1)
    1b40:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1b44:	06e05c63          	blez	a4,1bbc <memmove+0xe8>
            *dst++ = *src++;
    1b48:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1b4c:	4785                	li	a5,1
            *dst++ = *src++;
    1b4e:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1b52:	06e7d563          	bge	a5,a4,1bbc <memmove+0xe8>
            *dst++ = *src++;
    1b56:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1b5a:	4789                	li	a5,2
            *dst++ = *src++;
    1b5c:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1b60:	04e7de63          	bge	a5,a4,1bbc <memmove+0xe8>
            *dst++ = *src++;
    1b64:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1b68:	478d                	li	a5,3
            *dst++ = *src++;
    1b6a:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1b6e:	04e7d763          	bge	a5,a4,1bbc <memmove+0xe8>
            *dst++ = *src++;
    1b72:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1b76:	4791                	li	a5,4
            *dst++ = *src++;
    1b78:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1b7c:	04e7d063          	bge	a5,a4,1bbc <memmove+0xe8>
            *dst++ = *src++;
    1b80:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1b84:	4795                	li	a5,5
            *dst++ = *src++;
    1b86:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1b8a:	02e7d963          	bge	a5,a4,1bbc <memmove+0xe8>
            *dst++ = *src++;
    1b8e:	0065c783          	lbu	a5,6(a1)
    1b92:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1b96:	8082                	ret
    } else {
        dst += n;
    1b98:	00c507b3          	add	a5,a0,a2
        src += n;
    1b9c:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1b9e:	00c05f63          	blez	a2,1bbc <memmove+0xe8>
    1ba2:	1702                	slli	a4,a4,0x20
    1ba4:	9301                	srli	a4,a4,0x20
    1ba6:	fff74713          	not	a4,a4
    1baa:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1bac:	fff5c683          	lbu	a3,-1(a1)
    1bb0:	17fd                	addi	a5,a5,-1
    1bb2:	15fd                	addi	a1,a1,-1
    1bb4:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1bb8:	fee79ae3          	bne	a5,a4,1bac <memmove+0xd8>
    }
    return vdst;
}
    1bbc:	8082                	ret
    1bbe:	02071693          	slli	a3,a4,0x20
    1bc2:	9281                	srli	a3,a3,0x20
    1bc4:	0685                	addi	a3,a3,1
    1bc6:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1bc8:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1bca:	0005c703          	lbu	a4,0(a1)
    1bce:	0585                	addi	a1,a1,1
    1bd0:	0785                	addi	a5,a5,1
    1bd2:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1bd6:	fed59ae3          	bne	a1,a3,1bca <memmove+0xf6>
    1bda:	8082                	ret

0000000000001bdc <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1bdc:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1be0:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1be4:	2501                	sext.w	a0,a0
    1be6:	8082                	ret

0000000000001be8 <exec>:
    register long a7 __asm__("a7") = n;
    1be8:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1bec:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1bee:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1bf2:	2501                	sext.w	a0,a0
    1bf4:	8082                	ret

0000000000001bf6 <exit>:
    register long a7 __asm__("a7") = n;
    1bf6:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1bfa:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1bfe:	8082                	ret

0000000000001c00 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1c00:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c04:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1c08:	8082                	ret

0000000000001c0a <write>:
    register long a7 __asm__("a7") = n;
    1c0a:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c0e:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1c12:	8082                	ret

0000000000001c14 <getpid>:
    register long a7 __asm__("a7") = n;
    1c14:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c18:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c1c:	2501                	sext.w	a0,a0
    1c1e:	8082                	ret

0000000000001c20 <getppid>:
    register long a7 __asm__("a7") = n;
    1c20:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c24:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c28:	2501                	sext.w	a0,a0
    1c2a:	8082                	ret

0000000000001c2c <open>:
    register long a7 __asm__("a7") = n;
    1c2c:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c30:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1c34:	2501                	sext.w	a0,a0
    1c36:	8082                	ret

0000000000001c38 <mknod>:
    register long a7 __asm__("a7") = n;
    1c38:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c3c:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1c40:	2501                	sext.w	a0,a0
    1c42:	8082                	ret

0000000000001c44 <dup>:
    register long a7 __asm__("a7") = n;
    1c44:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1c46:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1c4a:	2501                	sext.w	a0,a0
    1c4c:	8082                	ret

0000000000001c4e <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c4e:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c52:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c56:	2501                	sext.w	a0,a0
    1c58:	8082                	ret

0000000000001c5a <waitpid>:
    register long a7 __asm__("a7") = n;
    1c5a:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c5e:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1c62:	2501                	sext.w	a0,a0
    1c64:	8082                	ret

0000000000001c66 <wait>:

pid_t wait(int *wstatus)
{
    1c66:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1c68:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1c6c:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c6e:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1c72:	2501                	sext.w	a0,a0
    1c74:	8082                	ret

0000000000001c76 <mkdir>:
    register long a7 __asm__("a7") = n;
    1c76:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1c7a:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1c7e:	2501                	sext.w	a0,a0
    1c80:	8082                	ret

0000000000001c82 <close>:
    register long a7 __asm__("a7") = n;
    1c82:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c86:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c8a:	2501                	sext.w	a0,a0
    1c8c:	8082                	ret

0000000000001c8e <fork>:
    register long a7 __asm__("a7") = n;
    1c8e:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1c92:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1c96:	2501                	sext.w	a0,a0
    1c98:	8082                	ret

0000000000001c9a <time_ms>:
    register long a7 __asm__("a7") = n;
    1c9a:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c9e:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1ca2:	8082                	ret

0000000000001ca4 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1ca4:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1ca6:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1caa:	00000073          	ecall
    1cae:	87aa                	mv	a5,a0
    1cb0:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1cb4:	97ba                	add	a5,a5,a4
    1cb6:	00f57c63          	bgeu	a0,a5,1cce <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1cba:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cbe:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1cc2:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1cc6:	00000073          	ecall
    1cca:	fef568e3          	bltu	a0,a5,1cba <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1cce:	4501                	li	a0,0
    1cd0:	8082                	ret

0000000000001cd2 <pipe>:
    register long a7 __asm__("a7") = n;
    1cd2:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1cd6:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1cda:	2501                	sext.w	a0,a0
    1cdc:	8082                	ret

0000000000001cde <fstat>:
    register long a7 __asm__("a7") = n;
    1cde:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ce2:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1ce6:	2501                	sext.w	a0,a0
    1ce8:	8082                	ret

0000000000001cea <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1cea:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1cec:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1cf0:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cf2:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1cf6:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1cfa:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1cfe:	0206c163          	bltz	a3,1d20 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1d02:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1d06:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1d08:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d0a:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d0e:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1d12:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1d16:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1d18:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1d1c:	853e                	mv	a0,a5
    1d1e:	8082                	ret
        return -1;
    1d20:	57fd                	li	a5,-1
    1d22:	bfed                	j	1d1c <stat+0x32>

0000000000001d24 <chdir>:
    register long a7 __asm__("a7") = n;
    1d24:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1d28:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1d2c:	2501                	sext.w	a0,a0
    1d2e:	8082                	ret

0000000000001d30 <link>:
    register long a7 __asm__("a7") = n;
    1d30:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d34:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1d38:	2501                	sext.w	a0,a0
    1d3a:	8082                	ret

0000000000001d3c <unlink>:
    register long a7 __asm__("a7") = n;
    1d3c:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1d40:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1d44:	2501                	sext.w	a0,a0
    1d46:	8082                	ret

0000000000001d48 <setpriority>:
    register long a7 __asm__("a7") = n;
    1d48:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d4c:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1d50:	8082                	ret

0000000000001d52 <getpriority>:
    register long a7 __asm__("a7") = n;
    1d52:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1d56:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1d5a:	8082                	ret

0000000000001d5c <sharedmem>:
    register long a7 __asm__("a7") = n;
    1d5c:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d60:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1d64:	8082                	ret
