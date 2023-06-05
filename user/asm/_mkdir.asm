
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_mkdir:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a08d                	j	1062 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <ucore.h>
#include <stdio.h>
int main(int argc, char *argv[])
{
    1002:	1101                	addi	sp,sp,-32
    1004:	ec06                	sd	ra,24(sp)
    1006:	e822                	sd	s0,16(sp)
    1008:	e426                	sd	s1,8(sp)
  int i;

  if (argc < 2)
    100a:	4785                	li	a5,1
    100c:	04a7d163          	bge	a5,a0,104e <main+0x4c>
    1010:	ffe5049b          	addiw	s1,a0,-2
    1014:	1482                	slli	s1,s1,0x20
    1016:	80f5                	srli	s1,s1,0x1d
    1018:	01058793          	addi	a5,a1,16
    101c:	00858413          	addi	s0,a1,8
    1020:	94be                	add	s1,s1,a5
    1022:	a021                	j	102a <main+0x28>
    1024:	0421                	addi	s0,s0,8
  {
    printf("Usage: makedir files...\n");
    exit(1);
  }

  for (i = 1; i < argc; i++)
    1026:	00940e63          	beq	s0,s1,1042 <main+0x40>
  {
    if (mkdir(argv[i]) < 0)
    102a:	6008                	ld	a0,0(s0)
    102c:	445000ef          	jal	ra,1c70 <mkdir>
    1030:	fe055ae3          	bgez	a0,1024 <main+0x22>
    {
      printf("makedir: %s failed to create\n", argv[i]);
    1034:	600c                	ld	a1,0(s0)
    1036:	00001517          	auipc	a0,0x1
    103a:	d4a50513          	addi	a0,a0,-694 # 1d80 <sharedmem+0x2a>
    103e:	0ba000ef          	jal	ra,10f8 <printf>
      break;
    }
  }

  return 0;
}
    1042:	60e2                	ld	ra,24(sp)
    1044:	6442                	ld	s0,16(sp)
    1046:	64a2                	ld	s1,8(sp)
    1048:	4501                	li	a0,0
    104a:	6105                	addi	sp,sp,32
    104c:	8082                	ret
    printf("Usage: makedir files...\n");
    104e:	00001517          	auipc	a0,0x1
    1052:	d1250513          	addi	a0,a0,-750 # 1d60 <sharedmem+0xa>
    1056:	0a2000ef          	jal	ra,10f8 <printf>
    exit(1);
    105a:	4505                	li	a0,1
    105c:	395000ef          	jal	ra,1bf0 <exit>
  for (i = 1; i < argc; i++)
    1060:	b7cd                	j	1042 <main+0x40>

0000000000001062 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1062:	1141                	addi	sp,sp,-16
    1064:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    1066:	f9dff0ef          	jal	ra,1002 <main>
}
    106a:	60a2                	ld	ra,8(sp)
    106c:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    106e:	3830006f          	j	1bf0 <exit>

0000000000001072 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    1072:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    1074:	00f10593          	addi	a1,sp,15
    1078:	4605                	li	a2,1
    107a:	4501                	li	a0,0
int getchar() {
    107c:	ec06                	sd	ra,24(sp)
    char byte = 0;
    107e:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1082:	379000ef          	jal	ra,1bfa <read>
    return byte;
}
    1086:	60e2                	ld	ra,24(sp)
    1088:	00f14503          	lbu	a0,15(sp)
    108c:	6105                	addi	sp,sp,32
    108e:	8082                	ret

0000000000001090 <putchar>:

int putchar(int c)
{
    1090:	1141                	addi	sp,sp,-16
    1092:	e406                	sd	ra,8(sp)
    1094:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    1096:	00001597          	auipc	a1,0x1
    109a:	d2a58593          	addi	a1,a1,-726 # 1dc0 <put.1156>
    return write(stdout, put, 1);
    109e:	4605                	li	a2,1
    10a0:	4505                	li	a0,1
    put[0] = c;
    10a2:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    10a6:	35f000ef          	jal	ra,1c04 <write>
}
    10aa:	60a2                	ld	ra,8(sp)
    10ac:	2501                	sext.w	a0,a0
    10ae:	0141                	addi	sp,sp,16
    10b0:	8082                	ret

00000000000010b2 <puts>:

int puts(const char* s)
{
    10b2:	1141                	addi	sp,sp,-16
    10b4:	e022                	sd	s0,0(sp)
    10b6:	e406                	sd	ra,8(sp)
    10b8:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    10ba:	66e000ef          	jal	ra,1728 <strlen>
    10be:	862a                	mv	a2,a0
    10c0:	85a2                	mv	a1,s0
    10c2:	4505                	li	a0,1
    10c4:	341000ef          	jal	ra,1c04 <write>
    10c8:	00055763          	bgez	a0,10d6 <puts+0x24>
    return r;
}
    10cc:	60a2                	ld	ra,8(sp)
    10ce:	6402                	ld	s0,0(sp)
    10d0:	557d                	li	a0,-1
    10d2:	0141                	addi	sp,sp,16
    10d4:	8082                	ret
    put[0] = c;
    10d6:	00001597          	auipc	a1,0x1
    10da:	cea58593          	addi	a1,a1,-790 # 1dc0 <put.1156>
    10de:	47a9                	li	a5,10
    return write(stdout, put, 1);
    10e0:	4605                	li	a2,1
    10e2:	4505                	li	a0,1
    put[0] = c;
    10e4:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    10e8:	31d000ef          	jal	ra,1c04 <write>
}
    10ec:	60a2                	ld	ra,8(sp)
    10ee:	6402                	ld	s0,0(sp)
    10f0:	41f5551b          	sraiw	a0,a0,0x1f
    10f4:	0141                	addi	sp,sp,16
    10f6:	8082                	ret

