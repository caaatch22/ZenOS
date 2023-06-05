
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_cat:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a251                	j	1184 <__start_main>

Disassembly of section .text:

0000000000001002 <cat>:

char buf[512];

void
cat(int fd)
{
    1002:	7179                	addi	sp,sp,-48
    1004:	ec26                	sd	s1,24(sp)
    1006:	e84a                	sd	s2,16(sp)
    1008:	e44e                	sd	s3,8(sp)
    100a:	f406                	sd	ra,40(sp)
    100c:	f022                	sd	s0,32(sp)
    100e:	892a                	mv	s2,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    1010:	00001497          	auipc	s1,0x1
    1014:	ee848493          	addi	s1,s1,-280 # 1ef8 <buf>
    if (write(1, buf, n) != n) {
      printf( "cat: write error\n");
    1018:	00001997          	auipc	s3,0x1
    101c:	e7098993          	addi	s3,s3,-400 # 1e88 <sharedmem+0x10>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    1020:	a029                	j	102a <cat+0x28>
    if (write(1, buf, n) != n) {
    1022:	505000ef          	jal	ra,1d26 <write>
    1026:	02851763          	bne	a0,s0,1054 <cat+0x52>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    102a:	20000613          	li	a2,512
    102e:	85a6                	mv	a1,s1
    1030:	854a                	mv	a0,s2
    1032:	4eb000ef          	jal	ra,1d1c <read>
    1036:	842a                	mv	s0,a0
    1038:	2401                	sext.w	s0,s0
    if (write(1, buf, n) != n) {
    103a:	85a6                	mv	a1,s1
    103c:	4505                	li	a0,1
    103e:	8622                	mv	a2,s0
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    1040:	fe8041e3          	bgtz	s0,1022 <cat+0x20>
      exit(1);
    }
  }
  if(n < 0){
    1044:	ec19                	bnez	s0,1062 <cat+0x60>
    printf( "cat: read error\n");
    exit(1);
  }
}
    1046:	70a2                	ld	ra,40(sp)
    1048:	7402                	ld	s0,32(sp)
    104a:	64e2                	ld	s1,24(sp)
    104c:	6942                	ld	s2,16(sp)
    104e:	69a2                	ld	s3,8(sp)
    1050:	6145                	addi	sp,sp,48
    1052:	8082                	ret
      printf( "cat: write error\n");
    1054:	854e                	mv	a0,s3
    1056:	1c4000ef          	jal	ra,121a <printf>
      exit(1);
    105a:	4505                	li	a0,1
    105c:	4b7000ef          	jal	ra,1d12 <exit>
    1060:	b7e9                	j	102a <cat+0x28>
    printf( "cat: read error\n");
    1062:	00001517          	auipc	a0,0x1
    1066:	e3e50513          	addi	a0,a0,-450 # 1ea0 <sharedmem+0x28>
    106a:	1b0000ef          	jal	ra,121a <printf>
}
    106e:	7402                	ld	s0,32(sp)
    1070:	70a2                	ld	ra,40(sp)
    1072:	64e2                	ld	s1,24(sp)
    1074:	6942                	ld	s2,16(sp)
    1076:	69a2                	ld	s3,8(sp)
    exit(1);
    1078:	4505                	li	a0,1
}
    107a:	6145                	addi	sp,sp,48
    exit(1);
    107c:	4970006f          	j	1d12 <exit>

0000000000001080 <main>:

