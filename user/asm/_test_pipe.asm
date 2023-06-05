
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_pipe:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a23d                	j	112e <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <ucore.h>
#include <string.h>

char STR[] = "hello pipe!";

int main() {
    1002:	7139                	addi	sp,sp,-64
    // create pipe
    int pipe_fd[2];
    int ret = pipe((void*)pipe_fd);
    1004:	850a                	mv	a0,sp
int main() {
    1006:	fc06                	sd	ra,56(sp)
    1008:	f822                	sd	s0,48(sp)
    int ret = pipe((void*)pipe_fd);
    100a:	5d7000ef          	jal	ra,1de0 <pipe>
    assert(ret == 0, -2);
    100e:	00153513          	seqz	a0,a0
    1012:	55f9                	li	a1,-2
    1014:	542000ef          	jal	ra,1556 <assert>
    printf("pipe_fd=%p\n", pipe_fd);
    1018:	858a                	mv	a1,sp
    101a:	00001517          	auipc	a0,0x1
    101e:	e5e50513          	addi	a0,a0,-418 # 1e78 <sharedmem+0xe>
    1022:	1a2000ef          	jal	ra,11c4 <printf>
    printf("[parent] read end = %d, write end = %d\n", pipe_fd[0], pipe_fd[1]);
    1026:	4612                	lw	a2,4(sp)
    1028:	4582                	lw	a1,0(sp)
    102a:	00001517          	auipc	a0,0x1
    102e:	e5e50513          	addi	a0,a0,-418 # 1e88 <sharedmem+0x1e>
    1032:	192000ef          	jal	ra,11c4 <printf>
    if (fork() == 0) {
    1036:	567000ef          	jal	ra,1d9c <fork>
    103a:	c549                	beqz	a0,10c4 <main+0xc2>
        puts("Read OK, child process exited!");
        return 0;
    } else {
        // parent process, write to child
        // close read end
        close(pipe_fd[0]);
    103c:	4502                	lw	a0,0(sp)
    103e:	553000ef          	jal	ra,1d90 <close>
        printf("[parent] close read end\n");
    1042:	00001517          	auipc	a0,0x1
    1046:	ebe50513          	addi	a0,a0,-322 # 1f00 <sharedmem+0x96>
    104a:	17a000ef          	jal	ra,11c4 <printf>
        assert(write(pipe_fd[1], STR, strlen(STR)) == strlen(STR), -3);
    104e:	4412                	lw	s0,4(sp)
    1050:	00001517          	auipc	a0,0x1
    1054:	f3850513          	addi	a0,a0,-200 # 1f88 <STR>
    1058:	7e4000ef          	jal	ra,183c <strlen>
    105c:	862a                	mv	a2,a0
    105e:	00001597          	auipc	a1,0x1
    1062:	f2a58593          	addi	a1,a1,-214 # 1f88 <STR>
    1066:	8522                	mv	a0,s0
    1068:	4b1000ef          	jal	ra,1d18 <write>
    106c:	842a                	mv	s0,a0
    106e:	00001517          	auipc	a0,0x1
    1072:	f1a50513          	addi	a0,a0,-230 # 1f88 <STR>
    1076:	7c6000ef          	jal	ra,183c <strlen>
    107a:	40a40533          	sub	a0,s0,a0
    107e:	55f5                	li	a1,-3
    1080:	00153513          	seqz	a0,a0
    1084:	4d2000ef          	jal	ra,1556 <assert>
        printf("[parent] write over\n");
    1088:	00001517          	auipc	a0,0x1
    108c:	e9850513          	addi	a0,a0,-360 # 1f20 <sharedmem+0xb6>
    1090:	134000ef          	jal	ra,11c4 <printf>
        // close write end
        close(pipe_fd[1]);
    1094:	4512                	lw	a0,4(sp)
    1096:	4fb000ef          	jal	ra,1d90 <close>
        int exit_code = 0;
        wait(&exit_code);
    109a:	0028                	addi	a0,sp,8
        int exit_code = 0;
    109c:	c402                	sw	zero,8(sp)
        wait(&exit_code);
    109e:	4d7000ef          	jal	ra,1d74 <wait>
        assert(exit_code == 0, -2);
    10a2:	4522                	lw	a0,8(sp)
    10a4:	55f9                	li	a1,-2
    10a6:	00153513          	seqz	a0,a0
    10aa:	4ac000ef          	jal	ra,1556 <assert>
        puts("pipetest passed!");
    10ae:	00001517          	auipc	a0,0x1
    10b2:	e8a50513          	addi	a0,a0,-374 # 1f38 <sharedmem+0xce>
    10b6:	0c8000ef          	jal	ra,117e <puts>
    }
    return 0;
}
    10ba:	70e2                	ld	ra,56(sp)
    10bc:	7442                	ld	s0,48(sp)
    10be:	4501                	li	a0,0
    10c0:	6121                	addi	sp,sp,64
    10c2:	8082                	ret
        close(pipe_fd[1]);
    10c4:	4512                	lw	a0,4(sp)
    10c6:	4cb000ef          	jal	ra,1d90 <close>
        puts("[child] close write end");
    10ca:	00001517          	auipc	a0,0x1
    10ce:	de650513          	addi	a0,a0,-538 # 1eb0 <sharedmem+0x46>
    10d2:	0ac000ef          	jal	ra,117e <puts>
        int len_read = read(pipe_fd[0], buffer, 32);
    10d6:	4502                	lw	a0,0(sp)
    10d8:	002c                	addi	a1,sp,8
    10da:	02000613          	li	a2,32
    10de:	431000ef          	jal	ra,1d0e <read>
    10e2:	842a                	mv	s0,a0
        puts("[chile] read over");
    10e4:	00001517          	auipc	a0,0x1
    10e8:	de450513          	addi	a0,a0,-540 # 1ec8 <sharedmem+0x5e>
    10ec:	092000ef          	jal	ra,117e <puts>
        buffer[len_read] = 0;
    10f0:	181c                	addi	a5,sp,48
    10f2:	2401                	sext.w	s0,s0
    10f4:	943e                	add	s0,s0,a5
        assert(strncmp(buffer, STR, strlen(STR)) == 0, -3);
    10f6:	00001517          	auipc	a0,0x1
    10fa:	e9250513          	addi	a0,a0,-366 # 1f88 <STR>
        buffer[len_read] = 0;
    10fe:	fc040c23          	sb	zero,-40(s0)
        assert(strncmp(buffer, STR, strlen(STR)) == 0, -3);
    1102:	73a000ef          	jal	ra,183c <strlen>
    1106:	862a                	mv	a2,a0
    1108:	00001597          	auipc	a1,0x1
    110c:	e8058593          	addi	a1,a1,-384 # 1f88 <STR>
    1110:	0028                	addi	a0,sp,8
    1112:	6e8000ef          	jal	ra,17fa <strncmp>
    1116:	00153513          	seqz	a0,a0
    111a:	55f5                	li	a1,-3
    111c:	43a000ef          	jal	ra,1556 <assert>
        puts("Read OK, child process exited!");
    1120:	00001517          	auipc	a0,0x1
    1124:	dc050513          	addi	a0,a0,-576 # 1ee0 <sharedmem+0x76>
    1128:	056000ef          	jal	ra,117e <puts>
        return 0;
    112c:	b779                	j	10ba <main+0xb8>

000000000000112e <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    112e:	1141                	addi	sp,sp,-16
    1130:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    1132:	ed1ff0ef          	jal	ra,1002 <main>
}
    1136:	60a2                	ld	ra,8(sp)
    1138:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    113a:	3cb0006f          	j	1d04 <exit>

000000000000113e <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    113e:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    1140:	00f10593          	addi	a1,sp,15
    1144:	4605                	li	a2,1
    1146:	4501                	li	a0,0
int getchar() {
    1148:	ec06                	sd	ra,24(sp)
    char byte = 0;
    114a:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    114e:	3c1000ef          	jal	ra,1d0e <read>
    return byte;
}
    1152:	60e2                	ld	ra,24(sp)
    1154:	00f14503          	lbu	a0,15(sp)
    1158:	6105                	addi	sp,sp,32
    115a:	8082                	ret

000000000000115c <putchar>:

int putchar(int c)
{
    115c:	1141                	addi	sp,sp,-16
    115e:	e406                	sd	ra,8(sp)
    1160:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    1162:	00001597          	auipc	a1,0x1
    1166:	e1658593          	addi	a1,a1,-490 # 1f78 <put.1156>
    return write(stdout, put, 1);
    116a:	4605                	li	a2,1
    116c:	4505                	li	a0,1
    put[0] = c;
    116e:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1172:	3a7000ef          	jal	ra,1d18 <write>
}
    1176:	60a2                	ld	ra,8(sp)
    1178:	2501                	sext.w	a0,a0
    117a:	0141                	addi	sp,sp,16
    117c:	8082                	ret

000000000000117e <puts>:

