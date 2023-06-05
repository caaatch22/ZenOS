
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_echo:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a8ad                	j	107a <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <stdio.h>
#include <string.h>
#include <ucore.h>
int
main(int argc, char *argv[])
{
    1002:	7179                	addi	sp,sp,-48
    1004:	f406                	sd	ra,40(sp)
    1006:	f022                	sd	s0,32(sp)
    1008:	ec26                	sd	s1,24(sp)
    100a:	e84a                	sd	s2,16(sp)
    100c:	e44e                	sd	s3,8(sp)
  int i;

  for(i = 1; i < argc; i++){
    100e:	4785                	li	a5,1
    1010:	04a7da63          	bge	a5,a0,1064 <main+0x62>
    1014:	ffe5091b          	addiw	s2,a0,-2
    1018:	1902                	slli	s2,s2,0x20
    101a:	01d95913          	srli	s2,s2,0x1d
    101e:	01058793          	addi	a5,a1,16
    1022:	00858413          	addi	s0,a1,8
    1026:	993e                	add	s2,s2,a5
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
    1028:	00001997          	auipc	s3,0x1
    102c:	97898993          	addi	s3,s3,-1672 # 19a0 <sharedmem+0xc>
    write(1, argv[i], strlen(argv[i]));
    1030:	6004                	ld	s1,0(s0)
    1032:	0421                	addi	s0,s0,8
    1034:	8526                	mv	a0,s1
    1036:	330000ef          	jal	ra,1366 <strlen>
    103a:	862a                	mv	a2,a0
    103c:	85a6                	mv	a1,s1
    103e:	4505                	li	a0,1
    1040:	003000ef          	jal	ra,1842 <write>
      write(1, " ", 1);
    1044:	4605                	li	a2,1
    1046:	85ce                	mv	a1,s3
    1048:	4505                	li	a0,1
    if(i + 1 < argc){
    104a:	01240563          	beq	s0,s2,1054 <main+0x52>
      write(1, " ", 1);
    104e:	7f4000ef          	jal	ra,1842 <write>
  for(i = 1; i < argc; i++){
    1052:	bff9                	j	1030 <main+0x2e>
    } else {
      write(1, "\n", 1);
    1054:	4605                	li	a2,1
    1056:	00001597          	auipc	a1,0x1
    105a:	95258593          	addi	a1,a1,-1710 # 19a8 <sharedmem+0x14>
    105e:	4505                	li	a0,1
    1060:	7e2000ef          	jal	ra,1842 <write>
    }
  }
  exit(0);
    1064:	4501                	li	a0,0
    1066:	7c8000ef          	jal	ra,182e <exit>
}
    106a:	70a2                	ld	ra,40(sp)
    106c:	7402                	ld	s0,32(sp)
    106e:	64e2                	ld	s1,24(sp)
    1070:	6942                	ld	s2,16(sp)
    1072:	69a2                	ld	s3,8(sp)
    1074:	4501                	li	a0,0
    1076:	6145                	addi	sp,sp,48
    1078:	8082                	ret

000000000000107a <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    107a:	1141                	addi	sp,sp,-16
    107c:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    107e:	f85ff0ef          	jal	ra,1002 <main>
}
    1082:	60a2                	ld	ra,8(sp)
    1084:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    1086:	a765                	j	182e <exit>

0000000000001088 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1088:	02000793          	li	a5,32
    108c:	00f50663          	beq	a0,a5,1098 <isspace+0x10>
    1090:	355d                	addiw	a0,a0,-9
    1092:	00553513          	sltiu	a0,a0,5
    1096:	8082                	ret
    1098:	4505                	li	a0,1
}
    109a:	8082                	ret

000000000000109c <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    109c:	fd05051b          	addiw	a0,a0,-48
}
    10a0:	00a53513          	sltiu	a0,a0,10
    10a4:	8082                	ret

00000000000010a6 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    10a6:	02000613          	li	a2,32
    10aa:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    10ac:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    10b0:	ff77069b          	addiw	a3,a4,-9
    10b4:	04c70d63          	beq	a4,a2,110e <atoi+0x68>
    10b8:	0007079b          	sext.w	a5,a4
    10bc:	04d5f963          	bgeu	a1,a3,110e <atoi+0x68>
        s++;
    switch (*s) {
    10c0:	02b00693          	li	a3,43
    10c4:	04d70a63          	beq	a4,a3,1118 <atoi+0x72>
    10c8:	02d00693          	li	a3,45
    10cc:	06d70463          	beq	a4,a3,1134 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    10d0:	fd07859b          	addiw	a1,a5,-48
    10d4:	4625                	li	a2,9
    10d6:	873e                	mv	a4,a5
    10d8:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    10da:	4e01                	li	t3,0
    while (isdigit(*s))
    10dc:	04b66a63          	bltu	a2,a1,1130 <atoi+0x8a>
    int n = 0, neg = 0;
    10e0:	4501                	li	a0,0
    while (isdigit(*s))
    10e2:	4825                	li	a6,9
    10e4:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    10e8:	0025179b          	slliw	a5,a0,0x2
    10ec:	9d3d                	addw	a0,a0,a5
    10ee:	fd07031b          	addiw	t1,a4,-48
    10f2:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    10f6:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    10fa:	0685                	addi	a3,a3,1
    10fc:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    1100:	0006071b          	sext.w	a4,a2
    1104:	feb870e3          	bgeu	a6,a1,10e4 <atoi+0x3e>
    return neg ? n : -n;
    1108:	000e0563          	beqz	t3,1112 <atoi+0x6c>
}
    110c:	8082                	ret
        s++;
    110e:	0505                	addi	a0,a0,1
    1110:	bf71                	j	10ac <atoi+0x6>
    1112:	4113053b          	subw	a0,t1,a7
    1116:	8082                	ret
    while (isdigit(*s))
    1118:	00154783          	lbu	a5,1(a0)
    111c:	4625                	li	a2,9
        s++;
    111e:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1122:	fd07859b          	addiw	a1,a5,-48
    1126:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    112a:	4e01                	li	t3,0
    while (isdigit(*s))
    112c:	fab67ae3          	bgeu	a2,a1,10e0 <atoi+0x3a>
    1130:	4501                	li	a0,0
}
    1132:	8082                	ret
    while (isdigit(*s))
    1134:	00154783          	lbu	a5,1(a0)
    1138:	4625                	li	a2,9
        s++;
    113a:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    113e:	fd07859b          	addiw	a1,a5,-48
    1142:	0007871b          	sext.w	a4,a5
    1146:	feb665e3          	bltu	a2,a1,1130 <atoi+0x8a>
        neg = 1;
    114a:	4e05                	li	t3,1
    114c:	bf51                	j	10e0 <atoi+0x3a>

