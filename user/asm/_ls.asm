
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_ls:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	acf9                	j	12de <__start_main>

Disassembly of section .text:

0000000000001002 <fmtname>:
#include <string.h>
#include <ucore.h>
#include <ucore.h>
char *
fmtname(char *path)
{
    1002:	1101                	addi	sp,sp,-32
    1004:	e822                	sd	s0,16(sp)
    1006:	e426                	sd	s1,8(sp)
    1008:	ec06                	sd	ra,24(sp)
    100a:	84aa                	mv	s1,a0
  static char buf[DIRSIZ + 1];
  char *p;

  // Find first character after last slash.
  for (p = path + strlen(path); p >= path && *p != '/'; p--)
    100c:	199000ef          	jal	ra,19a4 <strlen>
    1010:	00a48433          	add	s0,s1,a0
    1014:	02f00693          	li	a3,47
    1018:	00947663          	bgeu	s0,s1,1024 <fmtname+0x22>
    101c:	a811                	j	1030 <fmtname+0x2e>
    101e:	0097ea63          	bltu	a5,s1,1032 <fmtname+0x30>
    1022:	843e                	mv	s0,a5
    1024:	00044703          	lbu	a4,0(s0)
    1028:	fff40793          	addi	a5,s0,-1
    102c:	fed719e3          	bne	a4,a3,101e <fmtname+0x1c>
    1030:	0405                	addi	s0,s0,1
    ;
  p++;

  // Return blank-padded name.
  if (strlen(p) >= DIRSIZ)
    1032:	8522                	mv	a0,s0
    1034:	171000ef          	jal	ra,19a4 <strlen>
    1038:	47b5                	li	a5,13
    103a:	04a7e063          	bltu	a5,a0,107a <fmtname+0x78>
    return p;
  memmove(buf, p, strlen(p));
    103e:	8522                	mv	a0,s0
    1040:	165000ef          	jal	ra,19a4 <strlen>
    1044:	00001497          	auipc	s1,0x1
    1048:	06c48493          	addi	s1,s1,108 # 20b0 <buf.1153>
    104c:	85a2                	mv	a1,s0
    104e:	0005061b          	sext.w	a2,a0
    1052:	8526                	mv	a0,s1
    1054:	4f7000ef          	jal	ra,1d4a <memmove>
  memset(buf + strlen(p), ' ', DIRSIZ - strlen(p));
    1058:	8522                	mv	a0,s0
    105a:	14b000ef          	jal	ra,19a4 <strlen>
    105e:	87aa                	mv	a5,a0
    1060:	8522                	mv	a0,s0
    1062:	843e                	mv	s0,a5
    1064:	141000ef          	jal	ra,19a4 <strlen>
    1068:	4639                	li	a2,14
    106a:	8e09                	sub	a2,a2,a0
    106c:	02000593          	li	a1,32
    1070:	00848533          	add	a0,s1,s0
    1074:	718000ef          	jal	ra,178c <memset>
  return buf;
    1078:	8426                	mv	s0,s1
}
    107a:	60e2                	ld	ra,24(sp)
    107c:	8522                	mv	a0,s0
    107e:	6442                	ld	s0,16(sp)
    1080:	64a2                	ld	s1,8(sp)
    1082:	6105                	addi	sp,sp,32
    1084:	8082                	ret

0000000000001086 <ls>:

void ls(char *path)
{
    1086:	d7010113          	addi	sp,sp,-656
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if ((fd = open(path, 0)) < 0)
    108a:	4581                	li	a1,0
{
    108c:	26913c23          	sd	s1,632(sp)
    1090:	28113423          	sd	ra,648(sp)
    1094:	28813023          	sd	s0,640(sp)
    1098:	27213823          	sd	s2,624(sp)
    109c:	27313423          	sd	s3,616(sp)
    10a0:	27413023          	sd	s4,608(sp)
    10a4:	25513c23          	sd	s5,600(sp)
    10a8:	25613823          	sd	s6,592(sp)
    10ac:	25713423          	sd	s7,584(sp)
    10b0:	25813023          	sd	s8,576(sp)
    10b4:	23913c23          	sd	s9,568(sp)
    10b8:	84aa                	mv	s1,a0
  if ((fd = open(path, 0)) < 0)
    10ba:	5e9000ef          	jal	ra,1ea2 <open>
    10be:	02054d63          	bltz	a0,10f8 <ls+0x72>
  {
    printf("ls: cannot open %s\n", path);
    return;
  }

  if (fstat(fd, &st) < 0)
    10c2:	082c                	addi	a1,sp,24
    10c4:	842a                	mv	s0,a0
    10c6:	68f000ef          	jal	ra,1f54 <fstat>
    10ca:	0c054063          	bltz	a0,118a <ls+0x104>
    printf("ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch (st.type)
    10ce:	02011783          	lh	a5,32(sp)
    10d2:	4709                	li	a4,2
    10d4:	08e78e63          	beq	a5,a4,1170 <ls+0xea>
    10d8:	470d                	li	a4,3
    10da:	06e78e63          	beq	a5,a4,1156 <ls+0xd0>
    10de:	4705                	li	a4,1
    10e0:	04e78c63          	beq	a5,a4,1138 <ls+0xb2>
      }
      printf("%d %l\n", st.ino, st.size);
    }
    break;
  default:
    printf("unknown type\n");
    10e4:	00001517          	auipc	a0,0x1
    10e8:	f9450513          	addi	a0,a0,-108 # 2078 <sharedmem+0xa6>
    10ec:	288000ef          	jal	ra,1374 <printf>

  }
  close(fd);
    10f0:	8522                	mv	a0,s0
    10f2:	607000ef          	jal	ra,1ef8 <close>
    10f6:	a801                	j	1106 <ls+0x80>
    printf("ls: cannot open %s\n", path);
    10f8:	85a6                	mv	a1,s1
    10fa:	00001517          	auipc	a0,0x1
    10fe:	ee650513          	addi	a0,a0,-282 # 1fe0 <sharedmem+0xe>
    1102:	272000ef          	jal	ra,1374 <printf>
}
    1106:	28813083          	ld	ra,648(sp)
    110a:	28013403          	ld	s0,640(sp)
    110e:	27813483          	ld	s1,632(sp)
    1112:	27013903          	ld	s2,624(sp)
    1116:	26813983          	ld	s3,616(sp)
    111a:	26013a03          	ld	s4,608(sp)
    111e:	25813a83          	ld	s5,600(sp)
    1122:	25013b03          	ld	s6,592(sp)
    1126:	24813b83          	ld	s7,584(sp)
    112a:	24013c03          	ld	s8,576(sp)
    112e:	23813c83          	ld	s9,568(sp)
    1132:	29010113          	addi	sp,sp,656
    1136:	8082                	ret
    if (strlen(path) + 1 + DIRSIZ + 1 > sizeof buf)
    1138:	8526                	mv	a0,s1
    113a:	06b000ef          	jal	ra,19a4 <strlen>
    113e:	0541                	addi	a0,a0,16
    1140:	20000793          	li	a5,512
    1144:	04a7fe63          	bgeu	a5,a0,11a0 <ls+0x11a>
      printf("ls: path too long\n");
    1148:	00001517          	auipc	a0,0x1
    114c:	ee850513          	addi	a0,a0,-280 # 2030 <sharedmem+0x5e>
    1150:	224000ef          	jal	ra,1374 <printf>
      break;
    1154:	bf71                	j	10f0 <ls+0x6a>
    printf("%s DEV %d %l\n", fmtname(path), st.ino, st.size);
    1156:	8526                	mv	a0,s1
    1158:	eabff0ef          	jal	ra,1002 <fmtname>
    115c:	76a2                	ld	a3,40(sp)
    115e:	4672                	lw	a2,28(sp)
    1160:	85aa                	mv	a1,a0
    1162:	00001517          	auipc	a0,0x1
    1166:	ebe50513          	addi	a0,a0,-322 # 2020 <sharedmem+0x4e>
    116a:	20a000ef          	jal	ra,1374 <printf>
    break;
    116e:	b749                	j	10f0 <ls+0x6a>
    printf("%s FIL %d %l\n", fmtname(path), st.ino, st.size);
    1170:	8526                	mv	a0,s1
    1172:	e91ff0ef          	jal	ra,1002 <fmtname>
    1176:	76a2                	ld	a3,40(sp)
    1178:	4672                	lw	a2,28(sp)
    117a:	85aa                	mv	a1,a0
    117c:	00001517          	auipc	a0,0x1
    1180:	e9450513          	addi	a0,a0,-364 # 2010 <sharedmem+0x3e>
    1184:	1f0000ef          	jal	ra,1374 <printf>
    break;
    1188:	b7a5                	j	10f0 <ls+0x6a>
    printf("ls: cannot stat %s\n", path);
    118a:	85a6                	mv	a1,s1
    118c:	00001517          	auipc	a0,0x1
    1190:	e6c50513          	addi	a0,a0,-404 # 1ff8 <sharedmem+0x26>
    1194:	1e0000ef          	jal	ra,1374 <printf>
    close(fd);
    1198:	8522                	mv	a0,s0
    119a:	55f000ef          	jal	ra,1ef8 <close>
    return;
    119e:	b7a5                	j	1106 <ls+0x80>
    strcpy(buf, path);
    11a0:	85a6                	mv	a1,s1
    11a2:	1808                	addi	a0,sp,48
    11a4:	7ac000ef          	jal	ra,1950 <strcpy>
    p = buf + strlen(buf);
    11a8:	1808                	addi	a0,sp,48
    11aa:	7fa000ef          	jal	ra,19a4 <strlen>
    11ae:	181c                	addi	a5,sp,48
    11b0:	00a784b3          	add	s1,a5,a0
    *p++ = '/';
    11b4:	02f00793          	li	a5,47
    11b8:	00148913          	addi	s2,s1,1
    11bc:	00f48023          	sb	a5,0(s1)
      printf("%s ", fmtname(buf));
    11c0:	00001a97          	auipc	s5,0x1
    11c4:	e88a8a93          	addi	s5,s5,-376 # 2048 <sharedmem+0x76>
      if (st.type == T_DIR)
    11c8:	4a05                	li	s4,1
      printf("%d %l\n", st.ino, st.size);
    11ca:	00001997          	auipc	s3,0x1
    11ce:	ea698993          	addi	s3,s3,-346 # 2070 <sharedmem+0x9e>
      else if (st.type == T_FILE)
    11d2:	4b09                	li	s6,2
      else if (st.type == T_DEVICE)
    11d4:	4b8d                	li	s7,3
        printf("UNK ");
    11d6:	00001c17          	auipc	s8,0x1
    11da:	e92c0c13          	addi	s8,s8,-366 # 2068 <sharedmem+0x96>
        printf("DEV ");
    11de:	00001c97          	auipc	s9,0x1
    11e2:	e82c8c93          	addi	s9,s9,-382 # 2060 <sharedmem+0x8e>
    while (read(fd, &de, sizeof(de)) == sizeof(de))
    11e6:	4641                	li	a2,16
    11e8:	002c                	addi	a1,sp,8
    11ea:	8522                	mv	a0,s0
    11ec:	48b000ef          	jal	ra,1e76 <read>
    11f0:	47c1                	li	a5,16
    11f2:	eef51fe3          	bne	a0,a5,10f0 <ls+0x6a>
      if (de.inum == 0)
    11f6:	00815783          	lhu	a5,8(sp)
    11fa:	d7f5                	beqz	a5,11e6 <ls+0x160>
      memmove(p, de.name, DIRSIZ);
    11fc:	00a10593          	addi	a1,sp,10
    1200:	4639                	li	a2,14
    1202:	854a                	mv	a0,s2
    1204:	347000ef          	jal	ra,1d4a <memmove>
      if (stat(buf, &st) < 0)
    1208:	082c                	addi	a1,sp,24
    120a:	1808                	addi	a0,sp,48
      p[DIRSIZ] = 0;
    120c:	000487a3          	sb	zero,15(s1)
      if (stat(buf, &st) < 0)
    1210:	551000ef          	jal	ra,1f60 <stat>
    1214:	04054263          	bltz	a0,1258 <ls+0x1d2>
      printf("%s ", fmtname(buf));
    1218:	1808                	addi	a0,sp,48
    121a:	de9ff0ef          	jal	ra,1002 <fmtname>
    121e:	85aa                	mv	a1,a0
    1220:	8556                	mv	a0,s5
    1222:	152000ef          	jal	ra,1374 <printf>
      if (st.type == T_DIR)
    1226:	02011783          	lh	a5,32(sp)
    122a:	05478363          	beq	a5,s4,1270 <ls+0x1ea>
      else if (st.type == T_FILE)
    122e:	05678863          	beq	a5,s6,127e <ls+0x1f8>
      else if (st.type == T_DEVICE)
    1232:	03778b63          	beq	a5,s7,1268 <ls+0x1e2>
        printf("UNK ");
    1236:	8562                	mv	a0,s8
    1238:	13c000ef          	jal	ra,1374 <printf>
      printf("%d %l\n", st.ino, st.size);
    123c:	7622                	ld	a2,40(sp)
    123e:	45f2                	lw	a1,28(sp)
    1240:	854e                	mv	a0,s3
    1242:	132000ef          	jal	ra,1374 <printf>
    while (read(fd, &de, sizeof(de)) == sizeof(de))
    1246:	4641                	li	a2,16
    1248:	002c                	addi	a1,sp,8
    124a:	8522                	mv	a0,s0
    124c:	42b000ef          	jal	ra,1e76 <read>
    1250:	47c1                	li	a5,16
    1252:	faf502e3          	beq	a0,a5,11f6 <ls+0x170>
    1256:	bd69                	j	10f0 <ls+0x6a>
        printf("ls: cannot stat %s\n", buf);
    1258:	180c                	addi	a1,sp,48
    125a:	00001517          	auipc	a0,0x1
    125e:	d9e50513          	addi	a0,a0,-610 # 1ff8 <sharedmem+0x26>
    1262:	112000ef          	jal	ra,1374 <printf>
        continue;
    1266:	b741                	j	11e6 <ls+0x160>
        printf("DEV ");
    1268:	8566                	mv	a0,s9
    126a:	10a000ef          	jal	ra,1374 <printf>
    126e:	b7f9                	j	123c <ls+0x1b6>
        printf("DIR ");
    1270:	00001517          	auipc	a0,0x1
    1274:	de050513          	addi	a0,a0,-544 # 2050 <sharedmem+0x7e>
    1278:	0fc000ef          	jal	ra,1374 <printf>
    127c:	b7c1                	j	123c <ls+0x1b6>
        printf("FIL ");
    127e:	00001517          	auipc	a0,0x1
    1282:	dda50513          	addi	a0,a0,-550 # 2058 <sharedmem+0x86>
    1286:	0ee000ef          	jal	ra,1374 <printf>
    128a:	bf4d                	j	123c <ls+0x1b6>

