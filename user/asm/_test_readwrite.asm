
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_readwrite:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a065                	j	10a8 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <stdlib.h>
#include <ucore.h>
#include <fcntl.h>
#include <string.h>

int main() {
    1002:	cf010113          	addi	sp,sp,-784
    int fd = open("poem.txt", O_CREATE | O_WRONLY);
    1006:	20100593          	li	a1,513
    100a:	00001517          	auipc	a0,0x1
    100e:	d9e50513          	addi	a0,a0,-610 # 1da8 <sharedmem+0xc>
int main() {
    1012:	30113423          	sd	ra,776(sp)
    1016:	30813023          	sd	s0,768(sp)
    int fd = open("poem.txt", O_CREATE | O_WRONLY);
    101a:	453000ef          	jal	ra,1c6c <open>
    printf("open OK, fd = %d\n", fd);
    101e:	85aa                	mv	a1,a0
    int fd = open("poem.txt", O_CREATE | O_WRONLY);
    1020:	842a                	mv	s0,a0
    printf("open OK, fd = %d\n", fd);
    1022:	00001517          	auipc	a0,0x1
    1026:	d9650513          	addi	a0,a0,-618 # 1db8 <sharedmem+0x1c>
    102a:	114000ef          	jal	ra,113e <printf>
    char str[] = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.\n";
    102e:	00001797          	auipc	a5,0x1
    1032:	dba78793          	addi	a5,a5,-582 # 1de8 <sharedmem+0x4c>
    1036:	870a                	mv	a4,sp
    1038:	00001697          	auipc	a3,0x1
    103c:	0a868693          	addi	a3,a3,168 # 20e0 <sharedmem+0x344>
    1040:	0007b883          	ld	a7,0(a5)
    1044:	0087b803          	ld	a6,8(a5)
    1048:	6b88                	ld	a0,16(a5)
    104a:	6f8c                	ld	a1,24(a5)
    104c:	7390                	ld	a2,32(a5)
    104e:	01173023          	sd	a7,0(a4)
    1052:	01073423          	sd	a6,8(a4)
    1056:	eb08                	sd	a0,16(a4)
    1058:	ef0c                	sd	a1,24(a4)
    105a:	f310                	sd	a2,32(a4)
    105c:	02878793          	addi	a5,a5,40
    1060:	02870713          	addi	a4,a4,40
    1064:	fcd79ee3          	bne	a5,a3,1040 <main+0x3e>
    1068:	4394                	lw	a3,0(a5)
    106a:	0047c783          	lbu	a5,4(a5)
    int len = strlen(str);
    106e:	850a                	mv	a0,sp
    char str[] = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.\n";
    1070:	c314                	sw	a3,0(a4)
    1072:	00f70223          	sb	a5,4(a4)
    int len = strlen(str);
    1076:	6f8000ef          	jal	ra,176e <strlen>
    write(fd, str, len);
    107a:	0005061b          	sext.w	a2,a0
    107e:	858a                	mv	a1,sp
    1080:	8522                	mv	a0,s0
    1082:	3c9000ef          	jal	ra,1c4a <write>
    close(fd);
    1086:	8522                	mv	a0,s0
    1088:	43b000ef          	jal	ra,1cc2 <close>
    puts("write poem.txt over.");
    108c:	00001517          	auipc	a0,0x1
    1090:	d4450513          	addi	a0,a0,-700 # 1dd0 <sharedmem+0x34>
    1094:	064000ef          	jal	ra,10f8 <puts>
    return 0;
    1098:	30813083          	ld	ra,776(sp)
    109c:	30013403          	ld	s0,768(sp)
    10a0:	4501                	li	a0,0
    10a2:	31010113          	addi	sp,sp,784
    10a6:	8082                	ret

00000000000010a8 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    10a8:	1141                	addi	sp,sp,-16
    10aa:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    10ac:	f57ff0ef          	jal	ra,1002 <main>
}
    10b0:	60a2                	ld	ra,8(sp)
    10b2:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    10b4:	3830006f          	j	1c36 <exit>

00000000000010b8 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    10b8:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    10ba:	00f10593          	addi	a1,sp,15
    10be:	4605                	li	a2,1
    10c0:	4501                	li	a0,0
int getchar() {
    10c2:	ec06                	sd	ra,24(sp)
    char byte = 0;
    10c4:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    10c8:	379000ef          	jal	ra,1c40 <read>
    return byte;
}
    10cc:	60e2                	ld	ra,24(sp)
    10ce:	00f14503          	lbu	a0,15(sp)
    10d2:	6105                	addi	sp,sp,32
    10d4:	8082                	ret

00000000000010d6 <putchar>:

int putchar(int c)
{
    10d6:	1141                	addi	sp,sp,-16
    10d8:	e406                	sd	ra,8(sp)
    10da:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    10dc:	00001597          	auipc	a1,0x1
    10e0:	02c58593          	addi	a1,a1,44 # 2108 <put.1156>
    return write(stdout, put, 1);
    10e4:	4605                	li	a2,1
    10e6:	4505                	li	a0,1
    put[0] = c;
    10e8:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    10ec:	35f000ef          	jal	ra,1c4a <write>
}
    10f0:	60a2                	ld	ra,8(sp)
    10f2:	2501                	sext.w	a0,a0
    10f4:	0141                	addi	sp,sp,16
    10f6:	8082                	ret

00000000000010f8 <puts>:

int puts(const char* s)
{
    10f8:	1141                	addi	sp,sp,-16
    10fa:	e022                	sd	s0,0(sp)
    10fc:	e406                	sd	ra,8(sp)
    10fe:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    1100:	66e000ef          	jal	ra,176e <strlen>
    1104:	862a                	mv	a2,a0
    1106:	85a2                	mv	a1,s0
    1108:	4505                	li	a0,1
    110a:	341000ef          	jal	ra,1c4a <write>
    110e:	00055763          	bgez	a0,111c <puts+0x24>
    return r;
}
    1112:	60a2                	ld	ra,8(sp)
    1114:	6402                	ld	s0,0(sp)
    1116:	557d                	li	a0,-1
    1118:	0141                	addi	sp,sp,16
    111a:	8082                	ret
    put[0] = c;
    111c:	00001597          	auipc	a1,0x1
    1120:	fec58593          	addi	a1,a1,-20 # 2108 <put.1156>
    1124:	47a9                	li	a5,10
    return write(stdout, put, 1);
    1126:	4605                	li	a2,1
    1128:	4505                	li	a0,1
    put[0] = c;
    112a:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    112e:	31d000ef          	jal	ra,1c4a <write>
}
    1132:	60a2                	ld	ra,8(sp)
    1134:	6402                	ld	s0,0(sp)
    1136:	41f5551b          	sraiw	a0,a0,0x1f
    113a:	0141                	addi	sp,sp,16
    113c:	8082                	ret

