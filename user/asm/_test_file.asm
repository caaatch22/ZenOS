
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_file:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a8e9                	j	10da <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <stdlib.h>
#include <ucore.h>
#include <fcntl.h>
#include <string.h>

int main() {
    1002:	7151                	addi	sp,sp,-240
    int exit_code;
    int fd = open("test", O_CREATE | O_WRONLY);
    1004:	20100593          	li	a1,513
    1008:	00001517          	auipc	a0,0x1
    100c:	dd050513          	addi	a0,a0,-560 # 1dd8 <sharedmem+0xa>
int main() {
    1010:	f586                	sd	ra,232(sp)
    1012:	f1a2                	sd	s0,224(sp)
    1014:	eda6                	sd	s1,216(sp)
    int fd = open("test", O_CREATE | O_WRONLY);
    1016:	489000ef          	jal	ra,1c9e <open>
    101a:	842a                	mv	s0,a0
    printf("open OK, fd = %d\n", fd);
    101c:	85aa                	mv	a1,a0
    101e:	00001517          	auipc	a0,0x1
    1022:	dc250513          	addi	a0,a0,-574 # 1de0 <sharedmem+0x12>
    1026:	14a000ef          	jal	ra,1170 <printf>
    char str[100] = "hello world!\0";
    102a:	00001797          	auipc	a5,0x1
    102e:	e2e78793          	addi	a5,a5,-466 # 1e58 <put.1156+0x8>
    1032:	6394                	ld	a3,0(a5)
    1034:	4798                	lw	a4,8(a5)
    1036:	00c7d783          	lhu	a5,12(a5)
    103a:	05600613          	li	a2,86
    103e:	4581                	li	a1,0
    1040:	00e10513          	addi	a0,sp,14
    1044:	e036                	sd	a3,0(sp)
    1046:	c43a                	sw	a4,8(sp)
    1048:	00f11623          	sh	a5,12(sp)
    104c:	53c000ef          	jal	ra,1588 <memset>
    int len = strlen(str);
    1050:	850a                	mv	a0,sp
    1052:	74e000ef          	jal	ra,17a0 <strlen>
    write(fd, str, len);
    1056:	0005049b          	sext.w	s1,a0
    105a:	8626                	mv	a2,s1
    105c:	858a                	mv	a1,sp
    105e:	8522                	mv	a0,s0
    1060:	41d000ef          	jal	ra,1c7c <write>
    close(fd);
    1064:	8522                	mv	a0,s0
    1066:	48f000ef          	jal	ra,1cf4 <close>
    puts("write over.");
    106a:	00001517          	auipc	a0,0x1
    106e:	d8e50513          	addi	a0,a0,-626 # 1df8 <sharedmem+0x2a>
    1072:	0b8000ef          	jal	ra,112a <puts>
    if(fork() == 0) {
    1076:	48b000ef          	jal	ra,1d00 <fork>
    107a:	c105                	beqz	a0,109a <main+0x98>
        puts(str);
        puts("read over.");
        close(fd);
        exit(0);
    }
    wait(&exit_code);
    107c:	10a8                	addi	a0,sp,104
    107e:	45b000ef          	jal	ra,1cd8 <wait>
    puts("filetest passed.");
    1082:	00001517          	auipc	a0,0x1
    1086:	d9650513          	addi	a0,a0,-618 # 1e18 <sharedmem+0x4a>
    108a:	0a0000ef          	jal	ra,112a <puts>
    return 0;
    108e:	70ae                	ld	ra,232(sp)
    1090:	740e                	ld	s0,224(sp)
    1092:	64ee                	ld	s1,216(sp)
    1094:	4501                	li	a0,0
    1096:	616d                	addi	sp,sp,240
    1098:	8082                	ret
        int fd = open("test", O_RDONLY);
    109a:	4581                	li	a1,0
    109c:	00001517          	auipc	a0,0x1
    10a0:	d3c50513          	addi	a0,a0,-708 # 1dd8 <sharedmem+0xa>
    10a4:	3fb000ef          	jal	ra,1c9e <open>
        str[read(fd, str, len)] = 0;
    10a8:	8626                	mv	a2,s1
    10aa:	10ac                	addi	a1,sp,104
        int fd = open("test", O_RDONLY);
    10ac:	842a                	mv	s0,a0
        str[read(fd, str, len)] = 0;
    10ae:	3c5000ef          	jal	ra,1c72 <read>
    10b2:	099c                	addi	a5,sp,208
    10b4:	97aa                	add	a5,a5,a0
        puts(str);
    10b6:	10a8                	addi	a0,sp,104
        str[read(fd, str, len)] = 0;
    10b8:	f8078c23          	sb	zero,-104(a5)
        puts(str);
    10bc:	06e000ef          	jal	ra,112a <puts>
        puts("read over.");
    10c0:	00001517          	auipc	a0,0x1
    10c4:	d4850513          	addi	a0,a0,-696 # 1e08 <sharedmem+0x3a>
    10c8:	062000ef          	jal	ra,112a <puts>
        close(fd);
    10cc:	8522                	mv	a0,s0
    10ce:	427000ef          	jal	ra,1cf4 <close>
        exit(0);
    10d2:	4501                	li	a0,0
    10d4:	395000ef          	jal	ra,1c68 <exit>
    10d8:	b755                	j	107c <main+0x7a>

00000000000010da <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    10da:	1141                	addi	sp,sp,-16
    10dc:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    10de:	f25ff0ef          	jal	ra,1002 <main>
}
    10e2:	60a2                	ld	ra,8(sp)
    10e4:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    10e6:	3830006f          	j	1c68 <exit>

00000000000010ea <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    10ea:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    10ec:	00f10593          	addi	a1,sp,15
    10f0:	4605                	li	a2,1
    10f2:	4501                	li	a0,0
int getchar() {
    10f4:	ec06                	sd	ra,24(sp)
    char byte = 0;
    10f6:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    10fa:	379000ef          	jal	ra,1c72 <read>
    return byte;
}
    10fe:	60e2                	ld	ra,24(sp)
    1100:	00f14503          	lbu	a0,15(sp)
    1104:	6105                	addi	sp,sp,32
    1106:	8082                	ret

0000000000001108 <putchar>:

int putchar(int c)
{
    1108:	1141                	addi	sp,sp,-16
    110a:	e406                	sd	ra,8(sp)
    110c:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    110e:	00001597          	auipc	a1,0x1
    1112:	d4258593          	addi	a1,a1,-702 # 1e50 <put.1156>
    return write(stdout, put, 1);
    1116:	4605                	li	a2,1
    1118:	4505                	li	a0,1
    put[0] = c;
    111a:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    111e:	35f000ef          	jal	ra,1c7c <write>
}
    1122:	60a2                	ld	ra,8(sp)
    1124:	2501                	sext.w	a0,a0
    1126:	0141                	addi	sp,sp,16
    1128:	8082                	ret

000000000000112a <puts>:

int puts(const char* s)
{
    112a:	1141                	addi	sp,sp,-16
    112c:	e022                	sd	s0,0(sp)
    112e:	e406                	sd	ra,8(sp)
    1130:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    1132:	66e000ef          	jal	ra,17a0 <strlen>
    1136:	862a                	mv	a2,a0
    1138:	85a2                	mv	a1,s0
    113a:	4505                	li	a0,1
    113c:	341000ef          	jal	ra,1c7c <write>
    1140:	00055763          	bgez	a0,114e <puts+0x24>
    return r;
}
    1144:	60a2                	ld	ra,8(sp)
    1146:	6402                	ld	s0,0(sp)
    1148:	557d                	li	a0,-1
    114a:	0141                	addi	sp,sp,16
    114c:	8082                	ret
    put[0] = c;
    114e:	00001597          	auipc	a1,0x1
    1152:	d0258593          	addi	a1,a1,-766 # 1e50 <put.1156>
    1156:	47a9                	li	a5,10
    return write(stdout, put, 1);
    1158:	4605                	li	a2,1
    115a:	4505                	li	a0,1
    put[0] = c;
    115c:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1160:	31d000ef          	jal	ra,1c7c <write>
}
    1164:	60a2                	ld	ra,8(sp)
    1166:	6402                	ld	s0,0(sp)
    1168:	41f5551b          	sraiw	a0,a0,0x1f
    116c:	0141                	addi	sp,sp,16
    116e:	8082                	ret

