
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_sleep:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a0a1                	j	1048 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <ucore.h>
#include <string.h>
#include <fcntl.h>

int main(int argc, char *argv[])
{
    1002:	1101                	addi	sp,sp,-32
    printf("Will sleep for 10 seconds\n");
    1004:	00001517          	auipc	a0,0x1
    1008:	d4450513          	addi	a0,a0,-700 # 1d48 <sharedmem+0xc>
{
    100c:	e822                	sd	s0,16(sp)
    100e:	e426                	sd	s1,8(sp)
    1010:	e04a                	sd	s2,0(sp)
    1012:	ec06                	sd	ra,24(sp)
    for (int i = 0; i < 10; i++)
    1014:	4401                	li	s0,0
    printf("Will sleep for 10 seconds\n");
    1016:	0c8000ef          	jal	ra,10de <printf>
    {
        printf("%d\n",i);
    101a:	00001917          	auipc	s2,0x1
    101e:	d4e90913          	addi	s2,s2,-690 # 1d68 <sharedmem+0x2c>
    for (int i = 0; i < 10; i++)
    1022:	44a9                	li	s1,10
        printf("%d\n",i);
    1024:	85a2                	mv	a1,s0
    1026:	854a                	mv	a0,s2
    1028:	0b6000ef          	jal	ra,10de <printf>
    for (int i = 0; i < 10; i++)
    102c:	2405                	addiw	s0,s0,1
        sleep(1000);
    102e:	3e800513          	li	a0,1000
    1032:	453000ef          	jal	ra,1c84 <sleep>
    for (int i = 0; i < 10; i++)
    1036:	fe9417e3          	bne	s0,s1,1024 <main+0x22>
    }

    return 0;
    103a:	60e2                	ld	ra,24(sp)
    103c:	6442                	ld	s0,16(sp)
    103e:	64a2                	ld	s1,8(sp)
    1040:	6902                	ld	s2,0(sp)
    1042:	4501                	li	a0,0
    1044:	6105                	addi	sp,sp,32
    1046:	8082                	ret

0000000000001048 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1048:	1141                	addi	sp,sp,-16
    104a:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    104c:	fb7ff0ef          	jal	ra,1002 <main>
}
    1050:	60a2                	ld	ra,8(sp)
    1052:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    1054:	3830006f          	j	1bd6 <exit>

0000000000001058 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    1058:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    105a:	00f10593          	addi	a1,sp,15
    105e:	4605                	li	a2,1
    1060:	4501                	li	a0,0
int getchar() {
    1062:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1064:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1068:	379000ef          	jal	ra,1be0 <read>
    return byte;
}
    106c:	60e2                	ld	ra,24(sp)
    106e:	00f14503          	lbu	a0,15(sp)
    1072:	6105                	addi	sp,sp,32
    1074:	8082                	ret

0000000000001076 <putchar>:

int putchar(int c)
{
    1076:	1141                	addi	sp,sp,-16
    1078:	e406                	sd	ra,8(sp)
    107a:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    107c:	00001597          	auipc	a1,0x1
    1080:	d1458593          	addi	a1,a1,-748 # 1d90 <put.1156>
    return write(stdout, put, 1);
    1084:	4605                	li	a2,1
    1086:	4505                	li	a0,1
    put[0] = c;
    1088:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    108c:	35f000ef          	jal	ra,1bea <write>
}
    1090:	60a2                	ld	ra,8(sp)
    1092:	2501                	sext.w	a0,a0
    1094:	0141                	addi	sp,sp,16
    1096:	8082                	ret

0000000000001098 <puts>:

int puts(const char* s)
{
    1098:	1141                	addi	sp,sp,-16
    109a:	e022                	sd	s0,0(sp)
    109c:	e406                	sd	ra,8(sp)
    109e:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    10a0:	66e000ef          	jal	ra,170e <strlen>
    10a4:	862a                	mv	a2,a0
    10a6:	85a2                	mv	a1,s0
    10a8:	4505                	li	a0,1
    10aa:	341000ef          	jal	ra,1bea <write>
    10ae:	00055763          	bgez	a0,10bc <puts+0x24>
    return r;
}
    10b2:	60a2                	ld	ra,8(sp)
    10b4:	6402                	ld	s0,0(sp)
    10b6:	557d                	li	a0,-1
    10b8:	0141                	addi	sp,sp,16
    10ba:	8082                	ret
    put[0] = c;
    10bc:	00001597          	auipc	a1,0x1
    10c0:	cd458593          	addi	a1,a1,-812 # 1d90 <put.1156>
    10c4:	47a9                	li	a5,10
    return write(stdout, put, 1);
    10c6:	4605                	li	a2,1
    10c8:	4505                	li	a0,1
    put[0] = c;
    10ca:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    10ce:	31d000ef          	jal	ra,1bea <write>
}
    10d2:	60a2                	ld	ra,8(sp)
    10d4:	6402                	ld	s0,0(sp)
    10d6:	41f5551b          	sraiw	a0,a0,0x1f
    10da:	0141                	addi	sp,sp,16
    10dc:	8082                	ret