000000000000114e <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    114e:	16060d63          	beqz	a2,12c8 <memset+0x17a>
    1152:	40a007b3          	neg	a5,a0
    1156:	8b9d                	andi	a5,a5,7
    1158:	00778713          	addi	a4,a5,7
    115c:	482d                	li	a6,11
    115e:	0ff5f593          	andi	a1,a1,255
    1162:	fff60693          	addi	a3,a2,-1
    1166:	17076263          	bltu	a4,a6,12ca <memset+0x17c>
    116a:	16e6ea63          	bltu	a3,a4,12de <memset+0x190>
    116e:	16078563          	beqz	a5,12d8 <memset+0x18a>
    1172:	00b50023          	sb	a1,0(a0)
    1176:	4705                	li	a4,1
    1178:	00150e93          	addi	t4,a0,1
    117c:	14e78c63          	beq	a5,a4,12d4 <memset+0x186>
    1180:	00b500a3          	sb	a1,1(a0)
    1184:	4709                	li	a4,2
    1186:	00250e93          	addi	t4,a0,2
    118a:	14e78d63          	beq	a5,a4,12e4 <memset+0x196>
    118e:	00b50123          	sb	a1,2(a0)
    1192:	470d                	li	a4,3
    1194:	00350e93          	addi	t4,a0,3
    1198:	12e78b63          	beq	a5,a4,12ce <memset+0x180>
    119c:	00b501a3          	sb	a1,3(a0)
    11a0:	4711                	li	a4,4
    11a2:	00450e93          	addi	t4,a0,4
    11a6:	14e78163          	beq	a5,a4,12e8 <memset+0x19a>
    11aa:	00b50223          	sb	a1,4(a0)
    11ae:	4715                	li	a4,5
    11b0:	00550e93          	addi	t4,a0,5
    11b4:	12e78c63          	beq	a5,a4,12ec <memset+0x19e>
    11b8:	00b502a3          	sb	a1,5(a0)
    11bc:	471d                	li	a4,7
    11be:	00650e93          	addi	t4,a0,6
    11c2:	12e79763          	bne	a5,a4,12f0 <memset+0x1a2>
    11c6:	00750e93          	addi	t4,a0,7
    11ca:	00b50323          	sb	a1,6(a0)
    11ce:	4f1d                	li	t5,7
    11d0:	00859713          	slli	a4,a1,0x8
    11d4:	8f4d                	or	a4,a4,a1
    11d6:	01059e13          	slli	t3,a1,0x10
    11da:	01c76e33          	or	t3,a4,t3
    11de:	01859313          	slli	t1,a1,0x18
    11e2:	006e6333          	or	t1,t3,t1
    11e6:	02059893          	slli	a7,a1,0x20
    11ea:	011368b3          	or	a7,t1,a7
    11ee:	02859813          	slli	a6,a1,0x28
    11f2:	40f60333          	sub	t1,a2,a5
    11f6:	0108e833          	or	a6,a7,a6
    11fa:	03059693          	slli	a3,a1,0x30
    11fe:	00d866b3          	or	a3,a6,a3
    1202:	03859713          	slli	a4,a1,0x38
    1206:	97aa                	add	a5,a5,a0
    1208:	ff837813          	andi	a6,t1,-8
    120c:	8f55                	or	a4,a4,a3
    120e:	00f806b3          	add	a3,a6,a5
    1212:	e398                	sd	a4,0(a5)
    1214:	07a1                	addi	a5,a5,8
    1216:	fed79ee3          	bne	a5,a3,1212 <memset+0xc4>
    121a:	ff837693          	andi	a3,t1,-8
    121e:	00de87b3          	add	a5,t4,a3
    1222:	01e6873b          	addw	a4,a3,t5
    1226:	0ad30663          	beq	t1,a3,12d2 <memset+0x184>
    122a:	00b78023          	sb	a1,0(a5)
    122e:	0017069b          	addiw	a3,a4,1
    1232:	08c6fb63          	bgeu	a3,a2,12c8 <memset+0x17a>
    1236:	00b780a3          	sb	a1,1(a5)
    123a:	0027069b          	addiw	a3,a4,2
    123e:	08c6f563          	bgeu	a3,a2,12c8 <memset+0x17a>
    1242:	00b78123          	sb	a1,2(a5)
    1246:	0037069b          	addiw	a3,a4,3
    124a:	06c6ff63          	bgeu	a3,a2,12c8 <memset+0x17a>
    124e:	00b781a3          	sb	a1,3(a5)
    1252:	0047069b          	addiw	a3,a4,4
    1256:	06c6f963          	bgeu	a3,a2,12c8 <memset+0x17a>
    125a:	00b78223          	sb	a1,4(a5)
    125e:	0057069b          	addiw	a3,a4,5
    1262:	06c6f363          	bgeu	a3,a2,12c8 <memset+0x17a>
    1266:	00b782a3          	sb	a1,5(a5)
    126a:	0067069b          	addiw	a3,a4,6
    126e:	04c6fd63          	bgeu	a3,a2,12c8 <memset+0x17a>
    1272:	00b78323          	sb	a1,6(a5)
    1276:	0077069b          	addiw	a3,a4,7
    127a:	04c6f763          	bgeu	a3,a2,12c8 <memset+0x17a>
    127e:	00b783a3          	sb	a1,7(a5)
    1282:	0087069b          	addiw	a3,a4,8
    1286:	04c6f163          	bgeu	a3,a2,12c8 <memset+0x17a>
    128a:	00b78423          	sb	a1,8(a5)
    128e:	0097069b          	addiw	a3,a4,9
    1292:	02c6fb63          	bgeu	a3,a2,12c8 <memset+0x17a>
    1296:	00b784a3          	sb	a1,9(a5)
    129a:	00a7069b          	addiw	a3,a4,10
    129e:	02c6f563          	bgeu	a3,a2,12c8 <memset+0x17a>
    12a2:	00b78523          	sb	a1,10(a5)
    12a6:	00b7069b          	addiw	a3,a4,11
    12aa:	00c6ff63          	bgeu	a3,a2,12c8 <memset+0x17a>
    12ae:	00b785a3          	sb	a1,11(a5)
    12b2:	00c7069b          	addiw	a3,a4,12
    12b6:	00c6f963          	bgeu	a3,a2,12c8 <memset+0x17a>
    12ba:	00b78623          	sb	a1,12(a5)
    12be:	2735                	addiw	a4,a4,13
    12c0:	00c77463          	bgeu	a4,a2,12c8 <memset+0x17a>
    12c4:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    12c8:	8082                	ret
    12ca:	472d                	li	a4,11
    12cc:	bd79                	j	116a <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    12ce:	4f0d                	li	t5,3
    12d0:	b701                	j	11d0 <memset+0x82>
    12d2:	8082                	ret
    12d4:	4f05                	li	t5,1
    12d6:	bded                	j	11d0 <memset+0x82>
    12d8:	8eaa                	mv	t4,a0
    12da:	4f01                	li	t5,0
    12dc:	bdd5                	j	11d0 <memset+0x82>
    12de:	87aa                	mv	a5,a0
    12e0:	4701                	li	a4,0
    12e2:	b7a1                	j	122a <memset+0xdc>
    12e4:	4f09                	li	t5,2
    12e6:	b5ed                	j	11d0 <memset+0x82>
    12e8:	4f11                	li	t5,4
    12ea:	b5dd                	j	11d0 <memset+0x82>
    12ec:	4f15                	li	t5,5
    12ee:	b5cd                	j	11d0 <memset+0x82>
    12f0:	4f19                	li	t5,6
    12f2:	bdf9                	j	11d0 <memset+0x82>