000000000000128c <main>:

int main(int argc, char *argv[])
{
    128c:	1101                	addi	sp,sp,-32
    128e:	ec06                	sd	ra,24(sp)
    1290:	e822                	sd	s0,16(sp)
    1292:	e426                	sd	s1,8(sp)
  int i;

  if (argc < 2)
    1294:	4785                	li	a5,1
    1296:	02a7da63          	bge	a5,a0,12ca <main+0x3e>
    129a:	ffe5049b          	addiw	s1,a0,-2
    129e:	1482                	slli	s1,s1,0x20
    12a0:	80f5                	srli	s1,s1,0x1d
    12a2:	01058793          	addi	a5,a1,16
    12a6:	00858413          	addi	s0,a1,8
    12aa:	94be                	add	s1,s1,a5
  {
    ls(".");
    exit(0);
  }
  for (i = 1; i < argc; i++)
    ls(argv[i]);
    12ac:	6008                	ld	a0,0(s0)
    12ae:	0421                	addi	s0,s0,8
    12b0:	dd7ff0ef          	jal	ra,1086 <ls>
  for (i = 1; i < argc; i++)
    12b4:	fe941ce3          	bne	s0,s1,12ac <main+0x20>
  exit(0);
    12b8:	4501                	li	a0,0
    12ba:	3b3000ef          	jal	ra,1e6c <exit>
}
    12be:	60e2                	ld	ra,24(sp)
    12c0:	6442                	ld	s0,16(sp)
    12c2:	64a2                	ld	s1,8(sp)
    12c4:	4501                	li	a0,0
    12c6:	6105                	addi	sp,sp,32
    12c8:	8082                	ret
    ls(".");
    12ca:	00001517          	auipc	a0,0x1
    12ce:	dbe50513          	addi	a0,a0,-578 # 2088 <sharedmem+0xb6>
    12d2:	db5ff0ef          	jal	ra,1086 <ls>
    exit(0);
    12d6:	4501                	li	a0,0
    12d8:	395000ef          	jal	ra,1e6c <exit>
  for (i = 1; i < argc; i++)
    12dc:	bff1                	j	12b8 <main+0x2c>

00000000000012de <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    12de:	1141                	addi	sp,sp,-16
    12e0:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    12e2:	fabff0ef          	jal	ra,128c <main>
}
    12e6:	60a2                	ld	ra,8(sp)
    12e8:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    12ea:	3830006f          	j	1e6c <exit>

00000000000012ee <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    12ee:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    12f0:	00f10593          	addi	a1,sp,15
    12f4:	4605                	li	a2,1
    12f6:	4501                	li	a0,0
int getchar() {
    12f8:	ec06                	sd	ra,24(sp)
    char byte = 0;
    12fa:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    12fe:	379000ef          	jal	ra,1e76 <read>
    return byte;
}
    1302:	60e2                	ld	ra,24(sp)
    1304:	00f14503          	lbu	a0,15(sp)
    1308:	6105                	addi	sp,sp,32
    130a:	8082                	ret

000000000000130c <putchar>:

int putchar(int c)
{
    130c:	1141                	addi	sp,sp,-16
    130e:	e406                	sd	ra,8(sp)
    1310:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    1312:	00001597          	auipc	a1,0x1
    1316:	dae58593          	addi	a1,a1,-594 # 20c0 <put.1156>
    return write(stdout, put, 1);
    131a:	4605                	li	a2,1
    131c:	4505                	li	a0,1
    put[0] = c;
    131e:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1322:	35f000ef          	jal	ra,1e80 <write>
}
    1326:	60a2                	ld	ra,8(sp)
    1328:	2501                	sext.w	a0,a0
    132a:	0141                	addi	sp,sp,16
    132c:	8082                	ret

000000000000132e <puts>:

int puts(const char* s)
{
    132e:	1141                	addi	sp,sp,-16
    1330:	e022                	sd	s0,0(sp)
    1332:	e406                	sd	ra,8(sp)
    1334:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    1336:	66e000ef          	jal	ra,19a4 <strlen>
    133a:	862a                	mv	a2,a0
    133c:	85a2                	mv	a1,s0
    133e:	4505                	li	a0,1
    1340:	341000ef          	jal	ra,1e80 <write>
    1344:	00055763          	bgez	a0,1352 <puts+0x24>
    return r;
}
    1348:	60a2                	ld	ra,8(sp)
    134a:	6402                	ld	s0,0(sp)
    134c:	557d                	li	a0,-1
    134e:	0141                	addi	sp,sp,16
    1350:	8082                	ret
    put[0] = c;
    1352:	00001597          	auipc	a1,0x1
    1356:	d6e58593          	addi	a1,a1,-658 # 20c0 <put.1156>
    135a:	47a9                	li	a5,10
    return write(stdout, put, 1);
    135c:	4605                	li	a2,1
    135e:	4505                	li	a0,1
    put[0] = c;
    1360:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1364:	31d000ef          	jal	ra,1e80 <write>
}
    1368:	60a2                	ld	ra,8(sp)
    136a:	6402                	ld	s0,0(sp)
    136c:	41f5551b          	sraiw	a0,a0,0x1f
    1370:	0141                	addi	sp,sp,16
    1372:	8082                	ret