00000000000010de <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    10de:	7115                	addi	sp,sp,-224
    10e0:	ed06                	sd	ra,152(sp)
    10e2:	e922                	sd	s0,144(sp)
    10e4:	e526                	sd	s1,136(sp)
    10e6:	e14a                	sd	s2,128(sp)
    10e8:	fcce                	sd	s3,120(sp)
    10ea:	f8d2                	sd	s4,112(sp)
    10ec:	f4d6                	sd	s5,104(sp)
    10ee:	f0da                	sd	s6,96(sp)
    10f0:	ecde                	sd	s7,88(sp)
    10f2:	e8e2                	sd	s8,80(sp)
    10f4:	e4e6                	sd	s9,72(sp)
    10f6:	e0ea                	sd	s10,64(sp)
    10f8:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    10fa:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    10fe:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    1100:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    1102:	f52e                	sd	a1,168(sp)
    1104:	f932                	sd	a2,176(sp)
    1106:	fd36                	sd	a3,184(sp)
    1108:	e1ba                	sd	a4,192(sp)
    110a:	e9c2                	sd	a6,208(sp)
    110c:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    110e:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1110:	0c030b63          	beqz	t1,11e6 <printf+0x108>
    1114:	8aaa                	mv	s5,a0
    1116:	0003071b          	sext.w	a4,t1
    111a:	4481                	li	s1,0
        if (c != '%') {
    111c:	02500b93          	li	s7,37
    put[0] = c;
    1120:	00001417          	auipc	s0,0x1
    1124:	c7040413          	addi	s0,s0,-912 # 1d90 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    1128:	4c51                	li	s8,20
    put[0] = c;
    112a:	02500c93          	li	s9,37
    112e:	00001a17          	auipc	s4,0x1
    1132:	c6aa0a13          	addi	s4,s4,-918 # 1d98 <put.1156+0x8>
    1136:	00001997          	auipc	s3,0x1
    113a:	cba98993          	addi	s3,s3,-838 # 1df0 <digits>
    113e:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    1142:	0014879b          	addiw	a5,s1,1
    1146:	00fa8933          	add	s2,s5,a5
    114a:	13771163          	bne	a4,s7,126c <printf+0x18e>
        c = fmt[++i] & 0xff;
    114e:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    1152:	080d0a63          	beqz	s10,11e6 <printf+0x108>
        switch (c) {
    1156:	2489                	addiw	s1,s1,2
    1158:	009a8933          	add	s2,s5,s1
    115c:	257d0e63          	beq	s10,s7,13b8 <printf+0x2da>
    1160:	f9cd079b          	addiw	a5,s10,-100
    1164:	0ff7f793          	andi	a5,a5,255
    1168:	0cfc6263          	bltu	s8,a5,122c <printf+0x14e>
    116c:	078a                	slli	a5,a5,0x2
    116e:	97d2                	add	a5,a5,s4
    1170:	439c                	lw	a5,0(a5)
    1172:	97d2                	add	a5,a5,s4
    1174:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    1176:	67a2                	ld	a5,8(sp)
    1178:	4398                	lw	a4,0(a5)
    117a:	07a1                	addi	a5,a5,8
    117c:	e43e                	sd	a5,8(sp)
    117e:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    1182:	26074663          	bltz	a4,13ee <printf+0x310>
        buf[i++] = digits[x % base];
    1186:	8bbd                	andi	a5,a5,15
    1188:	97ce                	add	a5,a5,s3
    118a:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    118e:	40475d1b          	sraiw	s10,a4,0x4
    1192:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    1196:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    119a:	020d0163          	beqz	s10,11bc <printf+0xde>
        buf[i++] = digits[x % base];
    119e:	9d4e                	add	s10,s10,s3
    11a0:	000d4783          	lbu	a5,0(s10)
    11a4:	4d05                	li	s10,1
    11a6:	00f108a3          	sb	a5,17(sp)
    if (sign)
    11aa:	00075963          	bgez	a4,11bc <printf+0xde>
        buf[i++] = digits[x % base];
    11ae:	4d09                	li	s10,2
        buf[i++] = '-';
    11b0:	181c                	addi	a5,sp,48
    11b2:	02d00713          	li	a4,45
    11b6:	97ea                	add	a5,a5,s10
    11b8:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    11bc:	9d5a                	add	s10,s10,s6
    11be:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    11c2:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    11c6:	4605                	li	a2,1
    11c8:	1d7d                	addi	s10,s10,-1
    11ca:	85a2                	mv	a1,s0
    11cc:	4505                	li	a0,1
    put[0] = c;
    11ce:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    11d2:	219000ef          	jal	ra,1bea <write>
    while (--i >= 0)
    11d6:	ffbd16e3          	bne	s10,s11,11c2 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    11da:	00094303          	lbu	t1,0(s2)
    11de:	0003071b          	sext.w	a4,t1
    11e2:	f60310e3          	bnez	t1,1142 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    11e6:	60ea                	ld	ra,152(sp)
    11e8:	644a                	ld	s0,144(sp)
    11ea:	64aa                	ld	s1,136(sp)
    11ec:	690a                	ld	s2,128(sp)
    11ee:	79e6                	ld	s3,120(sp)
    11f0:	7a46                	ld	s4,112(sp)
    11f2:	7aa6                	ld	s5,104(sp)
    11f4:	7b06                	ld	s6,96(sp)
    11f6:	6be6                	ld	s7,88(sp)
    11f8:	6c46                	ld	s8,80(sp)
    11fa:	6ca6                	ld	s9,72(sp)
    11fc:	6d06                	ld	s10,64(sp)
    11fe:	7de2                	ld	s11,56(sp)
    1200:	612d                	addi	sp,sp,224
    1202:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    1204:	67a2                	ld	a5,8(sp)
    1206:	0007bd03          	ld	s10,0(a5)
    120a:	07a1                	addi	a5,a5,8
    120c:	e43e                	sd	a5,8(sp)
    120e:	000d1b63          	bnez	s10,1224 <printf+0x146>
    1212:	aafd                	j	1410 <printf+0x332>
    return write(stdout, put, 1);
    1214:	4605                	li	a2,1
    1216:	85a2                	mv	a1,s0
    1218:	4505                	li	a0,1
                for (; *s; s++)
    121a:	0d05                	addi	s10,s10,1
    put[0] = c;
    121c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1220:	1cb000ef          	jal	ra,1bea <write>
                for (; *s; s++)
    1224:	000d4783          	lbu	a5,0(s10)
    1228:	f7f5                	bnez	a5,1214 <printf+0x136>
    122a:	a02d                	j	1254 <printf+0x176>
    return write(stdout, put, 1);
    122c:	4605                	li	a2,1
    122e:	00001597          	auipc	a1,0x1
    1232:	b6258593          	addi	a1,a1,-1182 # 1d90 <put.1156>
    1236:	4505                	li	a0,1
    put[0] = c;
    1238:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    123c:	1af000ef          	jal	ra,1bea <write>
    1240:	4605                	li	a2,1
    1242:	00001597          	auipc	a1,0x1
    1246:	b4e58593          	addi	a1,a1,-1202 # 1d90 <put.1156>
    124a:	4505                	li	a0,1
    put[0] = c;
    124c:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    1250:	19b000ef          	jal	ra,1bea <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1254:	00094303          	lbu	t1,0(s2)
    1258:	0003071b          	sext.w	a4,t1
    125c:	f80305e3          	beqz	t1,11e6 <printf+0x108>
        if (c != '%') {
    1260:	0014879b          	addiw	a5,s1,1
    1264:	00fa8933          	add	s2,s5,a5
    1268:	ef7703e3          	beq	a4,s7,114e <printf+0x70>
    return write(stdout, put, 1);
    126c:	4605                	li	a2,1
    126e:	00001597          	auipc	a1,0x1
    1272:	b2258593          	addi	a1,a1,-1246 # 1d90 <put.1156>
    1276:	4505                	li	a0,1
    put[0] = c;
    1278:	00640023          	sb	t1,0(s0)
            continue;
    127c:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    127e:	16d000ef          	jal	ra,1bea <write>
            continue;
    1282:	bfc9                	j	1254 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    1284:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    1286:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    1288:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    128a:	0007b883          	ld	a7,0(a5)
    128e:	07a1                	addi	a5,a5,8
    1290:	e43e                	sd	a5,8(sp)
        x = -xx;
    1292:	43f8d713          	srai	a4,a7,0x3f
    1296:	011747b3          	xor	a5,a4,a7
    129a:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    129c:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    129e:	02c7f733          	remu	a4,a5,a2
    12a2:	8d36                	mv	s10,a3
    12a4:	0685                	addi	a3,a3,1
    12a6:	00db0533          	add	a0,s6,a3
    12aa:	85be                	mv	a1,a5
    12ac:	974e                	add	a4,a4,s3
    12ae:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    12b2:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    12b6:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    12ba:	feb862e3          	bltu	a6,a1,129e <printf+0x1c0>
    if (sign)
    12be:	1208c063          	bltz	a7,13de <printf+0x300>
    while (--i >= 0)
    12c2:	9d5a                	add	s10,s10,s6
    put[0] = c;
    12c4:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    12c8:	4605                	li	a2,1
    12ca:	85a2                	mv	a1,s0
    12cc:	4505                	li	a0,1
    put[0] = c;
    12ce:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    12d2:	119000ef          	jal	ra,1bea <write>
    while (--i >= 0)
    12d6:	87ea                	mv	a5,s10
    12d8:	1d7d                	addi	s10,s10,-1
    12da:	fefb15e3          	bne	s6,a5,12c4 <printf+0x1e6>
    12de:	bf9d                	j	1254 <printf+0x176>
                printptr(va_arg(ap, uint64));
    12e0:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    12e2:	4605                	li	a2,1
    12e4:	00001597          	auipc	a1,0x1
    12e8:	aac58593          	addi	a1,a1,-1364 # 1d90 <put.1156>
                printptr(va_arg(ap, uint64));
    12ec:	0007bd83          	ld	s11,0(a5)
    12f0:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    12f4:	4505                	li	a0,1
    put[0] = c;
    12f6:	03000793          	li	a5,48
    12fa:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    12fe:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    1300:	0eb000ef          	jal	ra,1bea <write>
    put[0] = c;
    1304:	07800793          	li	a5,120
    return write(stdout, put, 1);
    1308:	4605                	li	a2,1
    130a:	00001597          	auipc	a1,0x1
    130e:	a8658593          	addi	a1,a1,-1402 # 1d90 <put.1156>
    1312:	4505                	li	a0,1
    put[0] = c;
    1314:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1318:	4d41                	li	s10,16
    131a:	0d1000ef          	jal	ra,1bea <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    131e:	03cdd793          	srli	a5,s11,0x3c
    1322:	97ce                	add	a5,a5,s3
    put[0] = c;
    1324:	0007c783          	lbu	a5,0(a5)
    1328:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    132a:	4605                	li	a2,1
    132c:	85a2                	mv	a1,s0
    132e:	4505                	li	a0,1
    put[0] = c;
    1330:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1334:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1336:	0b5000ef          	jal	ra,1bea <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    133a:	fe0d12e3          	bnez	s10,131e <printf+0x240>
    133e:	bf19                	j	1254 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    1340:	67a2                	ld	a5,8(sp)
    1342:	4394                	lw	a3,0(a5)
    1344:	07a1                	addi	a5,a5,8
    1346:	e43e                	sd	a5,8(sp)
    1348:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    134c:	0006d663          	bgez	a3,1358 <printf+0x27a>
        x = -xx;
    1350:	40f007bb          	negw	a5,a5
    1354:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    1358:	4729                	li	a4,10
    135a:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    135e:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    1362:	964e                	add	a2,a2,s3
    1364:	00064603          	lbu	a2,0(a2)
    1368:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    136c:	0a0d0963          	beqz	s10,141e <printf+0x340>
        buf[i++] = digits[x % base];
    1370:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    1374:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    1378:	00c98733          	add	a4,s3,a2
    137c:	00074703          	lbu	a4,0(a4)
    1380:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    1384:	c3cd                	beqz	a5,1426 <printf+0x348>
        buf[i++] = digits[x % base];
    1386:	97ce                	add	a5,a5,s3
    1388:	0007c703          	lbu	a4,0(a5)
    138c:	4d09                	li	s10,2
    138e:	478d                	li	a5,3
    1390:	00e10923          	sb	a4,18(sp)
    if (sign)
    1394:	0206cd63          	bltz	a3,13ce <printf+0x2f0>
    while (--i >= 0)
    1398:	9d5a                	add	s10,s10,s6
    139a:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    139e:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    13a2:	4605                	li	a2,1
    13a4:	1d7d                	addi	s10,s10,-1
    13a6:	85a2                	mv	a1,s0
    13a8:	4505                	li	a0,1
    put[0] = c;
    13aa:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    13ae:	03d000ef          	jal	ra,1bea <write>
    while (--i >= 0)
    13b2:	ffbd16e3          	bne	s10,s11,139e <printf+0x2c0>
    13b6:	bd79                	j	1254 <printf+0x176>
    return write(stdout, put, 1);
    13b8:	4605                	li	a2,1
    13ba:	00001597          	auipc	a1,0x1
    13be:	9d658593          	addi	a1,a1,-1578 # 1d90 <put.1156>
    13c2:	4505                	li	a0,1
    put[0] = c;
    13c4:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    13c8:	023000ef          	jal	ra,1bea <write>
    13cc:	b561                	j	1254 <printf+0x176>
        buf[i++] = '-';
    13ce:	1818                	addi	a4,sp,48
    13d0:	973e                	add	a4,a4,a5
    13d2:	02d00693          	li	a3,45
    13d6:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    13da:	8d3e                	mv	s10,a5
    13dc:	bf75                	j	1398 <printf+0x2ba>
        buf[i++] = '-';
    13de:	181c                	addi	a5,sp,48
    13e0:	97b6                	add	a5,a5,a3
    13e2:	02d00713          	li	a4,45
    13e6:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    13ea:	8d36                	mv	s10,a3
    13ec:	bdd9                	j	12c2 <printf+0x1e4>
        x = -xx;
    13ee:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    13f2:	00f7f693          	andi	a3,a5,15
    13f6:	96ce                	add	a3,a3,s3
    13f8:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    13fc:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    1400:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    1404:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1408:	d80d1be3          	bnez	s10,119e <printf+0xc0>
        buf[i++] = digits[x % base];
    140c:	4d05                	li	s10,1
    140e:	b34d                	j	11b0 <printf+0xd2>
                s = "(null)";
    1410:	00001d17          	auipc	s10,0x1
    1414:	960d0d13          	addi	s10,s10,-1696 # 1d70 <sharedmem+0x34>
                for (; *s; s++)
    1418:	02800793          	li	a5,40
    141c:	bbe5                	j	1214 <printf+0x136>
        buf[i++] = digits[x % base];
    141e:	4785                	li	a5,1
    if (sign)
    1420:	f606dce3          	bgez	a3,1398 <printf+0x2ba>
    1424:	b76d                	j	13ce <printf+0x2f0>
        buf[i++] = digits[x % base];
    1426:	4789                	li	a5,2
    1428:	4d05                	li	s10,1
    if (sign)
    142a:	f606d7e3          	bgez	a3,1398 <printf+0x2ba>
    142e:	b745                	j	13ce <printf+0x2f0>

0000000000001430 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1430:	02000793          	li	a5,32
    1434:	00f50663          	beq	a0,a5,1440 <isspace+0x10>
    1438:	355d                	addiw	a0,a0,-9
    143a:	00553513          	sltiu	a0,a0,5
    143e:	8082                	ret
    1440:	4505                	li	a0,1
}
    1442:	8082                	ret

0000000000001444 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1444:	fd05051b          	addiw	a0,a0,-48
}
    1448:	00a53513          	sltiu	a0,a0,10
    144c:	8082                	ret

000000000000144e <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    144e:	02000613          	li	a2,32
    1452:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1454:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1458:	ff77069b          	addiw	a3,a4,-9
    145c:	04c70d63          	beq	a4,a2,14b6 <atoi+0x68>
    1460:	0007079b          	sext.w	a5,a4
    1464:	04d5f963          	bgeu	a1,a3,14b6 <atoi+0x68>
        s++;
    switch (*s) {
    1468:	02b00693          	li	a3,43
    146c:	04d70a63          	beq	a4,a3,14c0 <atoi+0x72>
    1470:	02d00693          	li	a3,45
    1474:	06d70463          	beq	a4,a3,14dc <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    1478:	fd07859b          	addiw	a1,a5,-48
    147c:	4625                	li	a2,9
    147e:	873e                	mv	a4,a5
    1480:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1482:	4e01                	li	t3,0
    while (isdigit(*s))
    1484:	04b66a63          	bltu	a2,a1,14d8 <atoi+0x8a>
    int n = 0, neg = 0;
    1488:	4501                	li	a0,0
    while (isdigit(*s))
    148a:	4825                	li	a6,9
    148c:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1490:	0025179b          	slliw	a5,a0,0x2
    1494:	9d3d                	addw	a0,a0,a5
    1496:	fd07031b          	addiw	t1,a4,-48
    149a:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    149e:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    14a2:	0685                	addi	a3,a3,1
    14a4:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    14a8:	0006071b          	sext.w	a4,a2
    14ac:	feb870e3          	bgeu	a6,a1,148c <atoi+0x3e>
    return neg ? n : -n;
    14b0:	000e0563          	beqz	t3,14ba <atoi+0x6c>
}
    14b4:	8082                	ret
        s++;
    14b6:	0505                	addi	a0,a0,1
    14b8:	bf71                	j	1454 <atoi+0x6>
    14ba:	4113053b          	subw	a0,t1,a7
    14be:	8082                	ret
    while (isdigit(*s))
    14c0:	00154783          	lbu	a5,1(a0)
    14c4:	4625                	li	a2,9
        s++;
    14c6:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    14ca:	fd07859b          	addiw	a1,a5,-48
    14ce:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    14d2:	4e01                	li	t3,0
    while (isdigit(*s))
    14d4:	fab67ae3          	bgeu	a2,a1,1488 <atoi+0x3a>
    14d8:	4501                	li	a0,0
}
    14da:	8082                	ret
    while (isdigit(*s))
    14dc:	00154783          	lbu	a5,1(a0)
    14e0:	4625                	li	a2,9
        s++;
    14e2:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    14e6:	fd07859b          	addiw	a1,a5,-48
    14ea:	0007871b          	sext.w	a4,a5
    14ee:	feb665e3          	bltu	a2,a1,14d8 <atoi+0x8a>
        neg = 1;
    14f2:	4e05                	li	t3,1
    14f4:	bf51                	j	1488 <atoi+0x3a>