0000000000001170 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    1170:	7115                	addi	sp,sp,-224
    1172:	ed06                	sd	ra,152(sp)
    1174:	e922                	sd	s0,144(sp)
    1176:	e526                	sd	s1,136(sp)
    1178:	e14a                	sd	s2,128(sp)
    117a:	fcce                	sd	s3,120(sp)
    117c:	f8d2                	sd	s4,112(sp)
    117e:	f4d6                	sd	s5,104(sp)
    1180:	f0da                	sd	s6,96(sp)
    1182:	ecde                	sd	s7,88(sp)
    1184:	e8e2                	sd	s8,80(sp)
    1186:	e4e6                	sd	s9,72(sp)
    1188:	e0ea                	sd	s10,64(sp)
    118a:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    118c:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    1190:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    1192:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    1194:	f52e                	sd	a1,168(sp)
    1196:	f932                	sd	a2,176(sp)
    1198:	fd36                	sd	a3,184(sp)
    119a:	e1ba                	sd	a4,192(sp)
    119c:	e9c2                	sd	a6,208(sp)
    119e:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    11a0:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    11a2:	0c030b63          	beqz	t1,1278 <printf+0x108>
    11a6:	8aaa                	mv	s5,a0
    11a8:	0003071b          	sext.w	a4,t1
    11ac:	4481                	li	s1,0
        if (c != '%') {
    11ae:	02500b93          	li	s7,37
    put[0] = c;
    11b2:	00001417          	auipc	s0,0x1
    11b6:	c9e40413          	addi	s0,s0,-866 # 1e50 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    11ba:	4c51                	li	s8,20
    put[0] = c;
    11bc:	02500c93          	li	s9,37
    11c0:	00001a17          	auipc	s4,0x1
    11c4:	d00a0a13          	addi	s4,s4,-768 # 1ec0 <put.1156+0x70>
    11c8:	00001997          	auipc	s3,0x1
    11cc:	d5098993          	addi	s3,s3,-688 # 1f18 <digits>
    11d0:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    11d4:	0014879b          	addiw	a5,s1,1
    11d8:	00fa8933          	add	s2,s5,a5
    11dc:	13771163          	bne	a4,s7,12fe <printf+0x18e>
        c = fmt[++i] & 0xff;
    11e0:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    11e4:	080d0a63          	beqz	s10,1278 <printf+0x108>
        switch (c) {
    11e8:	2489                	addiw	s1,s1,2
    11ea:	009a8933          	add	s2,s5,s1
    11ee:	257d0e63          	beq	s10,s7,144a <printf+0x2da>
    11f2:	f9cd079b          	addiw	a5,s10,-100
    11f6:	0ff7f793          	andi	a5,a5,255
    11fa:	0cfc6263          	bltu	s8,a5,12be <printf+0x14e>
    11fe:	078a                	slli	a5,a5,0x2
    1200:	97d2                	add	a5,a5,s4
    1202:	439c                	lw	a5,0(a5)
    1204:	97d2                	add	a5,a5,s4
    1206:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    1208:	67a2                	ld	a5,8(sp)
    120a:	4398                	lw	a4,0(a5)
    120c:	07a1                	addi	a5,a5,8
    120e:	e43e                	sd	a5,8(sp)
    1210:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    1214:	26074663          	bltz	a4,1480 <printf+0x310>
        buf[i++] = digits[x % base];
    1218:	8bbd                	andi	a5,a5,15
    121a:	97ce                	add	a5,a5,s3
    121c:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1220:	40475d1b          	sraiw	s10,a4,0x4
    1224:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    1228:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    122c:	020d0163          	beqz	s10,124e <printf+0xde>
        buf[i++] = digits[x % base];
    1230:	9d4e                	add	s10,s10,s3
    1232:	000d4783          	lbu	a5,0(s10)
    1236:	4d05                	li	s10,1
    1238:	00f108a3          	sb	a5,17(sp)
    if (sign)
    123c:	00075963          	bgez	a4,124e <printf+0xde>
        buf[i++] = digits[x % base];
    1240:	4d09                	li	s10,2
        buf[i++] = '-';
    1242:	181c                	addi	a5,sp,48
    1244:	02d00713          	li	a4,45
    1248:	97ea                	add	a5,a5,s10
    124a:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    124e:	9d5a                	add	s10,s10,s6
    1250:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1254:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1258:	4605                	li	a2,1
    125a:	1d7d                	addi	s10,s10,-1
    125c:	85a2                	mv	a1,s0
    125e:	4505                	li	a0,1
    put[0] = c;
    1260:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1264:	219000ef          	jal	ra,1c7c <write>
    while (--i >= 0)
    1268:	ffbd16e3          	bne	s10,s11,1254 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    126c:	00094303          	lbu	t1,0(s2)
    1270:	0003071b          	sext.w	a4,t1
    1274:	f60310e3          	bnez	t1,11d4 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    1278:	60ea                	ld	ra,152(sp)
    127a:	644a                	ld	s0,144(sp)
    127c:	64aa                	ld	s1,136(sp)
    127e:	690a                	ld	s2,128(sp)
    1280:	79e6                	ld	s3,120(sp)
    1282:	7a46                	ld	s4,112(sp)
    1284:	7aa6                	ld	s5,104(sp)
    1286:	7b06                	ld	s6,96(sp)
    1288:	6be6                	ld	s7,88(sp)
    128a:	6c46                	ld	s8,80(sp)
    128c:	6ca6                	ld	s9,72(sp)
    128e:	6d06                	ld	s10,64(sp)
    1290:	7de2                	ld	s11,56(sp)
    1292:	612d                	addi	sp,sp,224
    1294:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    1296:	67a2                	ld	a5,8(sp)
    1298:	0007bd03          	ld	s10,0(a5)
    129c:	07a1                	addi	a5,a5,8
    129e:	e43e                	sd	a5,8(sp)
    12a0:	000d1b63          	bnez	s10,12b6 <printf+0x146>
    12a4:	aafd                	j	14a2 <printf+0x332>
    return write(stdout, put, 1);
    12a6:	4605                	li	a2,1
    12a8:	85a2                	mv	a1,s0
    12aa:	4505                	li	a0,1
                for (; *s; s++)
    12ac:	0d05                	addi	s10,s10,1
    put[0] = c;
    12ae:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    12b2:	1cb000ef          	jal	ra,1c7c <write>
                for (; *s; s++)
    12b6:	000d4783          	lbu	a5,0(s10)
    12ba:	f7f5                	bnez	a5,12a6 <printf+0x136>
    12bc:	a02d                	j	12e6 <printf+0x176>
    return write(stdout, put, 1);
    12be:	4605                	li	a2,1
    12c0:	00001597          	auipc	a1,0x1
    12c4:	b9058593          	addi	a1,a1,-1136 # 1e50 <put.1156>
    12c8:	4505                	li	a0,1
    put[0] = c;
    12ca:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    12ce:	1af000ef          	jal	ra,1c7c <write>
    12d2:	4605                	li	a2,1
    12d4:	00001597          	auipc	a1,0x1
    12d8:	b7c58593          	addi	a1,a1,-1156 # 1e50 <put.1156>
    12dc:	4505                	li	a0,1
    put[0] = c;
    12de:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    12e2:	19b000ef          	jal	ra,1c7c <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    12e6:	00094303          	lbu	t1,0(s2)
    12ea:	0003071b          	sext.w	a4,t1
    12ee:	f80305e3          	beqz	t1,1278 <printf+0x108>
        if (c != '%') {
    12f2:	0014879b          	addiw	a5,s1,1
    12f6:	00fa8933          	add	s2,s5,a5
    12fa:	ef7703e3          	beq	a4,s7,11e0 <printf+0x70>
    return write(stdout, put, 1);
    12fe:	4605                	li	a2,1
    1300:	00001597          	auipc	a1,0x1
    1304:	b5058593          	addi	a1,a1,-1200 # 1e50 <put.1156>
    1308:	4505                	li	a0,1
    put[0] = c;
    130a:	00640023          	sb	t1,0(s0)
            continue;
    130e:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    1310:	16d000ef          	jal	ra,1c7c <write>
            continue;
    1314:	bfc9                	j	12e6 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    1316:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    1318:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    131a:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    131c:	0007b883          	ld	a7,0(a5)
    1320:	07a1                	addi	a5,a5,8
    1322:	e43e                	sd	a5,8(sp)
        x = -xx;
    1324:	43f8d713          	srai	a4,a7,0x3f
    1328:	011747b3          	xor	a5,a4,a7
    132c:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    132e:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    1330:	02c7f733          	remu	a4,a5,a2
    1334:	8d36                	mv	s10,a3
    1336:	0685                	addi	a3,a3,1
    1338:	00db0533          	add	a0,s6,a3
    133c:	85be                	mv	a1,a5
    133e:	974e                	add	a4,a4,s3
    1340:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    1344:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    1348:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    134c:	feb862e3          	bltu	a6,a1,1330 <printf+0x1c0>
    if (sign)
    1350:	1208c063          	bltz	a7,1470 <printf+0x300>
    while (--i >= 0)
    1354:	9d5a                	add	s10,s10,s6
    put[0] = c;
    1356:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    135a:	4605                	li	a2,1
    135c:	85a2                	mv	a1,s0
    135e:	4505                	li	a0,1
    put[0] = c;
    1360:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1364:	119000ef          	jal	ra,1c7c <write>
    while (--i >= 0)
    1368:	87ea                	mv	a5,s10
    136a:	1d7d                	addi	s10,s10,-1
    136c:	fefb15e3          	bne	s6,a5,1356 <printf+0x1e6>
    1370:	bf9d                	j	12e6 <printf+0x176>
                printptr(va_arg(ap, uint64));
    1372:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    1374:	4605                	li	a2,1
    1376:	00001597          	auipc	a1,0x1
    137a:	ada58593          	addi	a1,a1,-1318 # 1e50 <put.1156>
                printptr(va_arg(ap, uint64));
    137e:	0007bd83          	ld	s11,0(a5)
    1382:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    1386:	4505                	li	a0,1
    put[0] = c;
    1388:	03000793          	li	a5,48
    138c:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    1390:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    1392:	0eb000ef          	jal	ra,1c7c <write>
    put[0] = c;
    1396:	07800793          	li	a5,120
    return write(stdout, put, 1);
    139a:	4605                	li	a2,1
    139c:	00001597          	auipc	a1,0x1
    13a0:	ab458593          	addi	a1,a1,-1356 # 1e50 <put.1156>
    13a4:	4505                	li	a0,1
    put[0] = c;
    13a6:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    13aa:	4d41                	li	s10,16
    13ac:	0d1000ef          	jal	ra,1c7c <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    13b0:	03cdd793          	srli	a5,s11,0x3c
    13b4:	97ce                	add	a5,a5,s3
    put[0] = c;
    13b6:	0007c783          	lbu	a5,0(a5)
    13ba:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    13bc:	4605                	li	a2,1
    13be:	85a2                	mv	a1,s0
    13c0:	4505                	li	a0,1
    put[0] = c;
    13c2:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    13c6:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    13c8:	0b5000ef          	jal	ra,1c7c <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    13cc:	fe0d12e3          	bnez	s10,13b0 <printf+0x240>
    13d0:	bf19                	j	12e6 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    13d2:	67a2                	ld	a5,8(sp)
    13d4:	4394                	lw	a3,0(a5)
    13d6:	07a1                	addi	a5,a5,8
    13d8:	e43e                	sd	a5,8(sp)
    13da:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    13de:	0006d663          	bgez	a3,13ea <printf+0x27a>
        x = -xx;
    13e2:	40f007bb          	negw	a5,a5
    13e6:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    13ea:	4729                	li	a4,10
    13ec:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    13f0:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    13f4:	964e                	add	a2,a2,s3
    13f6:	00064603          	lbu	a2,0(a2)
    13fa:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    13fe:	0a0d0963          	beqz	s10,14b0 <printf+0x340>
        buf[i++] = digits[x % base];
    1402:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    1406:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    140a:	00c98733          	add	a4,s3,a2
    140e:	00074703          	lbu	a4,0(a4)
    1412:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    1416:	c3cd                	beqz	a5,14b8 <printf+0x348>
        buf[i++] = digits[x % base];
    1418:	97ce                	add	a5,a5,s3
    141a:	0007c703          	lbu	a4,0(a5)
    141e:	4d09                	li	s10,2
    1420:	478d                	li	a5,3
    1422:	00e10923          	sb	a4,18(sp)
    if (sign)
    1426:	0206cd63          	bltz	a3,1460 <printf+0x2f0>
    while (--i >= 0)
    142a:	9d5a                	add	s10,s10,s6
    142c:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1430:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1434:	4605                	li	a2,1
    1436:	1d7d                	addi	s10,s10,-1
    1438:	85a2                	mv	a1,s0
    143a:	4505                	li	a0,1
    put[0] = c;
    143c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1440:	03d000ef          	jal	ra,1c7c <write>
    while (--i >= 0)
    1444:	ffbd16e3          	bne	s10,s11,1430 <printf+0x2c0>
    1448:	bd79                	j	12e6 <printf+0x176>
    return write(stdout, put, 1);
    144a:	4605                	li	a2,1
    144c:	00001597          	auipc	a1,0x1
    1450:	a0458593          	addi	a1,a1,-1532 # 1e50 <put.1156>
    1454:	4505                	li	a0,1
    put[0] = c;
    1456:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    145a:	023000ef          	jal	ra,1c7c <write>
    145e:	b561                	j	12e6 <printf+0x176>
        buf[i++] = '-';
    1460:	1818                	addi	a4,sp,48
    1462:	973e                	add	a4,a4,a5
    1464:	02d00693          	li	a3,45
    1468:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    146c:	8d3e                	mv	s10,a5
    146e:	bf75                	j	142a <printf+0x2ba>
        buf[i++] = '-';
    1470:	181c                	addi	a5,sp,48
    1472:	97b6                	add	a5,a5,a3
    1474:	02d00713          	li	a4,45
    1478:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    147c:	8d36                	mv	s10,a3
    147e:	bdd9                	j	1354 <printf+0x1e4>
        x = -xx;
    1480:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    1484:	00f7f693          	andi	a3,a5,15
    1488:	96ce                	add	a3,a3,s3
    148a:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    148e:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    1492:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    1496:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    149a:	d80d1be3          	bnez	s10,1230 <printf+0xc0>
        buf[i++] = digits[x % base];
    149e:	4d05                	li	s10,1
    14a0:	b34d                	j	1242 <printf+0xd2>
                s = "(null)";
    14a2:	00001d17          	auipc	s10,0x1
    14a6:	98ed0d13          	addi	s10,s10,-1650 # 1e30 <sharedmem+0x62>
                for (; *s; s++)
    14aa:	02800793          	li	a5,40
    14ae:	bbe5                	j	12a6 <printf+0x136>
        buf[i++] = digits[x % base];
    14b0:	4785                	li	a5,1
    if (sign)
    14b2:	f606dce3          	bgez	a3,142a <printf+0x2ba>
    14b6:	b76d                	j	1460 <printf+0x2f0>
        buf[i++] = digits[x % base];
    14b8:	4789                	li	a5,2
    14ba:	4d05                	li	s10,1
    if (sign)
    14bc:	f606d7e3          	bgez	a3,142a <printf+0x2ba>
    14c0:	b745                	j	1460 <printf+0x2f0>

00000000000014c2 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    14c2:	02000793          	li	a5,32
    14c6:	00f50663          	beq	a0,a5,14d2 <isspace+0x10>
    14ca:	355d                	addiw	a0,a0,-9
    14cc:	00553513          	sltiu	a0,a0,5
    14d0:	8082                	ret
    14d2:	4505                	li	a0,1
}
    14d4:	8082                	ret

00000000000014d6 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    14d6:	fd05051b          	addiw	a0,a0,-48
}
    14da:	00a53513          	sltiu	a0,a0,10
    14de:	8082                	ret

00000000000014e0 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    14e0:	02000613          	li	a2,32
    14e4:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    14e6:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    14ea:	ff77069b          	addiw	a3,a4,-9
    14ee:	04c70d63          	beq	a4,a2,1548 <atoi+0x68>
    14f2:	0007079b          	sext.w	a5,a4
    14f6:	04d5f963          	bgeu	a1,a3,1548 <atoi+0x68>
        s++;
    switch (*s) {
    14fa:	02b00693          	li	a3,43
    14fe:	04d70a63          	beq	a4,a3,1552 <atoi+0x72>
    1502:	02d00693          	li	a3,45
    1506:	06d70463          	beq	a4,a3,156e <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    150a:	fd07859b          	addiw	a1,a5,-48
    150e:	4625                	li	a2,9
    1510:	873e                	mv	a4,a5
    1512:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1514:	4e01                	li	t3,0
    while (isdigit(*s))
    1516:	04b66a63          	bltu	a2,a1,156a <atoi+0x8a>
    int n = 0, neg = 0;
    151a:	4501                	li	a0,0
    while (isdigit(*s))
    151c:	4825                	li	a6,9
    151e:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1522:	0025179b          	slliw	a5,a0,0x2
    1526:	9d3d                	addw	a0,a0,a5
    1528:	fd07031b          	addiw	t1,a4,-48
    152c:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1530:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1534:	0685                	addi	a3,a3,1
    1536:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    153a:	0006071b          	sext.w	a4,a2
    153e:	feb870e3          	bgeu	a6,a1,151e <atoi+0x3e>
    return neg ? n : -n;
    1542:	000e0563          	beqz	t3,154c <atoi+0x6c>
}
    1546:	8082                	ret
        s++;
    1548:	0505                	addi	a0,a0,1
    154a:	bf71                	j	14e6 <atoi+0x6>
    154c:	4113053b          	subw	a0,t1,a7
    1550:	8082                	ret
    while (isdigit(*s))
    1552:	00154783          	lbu	a5,1(a0)
    1556:	4625                	li	a2,9
        s++;
    1558:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    155c:	fd07859b          	addiw	a1,a5,-48
    1560:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1564:	4e01                	li	t3,0
    while (isdigit(*s))
    1566:	fab67ae3          	bgeu	a2,a1,151a <atoi+0x3a>
    156a:	4501                	li	a0,0
}
    156c:	8082                	ret
    while (isdigit(*s))
    156e:	00154783          	lbu	a5,1(a0)
    1572:	4625                	li	a2,9
        s++;
    1574:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1578:	fd07859b          	addiw	a1,a5,-48
    157c:	0007871b          	sext.w	a4,a5
    1580:	feb665e3          	bltu	a2,a1,156a <atoi+0x8a>
        neg = 1;
    1584:	4e05                	li	t3,1
    1586:	bf51                	j	151a <atoi+0x3a>