int puts(const char* s)
{
    117e:	1141                	addi	sp,sp,-16
    1180:	e022                	sd	s0,0(sp)
    1182:	e406                	sd	ra,8(sp)
    1184:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    1186:	6b6000ef          	jal	ra,183c <strlen>
    118a:	862a                	mv	a2,a0
    118c:	85a2                	mv	a1,s0
    118e:	4505                	li	a0,1
    1190:	389000ef          	jal	ra,1d18 <write>
    1194:	00055763          	bgez	a0,11a2 <puts+0x24>
    return r;
}
    1198:	60a2                	ld	ra,8(sp)
    119a:	6402                	ld	s0,0(sp)
    119c:	557d                	li	a0,-1
    119e:	0141                	addi	sp,sp,16
    11a0:	8082                	ret
    put[0] = c;
    11a2:	00001597          	auipc	a1,0x1
    11a6:	dd658593          	addi	a1,a1,-554 # 1f78 <put.1156>
    11aa:	47a9                	li	a5,10
    return write(stdout, put, 1);
    11ac:	4605                	li	a2,1
    11ae:	4505                	li	a0,1
    put[0] = c;
    11b0:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    11b4:	365000ef          	jal	ra,1d18 <write>
}
    11b8:	60a2                	ld	ra,8(sp)
    11ba:	6402                	ld	s0,0(sp)
    11bc:	41f5551b          	sraiw	a0,a0,0x1f
    11c0:	0141                	addi	sp,sp,16
    11c2:	8082                	ret