00000000000014f6 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    14f6:	16060d63          	beqz	a2,1670 <memset+0x17a>
    14fa:	40a007b3          	neg	a5,a0
    14fe:	8b9d                	andi	a5,a5,7
    1500:	00778713          	addi	a4,a5,7
    1504:	482d                	li	a6,11
    1506:	0ff5f593          	andi	a1,a1,255
    150a:	fff60693          	addi	a3,a2,-1
    150e:	17076263          	bltu	a4,a6,1672 <memset+0x17c>
    1512:	16e6ea63          	bltu	a3,a4,1686 <memset+0x190>
    1516:	16078563          	beqz	a5,1680 <memset+0x18a>
    151a:	00b50023          	sb	a1,0(a0)
    151e:	4705                	li	a4,1
    1520:	00150e93          	addi	t4,a0,1
    1524:	14e78c63          	beq	a5,a4,167c <memset+0x186>
    1528:	00b500a3          	sb	a1,1(a0)
    152c:	4709                	li	a4,2
    152e:	00250e93          	addi	t4,a0,2
    1532:	14e78d63          	beq	a5,a4,168c <memset+0x196>
    1536:	00b50123          	sb	a1,2(a0)
    153a:	470d                	li	a4,3
    153c:	00350e93          	addi	t4,a0,3
    1540:	12e78b63          	beq	a5,a4,1676 <memset+0x180>
    1544:	00b501a3          	sb	a1,3(a0)
    1548:	4711                	li	a4,4
    154a:	00450e93          	addi	t4,a0,4
    154e:	14e78163          	beq	a5,a4,1690 <memset+0x19a>
    1552:	00b50223          	sb	a1,4(a0)
    1556:	4715                	li	a4,5
    1558:	00550e93          	addi	t4,a0,5
    155c:	12e78c63          	beq	a5,a4,1694 <memset+0x19e>
    1560:	00b502a3          	sb	a1,5(a0)
    1564:	471d                	li	a4,7
    1566:	00650e93          	addi	t4,a0,6
    156a:	12e79763          	bne	a5,a4,1698 <memset+0x1a2>
    156e:	00750e93          	addi	t4,a0,7
    1572:	00b50323          	sb	a1,6(a0)
    1576:	4f1d                	li	t5,7
    1578:	00859713          	slli	a4,a1,0x8
    157c:	8f4d                	or	a4,a4,a1
    157e:	01059e13          	slli	t3,a1,0x10
    1582:	01c76e33          	or	t3,a4,t3
    1586:	01859313          	slli	t1,a1,0x18
    158a:	006e6333          	or	t1,t3,t1
    158e:	02059893          	slli	a7,a1,0x20
    1592:	011368b3          	or	a7,t1,a7
    1596:	02859813          	slli	a6,a1,0x28
    159a:	40f60333          	sub	t1,a2,a5
    159e:	0108e833          	or	a6,a7,a6
    15a2:	03059693          	slli	a3,a1,0x30
    15a6:	00d866b3          	or	a3,a6,a3
    15aa:	03859713          	slli	a4,a1,0x38
    15ae:	97aa                	add	a5,a5,a0
    15b0:	ff837813          	andi	a6,t1,-8
    15b4:	8f55                	or	a4,a4,a3
    15b6:	00f806b3          	add	a3,a6,a5
    15ba:	e398                	sd	a4,0(a5)
    15bc:	07a1                	addi	a5,a5,8
    15be:	fed79ee3          	bne	a5,a3,15ba <memset+0xc4>
    15c2:	ff837693          	andi	a3,t1,-8
    15c6:	00de87b3          	add	a5,t4,a3
    15ca:	01e6873b          	addw	a4,a3,t5
    15ce:	0ad30663          	beq	t1,a3,167a <memset+0x184>
    15d2:	00b78023          	sb	a1,0(a5)
    15d6:	0017069b          	addiw	a3,a4,1
    15da:	08c6fb63          	bgeu	a3,a2,1670 <memset+0x17a>
    15de:	00b780a3          	sb	a1,1(a5)
    15e2:	0027069b          	addiw	a3,a4,2
    15e6:	08c6f563          	bgeu	a3,a2,1670 <memset+0x17a>
    15ea:	00b78123          	sb	a1,2(a5)
    15ee:	0037069b          	addiw	a3,a4,3
    15f2:	06c6ff63          	bgeu	a3,a2,1670 <memset+0x17a>
    15f6:	00b781a3          	sb	a1,3(a5)
    15fa:	0047069b          	addiw	a3,a4,4
    15fe:	06c6f963          	bgeu	a3,a2,1670 <memset+0x17a>
    1602:	00b78223          	sb	a1,4(a5)
    1606:	0057069b          	addiw	a3,a4,5
    160a:	06c6f363          	bgeu	a3,a2,1670 <memset+0x17a>
    160e:	00b782a3          	sb	a1,5(a5)
    1612:	0067069b          	addiw	a3,a4,6
    1616:	04c6fd63          	bgeu	a3,a2,1670 <memset+0x17a>
    161a:	00b78323          	sb	a1,6(a5)
    161e:	0077069b          	addiw	a3,a4,7
    1622:	04c6f763          	bgeu	a3,a2,1670 <memset+0x17a>
    1626:	00b783a3          	sb	a1,7(a5)
    162a:	0087069b          	addiw	a3,a4,8
    162e:	04c6f163          	bgeu	a3,a2,1670 <memset+0x17a>
    1632:	00b78423          	sb	a1,8(a5)
    1636:	0097069b          	addiw	a3,a4,9
    163a:	02c6fb63          	bgeu	a3,a2,1670 <memset+0x17a>
    163e:	00b784a3          	sb	a1,9(a5)
    1642:	00a7069b          	addiw	a3,a4,10
    1646:	02c6f563          	bgeu	a3,a2,1670 <memset+0x17a>
    164a:	00b78523          	sb	a1,10(a5)
    164e:	00b7069b          	addiw	a3,a4,11
    1652:	00c6ff63          	bgeu	a3,a2,1670 <memset+0x17a>
    1656:	00b785a3          	sb	a1,11(a5)
    165a:	00c7069b          	addiw	a3,a4,12
    165e:	00c6f963          	bgeu	a3,a2,1670 <memset+0x17a>
    1662:	00b78623          	sb	a1,12(a5)
    1666:	2735                	addiw	a4,a4,13
    1668:	00c77463          	bgeu	a4,a2,1670 <memset+0x17a>
    166c:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    1670:	8082                	ret
    1672:	472d                	li	a4,11
    1674:	bd79                	j	1512 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1676:	4f0d                	li	t5,3
    1678:	b701                	j	1578 <memset+0x82>
    167a:	8082                	ret
    167c:	4f05                	li	t5,1
    167e:	bded                	j	1578 <memset+0x82>
    1680:	8eaa                	mv	t4,a0
    1682:	4f01                	li	t5,0
    1684:	bdd5                	j	1578 <memset+0x82>
    1686:	87aa                	mv	a5,a0
    1688:	4701                	li	a4,0
    168a:	b7a1                	j	15d2 <memset+0xdc>
    168c:	4f09                	li	t5,2
    168e:	b5ed                	j	1578 <memset+0x82>
    1690:	4f11                	li	t5,4
    1692:	b5dd                	j	1578 <memset+0x82>
    1694:	4f15                	li	t5,5
    1696:	b5cd                	j	1578 <memset+0x82>
    1698:	4f19                	li	t5,6
    169a:	bdf9                	j	1578 <memset+0x82>