int
main(int argc, char *argv[])
{
    1080:	715d                	addi	sp,sp,-80
    1082:	e486                	sd	ra,72(sp)
    1084:	e0a2                	sd	s0,64(sp)
    1086:	fc26                	sd	s1,56(sp)
    1088:	f84a                	sd	s2,48(sp)
    108a:	f44e                	sd	s3,40(sp)
    108c:	f052                	sd	s4,32(sp)
    108e:	ec56                	sd	s5,24(sp)
    1090:	e85a                	sd	s6,16(sp)
    1092:	e45e                	sd	s7,8(sp)
  int fd, i;

  if(argc <= 1){
    1094:	4785                	li	a5,1
    1096:	0ea7d063          	bge	a5,a0,1176 <main+0xf6>
    109a:	ffe50a1b          	addiw	s4,a0,-2
    109e:	1a02                	slli	s4,s4,0x20
    10a0:	01da5a13          	srli	s4,s4,0x1d
    10a4:	01058793          	addi	a5,a1,16
    10a8:	00858913          	addi	s2,a1,8
    10ac:	9a3e                	add	s4,s4,a5
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf( "cat: cannot open %s\n", argv[i]);
    10ae:	00001b97          	auipc	s7,0x1
    10b2:	e0ab8b93          	addi	s7,s7,-502 # 1eb8 <sharedmem+0x40>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    10b6:	00001997          	auipc	s3,0x1
    10ba:	e4298993          	addi	s3,s3,-446 # 1ef8 <buf>
      printf( "cat: write error\n");
    10be:	00001a97          	auipc	s5,0x1
    10c2:	dcaa8a93          	addi	s5,s5,-566 # 1e88 <sharedmem+0x10>
    printf( "cat: read error\n");
    10c6:	00001b17          	auipc	s6,0x1
    10ca:	ddab0b13          	addi	s6,s6,-550 # 1ea0 <sharedmem+0x28>
    if((fd = open(argv[i], 0)) < 0){
    10ce:	00093503          	ld	a0,0(s2)
    10d2:	4581                	li	a1,0
    10d4:	475000ef          	jal	ra,1d48 <open>
    10d8:	84aa                	mv	s1,a0
    10da:	00055763          	bgez	a0,10e8 <main+0x68>
    10de:	a059                	j	1164 <main+0xe4>
    if (write(1, buf, n) != n) {
    10e0:	447000ef          	jal	ra,1d26 <write>
    10e4:	04851563          	bne	a0,s0,112e <main+0xae>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    10e8:	20000613          	li	a2,512
    10ec:	85ce                	mv	a1,s3
    10ee:	8526                	mv	a0,s1
    10f0:	42d000ef          	jal	ra,1d1c <read>
    10f4:	842a                	mv	s0,a0
    10f6:	2401                	sext.w	s0,s0
    if (write(1, buf, n) != n) {
    10f8:	85ce                	mv	a1,s3
    10fa:	4505                	li	a0,1
    10fc:	8622                	mv	a2,s0
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    10fe:	fe8041e3          	bgtz	s0,10e0 <main+0x60>
  if(n < 0){
    1102:	ec0d                	bnez	s0,113c <main+0xbc>
      exit(1);
    }
    cat(fd);
    close(fd);
    1104:	0921                	addi	s2,s2,8
    1106:	8526                	mv	a0,s1
    1108:	497000ef          	jal	ra,1d9e <close>
  for(i = 1; i < argc; i++){
    110c:	fd2a11e3          	bne	s4,s2,10ce <main+0x4e>
  }
  exit(0);
    1110:	4501                	li	a0,0
    1112:	401000ef          	jal	ra,1d12 <exit>
}
    1116:	60a6                	ld	ra,72(sp)
    1118:	6406                	ld	s0,64(sp)
    111a:	74e2                	ld	s1,56(sp)
    111c:	7942                	ld	s2,48(sp)
    111e:	79a2                	ld	s3,40(sp)
    1120:	7a02                	ld	s4,32(sp)
    1122:	6ae2                	ld	s5,24(sp)
    1124:	6b42                	ld	s6,16(sp)
    1126:	6ba2                	ld	s7,8(sp)
    1128:	4501                	li	a0,0
    112a:	6161                	addi	sp,sp,80
    112c:	8082                	ret
      printf( "cat: write error\n");
    112e:	8556                	mv	a0,s5
    1130:	0ea000ef          	jal	ra,121a <printf>
      exit(1);
    1134:	4505                	li	a0,1
    1136:	3dd000ef          	jal	ra,1d12 <exit>
    113a:	b77d                	j	10e8 <main+0x68>
    printf( "cat: read error\n");
    113c:	855a                	mv	a0,s6
    113e:	0dc000ef          	jal	ra,121a <printf>
    exit(1);
    1142:	4505                	li	a0,1
    1144:	3cf000ef          	jal	ra,1d12 <exit>
    close(fd);
    1148:	0921                	addi	s2,s2,8
    114a:	8526                	mv	a0,s1
    114c:	453000ef          	jal	ra,1d9e <close>
  for(i = 1; i < argc; i++){
    1150:	fd4900e3          	beq	s2,s4,1110 <main+0x90>
    if((fd = open(argv[i], 0)) < 0){
    1154:	00093503          	ld	a0,0(s2)
    1158:	4581                	li	a1,0
    115a:	3ef000ef          	jal	ra,1d48 <open>
    115e:	84aa                	mv	s1,a0
    1160:	f80554e3          	bgez	a0,10e8 <main+0x68>
      printf( "cat: cannot open %s\n", argv[i]);
    1164:	00093583          	ld	a1,0(s2)
    1168:	855e                	mv	a0,s7
    116a:	0b0000ef          	jal	ra,121a <printf>
      exit(1);
    116e:	4505                	li	a0,1
    1170:	3a3000ef          	jal	ra,1d12 <exit>
    1174:	bf95                	j	10e8 <main+0x68>
    cat(0);
    1176:	4501                	li	a0,0
    1178:	e8bff0ef          	jal	ra,1002 <cat>
    exit(0);
    117c:	4501                	li	a0,0
    117e:	395000ef          	jal	ra,1d12 <exit>
  for(i = 1; i < argc; i++){
    1182:	b779                	j	1110 <main+0x90>

0000000000001184 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1184:	1141                	addi	sp,sp,-16
    1186:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    1188:	ef9ff0ef          	jal	ra,1080 <main>
}
    118c:	60a2                	ld	ra,8(sp)
    118e:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    1190:	3830006f          	j	1d12 <exit>

0000000000001194 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    1194:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    1196:	00f10593          	addi	a1,sp,15
    119a:	4605                	li	a2,1
    119c:	4501                	li	a0,0
int getchar() {
    119e:	ec06                	sd	ra,24(sp)
    char byte = 0;
    11a0:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    11a4:	379000ef          	jal	ra,1d1c <read>
    return byte;
}
    11a8:	60e2                	ld	ra,24(sp)
    11aa:	00f14503          	lbu	a0,15(sp)
    11ae:	6105                	addi	sp,sp,32
    11b0:	8082                	ret

00000000000011b2 <putchar>:

int putchar(int c)
{
    11b2:	1141                	addi	sp,sp,-16
    11b4:	e406                	sd	ra,8(sp)
    11b6:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    11b8:	00001597          	auipc	a1,0x1
    11bc:	d3858593          	addi	a1,a1,-712 # 1ef0 <put.1156>
    return write(stdout, put, 1);
    11c0:	4605                	li	a2,1
    11c2:	4505                	li	a0,1
    put[0] = c;
    11c4:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    11c8:	35f000ef          	jal	ra,1d26 <write>
}
    11cc:	60a2                	ld	ra,8(sp)
    11ce:	2501                	sext.w	a0,a0
    11d0:	0141                	addi	sp,sp,16
    11d2:	8082                	ret

00000000000011d4 <puts>:

int puts(const char* s)
{
    11d4:	1141                	addi	sp,sp,-16
    11d6:	e022                	sd	s0,0(sp)
    11d8:	e406                	sd	ra,8(sp)
    11da:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    11dc:	66e000ef          	jal	ra,184a <strlen>
    11e0:	862a                	mv	a2,a0
    11e2:	85a2                	mv	a1,s0
    11e4:	4505                	li	a0,1
    11e6:	341000ef          	jal	ra,1d26 <write>
    11ea:	00055763          	bgez	a0,11f8 <puts+0x24>
    return r;
}
    11ee:	60a2                	ld	ra,8(sp)
    11f0:	6402                	ld	s0,0(sp)
    11f2:	557d                	li	a0,-1
    11f4:	0141                	addi	sp,sp,16
    11f6:	8082                	ret
    put[0] = c;
    11f8:	00001597          	auipc	a1,0x1
    11fc:	cf858593          	addi	a1,a1,-776 # 1ef0 <put.1156>
    1200:	47a9                	li	a5,10
    return write(stdout, put, 1);
    1202:	4605                	li	a2,1
    1204:	4505                	li	a0,1
    put[0] = c;
    1206:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    120a:	31d000ef          	jal	ra,1d26 <write>
}
    120e:	60a2                	ld	ra,8(sp)
    1210:	6402                	ld	s0,0(sp)
    1212:	41f5551b          	sraiw	a0,a0,0x1f
    1216:	0141                	addi	sp,sp,16
    1218:	8082                	ret

000000000000121a <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    121a:	7115                	addi	sp,sp,-224
    121c:	ed06                	sd	ra,152(sp)
    121e:	e922                	sd	s0,144(sp)
    1220:	e526                	sd	s1,136(sp)
    1222:	e14a                	sd	s2,128(sp)
    1224:	fcce                	sd	s3,120(sp)
    1226:	f8d2                	sd	s4,112(sp)
    1228:	f4d6                	sd	s5,104(sp)
    122a:	f0da                	sd	s6,96(sp)
    122c:	ecde                	sd	s7,88(sp)
    122e:	e8e2                	sd	s8,80(sp)
    1230:	e4e6                	sd	s9,72(sp)
    1232:	e0ea                	sd	s10,64(sp)
    1234:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1236:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    123a:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    123c:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    123e:	f52e                	sd	a1,168(sp)
    1240:	f932                	sd	a2,176(sp)
    1242:	fd36                	sd	a3,184(sp)
    1244:	e1ba                	sd	a4,192(sp)
    1246:	e9c2                	sd	a6,208(sp)
    1248:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    124a:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    124c:	0c030b63          	beqz	t1,1322 <printf+0x108>
    1250:	8aaa                	mv	s5,a0
    1252:	0003071b          	sext.w	a4,t1
    1256:	4481                	li	s1,0
        if (c != '%') {
    1258:	02500b93          	li	s7,37
    put[0] = c;
    125c:	00001417          	auipc	s0,0x1
    1260:	c9440413          	addi	s0,s0,-876 # 1ef0 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    1264:	4c51                	li	s8,20
    put[0] = c;
    1266:	02500c93          	li	s9,37
    126a:	00001a17          	auipc	s4,0x1
    126e:	e8ea0a13          	addi	s4,s4,-370 # 20f8 <buf+0x200>
    1272:	00001997          	auipc	s3,0x1
    1276:	ede98993          	addi	s3,s3,-290 # 2150 <digits>
    127a:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    127e:	0014879b          	addiw	a5,s1,1
    1282:	00fa8933          	add	s2,s5,a5
    1286:	13771163          	bne	a4,s7,13a8 <printf+0x18e>
        c = fmt[++i] & 0xff;
    128a:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    128e:	080d0a63          	beqz	s10,1322 <printf+0x108>
        switch (c) {
    1292:	2489                	addiw	s1,s1,2
    1294:	009a8933          	add	s2,s5,s1
    1298:	257d0e63          	beq	s10,s7,14f4 <printf+0x2da>
    129c:	f9cd079b          	addiw	a5,s10,-100
    12a0:	0ff7f793          	andi	a5,a5,255
    12a4:	0cfc6263          	bltu	s8,a5,1368 <printf+0x14e>
    12a8:	078a                	slli	a5,a5,0x2
    12aa:	97d2                	add	a5,a5,s4
    12ac:	439c                	lw	a5,0(a5)
    12ae:	97d2                	add	a5,a5,s4
    12b0:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    12b2:	67a2                	ld	a5,8(sp)
    12b4:	4398                	lw	a4,0(a5)
    12b6:	07a1                	addi	a5,a5,8
    12b8:	e43e                	sd	a5,8(sp)
    12ba:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    12be:	26074663          	bltz	a4,152a <printf+0x310>
        buf[i++] = digits[x % base];
    12c2:	8bbd                	andi	a5,a5,15
    12c4:	97ce                	add	a5,a5,s3
    12c6:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    12ca:	40475d1b          	sraiw	s10,a4,0x4
    12ce:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    12d2:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    12d6:	020d0163          	beqz	s10,12f8 <printf+0xde>
        buf[i++] = digits[x % base];
    12da:	9d4e                	add	s10,s10,s3
    12dc:	000d4783          	lbu	a5,0(s10)
    12e0:	4d05                	li	s10,1
    12e2:	00f108a3          	sb	a5,17(sp)
    if (sign)
    12e6:	00075963          	bgez	a4,12f8 <printf+0xde>
        buf[i++] = digits[x % base];
    12ea:	4d09                	li	s10,2
        buf[i++] = '-';
    12ec:	181c                	addi	a5,sp,48
    12ee:	02d00713          	li	a4,45
    12f2:	97ea                	add	a5,a5,s10
    12f4:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    12f8:	9d5a                	add	s10,s10,s6
    12fa:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    12fe:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1302:	4605                	li	a2,1
    1304:	1d7d                	addi	s10,s10,-1
    1306:	85a2                	mv	a1,s0
    1308:	4505                	li	a0,1
    put[0] = c;
    130a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    130e:	219000ef          	jal	ra,1d26 <write>
    while (--i >= 0)
    1312:	ffbd16e3          	bne	s10,s11,12fe <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1316:	00094303          	lbu	t1,0(s2)
    131a:	0003071b          	sext.w	a4,t1
    131e:	f60310e3          	bnez	t1,127e <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    1322:	60ea                	ld	ra,152(sp)
    1324:	644a                	ld	s0,144(sp)
    1326:	64aa                	ld	s1,136(sp)
    1328:	690a                	ld	s2,128(sp)
    132a:	79e6                	ld	s3,120(sp)
    132c:	7a46                	ld	s4,112(sp)
    132e:	7aa6                	ld	s5,104(sp)
    1330:	7b06                	ld	s6,96(sp)
    1332:	6be6                	ld	s7,88(sp)
    1334:	6c46                	ld	s8,80(sp)
    1336:	6ca6                	ld	s9,72(sp)
    1338:	6d06                	ld	s10,64(sp)
    133a:	7de2                	ld	s11,56(sp)
    133c:	612d                	addi	sp,sp,224
    133e:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    1340:	67a2                	ld	a5,8(sp)
    1342:	0007bd03          	ld	s10,0(a5)
    1346:	07a1                	addi	a5,a5,8
    1348:	e43e                	sd	a5,8(sp)
    134a:	000d1b63          	bnez	s10,1360 <printf+0x146>
    134e:	aafd                	j	154c <printf+0x332>
    return write(stdout, put, 1);
    1350:	4605                	li	a2,1
    1352:	85a2                	mv	a1,s0
    1354:	4505                	li	a0,1
                for (; *s; s++)
    1356:	0d05                	addi	s10,s10,1
    put[0] = c;
    1358:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    135c:	1cb000ef          	jal	ra,1d26 <write>
                for (; *s; s++)
    1360:	000d4783          	lbu	a5,0(s10)
    1364:	f7f5                	bnez	a5,1350 <printf+0x136>
    1366:	a02d                	j	1390 <printf+0x176>
    return write(stdout, put, 1);
    1368:	4605                	li	a2,1
    136a:	00001597          	auipc	a1,0x1
    136e:	b8658593          	addi	a1,a1,-1146 # 1ef0 <put.1156>
    1372:	4505                	li	a0,1
    put[0] = c;
    1374:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    1378:	1af000ef          	jal	ra,1d26 <write>
    137c:	4605                	li	a2,1
    137e:	00001597          	auipc	a1,0x1
    1382:	b7258593          	addi	a1,a1,-1166 # 1ef0 <put.1156>
    1386:	4505                	li	a0,1
    put[0] = c;
    1388:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    138c:	19b000ef          	jal	ra,1d26 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1390:	00094303          	lbu	t1,0(s2)
    1394:	0003071b          	sext.w	a4,t1
    1398:	f80305e3          	beqz	t1,1322 <printf+0x108>
        if (c != '%') {
    139c:	0014879b          	addiw	a5,s1,1
    13a0:	00fa8933          	add	s2,s5,a5
    13a4:	ef7703e3          	beq	a4,s7,128a <printf+0x70>
    return write(stdout, put, 1);
    13a8:	4605                	li	a2,1
    13aa:	00001597          	auipc	a1,0x1
    13ae:	b4658593          	addi	a1,a1,-1210 # 1ef0 <put.1156>
    13b2:	4505                	li	a0,1
    put[0] = c;
    13b4:	00640023          	sb	t1,0(s0)
            continue;
    13b8:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    13ba:	16d000ef          	jal	ra,1d26 <write>
            continue;
    13be:	bfc9                	j	1390 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    13c0:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    13c2:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    13c4:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    13c6:	0007b883          	ld	a7,0(a5)
    13ca:	07a1                	addi	a5,a5,8
    13cc:	e43e                	sd	a5,8(sp)
        x = -xx;
    13ce:	43f8d713          	srai	a4,a7,0x3f
    13d2:	011747b3          	xor	a5,a4,a7
    13d6:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    13d8:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    13da:	02c7f733          	remu	a4,a5,a2
    13de:	8d36                	mv	s10,a3
    13e0:	0685                	addi	a3,a3,1
    13e2:	00db0533          	add	a0,s6,a3
    13e6:	85be                	mv	a1,a5
    13e8:	974e                	add	a4,a4,s3
    13ea:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    13ee:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    13f2:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    13f6:	feb862e3          	bltu	a6,a1,13da <printf+0x1c0>
    if (sign)
    13fa:	1208c063          	bltz	a7,151a <printf+0x300>
    while (--i >= 0)
    13fe:	9d5a                	add	s10,s10,s6
    put[0] = c;
    1400:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1404:	4605                	li	a2,1
    1406:	85a2                	mv	a1,s0
    1408:	4505                	li	a0,1
    put[0] = c;
    140a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    140e:	119000ef          	jal	ra,1d26 <write>
    while (--i >= 0)
    1412:	87ea                	mv	a5,s10
    1414:	1d7d                	addi	s10,s10,-1
    1416:	fefb15e3          	bne	s6,a5,1400 <printf+0x1e6>
    141a:	bf9d                	j	1390 <printf+0x176>
                printptr(va_arg(ap, uint64));
    141c:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    141e:	4605                	li	a2,1
    1420:	00001597          	auipc	a1,0x1
    1424:	ad058593          	addi	a1,a1,-1328 # 1ef0 <put.1156>
                printptr(va_arg(ap, uint64));
    1428:	0007bd83          	ld	s11,0(a5)
    142c:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    1430:	4505                	li	a0,1
    put[0] = c;
    1432:	03000793          	li	a5,48
    1436:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    143a:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    143c:	0eb000ef          	jal	ra,1d26 <write>
    put[0] = c;
    1440:	07800793          	li	a5,120
    return write(stdout, put, 1);
    1444:	4605                	li	a2,1
    1446:	00001597          	auipc	a1,0x1
    144a:	aaa58593          	addi	a1,a1,-1366 # 1ef0 <put.1156>
    144e:	4505                	li	a0,1
    put[0] = c;
    1450:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1454:	4d41                	li	s10,16
    1456:	0d1000ef          	jal	ra,1d26 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    145a:	03cdd793          	srli	a5,s11,0x3c
    145e:	97ce                	add	a5,a5,s3
    put[0] = c;
    1460:	0007c783          	lbu	a5,0(a5)
    1464:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    1466:	4605                	li	a2,1
    1468:	85a2                	mv	a1,s0
    146a:	4505                	li	a0,1
    put[0] = c;
    146c:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1470:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1472:	0b5000ef          	jal	ra,1d26 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1476:	fe0d12e3          	bnez	s10,145a <printf+0x240>
    147a:	bf19                	j	1390 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    147c:	67a2                	ld	a5,8(sp)
    147e:	4394                	lw	a3,0(a5)
    1480:	07a1                	addi	a5,a5,8
    1482:	e43e                	sd	a5,8(sp)
    1484:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    1488:	0006d663          	bgez	a3,1494 <printf+0x27a>
        x = -xx;
    148c:	40f007bb          	negw	a5,a5
    1490:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    1494:	4729                	li	a4,10
    1496:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    149a:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    149e:	964e                	add	a2,a2,s3
    14a0:	00064603          	lbu	a2,0(a2)
    14a4:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    14a8:	0a0d0963          	beqz	s10,155a <printf+0x340>
        buf[i++] = digits[x % base];
    14ac:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    14b0:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    14b4:	00c98733          	add	a4,s3,a2
    14b8:	00074703          	lbu	a4,0(a4)
    14bc:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    14c0:	c3cd                	beqz	a5,1562 <printf+0x348>
        buf[i++] = digits[x % base];
    14c2:	97ce                	add	a5,a5,s3
    14c4:	0007c703          	lbu	a4,0(a5)
    14c8:	4d09                	li	s10,2
    14ca:	478d                	li	a5,3
    14cc:	00e10923          	sb	a4,18(sp)
    if (sign)
    14d0:	0206cd63          	bltz	a3,150a <printf+0x2f0>
    while (--i >= 0)
    14d4:	9d5a                	add	s10,s10,s6
    14d6:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    14da:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    14de:	4605                	li	a2,1
    14e0:	1d7d                	addi	s10,s10,-1
    14e2:	85a2                	mv	a1,s0
    14e4:	4505                	li	a0,1
    put[0] = c;
    14e6:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    14ea:	03d000ef          	jal	ra,1d26 <write>
    while (--i >= 0)
    14ee:	ffbd16e3          	bne	s10,s11,14da <printf+0x2c0>
    14f2:	bd79                	j	1390 <printf+0x176>
    return write(stdout, put, 1);
    14f4:	4605                	li	a2,1
    14f6:	00001597          	auipc	a1,0x1
    14fa:	9fa58593          	addi	a1,a1,-1542 # 1ef0 <put.1156>
    14fe:	4505                	li	a0,1
    put[0] = c;
    1500:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    1504:	023000ef          	jal	ra,1d26 <write>
    1508:	b561                	j	1390 <printf+0x176>
        buf[i++] = '-';
    150a:	1818                	addi	a4,sp,48
    150c:	973e                	add	a4,a4,a5
    150e:	02d00693          	li	a3,45
    1512:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    1516:	8d3e                	mv	s10,a5
    1518:	bf75                	j	14d4 <printf+0x2ba>
        buf[i++] = '-';
    151a:	181c                	addi	a5,sp,48
    151c:	97b6                	add	a5,a5,a3
    151e:	02d00713          	li	a4,45
    1522:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    1526:	8d36                	mv	s10,a3
    1528:	bdd9                	j	13fe <printf+0x1e4>
        x = -xx;
    152a:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    152e:	00f7f693          	andi	a3,a5,15
    1532:	96ce                	add	a3,a3,s3
    1534:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    1538:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    153c:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    1540:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1544:	d80d1be3          	bnez	s10,12da <printf+0xc0>
        buf[i++] = digits[x % base];
    1548:	4d05                	li	s10,1
    154a:	b34d                	j	12ec <printf+0xd2>
                s = "(null)";
    154c:	00001d17          	auipc	s10,0x1
    1550:	984d0d13          	addi	s10,s10,-1660 # 1ed0 <sharedmem+0x58>
                for (; *s; s++)
    1554:	02800793          	li	a5,40
    1558:	bbe5                	j	1350 <printf+0x136>
        buf[i++] = digits[x % base];
    155a:	4785                	li	a5,1
    if (sign)
    155c:	f606dce3          	bgez	a3,14d4 <printf+0x2ba>
    1560:	b76d                	j	150a <printf+0x2f0>
        buf[i++] = digits[x % base];
    1562:	4789                	li	a5,2
    1564:	4d05                	li	s10,1
    if (sign)
    1566:	f606d7e3          	bgez	a3,14d4 <printf+0x2ba>
    156a:	b745                	j	150a <printf+0x2f0>

000000000000156c <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    156c:	02000793          	li	a5,32
    1570:	00f50663          	beq	a0,a5,157c <isspace+0x10>
    1574:	355d                	addiw	a0,a0,-9
    1576:	00553513          	sltiu	a0,a0,5
    157a:	8082                	ret
    157c:	4505                	li	a0,1
}
    157e:	8082                	ret

0000000000001580 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1580:	fd05051b          	addiw	a0,a0,-48
}
    1584:	00a53513          	sltiu	a0,a0,10
    1588:	8082                	ret

000000000000158a <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    158a:	02000613          	li	a2,32
    158e:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1590:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1594:	ff77069b          	addiw	a3,a4,-9
    1598:	04c70d63          	beq	a4,a2,15f2 <atoi+0x68>
    159c:	0007079b          	sext.w	a5,a4
    15a0:	04d5f963          	bgeu	a1,a3,15f2 <atoi+0x68>
        s++;
    switch (*s) {
    15a4:	02b00693          	li	a3,43
    15a8:	04d70a63          	beq	a4,a3,15fc <atoi+0x72>
    15ac:	02d00693          	li	a3,45
    15b0:	06d70463          	beq	a4,a3,1618 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    15b4:	fd07859b          	addiw	a1,a5,-48
    15b8:	4625                	li	a2,9
    15ba:	873e                	mv	a4,a5
    15bc:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    15be:	4e01                	li	t3,0
    while (isdigit(*s))
    15c0:	04b66a63          	bltu	a2,a1,1614 <atoi+0x8a>
    int n = 0, neg = 0;
    15c4:	4501                	li	a0,0
    while (isdigit(*s))
    15c6:	4825                	li	a6,9
    15c8:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    15cc:	0025179b          	slliw	a5,a0,0x2
    15d0:	9d3d                	addw	a0,a0,a5
    15d2:	fd07031b          	addiw	t1,a4,-48
    15d6:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    15da:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    15de:	0685                	addi	a3,a3,1
    15e0:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    15e4:	0006071b          	sext.w	a4,a2
    15e8:	feb870e3          	bgeu	a6,a1,15c8 <atoi+0x3e>
    return neg ? n : -n;
    15ec:	000e0563          	beqz	t3,15f6 <atoi+0x6c>
}
    15f0:	8082                	ret
        s++;
    15f2:	0505                	addi	a0,a0,1
    15f4:	bf71                	j	1590 <atoi+0x6>
    15f6:	4113053b          	subw	a0,t1,a7
    15fa:	8082                	ret
    while (isdigit(*s))
    15fc:	00154783          	lbu	a5,1(a0)
    1600:	4625                	li	a2,9
        s++;
    1602:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1606:	fd07859b          	addiw	a1,a5,-48
    160a:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    160e:	4e01                	li	t3,0
    while (isdigit(*s))
    1610:	fab67ae3          	bgeu	a2,a1,15c4 <atoi+0x3a>
    1614:	4501                	li	a0,0
}
    1616:	8082                	ret
    while (isdigit(*s))
    1618:	00154783          	lbu	a5,1(a0)
    161c:	4625                	li	a2,9
        s++;
    161e:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1622:	fd07859b          	addiw	a1,a5,-48
    1626:	0007871b          	sext.w	a4,a5
    162a:	feb665e3          	bltu	a2,a1,1614 <atoi+0x8a>
        neg = 1;
    162e:	4e05                	li	t3,1
    1630:	bf51                	j	15c4 <atoi+0x3a>

0000000000001632 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    1632:	16060d63          	beqz	a2,17ac <memset+0x17a>
    1636:	40a007b3          	neg	a5,a0
    163a:	8b9d                	andi	a5,a5,7
    163c:	00778713          	addi	a4,a5,7
    1640:	482d                	li	a6,11
    1642:	0ff5f593          	andi	a1,a1,255
    1646:	fff60693          	addi	a3,a2,-1
    164a:	17076263          	bltu	a4,a6,17ae <memset+0x17c>
    164e:	16e6ea63          	bltu	a3,a4,17c2 <memset+0x190>
    1652:	16078563          	beqz	a5,17bc <memset+0x18a>
    1656:	00b50023          	sb	a1,0(a0)
    165a:	4705                	li	a4,1
    165c:	00150e93          	addi	t4,a0,1
    1660:	14e78c63          	beq	a5,a4,17b8 <memset+0x186>
    1664:	00b500a3          	sb	a1,1(a0)
    1668:	4709                	li	a4,2
    166a:	00250e93          	addi	t4,a0,2
    166e:	14e78d63          	beq	a5,a4,17c8 <memset+0x196>
    1672:	00b50123          	sb	a1,2(a0)
    1676:	470d                	li	a4,3
    1678:	00350e93          	addi	t4,a0,3
    167c:	12e78b63          	beq	a5,a4,17b2 <memset+0x180>
    1680:	00b501a3          	sb	a1,3(a0)
    1684:	4711                	li	a4,4
    1686:	00450e93          	addi	t4,a0,4
    168a:	14e78163          	beq	a5,a4,17cc <memset+0x19a>
    168e:	00b50223          	sb	a1,4(a0)
    1692:	4715                	li	a4,5
    1694:	00550e93          	addi	t4,a0,5
    1698:	12e78c63          	beq	a5,a4,17d0 <memset+0x19e>
    169c:	00b502a3          	sb	a1,5(a0)
    16a0:	471d                	li	a4,7
    16a2:	00650e93          	addi	t4,a0,6
    16a6:	12e79763          	bne	a5,a4,17d4 <memset+0x1a2>
    16aa:	00750e93          	addi	t4,a0,7
    16ae:	00b50323          	sb	a1,6(a0)
    16b2:	4f1d                	li	t5,7
    16b4:	00859713          	slli	a4,a1,0x8
    16b8:	8f4d                	or	a4,a4,a1
    16ba:	01059e13          	slli	t3,a1,0x10
    16be:	01c76e33          	or	t3,a4,t3
    16c2:	01859313          	slli	t1,a1,0x18
    16c6:	006e6333          	or	t1,t3,t1
    16ca:	02059893          	slli	a7,a1,0x20
    16ce:	011368b3          	or	a7,t1,a7
    16d2:	02859813          	slli	a6,a1,0x28
    16d6:	40f60333          	sub	t1,a2,a5
    16da:	0108e833          	or	a6,a7,a6
    16de:	03059693          	slli	a3,a1,0x30
    16e2:	00d866b3          	or	a3,a6,a3
    16e6:	03859713          	slli	a4,a1,0x38
    16ea:	97aa                	add	a5,a5,a0
    16ec:	ff837813          	andi	a6,t1,-8
    16f0:	8f55                	or	a4,a4,a3
    16f2:	00f806b3          	add	a3,a6,a5
    16f6:	e398                	sd	a4,0(a5)
    16f8:	07a1                	addi	a5,a5,8
    16fa:	fed79ee3          	bne	a5,a3,16f6 <memset+0xc4>
    16fe:	ff837693          	andi	a3,t1,-8
    1702:	00de87b3          	add	a5,t4,a3
    1706:	01e6873b          	addw	a4,a3,t5
    170a:	0ad30663          	beq	t1,a3,17b6 <memset+0x184>
    170e:	00b78023          	sb	a1,0(a5)
    1712:	0017069b          	addiw	a3,a4,1
    1716:	08c6fb63          	bgeu	a3,a2,17ac <memset+0x17a>
    171a:	00b780a3          	sb	a1,1(a5)
    171e:	0027069b          	addiw	a3,a4,2
    1722:	08c6f563          	bgeu	a3,a2,17ac <memset+0x17a>
    1726:	00b78123          	sb	a1,2(a5)
    172a:	0037069b          	addiw	a3,a4,3
    172e:	06c6ff63          	bgeu	a3,a2,17ac <memset+0x17a>
    1732:	00b781a3          	sb	a1,3(a5)
    1736:	0047069b          	addiw	a3,a4,4
    173a:	06c6f963          	bgeu	a3,a2,17ac <memset+0x17a>
    173e:	00b78223          	sb	a1,4(a5)
    1742:	0057069b          	addiw	a3,a4,5
    1746:	06c6f363          	bgeu	a3,a2,17ac <memset+0x17a>
    174a:	00b782a3          	sb	a1,5(a5)
    174e:	0067069b          	addiw	a3,a4,6
    1752:	04c6fd63          	bgeu	a3,a2,17ac <memset+0x17a>
    1756:	00b78323          	sb	a1,6(a5)
    175a:	0077069b          	addiw	a3,a4,7
    175e:	04c6f763          	bgeu	a3,a2,17ac <memset+0x17a>
    1762:	00b783a3          	sb	a1,7(a5)
    1766:	0087069b          	addiw	a3,a4,8
    176a:	04c6f163          	bgeu	a3,a2,17ac <memset+0x17a>
    176e:	00b78423          	sb	a1,8(a5)
    1772:	0097069b          	addiw	a3,a4,9
    1776:	02c6fb63          	bgeu	a3,a2,17ac <memset+0x17a>
    177a:	00b784a3          	sb	a1,9(a5)
    177e:	00a7069b          	addiw	a3,a4,10
    1782:	02c6f563          	bgeu	a3,a2,17ac <memset+0x17a>
    1786:	00b78523          	sb	a1,10(a5)
    178a:	00b7069b          	addiw	a3,a4,11
    178e:	00c6ff63          	bgeu	a3,a2,17ac <memset+0x17a>
    1792:	00b785a3          	sb	a1,11(a5)
    1796:	00c7069b          	addiw	a3,a4,12
    179a:	00c6f963          	bgeu	a3,a2,17ac <memset+0x17a>
    179e:	00b78623          	sb	a1,12(a5)
    17a2:	2735                	addiw	a4,a4,13
    17a4:	00c77463          	bgeu	a4,a2,17ac <memset+0x17a>
    17a8:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    17ac:	8082                	ret
    17ae:	472d                	li	a4,11
    17b0:	bd79                	j	164e <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    17b2:	4f0d                	li	t5,3
    17b4:	b701                	j	16b4 <memset+0x82>
    17b6:	8082                	ret
    17b8:	4f05                	li	t5,1
    17ba:	bded                	j	16b4 <memset+0x82>
    17bc:	8eaa                	mv	t4,a0
    17be:	4f01                	li	t5,0
    17c0:	bdd5                	j	16b4 <memset+0x82>
    17c2:	87aa                	mv	a5,a0
    17c4:	4701                	li	a4,0
    17c6:	b7a1                	j	170e <memset+0xdc>
    17c8:	4f09                	li	t5,2
    17ca:	b5ed                	j	16b4 <memset+0x82>
    17cc:	4f11                	li	t5,4
    17ce:	b5dd                	j	16b4 <memset+0x82>
    17d0:	4f15                	li	t5,5
    17d2:	b5cd                	j	16b4 <memset+0x82>
    17d4:	4f19                	li	t5,6
    17d6:	bdf9                	j	16b4 <memset+0x82>

00000000000017d8 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    17d8:	00054783          	lbu	a5,0(a0)
    17dc:	0005c703          	lbu	a4,0(a1)
    17e0:	00e79863          	bne	a5,a4,17f0 <strcmp+0x18>
    17e4:	0505                	addi	a0,a0,1
    17e6:	0585                	addi	a1,a1,1
    17e8:	fbe5                	bnez	a5,17d8 <strcmp>
    17ea:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    17ec:	9d19                	subw	a0,a0,a4
    17ee:	8082                	ret
    17f0:	0007851b          	sext.w	a0,a5
    17f4:	bfe5                	j	17ec <strcmp+0x14>

00000000000017f6 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    17f6:	87aa                	mv	a5,a0
    17f8:	0005c703          	lbu	a4,0(a1)
    17fc:	0785                	addi	a5,a5,1
    17fe:	0585                	addi	a1,a1,1
    1800:	fee78fa3          	sb	a4,-1(a5)
    1804:	fb75                	bnez	a4,17f8 <strcpy+0x2>
        ;
    return os;
}
    1806:	8082                	ret

0000000000001808 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    1808:	ce05                	beqz	a2,1840 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    180a:	00054703          	lbu	a4,0(a0)
    180e:	0005c783          	lbu	a5,0(a1)
    1812:	cb0d                	beqz	a4,1844 <strncmp+0x3c>
    if (!n--)
    1814:	167d                	addi	a2,a2,-1
    1816:	00c506b3          	add	a3,a0,a2
    181a:	a819                	j	1830 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    181c:	00a68e63          	beq	a3,a0,1838 <strncmp+0x30>
    1820:	0505                	addi	a0,a0,1
    1822:	00e79b63          	bne	a5,a4,1838 <strncmp+0x30>
    1826:	00054703          	lbu	a4,0(a0)
    182a:	0005c783          	lbu	a5,0(a1)
    182e:	cb19                	beqz	a4,1844 <strncmp+0x3c>
    1830:	0005c783          	lbu	a5,0(a1)
    1834:	0585                	addi	a1,a1,1
    1836:	f3fd                	bnez	a5,181c <strncmp+0x14>
        ;
    return *l - *r;
    1838:	0007051b          	sext.w	a0,a4
    183c:	9d1d                	subw	a0,a0,a5
    183e:	8082                	ret
        return 0;
    1840:	4501                	li	a0,0
}
    1842:	8082                	ret
    1844:	4501                	li	a0,0
    return *l - *r;
    1846:	9d1d                	subw	a0,a0,a5
    1848:	8082                	ret

000000000000184a <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    184a:	00757793          	andi	a5,a0,7
    184e:	cf89                	beqz	a5,1868 <strlen+0x1e>
    1850:	87aa                	mv	a5,a0
    1852:	a029                	j	185c <strlen+0x12>
    1854:	0785                	addi	a5,a5,1
    1856:	0077f713          	andi	a4,a5,7
    185a:	cb01                	beqz	a4,186a <strlen+0x20>
        if (!*s)
    185c:	0007c703          	lbu	a4,0(a5)
    1860:	fb75                	bnez	a4,1854 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1862:	40a78533          	sub	a0,a5,a0
}
    1866:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1868:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    186a:	6394                	ld	a3,0(a5)
    186c:	00000597          	auipc	a1,0x0
    1870:	66c5b583          	ld	a1,1644(a1) # 1ed8 <sharedmem+0x60>
    1874:	00000617          	auipc	a2,0x0
    1878:	66c63603          	ld	a2,1644(a2) # 1ee0 <sharedmem+0x68>
    187c:	a019                	j	1882 <strlen+0x38>
    187e:	6794                	ld	a3,8(a5)
    1880:	07a1                	addi	a5,a5,8
    1882:	00b68733          	add	a4,a3,a1
    1886:	fff6c693          	not	a3,a3
    188a:	8f75                	and	a4,a4,a3
    188c:	8f71                	and	a4,a4,a2
    188e:	db65                	beqz	a4,187e <strlen+0x34>
    for (; *s; s++)
    1890:	0007c703          	lbu	a4,0(a5)
    1894:	d779                	beqz	a4,1862 <strlen+0x18>
    1896:	0017c703          	lbu	a4,1(a5)
    189a:	0785                	addi	a5,a5,1
    189c:	d379                	beqz	a4,1862 <strlen+0x18>
    189e:	0017c703          	lbu	a4,1(a5)
    18a2:	0785                	addi	a5,a5,1
    18a4:	fb6d                	bnez	a4,1896 <strlen+0x4c>
    18a6:	bf75                	j	1862 <strlen+0x18>

00000000000018a8 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18a8:	00757713          	andi	a4,a0,7
{
    18ac:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    18ae:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18b2:	cb19                	beqz	a4,18c8 <memchr+0x20>
    18b4:	ce25                	beqz	a2,192c <memchr+0x84>
    18b6:	0007c703          	lbu	a4,0(a5)
    18ba:	04b70e63          	beq	a4,a1,1916 <memchr+0x6e>
    18be:	0785                	addi	a5,a5,1
    18c0:	0077f713          	andi	a4,a5,7
    18c4:	167d                	addi	a2,a2,-1
    18c6:	f77d                	bnez	a4,18b4 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    18c8:	4501                	li	a0,0
    if (n && *s != c) {
    18ca:	c235                	beqz	a2,192e <memchr+0x86>
    18cc:	0007c703          	lbu	a4,0(a5)
    18d0:	04b70363          	beq	a4,a1,1916 <memchr+0x6e>
        size_t k = ONES * c;
    18d4:	00000517          	auipc	a0,0x0
    18d8:	61453503          	ld	a0,1556(a0) # 1ee8 <sharedmem+0x70>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    18dc:	471d                	li	a4,7
        size_t k = ONES * c;
    18de:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    18e2:	02c77a63          	bgeu	a4,a2,1916 <memchr+0x6e>
    18e6:	00000897          	auipc	a7,0x0
    18ea:	5f28b883          	ld	a7,1522(a7) # 1ed8 <sharedmem+0x60>
    18ee:	00000817          	auipc	a6,0x0
    18f2:	5f283803          	ld	a6,1522(a6) # 1ee0 <sharedmem+0x68>
    18f6:	431d                	li	t1,7
    18f8:	a029                	j	1902 <memchr+0x5a>
    18fa:	1661                	addi	a2,a2,-8
    18fc:	07a1                	addi	a5,a5,8
    18fe:	02c37963          	bgeu	t1,a2,1930 <memchr+0x88>
    1902:	6398                	ld	a4,0(a5)
    1904:	8f29                	xor	a4,a4,a0
    1906:	011706b3          	add	a3,a4,a7
    190a:	fff74713          	not	a4,a4
    190e:	8f75                	and	a4,a4,a3
    1910:	01077733          	and	a4,a4,a6
    1914:	d37d                	beqz	a4,18fa <memchr+0x52>
    1916:	853e                	mv	a0,a5
    1918:	97b2                	add	a5,a5,a2
    191a:	a021                	j	1922 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    191c:	0505                	addi	a0,a0,1
    191e:	00f50763          	beq	a0,a5,192c <memchr+0x84>
    1922:	00054703          	lbu	a4,0(a0)
    1926:	feb71be3          	bne	a4,a1,191c <memchr+0x74>
    192a:	8082                	ret
    return n ? (void*)s : 0;
    192c:	4501                	li	a0,0
}
    192e:	8082                	ret
    return n ? (void*)s : 0;
    1930:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1932:	f275                	bnez	a2,1916 <memchr+0x6e>
}
    1934:	8082                	ret

0000000000001936 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1936:	1101                	addi	sp,sp,-32
    1938:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    193a:	862e                	mv	a2,a1
{
    193c:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    193e:	4581                	li	a1,0
{
    1940:	e426                	sd	s1,8(sp)
    1942:	ec06                	sd	ra,24(sp)
    1944:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1946:	f63ff0ef          	jal	ra,18a8 <memchr>
    return p ? p - s : n;
    194a:	c519                	beqz	a0,1958 <strnlen+0x22>
}
    194c:	60e2                	ld	ra,24(sp)
    194e:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1950:	8d05                	sub	a0,a0,s1
}
    1952:	64a2                	ld	s1,8(sp)
    1954:	6105                	addi	sp,sp,32
    1956:	8082                	ret
    1958:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    195a:	8522                	mv	a0,s0
}
    195c:	6442                	ld	s0,16(sp)
    195e:	64a2                	ld	s1,8(sp)
    1960:	6105                	addi	sp,sp,32
    1962:	8082                	ret

0000000000001964 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1964:	00b547b3          	xor	a5,a0,a1
    1968:	8b9d                	andi	a5,a5,7
    196a:	eb95                	bnez	a5,199e <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    196c:	0075f793          	andi	a5,a1,7
    1970:	e7b1                	bnez	a5,19bc <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1972:	6198                	ld	a4,0(a1)
    1974:	00000617          	auipc	a2,0x0
    1978:	56463603          	ld	a2,1380(a2) # 1ed8 <sharedmem+0x60>
    197c:	00000817          	auipc	a6,0x0
    1980:	56483803          	ld	a6,1380(a6) # 1ee0 <sharedmem+0x68>
    1984:	a029                	j	198e <stpcpy+0x2a>
    1986:	e118                	sd	a4,0(a0)
    1988:	6598                	ld	a4,8(a1)
    198a:	05a1                	addi	a1,a1,8
    198c:	0521                	addi	a0,a0,8
    198e:	00c707b3          	add	a5,a4,a2
    1992:	fff74693          	not	a3,a4
    1996:	8ff5                	and	a5,a5,a3
    1998:	0107f7b3          	and	a5,a5,a6
    199c:	d7ed                	beqz	a5,1986 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    199e:	0005c783          	lbu	a5,0(a1)
    19a2:	00f50023          	sb	a5,0(a0)
    19a6:	c785                	beqz	a5,19ce <stpcpy+0x6a>
    19a8:	0015c783          	lbu	a5,1(a1)
    19ac:	0505                	addi	a0,a0,1
    19ae:	0585                	addi	a1,a1,1
    19b0:	00f50023          	sb	a5,0(a0)
    19b4:	fbf5                	bnez	a5,19a8 <stpcpy+0x44>
        ;
    return d;
}
    19b6:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    19b8:	0505                	addi	a0,a0,1
    19ba:	df45                	beqz	a4,1972 <stpcpy+0xe>
            if (!(*d = *s))
    19bc:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    19c0:	0585                	addi	a1,a1,1
    19c2:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    19c6:	00f50023          	sb	a5,0(a0)
    19ca:	f7fd                	bnez	a5,19b8 <stpcpy+0x54>
}
    19cc:	8082                	ret
    19ce:	8082                	ret