0000000000001588 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    1588:	16060d63          	beqz	a2,1702 <memset+0x17a>
    158c:	40a007b3          	neg	a5,a0
    1590:	8b9d                	andi	a5,a5,7
    1592:	00778713          	addi	a4,a5,7
    1596:	482d                	li	a6,11
    1598:	0ff5f593          	andi	a1,a1,255
    159c:	fff60693          	addi	a3,a2,-1
    15a0:	17076263          	bltu	a4,a6,1704 <memset+0x17c>
    15a4:	16e6ea63          	bltu	a3,a4,1718 <memset+0x190>
    15a8:	16078563          	beqz	a5,1712 <memset+0x18a>
    15ac:	00b50023          	sb	a1,0(a0)
    15b0:	4705                	li	a4,1
    15b2:	00150e93          	addi	t4,a0,1
    15b6:	14e78c63          	beq	a5,a4,170e <memset+0x186>
    15ba:	00b500a3          	sb	a1,1(a0)
    15be:	4709                	li	a4,2
    15c0:	00250e93          	addi	t4,a0,2
    15c4:	14e78d63          	beq	a5,a4,171e <memset+0x196>
    15c8:	00b50123          	sb	a1,2(a0)
    15cc:	470d                	li	a4,3
    15ce:	00350e93          	addi	t4,a0,3
    15d2:	12e78b63          	beq	a5,a4,1708 <memset+0x180>
    15d6:	00b501a3          	sb	a1,3(a0)
    15da:	4711                	li	a4,4
    15dc:	00450e93          	addi	t4,a0,4
    15e0:	14e78163          	beq	a5,a4,1722 <memset+0x19a>
    15e4:	00b50223          	sb	a1,4(a0)
    15e8:	4715                	li	a4,5
    15ea:	00550e93          	addi	t4,a0,5
    15ee:	12e78c63          	beq	a5,a4,1726 <memset+0x19e>
    15f2:	00b502a3          	sb	a1,5(a0)
    15f6:	471d                	li	a4,7
    15f8:	00650e93          	addi	t4,a0,6
    15fc:	12e79763          	bne	a5,a4,172a <memset+0x1a2>
    1600:	00750e93          	addi	t4,a0,7
    1604:	00b50323          	sb	a1,6(a0)
    1608:	4f1d                	li	t5,7
    160a:	00859713          	slli	a4,a1,0x8
    160e:	8f4d                	or	a4,a4,a1
    1610:	01059e13          	slli	t3,a1,0x10
    1614:	01c76e33          	or	t3,a4,t3
    1618:	01859313          	slli	t1,a1,0x18
    161c:	006e6333          	or	t1,t3,t1
    1620:	02059893          	slli	a7,a1,0x20
    1624:	011368b3          	or	a7,t1,a7
    1628:	02859813          	slli	a6,a1,0x28
    162c:	40f60333          	sub	t1,a2,a5
    1630:	0108e833          	or	a6,a7,a6
    1634:	03059693          	slli	a3,a1,0x30
    1638:	00d866b3          	or	a3,a6,a3
    163c:	03859713          	slli	a4,a1,0x38
    1640:	97aa                	add	a5,a5,a0
    1642:	ff837813          	andi	a6,t1,-8
    1646:	8f55                	or	a4,a4,a3
    1648:	00f806b3          	add	a3,a6,a5
    164c:	e398                	sd	a4,0(a5)
    164e:	07a1                	addi	a5,a5,8
    1650:	fed79ee3          	bne	a5,a3,164c <memset+0xc4>
    1654:	ff837693          	andi	a3,t1,-8
    1658:	00de87b3          	add	a5,t4,a3
    165c:	01e6873b          	addw	a4,a3,t5
    1660:	0ad30663          	beq	t1,a3,170c <memset+0x184>
    1664:	00b78023          	sb	a1,0(a5)
    1668:	0017069b          	addiw	a3,a4,1
    166c:	08c6fb63          	bgeu	a3,a2,1702 <memset+0x17a>
    1670:	00b780a3          	sb	a1,1(a5)
    1674:	0027069b          	addiw	a3,a4,2
    1678:	08c6f563          	bgeu	a3,a2,1702 <memset+0x17a>
    167c:	00b78123          	sb	a1,2(a5)
    1680:	0037069b          	addiw	a3,a4,3
    1684:	06c6ff63          	bgeu	a3,a2,1702 <memset+0x17a>
    1688:	00b781a3          	sb	a1,3(a5)
    168c:	0047069b          	addiw	a3,a4,4
    1690:	06c6f963          	bgeu	a3,a2,1702 <memset+0x17a>
    1694:	00b78223          	sb	a1,4(a5)
    1698:	0057069b          	addiw	a3,a4,5
    169c:	06c6f363          	bgeu	a3,a2,1702 <memset+0x17a>
    16a0:	00b782a3          	sb	a1,5(a5)
    16a4:	0067069b          	addiw	a3,a4,6
    16a8:	04c6fd63          	bgeu	a3,a2,1702 <memset+0x17a>
    16ac:	00b78323          	sb	a1,6(a5)
    16b0:	0077069b          	addiw	a3,a4,7
    16b4:	04c6f763          	bgeu	a3,a2,1702 <memset+0x17a>
    16b8:	00b783a3          	sb	a1,7(a5)
    16bc:	0087069b          	addiw	a3,a4,8
    16c0:	04c6f163          	bgeu	a3,a2,1702 <memset+0x17a>
    16c4:	00b78423          	sb	a1,8(a5)
    16c8:	0097069b          	addiw	a3,a4,9
    16cc:	02c6fb63          	bgeu	a3,a2,1702 <memset+0x17a>
    16d0:	00b784a3          	sb	a1,9(a5)
    16d4:	00a7069b          	addiw	a3,a4,10
    16d8:	02c6f563          	bgeu	a3,a2,1702 <memset+0x17a>
    16dc:	00b78523          	sb	a1,10(a5)
    16e0:	00b7069b          	addiw	a3,a4,11
    16e4:	00c6ff63          	bgeu	a3,a2,1702 <memset+0x17a>
    16e8:	00b785a3          	sb	a1,11(a5)
    16ec:	00c7069b          	addiw	a3,a4,12
    16f0:	00c6f963          	bgeu	a3,a2,1702 <memset+0x17a>
    16f4:	00b78623          	sb	a1,12(a5)
    16f8:	2735                	addiw	a4,a4,13
    16fa:	00c77463          	bgeu	a4,a2,1702 <memset+0x17a>
    16fe:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    1702:	8082                	ret
    1704:	472d                	li	a4,11
    1706:	bd79                	j	15a4 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1708:	4f0d                	li	t5,3
    170a:	b701                	j	160a <memset+0x82>
    170c:	8082                	ret
    170e:	4f05                	li	t5,1
    1710:	bded                	j	160a <memset+0x82>
    1712:	8eaa                	mv	t4,a0
    1714:	4f01                	li	t5,0
    1716:	bdd5                	j	160a <memset+0x82>
    1718:	87aa                	mv	a5,a0
    171a:	4701                	li	a4,0
    171c:	b7a1                	j	1664 <memset+0xdc>
    171e:	4f09                	li	t5,2
    1720:	b5ed                	j	160a <memset+0x82>
    1722:	4f11                	li	t5,4
    1724:	b5dd                	j	160a <memset+0x82>
    1726:	4f15                	li	t5,5
    1728:	b5cd                	j	160a <memset+0x82>
    172a:	4f19                	li	t5,6
    172c:	bdf9                	j	160a <memset+0x82>