000000000000169c <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    169c:	00054783          	lbu	a5,0(a0)
    16a0:	0005c703          	lbu	a4,0(a1)
    16a4:	00e79863          	bne	a5,a4,16b4 <strcmp+0x18>
    16a8:	0505                	addi	a0,a0,1
    16aa:	0585                	addi	a1,a1,1
    16ac:	fbe5                	bnez	a5,169c <strcmp>
    16ae:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    16b0:	9d19                	subw	a0,a0,a4
    16b2:	8082                	ret
    16b4:	0007851b          	sext.w	a0,a5
    16b8:	bfe5                	j	16b0 <strcmp+0x14>

00000000000016ba <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    16ba:	87aa                	mv	a5,a0
    16bc:	0005c703          	lbu	a4,0(a1)
    16c0:	0785                	addi	a5,a5,1
    16c2:	0585                	addi	a1,a1,1
    16c4:	fee78fa3          	sb	a4,-1(a5)
    16c8:	fb75                	bnez	a4,16bc <strcpy+0x2>
        ;
    return os;
}
    16ca:	8082                	ret

00000000000016cc <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    16cc:	ce05                	beqz	a2,1704 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    16ce:	00054703          	lbu	a4,0(a0)
    16d2:	0005c783          	lbu	a5,0(a1)
    16d6:	cb0d                	beqz	a4,1708 <strncmp+0x3c>
    if (!n--)
    16d8:	167d                	addi	a2,a2,-1
    16da:	00c506b3          	add	a3,a0,a2
    16de:	a819                	j	16f4 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    16e0:	00a68e63          	beq	a3,a0,16fc <strncmp+0x30>
    16e4:	0505                	addi	a0,a0,1
    16e6:	00e79b63          	bne	a5,a4,16fc <strncmp+0x30>
    16ea:	00054703          	lbu	a4,0(a0)
    16ee:	0005c783          	lbu	a5,0(a1)
    16f2:	cb19                	beqz	a4,1708 <strncmp+0x3c>
    16f4:	0005c783          	lbu	a5,0(a1)
    16f8:	0585                	addi	a1,a1,1
    16fa:	f3fd                	bnez	a5,16e0 <strncmp+0x14>
        ;
    return *l - *r;
    16fc:	0007051b          	sext.w	a0,a4
    1700:	9d1d                	subw	a0,a0,a5
    1702:	8082                	ret
        return 0;
    1704:	4501                	li	a0,0
}
    1706:	8082                	ret
    1708:	4501                	li	a0,0
    return *l - *r;
    170a:	9d1d                	subw	a0,a0,a5
    170c:	8082                	ret