00000000000019d0 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    19d0:	00b547b3          	xor	a5,a0,a1
    19d4:	8b9d                	andi	a5,a5,7
    19d6:	1a079863          	bnez	a5,1b86 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    19da:	0075f793          	andi	a5,a1,7
    19de:	16078463          	beqz	a5,1b46 <stpncpy+0x176>
    19e2:	ea01                	bnez	a2,19f2 <stpncpy+0x22>
    19e4:	a421                	j	1bec <stpncpy+0x21c>
    19e6:	167d                	addi	a2,a2,-1
    19e8:	0505                	addi	a0,a0,1
    19ea:	14070e63          	beqz	a4,1b46 <stpncpy+0x176>
    19ee:	1a060863          	beqz	a2,1b9e <stpncpy+0x1ce>
    19f2:	0005c783          	lbu	a5,0(a1)
    19f6:	0585                	addi	a1,a1,1
    19f8:	0075f713          	andi	a4,a1,7
    19fc:	00f50023          	sb	a5,0(a0)
    1a00:	f3fd                	bnez	a5,19e6 <stpncpy+0x16>
    1a02:	4805                	li	a6,1
    1a04:	1a061863          	bnez	a2,1bb4 <stpncpy+0x1e4>
    1a08:	40a007b3          	neg	a5,a0
    1a0c:	8b9d                	andi	a5,a5,7
    1a0e:	4681                	li	a3,0
    1a10:	18061a63          	bnez	a2,1ba4 <stpncpy+0x1d4>
    1a14:	00778713          	addi	a4,a5,7
    1a18:	45ad                	li	a1,11
    1a1a:	18b76363          	bltu	a4,a1,1ba0 <stpncpy+0x1d0>
    1a1e:	1ae6eb63          	bltu	a3,a4,1bd4 <stpncpy+0x204>
    1a22:	1a078363          	beqz	a5,1bc8 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1a26:	00050023          	sb	zero,0(a0)
    1a2a:	4685                	li	a3,1
    1a2c:	00150713          	addi	a4,a0,1
    1a30:	18d78f63          	beq	a5,a3,1bce <stpncpy+0x1fe>
    1a34:	000500a3          	sb	zero,1(a0)
    1a38:	4689                	li	a3,2
    1a3a:	00250713          	addi	a4,a0,2
    1a3e:	18d78e63          	beq	a5,a3,1bda <stpncpy+0x20a>
    1a42:	00050123          	sb	zero,2(a0)
    1a46:	468d                	li	a3,3
    1a48:	00350713          	addi	a4,a0,3
    1a4c:	16d78c63          	beq	a5,a3,1bc4 <stpncpy+0x1f4>
    1a50:	000501a3          	sb	zero,3(a0)
    1a54:	4691                	li	a3,4
    1a56:	00450713          	addi	a4,a0,4
    1a5a:	18d78263          	beq	a5,a3,1bde <stpncpy+0x20e>
    1a5e:	00050223          	sb	zero,4(a0)
    1a62:	4695                	li	a3,5
    1a64:	00550713          	addi	a4,a0,5
    1a68:	16d78d63          	beq	a5,a3,1be2 <stpncpy+0x212>
    1a6c:	000502a3          	sb	zero,5(a0)
    1a70:	469d                	li	a3,7
    1a72:	00650713          	addi	a4,a0,6
    1a76:	16d79863          	bne	a5,a3,1be6 <stpncpy+0x216>
    1a7a:	00750713          	addi	a4,a0,7
    1a7e:	00050323          	sb	zero,6(a0)
    1a82:	40f80833          	sub	a6,a6,a5
    1a86:	ff887593          	andi	a1,a6,-8
    1a8a:	97aa                	add	a5,a5,a0
    1a8c:	95be                	add	a1,a1,a5
    1a8e:	0007b023          	sd	zero,0(a5)
    1a92:	07a1                	addi	a5,a5,8
    1a94:	feb79de3          	bne	a5,a1,1a8e <stpncpy+0xbe>
    1a98:	ff887593          	andi	a1,a6,-8
    1a9c:	9ead                	addw	a3,a3,a1
    1a9e:	00b707b3          	add	a5,a4,a1
    1aa2:	12b80863          	beq	a6,a1,1bd2 <stpncpy+0x202>
    1aa6:	00078023          	sb	zero,0(a5)
    1aaa:	0016871b          	addiw	a4,a3,1
    1aae:	0ec77863          	bgeu	a4,a2,1b9e <stpncpy+0x1ce>
    1ab2:	000780a3          	sb	zero,1(a5)
    1ab6:	0026871b          	addiw	a4,a3,2
    1aba:	0ec77263          	bgeu	a4,a2,1b9e <stpncpy+0x1ce>
    1abe:	00078123          	sb	zero,2(a5)
    1ac2:	0036871b          	addiw	a4,a3,3
    1ac6:	0cc77c63          	bgeu	a4,a2,1b9e <stpncpy+0x1ce>
    1aca:	000781a3          	sb	zero,3(a5)
    1ace:	0046871b          	addiw	a4,a3,4
    1ad2:	0cc77663          	bgeu	a4,a2,1b9e <stpncpy+0x1ce>
    1ad6:	00078223          	sb	zero,4(a5)
    1ada:	0056871b          	addiw	a4,a3,5
    1ade:	0cc77063          	bgeu	a4,a2,1b9e <stpncpy+0x1ce>
    1ae2:	000782a3          	sb	zero,5(a5)
    1ae6:	0066871b          	addiw	a4,a3,6
    1aea:	0ac77a63          	bgeu	a4,a2,1b9e <stpncpy+0x1ce>
    1aee:	00078323          	sb	zero,6(a5)
    1af2:	0076871b          	addiw	a4,a3,7
    1af6:	0ac77463          	bgeu	a4,a2,1b9e <stpncpy+0x1ce>
    1afa:	000783a3          	sb	zero,7(a5)
    1afe:	0086871b          	addiw	a4,a3,8
    1b02:	08c77e63          	bgeu	a4,a2,1b9e <stpncpy+0x1ce>
    1b06:	00078423          	sb	zero,8(a5)
    1b0a:	0096871b          	addiw	a4,a3,9
    1b0e:	08c77863          	bgeu	a4,a2,1b9e <stpncpy+0x1ce>
    1b12:	000784a3          	sb	zero,9(a5)
    1b16:	00a6871b          	addiw	a4,a3,10
    1b1a:	08c77263          	bgeu	a4,a2,1b9e <stpncpy+0x1ce>
    1b1e:	00078523          	sb	zero,10(a5)
    1b22:	00b6871b          	addiw	a4,a3,11
    1b26:	06c77c63          	bgeu	a4,a2,1b9e <stpncpy+0x1ce>
    1b2a:	000785a3          	sb	zero,11(a5)
    1b2e:	00c6871b          	addiw	a4,a3,12
    1b32:	06c77663          	bgeu	a4,a2,1b9e <stpncpy+0x1ce>
    1b36:	00078623          	sb	zero,12(a5)
    1b3a:	26b5                	addiw	a3,a3,13
    1b3c:	06c6f163          	bgeu	a3,a2,1b9e <stpncpy+0x1ce>
    1b40:	000786a3          	sb	zero,13(a5)
    1b44:	8082                	ret
            ;
        if (!n || !*s)
    1b46:	c645                	beqz	a2,1bee <stpncpy+0x21e>
    1b48:	0005c783          	lbu	a5,0(a1)
    1b4c:	ea078be3          	beqz	a5,1a02 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b50:	479d                	li	a5,7
    1b52:	02c7ff63          	bgeu	a5,a2,1b90 <stpncpy+0x1c0>
    1b56:	00000897          	auipc	a7,0x0
    1b5a:	3828b883          	ld	a7,898(a7) # 1ed8 <sharedmem+0x60>
    1b5e:	00000817          	auipc	a6,0x0
    1b62:	38283803          	ld	a6,898(a6) # 1ee0 <sharedmem+0x68>
    1b66:	431d                	li	t1,7
    1b68:	6198                	ld	a4,0(a1)
    1b6a:	011707b3          	add	a5,a4,a7
    1b6e:	fff74693          	not	a3,a4
    1b72:	8ff5                	and	a5,a5,a3
    1b74:	0107f7b3          	and	a5,a5,a6
    1b78:	ef81                	bnez	a5,1b90 <stpncpy+0x1c0>
            *wd = *ws;
    1b7a:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b7c:	1661                	addi	a2,a2,-8
    1b7e:	05a1                	addi	a1,a1,8
    1b80:	0521                	addi	a0,a0,8
    1b82:	fec363e3          	bltu	t1,a2,1b68 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1b86:	e609                	bnez	a2,1b90 <stpncpy+0x1c0>
    1b88:	a08d                	j	1bea <stpncpy+0x21a>
    1b8a:	167d                	addi	a2,a2,-1
    1b8c:	0505                	addi	a0,a0,1
    1b8e:	ca01                	beqz	a2,1b9e <stpncpy+0x1ce>
    1b90:	0005c783          	lbu	a5,0(a1)
    1b94:	0585                	addi	a1,a1,1
    1b96:	00f50023          	sb	a5,0(a0)
    1b9a:	fbe5                	bnez	a5,1b8a <stpncpy+0x1ba>
        ;