00000000000011c4 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    11c4:	7115                	addi	sp,sp,-224
    11c6:	ed06                	sd	ra,152(sp)
    11c8:	e922                	sd	s0,144(sp)
    11ca:	e526                	sd	s1,136(sp)
    11cc:	e14a                	sd	s2,128(sp)
    11ce:	fcce                	sd	s3,120(sp)
    11d0:	f8d2                	sd	s4,112(sp)
    11d2:	f4d6                	sd	s5,104(sp)
    11d4:	f0da                	sd	s6,96(sp)
    11d6:	ecde                	sd	s7,88(sp)
    11d8:	e8e2                	sd	s8,80(sp)
    11da:	e4e6                	sd	s9,72(sp)
    11dc:	e0ea                	sd	s10,64(sp)
    11de:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    11e0:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    11e4:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    11e6:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    11e8:	f52e                	sd	a1,168(sp)
    11ea:	f932                	sd	a2,176(sp)
    11ec:	fd36                	sd	a3,184(sp)
    11ee:	e1ba                	sd	a4,192(sp)
    11f0:	e9c2                	sd	a6,208(sp)
    11f2:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    11f4:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    11f6:	0c030b63          	beqz	t1,12cc <printf+0x108>
    11fa:	8aaa                	mv	s5,a0
    11fc:	0003071b          	sext.w	a4,t1
    1200:	4481                	li	s1,0
        if (c != '%') {
    1202:	02500b93          	li	s7,37
    put[0] = c;
    1206:	00001417          	auipc	s0,0x1
    120a:	d7240413          	addi	s0,s0,-654 # 1f78 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    120e:	4c51                	li	s8,20
    put[0] = c;
    1210:	02500c93          	li	s9,37
    1214:	00001a17          	auipc	s4,0x1
    1218:	d84a0a13          	addi	s4,s4,-636 # 1f98 <STR+0x10>
    121c:	00001997          	auipc	s3,0x1
    1220:	dd498993          	addi	s3,s3,-556 # 1ff0 <digits>
    1224:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    1228:	0014879b          	addiw	a5,s1,1
    122c:	00fa8933          	add	s2,s5,a5
    1230:	13771163          	bne	a4,s7,1352 <printf+0x18e>
        c = fmt[++i] & 0xff;
    1234:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    1238:	080d0a63          	beqz	s10,12cc <printf+0x108>
        switch (c) {
    123c:	2489                	addiw	s1,s1,2
    123e:	009a8933          	add	s2,s5,s1
    1242:	257d0e63          	beq	s10,s7,149e <printf+0x2da>
    1246:	f9cd079b          	addiw	a5,s10,-100
    124a:	0ff7f793          	andi	a5,a5,255
    124e:	0cfc6263          	bltu	s8,a5,1312 <printf+0x14e>
    1252:	078a                	slli	a5,a5,0x2
    1254:	97d2                	add	a5,a5,s4
    1256:	439c                	lw	a5,0(a5)
    1258:	97d2                	add	a5,a5,s4
    125a:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    125c:	67a2                	ld	a5,8(sp)
    125e:	4398                	lw	a4,0(a5)
    1260:	07a1                	addi	a5,a5,8
    1262:	e43e                	sd	a5,8(sp)
    1264:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    1268:	26074663          	bltz	a4,14d4 <printf+0x310>
        buf[i++] = digits[x % base];
    126c:	8bbd                	andi	a5,a5,15
    126e:	97ce                	add	a5,a5,s3
    1270:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1274:	40475d1b          	sraiw	s10,a4,0x4
    1278:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    127c:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    1280:	020d0163          	beqz	s10,12a2 <printf+0xde>
        buf[i++] = digits[x % base];
    1284:	9d4e                	add	s10,s10,s3
    1286:	000d4783          	lbu	a5,0(s10)
    128a:	4d05                	li	s10,1
    128c:	00f108a3          	sb	a5,17(sp)
    if (sign)
    1290:	00075963          	bgez	a4,12a2 <printf+0xde>
        buf[i++] = digits[x % base];
    1294:	4d09                	li	s10,2
        buf[i++] = '-';
    1296:	181c                	addi	a5,sp,48
    1298:	02d00713          	li	a4,45
    129c:	97ea                	add	a5,a5,s10
    129e:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    12a2:	9d5a                	add	s10,s10,s6
    12a4:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    12a8:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    12ac:	4605                	li	a2,1
    12ae:	1d7d                	addi	s10,s10,-1
    12b0:	85a2                	mv	a1,s0
    12b2:	4505                	li	a0,1
    put[0] = c;
    12b4:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    12b8:	261000ef          	jal	ra,1d18 <write>
    while (--i >= 0)
    12bc:	ffbd16e3          	bne	s10,s11,12a8 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    12c0:	00094303          	lbu	t1,0(s2)
    12c4:	0003071b          	sext.w	a4,t1
    12c8:	f60310e3          	bnez	t1,1228 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    12cc:	60ea                	ld	ra,152(sp)
    12ce:	644a                	ld	s0,144(sp)
    12d0:	64aa                	ld	s1,136(sp)
    12d2:	690a                	ld	s2,128(sp)
    12d4:	79e6                	ld	s3,120(sp)
    12d6:	7a46                	ld	s4,112(sp)
    12d8:	7aa6                	ld	s5,104(sp)
    12da:	7b06                	ld	s6,96(sp)
    12dc:	6be6                	ld	s7,88(sp)
    12de:	6c46                	ld	s8,80(sp)
    12e0:	6ca6                	ld	s9,72(sp)
    12e2:	6d06                	ld	s10,64(sp)
    12e4:	7de2                	ld	s11,56(sp)
    12e6:	612d                	addi	sp,sp,224
    12e8:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    12ea:	67a2                	ld	a5,8(sp)
    12ec:	0007bd03          	ld	s10,0(a5)
    12f0:	07a1                	addi	a5,a5,8
    12f2:	e43e                	sd	a5,8(sp)
    12f4:	000d1b63          	bnez	s10,130a <printf+0x146>
    12f8:	aafd                	j	14f6 <printf+0x332>
    return write(stdout, put, 1);
    12fa:	4605                	li	a2,1
    12fc:	85a2                	mv	a1,s0
    12fe:	4505                	li	a0,1
                for (; *s; s++)
    1300:	0d05                	addi	s10,s10,1
    put[0] = c;
    1302:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1306:	213000ef          	jal	ra,1d18 <write>
                for (; *s; s++)
    130a:	000d4783          	lbu	a5,0(s10)
    130e:	f7f5                	bnez	a5,12fa <printf+0x136>
    1310:	a02d                	j	133a <printf+0x176>
    return write(stdout, put, 1);
    1312:	4605                	li	a2,1
    1314:	00001597          	auipc	a1,0x1
    1318:	c6458593          	addi	a1,a1,-924 # 1f78 <put.1156>
    131c:	4505                	li	a0,1
    put[0] = c;
    131e:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    1322:	1f7000ef          	jal	ra,1d18 <write>
    1326:	4605                	li	a2,1
    1328:	00001597          	auipc	a1,0x1
    132c:	c5058593          	addi	a1,a1,-944 # 1f78 <put.1156>
    1330:	4505                	li	a0,1
    put[0] = c;
    1332:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    1336:	1e3000ef          	jal	ra,1d18 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    133a:	00094303          	lbu	t1,0(s2)
    133e:	0003071b          	sext.w	a4,t1
    1342:	f80305e3          	beqz	t1,12cc <printf+0x108>
        if (c != '%') {
    1346:	0014879b          	addiw	a5,s1,1
    134a:	00fa8933          	add	s2,s5,a5
    134e:	ef7703e3          	beq	a4,s7,1234 <printf+0x70>
    return write(stdout, put, 1);
    1352:	4605                	li	a2,1
    1354:	00001597          	auipc	a1,0x1
    1358:	c2458593          	addi	a1,a1,-988 # 1f78 <put.1156>
    135c:	4505                	li	a0,1
    put[0] = c;
    135e:	00640023          	sb	t1,0(s0)
            continue;
    1362:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    1364:	1b5000ef          	jal	ra,1d18 <write>
            continue;
    1368:	bfc9                	j	133a <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    136a:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    136c:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    136e:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    1370:	0007b883          	ld	a7,0(a5)
    1374:	07a1                	addi	a5,a5,8
    1376:	e43e                	sd	a5,8(sp)
        x = -xx;
    1378:	43f8d713          	srai	a4,a7,0x3f
    137c:	011747b3          	xor	a5,a4,a7
    1380:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    1382:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    1384:	02c7f733          	remu	a4,a5,a2
    1388:	8d36                	mv	s10,a3
    138a:	0685                	addi	a3,a3,1
    138c:	00db0533          	add	a0,s6,a3
    1390:	85be                	mv	a1,a5
    1392:	974e                	add	a4,a4,s3
    1394:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    1398:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    139c:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    13a0:	feb862e3          	bltu	a6,a1,1384 <printf+0x1c0>
    if (sign)
    13a4:	1208c063          	bltz	a7,14c4 <printf+0x300>
    while (--i >= 0)
    13a8:	9d5a                	add	s10,s10,s6
    put[0] = c;
    13aa:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    13ae:	4605                	li	a2,1
    13b0:	85a2                	mv	a1,s0
    13b2:	4505                	li	a0,1
    put[0] = c;
    13b4:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    13b8:	161000ef          	jal	ra,1d18 <write>
    while (--i >= 0)
    13bc:	87ea                	mv	a5,s10
    13be:	1d7d                	addi	s10,s10,-1
    13c0:	fefb15e3          	bne	s6,a5,13aa <printf+0x1e6>
    13c4:	bf9d                	j	133a <printf+0x176>
                printptr(va_arg(ap, uint64));
    13c6:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    13c8:	4605                	li	a2,1
    13ca:	00001597          	auipc	a1,0x1
    13ce:	bae58593          	addi	a1,a1,-1106 # 1f78 <put.1156>
                printptr(va_arg(ap, uint64));
    13d2:	0007bd83          	ld	s11,0(a5)
    13d6:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    13da:	4505                	li	a0,1
    put[0] = c;
    13dc:	03000793          	li	a5,48
    13e0:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    13e4:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    13e6:	133000ef          	jal	ra,1d18 <write>
    put[0] = c;
    13ea:	07800793          	li	a5,120
    return write(stdout, put, 1);
    13ee:	4605                	li	a2,1
    13f0:	00001597          	auipc	a1,0x1
    13f4:	b8858593          	addi	a1,a1,-1144 # 1f78 <put.1156>
    13f8:	4505                	li	a0,1
    put[0] = c;
    13fa:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    13fe:	4d41                	li	s10,16
    1400:	119000ef          	jal	ra,1d18 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    1404:	03cdd793          	srli	a5,s11,0x3c
    1408:	97ce                	add	a5,a5,s3
    put[0] = c;
    140a:	0007c783          	lbu	a5,0(a5)
    140e:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    1410:	4605                	li	a2,1
    1412:	85a2                	mv	a1,s0
    1414:	4505                	li	a0,1
    put[0] = c;
    1416:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    141a:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    141c:	0fd000ef          	jal	ra,1d18 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1420:	fe0d12e3          	bnez	s10,1404 <printf+0x240>
    1424:	bf19                	j	133a <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    1426:	67a2                	ld	a5,8(sp)
    1428:	4394                	lw	a3,0(a5)
    142a:	07a1                	addi	a5,a5,8
    142c:	e43e                	sd	a5,8(sp)
    142e:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    1432:	0006d663          	bgez	a3,143e <printf+0x27a>
        x = -xx;
    1436:	40f007bb          	negw	a5,a5
    143a:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    143e:	4729                	li	a4,10
    1440:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    1444:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    1448:	964e                	add	a2,a2,s3
    144a:	00064603          	lbu	a2,0(a2)
    144e:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    1452:	0a0d0963          	beqz	s10,1504 <printf+0x340>
        buf[i++] = digits[x % base];
    1456:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    145a:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    145e:	00c98733          	add	a4,s3,a2
    1462:	00074703          	lbu	a4,0(a4)
    1466:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    146a:	c3cd                	beqz	a5,150c <printf+0x348>
        buf[i++] = digits[x % base];
    146c:	97ce                	add	a5,a5,s3
    146e:	0007c703          	lbu	a4,0(a5)
    1472:	4d09                	li	s10,2
    1474:	478d                	li	a5,3
    1476:	00e10923          	sb	a4,18(sp)
    if (sign)
    147a:	0206cd63          	bltz	a3,14b4 <printf+0x2f0>
    while (--i >= 0)
    147e:	9d5a                	add	s10,s10,s6
    1480:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1484:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1488:	4605                	li	a2,1
    148a:	1d7d                	addi	s10,s10,-1
    148c:	85a2                	mv	a1,s0
    148e:	4505                	li	a0,1
    put[0] = c;
    1490:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1494:	085000ef          	jal	ra,1d18 <write>
    while (--i >= 0)
    1498:	ffbd16e3          	bne	s10,s11,1484 <printf+0x2c0>
    149c:	bd79                	j	133a <printf+0x176>
    return write(stdout, put, 1);
    149e:	4605                	li	a2,1
    14a0:	00001597          	auipc	a1,0x1
    14a4:	ad858593          	addi	a1,a1,-1320 # 1f78 <put.1156>
    14a8:	4505                	li	a0,1
    put[0] = c;
    14aa:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    14ae:	06b000ef          	jal	ra,1d18 <write>
    14b2:	b561                	j	133a <printf+0x176>
        buf[i++] = '-';
    14b4:	1818                	addi	a4,sp,48
    14b6:	973e                	add	a4,a4,a5
    14b8:	02d00693          	li	a3,45
    14bc:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    14c0:	8d3e                	mv	s10,a5
    14c2:	bf75                	j	147e <printf+0x2ba>
        buf[i++] = '-';
    14c4:	181c                	addi	a5,sp,48
    14c6:	97b6                	add	a5,a5,a3
    14c8:	02d00713          	li	a4,45
    14cc:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    14d0:	8d36                	mv	s10,a3
    14d2:	bdd9                	j	13a8 <printf+0x1e4>
        x = -xx;
    14d4:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    14d8:	00f7f693          	andi	a3,a5,15
    14dc:	96ce                	add	a3,a3,s3
    14de:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    14e2:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    14e6:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    14ea:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    14ee:	d80d1be3          	bnez	s10,1284 <printf+0xc0>
        buf[i++] = digits[x % base];
    14f2:	4d05                	li	s10,1
    14f4:	b34d                	j	1296 <printf+0xd2>
                s = "(null)";
    14f6:	00001d17          	auipc	s10,0x1
    14fa:	a5ad0d13          	addi	s10,s10,-1446 # 1f50 <sharedmem+0xe6>
                for (; *s; s++)
    14fe:	02800793          	li	a5,40
    1502:	bbe5                	j	12fa <printf+0x136>
        buf[i++] = digits[x % base];
    1504:	4785                	li	a5,1
    if (sign)
    1506:	f606dce3          	bgez	a3,147e <printf+0x2ba>
    150a:	b76d                	j	14b4 <printf+0x2f0>
        buf[i++] = digits[x % base];
    150c:	4789                	li	a5,2
    150e:	4d05                	li	s10,1
    if (sign)
    1510:	f606d7e3          	bgez	a3,147e <printf+0x2ba>
    1514:	b745                	j	14b4 <printf+0x2f0>

0000000000001516 <srand>:
#include <ucore.h>

static uint64 seed;

void srand(unsigned s) {
    seed = s - 1;
    1516:	357d                	addiw	a0,a0,-1
    1518:	1502                	slli	a0,a0,0x20
    151a:	9101                	srli	a0,a0,0x20
    151c:	00001797          	auipc	a5,0x1
    1520:	a6a7b223          	sd	a0,-1436(a5) # 1f80 <seed>
}
    1524:	8082                	ret

0000000000001526 <rand>:

int rand(void) {
    seed = 6364136223846793005ULL * seed + 1;
    1526:	00001797          	auipc	a5,0x1
    152a:	a5a78793          	addi	a5,a5,-1446 # 1f80 <seed>
    152e:	6388                	ld	a0,0(a5)
    1530:	00001717          	auipc	a4,0x1
    1534:	a2873703          	ld	a4,-1496(a4) # 1f58 <sharedmem+0xee>
    1538:	02e50533          	mul	a0,a0,a4
    153c:	0505                	addi	a0,a0,1
    153e:	e388                	sd	a0,0(a5)
    return seed >> 33;
}
    1540:	9105                	srli	a0,a0,0x21
    1542:	8082                	ret

0000000000001544 <panic>:

void panic(char* m) {
    1544:	1141                	addi	sp,sp,-16
    1546:	e406                	sd	ra,8(sp)
    puts(m);
    1548:	c37ff0ef          	jal	ra,117e <puts>
    exit(-100);
}
    154c:	60a2                	ld	ra,8(sp)
    exit(-100);
    154e:	f9c00513          	li	a0,-100
}
    1552:	0141                	addi	sp,sp,16
    exit(-100);
    1554:	af45                	j	1d04 <exit>

0000000000001556 <assert>:

void assert(int f, int code) {
    if(!f) {
    1556:	c111                	beqz	a0,155a <assert+0x4>
        exit(code);
    }
    1558:	8082                	ret
        exit(code);
    155a:	852e                	mv	a0,a1
    155c:	a765                	j	1d04 <exit>

000000000000155e <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    155e:	02000793          	li	a5,32
    1562:	00f50663          	beq	a0,a5,156e <isspace+0x10>
    1566:	355d                	addiw	a0,a0,-9
    1568:	00553513          	sltiu	a0,a0,5
    156c:	8082                	ret
    156e:	4505                	li	a0,1
}
    1570:	8082                	ret

0000000000001572 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1572:	fd05051b          	addiw	a0,a0,-48
}
    1576:	00a53513          	sltiu	a0,a0,10
    157a:	8082                	ret

000000000000157c <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    157c:	02000613          	li	a2,32
    1580:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1582:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1586:	ff77069b          	addiw	a3,a4,-9
    158a:	04c70d63          	beq	a4,a2,15e4 <atoi+0x68>
    158e:	0007079b          	sext.w	a5,a4
    1592:	04d5f963          	bgeu	a1,a3,15e4 <atoi+0x68>
        s++;
    switch (*s) {
    1596:	02b00693          	li	a3,43
    159a:	04d70a63          	beq	a4,a3,15ee <atoi+0x72>
    159e:	02d00693          	li	a3,45
    15a2:	06d70463          	beq	a4,a3,160a <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    15a6:	fd07859b          	addiw	a1,a5,-48
    15aa:	4625                	li	a2,9
    15ac:	873e                	mv	a4,a5
    15ae:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    15b0:	4e01                	li	t3,0
    while (isdigit(*s))
    15b2:	04b66a63          	bltu	a2,a1,1606 <atoi+0x8a>
    int n = 0, neg = 0;
    15b6:	4501                	li	a0,0
    while (isdigit(*s))
    15b8:	4825                	li	a6,9
    15ba:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    15be:	0025179b          	slliw	a5,a0,0x2
    15c2:	9d3d                	addw	a0,a0,a5
    15c4:	fd07031b          	addiw	t1,a4,-48
    15c8:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    15cc:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    15d0:	0685                	addi	a3,a3,1
    15d2:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    15d6:	0006071b          	sext.w	a4,a2
    15da:	feb870e3          	bgeu	a6,a1,15ba <atoi+0x3e>
    return neg ? n : -n;
    15de:	000e0563          	beqz	t3,15e8 <atoi+0x6c>
}
    15e2:	8082                	ret
        s++;
    15e4:	0505                	addi	a0,a0,1
    15e6:	bf71                	j	1582 <atoi+0x6>
    15e8:	4113053b          	subw	a0,t1,a7
    15ec:	8082                	ret
    while (isdigit(*s))
    15ee:	00154783          	lbu	a5,1(a0)
    15f2:	4625                	li	a2,9
        s++;
    15f4:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    15f8:	fd07859b          	addiw	a1,a5,-48
    15fc:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1600:	4e01                	li	t3,0
    while (isdigit(*s))
    1602:	fab67ae3          	bgeu	a2,a1,15b6 <atoi+0x3a>
    1606:	4501                	li	a0,0
}
    1608:	8082                	ret
    while (isdigit(*s))
    160a:	00154783          	lbu	a5,1(a0)
    160e:	4625                	li	a2,9
        s++;
    1610:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1614:	fd07859b          	addiw	a1,a5,-48
    1618:	0007871b          	sext.w	a4,a5
    161c:	feb665e3          	bltu	a2,a1,1606 <atoi+0x8a>
        neg = 1;
    1620:	4e05                	li	t3,1
    1622:	bf51                	j	15b6 <atoi+0x3a>