000000000000170e <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    170e:	00757793          	andi	a5,a0,7
    1712:	cf89                	beqz	a5,172c <strlen+0x1e>
    1714:	87aa                	mv	a5,a0
    1716:	a029                	j	1720 <strlen+0x12>
    1718:	0785                	addi	a5,a5,1
    171a:	0077f713          	andi	a4,a5,7
    171e:	cb01                	beqz	a4,172e <strlen+0x20>
        if (!*s)
    1720:	0007c703          	lbu	a4,0(a5)
    1724:	fb75                	bnez	a4,1718 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1726:	40a78533          	sub	a0,a5,a0
}
    172a:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    172c:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    172e:	6394                	ld	a3,0(a5)
    1730:	00000597          	auipc	a1,0x0
    1734:	6485b583          	ld	a1,1608(a1) # 1d78 <sharedmem+0x3c>
    1738:	00000617          	auipc	a2,0x0
    173c:	64863603          	ld	a2,1608(a2) # 1d80 <sharedmem+0x44>
    1740:	a019                	j	1746 <strlen+0x38>
    1742:	6794                	ld	a3,8(a5)
    1744:	07a1                	addi	a5,a5,8
    1746:	00b68733          	add	a4,a3,a1
    174a:	fff6c693          	not	a3,a3
    174e:	8f75                	and	a4,a4,a3
    1750:	8f71                	and	a4,a4,a2
    1752:	db65                	beqz	a4,1742 <strlen+0x34>
    for (; *s; s++)
    1754:	0007c703          	lbu	a4,0(a5)
    1758:	d779                	beqz	a4,1726 <strlen+0x18>
    175a:	0017c703          	lbu	a4,1(a5)
    175e:	0785                	addi	a5,a5,1
    1760:	d379                	beqz	a4,1726 <strlen+0x18>
    1762:	0017c703          	lbu	a4,1(a5)
    1766:	0785                	addi	a5,a5,1
    1768:	fb6d                	bnez	a4,175a <strlen+0x4c>
    176a:	bf75                	j	1726 <strlen+0x18>

000000000000176c <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    176c:	00757713          	andi	a4,a0,7
{
    1770:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1772:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1776:	cb19                	beqz	a4,178c <memchr+0x20>
    1778:	ce25                	beqz	a2,17f0 <memchr+0x84>
    177a:	0007c703          	lbu	a4,0(a5)
    177e:	04b70e63          	beq	a4,a1,17da <memchr+0x6e>
    1782:	0785                	addi	a5,a5,1
    1784:	0077f713          	andi	a4,a5,7
    1788:	167d                	addi	a2,a2,-1
    178a:	f77d                	bnez	a4,1778 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    178c:	4501                	li	a0,0
    if (n && *s != c) {
    178e:	c235                	beqz	a2,17f2 <memchr+0x86>
    1790:	0007c703          	lbu	a4,0(a5)
    1794:	04b70363          	beq	a4,a1,17da <memchr+0x6e>
        size_t k = ONES * c;
    1798:	00000517          	auipc	a0,0x0
    179c:	5f053503          	ld	a0,1520(a0) # 1d88 <sharedmem+0x4c>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    17a0:	471d                	li	a4,7
        size_t k = ONES * c;
    17a2:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    17a6:	02c77a63          	bgeu	a4,a2,17da <memchr+0x6e>
    17aa:	00000897          	auipc	a7,0x0
    17ae:	5ce8b883          	ld	a7,1486(a7) # 1d78 <sharedmem+0x3c>
    17b2:	00000817          	auipc	a6,0x0
    17b6:	5ce83803          	ld	a6,1486(a6) # 1d80 <sharedmem+0x44>
    17ba:	431d                	li	t1,7
    17bc:	a029                	j	17c6 <memchr+0x5a>
    17be:	1661                	addi	a2,a2,-8
    17c0:	07a1                	addi	a5,a5,8
    17c2:	02c37963          	bgeu	t1,a2,17f4 <memchr+0x88>
    17c6:	6398                	ld	a4,0(a5)
    17c8:	8f29                	xor	a4,a4,a0
    17ca:	011706b3          	add	a3,a4,a7
    17ce:	fff74713          	not	a4,a4
    17d2:	8f75                	and	a4,a4,a3
    17d4:	01077733          	and	a4,a4,a6
    17d8:	d37d                	beqz	a4,17be <memchr+0x52>
    17da:	853e                	mv	a0,a5
    17dc:	97b2                	add	a5,a5,a2
    17de:	a021                	j	17e6 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    17e0:	0505                	addi	a0,a0,1
    17e2:	00f50763          	beq	a0,a5,17f0 <memchr+0x84>
    17e6:	00054703          	lbu	a4,0(a0)
    17ea:	feb71be3          	bne	a4,a1,17e0 <memchr+0x74>
    17ee:	8082                	ret
    return n ? (void*)s : 0;
    17f0:	4501                	li	a0,0
}
    17f2:	8082                	ret
    return n ? (void*)s : 0;
    17f4:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    17f6:	f275                	bnez	a2,17da <memchr+0x6e>
}
    17f8:	8082                	ret

00000000000017fa <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    17fa:	1101                	addi	sp,sp,-32
    17fc:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    17fe:	862e                	mv	a2,a1
{
    1800:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1802:	4581                	li	a1,0
{
    1804:	e426                	sd	s1,8(sp)
    1806:	ec06                	sd	ra,24(sp)
    1808:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    180a:	f63ff0ef          	jal	ra,176c <memchr>
    return p ? p - s : n;
    180e:	c519                	beqz	a0,181c <strnlen+0x22>
}
    1810:	60e2                	ld	ra,24(sp)
    1812:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1814:	8d05                	sub	a0,a0,s1
}
    1816:	64a2                	ld	s1,8(sp)
    1818:	6105                	addi	sp,sp,32
    181a:	8082                	ret
    181c:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    181e:	8522                	mv	a0,s0
}
    1820:	6442                	ld	s0,16(sp)
    1822:	64a2                	ld	s1,8(sp)
    1824:	6105                	addi	sp,sp,32
    1826:	8082                	ret