00000000000010f8 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    10f8:	7115                	addi	sp,sp,-224
    10fa:	ed06                	sd	ra,152(sp)
    10fc:	e922                	sd	s0,144(sp)
    10fe:	e526                	sd	s1,136(sp)
    1100:	e14a                	sd	s2,128(sp)
    1102:	fcce                	sd	s3,120(sp)
    1104:	f8d2                	sd	s4,112(sp)
    1106:	f4d6                	sd	s5,104(sp)
    1108:	f0da                	sd	s6,96(sp)
    110a:	ecde                	sd	s7,88(sp)
    110c:	e8e2                	sd	s8,80(sp)
    110e:	e4e6                	sd	s9,72(sp)
    1110:	e0ea                	sd	s10,64(sp)
    1112:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1114:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    1118:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    111a:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    111c:	f52e                	sd	a1,168(sp)
    111e:	f932                	sd	a2,176(sp)
    1120:	fd36                	sd	a3,184(sp)
    1122:	e1ba                	sd	a4,192(sp)
    1124:	e9c2                	sd	a6,208(sp)
    1126:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    1128:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    112a:	0c030b63          	beqz	t1,1200 <printf+0x108>
    112e:	8aaa                	mv	s5,a0
    1130:	0003071b          	sext.w	a4,t1
    1134:	4481                	li	s1,0
        if (c != '%') {
    1136:	02500b93          	li	s7,37
    put[0] = c;
    113a:	00001417          	auipc	s0,0x1
    113e:	c8640413          	addi	s0,s0,-890 # 1dc0 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    1142:	4c51                	li	s8,20
    put[0] = c;
    1144:	02500c93          	li	s9,37
    1148:	00001a17          	auipc	s4,0x1
    114c:	c80a0a13          	addi	s4,s4,-896 # 1dc8 <put.1156+0x8>
    1150:	00001997          	auipc	s3,0x1
    1154:	cd098993          	addi	s3,s3,-816 # 1e20 <digits>
    1158:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    115c:	0014879b          	addiw	a5,s1,1
    1160:	00fa8933          	add	s2,s5,a5
    1164:	13771163          	bne	a4,s7,1286 <printf+0x18e>
        c = fmt[++i] & 0xff;
    1168:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    116c:	080d0a63          	beqz	s10,1200 <printf+0x108>
        switch (c) {
    1170:	2489                	addiw	s1,s1,2
    1172:	009a8933          	add	s2,s5,s1
    1176:	257d0e63          	beq	s10,s7,13d2 <printf+0x2da>
    117a:	f9cd079b          	addiw	a5,s10,-100
    117e:	0ff7f793          	andi	a5,a5,255
    1182:	0cfc6263          	bltu	s8,a5,1246 <printf+0x14e>
    1186:	078a                	slli	a5,a5,0x2
    1188:	97d2                	add	a5,a5,s4
    118a:	439c                	lw	a5,0(a5)
    118c:	97d2                	add	a5,a5,s4
    118e:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    1190:	67a2                	ld	a5,8(sp)
    1192:	4398                	lw	a4,0(a5)
    1194:	07a1                	addi	a5,a5,8
    1196:	e43e                	sd	a5,8(sp)
    1198:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    119c:	26074663          	bltz	a4,1408 <printf+0x310>
        buf[i++] = digits[x % base];
    11a0:	8bbd                	andi	a5,a5,15
    11a2:	97ce                	add	a5,a5,s3
    11a4:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    11a8:	40475d1b          	sraiw	s10,a4,0x4
    11ac:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    11b0:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    11b4:	020d0163          	beqz	s10,11d6 <printf+0xde>
        buf[i++] = digits[x % base];
    11b8:	9d4e                	add	s10,s10,s3
    11ba:	000d4783          	lbu	a5,0(s10)
    11be:	4d05                	li	s10,1
    11c0:	00f108a3          	sb	a5,17(sp)
    if (sign)
    11c4:	00075963          	bgez	a4,11d6 <printf+0xde>
        buf[i++] = digits[x % base];
    11c8:	4d09                	li	s10,2
        buf[i++] = '-';
    11ca:	181c                	addi	a5,sp,48
    11cc:	02d00713          	li	a4,45
    11d0:	97ea                	add	a5,a5,s10
    11d2:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    11d6:	9d5a                	add	s10,s10,s6
    11d8:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    11dc:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    11e0:	4605                	li	a2,1
    11e2:	1d7d                	addi	s10,s10,-1
    11e4:	85a2                	mv	a1,s0
    11e6:	4505                	li	a0,1
    put[0] = c;
    11e8:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    11ec:	219000ef          	jal	ra,1c04 <write>
    while (--i >= 0)
    11f0:	ffbd16e3          	bne	s10,s11,11dc <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    11f4:	00094303          	lbu	t1,0(s2)
    11f8:	0003071b          	sext.w	a4,t1
    11fc:	f60310e3          	bnez	t1,115c <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    1200:	60ea                	ld	ra,152(sp)
    1202:	644a                	ld	s0,144(sp)
    1204:	64aa                	ld	s1,136(sp)
    1206:	690a                	ld	s2,128(sp)
    1208:	79e6                	ld	s3,120(sp)
    120a:	7a46                	ld	s4,112(sp)
    120c:	7aa6                	ld	s5,104(sp)
    120e:	7b06                	ld	s6,96(sp)
    1210:	6be6                	ld	s7,88(sp)
    1212:	6c46                	ld	s8,80(sp)
    1214:	6ca6                	ld	s9,72(sp)
    1216:	6d06                	ld	s10,64(sp)
    1218:	7de2                	ld	s11,56(sp)
    121a:	612d                	addi	sp,sp,224
    121c:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    121e:	67a2                	ld	a5,8(sp)
    1220:	0007bd03          	ld	s10,0(a5)
    1224:	07a1                	addi	a5,a5,8
    1226:	e43e                	sd	a5,8(sp)
    1228:	000d1b63          	bnez	s10,123e <printf+0x146>
    122c:	aafd                	j	142a <printf+0x332>
    return write(stdout, put, 1);
    122e:	4605                	li	a2,1
    1230:	85a2                	mv	a1,s0
    1232:	4505                	li	a0,1
                for (; *s; s++)
    1234:	0d05                	addi	s10,s10,1
    put[0] = c;
    1236:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    123a:	1cb000ef          	jal	ra,1c04 <write>
                for (; *s; s++)
    123e:	000d4783          	lbu	a5,0(s10)
    1242:	f7f5                	bnez	a5,122e <printf+0x136>
    1244:	a02d                	j	126e <printf+0x176>
    return write(stdout, put, 1);
    1246:	4605                	li	a2,1
    1248:	00001597          	auipc	a1,0x1
    124c:	b7858593          	addi	a1,a1,-1160 # 1dc0 <put.1156>
    1250:	4505                	li	a0,1
    put[0] = c;
    1252:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    1256:	1af000ef          	jal	ra,1c04 <write>
    125a:	4605                	li	a2,1
    125c:	00001597          	auipc	a1,0x1
    1260:	b6458593          	addi	a1,a1,-1180 # 1dc0 <put.1156>
    1264:	4505                	li	a0,1
    put[0] = c;
    1266:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    126a:	19b000ef          	jal	ra,1c04 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    126e:	00094303          	lbu	t1,0(s2)
    1272:	0003071b          	sext.w	a4,t1
    1276:	f80305e3          	beqz	t1,1200 <printf+0x108>
        if (c != '%') {
    127a:	0014879b          	addiw	a5,s1,1
    127e:	00fa8933          	add	s2,s5,a5
    1282:	ef7703e3          	beq	a4,s7,1168 <printf+0x70>
    return write(stdout, put, 1);
    1286:	4605                	li	a2,1
    1288:	00001597          	auipc	a1,0x1
    128c:	b3858593          	addi	a1,a1,-1224 # 1dc0 <put.1156>
    1290:	4505                	li	a0,1
    put[0] = c;
    1292:	00640023          	sb	t1,0(s0)
            continue;
    1296:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    1298:	16d000ef          	jal	ra,1c04 <write>
            continue;
    129c:	bfc9                	j	126e <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    129e:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    12a0:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    12a2:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    12a4:	0007b883          	ld	a7,0(a5)
    12a8:	07a1                	addi	a5,a5,8
    12aa:	e43e                	sd	a5,8(sp)
        x = -xx;
    12ac:	43f8d713          	srai	a4,a7,0x3f
    12b0:	011747b3          	xor	a5,a4,a7
    12b4:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    12b6:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    12b8:	02c7f733          	remu	a4,a5,a2
    12bc:	8d36                	mv	s10,a3
    12be:	0685                	addi	a3,a3,1
    12c0:	00db0533          	add	a0,s6,a3
    12c4:	85be                	mv	a1,a5
    12c6:	974e                	add	a4,a4,s3
    12c8:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    12cc:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    12d0:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    12d4:	feb862e3          	bltu	a6,a1,12b8 <printf+0x1c0>
    if (sign)
    12d8:	1208c063          	bltz	a7,13f8 <printf+0x300>
    while (--i >= 0)
    12dc:	9d5a                	add	s10,s10,s6
    put[0] = c;
    12de:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    12e2:	4605                	li	a2,1
    12e4:	85a2                	mv	a1,s0
    12e6:	4505                	li	a0,1
    put[0] = c;
    12e8:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    12ec:	119000ef          	jal	ra,1c04 <write>
    while (--i >= 0)
    12f0:	87ea                	mv	a5,s10
    12f2:	1d7d                	addi	s10,s10,-1
    12f4:	fefb15e3          	bne	s6,a5,12de <printf+0x1e6>
    12f8:	bf9d                	j	126e <printf+0x176>
                printptr(va_arg(ap, uint64));
    12fa:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    12fc:	4605                	li	a2,1
    12fe:	00001597          	auipc	a1,0x1
    1302:	ac258593          	addi	a1,a1,-1342 # 1dc0 <put.1156>
                printptr(va_arg(ap, uint64));
    1306:	0007bd83          	ld	s11,0(a5)
    130a:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    130e:	4505                	li	a0,1
    put[0] = c;
    1310:	03000793          	li	a5,48
    1314:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    1318:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    131a:	0eb000ef          	jal	ra,1c04 <write>
    put[0] = c;
    131e:	07800793          	li	a5,120
    return write(stdout, put, 1);
    1322:	4605                	li	a2,1
    1324:	00001597          	auipc	a1,0x1
    1328:	a9c58593          	addi	a1,a1,-1380 # 1dc0 <put.1156>
    132c:	4505                	li	a0,1
    put[0] = c;
    132e:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1332:	4d41                	li	s10,16
    1334:	0d1000ef          	jal	ra,1c04 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    1338:	03cdd793          	srli	a5,s11,0x3c
    133c:	97ce                	add	a5,a5,s3
    put[0] = c;
    133e:	0007c783          	lbu	a5,0(a5)
    1342:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    1344:	4605                	li	a2,1
    1346:	85a2                	mv	a1,s0
    1348:	4505                	li	a0,1
    put[0] = c;
    134a:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    134e:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1350:	0b5000ef          	jal	ra,1c04 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1354:	fe0d12e3          	bnez	s10,1338 <printf+0x240>
    1358:	bf19                	j	126e <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    135a:	67a2                	ld	a5,8(sp)
    135c:	4394                	lw	a3,0(a5)
    135e:	07a1                	addi	a5,a5,8
    1360:	e43e                	sd	a5,8(sp)
    1362:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    1366:	0006d663          	bgez	a3,1372 <printf+0x27a>
        x = -xx;
    136a:	40f007bb          	negw	a5,a5
    136e:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    1372:	4729                	li	a4,10
    1374:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    1378:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    137c:	964e                	add	a2,a2,s3
    137e:	00064603          	lbu	a2,0(a2)
    1382:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    1386:	0a0d0963          	beqz	s10,1438 <printf+0x340>
        buf[i++] = digits[x % base];
    138a:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    138e:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    1392:	00c98733          	add	a4,s3,a2
    1396:	00074703          	lbu	a4,0(a4)
    139a:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    139e:	c3cd                	beqz	a5,1440 <printf+0x348>
        buf[i++] = digits[x % base];
    13a0:	97ce                	add	a5,a5,s3
    13a2:	0007c703          	lbu	a4,0(a5)
    13a6:	4d09                	li	s10,2
    13a8:	478d                	li	a5,3
    13aa:	00e10923          	sb	a4,18(sp)
    if (sign)
    13ae:	0206cd63          	bltz	a3,13e8 <printf+0x2f0>
    while (--i >= 0)
    13b2:	9d5a                	add	s10,s10,s6
    13b4:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    13b8:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    13bc:	4605                	li	a2,1
    13be:	1d7d                	addi	s10,s10,-1
    13c0:	85a2                	mv	a1,s0
    13c2:	4505                	li	a0,1
    put[0] = c;
    13c4:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    13c8:	03d000ef          	jal	ra,1c04 <write>
    while (--i >= 0)
    13cc:	ffbd16e3          	bne	s10,s11,13b8 <printf+0x2c0>
    13d0:	bd79                	j	126e <printf+0x176>
    return write(stdout, put, 1);
    13d2:	4605                	li	a2,1
    13d4:	00001597          	auipc	a1,0x1
    13d8:	9ec58593          	addi	a1,a1,-1556 # 1dc0 <put.1156>
    13dc:	4505                	li	a0,1
    put[0] = c;
    13de:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    13e2:	023000ef          	jal	ra,1c04 <write>
    13e6:	b561                	j	126e <printf+0x176>
        buf[i++] = '-';
    13e8:	1818                	addi	a4,sp,48
    13ea:	973e                	add	a4,a4,a5
    13ec:	02d00693          	li	a3,45
    13f0:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    13f4:	8d3e                	mv	s10,a5
    13f6:	bf75                	j	13b2 <printf+0x2ba>
        buf[i++] = '-';
    13f8:	181c                	addi	a5,sp,48
    13fa:	97b6                	add	a5,a5,a3
    13fc:	02d00713          	li	a4,45
    1400:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    1404:	8d36                	mv	s10,a3
    1406:	bdd9                	j	12dc <printf+0x1e4>
        x = -xx;
    1408:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    140c:	00f7f693          	andi	a3,a5,15
    1410:	96ce                	add	a3,a3,s3
    1412:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    1416:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    141a:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    141e:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1422:	d80d1be3          	bnez	s10,11b8 <printf+0xc0>
        buf[i++] = digits[x % base];
    1426:	4d05                	li	s10,1
    1428:	b34d                	j	11ca <printf+0xd2>
                s = "(null)";
    142a:	00001d17          	auipc	s10,0x1
    142e:	976d0d13          	addi	s10,s10,-1674 # 1da0 <sharedmem+0x4a>
                for (; *s; s++)
    1432:	02800793          	li	a5,40
    1436:	bbe5                	j	122e <printf+0x136>
        buf[i++] = digits[x % base];
    1438:	4785                	li	a5,1
    if (sign)
    143a:	f606dce3          	bgez	a3,13b2 <printf+0x2ba>
    143e:	b76d                	j	13e8 <printf+0x2f0>
        buf[i++] = digits[x % base];
    1440:	4789                	li	a5,2
    1442:	4d05                	li	s10,1
    if (sign)
    1444:	f606d7e3          	bgez	a3,13b2 <printf+0x2ba>
    1448:	b745                	j	13e8 <printf+0x2f0>

000000000000144a <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    144a:	02000793          	li	a5,32
    144e:	00f50663          	beq	a0,a5,145a <isspace+0x10>
    1452:	355d                	addiw	a0,a0,-9
    1454:	00553513          	sltiu	a0,a0,5
    1458:	8082                	ret
    145a:	4505                	li	a0,1
}
    145c:	8082                	ret

000000000000145e <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    145e:	fd05051b          	addiw	a0,a0,-48
}
    1462:	00a53513          	sltiu	a0,a0,10
    1466:	8082                	ret

0000000000001468 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1468:	02000613          	li	a2,32
    146c:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    146e:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1472:	ff77069b          	addiw	a3,a4,-9
    1476:	04c70d63          	beq	a4,a2,14d0 <atoi+0x68>
    147a:	0007079b          	sext.w	a5,a4
    147e:	04d5f963          	bgeu	a1,a3,14d0 <atoi+0x68>
        s++;
    switch (*s) {
    1482:	02b00693          	li	a3,43
    1486:	04d70a63          	beq	a4,a3,14da <atoi+0x72>
    148a:	02d00693          	li	a3,45
    148e:	06d70463          	beq	a4,a3,14f6 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1492:	fd07859b          	addiw	a1,a5,-48
    1496:	4625                	li	a2,9
    1498:	873e                	mv	a4,a5
    149a:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    149c:	4e01                	li	t3,0
    while (isdigit(*s))
    149e:	04b66a63          	bltu	a2,a1,14f2 <atoi+0x8a>
    int n = 0, neg = 0;
    14a2:	4501                	li	a0,0
    while (isdigit(*s))
    14a4:	4825                	li	a6,9
    14a6:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    14aa:	0025179b          	slliw	a5,a0,0x2
    14ae:	9d3d                	addw	a0,a0,a5
    14b0:	fd07031b          	addiw	t1,a4,-48
    14b4:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    14b8:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    14bc:	0685                	addi	a3,a3,1
    14be:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    14c2:	0006071b          	sext.w	a4,a2
    14c6:	feb870e3          	bgeu	a6,a1,14a6 <atoi+0x3e>
    return neg ? n : -n;
    14ca:	000e0563          	beqz	t3,14d4 <atoi+0x6c>
}
    14ce:	8082                	ret
        s++;
    14d0:	0505                	addi	a0,a0,1
    14d2:	bf71                	j	146e <atoi+0x6>
    14d4:	4113053b          	subw	a0,t1,a7
    14d8:	8082                	ret
    while (isdigit(*s))
    14da:	00154783          	lbu	a5,1(a0)
    14de:	4625                	li	a2,9
        s++;
    14e0:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    14e4:	fd07859b          	addiw	a1,a5,-48
    14e8:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    14ec:	4e01                	li	t3,0
    while (isdigit(*s))
    14ee:	fab67ae3          	bgeu	a2,a1,14a2 <atoi+0x3a>
    14f2:	4501                	li	a0,0
}
    14f4:	8082                	ret
    while (isdigit(*s))
    14f6:	00154783          	lbu	a5,1(a0)
    14fa:	4625                	li	a2,9
        s++;
    14fc:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1500:	fd07859b          	addiw	a1,a5,-48
    1504:	0007871b          	sext.w	a4,a5
    1508:	feb665e3          	bltu	a2,a1,14f2 <atoi+0x8a>
        neg = 1;
    150c:	4e05                	li	t3,1
    150e:	bf51                	j	14a2 <atoi+0x3a>