000000000000113e <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    113e:	7115                	addi	sp,sp,-224
    1140:	ed06                	sd	ra,152(sp)
    1142:	e922                	sd	s0,144(sp)
    1144:	e526                	sd	s1,136(sp)
    1146:	e14a                	sd	s2,128(sp)
    1148:	fcce                	sd	s3,120(sp)
    114a:	f8d2                	sd	s4,112(sp)
    114c:	f4d6                	sd	s5,104(sp)
    114e:	f0da                	sd	s6,96(sp)
    1150:	ecde                	sd	s7,88(sp)
    1152:	e8e2                	sd	s8,80(sp)
    1154:	e4e6                	sd	s9,72(sp)
    1156:	e0ea                	sd	s10,64(sp)
    1158:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    115a:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    115e:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    1160:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    1162:	f52e                	sd	a1,168(sp)
    1164:	f932                	sd	a2,176(sp)
    1166:	fd36                	sd	a3,184(sp)
    1168:	e1ba                	sd	a4,192(sp)
    116a:	e9c2                	sd	a6,208(sp)
    116c:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    116e:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1170:	0c030b63          	beqz	t1,1246 <printf+0x108>
    1174:	8aaa                	mv	s5,a0
    1176:	0003071b          	sext.w	a4,t1
    117a:	4481                	li	s1,0
        if (c != '%') {
    117c:	02500b93          	li	s7,37
    put[0] = c;
    1180:	00001417          	auipc	s0,0x1
    1184:	f8840413          	addi	s0,s0,-120 # 2108 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    1188:	4c51                	li	s8,20
    put[0] = c;
    118a:	02500c93          	li	s9,37
    118e:	00001a17          	auipc	s4,0x1
    1192:	f82a0a13          	addi	s4,s4,-126 # 2110 <put.1156+0x8>
    1196:	00001997          	auipc	s3,0x1
    119a:	fd298993          	addi	s3,s3,-46 # 2168 <digits>
    119e:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    11a2:	0014879b          	addiw	a5,s1,1
    11a6:	00fa8933          	add	s2,s5,a5
    11aa:	13771163          	bne	a4,s7,12cc <printf+0x18e>
        c = fmt[++i] & 0xff;
    11ae:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    11b2:	080d0a63          	beqz	s10,1246 <printf+0x108>
        switch (c) {
    11b6:	2489                	addiw	s1,s1,2
    11b8:	009a8933          	add	s2,s5,s1
    11bc:	257d0e63          	beq	s10,s7,1418 <printf+0x2da>
    11c0:	f9cd079b          	addiw	a5,s10,-100
    11c4:	0ff7f793          	andi	a5,a5,255
    11c8:	0cfc6263          	bltu	s8,a5,128c <printf+0x14e>
    11cc:	078a                	slli	a5,a5,0x2
    11ce:	97d2                	add	a5,a5,s4
    11d0:	439c                	lw	a5,0(a5)
    11d2:	97d2                	add	a5,a5,s4
    11d4:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    11d6:	67a2                	ld	a5,8(sp)
    11d8:	4398                	lw	a4,0(a5)
    11da:	07a1                	addi	a5,a5,8
    11dc:	e43e                	sd	a5,8(sp)
    11de:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    11e2:	26074663          	bltz	a4,144e <printf+0x310>
        buf[i++] = digits[x % base];
    11e6:	8bbd                	andi	a5,a5,15
    11e8:	97ce                	add	a5,a5,s3
    11ea:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    11ee:	40475d1b          	sraiw	s10,a4,0x4
    11f2:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    11f6:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    11fa:	020d0163          	beqz	s10,121c <printf+0xde>
        buf[i++] = digits[x % base];
    11fe:	9d4e                	add	s10,s10,s3
    1200:	000d4783          	lbu	a5,0(s10)
    1204:	4d05                	li	s10,1
    1206:	00f108a3          	sb	a5,17(sp)
    if (sign)
    120a:	00075963          	bgez	a4,121c <printf+0xde>
        buf[i++] = digits[x % base];
    120e:	4d09                	li	s10,2
        buf[i++] = '-';
    1210:	181c                	addi	a5,sp,48
    1212:	02d00713          	li	a4,45
    1216:	97ea                	add	a5,a5,s10
    1218:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    121c:	9d5a                	add	s10,s10,s6
    121e:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1222:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1226:	4605                	li	a2,1
    1228:	1d7d                	addi	s10,s10,-1
    122a:	85a2                	mv	a1,s0
    122c:	4505                	li	a0,1
    put[0] = c;
    122e:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1232:	219000ef          	jal	ra,1c4a <write>
    while (--i >= 0)
    1236:	ffbd16e3          	bne	s10,s11,1222 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    123a:	00094303          	lbu	t1,0(s2)
    123e:	0003071b          	sext.w	a4,t1
    1242:	f60310e3          	bnez	t1,11a2 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    1246:	60ea                	ld	ra,152(sp)
    1248:	644a                	ld	s0,144(sp)
    124a:	64aa                	ld	s1,136(sp)
    124c:	690a                	ld	s2,128(sp)
    124e:	79e6                	ld	s3,120(sp)
    1250:	7a46                	ld	s4,112(sp)
    1252:	7aa6                	ld	s5,104(sp)
    1254:	7b06                	ld	s6,96(sp)
    1256:	6be6                	ld	s7,88(sp)
    1258:	6c46                	ld	s8,80(sp)
    125a:	6ca6                	ld	s9,72(sp)
    125c:	6d06                	ld	s10,64(sp)
    125e:	7de2                	ld	s11,56(sp)
    1260:	612d                	addi	sp,sp,224
    1262:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    1264:	67a2                	ld	a5,8(sp)
    1266:	0007bd03          	ld	s10,0(a5)
    126a:	07a1                	addi	a5,a5,8
    126c:	e43e                	sd	a5,8(sp)
    126e:	000d1b63          	bnez	s10,1284 <printf+0x146>
    1272:	aafd                	j	1470 <printf+0x332>
    return write(stdout, put, 1);
    1274:	4605                	li	a2,1
    1276:	85a2                	mv	a1,s0
    1278:	4505                	li	a0,1
                for (; *s; s++)
    127a:	0d05                	addi	s10,s10,1
    put[0] = c;
    127c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1280:	1cb000ef          	jal	ra,1c4a <write>
                for (; *s; s++)
    1284:	000d4783          	lbu	a5,0(s10)
    1288:	f7f5                	bnez	a5,1274 <printf+0x136>
    128a:	a02d                	j	12b4 <printf+0x176>
    return write(stdout, put, 1);
    128c:	4605                	li	a2,1
    128e:	00001597          	auipc	a1,0x1
    1292:	e7a58593          	addi	a1,a1,-390 # 2108 <put.1156>
    1296:	4505                	li	a0,1
    put[0] = c;
    1298:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    129c:	1af000ef          	jal	ra,1c4a <write>
    12a0:	4605                	li	a2,1
    12a2:	00001597          	auipc	a1,0x1
    12a6:	e6658593          	addi	a1,a1,-410 # 2108 <put.1156>
    12aa:	4505                	li	a0,1
    put[0] = c;
    12ac:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    12b0:	19b000ef          	jal	ra,1c4a <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    12b4:	00094303          	lbu	t1,0(s2)
    12b8:	0003071b          	sext.w	a4,t1
    12bc:	f80305e3          	beqz	t1,1246 <printf+0x108>
        if (c != '%') {
    12c0:	0014879b          	addiw	a5,s1,1
    12c4:	00fa8933          	add	s2,s5,a5
    12c8:	ef7703e3          	beq	a4,s7,11ae <printf+0x70>
    return write(stdout, put, 1);
    12cc:	4605                	li	a2,1
    12ce:	00001597          	auipc	a1,0x1
    12d2:	e3a58593          	addi	a1,a1,-454 # 2108 <put.1156>
    12d6:	4505                	li	a0,1
    put[0] = c;
    12d8:	00640023          	sb	t1,0(s0)
            continue;
    12dc:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    12de:	16d000ef          	jal	ra,1c4a <write>
            continue;
    12e2:	bfc9                	j	12b4 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    12e4:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    12e6:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    12e8:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    12ea:	0007b883          	ld	a7,0(a5)
    12ee:	07a1                	addi	a5,a5,8
    12f0:	e43e                	sd	a5,8(sp)
        x = -xx;
    12f2:	43f8d713          	srai	a4,a7,0x3f
    12f6:	011747b3          	xor	a5,a4,a7
    12fa:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    12fc:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    12fe:	02c7f733          	remu	a4,a5,a2
    1302:	8d36                	mv	s10,a3
    1304:	0685                	addi	a3,a3,1
    1306:	00db0533          	add	a0,s6,a3
    130a:	85be                	mv	a1,a5
    130c:	974e                	add	a4,a4,s3
    130e:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    1312:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    1316:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    131a:	feb862e3          	bltu	a6,a1,12fe <printf+0x1c0>
    if (sign)
    131e:	1208c063          	bltz	a7,143e <printf+0x300>
    while (--i >= 0)
    1322:	9d5a                	add	s10,s10,s6
    put[0] = c;
    1324:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1328:	4605                	li	a2,1
    132a:	85a2                	mv	a1,s0
    132c:	4505                	li	a0,1
    put[0] = c;
    132e:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1332:	119000ef          	jal	ra,1c4a <write>
    while (--i >= 0)
    1336:	87ea                	mv	a5,s10
    1338:	1d7d                	addi	s10,s10,-1
    133a:	fefb15e3          	bne	s6,a5,1324 <printf+0x1e6>
    133e:	bf9d                	j	12b4 <printf+0x176>
                printptr(va_arg(ap, uint64));
    1340:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    1342:	4605                	li	a2,1
    1344:	00001597          	auipc	a1,0x1
    1348:	dc458593          	addi	a1,a1,-572 # 2108 <put.1156>
                printptr(va_arg(ap, uint64));
    134c:	0007bd83          	ld	s11,0(a5)
    1350:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    1354:	4505                	li	a0,1
    put[0] = c;
    1356:	03000793          	li	a5,48
    135a:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    135e:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    1360:	0eb000ef          	jal	ra,1c4a <write>
    put[0] = c;
    1364:	07800793          	li	a5,120
    return write(stdout, put, 1);
    1368:	4605                	li	a2,1
    136a:	00001597          	auipc	a1,0x1
    136e:	d9e58593          	addi	a1,a1,-610 # 2108 <put.1156>
    1372:	4505                	li	a0,1
    put[0] = c;
    1374:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1378:	4d41                	li	s10,16
    137a:	0d1000ef          	jal	ra,1c4a <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    137e:	03cdd793          	srli	a5,s11,0x3c
    1382:	97ce                	add	a5,a5,s3
    put[0] = c;
    1384:	0007c783          	lbu	a5,0(a5)
    1388:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    138a:	4605                	li	a2,1
    138c:	85a2                	mv	a1,s0
    138e:	4505                	li	a0,1
    put[0] = c;
    1390:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1394:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1396:	0b5000ef          	jal	ra,1c4a <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    139a:	fe0d12e3          	bnez	s10,137e <printf+0x240>
    139e:	bf19                	j	12b4 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    13a0:	67a2                	ld	a5,8(sp)
    13a2:	4394                	lw	a3,0(a5)
    13a4:	07a1                	addi	a5,a5,8
    13a6:	e43e                	sd	a5,8(sp)
    13a8:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    13ac:	0006d663          	bgez	a3,13b8 <printf+0x27a>
        x = -xx;
    13b0:	40f007bb          	negw	a5,a5
    13b4:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    13b8:	4729                	li	a4,10
    13ba:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    13be:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    13c2:	964e                	add	a2,a2,s3
    13c4:	00064603          	lbu	a2,0(a2)
    13c8:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    13cc:	0a0d0963          	beqz	s10,147e <printf+0x340>
        buf[i++] = digits[x % base];
    13d0:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    13d4:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    13d8:	00c98733          	add	a4,s3,a2
    13dc:	00074703          	lbu	a4,0(a4)
    13e0:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    13e4:	c3cd                	beqz	a5,1486 <printf+0x348>
        buf[i++] = digits[x % base];
    13e6:	97ce                	add	a5,a5,s3
    13e8:	0007c703          	lbu	a4,0(a5)
    13ec:	4d09                	li	s10,2
    13ee:	478d                	li	a5,3
    13f0:	00e10923          	sb	a4,18(sp)
    if (sign)
    13f4:	0206cd63          	bltz	a3,142e <printf+0x2f0>
    while (--i >= 0)
    13f8:	9d5a                	add	s10,s10,s6
    13fa:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    13fe:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1402:	4605                	li	a2,1
    1404:	1d7d                	addi	s10,s10,-1
    1406:	85a2                	mv	a1,s0
    1408:	4505                	li	a0,1
    put[0] = c;
    140a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    140e:	03d000ef          	jal	ra,1c4a <write>
    while (--i >= 0)
    1412:	ffbd16e3          	bne	s10,s11,13fe <printf+0x2c0>
    1416:	bd79                	j	12b4 <printf+0x176>
    return write(stdout, put, 1);
    1418:	4605                	li	a2,1
    141a:	00001597          	auipc	a1,0x1
    141e:	cee58593          	addi	a1,a1,-786 # 2108 <put.1156>
    1422:	4505                	li	a0,1
    put[0] = c;
    1424:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    1428:	023000ef          	jal	ra,1c4a <write>
    142c:	b561                	j	12b4 <printf+0x176>
        buf[i++] = '-';
    142e:	1818                	addi	a4,sp,48
    1430:	973e                	add	a4,a4,a5
    1432:	02d00693          	li	a3,45
    1436:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    143a:	8d3e                	mv	s10,a5
    143c:	bf75                	j	13f8 <printf+0x2ba>
        buf[i++] = '-';
    143e:	181c                	addi	a5,sp,48
    1440:	97b6                	add	a5,a5,a3
    1442:	02d00713          	li	a4,45
    1446:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    144a:	8d36                	mv	s10,a3
    144c:	bdd9                	j	1322 <printf+0x1e4>
        x = -xx;
    144e:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    1452:	00f7f693          	andi	a3,a5,15
    1456:	96ce                	add	a3,a3,s3
    1458:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    145c:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    1460:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    1464:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1468:	d80d1be3          	bnez	s10,11fe <printf+0xc0>
        buf[i++] = digits[x % base];
    146c:	4d05                	li	s10,1
    146e:	b34d                	j	1210 <printf+0xd2>
                s = "(null)";
    1470:	00001d17          	auipc	s10,0x1
    1474:	c78d0d13          	addi	s10,s10,-904 # 20e8 <sharedmem+0x34c>
                for (; *s; s++)
    1478:	02800793          	li	a5,40
    147c:	bbe5                	j	1274 <printf+0x136>
        buf[i++] = digits[x % base];
    147e:	4785                	li	a5,1
    if (sign)
    1480:	f606dce3          	bgez	a3,13f8 <printf+0x2ba>
    1484:	b76d                	j	142e <printf+0x2f0>
        buf[i++] = digits[x % base];
    1486:	4789                	li	a5,2
    1488:	4d05                	li	s10,1
    if (sign)
    148a:	f606d7e3          	bgez	a3,13f8 <printf+0x2ba>
    148e:	b745                	j	142e <printf+0x2f0>

0000000000001490 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1490:	02000793          	li	a5,32
    1494:	00f50663          	beq	a0,a5,14a0 <isspace+0x10>
    1498:	355d                	addiw	a0,a0,-9
    149a:	00553513          	sltiu	a0,a0,5
    149e:	8082                	ret
    14a0:	4505                	li	a0,1
}
    14a2:	8082                	ret

00000000000014a4 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    14a4:	fd05051b          	addiw	a0,a0,-48
}
    14a8:	00a53513          	sltiu	a0,a0,10
    14ac:	8082                	ret

00000000000014ae <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    14ae:	02000613          	li	a2,32
    14b2:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    14b4:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    14b8:	ff77069b          	addiw	a3,a4,-9
    14bc:	04c70d63          	beq	a4,a2,1516 <atoi+0x68>
    14c0:	0007079b          	sext.w	a5,a4
    14c4:	04d5f963          	bgeu	a1,a3,1516 <atoi+0x68>
        s++;
    switch (*s) {
    14c8:	02b00693          	li	a3,43
    14cc:	04d70a63          	beq	a4,a3,1520 <atoi+0x72>
    14d0:	02d00693          	li	a3,45
    14d4:	06d70463          	beq	a4,a3,153c <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    14d8:	fd07859b          	addiw	a1,a5,-48
    14dc:	4625                	li	a2,9
    14de:	873e                	mv	a4,a5
    14e0:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    14e2:	4e01                	li	t3,0
    while (isdigit(*s))
    14e4:	04b66a63          	bltu	a2,a1,1538 <atoi+0x8a>
    int n = 0, neg = 0;
    14e8:	4501                	li	a0,0
    while (isdigit(*s))
    14ea:	4825                	li	a6,9
    14ec:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    14f0:	0025179b          	slliw	a5,a0,0x2
    14f4:	9d3d                	addw	a0,a0,a5
    14f6:	fd07031b          	addiw	t1,a4,-48
    14fa:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    14fe:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1502:	0685                	addi	a3,a3,1
    1504:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1508:	0006071b          	sext.w	a4,a2
    150c:	feb870e3          	bgeu	a6,a1,14ec <atoi+0x3e>
    return neg ? n : -n;
    1510:	000e0563          	beqz	t3,151a <atoi+0x6c>
}
    1514:	8082                	ret
        s++;
    1516:	0505                	addi	a0,a0,1
    1518:	bf71                	j	14b4 <atoi+0x6>
    151a:	4113053b          	subw	a0,t1,a7
    151e:	8082                	ret
    while (isdigit(*s))
    1520:	00154783          	lbu	a5,1(a0)
    1524:	4625                	li	a2,9
        s++;
    1526:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    152a:	fd07859b          	addiw	a1,a5,-48
    152e:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1532:	4e01                	li	t3,0
    while (isdigit(*s))
    1534:	fab67ae3          	bgeu	a2,a1,14e8 <atoi+0x3a>
    1538:	4501                	li	a0,0
}
    153a:	8082                	ret
    while (isdigit(*s))
    153c:	00154783          	lbu	a5,1(a0)
    1540:	4625                	li	a2,9
        s++;
    1542:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1546:	fd07859b          	addiw	a1,a5,-48
    154a:	0007871b          	sext.w	a4,a5
    154e:	feb665e3          	bltu	a2,a1,1538 <atoi+0x8a>
        neg = 1;
    1552:	4e05                	li	t3,1
    1554:	bf51                	j	14e8 <atoi+0x3a>