0000000000001828 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1828:	00b547b3          	xor	a5,a0,a1
    182c:	8b9d                	andi	a5,a5,7
    182e:	eb95                	bnez	a5,1862 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1830:	0075f793          	andi	a5,a1,7
    1834:	e7b1                	bnez	a5,1880 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1836:	6198                	ld	a4,0(a1)
    1838:	00000617          	auipc	a2,0x0
    183c:	54063603          	ld	a2,1344(a2) # 1d78 <sharedmem+0x3c>
    1840:	00000817          	auipc	a6,0x0
    1844:	54083803          	ld	a6,1344(a6) # 1d80 <sharedmem+0x44>
    1848:	a029                	j	1852 <stpcpy+0x2a>
    184a:	e118                	sd	a4,0(a0)
    184c:	6598                	ld	a4,8(a1)
    184e:	05a1                	addi	a1,a1,8
    1850:	0521                	addi	a0,a0,8
    1852:	00c707b3          	add	a5,a4,a2
    1856:	fff74693          	not	a3,a4
    185a:	8ff5                	and	a5,a5,a3
    185c:	0107f7b3          	and	a5,a5,a6
    1860:	d7ed                	beqz	a5,184a <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1862:	0005c783          	lbu	a5,0(a1)
    1866:	00f50023          	sb	a5,0(a0)
    186a:	c785                	beqz	a5,1892 <stpcpy+0x6a>
    186c:	0015c783          	lbu	a5,1(a1)
    1870:	0505                	addi	a0,a0,1
    1872:	0585                	addi	a1,a1,1
    1874:	00f50023          	sb	a5,0(a0)
    1878:	fbf5                	bnez	a5,186c <stpcpy+0x44>
        ;
    return d;
}
    187a:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    187c:	0505                	addi	a0,a0,1
    187e:	df45                	beqz	a4,1836 <stpcpy+0xe>
            if (!(*d = *s))
    1880:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1884:	0585                	addi	a1,a1,1
    1886:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    188a:	00f50023          	sb	a5,0(a0)
    188e:	f7fd                	bnez	a5,187c <stpcpy+0x54>
}
    1890:	8082                	ret
    1892:	8082                	ret

0000000000001894 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1894:	00b547b3          	xor	a5,a0,a1
    1898:	8b9d                	andi	a5,a5,7
    189a:	1a079863          	bnez	a5,1a4a <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    189e:	0075f793          	andi	a5,a1,7
    18a2:	16078463          	beqz	a5,1a0a <stpncpy+0x176>
    18a6:	ea01                	bnez	a2,18b6 <stpncpy+0x22>
    18a8:	a421                	j	1ab0 <stpncpy+0x21c>
    18aa:	167d                	addi	a2,a2,-1
    18ac:	0505                	addi	a0,a0,1
    18ae:	14070e63          	beqz	a4,1a0a <stpncpy+0x176>
    18b2:	1a060863          	beqz	a2,1a62 <stpncpy+0x1ce>
    18b6:	0005c783          	lbu	a5,0(a1)
    18ba:	0585                	addi	a1,a1,1
    18bc:	0075f713          	andi	a4,a1,7
    18c0:	00f50023          	sb	a5,0(a0)
    18c4:	f3fd                	bnez	a5,18aa <stpncpy+0x16>
    18c6:	4805                	li	a6,1
    18c8:	1a061863          	bnez	a2,1a78 <stpncpy+0x1e4>
    18cc:	40a007b3          	neg	a5,a0
    18d0:	8b9d                	andi	a5,a5,7
    18d2:	4681                	li	a3,0
    18d4:	18061a63          	bnez	a2,1a68 <stpncpy+0x1d4>
    18d8:	00778713          	addi	a4,a5,7
    18dc:	45ad                	li	a1,11
    18de:	18b76363          	bltu	a4,a1,1a64 <stpncpy+0x1d0>
    18e2:	1ae6eb63          	bltu	a3,a4,1a98 <stpncpy+0x204>
    18e6:	1a078363          	beqz	a5,1a8c <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    18ea:	00050023          	sb	zero,0(a0)
    18ee:	4685                	li	a3,1
    18f0:	00150713          	addi	a4,a0,1
    18f4:	18d78f63          	beq	a5,a3,1a92 <stpncpy+0x1fe>
    18f8:	000500a3          	sb	zero,1(a0)
    18fc:	4689                	li	a3,2
    18fe:	00250713          	addi	a4,a0,2
    1902:	18d78e63          	beq	a5,a3,1a9e <stpncpy+0x20a>
    1906:	00050123          	sb	zero,2(a0)
    190a:	468d                	li	a3,3
    190c:	00350713          	addi	a4,a0,3
    1910:	16d78c63          	beq	a5,a3,1a88 <stpncpy+0x1f4>
    1914:	000501a3          	sb	zero,3(a0)
    1918:	4691                	li	a3,4
    191a:	00450713          	addi	a4,a0,4
    191e:	18d78263          	beq	a5,a3,1aa2 <stpncpy+0x20e>
    1922:	00050223          	sb	zero,4(a0)
    1926:	4695                	li	a3,5
    1928:	00550713          	addi	a4,a0,5
    192c:	16d78d63          	beq	a5,a3,1aa6 <stpncpy+0x212>
    1930:	000502a3          	sb	zero,5(a0)
    1934:	469d                	li	a3,7
    1936:	00650713          	addi	a4,a0,6
    193a:	16d79863          	bne	a5,a3,1aaa <stpncpy+0x216>
    193e:	00750713          	addi	a4,a0,7
    1942:	00050323          	sb	zero,6(a0)
    1946:	40f80833          	sub	a6,a6,a5
    194a:	ff887593          	andi	a1,a6,-8
    194e:	97aa                	add	a5,a5,a0
    1950:	95be                	add	a1,a1,a5
    1952:	0007b023          	sd	zero,0(a5)
    1956:	07a1                	addi	a5,a5,8
    1958:	feb79de3          	bne	a5,a1,1952 <stpncpy+0xbe>
    195c:	ff887593          	andi	a1,a6,-8
    1960:	9ead                	addw	a3,a3,a1
    1962:	00b707b3          	add	a5,a4,a1
    1966:	12b80863          	beq	a6,a1,1a96 <stpncpy+0x202>
    196a:	00078023          	sb	zero,0(a5)
    196e:	0016871b          	addiw	a4,a3,1
    1972:	0ec77863          	bgeu	a4,a2,1a62 <stpncpy+0x1ce>
    1976:	000780a3          	sb	zero,1(a5)
    197a:	0026871b          	addiw	a4,a3,2
    197e:	0ec77263          	bgeu	a4,a2,1a62 <stpncpy+0x1ce>
    1982:	00078123          	sb	zero,2(a5)
    1986:	0036871b          	addiw	a4,a3,3
    198a:	0cc77c63          	bgeu	a4,a2,1a62 <stpncpy+0x1ce>
    198e:	000781a3          	sb	zero,3(a5)
    1992:	0046871b          	addiw	a4,a3,4
    1996:	0cc77663          	bgeu	a4,a2,1a62 <stpncpy+0x1ce>
    199a:	00078223          	sb	zero,4(a5)
    199e:	0056871b          	addiw	a4,a3,5
    19a2:	0cc77063          	bgeu	a4,a2,1a62 <stpncpy+0x1ce>
    19a6:	000782a3          	sb	zero,5(a5)
    19aa:	0066871b          	addiw	a4,a3,6
    19ae:	0ac77a63          	bgeu	a4,a2,1a62 <stpncpy+0x1ce>
    19b2:	00078323          	sb	zero,6(a5)
    19b6:	0076871b          	addiw	a4,a3,7
    19ba:	0ac77463          	bgeu	a4,a2,1a62 <stpncpy+0x1ce>
    19be:	000783a3          	sb	zero,7(a5)
    19c2:	0086871b          	addiw	a4,a3,8
    19c6:	08c77e63          	bgeu	a4,a2,1a62 <stpncpy+0x1ce>
    19ca:	00078423          	sb	zero,8(a5)
    19ce:	0096871b          	addiw	a4,a3,9
    19d2:	08c77863          	bgeu	a4,a2,1a62 <stpncpy+0x1ce>
    19d6:	000784a3          	sb	zero,9(a5)
    19da:	00a6871b          	addiw	a4,a3,10
    19de:	08c77263          	bgeu	a4,a2,1a62 <stpncpy+0x1ce>
    19e2:	00078523          	sb	zero,10(a5)
    19e6:	00b6871b          	addiw	a4,a3,11
    19ea:	06c77c63          	bgeu	a4,a2,1a62 <stpncpy+0x1ce>
    19ee:	000785a3          	sb	zero,11(a5)
    19f2:	00c6871b          	addiw	a4,a3,12
    19f6:	06c77663          	bgeu	a4,a2,1a62 <stpncpy+0x1ce>
    19fa:	00078623          	sb	zero,12(a5)
    19fe:	26b5                	addiw	a3,a3,13
    1a00:	06c6f163          	bgeu	a3,a2,1a62 <stpncpy+0x1ce>
    1a04:	000786a3          	sb	zero,13(a5)
    1a08:	8082                	ret
            ;
        if (!n || !*s)
    1a0a:	c645                	beqz	a2,1ab2 <stpncpy+0x21e>
    1a0c:	0005c783          	lbu	a5,0(a1)
    1a10:	ea078be3          	beqz	a5,18c6 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1a14:	479d                	li	a5,7
    1a16:	02c7ff63          	bgeu	a5,a2,1a54 <stpncpy+0x1c0>
    1a1a:	00000897          	auipc	a7,0x0
    1a1e:	35e8b883          	ld	a7,862(a7) # 1d78 <sharedmem+0x3c>
    1a22:	00000817          	auipc	a6,0x0
    1a26:	35e83803          	ld	a6,862(a6) # 1d80 <sharedmem+0x44>
    1a2a:	431d                	li	t1,7
    1a2c:	6198                	ld	a4,0(a1)
    1a2e:	011707b3          	add	a5,a4,a7
    1a32:	fff74693          	not	a3,a4
    1a36:	8ff5                	and	a5,a5,a3
    1a38:	0107f7b3          	and	a5,a5,a6
    1a3c:	ef81                	bnez	a5,1a54 <stpncpy+0x1c0>
            *wd = *ws;
    1a3e:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1a40:	1661                	addi	a2,a2,-8
    1a42:	05a1                	addi	a1,a1,8
    1a44:	0521                	addi	a0,a0,8
    1a46:	fec363e3          	bltu	t1,a2,1a2c <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1a4a:	e609                	bnez	a2,1a54 <stpncpy+0x1c0>
    1a4c:	a08d                	j	1aae <stpncpy+0x21a>
    1a4e:	167d                	addi	a2,a2,-1
    1a50:	0505                	addi	a0,a0,1
    1a52:	ca01                	beqz	a2,1a62 <stpncpy+0x1ce>
    1a54:	0005c783          	lbu	a5,0(a1)
    1a58:	0585                	addi	a1,a1,1
    1a5a:	00f50023          	sb	a5,0(a0)
    1a5e:	fbe5                	bnez	a5,1a4e <stpncpy+0x1ba>
        ;