0000000000001374 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    1374:	7115                	addi	sp,sp,-224
    1376:	ed06                	sd	ra,152(sp)
    1378:	e922                	sd	s0,144(sp)
    137a:	e526                	sd	s1,136(sp)
    137c:	e14a                	sd	s2,128(sp)
    137e:	fcce                	sd	s3,120(sp)
    1380:	f8d2                	sd	s4,112(sp)
    1382:	f4d6                	sd	s5,104(sp)
    1384:	f0da                	sd	s6,96(sp)
    1386:	ecde                	sd	s7,88(sp)
    1388:	e8e2                	sd	s8,80(sp)
    138a:	e4e6                	sd	s9,72(sp)
    138c:	e0ea                	sd	s10,64(sp)
    138e:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1390:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    1394:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    1396:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    1398:	f52e                	sd	a1,168(sp)
    139a:	f932                	sd	a2,176(sp)
    139c:	fd36                	sd	a3,184(sp)
    139e:	e1ba                	sd	a4,192(sp)
    13a0:	e9c2                	sd	a6,208(sp)
    13a2:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    13a4:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    13a6:	0c030b63          	beqz	t1,147c <printf+0x108>
    13aa:	8aaa                	mv	s5,a0
    13ac:	0003071b          	sext.w	a4,t1
    13b0:	4481                	li	s1,0
        if (c != '%') {
    13b2:	02500b93          	li	s7,37
    put[0] = c;
    13b6:	00001417          	auipc	s0,0x1
    13ba:	d0a40413          	addi	s0,s0,-758 # 20c0 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    13be:	4c51                	li	s8,20
    put[0] = c;
    13c0:	02500c93          	li	s9,37
    13c4:	00001a17          	auipc	s4,0x1
    13c8:	d04a0a13          	addi	s4,s4,-764 # 20c8 <put.1156+0x8>
    13cc:	00001997          	auipc	s3,0x1
    13d0:	d5498993          	addi	s3,s3,-684 # 2120 <digits>
    13d4:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    13d8:	0014879b          	addiw	a5,s1,1
    13dc:	00fa8933          	add	s2,s5,a5
    13e0:	13771163          	bne	a4,s7,1502 <printf+0x18e>
        c = fmt[++i] & 0xff;
    13e4:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    13e8:	080d0a63          	beqz	s10,147c <printf+0x108>
        switch (c) {
    13ec:	2489                	addiw	s1,s1,2
    13ee:	009a8933          	add	s2,s5,s1
    13f2:	257d0e63          	beq	s10,s7,164e <printf+0x2da>
    13f6:	f9cd079b          	addiw	a5,s10,-100
    13fa:	0ff7f793          	andi	a5,a5,255
    13fe:	0cfc6263          	bltu	s8,a5,14c2 <printf+0x14e>
    1402:	078a                	slli	a5,a5,0x2
    1404:	97d2                	add	a5,a5,s4
    1406:	439c                	lw	a5,0(a5)
    1408:	97d2                	add	a5,a5,s4
    140a:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    140c:	67a2                	ld	a5,8(sp)
    140e:	4398                	lw	a4,0(a5)
    1410:	07a1                	addi	a5,a5,8
    1412:	e43e                	sd	a5,8(sp)
    1414:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    1418:	26074663          	bltz	a4,1684 <printf+0x310>
        buf[i++] = digits[x % base];
    141c:	8bbd                	andi	a5,a5,15
    141e:	97ce                	add	a5,a5,s3
    1420:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    1424:	40475d1b          	sraiw	s10,a4,0x4
    1428:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    142c:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    1430:	020d0163          	beqz	s10,1452 <printf+0xde>
        buf[i++] = digits[x % base];
    1434:	9d4e                	add	s10,s10,s3
    1436:	000d4783          	lbu	a5,0(s10)
    143a:	4d05                	li	s10,1
    143c:	00f108a3          	sb	a5,17(sp)
    if (sign)
    1440:	00075963          	bgez	a4,1452 <printf+0xde>
        buf[i++] = digits[x % base];
    1444:	4d09                	li	s10,2
        buf[i++] = '-';
    1446:	181c                	addi	a5,sp,48
    1448:	02d00713          	li	a4,45
    144c:	97ea                	add	a5,a5,s10
    144e:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    1452:	9d5a                	add	s10,s10,s6
    1454:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1458:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    145c:	4605                	li	a2,1
    145e:	1d7d                	addi	s10,s10,-1
    1460:	85a2                	mv	a1,s0
    1462:	4505                	li	a0,1
    put[0] = c;
    1464:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1468:	219000ef          	jal	ra,1e80 <write>
    while (--i >= 0)
    146c:	ffbd16e3          	bne	s10,s11,1458 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1470:	00094303          	lbu	t1,0(s2)
    1474:	0003071b          	sext.w	a4,t1
    1478:	f60310e3          	bnez	t1,13d8 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    147c:	60ea                	ld	ra,152(sp)
    147e:	644a                	ld	s0,144(sp)
    1480:	64aa                	ld	s1,136(sp)
    1482:	690a                	ld	s2,128(sp)
    1484:	79e6                	ld	s3,120(sp)
    1486:	7a46                	ld	s4,112(sp)
    1488:	7aa6                	ld	s5,104(sp)
    148a:	7b06                	ld	s6,96(sp)
    148c:	6be6                	ld	s7,88(sp)
    148e:	6c46                	ld	s8,80(sp)
    1490:	6ca6                	ld	s9,72(sp)
    1492:	6d06                	ld	s10,64(sp)
    1494:	7de2                	ld	s11,56(sp)
    1496:	612d                	addi	sp,sp,224
    1498:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    149a:	67a2                	ld	a5,8(sp)
    149c:	0007bd03          	ld	s10,0(a5)
    14a0:	07a1                	addi	a5,a5,8
    14a2:	e43e                	sd	a5,8(sp)
    14a4:	000d1b63          	bnez	s10,14ba <printf+0x146>
    14a8:	aafd                	j	16a6 <printf+0x332>
    return write(stdout, put, 1);
    14aa:	4605                	li	a2,1
    14ac:	85a2                	mv	a1,s0
    14ae:	4505                	li	a0,1
                for (; *s; s++)
    14b0:	0d05                	addi	s10,s10,1
    put[0] = c;
    14b2:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    14b6:	1cb000ef          	jal	ra,1e80 <write>
                for (; *s; s++)
    14ba:	000d4783          	lbu	a5,0(s10)
    14be:	f7f5                	bnez	a5,14aa <printf+0x136>
    14c0:	a02d                	j	14ea <printf+0x176>
    return write(stdout, put, 1);
    14c2:	4605                	li	a2,1
    14c4:	00001597          	auipc	a1,0x1
    14c8:	bfc58593          	addi	a1,a1,-1028 # 20c0 <put.1156>
    14cc:	4505                	li	a0,1
    put[0] = c;
    14ce:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    14d2:	1af000ef          	jal	ra,1e80 <write>
    14d6:	4605                	li	a2,1
    14d8:	00001597          	auipc	a1,0x1
    14dc:	be858593          	addi	a1,a1,-1048 # 20c0 <put.1156>
    14e0:	4505                	li	a0,1
    put[0] = c;
    14e2:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    14e6:	19b000ef          	jal	ra,1e80 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    14ea:	00094303          	lbu	t1,0(s2)
    14ee:	0003071b          	sext.w	a4,t1
    14f2:	f80305e3          	beqz	t1,147c <printf+0x108>
        if (c != '%') {
    14f6:	0014879b          	addiw	a5,s1,1
    14fa:	00fa8933          	add	s2,s5,a5
    14fe:	ef7703e3          	beq	a4,s7,13e4 <printf+0x70>
    return write(stdout, put, 1);
    1502:	4605                	li	a2,1
    1504:	00001597          	auipc	a1,0x1
    1508:	bbc58593          	addi	a1,a1,-1092 # 20c0 <put.1156>
    150c:	4505                	li	a0,1
    put[0] = c;
    150e:	00640023          	sb	t1,0(s0)
            continue;
    1512:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    1514:	16d000ef          	jal	ra,1e80 <write>
            continue;
    1518:	bfc9                	j	14ea <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    151a:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    151c:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    151e:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    1520:	0007b883          	ld	a7,0(a5)
    1524:	07a1                	addi	a5,a5,8
    1526:	e43e                	sd	a5,8(sp)
        x = -xx;
    1528:	43f8d713          	srai	a4,a7,0x3f
    152c:	011747b3          	xor	a5,a4,a7
    1530:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    1532:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    1534:	02c7f733          	remu	a4,a5,a2
    1538:	8d36                	mv	s10,a3
    153a:	0685                	addi	a3,a3,1
    153c:	00db0533          	add	a0,s6,a3
    1540:	85be                	mv	a1,a5
    1542:	974e                	add	a4,a4,s3
    1544:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    1548:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    154c:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    1550:	feb862e3          	bltu	a6,a1,1534 <printf+0x1c0>
    if (sign)
    1554:	1208c063          	bltz	a7,1674 <printf+0x300>
    while (--i >= 0)
    1558:	9d5a                	add	s10,s10,s6
    put[0] = c;
    155a:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    155e:	4605                	li	a2,1
    1560:	85a2                	mv	a1,s0
    1562:	4505                	li	a0,1
    put[0] = c;
    1564:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1568:	119000ef          	jal	ra,1e80 <write>
    while (--i >= 0)
    156c:	87ea                	mv	a5,s10
    156e:	1d7d                	addi	s10,s10,-1
    1570:	fefb15e3          	bne	s6,a5,155a <printf+0x1e6>
    1574:	bf9d                	j	14ea <printf+0x176>
                printptr(va_arg(ap, uint64));
    1576:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    1578:	4605                	li	a2,1
    157a:	00001597          	auipc	a1,0x1
    157e:	b4658593          	addi	a1,a1,-1210 # 20c0 <put.1156>
                printptr(va_arg(ap, uint64));
    1582:	0007bd83          	ld	s11,0(a5)
    1586:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    158a:	4505                	li	a0,1
    put[0] = c;
    158c:	03000793          	li	a5,48
    1590:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    1594:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    1596:	0eb000ef          	jal	ra,1e80 <write>
    put[0] = c;
    159a:	07800793          	li	a5,120
    return write(stdout, put, 1);
    159e:	4605                	li	a2,1
    15a0:	00001597          	auipc	a1,0x1
    15a4:	b2058593          	addi	a1,a1,-1248 # 20c0 <put.1156>
    15a8:	4505                	li	a0,1
    put[0] = c;
    15aa:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    15ae:	4d41                	li	s10,16
    15b0:	0d1000ef          	jal	ra,1e80 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    15b4:	03cdd793          	srli	a5,s11,0x3c
    15b8:	97ce                	add	a5,a5,s3
    put[0] = c;
    15ba:	0007c783          	lbu	a5,0(a5)
    15be:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    15c0:	4605                	li	a2,1
    15c2:	85a2                	mv	a1,s0
    15c4:	4505                	li	a0,1
    put[0] = c;
    15c6:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    15ca:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    15cc:	0b5000ef          	jal	ra,1e80 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    15d0:	fe0d12e3          	bnez	s10,15b4 <printf+0x240>
    15d4:	bf19                	j	14ea <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    15d6:	67a2                	ld	a5,8(sp)
    15d8:	4394                	lw	a3,0(a5)
    15da:	07a1                	addi	a5,a5,8
    15dc:	e43e                	sd	a5,8(sp)
    15de:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    15e2:	0006d663          	bgez	a3,15ee <printf+0x27a>
        x = -xx;
    15e6:	40f007bb          	negw	a5,a5
    15ea:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    15ee:	4729                	li	a4,10
    15f0:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    15f4:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    15f8:	964e                	add	a2,a2,s3
    15fa:	00064603          	lbu	a2,0(a2)
    15fe:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    1602:	0a0d0963          	beqz	s10,16b4 <printf+0x340>
        buf[i++] = digits[x % base];
    1606:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    160a:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    160e:	00c98733          	add	a4,s3,a2
    1612:	00074703          	lbu	a4,0(a4)
    1616:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    161a:	c3cd                	beqz	a5,16bc <printf+0x348>
        buf[i++] = digits[x % base];
    161c:	97ce                	add	a5,a5,s3
    161e:	0007c703          	lbu	a4,0(a5)
    1622:	4d09                	li	s10,2
    1624:	478d                	li	a5,3
    1626:	00e10923          	sb	a4,18(sp)
    if (sign)
    162a:	0206cd63          	bltz	a3,1664 <printf+0x2f0>
    while (--i >= 0)
    162e:	9d5a                	add	s10,s10,s6
    1630:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1634:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1638:	4605                	li	a2,1
    163a:	1d7d                	addi	s10,s10,-1
    163c:	85a2                	mv	a1,s0
    163e:	4505                	li	a0,1
    put[0] = c;
    1640:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1644:	03d000ef          	jal	ra,1e80 <write>
    while (--i >= 0)
    1648:	ffbd16e3          	bne	s10,s11,1634 <printf+0x2c0>
    164c:	bd79                	j	14ea <printf+0x176>
    return write(stdout, put, 1);
    164e:	4605                	li	a2,1
    1650:	00001597          	auipc	a1,0x1
    1654:	a7058593          	addi	a1,a1,-1424 # 20c0 <put.1156>
    1658:	4505                	li	a0,1
    put[0] = c;
    165a:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    165e:	023000ef          	jal	ra,1e80 <write>
    1662:	b561                	j	14ea <printf+0x176>
        buf[i++] = '-';
    1664:	1818                	addi	a4,sp,48
    1666:	973e                	add	a4,a4,a5
    1668:	02d00693          	li	a3,45
    166c:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    1670:	8d3e                	mv	s10,a5
    1672:	bf75                	j	162e <printf+0x2ba>
        buf[i++] = '-';
    1674:	181c                	addi	a5,sp,48
    1676:	97b6                	add	a5,a5,a3
    1678:	02d00713          	li	a4,45
    167c:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    1680:	8d36                	mv	s10,a3
    1682:	bdd9                	j	1558 <printf+0x1e4>
        x = -xx;
    1684:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    1688:	00f7f693          	andi	a3,a5,15
    168c:	96ce                	add	a3,a3,s3
    168e:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    1692:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    1696:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    169a:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    169e:	d80d1be3          	bnez	s10,1434 <printf+0xc0>
        buf[i++] = digits[x % base];
    16a2:	4d05                	li	s10,1
    16a4:	b34d                	j	1446 <printf+0xd2>
                s = "(null)";
    16a6:	00001d17          	auipc	s10,0x1
    16aa:	9ead0d13          	addi	s10,s10,-1558 # 2090 <sharedmem+0xbe>
                for (; *s; s++)
    16ae:	02800793          	li	a5,40
    16b2:	bbe5                	j	14aa <printf+0x136>
        buf[i++] = digits[x % base];
    16b4:	4785                	li	a5,1
    if (sign)
    16b6:	f606dce3          	bgez	a3,162e <printf+0x2ba>
    16ba:	b76d                	j	1664 <printf+0x2f0>
        buf[i++] = digits[x % base];
    16bc:	4789                	li	a5,2
    16be:	4d05                	li	s10,1
    if (sign)
    16c0:	f606d7e3          	bgez	a3,162e <printf+0x2ba>
    16c4:	b745                	j	1664 <printf+0x2f0>

00000000000016c6 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    16c6:	02000793          	li	a5,32
    16ca:	00f50663          	beq	a0,a5,16d6 <isspace+0x10>
    16ce:	355d                	addiw	a0,a0,-9
    16d0:	00553513          	sltiu	a0,a0,5
    16d4:	8082                	ret
    16d6:	4505                	li	a0,1
}
    16d8:	8082                	ret

00000000000016da <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    16da:	fd05051b          	addiw	a0,a0,-48
}
    16de:	00a53513          	sltiu	a0,a0,10
    16e2:	8082                	ret

00000000000016e4 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    16e4:	02000613          	li	a2,32
    16e8:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    16ea:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    16ee:	ff77069b          	addiw	a3,a4,-9
    16f2:	04c70d63          	beq	a4,a2,174c <atoi+0x68>
    16f6:	0007079b          	sext.w	a5,a4
    16fa:	04d5f963          	bgeu	a1,a3,174c <atoi+0x68>
        s++;
    switch (*s) {
    16fe:	02b00693          	li	a3,43
    1702:	04d70a63          	beq	a4,a3,1756 <atoi+0x72>
    1706:	02d00693          	li	a3,45
    170a:	06d70463          	beq	a4,a3,1772 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    170e:	fd07859b          	addiw	a1,a5,-48
    1712:	4625                	li	a2,9
    1714:	873e                	mv	a4,a5
    1716:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1718:	4e01                	li	t3,0
    while (isdigit(*s))
    171a:	04b66a63          	bltu	a2,a1,176e <atoi+0x8a>
    int n = 0, neg = 0;
    171e:	4501                	li	a0,0
    while (isdigit(*s))
    1720:	4825                	li	a6,9
    1722:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1726:	0025179b          	slliw	a5,a0,0x2
    172a:	9d3d                	addw	a0,a0,a5
    172c:	fd07031b          	addiw	t1,a4,-48
    1730:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1734:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1738:	0685                	addi	a3,a3,1
    173a:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    173e:	0006071b          	sext.w	a4,a2
    1742:	feb870e3          	bgeu	a6,a1,1722 <atoi+0x3e>
    return neg ? n : -n;
    1746:	000e0563          	beqz	t3,1750 <atoi+0x6c>
}
    174a:	8082                	ret
        s++;
    174c:	0505                	addi	a0,a0,1
    174e:	bf71                	j	16ea <atoi+0x6>
    1750:	4113053b          	subw	a0,t1,a7
    1754:	8082                	ret
    while (isdigit(*s))
    1756:	00154783          	lbu	a5,1(a0)
    175a:	4625                	li	a2,9
        s++;
    175c:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1760:	fd07859b          	addiw	a1,a5,-48
    1764:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1768:	4e01                	li	t3,0
    while (isdigit(*s))
    176a:	fab67ae3          	bgeu	a2,a1,171e <atoi+0x3a>
    176e:	4501                	li	a0,0
}
    1770:	8082                	ret
    while (isdigit(*s))
    1772:	00154783          	lbu	a5,1(a0)
    1776:	4625                	li	a2,9
        s++;
    1778:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    177c:	fd07859b          	addiw	a1,a5,-48
    1780:	0007871b          	sext.w	a4,a5
    1784:	feb665e3          	bltu	a2,a1,176e <atoi+0x8a>
        neg = 1;
    1788:	4e05                	li	t3,1
    178a:	bf51                	j	171e <atoi+0x3a>