0000000000001624 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    1624:	16060d63          	beqz	a2,179e <memset+0x17a>
    1628:	40a007b3          	neg	a5,a0
    162c:	8b9d                	andi	a5,a5,7
    162e:	00778713          	addi	a4,a5,7
    1632:	482d                	li	a6,11
    1634:	0ff5f593          	andi	a1,a1,255
    1638:	fff60693          	addi	a3,a2,-1
    163c:	17076263          	bltu	a4,a6,17a0 <memset+0x17c>
    1640:	16e6ea63          	bltu	a3,a4,17b4 <memset+0x190>
    1644:	16078563          	beqz	a5,17ae <memset+0x18a>
    1648:	00b50023          	sb	a1,0(a0)
    164c:	4705                	li	a4,1
    164e:	00150e93          	addi	t4,a0,1
    1652:	14e78c63          	beq	a5,a4,17aa <memset+0x186>
    1656:	00b500a3          	sb	a1,1(a0)
    165a:	4709                	li	a4,2
    165c:	00250e93          	addi	t4,a0,2
    1660:	14e78d63          	beq	a5,a4,17ba <memset+0x196>
    1664:	00b50123          	sb	a1,2(a0)
    1668:	470d                	li	a4,3
    166a:	00350e93          	addi	t4,a0,3
    166e:	12e78b63          	beq	a5,a4,17a4 <memset+0x180>
    1672:	00b501a3          	sb	a1,3(a0)
    1676:	4711                	li	a4,4
    1678:	00450e93          	addi	t4,a0,4
    167c:	14e78163          	beq	a5,a4,17be <memset+0x19a>
    1680:	00b50223          	sb	a1,4(a0)
    1684:	4715                	li	a4,5
    1686:	00550e93          	addi	t4,a0,5
    168a:	12e78c63          	beq	a5,a4,17c2 <memset+0x19e>
    168e:	00b502a3          	sb	a1,5(a0)
    1692:	471d                	li	a4,7
    1694:	00650e93          	addi	t4,a0,6
    1698:	12e79763          	bne	a5,a4,17c6 <memset+0x1a2>
    169c:	00750e93          	addi	t4,a0,7
    16a0:	00b50323          	sb	a1,6(a0)
    16a4:	4f1d                	li	t5,7
    16a6:	00859713          	slli	a4,a1,0x8
    16aa:	8f4d                	or	a4,a4,a1
    16ac:	01059e13          	slli	t3,a1,0x10
    16b0:	01c76e33          	or	t3,a4,t3
    16b4:	01859313          	slli	t1,a1,0x18
    16b8:	006e6333          	or	t1,t3,t1
    16bc:	02059893          	slli	a7,a1,0x20
    16c0:	011368b3          	or	a7,t1,a7
    16c4:	02859813          	slli	a6,a1,0x28
    16c8:	40f60333          	sub	t1,a2,a5
    16cc:	0108e833          	or	a6,a7,a6
    16d0:	03059693          	slli	a3,a1,0x30
    16d4:	00d866b3          	or	a3,a6,a3
    16d8:	03859713          	slli	a4,a1,0x38
    16dc:	97aa                	add	a5,a5,a0
    16de:	ff837813          	andi	a6,t1,-8
    16e2:	8f55                	or	a4,a4,a3
    16e4:	00f806b3          	add	a3,a6,a5
    16e8:	e398                	sd	a4,0(a5)
    16ea:	07a1                	addi	a5,a5,8
    16ec:	fed79ee3          	bne	a5,a3,16e8 <memset+0xc4>
    16f0:	ff837693          	andi	a3,t1,-8
    16f4:	00de87b3          	add	a5,t4,a3
    16f8:	01e6873b          	addw	a4,a3,t5
    16fc:	0ad30663          	beq	t1,a3,17a8 <memset+0x184>
    1700:	00b78023          	sb	a1,0(a5)
    1704:	0017069b          	addiw	a3,a4,1
    1708:	08c6fb63          	bgeu	a3,a2,179e <memset+0x17a>
    170c:	00b780a3          	sb	a1,1(a5)
    1710:	0027069b          	addiw	a3,a4,2
    1714:	08c6f563          	bgeu	a3,a2,179e <memset+0x17a>
    1718:	00b78123          	sb	a1,2(a5)
    171c:	0037069b          	addiw	a3,a4,3
    1720:	06c6ff63          	bgeu	a3,a2,179e <memset+0x17a>
    1724:	00b781a3          	sb	a1,3(a5)
    1728:	0047069b          	addiw	a3,a4,4
    172c:	06c6f963          	bgeu	a3,a2,179e <memset+0x17a>
    1730:	00b78223          	sb	a1,4(a5)
    1734:	0057069b          	addiw	a3,a4,5
    1738:	06c6f363          	bgeu	a3,a2,179e <memset+0x17a>
    173c:	00b782a3          	sb	a1,5(a5)
    1740:	0067069b          	addiw	a3,a4,6
    1744:	04c6fd63          	bgeu	a3,a2,179e <memset+0x17a>
    1748:	00b78323          	sb	a1,6(a5)
    174c:	0077069b          	addiw	a3,a4,7
    1750:	04c6f763          	bgeu	a3,a2,179e <memset+0x17a>
    1754:	00b783a3          	sb	a1,7(a5)
    1758:	0087069b          	addiw	a3,a4,8
    175c:	04c6f163          	bgeu	a3,a2,179e <memset+0x17a>
    1760:	00b78423          	sb	a1,8(a5)
    1764:	0097069b          	addiw	a3,a4,9
    1768:	02c6fb63          	bgeu	a3,a2,179e <memset+0x17a>
    176c:	00b784a3          	sb	a1,9(a5)
    1770:	00a7069b          	addiw	a3,a4,10
    1774:	02c6f563          	bgeu	a3,a2,179e <memset+0x17a>
    1778:	00b78523          	sb	a1,10(a5)
    177c:	00b7069b          	addiw	a3,a4,11
    1780:	00c6ff63          	bgeu	a3,a2,179e <memset+0x17a>
    1784:	00b785a3          	sb	a1,11(a5)
    1788:	00c7069b          	addiw	a3,a4,12
    178c:	00c6f963          	bgeu	a3,a2,179e <memset+0x17a>
    1790:	00b78623          	sb	a1,12(a5)
    1794:	2735                	addiw	a4,a4,13
    1796:	00c77463          	bgeu	a4,a2,179e <memset+0x17a>
    179a:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    179e:	8082                	ret
    17a0:	472d                	li	a4,11
    17a2:	bd79                	j	1640 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    17a4:	4f0d                	li	t5,3
    17a6:	b701                	j	16a6 <memset+0x82>
    17a8:	8082                	ret
    17aa:	4f05                	li	t5,1
    17ac:	bded                	j	16a6 <memset+0x82>
    17ae:	8eaa                	mv	t4,a0
    17b0:	4f01                	li	t5,0
    17b2:	bdd5                	j	16a6 <memset+0x82>
    17b4:	87aa                	mv	a5,a0
    17b6:	4701                	li	a4,0
    17b8:	b7a1                	j	1700 <memset+0xdc>
    17ba:	4f09                	li	t5,2
    17bc:	b5ed                	j	16a6 <memset+0x82>
    17be:	4f11                	li	t5,4
    17c0:	b5dd                	j	16a6 <memset+0x82>
    17c2:	4f15                	li	t5,5
    17c4:	b5cd                	j	16a6 <memset+0x82>
    17c6:	4f19                	li	t5,6
    17c8:	bdf9                	j	16a6 <memset+0x82>