000000000000172e <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    172e:	00054783          	lbu	a5,0(a0)
    1732:	0005c703          	lbu	a4,0(a1)
    1736:	00e79863          	bne	a5,a4,1746 <strcmp+0x18>
    173a:	0505                	addi	a0,a0,1
    173c:	0585                	addi	a1,a1,1
    173e:	fbe5                	bnez	a5,172e <strcmp>
    1740:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    1742:	9d19                	subw	a0,a0,a4
    1744:	8082                	ret
    1746:	0007851b          	sext.w	a0,a5
    174a:	bfe5                	j	1742 <strcmp+0x14>

000000000000174c <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    174c:	87aa                	mv	a5,a0
    174e:	0005c703          	lbu	a4,0(a1)
    1752:	0785                	addi	a5,a5,1
    1754:	0585                	addi	a1,a1,1
    1756:	fee78fa3          	sb	a4,-1(a5)
    175a:	fb75                	bnez	a4,174e <strcpy+0x2>
        ;
    return os;
}
    175c:	8082                	ret

000000000000175e <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    175e:	ce05                	beqz	a2,1796 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1760:	00054703          	lbu	a4,0(a0)
    1764:	0005c783          	lbu	a5,0(a1)
    1768:	cb0d                	beqz	a4,179a <strncmp+0x3c>
    if (!n--)
    176a:	167d                	addi	a2,a2,-1
    176c:	00c506b3          	add	a3,a0,a2
    1770:	a819                	j	1786 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1772:	00a68e63          	beq	a3,a0,178e <strncmp+0x30>
    1776:	0505                	addi	a0,a0,1
    1778:	00e79b63          	bne	a5,a4,178e <strncmp+0x30>
    177c:	00054703          	lbu	a4,0(a0)
    1780:	0005c783          	lbu	a5,0(a1)
    1784:	cb19                	beqz	a4,179a <strncmp+0x3c>
    1786:	0005c783          	lbu	a5,0(a1)
    178a:	0585                	addi	a1,a1,1
    178c:	f3fd                	bnez	a5,1772 <strncmp+0x14>
        ;
    return *l - *r;
    178e:	0007051b          	sext.w	a0,a4
    1792:	9d1d                	subw	a0,a0,a5
    1794:	8082                	ret
        return 0;
    1796:	4501                	li	a0,0
}
    1798:	8082                	ret
    179a:	4501                	li	a0,0
    return *l - *r;
    179c:	9d1d                	subw	a0,a0,a5
    179e:	8082                	ret