0000000000001556 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    1556:	16060d63          	beqz	a2,16d0 <memset+0x17a>
    155a:	40a007b3          	neg	a5,a0
    155e:	8b9d                	andi	a5,a5,7
    1560:	00778713          	addi	a4,a5,7
    1564:	482d                	li	a6,11
    1566:	0ff5f593          	andi	a1,a1,255
    156a:	fff60693          	addi	a3,a2,-1
    156e:	17076263          	bltu	a4,a6,16d2 <memset+0x17c>
    1572:	16e6ea63          	bltu	a3,a4,16e6 <memset+0x190>
    1576:	16078563          	beqz	a5,16e0 <memset+0x18a>
    157a:	00b50023          	sb	a1,0(a0)
    157e:	4705                	li	a4,1
    1580:	00150e93          	addi	t4,a0,1
    1584:	14e78c63          	beq	a5,a4,16dc <memset+0x186>
    1588:	00b500a3          	sb	a1,1(a0)
    158c:	4709                	li	a4,2
    158e:	00250e93          	addi	t4,a0,2
    1592:	14e78d63          	beq	a5,a4,16ec <memset+0x196>
    1596:	00b50123          	sb	a1,2(a0)
    159a:	470d                	li	a4,3
    159c:	00350e93          	addi	t4,a0,3
    15a0:	12e78b63          	beq	a5,a4,16d6 <memset+0x180>
    15a4:	00b501a3          	sb	a1,3(a0)
    15a8:	4711                	li	a4,4
    15aa:	00450e93          	addi	t4,a0,4
    15ae:	14e78163          	beq	a5,a4,16f0 <memset+0x19a>
    15b2:	00b50223          	sb	a1,4(a0)
    15b6:	4715                	li	a4,5
    15b8:	00550e93          	addi	t4,a0,5
    15bc:	12e78c63          	beq	a5,a4,16f4 <memset+0x19e>
    15c0:	00b502a3          	sb	a1,5(a0)
    15c4:	471d                	li	a4,7
    15c6:	00650e93          	addi	t4,a0,6
    15ca:	12e79763          	bne	a5,a4,16f8 <memset+0x1a2>
    15ce:	00750e93          	addi	t4,a0,7
    15d2:	00b50323          	sb	a1,6(a0)
    15d6:	4f1d                	li	t5,7
    15d8:	00859713          	slli	a4,a1,0x8
    15dc:	8f4d                	or	a4,a4,a1
    15de:	01059e13          	slli	t3,a1,0x10
    15e2:	01c76e33          	or	t3,a4,t3
    15e6:	01859313          	slli	t1,a1,0x18
    15ea:	006e6333          	or	t1,t3,t1
    15ee:	02059893          	slli	a7,a1,0x20
    15f2:	011368b3          	or	a7,t1,a7
    15f6:	02859813          	slli	a6,a1,0x28
    15fa:	40f60333          	sub	t1,a2,a5
    15fe:	0108e833          	or	a6,a7,a6
    1602:	03059693          	slli	a3,a1,0x30
    1606:	00d866b3          	or	a3,a6,a3
    160a:	03859713          	slli	a4,a1,0x38
    160e:	97aa                	add	a5,a5,a0
    1610:	ff837813          	andi	a6,t1,-8
    1614:	8f55                	or	a4,a4,a3
    1616:	00f806b3          	add	a3,a6,a5
    161a:	e398                	sd	a4,0(a5)
    161c:	07a1                	addi	a5,a5,8
    161e:	fed79ee3          	bne	a5,a3,161a <memset+0xc4>
    1622:	ff837693          	andi	a3,t1,-8
    1626:	00de87b3          	add	a5,t4,a3
    162a:	01e6873b          	addw	a4,a3,t5
    162e:	0ad30663          	beq	t1,a3,16da <memset+0x184>
    1632:	00b78023          	sb	a1,0(a5)
    1636:	0017069b          	addiw	a3,a4,1
    163a:	08c6fb63          	bgeu	a3,a2,16d0 <memset+0x17a>
    163e:	00b780a3          	sb	a1,1(a5)
    1642:	0027069b          	addiw	a3,a4,2
    1646:	08c6f563          	bgeu	a3,a2,16d0 <memset+0x17a>
    164a:	00b78123          	sb	a1,2(a5)
    164e:	0037069b          	addiw	a3,a4,3
    1652:	06c6ff63          	bgeu	a3,a2,16d0 <memset+0x17a>
    1656:	00b781a3          	sb	a1,3(a5)
    165a:	0047069b          	addiw	a3,a4,4
    165e:	06c6f963          	bgeu	a3,a2,16d0 <memset+0x17a>
    1662:	00b78223          	sb	a1,4(a5)
    1666:	0057069b          	addiw	a3,a4,5
    166a:	06c6f363          	bgeu	a3,a2,16d0 <memset+0x17a>
    166e:	00b782a3          	sb	a1,5(a5)
    1672:	0067069b          	addiw	a3,a4,6
    1676:	04c6fd63          	bgeu	a3,a2,16d0 <memset+0x17a>
    167a:	00b78323          	sb	a1,6(a5)
    167e:	0077069b          	addiw	a3,a4,7
    1682:	04c6f763          	bgeu	a3,a2,16d0 <memset+0x17a>
    1686:	00b783a3          	sb	a1,7(a5)
    168a:	0087069b          	addiw	a3,a4,8
    168e:	04c6f163          	bgeu	a3,a2,16d0 <memset+0x17a>
    1692:	00b78423          	sb	a1,8(a5)
    1696:	0097069b          	addiw	a3,a4,9
    169a:	02c6fb63          	bgeu	a3,a2,16d0 <memset+0x17a>
    169e:	00b784a3          	sb	a1,9(a5)
    16a2:	00a7069b          	addiw	a3,a4,10
    16a6:	02c6f563          	bgeu	a3,a2,16d0 <memset+0x17a>
    16aa:	00b78523          	sb	a1,10(a5)
    16ae:	00b7069b          	addiw	a3,a4,11
    16b2:	00c6ff63          	bgeu	a3,a2,16d0 <memset+0x17a>
    16b6:	00b785a3          	sb	a1,11(a5)
    16ba:	00c7069b          	addiw	a3,a4,12
    16be:	00c6f963          	bgeu	a3,a2,16d0 <memset+0x17a>
    16c2:	00b78623          	sb	a1,12(a5)
    16c6:	2735                	addiw	a4,a4,13
    16c8:	00c77463          	bgeu	a4,a2,16d0 <memset+0x17a>
    16cc:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    16d0:	8082                	ret
    16d2:	472d                	li	a4,11
    16d4:	bd79                	j	1572 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    16d6:	4f0d                	li	t5,3
    16d8:	b701                	j	15d8 <memset+0x82>
    16da:	8082                	ret
    16dc:	4f05                	li	t5,1
    16de:	bded                	j	15d8 <memset+0x82>
    16e0:	8eaa                	mv	t4,a0
    16e2:	4f01                	li	t5,0
    16e4:	bdd5                	j	15d8 <memset+0x82>
    16e6:	87aa                	mv	a5,a0
    16e8:	4701                	li	a4,0
    16ea:	b7a1                	j	1632 <memset+0xdc>
    16ec:	4f09                	li	t5,2
    16ee:	b5ed                	j	15d8 <memset+0x82>
    16f0:	4f11                	li	t5,4
    16f2:	b5dd                	j	15d8 <memset+0x82>
    16f4:	4f15                	li	t5,5
    16f6:	b5cd                	j	15d8 <memset+0x82>
    16f8:	4f19                	li	t5,6
    16fa:	bdf9                	j	15d8 <memset+0x82>