00000000000012f4 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    12f4:	00054783          	lbu	a5,0(a0)
    12f8:	0005c703          	lbu	a4,0(a1)
    12fc:	00e79863          	bne	a5,a4,130c <strcmp+0x18>
    1300:	0505                	addi	a0,a0,1
    1302:	0585                	addi	a1,a1,1
    1304:	fbe5                	bnez	a5,12f4 <strcmp>
    1306:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    1308:	9d19                	subw	a0,a0,a4
    130a:	8082                	ret
    130c:	0007851b          	sext.w	a0,a5
    1310:	bfe5                	j	1308 <strcmp+0x14>

0000000000001312 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1312:	87aa                	mv	a5,a0
    1314:	0005c703          	lbu	a4,0(a1)
    1318:	0785                	addi	a5,a5,1
    131a:	0585                	addi	a1,a1,1
    131c:	fee78fa3          	sb	a4,-1(a5)
    1320:	fb75                	bnez	a4,1314 <strcpy+0x2>
        ;
    return os;
}
    1322:	8082                	ret

0000000000001324 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    1324:	ce05                	beqz	a2,135c <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1326:	00054703          	lbu	a4,0(a0)
    132a:	0005c783          	lbu	a5,0(a1)
    132e:	cb0d                	beqz	a4,1360 <strncmp+0x3c>
    if (!n--)
    1330:	167d                	addi	a2,a2,-1
    1332:	00c506b3          	add	a3,a0,a2
    1336:	a819                	j	134c <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1338:	00a68e63          	beq	a3,a0,1354 <strncmp+0x30>
    133c:	0505                	addi	a0,a0,1
    133e:	00e79b63          	bne	a5,a4,1354 <strncmp+0x30>
    1342:	00054703          	lbu	a4,0(a0)
    1346:	0005c783          	lbu	a5,0(a1)
    134a:	cb19                	beqz	a4,1360 <strncmp+0x3c>
    134c:	0005c783          	lbu	a5,0(a1)
    1350:	0585                	addi	a1,a1,1
    1352:	f3fd                	bnez	a5,1338 <strncmp+0x14>
        ;
    return *l - *r;
    1354:	0007051b          	sext.w	a0,a4
    1358:	9d1d                	subw	a0,a0,a5
    135a:	8082                	ret
        return 0;
    135c:	4501                	li	a0,0
}
    135e:	8082                	ret
    1360:	4501                	li	a0,0
    return *l - *r;
    1362:	9d1d                	subw	a0,a0,a5
    1364:	8082                	ret