0000000000001510 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    1510:	16060d63          	beqz	a2,168a <memset+0x17a>
    1514:	40a007b3          	neg	a5,a0
    1518:	8b9d                	andi	a5,a5,7
    151a:	00778713          	addi	a4,a5,7
    151e:	482d                	li	a6,11
    1520:	0ff5f593          	andi	a1,a1,255
    1524:	fff60693          	addi	a3,a2,-1
    1528:	17076263          	bltu	a4,a6,168c <memset+0x17c>
    152c:	16e6ea63          	bltu	a3,a4,16a0 <memset+0x190>
    1530:	16078563          	beqz	a5,169a <memset+0x18a>
    1534:	00b50023          	sb	a1,0(a0)
    1538:	4705                	li	a4,1
    153a:	00150e93          	addi	t4,a0,1
    153e:	14e78c63          	beq	a5,a4,1696 <memset+0x186>
    1542:	00b500a3          	sb	a1,1(a0)
    1546:	4709                	li	a4,2
    1548:	00250e93          	addi	t4,a0,2
    154c:	14e78d63          	beq	a5,a4,16a6 <memset+0x196>
    1550:	00b50123          	sb	a1,2(a0)
    1554:	470d                	li	a4,3
    1556:	00350e93          	addi	t4,a0,3
    155a:	12e78b63          	beq	a5,a4,1690 <memset+0x180>
    155e:	00b501a3          	sb	a1,3(a0)
    1562:	4711                	li	a4,4
    1564:	00450e93          	addi	t4,a0,4
    1568:	14e78163          	beq	a5,a4,16aa <memset+0x19a>
    156c:	00b50223          	sb	a1,4(a0)
    1570:	4715                	li	a4,5
    1572:	00550e93          	addi	t4,a0,5
    1576:	12e78c63          	beq	a5,a4,16ae <memset+0x19e>
    157a:	00b502a3          	sb	a1,5(a0)
    157e:	471d                	li	a4,7
    1580:	00650e93          	addi	t4,a0,6
    1584:	12e79763          	bne	a5,a4,16b2 <memset+0x1a2>
    1588:	00750e93          	addi	t4,a0,7
    158c:	00b50323          	sb	a1,6(a0)
    1590:	4f1d                	li	t5,7
    1592:	00859713          	slli	a4,a1,0x8
    1596:	8f4d                	or	a4,a4,a1
    1598:	01059e13          	slli	t3,a1,0x10
    159c:	01c76e33          	or	t3,a4,t3
    15a0:	01859313          	slli	t1,a1,0x18
    15a4:	006e6333          	or	t1,t3,t1
    15a8:	02059893          	slli	a7,a1,0x20
    15ac:	011368b3          	or	a7,t1,a7
    15b0:	02859813          	slli	a6,a1,0x28
    15b4:	40f60333          	sub	t1,a2,a5
    15b8:	0108e833          	or	a6,a7,a6
    15bc:	03059693          	slli	a3,a1,0x30
    15c0:	00d866b3          	or	a3,a6,a3
    15c4:	03859713          	slli	a4,a1,0x38
    15c8:	97aa                	add	a5,a5,a0
    15ca:	ff837813          	andi	a6,t1,-8
    15ce:	8f55                	or	a4,a4,a3
    15d0:	00f806b3          	add	a3,a6,a5
    15d4:	e398                	sd	a4,0(a5)
    15d6:	07a1                	addi	a5,a5,8
    15d8:	fed79ee3          	bne	a5,a3,15d4 <memset+0xc4>
    15dc:	ff837693          	andi	a3,t1,-8
    15e0:	00de87b3          	add	a5,t4,a3
    15e4:	01e6873b          	addw	a4,a3,t5
    15e8:	0ad30663          	beq	t1,a3,1694 <memset+0x184>
    15ec:	00b78023          	sb	a1,0(a5)
    15f0:	0017069b          	addiw	a3,a4,1
    15f4:	08c6fb63          	bgeu	a3,a2,168a <memset+0x17a>
    15f8:	00b780a3          	sb	a1,1(a5)
    15fc:	0027069b          	addiw	a3,a4,2
    1600:	08c6f563          	bgeu	a3,a2,168a <memset+0x17a>
    1604:	00b78123          	sb	a1,2(a5)
    1608:	0037069b          	addiw	a3,a4,3
    160c:	06c6ff63          	bgeu	a3,a2,168a <memset+0x17a>
    1610:	00b781a3          	sb	a1,3(a5)
    1614:	0047069b          	addiw	a3,a4,4
    1618:	06c6f963          	bgeu	a3,a2,168a <memset+0x17a>
    161c:	00b78223          	sb	a1,4(a5)
    1620:	0057069b          	addiw	a3,a4,5
    1624:	06c6f363          	bgeu	a3,a2,168a <memset+0x17a>
    1628:	00b782a3          	sb	a1,5(a5)
    162c:	0067069b          	addiw	a3,a4,6
    1630:	04c6fd63          	bgeu	a3,a2,168a <memset+0x17a>
    1634:	00b78323          	sb	a1,6(a5)
    1638:	0077069b          	addiw	a3,a4,7
    163c:	04c6f763          	bgeu	a3,a2,168a <memset+0x17a>
    1640:	00b783a3          	sb	a1,7(a5)
    1644:	0087069b          	addiw	a3,a4,8
    1648:	04c6f163          	bgeu	a3,a2,168a <memset+0x17a>
    164c:	00b78423          	sb	a1,8(a5)
    1650:	0097069b          	addiw	a3,a4,9
    1654:	02c6fb63          	bgeu	a3,a2,168a <memset+0x17a>
    1658:	00b784a3          	sb	a1,9(a5)
    165c:	00a7069b          	addiw	a3,a4,10
    1660:	02c6f563          	bgeu	a3,a2,168a <memset+0x17a>
    1664:	00b78523          	sb	a1,10(a5)
    1668:	00b7069b          	addiw	a3,a4,11
    166c:	00c6ff63          	bgeu	a3,a2,168a <memset+0x17a>
    1670:	00b785a3          	sb	a1,11(a5)
    1674:	00c7069b          	addiw	a3,a4,12
    1678:	00c6f963          	bgeu	a3,a2,168a <memset+0x17a>
    167c:	00b78623          	sb	a1,12(a5)
    1680:	2735                	addiw	a4,a4,13
    1682:	00c77463          	bgeu	a4,a2,168a <memset+0x17a>
    1686:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    168a:	8082                	ret
    168c:	472d                	li	a4,11
    168e:	bd79                	j	152c <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1690:	4f0d                	li	t5,3
    1692:	b701                	j	1592 <memset+0x82>
    1694:	8082                	ret
    1696:	4f05                	li	t5,1
    1698:	bded                	j	1592 <memset+0x82>
    169a:	8eaa                	mv	t4,a0
    169c:	4f01                	li	t5,0
    169e:	bdd5                	j	1592 <memset+0x82>
    16a0:	87aa                	mv	a5,a0
    16a2:	4701                	li	a4,0
    16a4:	b7a1                	j	15ec <memset+0xdc>
    16a6:	4f09                	li	t5,2
    16a8:	b5ed                	j	1592 <memset+0x82>
    16aa:	4f11                	li	t5,4
    16ac:	b5dd                	j	1592 <memset+0x82>
    16ae:	4f15                	li	t5,5
    16b0:	b5cd                	j	1592 <memset+0x82>
    16b2:	4f19                	li	t5,6
    16b4:	bdf9                	j	1592 <memset+0x82>