00000000000016fc <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    16fc:	00054783          	lbu	a5,0(a0)
    1700:	0005c703          	lbu	a4,0(a1)
    1704:	00e79863          	bne	a5,a4,1714 <strcmp+0x18>
    1708:	0505                	addi	a0,a0,1
    170a:	0585                	addi	a1,a1,1
    170c:	fbe5                	bnez	a5,16fc <strcmp>
    170e:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    1710:	9d19                	subw	a0,a0,a4
    1712:	8082                	ret
    1714:	0007851b          	sext.w	a0,a5
    1718:	bfe5                	j	1710 <strcmp+0x14>

000000000000171a <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    171a:	87aa                	mv	a5,a0
    171c:	0005c703          	lbu	a4,0(a1)
    1720:	0785                	addi	a5,a5,1
    1722:	0585                	addi	a1,a1,1
    1724:	fee78fa3          	sb	a4,-1(a5)
    1728:	fb75                	bnez	a4,171c <strcpy+0x2>
        ;
    return os;
}
    172a:	8082                	ret

000000000000172c <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    172c:	ce05                	beqz	a2,1764 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    172e:	00054703          	lbu	a4,0(a0)
    1732:	0005c783          	lbu	a5,0(a1)
    1736:	cb0d                	beqz	a4,1768 <strncmp+0x3c>
    if (!n--)
    1738:	167d                	addi	a2,a2,-1
    173a:	00c506b3          	add	a3,a0,a2
    173e:	a819                	j	1754 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1740:	00a68e63          	beq	a3,a0,175c <strncmp+0x30>
    1744:	0505                	addi	a0,a0,1
    1746:	00e79b63          	bne	a5,a4,175c <strncmp+0x30>
    174a:	00054703          	lbu	a4,0(a0)
    174e:	0005c783          	lbu	a5,0(a1)
    1752:	cb19                	beqz	a4,1768 <strncmp+0x3c>
    1754:	0005c783          	lbu	a5,0(a1)
    1758:	0585                	addi	a1,a1,1
    175a:	f3fd                	bnez	a5,1740 <strncmp+0x14>
        ;
    return *l - *r;
    175c:	0007051b          	sext.w	a0,a4
    1760:	9d1d                	subw	a0,a0,a5
    1762:	8082                	ret
        return 0;
    1764:	4501                	li	a0,0
}
    1766:	8082                	ret
    1768:	4501                	li	a0,0
    return *l - *r;
    176a:	9d1d                	subw	a0,a0,a5
    176c:	8082                	ret