00000000000017ca <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    17ca:	00054783          	lbu	a5,0(a0)
    17ce:	0005c703          	lbu	a4,0(a1)
    17d2:	00e79863          	bne	a5,a4,17e2 <strcmp+0x18>
    17d6:	0505                	addi	a0,a0,1
    17d8:	0585                	addi	a1,a1,1
    17da:	fbe5                	bnez	a5,17ca <strcmp>
    17dc:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    17de:	9d19                	subw	a0,a0,a4
    17e0:	8082                	ret
    17e2:	0007851b          	sext.w	a0,a5
    17e6:	bfe5                	j	17de <strcmp+0x14>

00000000000017e8 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    17e8:	87aa                	mv	a5,a0
    17ea:	0005c703          	lbu	a4,0(a1)
    17ee:	0785                	addi	a5,a5,1
    17f0:	0585                	addi	a1,a1,1
    17f2:	fee78fa3          	sb	a4,-1(a5)
    17f6:	fb75                	bnez	a4,17ea <strcpy+0x2>
        ;
    return os;
}
    17f8:	8082                	ret

00000000000017fa <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    17fa:	ce05                	beqz	a2,1832 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    17fc:	00054703          	lbu	a4,0(a0)
    1800:	0005c783          	lbu	a5,0(a1)
    1804:	cb0d                	beqz	a4,1836 <strncmp+0x3c>
    if (!n--)
    1806:	167d                	addi	a2,a2,-1
    1808:	00c506b3          	add	a3,a0,a2
    180c:	a819                	j	1822 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    180e:	00a68e63          	beq	a3,a0,182a <strncmp+0x30>
    1812:	0505                	addi	a0,a0,1
    1814:	00e79b63          	bne	a5,a4,182a <strncmp+0x30>
    1818:	00054703          	lbu	a4,0(a0)
    181c:	0005c783          	lbu	a5,0(a1)
    1820:	cb19                	beqz	a4,1836 <strncmp+0x3c>
    1822:	0005c783          	lbu	a5,0(a1)
    1826:	0585                	addi	a1,a1,1
    1828:	f3fd                	bnez	a5,180e <strncmp+0x14>
        ;
    return *l - *r;
    182a:	0007051b          	sext.w	a0,a4
    182e:	9d1d                	subw	a0,a0,a5
    1830:	8082                	ret
        return 0;
    1832:	4501                	li	a0,0
}
    1834:	8082                	ret
    1836:	4501                	li	a0,0
    return *l - *r;
    1838:	9d1d                	subw	a0,a0,a5
    183a:	8082                	ret

000000000000183c <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    183c:	00757793          	andi	a5,a0,7
    1840:	cf89                	beqz	a5,185a <strlen+0x1e>
    1842:	87aa                	mv	a5,a0
    1844:	a029                	j	184e <strlen+0x12>
    1846:	0785                	addi	a5,a5,1
    1848:	0077f713          	andi	a4,a5,7
    184c:	cb01                	beqz	a4,185c <strlen+0x20>
        if (!*s)
    184e:	0007c703          	lbu	a4,0(a5)
    1852:	fb75                	bnez	a4,1846 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1854:	40a78533          	sub	a0,a5,a0
}
    1858:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    185a:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    185c:	6394                	ld	a3,0(a5)
    185e:	00000597          	auipc	a1,0x0
    1862:	7025b583          	ld	a1,1794(a1) # 1f60 <sharedmem+0xf6>
    1866:	00000617          	auipc	a2,0x0
    186a:	70263603          	ld	a2,1794(a2) # 1f68 <sharedmem+0xfe>
    186e:	a019                	j	1874 <strlen+0x38>
    1870:	6794                	ld	a3,8(a5)
    1872:	07a1                	addi	a5,a5,8
    1874:	00b68733          	add	a4,a3,a1
    1878:	fff6c693          	not	a3,a3
    187c:	8f75                	and	a4,a4,a3
    187e:	8f71                	and	a4,a4,a2
    1880:	db65                	beqz	a4,1870 <strlen+0x34>
    for (; *s; s++)
    1882:	0007c703          	lbu	a4,0(a5)
    1886:	d779                	beqz	a4,1854 <strlen+0x18>
    1888:	0017c703          	lbu	a4,1(a5)
    188c:	0785                	addi	a5,a5,1
    188e:	d379                	beqz	a4,1854 <strlen+0x18>
    1890:	0017c703          	lbu	a4,1(a5)
    1894:	0785                	addi	a5,a5,1
    1896:	fb6d                	bnez	a4,1888 <strlen+0x4c>
    1898:	bf75                	j	1854 <strlen+0x18>