00000000000017a0 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    17a0:	00757793          	andi	a5,a0,7
    17a4:	cf89                	beqz	a5,17be <strlen+0x1e>
    17a6:	87aa                	mv	a5,a0
    17a8:	a029                	j	17b2 <strlen+0x12>
    17aa:	0785                	addi	a5,a5,1
    17ac:	0077f713          	andi	a4,a5,7
    17b0:	cb01                	beqz	a4,17c0 <strlen+0x20>
        if (!*s)
    17b2:	0007c703          	lbu	a4,0(a5)
    17b6:	fb75                	bnez	a4,17aa <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    17b8:	40a78533          	sub	a0,a5,a0
}
    17bc:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    17be:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    17c0:	6394                	ld	a3,0(a5)
    17c2:	00000597          	auipc	a1,0x0
    17c6:	6765b583          	ld	a1,1654(a1) # 1e38 <sharedmem+0x6a>
    17ca:	00000617          	auipc	a2,0x0
    17ce:	67663603          	ld	a2,1654(a2) # 1e40 <sharedmem+0x72>
    17d2:	a019                	j	17d8 <strlen+0x38>
    17d4:	6794                	ld	a3,8(a5)
    17d6:	07a1                	addi	a5,a5,8
    17d8:	00b68733          	add	a4,a3,a1
    17dc:	fff6c693          	not	a3,a3
    17e0:	8f75                	and	a4,a4,a3
    17e2:	8f71                	and	a4,a4,a2
    17e4:	db65                	beqz	a4,17d4 <strlen+0x34>
    for (; *s; s++)
    17e6:	0007c703          	lbu	a4,0(a5)
    17ea:	d779                	beqz	a4,17b8 <strlen+0x18>
    17ec:	0017c703          	lbu	a4,1(a5)
    17f0:	0785                	addi	a5,a5,1
    17f2:	d379                	beqz	a4,17b8 <strlen+0x18>
    17f4:	0017c703          	lbu	a4,1(a5)
    17f8:	0785                	addi	a5,a5,1
    17fa:	fb6d                	bnez	a4,17ec <strlen+0x4c>
    17fc:	bf75                	j	17b8 <strlen+0x18>

00000000000017fe <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    17fe:	00757713          	andi	a4,a0,7
{
    1802:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1804:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1808:	cb19                	beqz	a4,181e <memchr+0x20>
    180a:	ce25                	beqz	a2,1882 <memchr+0x84>
    180c:	0007c703          	lbu	a4,0(a5)
    1810:	04b70e63          	beq	a4,a1,186c <memchr+0x6e>
    1814:	0785                	addi	a5,a5,1
    1816:	0077f713          	andi	a4,a5,7
    181a:	167d                	addi	a2,a2,-1
    181c:	f77d                	bnez	a4,180a <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    181e:	4501                	li	a0,0
    if (n && *s != c) {
    1820:	c235                	beqz	a2,1884 <memchr+0x86>
    1822:	0007c703          	lbu	a4,0(a5)
    1826:	04b70363          	beq	a4,a1,186c <memchr+0x6e>
        size_t k = ONES * c;
    182a:	00000517          	auipc	a0,0x0
    182e:	61e53503          	ld	a0,1566(a0) # 1e48 <sharedmem+0x7a>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1832:	471d                	li	a4,7
        size_t k = ONES * c;
    1834:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1838:	02c77a63          	bgeu	a4,a2,186c <memchr+0x6e>
    183c:	00000897          	auipc	a7,0x0
    1840:	5fc8b883          	ld	a7,1532(a7) # 1e38 <sharedmem+0x6a>
    1844:	00000817          	auipc	a6,0x0
    1848:	5fc83803          	ld	a6,1532(a6) # 1e40 <sharedmem+0x72>
    184c:	431d                	li	t1,7
    184e:	a029                	j	1858 <memchr+0x5a>
    1850:	1661                	addi	a2,a2,-8
    1852:	07a1                	addi	a5,a5,8
    1854:	02c37963          	bgeu	t1,a2,1886 <memchr+0x88>
    1858:	6398                	ld	a4,0(a5)
    185a:	8f29                	xor	a4,a4,a0
    185c:	011706b3          	add	a3,a4,a7
    1860:	fff74713          	not	a4,a4
    1864:	8f75                	and	a4,a4,a3
    1866:	01077733          	and	a4,a4,a6
    186a:	d37d                	beqz	a4,1850 <memchr+0x52>
    186c:	853e                	mv	a0,a5
    186e:	97b2                	add	a5,a5,a2
    1870:	a021                	j	1878 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1872:	0505                	addi	a0,a0,1
    1874:	00f50763          	beq	a0,a5,1882 <memchr+0x84>
    1878:	00054703          	lbu	a4,0(a0)
    187c:	feb71be3          	bne	a4,a1,1872 <memchr+0x74>
    1880:	8082                	ret
    return n ? (void*)s : 0;
    1882:	4501                	li	a0,0
}
    1884:	8082                	ret
    return n ? (void*)s : 0;
    1886:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1888:	f275                	bnez	a2,186c <memchr+0x6e>
}
    188a:	8082                	ret