000000000000178c <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    178c:	16060d63          	beqz	a2,1906 <memset+0x17a>
    1790:	40a007b3          	neg	a5,a0
    1794:	8b9d                	andi	a5,a5,7
    1796:	00778713          	addi	a4,a5,7
    179a:	482d                	li	a6,11
    179c:	0ff5f593          	andi	a1,a1,255
    17a0:	fff60693          	addi	a3,a2,-1
    17a4:	17076263          	bltu	a4,a6,1908 <memset+0x17c>
    17a8:	16e6ea63          	bltu	a3,a4,191c <memset+0x190>
    17ac:	16078563          	beqz	a5,1916 <memset+0x18a>
    17b0:	00b50023          	sb	a1,0(a0)
    17b4:	4705                	li	a4,1
    17b6:	00150e93          	addi	t4,a0,1
    17ba:	14e78c63          	beq	a5,a4,1912 <memset+0x186>
    17be:	00b500a3          	sb	a1,1(a0)
    17c2:	4709                	li	a4,2
    17c4:	00250e93          	addi	t4,a0,2
    17c8:	14e78d63          	beq	a5,a4,1922 <memset+0x196>
    17cc:	00b50123          	sb	a1,2(a0)
    17d0:	470d                	li	a4,3
    17d2:	00350e93          	addi	t4,a0,3
    17d6:	12e78b63          	beq	a5,a4,190c <memset+0x180>
    17da:	00b501a3          	sb	a1,3(a0)
    17de:	4711                	li	a4,4
    17e0:	00450e93          	addi	t4,a0,4
    17e4:	14e78163          	beq	a5,a4,1926 <memset+0x19a>
    17e8:	00b50223          	sb	a1,4(a0)
    17ec:	4715                	li	a4,5
    17ee:	00550e93          	addi	t4,a0,5
    17f2:	12e78c63          	beq	a5,a4,192a <memset+0x19e>
    17f6:	00b502a3          	sb	a1,5(a0)
    17fa:	471d                	li	a4,7
    17fc:	00650e93          	addi	t4,a0,6
    1800:	12e79763          	bne	a5,a4,192e <memset+0x1a2>
    1804:	00750e93          	addi	t4,a0,7
    1808:	00b50323          	sb	a1,6(a0)
    180c:	4f1d                	li	t5,7
    180e:	00859713          	slli	a4,a1,0x8
    1812:	8f4d                	or	a4,a4,a1
    1814:	01059e13          	slli	t3,a1,0x10
    1818:	01c76e33          	or	t3,a4,t3
    181c:	01859313          	slli	t1,a1,0x18
    1820:	006e6333          	or	t1,t3,t1
    1824:	02059893          	slli	a7,a1,0x20
    1828:	011368b3          	or	a7,t1,a7
    182c:	02859813          	slli	a6,a1,0x28
    1830:	40f60333          	sub	t1,a2,a5
    1834:	0108e833          	or	a6,a7,a6
    1838:	03059693          	slli	a3,a1,0x30
    183c:	00d866b3          	or	a3,a6,a3
    1840:	03859713          	slli	a4,a1,0x38
    1844:	97aa                	add	a5,a5,a0
    1846:	ff837813          	andi	a6,t1,-8
    184a:	8f55                	or	a4,a4,a3
    184c:	00f806b3          	add	a3,a6,a5
    1850:	e398                	sd	a4,0(a5)
    1852:	07a1                	addi	a5,a5,8
    1854:	fed79ee3          	bne	a5,a3,1850 <memset+0xc4>
    1858:	ff837693          	andi	a3,t1,-8
    185c:	00de87b3          	add	a5,t4,a3
    1860:	01e6873b          	addw	a4,a3,t5
    1864:	0ad30663          	beq	t1,a3,1910 <memset+0x184>
    1868:	00b78023          	sb	a1,0(a5)
    186c:	0017069b          	addiw	a3,a4,1
    1870:	08c6fb63          	bgeu	a3,a2,1906 <memset+0x17a>
    1874:	00b780a3          	sb	a1,1(a5)
    1878:	0027069b          	addiw	a3,a4,2
    187c:	08c6f563          	bgeu	a3,a2,1906 <memset+0x17a>
    1880:	00b78123          	sb	a1,2(a5)
    1884:	0037069b          	addiw	a3,a4,3
    1888:	06c6ff63          	bgeu	a3,a2,1906 <memset+0x17a>
    188c:	00b781a3          	sb	a1,3(a5)
    1890:	0047069b          	addiw	a3,a4,4
    1894:	06c6f963          	bgeu	a3,a2,1906 <memset+0x17a>
    1898:	00b78223          	sb	a1,4(a5)
    189c:	0057069b          	addiw	a3,a4,5
    18a0:	06c6f363          	bgeu	a3,a2,1906 <memset+0x17a>
    18a4:	00b782a3          	sb	a1,5(a5)
    18a8:	0067069b          	addiw	a3,a4,6
    18ac:	04c6fd63          	bgeu	a3,a2,1906 <memset+0x17a>
    18b0:	00b78323          	sb	a1,6(a5)
    18b4:	0077069b          	addiw	a3,a4,7
    18b8:	04c6f763          	bgeu	a3,a2,1906 <memset+0x17a>
    18bc:	00b783a3          	sb	a1,7(a5)
    18c0:	0087069b          	addiw	a3,a4,8
    18c4:	04c6f163          	bgeu	a3,a2,1906 <memset+0x17a>
    18c8:	00b78423          	sb	a1,8(a5)
    18cc:	0097069b          	addiw	a3,a4,9
    18d0:	02c6fb63          	bgeu	a3,a2,1906 <memset+0x17a>
    18d4:	00b784a3          	sb	a1,9(a5)
    18d8:	00a7069b          	addiw	a3,a4,10
    18dc:	02c6f563          	bgeu	a3,a2,1906 <memset+0x17a>
    18e0:	00b78523          	sb	a1,10(a5)
    18e4:	00b7069b          	addiw	a3,a4,11
    18e8:	00c6ff63          	bgeu	a3,a2,1906 <memset+0x17a>
    18ec:	00b785a3          	sb	a1,11(a5)
    18f0:	00c7069b          	addiw	a3,a4,12
    18f4:	00c6f963          	bgeu	a3,a2,1906 <memset+0x17a>
    18f8:	00b78623          	sb	a1,12(a5)
    18fc:	2735                	addiw	a4,a4,13
    18fe:	00c77463          	bgeu	a4,a2,1906 <memset+0x17a>
    1902:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    1906:	8082                	ret
    1908:	472d                	li	a4,11
    190a:	bd79                	j	17a8 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    190c:	4f0d                	li	t5,3
    190e:	b701                	j	180e <memset+0x82>
    1910:	8082                	ret
    1912:	4f05                	li	t5,1
    1914:	bded                	j	180e <memset+0x82>
    1916:	8eaa                	mv	t4,a0
    1918:	4f01                	li	t5,0
    191a:	bdd5                	j	180e <memset+0x82>
    191c:	87aa                	mv	a5,a0
    191e:	4701                	li	a4,0
    1920:	b7a1                	j	1868 <memset+0xdc>
    1922:	4f09                	li	t5,2
    1924:	b5ed                	j	180e <memset+0x82>
    1926:	4f11                	li	t5,4
    1928:	b5dd                	j	180e <memset+0x82>
    192a:	4f15                	li	t5,5
    192c:	b5cd                	j	180e <memset+0x82>
    192e:	4f19                	li	t5,6
    1930:	bdf9                	j	180e <memset+0x82>