000000000000189a <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    189a:	00757713          	andi	a4,a0,7
{
    189e:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    18a0:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    18a4:	cb19                	beqz	a4,18ba <memchr+0x20>
    18a6:	ce25                	beqz	a2,191e <memchr+0x84>
    18a8:	0007c703          	lbu	a4,0(a5)
    18ac:	04b70e63          	beq	a4,a1,1908 <memchr+0x6e>
    18b0:	0785                	addi	a5,a5,1
    18b2:	0077f713          	andi	a4,a5,7
    18b6:	167d                	addi	a2,a2,-1
    18b8:	f77d                	bnez	a4,18a6 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    18ba:	4501                	li	a0,0
    if (n && *s != c) {
    18bc:	c235                	beqz	a2,1920 <memchr+0x86>
    18be:	0007c703          	lbu	a4,0(a5)
    18c2:	04b70363          	beq	a4,a1,1908 <memchr+0x6e>
        size_t k = ONES * c;
    18c6:	00000517          	auipc	a0,0x0
    18ca:	6aa53503          	ld	a0,1706(a0) # 1f70 <sharedmem+0x106>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    18ce:	471d                	li	a4,7
        size_t k = ONES * c;
    18d0:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    18d4:	02c77a63          	bgeu	a4,a2,1908 <memchr+0x6e>
    18d8:	00000897          	auipc	a7,0x0
    18dc:	6888b883          	ld	a7,1672(a7) # 1f60 <sharedmem+0xf6>
    18e0:	00000817          	auipc	a6,0x0
    18e4:	68883803          	ld	a6,1672(a6) # 1f68 <sharedmem+0xfe>
    18e8:	431d                	li	t1,7
    18ea:	a029                	j	18f4 <memchr+0x5a>
    18ec:	1661                	addi	a2,a2,-8
    18ee:	07a1                	addi	a5,a5,8
    18f0:	02c37963          	bgeu	t1,a2,1922 <memchr+0x88>
    18f4:	6398                	ld	a4,0(a5)
    18f6:	8f29                	xor	a4,a4,a0
    18f8:	011706b3          	add	a3,a4,a7
    18fc:	fff74713          	not	a4,a4
    1900:	8f75                	and	a4,a4,a3
    1902:	01077733          	and	a4,a4,a6
    1906:	d37d                	beqz	a4,18ec <memchr+0x52>
    1908:	853e                	mv	a0,a5
    190a:	97b2                	add	a5,a5,a2
    190c:	a021                	j	1914 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    190e:	0505                	addi	a0,a0,1
    1910:	00f50763          	beq	a0,a5,191e <memchr+0x84>
    1914:	00054703          	lbu	a4,0(a0)
    1918:	feb71be3          	bne	a4,a1,190e <memchr+0x74>
    191c:	8082                	ret
    return n ? (void*)s : 0;
    191e:	4501                	li	a0,0
}
    1920:	8082                	ret
    return n ? (void*)s : 0;
    1922:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1924:	f275                	bnez	a2,1908 <memchr+0x6e>
}
    1926:	8082                	ret

0000000000001928 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1928:	1101                	addi	sp,sp,-32
    192a:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    192c:	862e                	mv	a2,a1
{
    192e:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1930:	4581                	li	a1,0
{
    1932:	e426                	sd	s1,8(sp)
    1934:	ec06                	sd	ra,24(sp)
    1936:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1938:	f63ff0ef          	jal	ra,189a <memchr>
    return p ? p - s : n;
    193c:	c519                	beqz	a0,194a <strnlen+0x22>
}
    193e:	60e2                	ld	ra,24(sp)
    1940:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1942:	8d05                	sub	a0,a0,s1
}
    1944:	64a2                	ld	s1,8(sp)
    1946:	6105                	addi	sp,sp,32
    1948:	8082                	ret
    194a:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    194c:	8522                	mv	a0,s0
}
    194e:	6442                	ld	s0,16(sp)
    1950:	64a2                	ld	s1,8(sp)
    1952:	6105                	addi	sp,sp,32
    1954:	8082                	ret

0000000000001956 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1956:	00b547b3          	xor	a5,a0,a1
    195a:	8b9d                	andi	a5,a5,7
    195c:	eb95                	bnez	a5,1990 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    195e:	0075f793          	andi	a5,a1,7
    1962:	e7b1                	bnez	a5,19ae <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1964:	6198                	ld	a4,0(a1)
    1966:	00000617          	auipc	a2,0x0
    196a:	5fa63603          	ld	a2,1530(a2) # 1f60 <sharedmem+0xf6>
    196e:	00000817          	auipc	a6,0x0
    1972:	5fa83803          	ld	a6,1530(a6) # 1f68 <sharedmem+0xfe>
    1976:	a029                	j	1980 <stpcpy+0x2a>
    1978:	e118                	sd	a4,0(a0)
    197a:	6598                	ld	a4,8(a1)
    197c:	05a1                	addi	a1,a1,8
    197e:	0521                	addi	a0,a0,8
    1980:	00c707b3          	add	a5,a4,a2
    1984:	fff74693          	not	a3,a4
    1988:	8ff5                	and	a5,a5,a3
    198a:	0107f7b3          	and	a5,a5,a6
    198e:	d7ed                	beqz	a5,1978 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1990:	0005c783          	lbu	a5,0(a1)
    1994:	00f50023          	sb	a5,0(a0)
    1998:	c785                	beqz	a5,19c0 <stpcpy+0x6a>
    199a:	0015c783          	lbu	a5,1(a1)
    199e:	0505                	addi	a0,a0,1
    19a0:	0585                	addi	a1,a1,1
    19a2:	00f50023          	sb	a5,0(a0)
    19a6:	fbf5                	bnez	a5,199a <stpcpy+0x44>
        ;
    return d;
}
    19a8:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    19aa:	0505                	addi	a0,a0,1
    19ac:	df45                	beqz	a4,1964 <stpcpy+0xe>
            if (!(*d = *s))
    19ae:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    19b2:	0585                	addi	a1,a1,1
    19b4:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    19b8:	00f50023          	sb	a5,0(a0)
    19bc:	f7fd                	bnez	a5,19aa <stpcpy+0x54>
}
    19be:	8082                	ret
    19c0:	8082                	ret