tail:
    1b9c:	b59d                	j	1a02 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1b9e:	8082                	ret
    1ba0:	472d                	li	a4,11
    1ba2:	bdb5                	j	1a1e <stpncpy+0x4e>
    1ba4:	00778713          	addi	a4,a5,7
    1ba8:	45ad                	li	a1,11
    1baa:	fff60693          	addi	a3,a2,-1
    1bae:	e6b778e3          	bgeu	a4,a1,1a1e <stpncpy+0x4e>
    1bb2:	b7fd                	j	1ba0 <stpncpy+0x1d0>
    1bb4:	40a007b3          	neg	a5,a0
    1bb8:	8832                	mv	a6,a2
    1bba:	8b9d                	andi	a5,a5,7
    1bbc:	4681                	li	a3,0
    1bbe:	e4060be3          	beqz	a2,1a14 <stpncpy+0x44>
    1bc2:	b7cd                	j	1ba4 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1bc4:	468d                	li	a3,3
    1bc6:	bd75                	j	1a82 <stpncpy+0xb2>
    1bc8:	872a                	mv	a4,a0
    1bca:	4681                	li	a3,0
    1bcc:	bd5d                	j	1a82 <stpncpy+0xb2>
    1bce:	4685                	li	a3,1
    1bd0:	bd4d                	j	1a82 <stpncpy+0xb2>
    1bd2:	8082                	ret
    1bd4:	87aa                	mv	a5,a0
    1bd6:	4681                	li	a3,0
    1bd8:	b5f9                	j	1aa6 <stpncpy+0xd6>
    1bda:	4689                	li	a3,2
    1bdc:	b55d                	j	1a82 <stpncpy+0xb2>
    1bde:	4691                	li	a3,4
    1be0:	b54d                	j	1a82 <stpncpy+0xb2>
    1be2:	4695                	li	a3,5
    1be4:	bd79                	j	1a82 <stpncpy+0xb2>
    1be6:	4699                	li	a3,6
    1be8:	bd69                	j	1a82 <stpncpy+0xb2>
    1bea:	8082                	ret
    1bec:	8082                	ret
    1bee:	8082                	ret