0000000000001366 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    1366:	00757793          	andi	a5,a0,7
    136a:	cf89                	beqz	a5,1384 <strlen+0x1e>
    136c:	87aa                	mv	a5,a0
    136e:	a029                	j	1378 <strlen+0x12>
    1370:	0785                	addi	a5,a5,1
    1372:	0077f713          	andi	a4,a5,7
    1376:	cb01                	beqz	a4,1386 <strlen+0x20>
        if (!*s)
    1378:	0007c703          	lbu	a4,0(a5)
    137c:	fb75                	bnez	a4,1370 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    137e:	40a78533          	sub	a0,a5,a0
}
    1382:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1384:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    1386:	6394                	ld	a3,0(a5)
    1388:	00000597          	auipc	a1,0x0
    138c:	6285b583          	ld	a1,1576(a1) # 19b0 <sharedmem+0x1c>
    1390:	00000617          	auipc	a2,0x0
    1394:	62863603          	ld	a2,1576(a2) # 19b8 <sharedmem+0x24>
    1398:	a019                	j	139e <strlen+0x38>
    139a:	6794                	ld	a3,8(a5)
    139c:	07a1                	addi	a5,a5,8
    139e:	00b68733          	add	a4,a3,a1
    13a2:	fff6c693          	not	a3,a3
    13a6:	8f75                	and	a4,a4,a3
    13a8:	8f71                	and	a4,a4,a2
    13aa:	db65                	beqz	a4,139a <strlen+0x34>
    for (; *s; s++)
    13ac:	0007c703          	lbu	a4,0(a5)
    13b0:	d779                	beqz	a4,137e <strlen+0x18>
    13b2:	0017c703          	lbu	a4,1(a5)
    13b6:	0785                	addi	a5,a5,1
    13b8:	d379                	beqz	a4,137e <strlen+0x18>
    13ba:	0017c703          	lbu	a4,1(a5)
    13be:	0785                	addi	a5,a5,1
    13c0:	fb6d                	bnez	a4,13b2 <strlen+0x4c>
    13c2:	bf75                	j	137e <strlen+0x18>

00000000000013c4 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    13c4:	00757713          	andi	a4,a0,7
{
    13c8:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    13ca:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    13ce:	cb19                	beqz	a4,13e4 <memchr+0x20>
    13d0:	ce25                	beqz	a2,1448 <memchr+0x84>
    13d2:	0007c703          	lbu	a4,0(a5)
    13d6:	04b70e63          	beq	a4,a1,1432 <memchr+0x6e>
    13da:	0785                	addi	a5,a5,1
    13dc:	0077f713          	andi	a4,a5,7
    13e0:	167d                	addi	a2,a2,-1
    13e2:	f77d                	bnez	a4,13d0 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    13e4:	4501                	li	a0,0
    if (n && *s != c) {
    13e6:	c235                	beqz	a2,144a <memchr+0x86>
    13e8:	0007c703          	lbu	a4,0(a5)
    13ec:	04b70363          	beq	a4,a1,1432 <memchr+0x6e>
        size_t k = ONES * c;
    13f0:	00000517          	auipc	a0,0x0
    13f4:	5d053503          	ld	a0,1488(a0) # 19c0 <sharedmem+0x2c>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    13f8:	471d                	li	a4,7
        size_t k = ONES * c;
    13fa:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    13fe:	02c77a63          	bgeu	a4,a2,1432 <memchr+0x6e>
    1402:	00000897          	auipc	a7,0x0
    1406:	5ae8b883          	ld	a7,1454(a7) # 19b0 <sharedmem+0x1c>
    140a:	00000817          	auipc	a6,0x0
    140e:	5ae83803          	ld	a6,1454(a6) # 19b8 <sharedmem+0x24>
    1412:	431d                	li	t1,7
    1414:	a029                	j	141e <memchr+0x5a>
    1416:	1661                	addi	a2,a2,-8
    1418:	07a1                	addi	a5,a5,8
    141a:	02c37963          	bgeu	t1,a2,144c <memchr+0x88>
    141e:	6398                	ld	a4,0(a5)
    1420:	8f29                	xor	a4,a4,a0
    1422:	011706b3          	add	a3,a4,a7
    1426:	fff74713          	not	a4,a4
    142a:	8f75                	and	a4,a4,a3
    142c:	01077733          	and	a4,a4,a6
    1430:	d37d                	beqz	a4,1416 <memchr+0x52>
    1432:	853e                	mv	a0,a5
    1434:	97b2                	add	a5,a5,a2
    1436:	a021                	j	143e <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1438:	0505                	addi	a0,a0,1
    143a:	00f50763          	beq	a0,a5,1448 <memchr+0x84>
    143e:	00054703          	lbu	a4,0(a0)
    1442:	feb71be3          	bne	a4,a1,1438 <memchr+0x74>
    1446:	8082                	ret
    return n ? (void*)s : 0;
    1448:	4501                	li	a0,0
}
    144a:	8082                	ret
    return n ? (void*)s : 0;
    144c:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    144e:	f275                	bnez	a2,1432 <memchr+0x6e>
}
    1450:	8082                	ret

0000000000001452 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1452:	1101                	addi	sp,sp,-32
    1454:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1456:	862e                	mv	a2,a1
{
    1458:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    145a:	4581                	li	a1,0
{
    145c:	e426                	sd	s1,8(sp)
    145e:	ec06                	sd	ra,24(sp)
    1460:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1462:	f63ff0ef          	jal	ra,13c4 <memchr>
    return p ? p - s : n;
    1466:	c519                	beqz	a0,1474 <strnlen+0x22>
}
    1468:	60e2                	ld	ra,24(sp)
    146a:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    146c:	8d05                	sub	a0,a0,s1
}
    146e:	64a2                	ld	s1,8(sp)
    1470:	6105                	addi	sp,sp,32
    1472:	8082                	ret
    1474:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1476:	8522                	mv	a0,s0
}
    1478:	6442                	ld	s0,16(sp)
    147a:	64a2                	ld	s1,8(sp)
    147c:	6105                	addi	sp,sp,32
    147e:	8082                	ret