00000000000019c2 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    19c2:	00b547b3          	xor	a5,a0,a1
    19c6:	8b9d                	andi	a5,a5,7
    19c8:	1a079863          	bnez	a5,1b78 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    19cc:	0075f793          	andi	a5,a1,7
    19d0:	16078463          	beqz	a5,1b38 <stpncpy+0x176>
    19d4:	ea01                	bnez	a2,19e4 <stpncpy+0x22>
    19d6:	a421                	j	1bde <stpncpy+0x21c>
    19d8:	167d                	addi	a2,a2,-1
    19da:	0505                	addi	a0,a0,1
    19dc:	14070e63          	beqz	a4,1b38 <stpncpy+0x176>
    19e0:	1a060863          	beqz	a2,1b90 <stpncpy+0x1ce>
    19e4:	0005c783          	lbu	a5,0(a1)
    19e8:	0585                	addi	a1,a1,1
    19ea:	0075f713          	andi	a4,a1,7
    19ee:	00f50023          	sb	a5,0(a0)
    19f2:	f3fd                	bnez	a5,19d8 <stpncpy+0x16>
    19f4:	4805                	li	a6,1
    19f6:	1a061863          	bnez	a2,1ba6 <stpncpy+0x1e4>
    19fa:	40a007b3          	neg	a5,a0
    19fe:	8b9d                	andi	a5,a5,7
    1a00:	4681                	li	a3,0
    1a02:	18061a63          	bnez	a2,1b96 <stpncpy+0x1d4>
    1a06:	00778713          	addi	a4,a5,7
    1a0a:	45ad                	li	a1,11
    1a0c:	18b76363          	bltu	a4,a1,1b92 <stpncpy+0x1d0>
    1a10:	1ae6eb63          	bltu	a3,a4,1bc6 <stpncpy+0x204>
    1a14:	1a078363          	beqz	a5,1bba <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1a18:	00050023          	sb	zero,0(a0)
    1a1c:	4685                	li	a3,1
    1a1e:	00150713          	addi	a4,a0,1
    1a22:	18d78f63          	beq	a5,a3,1bc0 <stpncpy+0x1fe>
    1a26:	000500a3          	sb	zero,1(a0)
    1a2a:	4689                	li	a3,2
    1a2c:	00250713          	addi	a4,a0,2
    1a30:	18d78e63          	beq	a5,a3,1bcc <stpncpy+0x20a>
    1a34:	00050123          	sb	zero,2(a0)
    1a38:	468d                	li	a3,3
    1a3a:	00350713          	addi	a4,a0,3
    1a3e:	16d78c63          	beq	a5,a3,1bb6 <stpncpy+0x1f4>
    1a42:	000501a3          	sb	zero,3(a0)
    1a46:	4691                	li	a3,4
    1a48:	00450713          	addi	a4,a0,4
    1a4c:	18d78263          	beq	a5,a3,1bd0 <stpncpy+0x20e>
    1a50:	00050223          	sb	zero,4(a0)
    1a54:	4695                	li	a3,5
    1a56:	00550713          	addi	a4,a0,5
    1a5a:	16d78d63          	beq	a5,a3,1bd4 <stpncpy+0x212>
    1a5e:	000502a3          	sb	zero,5(a0)
    1a62:	469d                	li	a3,7
    1a64:	00650713          	addi	a4,a0,6
    1a68:	16d79863          	bne	a5,a3,1bd8 <stpncpy+0x216>
    1a6c:	00750713          	addi	a4,a0,7
    1a70:	00050323          	sb	zero,6(a0)
    1a74:	40f80833          	sub	a6,a6,a5
    1a78:	ff887593          	andi	a1,a6,-8
    1a7c:	97aa                	add	a5,a5,a0
    1a7e:	95be                	add	a1,a1,a5
    1a80:	0007b023          	sd	zero,0(a5)
    1a84:	07a1                	addi	a5,a5,8
    1a86:	feb79de3          	bne	a5,a1,1a80 <stpncpy+0xbe>
    1a8a:	ff887593          	andi	a1,a6,-8
    1a8e:	9ead                	addw	a3,a3,a1
    1a90:	00b707b3          	add	a5,a4,a1
    1a94:	12b80863          	beq	a6,a1,1bc4 <stpncpy+0x202>
    1a98:	00078023          	sb	zero,0(a5)
    1a9c:	0016871b          	addiw	a4,a3,1
    1aa0:	0ec77863          	bgeu	a4,a2,1b90 <stpncpy+0x1ce>
    1aa4:	000780a3          	sb	zero,1(a5)
    1aa8:	0026871b          	addiw	a4,a3,2
    1aac:	0ec77263          	bgeu	a4,a2,1b90 <stpncpy+0x1ce>
    1ab0:	00078123          	sb	zero,2(a5)
    1ab4:	0036871b          	addiw	a4,a3,3
    1ab8:	0cc77c63          	bgeu	a4,a2,1b90 <stpncpy+0x1ce>
    1abc:	000781a3          	sb	zero,3(a5)
    1ac0:	0046871b          	addiw	a4,a3,4
    1ac4:	0cc77663          	bgeu	a4,a2,1b90 <stpncpy+0x1ce>
    1ac8:	00078223          	sb	zero,4(a5)
    1acc:	0056871b          	addiw	a4,a3,5
    1ad0:	0cc77063          	bgeu	a4,a2,1b90 <stpncpy+0x1ce>
    1ad4:	000782a3          	sb	zero,5(a5)
    1ad8:	0066871b          	addiw	a4,a3,6
    1adc:	0ac77a63          	bgeu	a4,a2,1b90 <stpncpy+0x1ce>
    1ae0:	00078323          	sb	zero,6(a5)
    1ae4:	0076871b          	addiw	a4,a3,7
    1ae8:	0ac77463          	bgeu	a4,a2,1b90 <stpncpy+0x1ce>
    1aec:	000783a3          	sb	zero,7(a5)
    1af0:	0086871b          	addiw	a4,a3,8
    1af4:	08c77e63          	bgeu	a4,a2,1b90 <stpncpy+0x1ce>
    1af8:	00078423          	sb	zero,8(a5)
    1afc:	0096871b          	addiw	a4,a3,9
    1b00:	08c77863          	bgeu	a4,a2,1b90 <stpncpy+0x1ce>
    1b04:	000784a3          	sb	zero,9(a5)
    1b08:	00a6871b          	addiw	a4,a3,10
    1b0c:	08c77263          	bgeu	a4,a2,1b90 <stpncpy+0x1ce>
    1b10:	00078523          	sb	zero,10(a5)
    1b14:	00b6871b          	addiw	a4,a3,11
    1b18:	06c77c63          	bgeu	a4,a2,1b90 <stpncpy+0x1ce>
    1b1c:	000785a3          	sb	zero,11(a5)
    1b20:	00c6871b          	addiw	a4,a3,12
    1b24:	06c77663          	bgeu	a4,a2,1b90 <stpncpy+0x1ce>
    1b28:	00078623          	sb	zero,12(a5)
    1b2c:	26b5                	addiw	a3,a3,13
    1b2e:	06c6f163          	bgeu	a3,a2,1b90 <stpncpy+0x1ce>
    1b32:	000786a3          	sb	zero,13(a5)
    1b36:	8082                	ret
            ;
        if (!n || !*s)
    1b38:	c645                	beqz	a2,1be0 <stpncpy+0x21e>
    1b3a:	0005c783          	lbu	a5,0(a1)
    1b3e:	ea078be3          	beqz	a5,19f4 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b42:	479d                	li	a5,7
    1b44:	02c7ff63          	bgeu	a5,a2,1b82 <stpncpy+0x1c0>
    1b48:	00000897          	auipc	a7,0x0
    1b4c:	4188b883          	ld	a7,1048(a7) # 1f60 <sharedmem+0xf6>
    1b50:	00000817          	auipc	a6,0x0
    1b54:	41883803          	ld	a6,1048(a6) # 1f68 <sharedmem+0xfe>
    1b58:	431d                	li	t1,7
    1b5a:	6198                	ld	a4,0(a1)
    1b5c:	011707b3          	add	a5,a4,a7
    1b60:	fff74693          	not	a3,a4
    1b64:	8ff5                	and	a5,a5,a3
    1b66:	0107f7b3          	and	a5,a5,a6
    1b6a:	ef81                	bnez	a5,1b82 <stpncpy+0x1c0>
            *wd = *ws;
    1b6c:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1b6e:	1661                	addi	a2,a2,-8
    1b70:	05a1                	addi	a1,a1,8
    1b72:	0521                	addi	a0,a0,8
    1b74:	fec363e3          	bltu	t1,a2,1b5a <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1b78:	e609                	bnez	a2,1b82 <stpncpy+0x1c0>
    1b7a:	a08d                	j	1bdc <stpncpy+0x21a>
    1b7c:	167d                	addi	a2,a2,-1
    1b7e:	0505                	addi	a0,a0,1
    1b80:	ca01                	beqz	a2,1b90 <stpncpy+0x1ce>
    1b82:	0005c783          	lbu	a5,0(a1)
    1b86:	0585                	addi	a1,a1,1
    1b88:	00f50023          	sb	a5,0(a0)
    1b8c:	fbe5                	bnez	a5,1b7c <stpncpy+0x1ba>
        ;
tail:
    1b8e:	b59d                	j	19f4 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1b90:	8082                	ret
    1b92:	472d                	li	a4,11
    1b94:	bdb5                	j	1a10 <stpncpy+0x4e>
    1b96:	00778713          	addi	a4,a5,7
    1b9a:	45ad                	li	a1,11
    1b9c:	fff60693          	addi	a3,a2,-1
    1ba0:	e6b778e3          	bgeu	a4,a1,1a10 <stpncpy+0x4e>
    1ba4:	b7fd                	j	1b92 <stpncpy+0x1d0>
    1ba6:	40a007b3          	neg	a5,a0
    1baa:	8832                	mv	a6,a2
    1bac:	8b9d                	andi	a5,a5,7
    1bae:	4681                	li	a3,0
    1bb0:	e4060be3          	beqz	a2,1a06 <stpncpy+0x44>
    1bb4:	b7cd                	j	1b96 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1bb6:	468d                	li	a3,3
    1bb8:	bd75                	j	1a74 <stpncpy+0xb2>
    1bba:	872a                	mv	a4,a0
    1bbc:	4681                	li	a3,0
    1bbe:	bd5d                	j	1a74 <stpncpy+0xb2>
    1bc0:	4685                	li	a3,1
    1bc2:	bd4d                	j	1a74 <stpncpy+0xb2>
    1bc4:	8082                	ret
    1bc6:	87aa                	mv	a5,a0
    1bc8:	4681                	li	a3,0
    1bca:	b5f9                	j	1a98 <stpncpy+0xd6>
    1bcc:	4689                	li	a3,2
    1bce:	b55d                	j	1a74 <stpncpy+0xb2>
    1bd0:	4691                	li	a3,4
    1bd2:	b54d                	j	1a74 <stpncpy+0xb2>
    1bd4:	4695                	li	a3,5
    1bd6:	bd79                	j	1a74 <stpncpy+0xb2>
    1bd8:	4699                	li	a3,6
    1bda:	bd69                	j	1a74 <stpncpy+0xb2>
    1bdc:	8082                	ret
    1bde:	8082                	ret
    1be0:	8082                	ret