0000000000001bf0 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1bf0:	fff6071b          	addiw	a4,a2,-1
    1bf4:	0cb57063          	bgeu	a0,a1,1cb4 <memmove+0xc4>
        while (n-- > 0)
    1bf8:	0ec05063          	blez	a2,1cd8 <memmove+0xe8>
    1bfc:	00750693          	addi	a3,a0,7
    1c00:	8e8d                	sub	a3,a3,a1
    1c02:	00b567b3          	or	a5,a0,a1
    1c06:	00f6b693          	sltiu	a3,a3,15
    1c0a:	8b9d                	andi	a5,a5,7
    1c0c:	0016c693          	xori	a3,a3,1
    1c10:	0017b793          	seqz	a5,a5
    1c14:	8ff5                	and	a5,a5,a3
    1c16:	c3f1                	beqz	a5,1cda <memmove+0xea>
    1c18:	0007079b          	sext.w	a5,a4
    1c1c:	46a5                	li	a3,9
    1c1e:	0af6fe63          	bgeu	a3,a5,1cda <memmove+0xea>
    1c22:	0036589b          	srliw	a7,a2,0x3
    1c26:	088e                	slli	a7,a7,0x3
    1c28:	2601                	sext.w	a2,a2
    1c2a:	87ae                	mv	a5,a1
    1c2c:	86aa                	mv	a3,a0
    1c2e:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1c30:	0007b803          	ld	a6,0(a5)
    1c34:	07a1                	addi	a5,a5,8
    1c36:	06a1                	addi	a3,a3,8
    1c38:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1c3c:	ff179ae3          	bne	a5,a7,1c30 <memmove+0x40>
    1c40:	ff867813          	andi	a6,a2,-8
    1c44:	02081793          	slli	a5,a6,0x20
    1c48:	9381                	srli	a5,a5,0x20
    1c4a:	00f506b3          	add	a3,a0,a5
    1c4e:	95be                	add	a1,a1,a5
    1c50:	4107073b          	subw	a4,a4,a6
    1c54:	09060263          	beq	a2,a6,1cd8 <memmove+0xe8>
            *dst++ = *src++;
    1c58:	0005c783          	lbu	a5,0(a1)
    1c5c:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1c60:	06e05c63          	blez	a4,1cd8 <memmove+0xe8>
            *dst++ = *src++;
    1c64:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1c68:	4785                	li	a5,1
            *dst++ = *src++;
    1c6a:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1c6e:	06e7d563          	bge	a5,a4,1cd8 <memmove+0xe8>
            *dst++ = *src++;
    1c72:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1c76:	4789                	li	a5,2
            *dst++ = *src++;
    1c78:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1c7c:	04e7de63          	bge	a5,a4,1cd8 <memmove+0xe8>
            *dst++ = *src++;
    1c80:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1c84:	478d                	li	a5,3
            *dst++ = *src++;
    1c86:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1c8a:	04e7d763          	bge	a5,a4,1cd8 <memmove+0xe8>
            *dst++ = *src++;
    1c8e:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1c92:	4791                	li	a5,4
            *dst++ = *src++;
    1c94:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1c98:	04e7d063          	bge	a5,a4,1cd8 <memmove+0xe8>
            *dst++ = *src++;
    1c9c:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1ca0:	4795                	li	a5,5
            *dst++ = *src++;
    1ca2:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1ca6:	02e7d963          	bge	a5,a4,1cd8 <memmove+0xe8>
            *dst++ = *src++;
    1caa:	0065c783          	lbu	a5,6(a1)
    1cae:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1cb2:	8082                	ret
    } else {
        dst += n;
    1cb4:	00c507b3          	add	a5,a0,a2
        src += n;
    1cb8:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1cba:	00c05f63          	blez	a2,1cd8 <memmove+0xe8>
    1cbe:	1702                	slli	a4,a4,0x20
    1cc0:	9301                	srli	a4,a4,0x20
    1cc2:	fff74713          	not	a4,a4
    1cc6:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1cc8:	fff5c683          	lbu	a3,-1(a1)
    1ccc:	17fd                	addi	a5,a5,-1
    1cce:	15fd                	addi	a1,a1,-1
    1cd0:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1cd4:	fee79ae3          	bne	a5,a4,1cc8 <memmove+0xd8>
    }
    return vdst;
}
    1cd8:	8082                	ret
    1cda:	02071693          	slli	a3,a4,0x20
    1cde:	9281                	srli	a3,a3,0x20
    1ce0:	0685                	addi	a3,a3,1
    1ce2:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1ce4:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1ce6:	0005c703          	lbu	a4,0(a1)
    1cea:	0585                	addi	a1,a1,1
    1cec:	0785                	addi	a5,a5,1
    1cee:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1cf2:	fed59ae3          	bne	a1,a3,1ce6 <memmove+0xf6>
    1cf6:	8082                	ret