0000000000001480 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1480:	00b547b3          	xor	a5,a0,a1
    1484:	8b9d                	andi	a5,a5,7
    1486:	eb95                	bnez	a5,14ba <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1488:	0075f793          	andi	a5,a1,7
    148c:	e7b1                	bnez	a5,14d8 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    148e:	6198                	ld	a4,0(a1)
    1490:	00000617          	auipc	a2,0x0
    1494:	52063603          	ld	a2,1312(a2) # 19b0 <sharedmem+0x1c>
    1498:	00000817          	auipc	a6,0x0
    149c:	52083803          	ld	a6,1312(a6) # 19b8 <sharedmem+0x24>
    14a0:	a029                	j	14aa <stpcpy+0x2a>
    14a2:	e118                	sd	a4,0(a0)
    14a4:	6598                	ld	a4,8(a1)
    14a6:	05a1                	addi	a1,a1,8
    14a8:	0521                	addi	a0,a0,8
    14aa:	00c707b3          	add	a5,a4,a2
    14ae:	fff74693          	not	a3,a4
    14b2:	8ff5                	and	a5,a5,a3
    14b4:	0107f7b3          	and	a5,a5,a6
    14b8:	d7ed                	beqz	a5,14a2 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    14ba:	0005c783          	lbu	a5,0(a1)
    14be:	00f50023          	sb	a5,0(a0)
    14c2:	c785                	beqz	a5,14ea <stpcpy+0x6a>
    14c4:	0015c783          	lbu	a5,1(a1)
    14c8:	0505                	addi	a0,a0,1
    14ca:	0585                	addi	a1,a1,1
    14cc:	00f50023          	sb	a5,0(a0)
    14d0:	fbf5                	bnez	a5,14c4 <stpcpy+0x44>
        ;
    return d;
}
    14d2:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    14d4:	0505                	addi	a0,a0,1
    14d6:	df45                	beqz	a4,148e <stpcpy+0xe>
            if (!(*d = *s))
    14d8:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    14dc:	0585                	addi	a1,a1,1
    14de:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    14e2:	00f50023          	sb	a5,0(a0)
    14e6:	f7fd                	bnez	a5,14d4 <stpcpy+0x54>
}
    14e8:	8082                	ret
    14ea:	8082                	ret