00000000000016b6 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    16b6:	00054783          	lbu	a5,0(a0)
    16ba:	0005c703          	lbu	a4,0(a1)
    16be:	00e79863          	bne	a5,a4,16ce <strcmp+0x18>
    16c2:	0505                	addi	a0,a0,1
    16c4:	0585                	addi	a1,a1,1
    16c6:	fbe5                	bnez	a5,16b6 <strcmp>
    16c8:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    16ca:	9d19                	subw	a0,a0,a4
    16cc:	8082                	ret
    16ce:	0007851b          	sext.w	a0,a5
    16d2:	bfe5                	j	16ca <strcmp+0x14>

00000000000016d4 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    16d4:	87aa                	mv	a5,a0
    16d6:	0005c703          	lbu	a4,0(a1)
    16da:	0785                	addi	a5,a5,1
    16dc:	0585                	addi	a1,a1,1
    16de:	fee78fa3          	sb	a4,-1(a5)
    16e2:	fb75                	bnez	a4,16d6 <strcpy+0x2>
        ;
    return os;
}
    16e4:	8082                	ret

00000000000016e6 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    16e6:	ce05                	beqz	a2,171e <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    16e8:	00054703          	lbu	a4,0(a0)
    16ec:	0005c783          	lbu	a5,0(a1)
    16f0:	cb0d                	beqz	a4,1722 <strncmp+0x3c>
    if (!n--)
    16f2:	167d                	addi	a2,a2,-1
    16f4:	00c506b3          	add	a3,a0,a2
    16f8:	a819                	j	170e <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    16fa:	00a68e63          	beq	a3,a0,1716 <strncmp+0x30>
    16fe:	0505                	addi	a0,a0,1
    1700:	00e79b63          	bne	a5,a4,1716 <strncmp+0x30>
    1704:	00054703          	lbu	a4,0(a0)
    1708:	0005c783          	lbu	a5,0(a1)
    170c:	cb19                	beqz	a4,1722 <strncmp+0x3c>
    170e:	0005c783          	lbu	a5,0(a1)
    1712:	0585                	addi	a1,a1,1
    1714:	f3fd                	bnez	a5,16fa <strncmp+0x14>
        ;
    return *l - *r;
    1716:	0007051b          	sext.w	a0,a4
    171a:	9d1d                	subw	a0,a0,a5
    171c:	8082                	ret
        return 0;
    171e:	4501                	li	a0,0
}
    1720:	8082                	ret
    1722:	4501                	li	a0,0
    return *l - *r;
    1724:	9d1d                	subw	a0,a0,a5
    1726:	8082                	ret