0000000000001cf8 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1cf8:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cfc:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1d00:	2501                	sext.w	a0,a0
    1d02:	8082                	ret

0000000000001d04 <exec>:
    register long a7 __asm__("a7") = n;
    1d04:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1d08:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d0a:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1d0e:	2501                	sext.w	a0,a0
    1d10:	8082                	ret

0000000000001d12 <exit>:
    register long a7 __asm__("a7") = n;
    1d12:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d16:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1d1a:	8082                	ret

0000000000001d1c <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1d1c:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d20:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1d24:	8082                	ret

0000000000001d26 <write>:
    register long a7 __asm__("a7") = n;
    1d26:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d2a:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1d2e:	8082                	ret

0000000000001d30 <getpid>:
    register long a7 __asm__("a7") = n;
    1d30:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1d34:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1d38:	2501                	sext.w	a0,a0
    1d3a:	8082                	ret

0000000000001d3c <getppid>:
    register long a7 __asm__("a7") = n;
    1d3c:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1d40:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1d44:	2501                	sext.w	a0,a0
    1d46:	8082                	ret

0000000000001d48 <open>:
    register long a7 __asm__("a7") = n;
    1d48:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d4c:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1d50:	2501                	sext.w	a0,a0
    1d52:	8082                	ret

0000000000001d54 <mknod>:
    register long a7 __asm__("a7") = n;
    1d54:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d58:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1d5c:	2501                	sext.w	a0,a0
    1d5e:	8082                	ret