00000000000014ec <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    14ec:	00b547b3          	xor	a5,a0,a1
    14f0:	8b9d                	andi	a5,a5,7
    14f2:	1a079863          	bnez	a5,16a2 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    14f6:	0075f793          	andi	a5,a1,7
    14fa:	16078463          	beqz	a5,1662 <stpncpy+0x176>
    14fe:	ea01                	bnez	a2,150e <stpncpy+0x22>
    1500:	a421                	j	1708 <stpncpy+0x21c>
    1502:	167d                	addi	a2,a2,-1
    1504:	0505                	addi	a0,a0,1
    1506:	14070e63          	beqz	a4,1662 <stpncpy+0x176>
    150a:	1a060863          	beqz	a2,16ba <stpncpy+0x1ce>
    150e:	0005c783          	lbu	a5,0(a1)
    1512:	0585                	addi	a1,a1,1
    1514:	0075f713          	andi	a4,a1,7
    1518:	00f50023          	sb	a5,0(a0)
    151c:	f3fd                	bnez	a5,1502 <stpncpy+0x16>
    151e:	4805                	li	a6,1
    1520:	1a061863          	bnez	a2,16d0 <stpncpy+0x1e4>
    1524:	40a007b3          	neg	a5,a0
    1528:	8b9d                	andi	a5,a5,7
    152a:	4681                	li	a3,0
    152c:	18061a63          	bnez	a2,16c0 <stpncpy+0x1d4>
    1530:	00778713          	addi	a4,a5,7
    1534:	45ad                	li	a1,11
    1536:	18b76363          	bltu	a4,a1,16bc <stpncpy+0x1d0>
    153a:	1ae6eb63          	bltu	a3,a4,16f0 <stpncpy+0x204>
    153e:	1a078363          	beqz	a5,16e4 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1542:	00050023          	sb	zero,0(a0)
    1546:	4685                	li	a3,1
    1548:	00150713          	addi	a4,a0,1
    154c:	18d78f63          	beq	a5,a3,16ea <stpncpy+0x1fe>
    1550:	000500a3          	sb	zero,1(a0)
    1554:	4689                	li	a3,2
    1556:	00250713          	addi	a4,a0,2
    155a:	18d78e63          	beq	a5,a3,16f6 <stpncpy+0x20a>
    155e:	00050123          	sb	zero,2(a0)
    1562:	468d                	li	a3,3
    1564:	00350713          	addi	a4,a0,3
    1568:	16d78c63          	beq	a5,a3,16e0 <stpncpy+0x1f4>
    156c:	000501a3          	sb	zero,3(a0)
    1570:	4691                	li	a3,4
    1572:	00450713          	addi	a4,a0,4
    1576:	18d78263          	beq	a5,a3,16fa <stpncpy+0x20e>
    157a:	00050223          	sb	zero,4(a0)
    157e:	4695                	li	a3,5
    1580:	00550713          	addi	a4,a0,5
    1584:	16d78d63          	beq	a5,a3,16fe <stpncpy+0x212>
    1588:	000502a3          	sb	zero,5(a0)
    158c:	469d                	li	a3,7
    158e:	00650713          	addi	a4,a0,6
    1592:	16d79863          	bne	a5,a3,1702 <stpncpy+0x216>
    1596:	00750713          	addi	a4,a0,7
    159a:	00050323          	sb	zero,6(a0)
    159e:	40f80833          	sub	a6,a6,a5
    15a2:	ff887593          	andi	a1,a6,-8
    15a6:	97aa                	add	a5,a5,a0
    15a8:	95be                	add	a1,a1,a5
    15aa:	0007b023          	sd	zero,0(a5)
    15ae:	07a1                	addi	a5,a5,8
    15b0:	feb79de3          	bne	a5,a1,15aa <stpncpy+0xbe>
    15b4:	ff887593          	andi	a1,a6,-8
    15b8:	9ead                	addw	a3,a3,a1
    15ba:	00b707b3          	add	a5,a4,a1
    15be:	12b80863          	beq	a6,a1,16ee <stpncpy+0x202>
    15c2:	00078023          	sb	zero,0(a5)
    15c6:	0016871b          	addiw	a4,a3,1
    15ca:	0ec77863          	bgeu	a4,a2,16ba <stpncpy+0x1ce>
    15ce:	000780a3          	sb	zero,1(a5)
    15d2:	0026871b          	addiw	a4,a3,2
    15d6:	0ec77263          	bgeu	a4,a2,16ba <stpncpy+0x1ce>
    15da:	00078123          	sb	zero,2(a5)
    15de:	0036871b          	addiw	a4,a3,3
    15e2:	0cc77c63          	bgeu	a4,a2,16ba <stpncpy+0x1ce>
    15e6:	000781a3          	sb	zero,3(a5)
    15ea:	0046871b          	addiw	a4,a3,4
    15ee:	0cc77663          	bgeu	a4,a2,16ba <stpncpy+0x1ce>
    15f2:	00078223          	sb	zero,4(a5)
    15f6:	0056871b          	addiw	a4,a3,5
    15fa:	0cc77063          	bgeu	a4,a2,16ba <stpncpy+0x1ce>
    15fe:	000782a3          	sb	zero,5(a5)
    1602:	0066871b          	addiw	a4,a3,6
    1606:	0ac77a63          	bgeu	a4,a2,16ba <stpncpy+0x1ce>
    160a:	00078323          	sb	zero,6(a5)
    160e:	0076871b          	addiw	a4,a3,7
    1612:	0ac77463          	bgeu	a4,a2,16ba <stpncpy+0x1ce>
    1616:	000783a3          	sb	zero,7(a5)
    161a:	0086871b          	addiw	a4,a3,8
    161e:	08c77e63          	bgeu	a4,a2,16ba <stpncpy+0x1ce>
    1622:	00078423          	sb	zero,8(a5)
    1626:	0096871b          	addiw	a4,a3,9
    162a:	08c77863          	bgeu	a4,a2,16ba <stpncpy+0x1ce>
    162e:	000784a3          	sb	zero,9(a5)
    1632:	00a6871b          	addiw	a4,a3,10
    1636:	08c77263          	bgeu	a4,a2,16ba <stpncpy+0x1ce>
    163a:	00078523          	sb	zero,10(a5)
    163e:	00b6871b          	addiw	a4,a3,11
    1642:	06c77c63          	bgeu	a4,a2,16ba <stpncpy+0x1ce>
    1646:	000785a3          	sb	zero,11(a5)
    164a:	00c6871b          	addiw	a4,a3,12
    164e:	06c77663          	bgeu	a4,a2,16ba <stpncpy+0x1ce>
    1652:	00078623          	sb	zero,12(a5)
    1656:	26b5                	addiw	a3,a3,13
    1658:	06c6f163          	bgeu	a3,a2,16ba <stpncpy+0x1ce>
    165c:	000786a3          	sb	zero,13(a5)
    1660:	8082                	ret
            ;
        if (!n || !*s)
    1662:	c645                	beqz	a2,170a <stpncpy+0x21e>
    1664:	0005c783          	lbu	a5,0(a1)
    1668:	ea078be3          	beqz	a5,151e <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    166c:	479d                	li	a5,7
    166e:	02c7ff63          	bgeu	a5,a2,16ac <stpncpy+0x1c0>
    1672:	00000897          	auipc	a7,0x0
    1676:	33e8b883          	ld	a7,830(a7) # 19b0 <sharedmem+0x1c>
    167a:	00000817          	auipc	a6,0x0
    167e:	33e83803          	ld	a6,830(a6) # 19b8 <sharedmem+0x24>
    1682:	431d                	li	t1,7
    1684:	6198                	ld	a4,0(a1)
    1686:	011707b3          	add	a5,a4,a7
    168a:	fff74693          	not	a3,a4
    168e:	8ff5                	and	a5,a5,a3
    1690:	0107f7b3          	and	a5,a5,a6
    1694:	ef81                	bnez	a5,16ac <stpncpy+0x1c0>
            *wd = *ws;
    1696:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1698:	1661                	addi	a2,a2,-8
    169a:	05a1                	addi	a1,a1,8
    169c:	0521                	addi	a0,a0,8
    169e:	fec363e3          	bltu	t1,a2,1684 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    16a2:	e609                	bnez	a2,16ac <stpncpy+0x1c0>
    16a4:	a08d                	j	1706 <stpncpy+0x21a>
    16a6:	167d                	addi	a2,a2,-1
    16a8:	0505                	addi	a0,a0,1
    16aa:	ca01                	beqz	a2,16ba <stpncpy+0x1ce>
    16ac:	0005c783          	lbu	a5,0(a1)
    16b0:	0585                	addi	a1,a1,1
    16b2:	00f50023          	sb	a5,0(a0)
    16b6:	fbe5                	bnez	a5,16a6 <stpncpy+0x1ba>
        ;