000000000000176e <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    176e:	00757793          	andi	a5,a0,7
    1772:	cf89                	beqz	a5,178c <strlen+0x1e>
    1774:	87aa                	mv	a5,a0
    1776:	a029                	j	1780 <strlen+0x12>
    1778:	0785                	addi	a5,a5,1
    177a:	0077f713          	andi	a4,a5,7
    177e:	cb01                	beqz	a4,178e <strlen+0x20>
        if (!*s)
    1780:	0007c703          	lbu	a4,0(a5)
    1784:	fb75                	bnez	a4,1778 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1786:	40a78533          	sub	a0,a5,a0
}
    178a:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    178c:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    178e:	6394                	ld	a3,0(a5)
    1790:	00001597          	auipc	a1,0x1
    1794:	9605b583          	ld	a1,-1696(a1) # 20f0 <sharedmem+0x354>
    1798:	00001617          	auipc	a2,0x1
    179c:	96063603          	ld	a2,-1696(a2) # 20f8 <sharedmem+0x35c>
    17a0:	a019                	j	17a6 <strlen+0x38>
    17a2:	6794                	ld	a3,8(a5)
    17a4:	07a1                	addi	a5,a5,8
    17a6:	00b68733          	add	a4,a3,a1
    17aa:	fff6c693          	not	a3,a3
    17ae:	8f75                	and	a4,a4,a3
    17b0:	8f71                	and	a4,a4,a2
    17b2:	db65                	beqz	a4,17a2 <strlen+0x34>
    for (; *s; s++)
    17b4:	0007c703          	lbu	a4,0(a5)
    17b8:	d779                	beqz	a4,1786 <strlen+0x18>
    17ba:	0017c703          	lbu	a4,1(a5)
    17be:	0785                	addi	a5,a5,1
    17c0:	d379                	beqz	a4,1786 <strlen+0x18>
    17c2:	0017c703          	lbu	a4,1(a5)
    17c6:	0785                	addi	a5,a5,1
    17c8:	fb6d                	bnez	a4,17ba <strlen+0x4c>
    17ca:	bf75                	j	1786 <strlen+0x18>

00000000000017cc <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    17cc:	00757713          	andi	a4,a0,7
{
    17d0:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    17d2:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    17d6:	cb19                	beqz	a4,17ec <memchr+0x20>
    17d8:	ce25                	beqz	a2,1850 <memchr+0x84>
    17da:	0007c703          	lbu	a4,0(a5)
    17de:	04b70e63          	beq	a4,a1,183a <memchr+0x6e>
    17e2:	0785                	addi	a5,a5,1
    17e4:	0077f713          	andi	a4,a5,7
    17e8:	167d                	addi	a2,a2,-1
    17ea:	f77d                	bnez	a4,17d8 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    17ec:	4501                	li	a0,0
    if (n && *s != c) {
    17ee:	c235                	beqz	a2,1852 <memchr+0x86>
    17f0:	0007c703          	lbu	a4,0(a5)
    17f4:	04b70363          	beq	a4,a1,183a <memchr+0x6e>
        size_t k = ONES * c;
    17f8:	00001517          	auipc	a0,0x1
    17fc:	90853503          	ld	a0,-1784(a0) # 2100 <sharedmem+0x364>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1800:	471d                	li	a4,7
        size_t k = ONES * c;
    1802:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1806:	02c77a63          	bgeu	a4,a2,183a <memchr+0x6e>
    180a:	00001897          	auipc	a7,0x1
    180e:	8e68b883          	ld	a7,-1818(a7) # 20f0 <sharedmem+0x354>
    1812:	00001817          	auipc	a6,0x1
    1816:	8e683803          	ld	a6,-1818(a6) # 20f8 <sharedmem+0x35c>
    181a:	431d                	li	t1,7
    181c:	a029                	j	1826 <memchr+0x5a>
    181e:	1661                	addi	a2,a2,-8
    1820:	07a1                	addi	a5,a5,8
    1822:	02c37963          	bgeu	t1,a2,1854 <memchr+0x88>
    1826:	6398                	ld	a4,0(a5)
    1828:	8f29                	xor	a4,a4,a0
    182a:	011706b3          	add	a3,a4,a7
    182e:	fff74713          	not	a4,a4
    1832:	8f75                	and	a4,a4,a3
    1834:	01077733          	and	a4,a4,a6
    1838:	d37d                	beqz	a4,181e <memchr+0x52>
    183a:	853e                	mv	a0,a5
    183c:	97b2                	add	a5,a5,a2
    183e:	a021                	j	1846 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1840:	0505                	addi	a0,a0,1
    1842:	00f50763          	beq	a0,a5,1850 <memchr+0x84>
    1846:	00054703          	lbu	a4,0(a0)
    184a:	feb71be3          	bne	a4,a1,1840 <memchr+0x74>
    184e:	8082                	ret
    return n ? (void*)s : 0;
    1850:	4501                	li	a0,0
}
    1852:	8082                	ret
    return n ? (void*)s : 0;
    1854:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1856:	f275                	bnez	a2,183a <memchr+0x6e>
}
    1858:	8082                	ret