000000000000188c <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    188c:	1101                	addi	sp,sp,-32
    188e:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1890:	862e                	mv	a2,a1
{
    1892:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1894:	4581                	li	a1,0
{
    1896:	e426                	sd	s1,8(sp)
    1898:	ec06                	sd	ra,24(sp)
    189a:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    189c:	f63ff0ef          	jal	ra,17fe <memchr>
    return p ? p - s : n;
    18a0:	c519                	beqz	a0,18ae <strnlen+0x22>
}
    18a2:	60e2                	ld	ra,24(sp)
    18a4:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    18a6:	8d05                	sub	a0,a0,s1
}
    18a8:	64a2                	ld	s1,8(sp)
    18aa:	6105                	addi	sp,sp,32
    18ac:	8082                	ret
    18ae:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    18b0:	8522                	mv	a0,s0
}
    18b2:	6442                	ld	s0,16(sp)
    18b4:	64a2                	ld	s1,8(sp)
    18b6:	6105                	addi	sp,sp,32
    18b8:	8082                	ret

00000000000018ba <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    18ba:	00b547b3          	xor	a5,a0,a1
    18be:	8b9d                	andi	a5,a5,7
    18c0:	eb95                	bnez	a5,18f4 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    18c2:	0075f793          	andi	a5,a1,7
    18c6:	e7b1                	bnez	a5,1912 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    18c8:	6198                	ld	a4,0(a1)
    18ca:	00000617          	auipc	a2,0x0
    18ce:	56e63603          	ld	a2,1390(a2) # 1e38 <sharedmem+0x6a>
    18d2:	00000817          	auipc	a6,0x0
    18d6:	56e83803          	ld	a6,1390(a6) # 1e40 <sharedmem+0x72>
    18da:	a029                	j	18e4 <stpcpy+0x2a>
    18dc:	e118                	sd	a4,0(a0)
    18de:	6598                	ld	a4,8(a1)
    18e0:	05a1                	addi	a1,a1,8
    18e2:	0521                	addi	a0,a0,8
    18e4:	00c707b3          	add	a5,a4,a2
    18e8:	fff74693          	not	a3,a4
    18ec:	8ff5                	and	a5,a5,a3
    18ee:	0107f7b3          	and	a5,a5,a6
    18f2:	d7ed                	beqz	a5,18dc <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    18f4:	0005c783          	lbu	a5,0(a1)
    18f8:	00f50023          	sb	a5,0(a0)
    18fc:	c785                	beqz	a5,1924 <stpcpy+0x6a>
    18fe:	0015c783          	lbu	a5,1(a1)
    1902:	0505                	addi	a0,a0,1
    1904:	0585                	addi	a1,a1,1
    1906:	00f50023          	sb	a5,0(a0)
    190a:	fbf5                	bnez	a5,18fe <stpcpy+0x44>
        ;
    return d;
}
    190c:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    190e:	0505                	addi	a0,a0,1
    1910:	df45                	beqz	a4,18c8 <stpcpy+0xe>
            if (!(*d = *s))
    1912:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1916:	0585                	addi	a1,a1,1
    1918:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    191c:	00f50023          	sb	a5,0(a0)
    1920:	f7fd                	bnez	a5,190e <stpcpy+0x54>
}
    1922:	8082                	ret
    1924:	8082                	ret