tail:
    16b8:	b59d                	j	151e <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    16ba:	8082                	ret
    16bc:	472d                	li	a4,11
    16be:	bdb5                	j	153a <stpncpy+0x4e>
    16c0:	00778713          	addi	a4,a5,7
    16c4:	45ad                	li	a1,11
    16c6:	fff60693          	addi	a3,a2,-1
    16ca:	e6b778e3          	bgeu	a4,a1,153a <stpncpy+0x4e>
    16ce:	b7fd                	j	16bc <stpncpy+0x1d0>
    16d0:	40a007b3          	neg	a5,a0
    16d4:	8832                	mv	a6,a2
    16d6:	8b9d                	andi	a5,a5,7
    16d8:	4681                	li	a3,0
    16da:	e4060be3          	beqz	a2,1530 <stpncpy+0x44>
    16de:	b7cd                	j	16c0 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    16e0:	468d                	li	a3,3
    16e2:	bd75                	j	159e <stpncpy+0xb2>
    16e4:	872a                	mv	a4,a0
    16e6:	4681                	li	a3,0
    16e8:	bd5d                	j	159e <stpncpy+0xb2>
    16ea:	4685                	li	a3,1
    16ec:	bd4d                	j	159e <stpncpy+0xb2>
    16ee:	8082                	ret
    16f0:	87aa                	mv	a5,a0
    16f2:	4681                	li	a3,0
    16f4:	b5f9                	j	15c2 <stpncpy+0xd6>
    16f6:	4689                	li	a3,2
    16f8:	b55d                	j	159e <stpncpy+0xb2>
    16fa:	4691                	li	a3,4
    16fc:	b54d                	j	159e <stpncpy+0xb2>
    16fe:	4695                	li	a3,5
    1700:	bd79                	j	159e <stpncpy+0xb2>
    1702:	4699                	li	a3,6
    1704:	bd69                	j	159e <stpncpy+0xb2>
    1706:	8082                	ret
    1708:	8082                	ret
    170a:	8082                	ret

000000000000170c <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    170c:	fff6071b          	addiw	a4,a2,-1
    1710:	0cb57063          	bgeu	a0,a1,17d0 <memmove+0xc4>
        while (n-- > 0)
    1714:	0ec05063          	blez	a2,17f4 <memmove+0xe8>
    1718:	00750693          	addi	a3,a0,7
    171c:	8e8d                	sub	a3,a3,a1
    171e:	00b567b3          	or	a5,a0,a1
    1722:	00f6b693          	sltiu	a3,a3,15
    1726:	8b9d                	andi	a5,a5,7
    1728:	0016c693          	xori	a3,a3,1
    172c:	0017b793          	seqz	a5,a5
    1730:	8ff5                	and	a5,a5,a3
    1732:	c3f1                	beqz	a5,17f6 <memmove+0xea>
    1734:	0007079b          	sext.w	a5,a4
    1738:	46a5                	li	a3,9
    173a:	0af6fe63          	bgeu	a3,a5,17f6 <memmove+0xea>
    173e:	0036589b          	srliw	a7,a2,0x3
    1742:	088e                	slli	a7,a7,0x3
    1744:	2601                	sext.w	a2,a2
    1746:	87ae                	mv	a5,a1
    1748:	86aa                	mv	a3,a0
    174a:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    174c:	0007b803          	ld	a6,0(a5)
    1750:	07a1                	addi	a5,a5,8
    1752:	06a1                	addi	a3,a3,8
    1754:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1758:	ff179ae3          	bne	a5,a7,174c <memmove+0x40>
    175c:	ff867813          	andi	a6,a2,-8
    1760:	02081793          	slli	a5,a6,0x20
    1764:	9381                	srli	a5,a5,0x20
    1766:	00f506b3          	add	a3,a0,a5
    176a:	95be                	add	a1,a1,a5
    176c:	4107073b          	subw	a4,a4,a6
    1770:	09060263          	beq	a2,a6,17f4 <memmove+0xe8>
            *dst++ = *src++;
    1774:	0005c783          	lbu	a5,0(a1)
    1778:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    177c:	06e05c63          	blez	a4,17f4 <memmove+0xe8>
            *dst++ = *src++;
    1780:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1784:	4785                	li	a5,1
            *dst++ = *src++;
    1786:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    178a:	06e7d563          	bge	a5,a4,17f4 <memmove+0xe8>
            *dst++ = *src++;
    178e:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1792:	4789                	li	a5,2
            *dst++ = *src++;
    1794:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1798:	04e7de63          	bge	a5,a4,17f4 <memmove+0xe8>
            *dst++ = *src++;
    179c:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    17a0:	478d                	li	a5,3
            *dst++ = *src++;
    17a2:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    17a6:	04e7d763          	bge	a5,a4,17f4 <memmove+0xe8>
            *dst++ = *src++;
    17aa:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    17ae:	4791                	li	a5,4
            *dst++ = *src++;
    17b0:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    17b4:	04e7d063          	bge	a5,a4,17f4 <memmove+0xe8>
            *dst++ = *src++;
    17b8:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    17bc:	4795                	li	a5,5
            *dst++ = *src++;
    17be:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    17c2:	02e7d963          	bge	a5,a4,17f4 <memmove+0xe8>
            *dst++ = *src++;
    17c6:	0065c783          	lbu	a5,6(a1)
    17ca:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    17ce:	8082                	ret
    } else {
        dst += n;
    17d0:	00c507b3          	add	a5,a0,a2
        src += n;
    17d4:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    17d6:	00c05f63          	blez	a2,17f4 <memmove+0xe8>
    17da:	1702                	slli	a4,a4,0x20
    17dc:	9301                	srli	a4,a4,0x20
    17de:	fff74713          	not	a4,a4
    17e2:	973e                	add	a4,a4,a5
            *--dst = *--src;
    17e4:	fff5c683          	lbu	a3,-1(a1)
    17e8:	17fd                	addi	a5,a5,-1
    17ea:	15fd                	addi	a1,a1,-1
    17ec:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    17f0:	fee79ae3          	bne	a5,a4,17e4 <memmove+0xd8>
    }
    return vdst;
}
    17f4:	8082                	ret
    17f6:	02071693          	slli	a3,a4,0x20
    17fa:	9281                	srli	a3,a3,0x20
    17fc:	0685                	addi	a3,a3,1
    17fe:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1800:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1802:	0005c703          	lbu	a4,0(a1)
    1806:	0585                	addi	a1,a1,1
    1808:	0785                	addi	a5,a5,1
    180a:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    180e:	fed59ae3          	bne	a1,a3,1802 <memmove+0xf6>
    1812:	8082                	ret