000000000000185a <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    185a:	1101                	addi	sp,sp,-32
    185c:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    185e:	862e                	mv	a2,a1
{
    1860:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1862:	4581                	li	a1,0
{
    1864:	e426                	sd	s1,8(sp)
    1866:	ec06                	sd	ra,24(sp)
    1868:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    186a:	f63ff0ef          	jal	ra,17cc <memchr>
    return p ? p - s : n;
    186e:	c519                	beqz	a0,187c <strnlen+0x22>
}
    1870:	60e2                	ld	ra,24(sp)
    1872:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1874:	8d05                	sub	a0,a0,s1
}
    1876:	64a2                	ld	s1,8(sp)
    1878:	6105                	addi	sp,sp,32
    187a:	8082                	ret
    187c:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    187e:	8522                	mv	a0,s0
}
    1880:	6442                	ld	s0,16(sp)
    1882:	64a2                	ld	s1,8(sp)
    1884:	6105                	addi	sp,sp,32
    1886:	8082                	ret

0000000000001888 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1888:	00b547b3          	xor	a5,a0,a1
    188c:	8b9d                	andi	a5,a5,7
    188e:	eb95                	bnez	a5,18c2 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1890:	0075f793          	andi	a5,a1,7
    1894:	e7b1                	bnez	a5,18e0 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1896:	6198                	ld	a4,0(a1)
    1898:	00001617          	auipc	a2,0x1
    189c:	85863603          	ld	a2,-1960(a2) # 20f0 <sharedmem+0x354>
    18a0:	00001817          	auipc	a6,0x1
    18a4:	85883803          	ld	a6,-1960(a6) # 20f8 <sharedmem+0x35c>
    18a8:	a029                	j	18b2 <stpcpy+0x2a>
    18aa:	e118                	sd	a4,0(a0)
    18ac:	6598                	ld	a4,8(a1)
    18ae:	05a1                	addi	a1,a1,8
    18b0:	0521                	addi	a0,a0,8
    18b2:	00c707b3          	add	a5,a4,a2
    18b6:	fff74693          	not	a3,a4
    18ba:	8ff5                	and	a5,a5,a3
    18bc:	0107f7b3          	and	a5,a5,a6
    18c0:	d7ed                	beqz	a5,18aa <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    18c2:	0005c783          	lbu	a5,0(a1)
    18c6:	00f50023          	sb	a5,0(a0)
    18ca:	c785                	beqz	a5,18f2 <stpcpy+0x6a>
    18cc:	0015c783          	lbu	a5,1(a1)
    18d0:	0505                	addi	a0,a0,1
    18d2:	0585                	addi	a1,a1,1
    18d4:	00f50023          	sb	a5,0(a0)
    18d8:	fbf5                	bnez	a5,18cc <stpcpy+0x44>
        ;
    return d;
}
    18da:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    18dc:	0505                	addi	a0,a0,1
    18de:	df45                	beqz	a4,1896 <stpcpy+0xe>
            if (!(*d = *s))
    18e0:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    18e4:	0585                	addi	a1,a1,1
    18e6:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    18ea:	00f50023          	sb	a5,0(a0)
    18ee:	f7fd                	bnez	a5,18dc <stpcpy+0x54>
}
    18f0:	8082                	ret
    18f2:	8082                	ret

00000000000018f4 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    18f4:	00b547b3          	xor	a5,a0,a1
    18f8:	8b9d                	andi	a5,a5,7
    18fa:	1a079863          	bnez	a5,1aaa <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    18fe:	0075f793          	andi	a5,a1,7
    1902:	16078463          	beqz	a5,1a6a <stpncpy+0x176>
    1906:	ea01                	bnez	a2,1916 <stpncpy+0x22>
    1908:	a421                	j	1b10 <stpncpy+0x21c>
    190a:	167d                	addi	a2,a2,-1
    190c:	0505                	addi	a0,a0,1
    190e:	14070e63          	beqz	a4,1a6a <stpncpy+0x176>
    1912:	1a060863          	beqz	a2,1ac2 <stpncpy+0x1ce>
    1916:	0005c783          	lbu	a5,0(a1)
    191a:	0585                	addi	a1,a1,1
    191c:	0075f713          	andi	a4,a1,7
    1920:	00f50023          	sb	a5,0(a0)
    1924:	f3fd                	bnez	a5,190a <stpncpy+0x16>
    1926:	4805                	li	a6,1
    1928:	1a061863          	bnez	a2,1ad8 <stpncpy+0x1e4>
    192c:	40a007b3          	neg	a5,a0
    1930:	8b9d                	andi	a5,a5,7
    1932:	4681                	li	a3,0
    1934:	18061a63          	bnez	a2,1ac8 <stpncpy+0x1d4>
    1938:	00778713          	addi	a4,a5,7
    193c:	45ad                	li	a1,11
    193e:	18b76363          	bltu	a4,a1,1ac4 <stpncpy+0x1d0>
    1942:	1ae6eb63          	bltu	a3,a4,1af8 <stpncpy+0x204>
    1946:	1a078363          	beqz	a5,1aec <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    194a:	00050023          	sb	zero,0(a0)
    194e:	4685                	li	a3,1
    1950:	00150713          	addi	a4,a0,1
    1954:	18d78f63          	beq	a5,a3,1af2 <stpncpy+0x1fe>
    1958:	000500a3          	sb	zero,1(a0)
    195c:	4689                	li	a3,2
    195e:	00250713          	addi	a4,a0,2
    1962:	18d78e63          	beq	a5,a3,1afe <stpncpy+0x20a>
    1966:	00050123          	sb	zero,2(a0)
    196a:	468d                	li	a3,3
    196c:	00350713          	addi	a4,a0,3
    1970:	16d78c63          	beq	a5,a3,1ae8 <stpncpy+0x1f4>
    1974:	000501a3          	sb	zero,3(a0)
    1978:	4691                	li	a3,4
    197a:	00450713          	addi	a4,a0,4
    197e:	18d78263          	beq	a5,a3,1b02 <stpncpy+0x20e>
    1982:	00050223          	sb	zero,4(a0)
    1986:	4695                	li	a3,5
    1988:	00550713          	addi	a4,a0,5
    198c:	16d78d63          	beq	a5,a3,1b06 <stpncpy+0x212>
    1990:	000502a3          	sb	zero,5(a0)
    1994:	469d                	li	a3,7
    1996:	00650713          	addi	a4,a0,6
    199a:	16d79863          	bne	a5,a3,1b0a <stpncpy+0x216>
    199e:	00750713          	addi	a4,a0,7
    19a2:	00050323          	sb	zero,6(a0)
    19a6:	40f80833          	sub	a6,a6,a5
    19aa:	ff887593          	andi	a1,a6,-8
    19ae:	97aa                	add	a5,a5,a0
    19b0:	95be                	add	a1,a1,a5
    19b2:	0007b023          	sd	zero,0(a5)
    19b6:	07a1                	addi	a5,a5,8
    19b8:	feb79de3          	bne	a5,a1,19b2 <stpncpy+0xbe>
    19bc:	ff887593          	andi	a1,a6,-8
    19c0:	9ead                	addw	a3,a3,a1
    19c2:	00b707b3          	add	a5,a4,a1
    19c6:	12b80863          	beq	a6,a1,1af6 <stpncpy+0x202>
    19ca:	00078023          	sb	zero,0(a5)
    19ce:	0016871b          	addiw	a4,a3,1
    19d2:	0ec77863          	bgeu	a4,a2,1ac2 <stpncpy+0x1ce>
    19d6:	000780a3          	sb	zero,1(a5)
    19da:	0026871b          	addiw	a4,a3,2
    19de:	0ec77263          	bgeu	a4,a2,1ac2 <stpncpy+0x1ce>
    19e2:	00078123          	sb	zero,2(a5)
    19e6:	0036871b          	addiw	a4,a3,3
    19ea:	0cc77c63          	bgeu	a4,a2,1ac2 <stpncpy+0x1ce>
    19ee:	000781a3          	sb	zero,3(a5)
    19f2:	0046871b          	addiw	a4,a3,4
    19f6:	0cc77663          	bgeu	a4,a2,1ac2 <stpncpy+0x1ce>
    19fa:	00078223          	sb	zero,4(a5)
    19fe:	0056871b          	addiw	a4,a3,5
    1a02:	0cc77063          	bgeu	a4,a2,1ac2 <stpncpy+0x1ce>
    1a06:	000782a3          	sb	zero,5(a5)
    1a0a:	0066871b          	addiw	a4,a3,6
    1a0e:	0ac77a63          	bgeu	a4,a2,1ac2 <stpncpy+0x1ce>
    1a12:	00078323          	sb	zero,6(a5)
    1a16:	0076871b          	addiw	a4,a3,7
    1a1a:	0ac77463          	bgeu	a4,a2,1ac2 <stpncpy+0x1ce>
    1a1e:	000783a3          	sb	zero,7(a5)
    1a22:	0086871b          	addiw	a4,a3,8
    1a26:	08c77e63          	bgeu	a4,a2,1ac2 <stpncpy+0x1ce>
    1a2a:	00078423          	sb	zero,8(a5)
    1a2e:	0096871b          	addiw	a4,a3,9
    1a32:	08c77863          	bgeu	a4,a2,1ac2 <stpncpy+0x1ce>
    1a36:	000784a3          	sb	zero,9(a5)
    1a3a:	00a6871b          	addiw	a4,a3,10
    1a3e:	08c77263          	bgeu	a4,a2,1ac2 <stpncpy+0x1ce>
    1a42:	00078523          	sb	zero,10(a5)
    1a46:	00b6871b          	addiw	a4,a3,11
    1a4a:	06c77c63          	bgeu	a4,a2,1ac2 <stpncpy+0x1ce>
    1a4e:	000785a3          	sb	zero,11(a5)
    1a52:	00c6871b          	addiw	a4,a3,12
    1a56:	06c77663          	bgeu	a4,a2,1ac2 <stpncpy+0x1ce>
    1a5a:	00078623          	sb	zero,12(a5)
    1a5e:	26b5                	addiw	a3,a3,13
    1a60:	06c6f163          	bgeu	a3,a2,1ac2 <stpncpy+0x1ce>
    1a64:	000786a3          	sb	zero,13(a5)
    1a68:	8082                	ret
            ;
        if (!n || !*s)
    1a6a:	c645                	beqz	a2,1b12 <stpncpy+0x21e>
    1a6c:	0005c783          	lbu	a5,0(a1)
    1a70:	ea078be3          	beqz	a5,1926 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1a74:	479d                	li	a5,7
    1a76:	02c7ff63          	bgeu	a5,a2,1ab4 <stpncpy+0x1c0>
    1a7a:	00000897          	auipc	a7,0x0
    1a7e:	6768b883          	ld	a7,1654(a7) # 20f0 <sharedmem+0x354>
    1a82:	00000817          	auipc	a6,0x0
    1a86:	67683803          	ld	a6,1654(a6) # 20f8 <sharedmem+0x35c>
    1a8a:	431d                	li	t1,7
    1a8c:	6198                	ld	a4,0(a1)
    1a8e:	011707b3          	add	a5,a4,a7
    1a92:	fff74693          	not	a3,a4
    1a96:	8ff5                	and	a5,a5,a3
    1a98:	0107f7b3          	and	a5,a5,a6
    1a9c:	ef81                	bnez	a5,1ab4 <stpncpy+0x1c0>
            *wd = *ws;
    1a9e:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1aa0:	1661                	addi	a2,a2,-8
    1aa2:	05a1                	addi	a1,a1,8
    1aa4:	0521                	addi	a0,a0,8
    1aa6:	fec363e3          	bltu	t1,a2,1a8c <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1aaa:	e609                	bnez	a2,1ab4 <stpncpy+0x1c0>
    1aac:	a08d                	j	1b0e <stpncpy+0x21a>
    1aae:	167d                	addi	a2,a2,-1
    1ab0:	0505                	addi	a0,a0,1
    1ab2:	ca01                	beqz	a2,1ac2 <stpncpy+0x1ce>
    1ab4:	0005c783          	lbu	a5,0(a1)
    1ab8:	0585                	addi	a1,a1,1
    1aba:	00f50023          	sb	a5,0(a0)
    1abe:	fbe5                	bnez	a5,1aae <stpncpy+0x1ba>
        ;