0000000000001728 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    1728:	00757793          	andi	a5,a0,7
    172c:	cf89                	beqz	a5,1746 <strlen+0x1e>
    172e:	87aa                	mv	a5,a0
    1730:	a029                	j	173a <strlen+0x12>
    1732:	0785                	addi	a5,a5,1
    1734:	0077f713          	andi	a4,a5,7
    1738:	cb01                	beqz	a4,1748 <strlen+0x20>
        if (!*s)
    173a:	0007c703          	lbu	a4,0(a5)
    173e:	fb75                	bnez	a4,1732 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1740:	40a78533          	sub	a0,a5,a0
}
    1744:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1746:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    1748:	6394                	ld	a3,0(a5)
    174a:	00000597          	auipc	a1,0x0
    174e:	65e5b583          	ld	a1,1630(a1) # 1da8 <sharedmem+0x52>
    1752:	00000617          	auipc	a2,0x0
    1756:	65e63603          	ld	a2,1630(a2) # 1db0 <sharedmem+0x5a>
    175a:	a019                	j	1760 <strlen+0x38>
    175c:	6794                	ld	a3,8(a5)
    175e:	07a1                	addi	a5,a5,8
    1760:	00b68733          	add	a4,a3,a1
    1764:	fff6c693          	not	a3,a3
    1768:	8f75                	and	a4,a4,a3
    176a:	8f71                	and	a4,a4,a2
    176c:	db65                	beqz	a4,175c <strlen+0x34>
    for (; *s; s++)
    176e:	0007c703          	lbu	a4,0(a5)
    1772:	d779                	beqz	a4,1740 <strlen+0x18>
    1774:	0017c703          	lbu	a4,1(a5)
    1778:	0785                	addi	a5,a5,1
    177a:	d379                	beqz	a4,1740 <strlen+0x18>
    177c:	0017c703          	lbu	a4,1(a5)
    1780:	0785                	addi	a5,a5,1
    1782:	fb6d                	bnez	a4,1774 <strlen+0x4c>
    1784:	bf75                	j	1740 <strlen+0x18>

0000000000001786 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1786:	00757713          	andi	a4,a0,7
{
    178a:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    178c:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1790:	cb19                	beqz	a4,17a6 <memchr+0x20>
    1792:	ce25                	beqz	a2,180a <memchr+0x84>
    1794:	0007c703          	lbu	a4,0(a5)
    1798:	04b70e63          	beq	a4,a1,17f4 <memchr+0x6e>
    179c:	0785                	addi	a5,a5,1
    179e:	0077f713          	andi	a4,a5,7
    17a2:	167d                	addi	a2,a2,-1
    17a4:	f77d                	bnez	a4,1792 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    17a6:	4501                	li	a0,0
    if (n && *s != c) {
    17a8:	c235                	beqz	a2,180c <memchr+0x86>
    17aa:	0007c703          	lbu	a4,0(a5)
    17ae:	04b70363          	beq	a4,a1,17f4 <memchr+0x6e>
        size_t k = ONES * c;
    17b2:	00000517          	auipc	a0,0x0
    17b6:	60653503          	ld	a0,1542(a0) # 1db8 <sharedmem+0x62>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    17ba:	471d                	li	a4,7
        size_t k = ONES * c;
    17bc:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    17c0:	02c77a63          	bgeu	a4,a2,17f4 <memchr+0x6e>
    17c4:	00000897          	auipc	a7,0x0
    17c8:	5e48b883          	ld	a7,1508(a7) # 1da8 <sharedmem+0x52>
    17cc:	00000817          	auipc	a6,0x0
    17d0:	5e483803          	ld	a6,1508(a6) # 1db0 <sharedmem+0x5a>
    17d4:	431d                	li	t1,7
    17d6:	a029                	j	17e0 <memchr+0x5a>
    17d8:	1661                	addi	a2,a2,-8
    17da:	07a1                	addi	a5,a5,8
    17dc:	02c37963          	bgeu	t1,a2,180e <memchr+0x88>
    17e0:	6398                	ld	a4,0(a5)
    17e2:	8f29                	xor	a4,a4,a0
    17e4:	011706b3          	add	a3,a4,a7
    17e8:	fff74713          	not	a4,a4
    17ec:	8f75                	and	a4,a4,a3
    17ee:	01077733          	and	a4,a4,a6
    17f2:	d37d                	beqz	a4,17d8 <memchr+0x52>
    17f4:	853e                	mv	a0,a5
    17f6:	97b2                	add	a5,a5,a2
    17f8:	a021                	j	1800 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    17fa:	0505                	addi	a0,a0,1
    17fc:	00f50763          	beq	a0,a5,180a <memchr+0x84>
    1800:	00054703          	lbu	a4,0(a0)
    1804:	feb71be3          	bne	a4,a1,17fa <memchr+0x74>
    1808:	8082                	ret
    return n ? (void*)s : 0;
    180a:	4501                	li	a0,0
}
    180c:	8082                	ret
    return n ? (void*)s : 0;
    180e:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1810:	f275                	bnez	a2,17f4 <memchr+0x6e>
}
    1812:	8082                	ret