0000000000001814 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1814:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1818:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    181c:	2501                	sext.w	a0,a0
    181e:	8082                	ret

0000000000001820 <exec>:
    register long a7 __asm__("a7") = n;
    1820:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1824:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1826:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    182a:	2501                	sext.w	a0,a0
    182c:	8082                	ret

000000000000182e <exit>:
    register long a7 __asm__("a7") = n;
    182e:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1832:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1836:	8082                	ret

0000000000001838 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1838:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    183c:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1840:	8082                	ret

0000000000001842 <write>:
    register long a7 __asm__("a7") = n;
    1842:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1846:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    184a:	8082                	ret

000000000000184c <getpid>:
    register long a7 __asm__("a7") = n;
    184c:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1850:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1854:	2501                	sext.w	a0,a0
    1856:	8082                	ret

0000000000001858 <getppid>:
    register long a7 __asm__("a7") = n;
    1858:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    185c:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1860:	2501                	sext.w	a0,a0
    1862:	8082                	ret

0000000000001864 <open>:
    register long a7 __asm__("a7") = n;
    1864:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1868:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    186c:	2501                	sext.w	a0,a0
    186e:	8082                	ret

0000000000001870 <mknod>:
    register long a7 __asm__("a7") = n;
    1870:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1874:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1878:	2501                	sext.w	a0,a0
    187a:	8082                	ret

000000000000187c <dup>:
    register long a7 __asm__("a7") = n;
    187c:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    187e:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1882:	2501                	sext.w	a0,a0
    1884:	8082                	ret

0000000000001886 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1886:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    188a:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    188e:	2501                	sext.w	a0,a0
    1890:	8082                	ret

0000000000001892 <waitpid>:
    register long a7 __asm__("a7") = n;
    1892:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1896:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    189a:	2501                	sext.w	a0,a0
    189c:	8082                	ret

000000000000189e <wait>:

pid_t wait(int *wstatus)
{
    189e:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    18a0:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    18a4:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    18a6:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    18aa:	2501                	sext.w	a0,a0
    18ac:	8082                	ret

00000000000018ae <mkdir>:
    register long a7 __asm__("a7") = n;
    18ae:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    18b2:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    18b6:	2501                	sext.w	a0,a0
    18b8:	8082                	ret

00000000000018ba <close>:
    register long a7 __asm__("a7") = n;
    18ba:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    18be:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    18c2:	2501                	sext.w	a0,a0
    18c4:	8082                	ret

00000000000018c6 <fork>:
    register long a7 __asm__("a7") = n;
    18c6:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    18ca:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    18ce:	2501                	sext.w	a0,a0
    18d0:	8082                	ret

00000000000018d2 <time_ms>:
    register long a7 __asm__("a7") = n;
    18d2:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    18d6:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    18da:	8082                	ret

00000000000018dc <sleep>:

int sleep(unsigned long long time_in_ms)
{
    18dc:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    18de:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    18e2:	00000073          	ecall
    18e6:	87aa                	mv	a5,a0
    18e8:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    18ec:	97ba                	add	a5,a5,a4
    18ee:	00f57c63          	bgeu	a0,a5,1906 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    18f2:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    18f6:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    18fa:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    18fe:	00000073          	ecall
    1902:	fef568e3          	bltu	a0,a5,18f2 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1906:	4501                	li	a0,0
    1908:	8082                	ret

000000000000190a <pipe>:
    register long a7 __asm__("a7") = n;
    190a:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    190e:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1912:	2501                	sext.w	a0,a0
    1914:	8082                	ret

0000000000001916 <fstat>:
    register long a7 __asm__("a7") = n;
    1916:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    191a:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    191e:	2501                	sext.w	a0,a0
    1920:	8082                	ret

0000000000001922 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    1922:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    1924:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    1928:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    192a:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    192e:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    1932:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    1936:	0206c163          	bltz	a3,1958 <stat+0x36>
    register long a7 __asm__("a7") = n;
    193a:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    193e:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    1940:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1942:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1946:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    194a:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    194e:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    1950:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    1954:	853e                	mv	a0,a5
    1956:	8082                	ret
        return -1;
    1958:	57fd                	li	a5,-1
    195a:	bfed                	j	1954 <stat+0x32>

000000000000195c <chdir>:
    register long a7 __asm__("a7") = n;
    195c:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    1960:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    1964:	2501                	sext.w	a0,a0
    1966:	8082                	ret

0000000000001968 <link>:
    register long a7 __asm__("a7") = n;
    1968:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    196c:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    1970:	2501                	sext.w	a0,a0
    1972:	8082                	ret

0000000000001974 <unlink>:
    register long a7 __asm__("a7") = n;
    1974:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    1978:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    197c:	2501                	sext.w	a0,a0
    197e:	8082                	ret

0000000000001980 <setpriority>:
    register long a7 __asm__("a7") = n;
    1980:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    1984:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    1988:	8082                	ret

000000000000198a <getpriority>:
    register long a7 __asm__("a7") = n;
    198a:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    198e:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    1992:	8082                	ret

0000000000001994 <sharedmem>:
    register long a7 __asm__("a7") = n;
    1994:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1998:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    199c:	8082                	ret