tail:
    1a60:	b59d                	j	18c6 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1a62:	8082                	ret
    1a64:	472d                	li	a4,11
    1a66:	bdb5                	j	18e2 <stpncpy+0x4e>
    1a68:	00778713          	addi	a4,a5,7
    1a6c:	45ad                	li	a1,11
    1a6e:	fff60693          	addi	a3,a2,-1
    1a72:	e6b778e3          	bgeu	a4,a1,18e2 <stpncpy+0x4e>
    1a76:	b7fd                	j	1a64 <stpncpy+0x1d0>
    1a78:	40a007b3          	neg	a5,a0
    1a7c:	8832                	mv	a6,a2
    1a7e:	8b9d                	andi	a5,a5,7
    1a80:	4681                	li	a3,0
    1a82:	e4060be3          	beqz	a2,18d8 <stpncpy+0x44>
    1a86:	b7cd                	j	1a68 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1a88:	468d                	li	a3,3
    1a8a:	bd75                	j	1946 <stpncpy+0xb2>
    1a8c:	872a                	mv	a4,a0
    1a8e:	4681                	li	a3,0
    1a90:	bd5d                	j	1946 <stpncpy+0xb2>
    1a92:	4685                	li	a3,1
    1a94:	bd4d                	j	1946 <stpncpy+0xb2>
    1a96:	8082                	ret
    1a98:	87aa                	mv	a5,a0
    1a9a:	4681                	li	a3,0
    1a9c:	b5f9                	j	196a <stpncpy+0xd6>
    1a9e:	4689                	li	a3,2
    1aa0:	b55d                	j	1946 <stpncpy+0xb2>
    1aa2:	4691                	li	a3,4
    1aa4:	b54d                	j	1946 <stpncpy+0xb2>
    1aa6:	4695                	li	a3,5
    1aa8:	bd79                	j	1946 <stpncpy+0xb2>
    1aaa:	4699                	li	a3,6
    1aac:	bd69                	j	1946 <stpncpy+0xb2>
    1aae:	8082                	ret
    1ab0:	8082                	ret
    1ab2:	8082                	ret