0000000000001814 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1814:	1101                	addi	sp,sp,-32
    1816:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1818:	862e                	mv	a2,a1
{
    181a:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    181c:	4581                	li	a1,0
{
    181e:	e426                	sd	s1,8(sp)
    1820:	ec06                	sd	ra,24(sp)
    1822:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1824:	f63ff0ef          	jal	ra,1786 <memchr>
    return p ? p - s : n;
    1828:	c519                	beqz	a0,1836 <strnlen+0x22>
}
    182a:	60e2                	ld	ra,24(sp)
    182c:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    182e:	8d05                	sub	a0,a0,s1
}
    1830:	64a2                	ld	s1,8(sp)
    1832:	6105                	addi	sp,sp,32
    1834:	8082                	ret
    1836:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1838:	8522                	mv	a0,s0
}
    183a:	6442                	ld	s0,16(sp)
    183c:	64a2                	ld	s1,8(sp)
    183e:	6105                	addi	sp,sp,32
    1840:	8082                	ret

0000000000001842 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1842:	00b547b3          	xor	a5,a0,a1
    1846:	8b9d                	andi	a5,a5,7
    1848:	eb95                	bnez	a5,187c <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    184a:	0075f793          	andi	a5,a1,7
    184e:	e7b1                	bnez	a5,189a <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1850:	6198                	ld	a4,0(a1)
    1852:	00000617          	auipc	a2,0x0
    1856:	55663603          	ld	a2,1366(a2) # 1da8 <sharedmem+0x52>
    185a:	00000817          	auipc	a6,0x0
    185e:	55683803          	ld	a6,1366(a6) # 1db0 <sharedmem+0x5a>
    1862:	a029                	j	186c <stpcpy+0x2a>
    1864:	e118                	sd	a4,0(a0)
    1866:	6598                	ld	a4,8(a1)
    1868:	05a1                	addi	a1,a1,8
    186a:	0521                	addi	a0,a0,8
    186c:	00c707b3          	add	a5,a4,a2
    1870:	fff74693          	not	a3,a4
    1874:	8ff5                	and	a5,a5,a3
    1876:	0107f7b3          	and	a5,a5,a6
    187a:	d7ed                	beqz	a5,1864 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    187c:	0005c783          	lbu	a5,0(a1)
    1880:	00f50023          	sb	a5,0(a0)
    1884:	c785                	beqz	a5,18ac <stpcpy+0x6a>
    1886:	0015c783          	lbu	a5,1(a1)
    188a:	0505                	addi	a0,a0,1
    188c:	0585                	addi	a1,a1,1
    188e:	00f50023          	sb	a5,0(a0)
    1892:	fbf5                	bnez	a5,1886 <stpcpy+0x44>
        ;
    return d;
}
    1894:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1896:	0505                	addi	a0,a0,1
    1898:	df45                	beqz	a4,1850 <stpcpy+0xe>
            if (!(*d = *s))
    189a:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    189e:	0585                	addi	a1,a1,1
    18a0:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    18a4:	00f50023          	sb	a5,0(a0)
    18a8:	f7fd                	bnez	a5,1896 <stpcpy+0x54>
}
    18aa:	8082                	ret
    18ac:	8082                	ret

00000000000018ae <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    18ae:	00b547b3          	xor	a5,a0,a1
    18b2:	8b9d                	andi	a5,a5,7
    18b4:	1a079863          	bnez	a5,1a64 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    18b8:	0075f793          	andi	a5,a1,7
    18bc:	16078463          	beqz	a5,1a24 <stpncpy+0x176>
    18c0:	ea01                	bnez	a2,18d0 <stpncpy+0x22>
    18c2:	a421                	j	1aca <stpncpy+0x21c>
    18c4:	167d                	addi	a2,a2,-1
    18c6:	0505                	addi	a0,a0,1
    18c8:	14070e63          	beqz	a4,1a24 <stpncpy+0x176>
    18cc:	1a060863          	beqz	a2,1a7c <stpncpy+0x1ce>
    18d0:	0005c783          	lbu	a5,0(a1)
    18d4:	0585                	addi	a1,a1,1
    18d6:	0075f713          	andi	a4,a1,7
    18da:	00f50023          	sb	a5,0(a0)
    18de:	f3fd                	bnez	a5,18c4 <stpncpy+0x16>
    18e0:	4805                	li	a6,1
    18e2:	1a061863          	bnez	a2,1a92 <stpncpy+0x1e4>
    18e6:	40a007b3          	neg	a5,a0
    18ea:	8b9d                	andi	a5,a5,7
    18ec:	4681                	li	a3,0
    18ee:	18061a63          	bnez	a2,1a82 <stpncpy+0x1d4>
    18f2:	00778713          	addi	a4,a5,7
    18f6:	45ad                	li	a1,11
    18f8:	18b76363          	bltu	a4,a1,1a7e <stpncpy+0x1d0>
    18fc:	1ae6eb63          	bltu	a3,a4,1ab2 <stpncpy+0x204>
    1900:	1a078363          	beqz	a5,1aa6 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1904:	00050023          	sb	zero,0(a0)
    1908:	4685                	li	a3,1
    190a:	00150713          	addi	a4,a0,1
    190e:	18d78f63          	beq	a5,a3,1aac <stpncpy+0x1fe>
    1912:	000500a3          	sb	zero,1(a0)
    1916:	4689                	li	a3,2
    1918:	00250713          	addi	a4,a0,2
    191c:	18d78e63          	beq	a5,a3,1ab8 <stpncpy+0x20a>
    1920:	00050123          	sb	zero,2(a0)
    1924:	468d                	li	a3,3
    1926:	00350713          	addi	a4,a0,3
    192a:	16d78c63          	beq	a5,a3,1aa2 <stpncpy+0x1f4>
    192e:	000501a3          	sb	zero,3(a0)
    1932:	4691                	li	a3,4
    1934:	00450713          	addi	a4,a0,4
    1938:	18d78263          	beq	a5,a3,1abc <stpncpy+0x20e>
    193c:	00050223          	sb	zero,4(a0)
    1940:	4695                	li	a3,5
    1942:	00550713          	addi	a4,a0,5
    1946:	16d78d63          	beq	a5,a3,1ac0 <stpncpy+0x212>
    194a:	000502a3          	sb	zero,5(a0)
    194e:	469d                	li	a3,7
    1950:	00650713          	addi	a4,a0,6
    1954:	16d79863          	bne	a5,a3,1ac4 <stpncpy+0x216>
    1958:	00750713          	addi	a4,a0,7
    195c:	00050323          	sb	zero,6(a0)
    1960:	40f80833          	sub	a6,a6,a5
    1964:	ff887593          	andi	a1,a6,-8
    1968:	97aa                	add	a5,a5,a0
    196a:	95be                	add	a1,a1,a5
    196c:	0007b023          	sd	zero,0(a5)
    1970:	07a1                	addi	a5,a5,8
    1972:	feb79de3          	bne	a5,a1,196c <stpncpy+0xbe>
    1976:	ff887593          	andi	a1,a6,-8
    197a:	9ead                	addw	a3,a3,a1
    197c:	00b707b3          	add	a5,a4,a1
    1980:	12b80863          	beq	a6,a1,1ab0 <stpncpy+0x202>
    1984:	00078023          	sb	zero,0(a5)
    1988:	0016871b          	addiw	a4,a3,1
    198c:	0ec77863          	bgeu	a4,a2,1a7c <stpncpy+0x1ce>
    1990:	000780a3          	sb	zero,1(a5)
    1994:	0026871b          	addiw	a4,a3,2
    1998:	0ec77263          	bgeu	a4,a2,1a7c <stpncpy+0x1ce>
    199c:	00078123          	sb	zero,2(a5)
    19a0:	0036871b          	addiw	a4,a3,3
    19a4:	0cc77c63          	bgeu	a4,a2,1a7c <stpncpy+0x1ce>
    19a8:	000781a3          	sb	zero,3(a5)
    19ac:	0046871b          	addiw	a4,a3,4
    19b0:	0cc77663          	bgeu	a4,a2,1a7c <stpncpy+0x1ce>
    19b4:	00078223          	sb	zero,4(a5)
    19b8:	0056871b          	addiw	a4,a3,5
    19bc:	0cc77063          	bgeu	a4,a2,1a7c <stpncpy+0x1ce>
    19c0:	000782a3          	sb	zero,5(a5)
    19c4:	0066871b          	addiw	a4,a3,6
    19c8:	0ac77a63          	bgeu	a4,a2,1a7c <stpncpy+0x1ce>
    19cc:	00078323          	sb	zero,6(a5)
    19d0:	0076871b          	addiw	a4,a3,7
    19d4:	0ac77463          	bgeu	a4,a2,1a7c <stpncpy+0x1ce>
    19d8:	000783a3          	sb	zero,7(a5)
    19dc:	0086871b          	addiw	a4,a3,8
    19e0:	08c77e63          	bgeu	a4,a2,1a7c <stpncpy+0x1ce>
    19e4:	00078423          	sb	zero,8(a5)
    19e8:	0096871b          	addiw	a4,a3,9
    19ec:	08c77863          	bgeu	a4,a2,1a7c <stpncpy+0x1ce>
    19f0:	000784a3          	sb	zero,9(a5)
    19f4:	00a6871b          	addiw	a4,a3,10
    19f8:	08c77263          	bgeu	a4,a2,1a7c <stpncpy+0x1ce>
    19fc:	00078523          	sb	zero,10(a5)
    1a00:	00b6871b          	addiw	a4,a3,11
    1a04:	06c77c63          	bgeu	a4,a2,1a7c <stpncpy+0x1ce>
    1a08:	000785a3          	sb	zero,11(a5)
    1a0c:	00c6871b          	addiw	a4,a3,12
    1a10:	06c77663          	bgeu	a4,a2,1a7c <stpncpy+0x1ce>
    1a14:	00078623          	sb	zero,12(a5)
    1a18:	26b5                	addiw	a3,a3,13
    1a1a:	06c6f163          	bgeu	a3,a2,1a7c <stpncpy+0x1ce>
    1a1e:	000786a3          	sb	zero,13(a5)
    1a22:	8082                	ret
            ;
        if (!n || !*s)
    1a24:	c645                	beqz	a2,1acc <stpncpy+0x21e>
    1a26:	0005c783          	lbu	a5,0(a1)
    1a2a:	ea078be3          	beqz	a5,18e0 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1a2e:	479d                	li	a5,7
    1a30:	02c7ff63          	bgeu	a5,a2,1a6e <stpncpy+0x1c0>
    1a34:	00000897          	auipc	a7,0x0
    1a38:	3748b883          	ld	a7,884(a7) # 1da8 <sharedmem+0x52>
    1a3c:	00000817          	auipc	a6,0x0
    1a40:	37483803          	ld	a6,884(a6) # 1db0 <sharedmem+0x5a>
    1a44:	431d                	li	t1,7
    1a46:	6198                	ld	a4,0(a1)
    1a48:	011707b3          	add	a5,a4,a7
    1a4c:	fff74693          	not	a3,a4
    1a50:	8ff5                	and	a5,a5,a3
    1a52:	0107f7b3          	and	a5,a5,a6
    1a56:	ef81                	bnez	a5,1a6e <stpncpy+0x1c0>
            *wd = *ws;
    1a58:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1a5a:	1661                	addi	a2,a2,-8
    1a5c:	05a1                	addi	a1,a1,8
    1a5e:	0521                	addi	a0,a0,8
    1a60:	fec363e3          	bltu	t1,a2,1a46 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1a64:	e609                	bnez	a2,1a6e <stpncpy+0x1c0>
    1a66:	a08d                	j	1ac8 <stpncpy+0x21a>
    1a68:	167d                	addi	a2,a2,-1
    1a6a:	0505                	addi	a0,a0,1
    1a6c:	ca01                	beqz	a2,1a7c <stpncpy+0x1ce>
    1a6e:	0005c783          	lbu	a5,0(a1)
    1a72:	0585                	addi	a1,a1,1
    1a74:	00f50023          	sb	a5,0(a0)
    1a78:	fbe5                	bnez	a5,1a68 <stpncpy+0x1ba>
        ;