0000000000001be2 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1be2:	fff6071b          	addiw	a4,a2,-1
    1be6:	0cb57063          	bgeu	a0,a1,1ca6 <memmove+0xc4>
        while (n-- > 0)
    1bea:	0ec05063          	blez	a2,1cca <memmove+0xe8>
    1bee:	00750693          	addi	a3,a0,7
    1bf2:	8e8d                	sub	a3,a3,a1
    1bf4:	00b567b3          	or	a5,a0,a1
    1bf8:	00f6b693          	sltiu	a3,a3,15
    1bfc:	8b9d                	andi	a5,a5,7
    1bfe:	0016c693          	xori	a3,a3,1
    1c02:	0017b793          	seqz	a5,a5
    1c06:	8ff5                	and	a5,a5,a3
    1c08:	c3f1                	beqz	a5,1ccc <memmove+0xea>
    1c0a:	0007079b          	sext.w	a5,a4
    1c0e:	46a5                	li	a3,9
    1c10:	0af6fe63          	bgeu	a3,a5,1ccc <memmove+0xea>
    1c14:	0036589b          	srliw	a7,a2,0x3
    1c18:	088e                	slli	a7,a7,0x3
    1c1a:	2601                	sext.w	a2,a2
    1c1c:	87ae                	mv	a5,a1
    1c1e:	86aa                	mv	a3,a0
    1c20:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1c22:	0007b803          	ld	a6,0(a5)
    1c26:	07a1                	addi	a5,a5,8
    1c28:	06a1                	addi	a3,a3,8
    1c2a:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1c2e:	ff179ae3          	bne	a5,a7,1c22 <memmove+0x40>
    1c32:	ff867813          	andi	a6,a2,-8
    1c36:	02081793          	slli	a5,a6,0x20
    1c3a:	9381                	srli	a5,a5,0x20
    1c3c:	00f506b3          	add	a3,a0,a5
    1c40:	95be                	add	a1,a1,a5
    1c42:	4107073b          	subw	a4,a4,a6
    1c46:	09060263          	beq	a2,a6,1cca <memmove+0xe8>
            *dst++ = *src++;
    1c4a:	0005c783          	lbu	a5,0(a1)
    1c4e:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1c52:	06e05c63          	blez	a4,1cca <memmove+0xe8>
            *dst++ = *src++;
    1c56:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1c5a:	4785                	li	a5,1
            *dst++ = *src++;
    1c5c:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1c60:	06e7d563          	bge	a5,a4,1cca <memmove+0xe8>
            *dst++ = *src++;
    1c64:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1c68:	4789                	li	a5,2
            *dst++ = *src++;
    1c6a:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1c6e:	04e7de63          	bge	a5,a4,1cca <memmove+0xe8>
            *dst++ = *src++;
    1c72:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1c76:	478d                	li	a5,3
            *dst++ = *src++;
    1c78:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1c7c:	04e7d763          	bge	a5,a4,1cca <memmove+0xe8>
            *dst++ = *src++;
    1c80:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1c84:	4791                	li	a5,4
            *dst++ = *src++;
    1c86:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1c8a:	04e7d063          	bge	a5,a4,1cca <memmove+0xe8>
            *dst++ = *src++;
    1c8e:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1c92:	4795                	li	a5,5
            *dst++ = *src++;
    1c94:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1c98:	02e7d963          	bge	a5,a4,1cca <memmove+0xe8>
            *dst++ = *src++;
    1c9c:	0065c783          	lbu	a5,6(a1)
    1ca0:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1ca4:	8082                	ret
    } else {
        dst += n;
    1ca6:	00c507b3          	add	a5,a0,a2
        src += n;
    1caa:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1cac:	00c05f63          	blez	a2,1cca <memmove+0xe8>
    1cb0:	1702                	slli	a4,a4,0x20
    1cb2:	9301                	srli	a4,a4,0x20
    1cb4:	fff74713          	not	a4,a4
    1cb8:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1cba:	fff5c683          	lbu	a3,-1(a1)
    1cbe:	17fd                	addi	a5,a5,-1
    1cc0:	15fd                	addi	a1,a1,-1
    1cc2:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1cc6:	fee79ae3          	bne	a5,a4,1cba <memmove+0xd8>
    }
    return vdst;
}
    1cca:	8082                	ret
    1ccc:	02071693          	slli	a3,a4,0x20
    1cd0:	9281                	srli	a3,a3,0x20
    1cd2:	0685                	addi	a3,a3,1
    1cd4:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1cd6:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1cd8:	0005c703          	lbu	a4,0(a1)
    1cdc:	0585                	addi	a1,a1,1
    1cde:	0785                	addi	a5,a5,1
    1ce0:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1ce4:	fed59ae3          	bne	a1,a3,1cd8 <memmove+0xf6>
    1ce8:	8082                	ret

0000000000001cea <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1cea:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cee:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1cf2:	2501                	sext.w	a0,a0
    1cf4:	8082                	ret

0000000000001cf6 <exec>:
    register long a7 __asm__("a7") = n;
    1cf6:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1cfa:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1cfc:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1d00:	2501                	sext.w	a0,a0
    1d02:	8082                	ret

0000000000001d04 <exit>:
    register long a7 __asm__("a7") = n;
    1d04:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1d08:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1d0c:	8082                	ret

0000000000001d0e <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1d0e:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d12:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1d16:	8082                	ret

0000000000001d18 <write>:
    register long a7 __asm__("a7") = n;
    1d18:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d1c:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1d20:	8082                	ret

0000000000001d22 <getpid>:
    register long a7 __asm__("a7") = n;
    1d22:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1d26:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1d2a:	2501                	sext.w	a0,a0
    1d2c:	8082                	ret

0000000000001d2e <getppid>:
    register long a7 __asm__("a7") = n;
    1d2e:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1d32:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1d36:	2501                	sext.w	a0,a0
    1d38:	8082                	ret

0000000000001d3a <open>:
    register long a7 __asm__("a7") = n;
    1d3a:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d3e:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1d42:	2501                	sext.w	a0,a0
    1d44:	8082                	ret

0000000000001d46 <mknod>:
    register long a7 __asm__("a7") = n;
    1d46:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1d4a:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1d4e:	2501                	sext.w	a0,a0
    1d50:	8082                	ret

0000000000001d52 <dup>:
    register long a7 __asm__("a7") = n;
    1d52:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1d54:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1d58:	2501                	sext.w	a0,a0
    1d5a:	8082                	ret

0000000000001d5c <sched_yield>:
    register long a7 __asm__("a7") = n;
    1d5c:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1d60:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1d64:	2501                	sext.w	a0,a0
    1d66:	8082                	ret

0000000000001d68 <waitpid>:
    register long a7 __asm__("a7") = n;
    1d68:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d6c:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1d70:	2501                	sext.w	a0,a0
    1d72:	8082                	ret

0000000000001d74 <wait>:

pid_t wait(int *wstatus)
{
    1d74:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1d76:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1d7a:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1d7c:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1d80:	2501                	sext.w	a0,a0
    1d82:	8082                	ret

0000000000001d84 <mkdir>:
    register long a7 __asm__("a7") = n;
    1d84:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1d88:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1d8c:	2501                	sext.w	a0,a0
    1d8e:	8082                	ret

0000000000001d90 <close>:
    register long a7 __asm__("a7") = n;
    1d90:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1d94:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1d98:	2501                	sext.w	a0,a0
    1d9a:	8082                	ret

0000000000001d9c <fork>:
    register long a7 __asm__("a7") = n;
    1d9c:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1da0:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1da4:	2501                	sext.w	a0,a0
    1da6:	8082                	ret

0000000000001da8 <time_ms>:
    register long a7 __asm__("a7") = n;
    1da8:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1dac:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1db0:	8082                	ret

0000000000001db2 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1db2:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1db4:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1db8:	00000073          	ecall
    1dbc:	87aa                	mv	a5,a0
    1dbe:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1dc2:	97ba                	add	a5,a5,a4
    1dc4:	00f57c63          	bgeu	a0,a5,1ddc <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1dc8:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1dcc:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1dd0:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1dd4:	00000073          	ecall
    1dd8:	fef568e3          	bltu	a0,a5,1dc8 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1ddc:	4501                	li	a0,0
    1dde:	8082                	ret

0000000000001de0 <pipe>:
    register long a7 __asm__("a7") = n;
    1de0:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1de4:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1de8:	2501                	sext.w	a0,a0
    1dea:	8082                	ret

0000000000001dec <fstat>:
    register long a7 __asm__("a7") = n;
    1dec:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1df0:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1df4:	2501                	sext.w	a0,a0
    1df6:	8082                	ret

0000000000001df8 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1df8:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1dfa:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1dfe:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e00:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1e04:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1e08:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1e0c:	0206c163          	bltz	a3,1e2e <stat+0x36>
    register long a7 __asm__("a7") = n;
    1e10:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1e14:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1e16:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e18:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1e1c:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1e20:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1e24:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1e26:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1e2a:	853e                	mv	a0,a5
    1e2c:	8082                	ret
        return -1;
    1e2e:	57fd                	li	a5,-1
    1e30:	bfed                	j	1e2a <stat+0x32>

0000000000001e32 <chdir>:
    register long a7 __asm__("a7") = n;
    1e32:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1e36:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1e3a:	2501                	sext.w	a0,a0
    1e3c:	8082                	ret

0000000000001e3e <link>:
    register long a7 __asm__("a7") = n;
    1e3e:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e42:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1e46:	2501                	sext.w	a0,a0
    1e48:	8082                	ret

0000000000001e4a <unlink>:
    register long a7 __asm__("a7") = n;
    1e4a:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1e4e:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1e52:	2501                	sext.w	a0,a0
    1e54:	8082                	ret

0000000000001e56 <setpriority>:
    register long a7 __asm__("a7") = n;
    1e56:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1e5a:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1e5e:	8082                	ret

0000000000001e60 <getpriority>:
    register long a7 __asm__("a7") = n;
    1e60:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1e64:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1e68:	8082                	ret

0000000000001e6a <sharedmem>:
    register long a7 __asm__("a7") = n;
    1e6a:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e6e:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1e72:	8082                	ret