0000000000001d60 <dup>:
    register long a7 __asm__("a7") = n;
    1d60:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1d62:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1d66:	2501                	sext.w	a0,a0
    1d68:	8082                	ret

0000000000001d6a <sched_yield>:
    register long a7 __asm__("a7") = n;
    1d6a:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1d6e:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1d72:	2501                	sext.w	a0,a0
    1d74:	8082                	ret

0000000000001d76 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d76:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d7a:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1d7e:	2501                	sext.w	a0,a0
    1d80:	8082                	ret

0000000000001d82 <wait>:

pid_t wait(int *wstatus)
{
    1d82:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d84:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1d88:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d8a:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1d8e:	2501                	sext.w	a0,a0
    1d90:	8082                	ret

0000000000001d92 <mkdir>:
    register long a7 __asm__("a7") = n;
    1d92:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1d96:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1d9a:	2501                	sext.w	a0,a0
    1d9c:	8082                	ret

0000000000001d9e <close>:
    register long a7 __asm__("a7") = n;
    1d9e:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1da2:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1da6:	2501                	sext.w	a0,a0
    1da8:	8082                	ret

0000000000001daa <fork>:
    register long a7 __asm__("a7") = n;
    1daa:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1dae:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1db2:	2501                	sext.w	a0,a0
    1db4:	8082                	ret

0000000000001db6 <time_ms>:
    register long a7 __asm__("a7") = n;
    1db6:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1dba:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1dbe:	8082                	ret

0000000000001dc0 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1dc0:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1dc2:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1dc6:	00000073          	ecall
    1dca:	87aa                	mv	a5,a0
    1dcc:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1dd0:	97ba                	add	a5,a5,a4
    1dd2:	00f57c63          	bgeu	a0,a5,1dea <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1dd6:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1dda:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1dde:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1de2:	00000073          	ecall
    1de6:	fef568e3          	bltu	a0,a5,1dd6 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1dea:	4501                	li	a0,0
    1dec:	8082                	ret

0000000000001dee <pipe>:
    register long a7 __asm__("a7") = n;
    1dee:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1df2:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1df6:	2501                	sext.w	a0,a0
    1df8:	8082                	ret

0000000000001dfa <fstat>:
    register long a7 __asm__("a7") = n;
    1dfa:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dfe:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1e02:	2501                	sext.w	a0,a0
    1e04:	8082                	ret

0000000000001e06 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1e06:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1e08:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1e0c:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e0e:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1e12:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1e16:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1e1a:	0206c163          	bltz	a3,1e3c <stat+0x36>
    register long a7 __asm__("a7") = n;
    1e1e:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1e22:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1e24:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e26:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1e2a:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1e2e:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1e32:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1e34:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1e38:	853e                	mv	a0,a5
    1e3a:	8082                	ret
        return -1;
    1e3c:	57fd                	li	a5,-1
    1e3e:	bfed                	j	1e38 <stat+0x32>

0000000000001e40 <chdir>:
    register long a7 __asm__("a7") = n;
    1e40:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e44:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e48:	2501                	sext.w	a0,a0
    1e4a:	8082                	ret

0000000000001e4c <link>:
    register long a7 __asm__("a7") = n;
    1e4c:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e50:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1e54:	2501                	sext.w	a0,a0
    1e56:	8082                	ret

0000000000001e58 <unlink>:
    register long a7 __asm__("a7") = n;
    1e58:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1e5c:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1e60:	2501                	sext.w	a0,a0
    1e62:	8082                	ret

0000000000001e64 <setpriority>:
    register long a7 __asm__("a7") = n;
    1e64:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1e68:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1e6c:	8082                	ret

0000000000001e6e <getpriority>:
    register long a7 __asm__("a7") = n;
    1e6e:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1e72:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1e76:	8082                	ret

0000000000001e78 <sharedmem>:
    register long a7 __asm__("a7") = n;
    1e78:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e7c:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1e80:	8082                	ret