tail:
    1ac0:	b59d                	j	1926 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1ac2:	8082                	ret
    1ac4:	472d                	li	a4,11
    1ac6:	bdb5                	j	1942 <stpncpy+0x4e>
    1ac8:	00778713          	addi	a4,a5,7
    1acc:	45ad                	li	a1,11
    1ace:	fff60693          	addi	a3,a2,-1
    1ad2:	e6b778e3          	bgeu	a4,a1,1942 <stpncpy+0x4e>
    1ad6:	b7fd                	j	1ac4 <stpncpy+0x1d0>
    1ad8:	40a007b3          	neg	a5,a0
    1adc:	8832                	mv	a6,a2
    1ade:	8b9d                	andi	a5,a5,7
    1ae0:	4681                	li	a3,0
    1ae2:	e4060be3          	beqz	a2,1938 <stpncpy+0x44>
    1ae6:	b7cd                	j	1ac8 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1ae8:	468d                	li	a3,3
    1aea:	bd75                	j	19a6 <stpncpy+0xb2>
    1aec:	872a                	mv	a4,a0
    1aee:	4681                	li	a3,0
    1af0:	bd5d                	j	19a6 <stpncpy+0xb2>
    1af2:	4685                	li	a3,1
    1af4:	bd4d                	j	19a6 <stpncpy+0xb2>
    1af6:	8082                	ret
    1af8:	87aa                	mv	a5,a0
    1afa:	4681                	li	a3,0
    1afc:	b5f9                	j	19ca <stpncpy+0xd6>
    1afe:	4689                	li	a3,2
    1b00:	b55d                	j	19a6 <stpncpy+0xb2>
    1b02:	4691                	li	a3,4
    1b04:	b54d                	j	19a6 <stpncpy+0xb2>
    1b06:	4695                	li	a3,5
    1b08:	bd79                	j	19a6 <stpncpy+0xb2>
    1b0a:	4699                	li	a3,6
    1b0c:	bd69                	j	19a6 <stpncpy+0xb2>
    1b0e:	8082                	ret
    1b10:	8082                	ret
    1b12:	8082                	ret