0000000000001932 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    1932:	00054783          	lbu	a5,0(a0)
    1936:	0005c703          	lbu	a4,0(a1)
    193a:	00e79863          	bne	a5,a4,194a <strcmp+0x18>
    193e:	0505                	addi	a0,a0,1
    1940:	0585                	addi	a1,a1,1
    1942:	fbe5                	bnez	a5,1932 <strcmp>
    1944:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    1946:	9d19                	subw	a0,a0,a4
    1948:	8082                	ret
    194a:	0007851b          	sext.w	a0,a5
    194e:	bfe5                	j	1946 <strcmp+0x14>

0000000000001950 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1950:	87aa                	mv	a5,a0
    1952:	0005c703          	lbu	a4,0(a1)
    1956:	0785                	addi	a5,a5,1
    1958:	0585                	addi	a1,a1,1
    195a:	fee78fa3          	sb	a4,-1(a5)
    195e:	fb75                	bnez	a4,1952 <strcpy+0x2>
        ;
    return os;
}
    1960:	8082                	ret

0000000000001962 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    1962:	ce05                	beqz	a2,199a <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1964:	00054703          	lbu	a4,0(a0)
    1968:	0005c783          	lbu	a5,0(a1)
    196c:	cb0d                	beqz	a4,199e <strncmp+0x3c>
    if (!n--)
    196e:	167d                	addi	a2,a2,-1
    1970:	00c506b3          	add	a3,a0,a2
    1974:	a819                	j	198a <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1976:	00a68e63          	beq	a3,a0,1992 <strncmp+0x30>
    197a:	0505                	addi	a0,a0,1
    197c:	00e79b63          	bne	a5,a4,1992 <strncmp+0x30>
    1980:	00054703          	lbu	a4,0(a0)
    1984:	0005c783          	lbu	a5,0(a1)
    1988:	cb19                	beqz	a4,199e <strncmp+0x3c>
    198a:	0005c783          	lbu	a5,0(a1)
    198e:	0585                	addi	a1,a1,1
    1990:	f3fd                	bnez	a5,1976 <strncmp+0x14>
        ;
    return *l - *r;
    1992:	0007051b          	sext.w	a0,a4
    1996:	9d1d                	subw	a0,a0,a5
    1998:	8082                	ret
        return 0;
    199a:	4501                	li	a0,0
}
    199c:	8082                	ret
    199e:	4501                	li	a0,0
    return *l - *r;
    19a0:	9d1d                	subw	a0,a0,a5
    19a2:	8082                	ret