tail:
    1a7a:	b59d                	j	18e0 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1a7c:	8082                	ret
    1a7e:	472d                	li	a4,11
    1a80:	bdb5                	j	18fc <stpncpy+0x4e>
    1a82:	00778713          	addi	a4,a5,7
    1a86:	45ad                	li	a1,11
    1a88:	fff60693          	addi	a3,a2,-1
    1a8c:	e6b778e3          	bgeu	a4,a1,18fc <stpncpy+0x4e>
    1a90:	b7fd                	j	1a7e <stpncpy+0x1d0>
    1a92:	40a007b3          	neg	a5,a0
    1a96:	8832                	mv	a6,a2
    1a98:	8b9d                	andi	a5,a5,7
    1a9a:	4681                	li	a3,0
    1a9c:	e4060be3          	beqz	a2,18f2 <stpncpy+0x44>
    1aa0:	b7cd                	j	1a82 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1aa2:	468d                	li	a3,3
    1aa4:	bd75                	j	1960 <stpncpy+0xb2>
    1aa6:	872a                	mv	a4,a0
    1aa8:	4681                	li	a3,0
    1aaa:	bd5d                	j	1960 <stpncpy+0xb2>
    1aac:	4685                	li	a3,1
    1aae:	bd4d                	j	1960 <stpncpy+0xb2>
    1ab0:	8082                	ret
    1ab2:	87aa                	mv	a5,a0
    1ab4:	4681                	li	a3,0
    1ab6:	b5f9                	j	1984 <stpncpy+0xd6>
    1ab8:	4689                	li	a3,2
    1aba:	b55d                	j	1960 <stpncpy+0xb2>
    1abc:	4691                	li	a3,4
    1abe:	b54d                	j	1960 <stpncpy+0xb2>
    1ac0:	4695                	li	a3,5
    1ac2:	bd79                	j	1960 <stpncpy+0xb2>
    1ac4:	4699                	li	a3,6
    1ac6:	bd69                	j	1960 <stpncpy+0xb2>
    1ac8:	8082                	ret
    1aca:	8082                	ret
    1acc:	8082                	ret