0000000000001b14 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1b14:	fff6071b          	addiw	a4,a2,-1
    1b18:	0cb57063          	bgeu	a0,a1,1bd8 <memmove+0xc4>
        while (n-- > 0)
    1b1c:	0ec05063          	blez	a2,1bfc <memmove+0xe8>
    1b20:	00750693          	addi	a3,a0,7
    1b24:	8e8d                	sub	a3,a3,a1
    1b26:	00b567b3          	or	a5,a0,a1
    1b2a:	00f6b693          	sltiu	a3,a3,15
    1b2e:	8b9d                	andi	a5,a5,7
    1b30:	0016c693          	xori	a3,a3,1
    1b34:	0017b793          	seqz	a5,a5
    1b38:	8ff5                	and	a5,a5,a3
    1b3a:	c3f1                	beqz	a5,1bfe <memmove+0xea>
    1b3c:	0007079b          	sext.w	a5,a4
    1b40:	46a5                	li	a3,9
    1b42:	0af6fe63          	bgeu	a3,a5,1bfe <memmove+0xea>
    1b46:	0036589b          	srliw	a7,a2,0x3
    1b4a:	088e                	slli	a7,a7,0x3
    1b4c:	2601                	sext.w	a2,a2
    1b4e:	87ae                	mv	a5,a1
    1b50:	86aa                	mv	a3,a0
    1b52:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1b54:	0007b803          	ld	a6,0(a5)
    1b58:	07a1                	addi	a5,a5,8
    1b5a:	06a1                	addi	a3,a3,8
    1b5c:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1b60:	ff179ae3          	bne	a5,a7,1b54 <memmove+0x40>
    1b64:	ff867813          	andi	a6,a2,-8
    1b68:	02081793          	slli	a5,a6,0x20
    1b6c:	9381                	srli	a5,a5,0x20
    1b6e:	00f506b3          	add	a3,a0,a5
    1b72:	95be                	add	a1,a1,a5
    1b74:	4107073b          	subw	a4,a4,a6
    1b78:	09060263          	beq	a2,a6,1bfc <memmove+0xe8>
            *dst++ = *src++;
    1b7c:	0005c783          	lbu	a5,0(a1)
    1b80:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1b84:	06e05c63          	blez	a4,1bfc <memmove+0xe8>
            *dst++ = *src++;
    1b88:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1b8c:	4785                	li	a5,1
            *dst++ = *src++;
    1b8e:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1b92:	06e7d563          	bge	a5,a4,1bfc <memmove+0xe8>
            *dst++ = *src++;
    1b96:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1b9a:	4789                	li	a5,2
            *dst++ = *src++;
    1b9c:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1ba0:	04e7de63          	bge	a5,a4,1bfc <memmove+0xe8>
            *dst++ = *src++;
    1ba4:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1ba8:	478d                	li	a5,3
            *dst++ = *src++;
    1baa:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1bae:	04e7d763          	bge	a5,a4,1bfc <memmove+0xe8>
            *dst++ = *src++;
    1bb2:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1bb6:	4791                	li	a5,4
            *dst++ = *src++;
    1bb8:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1bbc:	04e7d063          	bge	a5,a4,1bfc <memmove+0xe8>
            *dst++ = *src++;
    1bc0:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1bc4:	4795                	li	a5,5
            *dst++ = *src++;
    1bc6:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1bca:	02e7d963          	bge	a5,a4,1bfc <memmove+0xe8>
            *dst++ = *src++;
    1bce:	0065c783          	lbu	a5,6(a1)
    1bd2:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1bd6:	8082                	ret
    } else {
        dst += n;
    1bd8:	00c507b3          	add	a5,a0,a2
        src += n;
    1bdc:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1bde:	00c05f63          	blez	a2,1bfc <memmove+0xe8>
    1be2:	1702                	slli	a4,a4,0x20
    1be4:	9301                	srli	a4,a4,0x20
    1be6:	fff74713          	not	a4,a4
    1bea:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1bec:	fff5c683          	lbu	a3,-1(a1)
    1bf0:	17fd                	addi	a5,a5,-1
    1bf2:	15fd                	addi	a1,a1,-1
    1bf4:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1bf8:	fee79ae3          	bne	a5,a4,1bec <memmove+0xd8>
    }
    return vdst;
}
    1bfc:	8082                	ret
    1bfe:	02071693          	slli	a3,a4,0x20
    1c02:	9281                	srli	a3,a3,0x20
    1c04:	0685                	addi	a3,a3,1
    1c06:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1c08:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1c0a:	0005c703          	lbu	a4,0(a1)
    1c0e:	0585                	addi	a1,a1,1
    1c10:	0785                	addi	a5,a5,1
    1c12:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1c16:	fed59ae3          	bne	a1,a3,1c0a <memmove+0xf6>
    1c1a:	8082                	ret

0000000000001c1c <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1c1c:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c20:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1c24:	2501                	sext.w	a0,a0
    1c26:	8082                	ret

0000000000001c28 <exec>:
    register long a7 __asm__("a7") = n;
    1c28:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1c2c:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c2e:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1c32:	2501                	sext.w	a0,a0
    1c34:	8082                	ret

0000000000001c36 <exit>:
    register long a7 __asm__("a7") = n;
    1c36:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1c3a:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1c3e:	8082                	ret

0000000000001c40 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1c40:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c44:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1c48:	8082                	ret

0000000000001c4a <write>:
    register long a7 __asm__("a7") = n;
    1c4a:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c4e:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1c52:	8082                	ret

0000000000001c54 <getpid>:
    register long a7 __asm__("a7") = n;
    1c54:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1c58:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1c5c:	2501                	sext.w	a0,a0
    1c5e:	8082                	ret

0000000000001c60 <getppid>:
    register long a7 __asm__("a7") = n;
    1c60:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c64:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c68:	2501                	sext.w	a0,a0
    1c6a:	8082                	ret

0000000000001c6c <open>:
    register long a7 __asm__("a7") = n;
    1c6c:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c70:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1c74:	2501                	sext.w	a0,a0
    1c76:	8082                	ret

0000000000001c78 <mknod>:
    register long a7 __asm__("a7") = n;
    1c78:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c7c:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1c80:	2501                	sext.w	a0,a0
    1c82:	8082                	ret

0000000000001c84 <dup>:
    register long a7 __asm__("a7") = n;
    1c84:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1c86:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1c8a:	2501                	sext.w	a0,a0
    1c8c:	8082                	ret

0000000000001c8e <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c8e:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c92:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c96:	2501                	sext.w	a0,a0
    1c98:	8082                	ret

0000000000001c9a <waitpid>:
    register long a7 __asm__("a7") = n;
    1c9a:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c9e:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1ca2:	2501                	sext.w	a0,a0
    1ca4:	8082                	ret

0000000000001ca6 <wait>:

pid_t wait(int *wstatus)
{
    1ca6:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1ca8:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1cac:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cae:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1cb2:	2501                	sext.w	a0,a0
    1cb4:	8082                	ret

0000000000001cb6 <mkdir>:
    register long a7 __asm__("a7") = n;
    1cb6:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1cba:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1cbe:	2501                	sext.w	a0,a0
    1cc0:	8082                	ret

0000000000001cc2 <close>:
    register long a7 __asm__("a7") = n;
    1cc2:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1cc6:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1cca:	2501                	sext.w	a0,a0
    1ccc:	8082                	ret

0000000000001cce <fork>:
    register long a7 __asm__("a7") = n;
    1cce:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1cd2:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1cd6:	2501                	sext.w	a0,a0
    1cd8:	8082                	ret

0000000000001cda <time_ms>:
    register long a7 __asm__("a7") = n;
    1cda:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1cde:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1ce2:	8082                	ret

0000000000001ce4 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1ce4:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1ce6:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1cea:	00000073          	ecall
    1cee:	87aa                	mv	a5,a0
    1cf0:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1cf4:	97ba                	add	a5,a5,a4
    1cf6:	00f57c63          	bgeu	a0,a5,1d0e <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1cfa:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1cfe:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d02:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1d06:	00000073          	ecall
    1d0a:	fef568e3          	bltu	a0,a5,1cfa <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1d0e:	4501                	li	a0,0
    1d10:	8082                	ret

0000000000001d12 <pipe>:
    register long a7 __asm__("a7") = n;
    1d12:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1d16:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1d1a:	2501                	sext.w	a0,a0
    1d1c:	8082                	ret

0000000000001d1e <fstat>:
    register long a7 __asm__("a7") = n;
    1d1e:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d22:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1d26:	2501                	sext.w	a0,a0
    1d28:	8082                	ret

0000000000001d2a <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1d2a:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1d2c:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1d30:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d32:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1d36:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1d3a:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1d3e:	0206c163          	bltz	a3,1d60 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1d42:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1d46:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1d48:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d4a:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1d4e:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1d52:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1d56:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1d58:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1d5c:	853e                	mv	a0,a5
    1d5e:	8082                	ret
        return -1;
    1d60:	57fd                	li	a5,-1
    1d62:	bfed                	j	1d5c <stat+0x32>

0000000000001d64 <chdir>:
    register long a7 __asm__("a7") = n;
    1d64:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1d68:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1d6c:	2501                	sext.w	a0,a0
    1d6e:	8082                	ret

0000000000001d70 <link>:
    register long a7 __asm__("a7") = n;
    1d70:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d74:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1d78:	2501                	sext.w	a0,a0
    1d7a:	8082                	ret

0000000000001d7c <unlink>:
    register long a7 __asm__("a7") = n;
    1d7c:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1d80:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1d84:	2501                	sext.w	a0,a0
    1d86:	8082                	ret

0000000000001d88 <setpriority>:
    register long a7 __asm__("a7") = n;
    1d88:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d8c:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1d90:	8082                	ret

0000000000001d92 <getpriority>:
    register long a7 __asm__("a7") = n;
    1d92:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1d96:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1d9a:	8082                	ret

0000000000001d9c <sharedmem>:
    register long a7 __asm__("a7") = n;
    1d9c:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1da0:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1da4:	8082                	ret