00000000000019a4 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    19a4:	00757793          	andi	a5,a0,7
    19a8:	cf89                	beqz	a5,19c2 <strlen+0x1e>
    19aa:	87aa                	mv	a5,a0
    19ac:	a029                	j	19b6 <strlen+0x12>
    19ae:	0785                	addi	a5,a5,1
    19b0:	0077f713          	andi	a4,a5,7
    19b4:	cb01                	beqz	a4,19c4 <strlen+0x20>
        if (!*s)
    19b6:	0007c703          	lbu	a4,0(a5)
    19ba:	fb75                	bnez	a4,19ae <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    19bc:	40a78533          	sub	a0,a5,a0
}
    19c0:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    19c2:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    19c4:	6394                	ld	a3,0(a5)
    19c6:	00000597          	auipc	a1,0x0
    19ca:	6d25b583          	ld	a1,1746(a1) # 2098 <sharedmem+0xc6>
    19ce:	00000617          	auipc	a2,0x0
    19d2:	6d263603          	ld	a2,1746(a2) # 20a0 <sharedmem+0xce>
    19d6:	a019                	j	19dc <strlen+0x38>
    19d8:	6794                	ld	a3,8(a5)
    19da:	07a1                	addi	a5,a5,8
    19dc:	00b68733          	add	a4,a3,a1
    19e0:	fff6c693          	not	a3,a3
    19e4:	8f75                	and	a4,a4,a3
    19e6:	8f71                	and	a4,a4,a2
    19e8:	db65                	beqz	a4,19d8 <strlen+0x34>
    for (; *s; s++)
    19ea:	0007c703          	lbu	a4,0(a5)
    19ee:	d779                	beqz	a4,19bc <strlen+0x18>
    19f0:	0017c703          	lbu	a4,1(a5)
    19f4:	0785                	addi	a5,a5,1
    19f6:	d379                	beqz	a4,19bc <strlen+0x18>
    19f8:	0017c703          	lbu	a4,1(a5)
    19fc:	0785                	addi	a5,a5,1
    19fe:	fb6d                	bnez	a4,19f0 <strlen+0x4c>
    1a00:	bf75                	j	19bc <strlen+0x18>

0000000000001a02 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1a02:	00757713          	andi	a4,a0,7
{
    1a06:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1a08:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1a0c:	cb19                	beqz	a4,1a22 <memchr+0x20>
    1a0e:	ce25                	beqz	a2,1a86 <memchr+0x84>
    1a10:	0007c703          	lbu	a4,0(a5)
    1a14:	04b70e63          	beq	a4,a1,1a70 <memchr+0x6e>
    1a18:	0785                	addi	a5,a5,1
    1a1a:	0077f713          	andi	a4,a5,7
    1a1e:	167d                	addi	a2,a2,-1
    1a20:	f77d                	bnez	a4,1a0e <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    1a22:	4501                	li	a0,0
    if (n && *s != c) {
    1a24:	c235                	beqz	a2,1a88 <memchr+0x86>
    1a26:	0007c703          	lbu	a4,0(a5)
    1a2a:	04b70363          	beq	a4,a1,1a70 <memchr+0x6e>
        size_t k = ONES * c;
    1a2e:	00000517          	auipc	a0,0x0
    1a32:	67a53503          	ld	a0,1658(a0) # 20a8 <sharedmem+0xd6>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1a36:	471d                	li	a4,7
        size_t k = ONES * c;
    1a38:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1a3c:	02c77a63          	bgeu	a4,a2,1a70 <memchr+0x6e>
    1a40:	00000897          	auipc	a7,0x0
    1a44:	6588b883          	ld	a7,1624(a7) # 2098 <sharedmem+0xc6>
    1a48:	00000817          	auipc	a6,0x0
    1a4c:	65883803          	ld	a6,1624(a6) # 20a0 <sharedmem+0xce>
    1a50:	431d                	li	t1,7
    1a52:	a029                	j	1a5c <memchr+0x5a>
    1a54:	1661                	addi	a2,a2,-8
    1a56:	07a1                	addi	a5,a5,8
    1a58:	02c37963          	bgeu	t1,a2,1a8a <memchr+0x88>
    1a5c:	6398                	ld	a4,0(a5)
    1a5e:	8f29                	xor	a4,a4,a0
    1a60:	011706b3          	add	a3,a4,a7
    1a64:	fff74713          	not	a4,a4
    1a68:	8f75                	and	a4,a4,a3
    1a6a:	01077733          	and	a4,a4,a6
    1a6e:	d37d                	beqz	a4,1a54 <memchr+0x52>
    1a70:	853e                	mv	a0,a5
    1a72:	97b2                	add	a5,a5,a2
    1a74:	a021                	j	1a7c <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1a76:	0505                	addi	a0,a0,1
    1a78:	00f50763          	beq	a0,a5,1a86 <memchr+0x84>
    1a7c:	00054703          	lbu	a4,0(a0)
    1a80:	feb71be3          	bne	a4,a1,1a76 <memchr+0x74>
    1a84:	8082                	ret
    return n ? (void*)s : 0;
    1a86:	4501                	li	a0,0
}
    1a88:	8082                	ret
    return n ? (void*)s : 0;
    1a8a:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1a8c:	f275                	bnez	a2,1a70 <memchr+0x6e>
}
    1a8e:	8082                	ret

0000000000001a90 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1a90:	1101                	addi	sp,sp,-32
    1a92:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1a94:	862e                	mv	a2,a1
{
    1a96:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1a98:	4581                	li	a1,0
{
    1a9a:	e426                	sd	s1,8(sp)
    1a9c:	ec06                	sd	ra,24(sp)
    1a9e:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1aa0:	f63ff0ef          	jal	ra,1a02 <memchr>
    return p ? p - s : n;
    1aa4:	c519                	beqz	a0,1ab2 <strnlen+0x22>
}
    1aa6:	60e2                	ld	ra,24(sp)
    1aa8:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1aaa:	8d05                	sub	a0,a0,s1
}
    1aac:	64a2                	ld	s1,8(sp)
    1aae:	6105                	addi	sp,sp,32
    1ab0:	8082                	ret
    1ab2:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1ab4:	8522                	mv	a0,s0
}
    1ab6:	6442                	ld	s0,16(sp)
    1ab8:	64a2                	ld	s1,8(sp)
    1aba:	6105                	addi	sp,sp,32
    1abc:	8082                	ret

0000000000001abe <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1abe:	00b547b3          	xor	a5,a0,a1
    1ac2:	8b9d                	andi	a5,a5,7
    1ac4:	eb95                	bnez	a5,1af8 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1ac6:	0075f793          	andi	a5,a1,7
    1aca:	e7b1                	bnez	a5,1b16 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1acc:	6198                	ld	a4,0(a1)
    1ace:	00000617          	auipc	a2,0x0
    1ad2:	5ca63603          	ld	a2,1482(a2) # 2098 <sharedmem+0xc6>
    1ad6:	00000817          	auipc	a6,0x0
    1ada:	5ca83803          	ld	a6,1482(a6) # 20a0 <sharedmem+0xce>
    1ade:	a029                	j	1ae8 <stpcpy+0x2a>
    1ae0:	e118                	sd	a4,0(a0)
    1ae2:	6598                	ld	a4,8(a1)
    1ae4:	05a1                	addi	a1,a1,8
    1ae6:	0521                	addi	a0,a0,8
    1ae8:	00c707b3          	add	a5,a4,a2
    1aec:	fff74693          	not	a3,a4
    1af0:	8ff5                	and	a5,a5,a3
    1af2:	0107f7b3          	and	a5,a5,a6
    1af6:	d7ed                	beqz	a5,1ae0 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1af8:	0005c783          	lbu	a5,0(a1)
    1afc:	00f50023          	sb	a5,0(a0)
    1b00:	c785                	beqz	a5,1b28 <stpcpy+0x6a>
    1b02:	0015c783          	lbu	a5,1(a1)
    1b06:	0505                	addi	a0,a0,1
    1b08:	0585                	addi	a1,a1,1
    1b0a:	00f50023          	sb	a5,0(a0)
    1b0e:	fbf5                	bnez	a5,1b02 <stpcpy+0x44>
        ;
    return d;
}
    1b10:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1b12:	0505                	addi	a0,a0,1
    1b14:	df45                	beqz	a4,1acc <stpcpy+0xe>
            if (!(*d = *s))
    1b16:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1b1a:	0585                	addi	a1,a1,1
    1b1c:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1b20:	00f50023          	sb	a5,0(a0)
    1b24:	f7fd                	bnez	a5,1b12 <stpcpy+0x54>
}
    1b26:	8082                	ret
    1b28:	8082                	ret