0000000000001ace <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1ace:	fff6071b          	addiw	a4,a2,-1
    1ad2:	0cb57063          	bgeu	a0,a1,1b92 <memmove+0xc4>
        while (n-- > 0)
    1ad6:	0ec05063          	blez	a2,1bb6 <memmove+0xe8>
    1ada:	00750693          	addi	a3,a0,7
    1ade:	8e8d                	sub	a3,a3,a1
    1ae0:	00b567b3          	or	a5,a0,a1
    1ae4:	00f6b693          	sltiu	a3,a3,15
    1ae8:	8b9d                	andi	a5,a5,7
    1aea:	0016c693          	xori	a3,a3,1
    1aee:	0017b793          	seqz	a5,a5
    1af2:	8ff5                	and	a5,a5,a3
    1af4:	c3f1                	beqz	a5,1bb8 <memmove+0xea>
    1af6:	0007079b          	sext.w	a5,a4
    1afa:	46a5                	li	a3,9
    1afc:	0af6fe63          	bgeu	a3,a5,1bb8 <memmove+0xea>
    1b00:	0036589b          	srliw	a7,a2,0x3
    1b04:	088e                	slli	a7,a7,0x3
    1b06:	2601                	sext.w	a2,a2
    1b08:	87ae                	mv	a5,a1
    1b0a:	86aa                	mv	a3,a0
    1b0c:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1b0e:	0007b803          	ld	a6,0(a5)
    1b12:	07a1                	addi	a5,a5,8
    1b14:	06a1                	addi	a3,a3,8
    1b16:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1b1a:	ff179ae3          	bne	a5,a7,1b0e <memmove+0x40>
    1b1e:	ff867813          	andi	a6,a2,-8
    1b22:	02081793          	slli	a5,a6,0x20
    1b26:	9381                	srli	a5,a5,0x20
    1b28:	00f506b3          	add	a3,a0,a5
    1b2c:	95be                	add	a1,a1,a5
    1b2e:	4107073b          	subw	a4,a4,a6
    1b32:	09060263          	beq	a2,a6,1bb6 <memmove+0xe8>
            *dst++ = *src++;
    1b36:	0005c783          	lbu	a5,0(a1)
    1b3a:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1b3e:	06e05c63          	blez	a4,1bb6 <memmove+0xe8>
            *dst++ = *src++;
    1b42:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1b46:	4785                	li	a5,1
            *dst++ = *src++;
    1b48:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1b4c:	06e7d563          	bge	a5,a4,1bb6 <memmove+0xe8>
            *dst++ = *src++;
    1b50:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1b54:	4789                	li	a5,2
            *dst++ = *src++;
    1b56:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1b5a:	04e7de63          	bge	a5,a4,1bb6 <memmove+0xe8>
            *dst++ = *src++;
    1b5e:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1b62:	478d                	li	a5,3
            *dst++ = *src++;
    1b64:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1b68:	04e7d763          	bge	a5,a4,1bb6 <memmove+0xe8>
            *dst++ = *src++;
    1b6c:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1b70:	4791                	li	a5,4
            *dst++ = *src++;
    1b72:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1b76:	04e7d063          	bge	a5,a4,1bb6 <memmove+0xe8>
            *dst++ = *src++;
    1b7a:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1b7e:	4795                	li	a5,5
            *dst++ = *src++;
    1b80:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1b84:	02e7d963          	bge	a5,a4,1bb6 <memmove+0xe8>
            *dst++ = *src++;
    1b88:	0065c783          	lbu	a5,6(a1)
    1b8c:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1b90:	8082                	ret
    } else {
        dst += n;
    1b92:	00c507b3          	add	a5,a0,a2
        src += n;
    1b96:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1b98:	00c05f63          	blez	a2,1bb6 <memmove+0xe8>
    1b9c:	1702                	slli	a4,a4,0x20
    1b9e:	9301                	srli	a4,a4,0x20
    1ba0:	fff74713          	not	a4,a4
    1ba4:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1ba6:	fff5c683          	lbu	a3,-1(a1)
    1baa:	17fd                	addi	a5,a5,-1
    1bac:	15fd                	addi	a1,a1,-1
    1bae:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1bb2:	fee79ae3          	bne	a5,a4,1ba6 <memmove+0xd8>
    }
    return vdst;
}
    1bb6:	8082                	ret
    1bb8:	02071693          	slli	a3,a4,0x20
    1bbc:	9281                	srli	a3,a3,0x20
    1bbe:	0685                	addi	a3,a3,1
    1bc0:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1bc2:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1bc4:	0005c703          	lbu	a4,0(a1)
    1bc8:	0585                	addi	a1,a1,1
    1bca:	0785                	addi	a5,a5,1
    1bcc:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1bd0:	fed59ae3          	bne	a1,a3,1bc4 <memmove+0xf6>
    1bd4:	8082                	ret

0000000000001bd6 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1bd6:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1bda:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1bde:	2501                	sext.w	a0,a0
    1be0:	8082                	ret

0000000000001be2 <exec>:
    register long a7 __asm__("a7") = n;
    1be2:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1be6:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1be8:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1bec:	2501                	sext.w	a0,a0
    1bee:	8082                	ret

0000000000001bf0 <exit>:
    register long a7 __asm__("a7") = n;
    1bf0:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1bf4:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1bf8:	8082                	ret

0000000000001bfa <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1bfa:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1bfe:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1c02:	8082                	ret

0000000000001c04 <write>:
    register long a7 __asm__("a7") = n;
    1c04:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c08:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1c0c:	8082                	ret

0000000000001c0e <getpid>:
    register long a7 __asm__("a7") = n;
    1c0e:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c12:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c16:	2501                	sext.w	a0,a0
    1c18:	8082                	ret

0000000000001c1a <getppid>:
    register long a7 __asm__("a7") = n;
    1c1a:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c1e:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c22:	2501                	sext.w	a0,a0
    1c24:	8082                	ret

0000000000001c26 <open>:
    register long a7 __asm__("a7") = n;
    1c26:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c2a:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1c2e:	2501                	sext.w	a0,a0
    1c30:	8082                	ret

0000000000001c32 <mknod>:
    register long a7 __asm__("a7") = n;
    1c32:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c36:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1c3a:	2501                	sext.w	a0,a0
    1c3c:	8082                	ret

0000000000001c3e <dup>:
    register long a7 __asm__("a7") = n;
    1c3e:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1c40:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1c44:	2501                	sext.w	a0,a0
    1c46:	8082                	ret

0000000000001c48 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c48:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c4c:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c50:	2501                	sext.w	a0,a0
    1c52:	8082                	ret

0000000000001c54 <waitpid>:
    register long a7 __asm__("a7") = n;
    1c54:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c58:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1c5c:	2501                	sext.w	a0,a0
    1c5e:	8082                	ret

0000000000001c60 <wait>:

pid_t wait(int *wstatus)
{
    1c60:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1c62:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1c66:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c68:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1c6c:	2501                	sext.w	a0,a0
    1c6e:	8082                	ret

0000000000001c70 <mkdir>:
    register long a7 __asm__("a7") = n;
    1c70:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1c74:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1c78:	2501                	sext.w	a0,a0
    1c7a:	8082                	ret

0000000000001c7c <close>:
    register long a7 __asm__("a7") = n;
    1c7c:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c80:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c84:	2501                	sext.w	a0,a0
    1c86:	8082                	ret

0000000000001c88 <fork>:
    register long a7 __asm__("a7") = n;
    1c88:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1c8c:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1c90:	2501                	sext.w	a0,a0
    1c92:	8082                	ret

0000000000001c94 <time_ms>:
    register long a7 __asm__("a7") = n;
    1c94:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c98:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1c9c:	8082                	ret

0000000000001c9e <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1c9e:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1ca0:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1ca4:	00000073          	ecall
    1ca8:	87aa                	mv	a5,a0
    1caa:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1cae:	97ba                	add	a5,a5,a4
    1cb0:	00f57c63          	bgeu	a0,a5,1cc8 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1cb4:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cb8:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1cbc:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1cc0:	00000073          	ecall
    1cc4:	fef568e3          	bltu	a0,a5,1cb4 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1cc8:	4501                	li	a0,0
    1cca:	8082                	ret

0000000000001ccc <pipe>:
    register long a7 __asm__("a7") = n;
    1ccc:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1cd0:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1cd4:	2501                	sext.w	a0,a0
    1cd6:	8082                	ret

0000000000001cd8 <fstat>:
    register long a7 __asm__("a7") = n;
    1cd8:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cdc:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1ce0:	2501                	sext.w	a0,a0
    1ce2:	8082                	ret

0000000000001ce4 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1ce4:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1ce6:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1cea:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cec:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1cf0:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1cf4:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1cf8:	0206c163          	bltz	a3,1d1a <stat+0x36>
    register long a7 __asm__("a7") = n;
    1cfc:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1d00:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1d02:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d04:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d08:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1d0c:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1d10:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1d12:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1d16:	853e                	mv	a0,a5
    1d18:	8082                	ret
        return -1;
    1d1a:	57fd                	li	a5,-1
    1d1c:	bfed                	j	1d16 <stat+0x32>

0000000000001d1e <chdir>:
    register long a7 __asm__("a7") = n;
    1d1e:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1d22:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1d26:	2501                	sext.w	a0,a0
    1d28:	8082                	ret

0000000000001d2a <link>:
    register long a7 __asm__("a7") = n;
    1d2a:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d2e:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1d32:	2501                	sext.w	a0,a0
    1d34:	8082                	ret

0000000000001d36 <unlink>:
    register long a7 __asm__("a7") = n;
    1d36:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1d3a:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1d3e:	2501                	sext.w	a0,a0
    1d40:	8082                	ret

0000000000001d42 <setpriority>:
    register long a7 __asm__("a7") = n;
    1d42:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d46:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1d4a:	8082                	ret

0000000000001d4c <getpriority>:
    register long a7 __asm__("a7") = n;
    1d4c:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1d50:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1d54:	8082                	ret

0000000000001d56 <sharedmem>:
    register long a7 __asm__("a7") = n;
    1d56:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d5a:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1d5e:	8082                	ret