0000000000001ab4 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1ab4:	fff6071b          	addiw	a4,a2,-1
    1ab8:	0cb57063          	bgeu	a0,a1,1b78 <memmove+0xc4>
        while (n-- > 0)
    1abc:	0ec05063          	blez	a2,1b9c <memmove+0xe8>
    1ac0:	00750693          	addi	a3,a0,7
    1ac4:	8e8d                	sub	a3,a3,a1
    1ac6:	00b567b3          	or	a5,a0,a1
    1aca:	00f6b693          	sltiu	a3,a3,15
    1ace:	8b9d                	andi	a5,a5,7
    1ad0:	0016c693          	xori	a3,a3,1
    1ad4:	0017b793          	seqz	a5,a5
    1ad8:	8ff5                	and	a5,a5,a3
    1ada:	c3f1                	beqz	a5,1b9e <memmove+0xea>
    1adc:	0007079b          	sext.w	a5,a4
    1ae0:	46a5                	li	a3,9
    1ae2:	0af6fe63          	bgeu	a3,a5,1b9e <memmove+0xea>
    1ae6:	0036589b          	srliw	a7,a2,0x3
    1aea:	088e                	slli	a7,a7,0x3
    1aec:	2601                	sext.w	a2,a2
    1aee:	87ae                	mv	a5,a1
    1af0:	86aa                	mv	a3,a0
    1af2:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1af4:	0007b803          	ld	a6,0(a5)
    1af8:	07a1                	addi	a5,a5,8
    1afa:	06a1                	addi	a3,a3,8
    1afc:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1b00:	ff179ae3          	bne	a5,a7,1af4 <memmove+0x40>
    1b04:	ff867813          	andi	a6,a2,-8
    1b08:	02081793          	slli	a5,a6,0x20
    1b0c:	9381                	srli	a5,a5,0x20
    1b0e:	00f506b3          	add	a3,a0,a5
    1b12:	95be                	add	a1,a1,a5
    1b14:	4107073b          	subw	a4,a4,a6
    1b18:	09060263          	beq	a2,a6,1b9c <memmove+0xe8>
            *dst++ = *src++;
    1b1c:	0005c783          	lbu	a5,0(a1)
    1b20:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1b24:	06e05c63          	blez	a4,1b9c <memmove+0xe8>
            *dst++ = *src++;
    1b28:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1b2c:	4785                	li	a5,1
            *dst++ = *src++;
    1b2e:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1b32:	06e7d563          	bge	a5,a4,1b9c <memmove+0xe8>
            *dst++ = *src++;
    1b36:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1b3a:	4789                	li	a5,2
            *dst++ = *src++;
    1b3c:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1b40:	04e7de63          	bge	a5,a4,1b9c <memmove+0xe8>
            *dst++ = *src++;
    1b44:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1b48:	478d                	li	a5,3
            *dst++ = *src++;
    1b4a:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1b4e:	04e7d763          	bge	a5,a4,1b9c <memmove+0xe8>
            *dst++ = *src++;
    1b52:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1b56:	4791                	li	a5,4
            *dst++ = *src++;
    1b58:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1b5c:	04e7d063          	bge	a5,a4,1b9c <memmove+0xe8>
            *dst++ = *src++;
    1b60:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1b64:	4795                	li	a5,5
            *dst++ = *src++;
    1b66:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1b6a:	02e7d963          	bge	a5,a4,1b9c <memmove+0xe8>
            *dst++ = *src++;
    1b6e:	0065c783          	lbu	a5,6(a1)
    1b72:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1b76:	8082                	ret
    } else {
        dst += n;
    1b78:	00c507b3          	add	a5,a0,a2
        src += n;
    1b7c:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1b7e:	00c05f63          	blez	a2,1b9c <memmove+0xe8>
    1b82:	1702                	slli	a4,a4,0x20
    1b84:	9301                	srli	a4,a4,0x20
    1b86:	fff74713          	not	a4,a4
    1b8a:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1b8c:	fff5c683          	lbu	a3,-1(a1)
    1b90:	17fd                	addi	a5,a5,-1
    1b92:	15fd                	addi	a1,a1,-1
    1b94:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1b98:	fee79ae3          	bne	a5,a4,1b8c <memmove+0xd8>
    }
    return vdst;
}
    1b9c:	8082                	ret
    1b9e:	02071693          	slli	a3,a4,0x20
    1ba2:	9281                	srli	a3,a3,0x20
    1ba4:	0685                	addi	a3,a3,1
    1ba6:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1ba8:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1baa:	0005c703          	lbu	a4,0(a1)
    1bae:	0585                	addi	a1,a1,1
    1bb0:	0785                	addi	a5,a5,1
    1bb2:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1bb6:	fed59ae3          	bne	a1,a3,1baa <memmove+0xf6>
    1bba:	8082                	ret

0000000000001bbc <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1bbc:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1bc0:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1bc4:	2501                	sext.w	a0,a0
    1bc6:	8082                	ret

0000000000001bc8 <exec>:
    register long a7 __asm__("a7") = n;
    1bc8:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1bcc:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1bce:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1bd2:	2501                	sext.w	a0,a0
    1bd4:	8082                	ret

0000000000001bd6 <exit>:
    register long a7 __asm__("a7") = n;
    1bd6:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1bda:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1bde:	8082                	ret

0000000000001be0 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1be0:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1be4:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1be8:	8082                	ret

0000000000001bea <write>:
    register long a7 __asm__("a7") = n;
    1bea:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1bee:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1bf2:	8082                	ret

0000000000001bf4 <getpid>:
    register long a7 __asm__("a7") = n;
    1bf4:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1bf8:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1bfc:	2501                	sext.w	a0,a0
    1bfe:	8082                	ret

0000000000001c00 <getppid>:
    register long a7 __asm__("a7") = n;
    1c00:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1c04:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1c08:	2501                	sext.w	a0,a0
    1c0a:	8082                	ret

0000000000001c0c <open>:
    register long a7 __asm__("a7") = n;
    1c0c:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c10:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1c14:	2501                	sext.w	a0,a0
    1c16:	8082                	ret

0000000000001c18 <mknod>:
    register long a7 __asm__("a7") = n;
    1c18:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1c1c:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1c20:	2501                	sext.w	a0,a0
    1c22:	8082                	ret

0000000000001c24 <dup>:
    register long a7 __asm__("a7") = n;
    1c24:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1c26:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1c2a:	2501                	sext.w	a0,a0
    1c2c:	8082                	ret

0000000000001c2e <sched_yield>:
    register long a7 __asm__("a7") = n;
    1c2e:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c32:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1c36:	2501                	sext.w	a0,a0
    1c38:	8082                	ret

0000000000001c3a <waitpid>:
    register long a7 __asm__("a7") = n;
    1c3a:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c3e:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1c42:	2501                	sext.w	a0,a0
    1c44:	8082                	ret

0000000000001c46 <wait>:

pid_t wait(int *wstatus)
{
    1c46:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1c48:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1c4c:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1c4e:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1c52:	2501                	sext.w	a0,a0
    1c54:	8082                	ret

0000000000001c56 <mkdir>:
    register long a7 __asm__("a7") = n;
    1c56:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1c5a:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1c5e:	2501                	sext.w	a0,a0
    1c60:	8082                	ret

0000000000001c62 <close>:
    register long a7 __asm__("a7") = n;
    1c62:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1c66:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1c6a:	2501                	sext.w	a0,a0
    1c6c:	8082                	ret

0000000000001c6e <fork>:
    register long a7 __asm__("a7") = n;
    1c6e:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1c72:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1c76:	2501                	sext.w	a0,a0
    1c78:	8082                	ret

0000000000001c7a <time_ms>:
    register long a7 __asm__("a7") = n;
    1c7a:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c7e:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1c82:	8082                	ret

0000000000001c84 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1c84:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1c86:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1c8a:	00000073          	ecall
    1c8e:	87aa                	mv	a5,a0
    1c90:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1c94:	97ba                	add	a5,a5,a4
    1c96:	00f57c63          	bgeu	a0,a5,1cae <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1c9a:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1c9e:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1ca2:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1ca6:	00000073          	ecall
    1caa:	fef568e3          	bltu	a0,a5,1c9a <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1cae:	4501                	li	a0,0
    1cb0:	8082                	ret

0000000000001cb2 <pipe>:
    register long a7 __asm__("a7") = n;
    1cb2:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1cb6:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1cba:	2501                	sext.w	a0,a0
    1cbc:	8082                	ret

0000000000001cbe <fstat>:
    register long a7 __asm__("a7") = n;
    1cbe:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cc2:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1cc6:	2501                	sext.w	a0,a0
    1cc8:	8082                	ret

0000000000001cca <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1cca:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1ccc:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1cd0:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cd2:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1cd6:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1cda:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1cde:	0206c163          	bltz	a3,1d00 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1ce2:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1ce6:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1ce8:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cea:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1cee:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1cf2:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1cf6:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1cf8:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1cfc:	853e                	mv	a0,a5
    1cfe:	8082                	ret
        return -1;
    1d00:	57fd                	li	a5,-1
    1d02:	bfed                	j	1cfc <stat+0x32>

0000000000001d04 <chdir>:
    register long a7 __asm__("a7") = n;
    1d04:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1d08:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1d0c:	2501                	sext.w	a0,a0
    1d0e:	8082                	ret

0000000000001d10 <link>:
    register long a7 __asm__("a7") = n;
    1d10:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d14:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1d18:	2501                	sext.w	a0,a0
    1d1a:	8082                	ret

0000000000001d1c <unlink>:
    register long a7 __asm__("a7") = n;
    1d1c:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1d20:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1d24:	2501                	sext.w	a0,a0
    1d26:	8082                	ret

0000000000001d28 <setpriority>:
    register long a7 __asm__("a7") = n;
    1d28:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1d2c:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1d30:	8082                	ret

0000000000001d32 <getpriority>:
    register long a7 __asm__("a7") = n;
    1d32:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1d36:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1d3a:	8082                	ret

0000000000001d3c <sharedmem>:
    register long a7 __asm__("a7") = n;
    1d3c:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d40:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1d44:	8082                	ret