0000000000001b2a <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1b2a:	00b547b3          	xor	a5,a0,a1
    1b2e:	8b9d                	andi	a5,a5,7
    1b30:	1a079863          	bnez	a5,1ce0 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1b34:	0075f793          	andi	a5,a1,7
    1b38:	16078463          	beqz	a5,1ca0 <stpncpy+0x176>
    1b3c:	ea01                	bnez	a2,1b4c <stpncpy+0x22>
    1b3e:	a421                	j	1d46 <stpncpy+0x21c>
    1b40:	167d                	addi	a2,a2,-1
    1b42:	0505                	addi	a0,a0,1
    1b44:	14070e63          	beqz	a4,1ca0 <stpncpy+0x176>
    1b48:	1a060863          	beqz	a2,1cf8 <stpncpy+0x1ce>
    1b4c:	0005c783          	lbu	a5,0(a1)
    1b50:	0585                	addi	a1,a1,1
    1b52:	0075f713          	andi	a4,a1,7
    1b56:	00f50023          	sb	a5,0(a0)
    1b5a:	f3fd                	bnez	a5,1b40 <stpncpy+0x16>
    1b5c:	4805                	li	a6,1
    1b5e:	1a061863          	bnez	a2,1d0e <stpncpy+0x1e4>
    1b62:	40a007b3          	neg	a5,a0
    1b66:	8b9d                	andi	a5,a5,7
    1b68:	4681                	li	a3,0
    1b6a:	18061a63          	bnez	a2,1cfe <stpncpy+0x1d4>
    1b6e:	00778713          	addi	a4,a5,7
    1b72:	45ad                	li	a1,11
    1b74:	18b76363          	bltu	a4,a1,1cfa <stpncpy+0x1d0>
    1b78:	1ae6eb63          	bltu	a3,a4,1d2e <stpncpy+0x204>
    1b7c:	1a078363          	beqz	a5,1d22 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1b80:	00050023          	sb	zero,0(a0)
    1b84:	4685                	li	a3,1
    1b86:	00150713          	addi	a4,a0,1
    1b8a:	18d78f63          	beq	a5,a3,1d28 <stpncpy+0x1fe>
    1b8e:	000500a3          	sb	zero,1(a0)
    1b92:	4689                	li	a3,2
    1b94:	00250713          	addi	a4,a0,2
    1b98:	18d78e63          	beq	a5,a3,1d34 <stpncpy+0x20a>
    1b9c:	00050123          	sb	zero,2(a0)
    1ba0:	468d                	li	a3,3
    1ba2:	00350713          	addi	a4,a0,3
    1ba6:	16d78c63          	beq	a5,a3,1d1e <stpncpy+0x1f4>
    1baa:	000501a3          	sb	zero,3(a0)
    1bae:	4691                	li	a3,4
    1bb0:	00450713          	addi	a4,a0,4
    1bb4:	18d78263          	beq	a5,a3,1d38 <stpncpy+0x20e>
    1bb8:	00050223          	sb	zero,4(a0)
    1bbc:	4695                	li	a3,5
    1bbe:	00550713          	addi	a4,a0,5
    1bc2:	16d78d63          	beq	a5,a3,1d3c <stpncpy+0x212>
    1bc6:	000502a3          	sb	zero,5(a0)
    1bca:	469d                	li	a3,7
    1bcc:	00650713          	addi	a4,a0,6
    1bd0:	16d79863          	bne	a5,a3,1d40 <stpncpy+0x216>
    1bd4:	00750713          	addi	a4,a0,7
    1bd8:	00050323          	sb	zero,6(a0)
    1bdc:	40f80833          	sub	a6,a6,a5
    1be0:	ff887593          	andi	a1,a6,-8
    1be4:	97aa                	add	a5,a5,a0
    1be6:	95be                	add	a1,a1,a5
    1be8:	0007b023          	sd	zero,0(a5)
    1bec:	07a1                	addi	a5,a5,8
    1bee:	feb79de3          	bne	a5,a1,1be8 <stpncpy+0xbe>
    1bf2:	ff887593          	andi	a1,a6,-8
    1bf6:	9ead                	addw	a3,a3,a1
    1bf8:	00b707b3          	add	a5,a4,a1
    1bfc:	12b80863          	beq	a6,a1,1d2c <stpncpy+0x202>
    1c00:	00078023          	sb	zero,0(a5)
    1c04:	0016871b          	addiw	a4,a3,1
    1c08:	0ec77863          	bgeu	a4,a2,1cf8 <stpncpy+0x1ce>
    1c0c:	000780a3          	sb	zero,1(a5)
    1c10:	0026871b          	addiw	a4,a3,2
    1c14:	0ec77263          	bgeu	a4,a2,1cf8 <stpncpy+0x1ce>
    1c18:	00078123          	sb	zero,2(a5)
    1c1c:	0036871b          	addiw	a4,a3,3
    1c20:	0cc77c63          	bgeu	a4,a2,1cf8 <stpncpy+0x1ce>
    1c24:	000781a3          	sb	zero,3(a5)
    1c28:	0046871b          	addiw	a4,a3,4
    1c2c:	0cc77663          	bgeu	a4,a2,1cf8 <stpncpy+0x1ce>
    1c30:	00078223          	sb	zero,4(a5)
    1c34:	0056871b          	addiw	a4,a3,5
    1c38:	0cc77063          	bgeu	a4,a2,1cf8 <stpncpy+0x1ce>
    1c3c:	000782a3          	sb	zero,5(a5)
    1c40:	0066871b          	addiw	a4,a3,6
    1c44:	0ac77a63          	bgeu	a4,a2,1cf8 <stpncpy+0x1ce>
    1c48:	00078323          	sb	zero,6(a5)
    1c4c:	0076871b          	addiw	a4,a3,7
    1c50:	0ac77463          	bgeu	a4,a2,1cf8 <stpncpy+0x1ce>
    1c54:	000783a3          	sb	zero,7(a5)
    1c58:	0086871b          	addiw	a4,a3,8
    1c5c:	08c77e63          	bgeu	a4,a2,1cf8 <stpncpy+0x1ce>
    1c60:	00078423          	sb	zero,8(a5)
    1c64:	0096871b          	addiw	a4,a3,9
    1c68:	08c77863          	bgeu	a4,a2,1cf8 <stpncpy+0x1ce>
    1c6c:	000784a3          	sb	zero,9(a5)
    1c70:	00a6871b          	addiw	a4,a3,10
    1c74:	08c77263          	bgeu	a4,a2,1cf8 <stpncpy+0x1ce>
    1c78:	00078523          	sb	zero,10(a5)
    1c7c:	00b6871b          	addiw	a4,a3,11
    1c80:	06c77c63          	bgeu	a4,a2,1cf8 <stpncpy+0x1ce>
    1c84:	000785a3          	sb	zero,11(a5)
    1c88:	00c6871b          	addiw	a4,a3,12
    1c8c:	06c77663          	bgeu	a4,a2,1cf8 <stpncpy+0x1ce>
    1c90:	00078623          	sb	zero,12(a5)
    1c94:	26b5                	addiw	a3,a3,13
    1c96:	06c6f163          	bgeu	a3,a2,1cf8 <stpncpy+0x1ce>
    1c9a:	000786a3          	sb	zero,13(a5)
    1c9e:	8082                	ret
            ;
        if (!n || !*s)
    1ca0:	c645                	beqz	a2,1d48 <stpncpy+0x21e>
    1ca2:	0005c783          	lbu	a5,0(a1)
    1ca6:	ea078be3          	beqz	a5,1b5c <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1caa:	479d                	li	a5,7
    1cac:	02c7ff63          	bgeu	a5,a2,1cea <stpncpy+0x1c0>
    1cb0:	00000897          	auipc	a7,0x0
    1cb4:	3e88b883          	ld	a7,1000(a7) # 2098 <sharedmem+0xc6>
    1cb8:	00000817          	auipc	a6,0x0
    1cbc:	3e883803          	ld	a6,1000(a6) # 20a0 <sharedmem+0xce>
    1cc0:	431d                	li	t1,7
    1cc2:	6198                	ld	a4,0(a1)
    1cc4:	011707b3          	add	a5,a4,a7
    1cc8:	fff74693          	not	a3,a4
    1ccc:	8ff5                	and	a5,a5,a3
    1cce:	0107f7b3          	and	a5,a5,a6
    1cd2:	ef81                	bnez	a5,1cea <stpncpy+0x1c0>
            *wd = *ws;
    1cd4:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1cd6:	1661                	addi	a2,a2,-8
    1cd8:	05a1                	addi	a1,a1,8
    1cda:	0521                	addi	a0,a0,8
    1cdc:	fec363e3          	bltu	t1,a2,1cc2 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1ce0:	e609                	bnez	a2,1cea <stpncpy+0x1c0>
    1ce2:	a08d                	j	1d44 <stpncpy+0x21a>
    1ce4:	167d                	addi	a2,a2,-1
    1ce6:	0505                	addi	a0,a0,1
    1ce8:	ca01                	beqz	a2,1cf8 <stpncpy+0x1ce>
    1cea:	0005c783          	lbu	a5,0(a1)
    1cee:	0585                	addi	a1,a1,1
    1cf0:	00f50023          	sb	a5,0(a0)
    1cf4:	fbe5                	bnez	a5,1ce4 <stpncpy+0x1ba>
        ;
tail:
    1cf6:	b59d                	j	1b5c <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1cf8:	8082                	ret
    1cfa:	472d                	li	a4,11
    1cfc:	bdb5                	j	1b78 <stpncpy+0x4e>
    1cfe:	00778713          	addi	a4,a5,7
    1d02:	45ad                	li	a1,11
    1d04:	fff60693          	addi	a3,a2,-1
    1d08:	e6b778e3          	bgeu	a4,a1,1b78 <stpncpy+0x4e>
    1d0c:	b7fd                	j	1cfa <stpncpy+0x1d0>
    1d0e:	40a007b3          	neg	a5,a0
    1d12:	8832                	mv	a6,a2
    1d14:	8b9d                	andi	a5,a5,7
    1d16:	4681                	li	a3,0
    1d18:	e4060be3          	beqz	a2,1b6e <stpncpy+0x44>
    1d1c:	b7cd                	j	1cfe <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1d1e:	468d                	li	a3,3
    1d20:	bd75                	j	1bdc <stpncpy+0xb2>
    1d22:	872a                	mv	a4,a0
    1d24:	4681                	li	a3,0
    1d26:	bd5d                	j	1bdc <stpncpy+0xb2>
    1d28:	4685                	li	a3,1
    1d2a:	bd4d                	j	1bdc <stpncpy+0xb2>
    1d2c:	8082                	ret
    1d2e:	87aa                	mv	a5,a0
    1d30:	4681                	li	a3,0
    1d32:	b5f9                	j	1c00 <stpncpy+0xd6>
    1d34:	4689                	li	a3,2
    1d36:	b55d                	j	1bdc <stpncpy+0xb2>
    1d38:	4691                	li	a3,4
    1d3a:	b54d                	j	1bdc <stpncpy+0xb2>
    1d3c:	4695                	li	a3,5
    1d3e:	bd79                	j	1bdc <stpncpy+0xb2>
    1d40:	4699                	li	a3,6
    1d42:	bd69                	j	1bdc <stpncpy+0xb2>
    1d44:	8082                	ret
    1d46:	8082                	ret
    1d48:	8082                	ret