0000000000001926 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1926:	00b547b3          	xor	a5,a0,a1
    192a:	8b9d                	andi	a5,a5,7
    192c:	1a079863          	bnez	a5,1adc <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1930:	0075f793          	andi	a5,a1,7
    1934:	16078463          	beqz	a5,1a9c <stpncpy+0x176>
    1938:	ea01                	bnez	a2,1948 <stpncpy+0x22>
    193a:	a421                	j	1b42 <stpncpy+0x21c>
    193c:	167d                	addi	a2,a2,-1
    193e:	0505                	addi	a0,a0,1
    1940:	14070e63          	beqz	a4,1a9c <stpncpy+0x176>
    1944:	1a060863          	beqz	a2,1af4 <stpncpy+0x1ce>
    1948:	0005c783          	lbu	a5,0(a1)
    194c:	0585                	addi	a1,a1,1
    194e:	0075f713          	andi	a4,a1,7
    1952:	00f50023          	sb	a5,0(a0)
    1956:	f3fd                	bnez	a5,193c <stpncpy+0x16>
    1958:	4805                	li	a6,1
    195a:	1a061863          	bnez	a2,1b0a <stpncpy+0x1e4>
    195e:	40a007b3          	neg	a5,a0
    1962:	8b9d                	andi	a5,a5,7
    1964:	4681                	li	a3,0
    1966:	18061a63          	bnez	a2,1afa <stpncpy+0x1d4>
    196a:	00778713          	addi	a4,a5,7
    196e:	45ad                	li	a1,11
    1970:	18b76363          	bltu	a4,a1,1af6 <stpncpy+0x1d0>
    1974:	1ae6eb63          	bltu	a3,a4,1b2a <stpncpy+0x204>
    1978:	1a078363          	beqz	a5,1b1e <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    197c:	00050023          	sb	zero,0(a0)
    1980:	4685                	li	a3,1
    1982:	00150713          	addi	a4,a0,1
    1986:	18d78f63          	beq	a5,a3,1b24 <stpncpy+0x1fe>
    198a:	000500a3          	sb	zero,1(a0)
    198e:	4689                	li	a3,2
    1990:	00250713          	addi	a4,a0,2
    1994:	18d78e63          	beq	a5,a3,1b30 <stpncpy+0x20a>
    1998:	00050123          	sb	zero,2(a0)
    199c:	468d                	li	a3,3
    199e:	00350713          	addi	a4,a0,3
    19a2:	16d78c63          	beq	a5,a3,1b1a <stpncpy+0x1f4>
    19a6:	000501a3          	sb	zero,3(a0)
    19aa:	4691                	li	a3,4
    19ac:	00450713          	addi	a4,a0,4
    19b0:	18d78263          	beq	a5,a3,1b34 <stpncpy+0x20e>
    19b4:	00050223          	sb	zero,4(a0)
    19b8:	4695                	li	a3,5
    19ba:	00550713          	addi	a4,a0,5
    19be:	16d78d63          	beq	a5,a3,1b38 <stpncpy+0x212>
    19c2:	000502a3          	sb	zero,5(a0)
    19c6:	469d                	li	a3,7
    19c8:	00650713          	addi	a4,a0,6
    19cc:	16d79863          	bne	a5,a3,1b3c <stpncpy+0x216>
    19d0:	00750713          	addi	a4,a0,7
    19d4:	00050323          	sb	zero,6(a0)
    19d8:	40f80833          	sub	a6,a6,a5
    19dc:	ff887593          	andi	a1,a6,-8
    19e0:	97aa                	add	a5,a5,a0
    19e2:	95be                	add	a1,a1,a5
    19e4:	0007b023          	sd	zero,0(a5)
    19e8:	07a1                	addi	a5,a5,8
    19ea:	feb79de3          	bne	a5,a1,19e4 <stpncpy+0xbe>
    19ee:	ff887593          	andi	a1,a6,-8
    19f2:	9ead                	addw	a3,a3,a1
    19f4:	00b707b3          	add	a5,a4,a1
    19f8:	12b80863          	beq	a6,a1,1b28 <stpncpy+0x202>
    19fc:	00078023          	sb	zero,0(a5)
    1a00:	0016871b          	addiw	a4,a3,1
    1a04:	0ec77863          	bgeu	a4,a2,1af4 <stpncpy+0x1ce>
    1a08:	000780a3          	sb	zero,1(a5)
    1a0c:	0026871b          	addiw	a4,a3,2
    1a10:	0ec77263          	bgeu	a4,a2,1af4 <stpncpy+0x1ce>
    1a14:	00078123          	sb	zero,2(a5)
    1a18:	0036871b          	addiw	a4,a3,3
    1a1c:	0cc77c63          	bgeu	a4,a2,1af4 <stpncpy+0x1ce>
    1a20:	000781a3          	sb	zero,3(a5)
    1a24:	0046871b          	addiw	a4,a3,4
    1a28:	0cc77663          	bgeu	a4,a2,1af4 <stpncpy+0x1ce>
    1a2c:	00078223          	sb	zero,4(a5)
    1a30:	0056871b          	addiw	a4,a3,5
    1a34:	0cc77063          	bgeu	a4,a2,1af4 <stpncpy+0x1ce>
    1a38:	000782a3          	sb	zero,5(a5)
    1a3c:	0066871b          	addiw	a4,a3,6
    1a40:	0ac77a63          	bgeu	a4,a2,1af4 <stpncpy+0x1ce>
    1a44:	00078323          	sb	zero,6(a5)
    1a48:	0076871b          	addiw	a4,a3,7
    1a4c:	0ac77463          	bgeu	a4,a2,1af4 <stpncpy+0x1ce>
    1a50:	000783a3          	sb	zero,7(a5)
    1a54:	0086871b          	addiw	a4,a3,8
    1a58:	08c77e63          	bgeu	a4,a2,1af4 <stpncpy+0x1ce>
    1a5c:	00078423          	sb	zero,8(a5)
    1a60:	0096871b          	addiw	a4,a3,9
    1a64:	08c77863          	bgeu	a4,a2,1af4 <stpncpy+0x1ce>
    1a68:	000784a3          	sb	zero,9(a5)
    1a6c:	00a6871b          	addiw	a4,a3,10
    1a70:	08c77263          	bgeu	a4,a2,1af4 <stpncpy+0x1ce>
    1a74:	00078523          	sb	zero,10(a5)
    1a78:	00b6871b          	addiw	a4,a3,11
    1a7c:	06c77c63          	bgeu	a4,a2,1af4 <stpncpy+0x1ce>
    1a80:	000785a3          	sb	zero,11(a5)
    1a84:	00c6871b          	addiw	a4,a3,12
    1a88:	06c77663          	bgeu	a4,a2,1af4 <stpncpy+0x1ce>
    1a8c:	00078623          	sb	zero,12(a5)
    1a90:	26b5                	addiw	a3,a3,13
    1a92:	06c6f163          	bgeu	a3,a2,1af4 <stpncpy+0x1ce>
    1a96:	000786a3          	sb	zero,13(a5)
    1a9a:	8082                	ret
            ;
        if (!n || !*s)
    1a9c:	c645                	beqz	a2,1b44 <stpncpy+0x21e>
    1a9e:	0005c783          	lbu	a5,0(a1)
    1aa2:	ea078be3          	beqz	a5,1958 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1aa6:	479d                	li	a5,7
    1aa8:	02c7ff63          	bgeu	a5,a2,1ae6 <stpncpy+0x1c0>
    1aac:	00000897          	auipc	a7,0x0
    1ab0:	38c8b883          	ld	a7,908(a7) # 1e38 <sharedmem+0x6a>
    1ab4:	00000817          	auipc	a6,0x0
    1ab8:	38c83803          	ld	a6,908(a6) # 1e40 <sharedmem+0x72>
    1abc:	431d                	li	t1,7
    1abe:	6198                	ld	a4,0(a1)
    1ac0:	011707b3          	add	a5,a4,a7
    1ac4:	fff74693          	not	a3,a4
    1ac8:	8ff5                	and	a5,a5,a3
    1aca:	0107f7b3          	and	a5,a5,a6
    1ace:	ef81                	bnez	a5,1ae6 <stpncpy+0x1c0>
            *wd = *ws;
    1ad0:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1ad2:	1661                	addi	a2,a2,-8
    1ad4:	05a1                	addi	a1,a1,8
    1ad6:	0521                	addi	a0,a0,8
    1ad8:	fec363e3          	bltu	t1,a2,1abe <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1adc:	e609                	bnez	a2,1ae6 <stpncpy+0x1c0>
    1ade:	a08d                	j	1b40 <stpncpy+0x21a>
    1ae0:	167d                	addi	a2,a2,-1
    1ae2:	0505                	addi	a0,a0,1
    1ae4:	ca01                	beqz	a2,1af4 <stpncpy+0x1ce>
    1ae6:	0005c783          	lbu	a5,0(a1)
    1aea:	0585                	addi	a1,a1,1
    1aec:	00f50023          	sb	a5,0(a0)
    1af0:	fbe5                	bnez	a5,1ae0 <stpncpy+0x1ba>
        ;
tail:
    1af2:	b59d                	j	1958 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1af4:	8082                	ret
    1af6:	472d                	li	a4,11
    1af8:	bdb5                	j	1974 <stpncpy+0x4e>
    1afa:	00778713          	addi	a4,a5,7
    1afe:	45ad                	li	a1,11
    1b00:	fff60693          	addi	a3,a2,-1
    1b04:	e6b778e3          	bgeu	a4,a1,1974 <stpncpy+0x4e>
    1b08:	b7fd                	j	1af6 <stpncpy+0x1d0>
    1b0a:	40a007b3          	neg	a5,a0
    1b0e:	8832                	mv	a6,a2
    1b10:	8b9d                	andi	a5,a5,7
    1b12:	4681                	li	a3,0
    1b14:	e4060be3          	beqz	a2,196a <stpncpy+0x44>
    1b18:	b7cd                	j	1afa <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1b1a:	468d                	li	a3,3
    1b1c:	bd75                	j	19d8 <stpncpy+0xb2>
    1b1e:	872a                	mv	a4,a0
    1b20:	4681                	li	a3,0
    1b22:	bd5d                	j	19d8 <stpncpy+0xb2>
    1b24:	4685                	li	a3,1
    1b26:	bd4d                	j	19d8 <stpncpy+0xb2>
    1b28:	8082                	ret
    1b2a:	87aa                	mv	a5,a0
    1b2c:	4681                	li	a3,0
    1b2e:	b5f9                	j	19fc <stpncpy+0xd6>
    1b30:	4689                	li	a3,2
    1b32:	b55d                	j	19d8 <stpncpy+0xb2>
    1b34:	4691                	li	a3,4
    1b36:	b54d                	j	19d8 <stpncpy+0xb2>
    1b38:	4695                	li	a3,5
    1b3a:	bd79                	j	19d8 <stpncpy+0xb2>
    1b3c:	4699                	li	a3,6
    1b3e:	bd69                	j	19d8 <stpncpy+0xb2>
    1b40:	8082                	ret
    1b42:	8082                	ret
    1b44:	8082                	ret

0000000000001b46 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1b46:	fff6071b          	addiw	a4,a2,-1
    1b4a:	0cb57063          	bgeu	a0,a1,1c0a <memmove+0xc4>
        while (n-- > 0)
    1b4e:	0ec05063          	blez	a2,1c2e <memmove+0xe8>
    1b52:	00750693          	addi	a3,a0,7
    1b56:	8e8d                	sub	a3,a3,a1
    1b58:	00b567b3          	or	a5,a0,a1
    1b5c:	00f6b693          	sltiu	a3,a3,15
    1b60:	8b9d                	andi	a5,a5,7
    1b62:	0016c693          	xori	a3,a3,1
    1b66:	0017b793          	seqz	a5,a5
    1b6a:	8ff5                	and	a5,a5,a3
    1b6c:	c3f1                	beqz	a5,1c30 <memmove+0xea>
    1b6e:	0007079b          	sext.w	a5,a4
    1b72:	46a5                	li	a3,9
    1b74:	0af6fe63          	bgeu	a3,a5,1c30 <memmove+0xea>
    1b78:	0036589b          	srliw	a7,a2,0x3
    1b7c:	088e                	slli	a7,a7,0x3
    1b7e:	2601                	sext.w	a2,a2
    1b80:	87ae                	mv	a5,a1
    1b82:	86aa                	mv	a3,a0
    1b84:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1b86:	0007b803          	ld	a6,0(a5)
    1b8a:	07a1                	addi	a5,a5,8
    1b8c:	06a1                	addi	a3,a3,8
    1b8e:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1b92:	ff179ae3          	bne	a5,a7,1b86 <memmove+0x40>
    1b96:	ff867813          	andi	a6,a2,-8
    1b9a:	02081793          	slli	a5,a6,0x20
    1b9e:	9381                	srli	a5,a5,0x20
    1ba0:	00f506b3          	add	a3,a0,a5
    1ba4:	95be                	add	a1,a1,a5
    1ba6:	4107073b          	subw	a4,a4,a6
    1baa:	09060263          	beq	a2,a6,1c2e <memmove+0xe8>
            *dst++ = *src++;
    1bae:	0005c783          	lbu	a5,0(a1)
    1bb2:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1bb6:	06e05c63          	blez	a4,1c2e <memmove+0xe8>
            *dst++ = *src++;
    1bba:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1bbe:	4785                	li	a5,1
            *dst++ = *src++;
    1bc0:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1bc4:	06e7d563          	bge	a5,a4,1c2e <memmove+0xe8>
            *dst++ = *src++;
    1bc8:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1bcc:	4789                	li	a5,2
            *dst++ = *src++;
    1bce:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1bd2:	04e7de63          	bge	a5,a4,1c2e <memmove+0xe8>
            *dst++ = *src++;
    1bd6:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1bda:	478d                	li	a5,3
            *dst++ = *src++;
    1bdc:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1be0:	04e7d763          	bge	a5,a4,1c2e <memmove+0xe8>
            *dst++ = *src++;
    1be4:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1be8:	4791                	li	a5,4
            *dst++ = *src++;
    1bea:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1bee:	04e7d063          	bge	a5,a4,1c2e <memmove+0xe8>
            *dst++ = *src++;
    1bf2:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1bf6:	4795                	li	a5,5
            *dst++ = *src++;
    1bf8:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1bfc:	02e7d963          	bge	a5,a4,1c2e <memmove+0xe8>
            *dst++ = *src++;
    1c00:	0065c783          	lbu	a5,6(a1)
    1c04:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1c08:	8082                	ret
    } else {
        dst += n;
    1c0a:	00c507b3          	add	a5,a0,a2
        src += n;
    1c0e:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1c10:	00c05f63          	blez	a2,1c2e <memmove+0xe8>
    1c14:	1702                	slli	a4,a4,0x20
    1c16:	9301                	srli	a4,a4,0x20
    1c18:	fff74713          	not	a4,a4
    1c1c:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1c1e:	fff5c683          	lbu	a3,-1(a1)
    1c22:	17fd                	addi	a5,a5,-1
    1c24:	15fd                	addi	a1,a1,-1
    1c26:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1c2a:	fee79ae3          	bne	a5,a4,1c1e <memmove+0xd8>
    }
    return vdst;
}
    1c2e:	8082                	ret
    1c30:	02071693          	slli	a3,a4,0x20
    1c34:	9281                	srli	a3,a3,0x20
    1c36:	0685                	addi	a3,a3,1
    1c38:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1c3a:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1c3c:	0005c703          	lbu	a4,0(a1)
    1c40:	0585                	addi	a1,a1,1
    1c42:	0785                	addi	a5,a5,1
    1c44:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1c48:	fed59ae3          	bne	a1,a3,1c3c <memmove+0xf6>
    1c4c:	8082                	ret

0000000000001c4e <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1c4e:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c52:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1c56:	2501                	sext.w	a0,a0
    1c58:	8082                	ret

0000000000001c5a <exec>:
    register long a7 __asm__("a7") = n;
    1c5a:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1c5e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c60:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1c64:	2501                	sext.w	a0,a0
    1c66:	8082                	ret

0000000000001c68 <exit>:
    register long a7 __asm__("a7") = n;
    1c68:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1c6c:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1c70:	8082                	ret

0000000000001c72 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1c72:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c76:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1c7a:	8082                	ret

0000000000001c7c <write>:
    register long a7 __asm__("a7") = n;
    1c7c:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c80:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1c84:	8082                	ret

0000000000001c86 <getpid>:
    register long a7 __asm__("a7") = n;
    1c86:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c8a:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c8e:	2501                	sext.w	a0,a0
    1c90:	8082                	ret

0000000000001c92 <getppid>:
    register long a7 __asm__("a7") = n;
    1c92:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c96:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c9a:	2501                	sext.w	a0,a0
    1c9c:	8082                	ret

0000000000001c9e <open>:
    register long a7 __asm__("a7") = n;
    1c9e:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ca2:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1ca6:	2501                	sext.w	a0,a0
    1ca8:	8082                	ret

0000000000001caa <mknod>:
    register long a7 __asm__("a7") = n;
    1caa:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1cae:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1cb2:	2501                	sext.w	a0,a0
    1cb4:	8082                	ret

0000000000001cb6 <dup>:
    register long a7 __asm__("a7") = n;
    1cb6:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1cb8:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1cbc:	2501                	sext.w	a0,a0
    1cbe:	8082                	ret

0000000000001cc0 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1cc0:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cc4:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1cc8:	2501                	sext.w	a0,a0
    1cca:	8082                	ret

0000000000001ccc <waitpid>:
    register long a7 __asm__("a7") = n;
    1ccc:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cd0:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1cd4:	2501                	sext.w	a0,a0
    1cd6:	8082                	ret

0000000000001cd8 <wait>:

pid_t wait(int *wstatus)
{
    1cd8:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1cda:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1cde:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ce0:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1ce4:	2501                	sext.w	a0,a0
    1ce6:	8082                	ret

0000000000001ce8 <mkdir>:
    register long a7 __asm__("a7") = n;
    1ce8:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1cec:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1cf0:	2501                	sext.w	a0,a0
    1cf2:	8082                	ret

0000000000001cf4 <close>:
    register long a7 __asm__("a7") = n;
    1cf4:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1cf8:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1cfc:	2501                	sext.w	a0,a0
    1cfe:	8082                	ret

0000000000001d00 <fork>:
    register long a7 __asm__("a7") = n;
    1d00:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1d04:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1d08:	2501                	sext.w	a0,a0
    1d0a:	8082                	ret

0000000000001d0c <time_ms>:
    register long a7 __asm__("a7") = n;
    1d0c:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d10:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1d14:	8082                	ret

0000000000001d16 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1d16:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1d18:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d1c:	00000073          	ecall
    1d20:	87aa                	mv	a5,a0
    1d22:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1d26:	97ba                	add	a5,a5,a4
    1d28:	00f57c63          	bgeu	a0,a5,1d40 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1d2c:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1d30:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d34:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d38:	00000073          	ecall
    1d3c:	fef568e3          	bltu	a0,a5,1d2c <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1d40:	4501                	li	a0,0
    1d42:	8082                	ret

0000000000001d44 <pipe>:
    register long a7 __asm__("a7") = n;
    1d44:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1d48:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1d4c:	2501                	sext.w	a0,a0
    1d4e:	8082                	ret

0000000000001d50 <fstat>:
    register long a7 __asm__("a7") = n;
    1d50:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d54:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1d58:	2501                	sext.w	a0,a0
    1d5a:	8082                	ret

0000000000001d5c <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1d5c:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1d5e:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1d62:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d64:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1d68:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1d6c:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1d70:	0206c163          	bltz	a3,1d92 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1d74:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1d78:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1d7a:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d7c:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d80:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1d84:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1d88:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1d8a:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1d8e:	853e                	mv	a0,a5
    1d90:	8082                	ret
        return -1;
    1d92:	57fd                	li	a5,-1
    1d94:	bfed                	j	1d8e <stat+0x32>

0000000000001d96 <chdir>:
    register long a7 __asm__("a7") = n;
    1d96:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1d9a:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1d9e:	2501                	sext.w	a0,a0
    1da0:	8082                	ret

0000000000001da2 <link>:
    register long a7 __asm__("a7") = n;
    1da2:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1da6:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1daa:	2501                	sext.w	a0,a0
    1dac:	8082                	ret

0000000000001dae <unlink>:
    register long a7 __asm__("a7") = n;
    1dae:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1db2:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1db6:	2501                	sext.w	a0,a0
    1db8:	8082                	ret

0000000000001dba <setpriority>:
    register long a7 __asm__("a7") = n;
    1dba:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1dbe:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1dc2:	8082                	ret

0000000000001dc4 <getpriority>:
    register long a7 __asm__("a7") = n;
    1dc4:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1dc8:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1dcc:	8082                	ret

0000000000001dce <sharedmem>:
    register long a7 __asm__("a7") = n;
    1dce:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1dd2:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1dd6:	8082                	ret