0000000000001d4a <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1d4a:	fff6071b          	addiw	a4,a2,-1
    1d4e:	0cb57063          	bgeu	a0,a1,1e0e <memmove+0xc4>
        while (n-- > 0)
    1d52:	0ec05063          	blez	a2,1e32 <memmove+0xe8>
    1d56:	00750693          	addi	a3,a0,7
    1d5a:	8e8d                	sub	a3,a3,a1
    1d5c:	00b567b3          	or	a5,a0,a1
    1d60:	00f6b693          	sltiu	a3,a3,15
    1d64:	8b9d                	andi	a5,a5,7
    1d66:	0016c693          	xori	a3,a3,1
    1d6a:	0017b793          	seqz	a5,a5
    1d6e:	8ff5                	and	a5,a5,a3
    1d70:	c3f1                	beqz	a5,1e34 <memmove+0xea>
    1d72:	0007079b          	sext.w	a5,a4
    1d76:	46a5                	li	a3,9
    1d78:	0af6fe63          	bgeu	a3,a5,1e34 <memmove+0xea>
    1d7c:	0036589b          	srliw	a7,a2,0x3
    1d80:	088e                	slli	a7,a7,0x3
    1d82:	2601                	sext.w	a2,a2
    1d84:	87ae                	mv	a5,a1
    1d86:	86aa                	mv	a3,a0
    1d88:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1d8a:	0007b803          	ld	a6,0(a5)
    1d8e:	07a1                	addi	a5,a5,8
    1d90:	06a1                	addi	a3,a3,8
    1d92:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1d96:	ff179ae3          	bne	a5,a7,1d8a <memmove+0x40>
    1d9a:	ff867813          	andi	a6,a2,-8
    1d9e:	02081793          	slli	a5,a6,0x20
    1da2:	9381                	srli	a5,a5,0x20
    1da4:	00f506b3          	add	a3,a0,a5
    1da8:	95be                	add	a1,a1,a5
    1daa:	4107073b          	subw	a4,a4,a6
    1dae:	09060263          	beq	a2,a6,1e32 <memmove+0xe8>
            *dst++ = *src++;
    1db2:	0005c783          	lbu	a5,0(a1)
    1db6:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1dba:	06e05c63          	blez	a4,1e32 <memmove+0xe8>
            *dst++ = *src++;
    1dbe:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1dc2:	4785                	li	a5,1
            *dst++ = *src++;
    1dc4:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1dc8:	06e7d563          	bge	a5,a4,1e32 <memmove+0xe8>
            *dst++ = *src++;
    1dcc:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1dd0:	4789                	li	a5,2
            *dst++ = *src++;
    1dd2:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1dd6:	04e7de63          	bge	a5,a4,1e32 <memmove+0xe8>
            *dst++ = *src++;
    1dda:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1dde:	478d                	li	a5,3
            *dst++ = *src++;
    1de0:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1de4:	04e7d763          	bge	a5,a4,1e32 <memmove+0xe8>
            *dst++ = *src++;
    1de8:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1dec:	4791                	li	a5,4
            *dst++ = *src++;
    1dee:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1df2:	04e7d063          	bge	a5,a4,1e32 <memmove+0xe8>
            *dst++ = *src++;
    1df6:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1dfa:	4795                	li	a5,5
            *dst++ = *src++;
    1dfc:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1e00:	02e7d963          	bge	a5,a4,1e32 <memmove+0xe8>
            *dst++ = *src++;
    1e04:	0065c783          	lbu	a5,6(a1)
    1e08:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1e0c:	8082                	ret
    } else {
        dst += n;
    1e0e:	00c507b3          	add	a5,a0,a2
        src += n;
    1e12:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1e14:	00c05f63          	blez	a2,1e32 <memmove+0xe8>
    1e18:	1702                	slli	a4,a4,0x20
    1e1a:	9301                	srli	a4,a4,0x20
    1e1c:	fff74713          	not	a4,a4
    1e20:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1e22:	fff5c683          	lbu	a3,-1(a1)
    1e26:	17fd                	addi	a5,a5,-1
    1e28:	15fd                	addi	a1,a1,-1
    1e2a:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1e2e:	fee79ae3          	bne	a5,a4,1e22 <memmove+0xd8>
    }
    return vdst;
}
    1e32:	8082                	ret
    1e34:	02071693          	slli	a3,a4,0x20
    1e38:	9281                	srli	a3,a3,0x20
    1e3a:	0685                	addi	a3,a3,1
    1e3c:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1e3e:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1e40:	0005c703          	lbu	a4,0(a1)
    1e44:	0585                	addi	a1,a1,1
    1e46:	0785                	addi	a5,a5,1
    1e48:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1e4c:	fed59ae3          	bne	a1,a3,1e40 <memmove+0xf6>
    1e50:	8082                	ret

0000000000001e52 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1e52:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e56:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1e5a:	2501                	sext.w	a0,a0
    1e5c:	8082                	ret

0000000000001e5e <exec>:
    register long a7 __asm__("a7") = n;
    1e5e:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1e62:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1e64:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1e68:	2501                	sext.w	a0,a0
    1e6a:	8082                	ret

0000000000001e6c <exit>:
    register long a7 __asm__("a7") = n;
    1e6c:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1e70:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1e74:	8082                	ret

0000000000001e76 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1e76:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e7a:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1e7e:	8082                	ret

0000000000001e80 <write>:
    register long a7 __asm__("a7") = n;
    1e80:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1e84:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1e88:	8082                	ret

0000000000001e8a <getpid>:
    register long a7 __asm__("a7") = n;
    1e8a:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1e8e:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1e92:	2501                	sext.w	a0,a0
    1e94:	8082                	ret

0000000000001e96 <getppid>:
    register long a7 __asm__("a7") = n;
    1e96:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1e9a:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1e9e:	2501                	sext.w	a0,a0
    1ea0:	8082                	ret

0000000000001ea2 <open>:
    register long a7 __asm__("a7") = n;
    1ea2:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ea6:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1eaa:	2501                	sext.w	a0,a0
    1eac:	8082                	ret

0000000000001eae <mknod>:
    register long a7 __asm__("a7") = n;
    1eae:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1eb2:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1eb6:	2501                	sext.w	a0,a0
    1eb8:	8082                	ret

0000000000001eba <dup>:
    register long a7 __asm__("a7") = n;
    1eba:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1ebc:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1ec0:	2501                	sext.w	a0,a0
    1ec2:	8082                	ret

0000000000001ec4 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1ec4:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1ec8:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1ecc:	2501                	sext.w	a0,a0
    1ece:	8082                	ret

0000000000001ed0 <waitpid>:
    register long a7 __asm__("a7") = n;
    1ed0:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ed4:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1ed8:	2501                	sext.w	a0,a0
    1eda:	8082                	ret

0000000000001edc <wait>:

pid_t wait(int *wstatus)
{
    1edc:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1ede:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1ee2:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1ee4:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1ee8:	2501                	sext.w	a0,a0
    1eea:	8082                	ret

0000000000001eec <mkdir>:
    register long a7 __asm__("a7") = n;
    1eec:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1ef0:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1ef4:	2501                	sext.w	a0,a0
    1ef6:	8082                	ret

0000000000001ef8 <close>:
    register long a7 __asm__("a7") = n;
    1ef8:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1efc:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1f00:	2501                	sext.w	a0,a0
    1f02:	8082                	ret

0000000000001f04 <fork>:
    register long a7 __asm__("a7") = n;
    1f04:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1f08:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1f0c:	2501                	sext.w	a0,a0
    1f0e:	8082                	ret

0000000000001f10 <time_ms>:
    register long a7 __asm__("a7") = n;
    1f10:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1f14:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1f18:	8082                	ret

0000000000001f1a <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1f1a:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1f1c:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1f20:	00000073          	ecall
    1f24:	87aa                	mv	a5,a0
    1f26:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1f2a:	97ba                	add	a5,a5,a4
    1f2c:	00f57c63          	bgeu	a0,a5,1f44 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1f30:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1f34:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1f38:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1f3c:	00000073          	ecall
    1f40:	fef568e3          	bltu	a0,a5,1f30 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1f44:	4501                	li	a0,0
    1f46:	8082                	ret

0000000000001f48 <pipe>:
    register long a7 __asm__("a7") = n;
    1f48:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1f4c:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1f50:	2501                	sext.w	a0,a0
    1f52:	8082                	ret

0000000000001f54 <fstat>:
    register long a7 __asm__("a7") = n;
    1f54:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f58:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    1f5c:	2501                	sext.w	a0,a0
    1f5e:	8082                	ret

0000000000001f60 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1f60:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1f62:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1f66:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f68:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    1f6c:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1f70:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1f74:	0206c163          	bltz	a3,1f96 <stat+0x36>
    register long a7 __asm__("a7") = n;
    1f78:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    1f7c:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1f7e:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f80:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1f84:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    1f88:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    1f8c:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1f8e:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1f92:	853e                	mv	a0,a5
    1f94:	8082                	ret
        return -1;
    1f96:	57fd                	li	a5,-1
    1f98:	bfed                	j	1f92 <stat+0x32>

0000000000001f9a <chdir>:
    register long a7 __asm__("a7") = n;
    1f9a:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1f9e:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1fa2:	2501                	sext.w	a0,a0
    1fa4:	8082                	ret

0000000000001fa6 <link>:
    register long a7 __asm__("a7") = n;
    1fa6:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1faa:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1fae:	2501                	sext.w	a0,a0
    1fb0:	8082                	ret

0000000000001fb2 <unlink>:
    register long a7 __asm__("a7") = n;
    1fb2:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1fb6:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    1fba:	2501                	sext.w	a0,a0
    1fbc:	8082                	ret

0000000000001fbe <setpriority>:
    register long a7 __asm__("a7") = n;
    1fbe:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1fc2:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1fc6:	8082                	ret

0000000000001fc8 <getpriority>:
    register long a7 __asm__("a7") = n;
    1fc8:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    1fcc:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1fd0:	8082                	ret

0000000000001fd2 <sharedmem>:
    register long a7 __asm__("a7") = n;
    1fd2:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1fd6:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    1fda:	8082                	ret
