
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_shmem1:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a659                	j	1386 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <ucore.h>
#include <string.h>
#include <fcntl.h>

int main(int argc, char *argv[])
{
    1002:	1101                	addi	sp,sp,-32
    void *shmem1 = sharedmem("shmem1", 8192);
    1004:	6589                	lui	a1,0x2
    1006:	00001517          	auipc	a0,0x1
    100a:	08250513          	addi	a0,a0,130 # 2088 <sharedmem+0xe>
{
    100e:	ec06                	sd	ra,24(sp)
    1010:	e822                	sd	s0,16(sp)
    1012:	e426                	sd	s1,8(sp)
    1014:	e04a                	sd	s2,0(sp)
    void *shmem1 = sharedmem("shmem1", 8192);
    1016:	064010ef          	jal	ra,207a <sharedmem>
    101a:	84aa                	mv	s1,a0
    sleep(1000);
    101c:	3e800513          	li	a0,1000
    1020:	7a3000ef          	jal	ra,1fc2 <sleep>
    void *shmem2 = sharedmem("shmem2", 0);
    1024:	4581                	li	a1,0
    1026:	00001517          	auipc	a0,0x1
    102a:	06a50513          	addi	a0,a0,106 # 2090 <sharedmem+0x16>
    102e:	04c010ef          	jal	ra,207a <sharedmem>
    1032:	892a                	mv	s2,a0

    printf("[prog 1] shared mem 2 start: %p\n", shmem2);
    1034:	85ca                	mv	a1,s2
    1036:	00001517          	auipc	a0,0x1
    103a:	06250513          	addi	a0,a0,98 # 2098 <sharedmem+0x1e>
    103e:	3de000ef          	jal	ra,141c <printf>
    printf("[prog 1] shared mem 1 start: %p\n", shmem1);
    1042:	85a6                	mv	a1,s1
    1044:	00001517          	auipc	a0,0x1
    1048:	07c50513          	addi	a0,a0,124 # 20c0 <sharedmem+0x46>
    104c:	3d0000ef          	jal	ra,141c <printf>
    sleep(1000);
    1050:	3e800513          	li	a0,1000
    1054:	76f000ef          	jal	ra,1fc2 <sleep>

    char *buf = (char *)shmem1;
    for (int i = 0; i < 8192; i++)
    1058:	409007b3          	neg	a5,s1
    105c:	8b9d                	andi	a5,a5,7
    105e:	8426                	mv	s0,s1
    1060:	2c078363          	beqz	a5,1326 <main+0x324>
    {
        buf[i] = 1;
    1064:	4705                	li	a4,1
    1066:	00e48023          	sb	a4,0(s1)
    for (int i = 0; i < 8192; i++)
    106a:	4705                	li	a4,1
    106c:	2ae78863          	beq	a5,a4,131c <main+0x31a>
        buf[i] = 1;
    1070:	00e480a3          	sb	a4,1(s1)
    for (int i = 0; i < 8192; i++)
    1074:	4689                	li	a3,2
    1076:	2ad78b63          	beq	a5,a3,132c <main+0x32a>
        buf[i] = 1;
    107a:	00e48123          	sb	a4,2(s1)
    for (int i = 0; i < 8192; i++)
    107e:	468d                	li	a3,3
    1080:	2cd78563          	beq	a5,a3,134a <main+0x348>
        buf[i] = 1;
    1084:	00e481a3          	sb	a4,3(s1)
    for (int i = 0; i < 8192; i++)
    1088:	4691                	li	a3,4
    108a:	26d78c63          	beq	a5,a3,1302 <main+0x300>
        buf[i] = 1;
    108e:	00e48223          	sb	a4,4(s1)
    for (int i = 0; i < 8192; i++)
    1092:	4695                	li	a3,5
    1094:	2cd78a63          	beq	a5,a3,1368 <main+0x366>
        buf[i] = 1;
    1098:	00e482a3          	sb	a4,5(s1)
    for (int i = 0; i < 8192; i++)
    109c:	469d                	li	a3,7
    109e:	2cd79f63          	bne	a5,a3,137c <main+0x37a>
        buf[i] = 1;
    10a2:	6689                	lui	a3,0x2
    10a4:	00e48323          	sb	a4,6(s1)
    10a8:	ff968593          	addi	a1,a3,-7 # 1ff9 <pipe+0x9>
    for (int i = 0; i < 8192; i++)
    10ac:	451d                	li	a0,7
    10ae:	6709                	lui	a4,0x2
    10b0:	40f7063b          	subw	a2,a4,a5
    10b4:	0036571b          	srliw	a4,a2,0x3
    10b8:	97a6                	add	a5,a5,s1
    10ba:	070e                	slli	a4,a4,0x3
    10bc:	0006081b          	sext.w	a6,a2
    10c0:	973e                	add	a4,a4,a5
        buf[i] = 1;
    10c2:	00001697          	auipc	a3,0x1
    10c6:	0466b683          	ld	a3,70(a3) # 2108 <sharedmem+0x8e>
    10ca:	e394                	sd	a3,0(a5)
    for (int i = 0; i < 8192; i++)
    10cc:	07a1                	addi	a5,a5,8
    10ce:	fee79ee3          	bne	a5,a4,10ca <main+0xc8>
    10d2:	ff867713          	andi	a4,a2,-8
    10d6:	00a7063b          	addw	a2,a4,a0
    10da:	40e5853b          	subw	a0,a1,a4
    10de:	2701                	sext.w	a4,a4
    10e0:	87b2                	mv	a5,a2
    10e2:	06e80663          	beq	a6,a4,114e <main+0x14c>
        buf[i] = 1;
    10e6:	9626                	add	a2,a2,s1
    10e8:	4705                	li	a4,1
    10ea:	00e60023          	sb	a4,0(a2)
    for (int i = 0; i < 8192; i++)
    10ee:	fff5059b          	addiw	a1,a0,-1
    10f2:	0017861b          	addiw	a2,a5,1
    10f6:	cda1                	beqz	a1,114e <main+0x14c>
        buf[i] = 1;
    10f8:	9626                	add	a2,a2,s1
    10fa:	00e60023          	sb	a4,0(a2)
    for (int i = 0; i < 8192; i++)
    10fe:	ffe5059b          	addiw	a1,a0,-2
    1102:	0027861b          	addiw	a2,a5,2
    1106:	c5a1                	beqz	a1,114e <main+0x14c>
        buf[i] = 1;
    1108:	9626                	add	a2,a2,s1
    110a:	00e60023          	sb	a4,0(a2)
    for (int i = 0; i < 8192; i++)
    110e:	ffd5059b          	addiw	a1,a0,-3
    1112:	0037861b          	addiw	a2,a5,3
    1116:	cd85                	beqz	a1,114e <main+0x14c>
        buf[i] = 1;
    1118:	9626                	add	a2,a2,s1
    111a:	00e60023          	sb	a4,0(a2)
    for (int i = 0; i < 8192; i++)
    111e:	ffc5059b          	addiw	a1,a0,-4
    1122:	0047861b          	addiw	a2,a5,4
    1126:	c585                	beqz	a1,114e <main+0x14c>
        buf[i] = 1;
    1128:	9626                	add	a2,a2,s1
    112a:	00e60023          	sb	a4,0(a2)
    for (int i = 0; i < 8192; i++)
    112e:	ffb5069b          	addiw	a3,a0,-5
    1132:	0057861b          	addiw	a2,a5,5
    1136:	ce81                	beqz	a3,114e <main+0x14c>
        buf[i] = 1;
    1138:	00c486b3          	add	a3,s1,a2
    113c:	00e68023          	sb	a4,0(a3)
    for (int i = 0; i < 8192; i++)
    1140:	4699                	li	a3,6
    1142:	2799                	addiw	a5,a5,6
    1144:	00d50563          	beq	a0,a3,114e <main+0x14c>
        buf[i] = 1;
    1148:	97a6                	add	a5,a5,s1
    114a:	00e78023          	sb	a4,0(a5)
    }
    sleep(1000);
    114e:	3e800513          	li	a0,1000
    1152:	671000ef          	jal	ra,1fc2 <sleep>
    buf = (char *)shmem2;
    for (int i = 0; i < 8192; i++)
    1156:	412006b3          	neg	a3,s2
    115a:	8a9d                	andi	a3,a3,7
    115c:	1a068d63          	beqz	a3,1316 <main+0x314>
    {

        buf[i] += 1;
    1160:	00094783          	lbu	a5,0(s2)
    1164:	4705                	li	a4,1
    1166:	2785                	addiw	a5,a5,1
    1168:	00f90023          	sb	a5,0(s2)
    for (int i = 0; i < 8192; i++)
    116c:	1ae68063          	beq	a3,a4,130c <main+0x30a>
        buf[i] += 1;
    1170:	00194783          	lbu	a5,1(s2)
    1174:	4709                	li	a4,2
    1176:	2785                	addiw	a5,a5,1
    1178:	00f900a3          	sb	a5,1(s2)
    for (int i = 0; i < 8192; i++)
    117c:	1ae68d63          	beq	a3,a4,1336 <main+0x334>
        buf[i] += 1;
    1180:	00294783          	lbu	a5,2(s2)
    1184:	470d                	li	a4,3
    1186:	2785                	addiw	a5,a5,1
    1188:	00f90123          	sb	a5,2(s2)
    for (int i = 0; i < 8192; i++)
    118c:	1ae68a63          	beq	a3,a4,1340 <main+0x33e>
        buf[i] += 1;
    1190:	00394783          	lbu	a5,3(s2)
    1194:	4711                	li	a4,4
    1196:	2785                	addiw	a5,a5,1
    1198:	00f901a3          	sb	a5,3(s2)
    for (int i = 0; i < 8192; i++)
    119c:	1ae68c63          	beq	a3,a4,1354 <main+0x352>
        buf[i] += 1;
    11a0:	00494783          	lbu	a5,4(s2)
    11a4:	4715                	li	a4,5
    11a6:	2785                	addiw	a5,a5,1
    11a8:	00f90223          	sb	a5,4(s2)
    for (int i = 0; i < 8192; i++)
    11ac:	1ae68963          	beq	a3,a4,135e <main+0x35c>
        buf[i] += 1;
    11b0:	00594783          	lbu	a5,5(s2)
    11b4:	471d                	li	a4,7
    11b6:	2785                	addiw	a5,a5,1
    11b8:	00f902a3          	sb	a5,5(s2)
    for (int i = 0; i < 8192; i++)
    11bc:	1ae69b63          	bne	a3,a4,1372 <main+0x370>
        buf[i] += 1;
    11c0:	00694783          	lbu	a5,6(s2)
    11c4:	6709                	lui	a4,0x2
    11c6:	ff970e13          	addi	t3,a4,-7 # 1ff9 <pipe+0x9>
    11ca:	2785                	addiw	a5,a5,1
    11cc:	00f90323          	sb	a5,6(s2)
    for (int i = 0; i < 8192; i++)
    11d0:	4f1d                	li	t5,7
    11d2:	6789                	lui	a5,0x2
    11d4:	40d7833b          	subw	t1,a5,a3
    11d8:	0033551b          	srliw	a0,t1,0x3
    11dc:	96ca                	add	a3,a3,s2
    11de:	050e                	slli	a0,a0,0x3
    11e0:	00030e9b          	sext.w	t4,t1
    11e4:	9536                	add	a0,a0,a3
    11e6:	8636                	mv	a2,a3
    11e8:	00001597          	auipc	a1,0x1
    11ec:	f205b583          	ld	a1,-224(a1) # 2108 <sharedmem+0x8e>
    11f0:	00001897          	auipc	a7,0x1
    11f4:	f208b883          	ld	a7,-224(a7) # 2110 <sharedmem+0x96>
    11f8:	00001817          	auipc	a6,0x1
    11fc:	f2083803          	ld	a6,-224(a6) # 2118 <sharedmem+0x9e>
        buf[i] += 1;
    1200:	629c                	ld	a5,0(a3)
    1202:	0621                	addi	a2,a2,8
    1204:	06a1                	addi	a3,a3,8
    1206:	00b7c733          	xor	a4,a5,a1
    120a:	0107f7b3          	and	a5,a5,a6
    120e:	01177733          	and	a4,a4,a7
    1212:	97ae                	add	a5,a5,a1
    1214:	8fb9                	xor	a5,a5,a4
    1216:	fef63c23          	sd	a5,-8(a2)
    for (int i = 0; i < 8192; i++)
    121a:	fea693e3          	bne	a3,a0,1200 <main+0x1fe>
    121e:	ff837793          	andi	a5,t1,-8
    1222:	01e786bb          	addw	a3,a5,t5
    1226:	40fe083b          	subw	a6,t3,a5
    122a:	2781                	sext.w	a5,a5
    122c:	85b6                	mv	a1,a3
    122e:	08fe8c63          	beq	t4,a5,12c6 <main+0x2c4>
        buf[i] += 1;
    1232:	96ca                	add	a3,a3,s2
    1234:	0006c503          	lbu	a0,0(a3)
    for (int i = 0; i < 8192; i++)
    1238:	fff8079b          	addiw	a5,a6,-1
    123c:	0015861b          	addiw	a2,a1,1
        buf[i] += 1;
    1240:	2505                	addiw	a0,a0,1
    1242:	00a68023          	sb	a0,0(a3)
    for (int i = 0; i < 8192; i++)
    1246:	c3c1                	beqz	a5,12c6 <main+0x2c4>
        buf[i] += 1;
    1248:	00c906b3          	add	a3,s2,a2
    124c:	0006c503          	lbu	a0,0(a3)
    for (int i = 0; i < 8192; i++)
    1250:	ffe8079b          	addiw	a5,a6,-2
    1254:	0025861b          	addiw	a2,a1,2
        buf[i] += 1;
    1258:	2505                	addiw	a0,a0,1
    125a:	00a68023          	sb	a0,0(a3)
    for (int i = 0; i < 8192; i++)
    125e:	c7a5                	beqz	a5,12c6 <main+0x2c4>
        buf[i] += 1;
    1260:	964a                	add	a2,a2,s2
    1262:	00064503          	lbu	a0,0(a2)
    for (int i = 0; i < 8192; i++)
    1266:	ffd8079b          	addiw	a5,a6,-3
    126a:	0035869b          	addiw	a3,a1,3
        buf[i] += 1;
    126e:	2505                	addiw	a0,a0,1
    1270:	00a60023          	sb	a0,0(a2)
    for (int i = 0; i < 8192; i++)
    1274:	cba9                	beqz	a5,12c6 <main+0x2c4>
        buf[i] += 1;
    1276:	96ca                	add	a3,a3,s2
    1278:	0006c503          	lbu	a0,0(a3)
    for (int i = 0; i < 8192; i++)
    127c:	ffc8079b          	addiw	a5,a6,-4
    1280:	0045861b          	addiw	a2,a1,4
        buf[i] += 1;
    1284:	2505                	addiw	a0,a0,1
    1286:	00a68023          	sb	a0,0(a3)
    for (int i = 0; i < 8192; i++)
    128a:	cf95                	beqz	a5,12c6 <main+0x2c4>
        buf[i] += 1;
    128c:	964a                	add	a2,a2,s2
    128e:	00064783          	lbu	a5,0(a2)
    for (int i = 0; i < 8192; i++)
    1292:	ffb8071b          	addiw	a4,a6,-5
    1296:	0055869b          	addiw	a3,a1,5
        buf[i] += 1;
    129a:	2785                	addiw	a5,a5,1
    129c:	00f60023          	sb	a5,0(a2)
    for (int i = 0; i < 8192; i++)
    12a0:	c31d                	beqz	a4,12c6 <main+0x2c4>
        buf[i] += 1;
    12a2:	00d90733          	add	a4,s2,a3
    12a6:	00074683          	lbu	a3,0(a4)
    for (int i = 0; i < 8192; i++)
    12aa:	4619                	li	a2,6
    12ac:	0065879b          	addiw	a5,a1,6
        buf[i] += 1;
    12b0:	2685                	addiw	a3,a3,1
    12b2:	00d70023          	sb	a3,0(a4)
    for (int i = 0; i < 8192; i++)
    12b6:	00c80863          	beq	a6,a2,12c6 <main+0x2c4>
        buf[i] += 1;
    12ba:	993e                	add	s2,s2,a5
    12bc:	00094783          	lbu	a5,0(s2)
    12c0:	2785                	addiw	a5,a5,1
    12c2:	00f90023          	sb	a5,0(s2)
    }
    sleep(1000);
    12c6:	3e800513          	li	a0,1000
    12ca:	4f9000ef          	jal	ra,1fc2 <sleep>

    buf = (char *)shmem1;
    for (int i = 0; i < 8192; i++)
    12ce:	6789                	lui	a5,0x2
    12d0:	94be                	add	s1,s1,a5
    {
        if(buf[i]!=3){
    12d2:	490d                	li	s2,3
    12d4:	00044783          	lbu	a5,0(s0)
            exit(-1);
    12d8:	557d                	li	a0,-1
    12da:	0405                	addi	s0,s0,1
        if(buf[i]!=3){
    12dc:	01278463          	beq	a5,s2,12e4 <main+0x2e2>
            exit(-1);
    12e0:	435000ef          	jal	ra,1f14 <exit>
    for (int i = 0; i < 8192; i++)
    12e4:	fe9418e3          	bne	s0,s1,12d4 <main+0x2d2>
        }
    }
    printf("[prog 1] check good\n");
    12e8:	00001517          	auipc	a0,0x1
    12ec:	e0050513          	addi	a0,a0,-512 # 20e8 <sharedmem+0x6e>
    12f0:	12c000ef          	jal	ra,141c <printf>
    
    return 0;
    12f4:	60e2                	ld	ra,24(sp)
    12f6:	6442                	ld	s0,16(sp)
    12f8:	64a2                	ld	s1,8(sp)
    12fa:	6902                	ld	s2,0(sp)
    12fc:	4501                	li	a0,0
    12fe:	6105                	addi	sp,sp,32
    1300:	8082                	ret
        buf[i] = 1;
    1302:	6689                	lui	a3,0x2
    1304:	ffc68593          	addi	a1,a3,-4 # 1ffc <fstat>
    for (int i = 0; i < 8192; i++)
    1308:	4511                	li	a0,4
    130a:	b355                	j	10ae <main+0xac>
        buf[i] += 1;
    130c:	6709                	lui	a4,0x2
    130e:	fff70e13          	addi	t3,a4,-1 # 1fff <fstat+0x3>
    for (int i = 0; i < 8192; i++)
    1312:	4f05                	li	t5,1
    1314:	bd7d                	j	11d2 <main+0x1d0>
    sleep(1000);
    1316:	6e09                	lui	t3,0x2
    for (int i = 0; i < 8192; i++)
    1318:	4f01                	li	t5,0
    131a:	bd65                	j	11d2 <main+0x1d0>
        buf[i] = 1;
    131c:	6689                	lui	a3,0x2
    131e:	fff68593          	addi	a1,a3,-1 # 1fff <fstat+0x3>
    for (int i = 0; i < 8192; i++)
    1322:	4505                	li	a0,1
    1324:	b369                	j	10ae <main+0xac>
    sleep(1000);
    1326:	6589                	lui	a1,0x2
    for (int i = 0; i < 8192; i++)
    1328:	4501                	li	a0,0
    132a:	b351                	j	10ae <main+0xac>
        buf[i] = 1;
    132c:	6689                	lui	a3,0x2
    132e:	ffe68593          	addi	a1,a3,-2 # 1ffe <fstat+0x2>
    for (int i = 0; i < 8192; i++)
    1332:	4509                	li	a0,2
    1334:	bbad                	j	10ae <main+0xac>
        buf[i] += 1;
    1336:	6709                	lui	a4,0x2
    1338:	ffe70e13          	addi	t3,a4,-2 # 1ffe <fstat+0x2>
    for (int i = 0; i < 8192; i++)
    133c:	4f09                	li	t5,2
    133e:	bd51                	j	11d2 <main+0x1d0>
        buf[i] += 1;
    1340:	6709                	lui	a4,0x2
    1342:	ffd70e13          	addi	t3,a4,-3 # 1ffd <fstat+0x1>
    for (int i = 0; i < 8192; i++)
    1346:	4f0d                	li	t5,3
    1348:	b569                	j	11d2 <main+0x1d0>
        buf[i] = 1;
    134a:	6689                	lui	a3,0x2
    134c:	ffd68593          	addi	a1,a3,-3 # 1ffd <fstat+0x1>
    for (int i = 0; i < 8192; i++)
    1350:	450d                	li	a0,3
    1352:	bbb1                	j	10ae <main+0xac>
        buf[i] += 1;
    1354:	6709                	lui	a4,0x2
    1356:	ffc70e13          	addi	t3,a4,-4 # 1ffc <fstat>
    for (int i = 0; i < 8192; i++)
    135a:	4f11                	li	t5,4
    135c:	bd9d                	j	11d2 <main+0x1d0>
        buf[i] += 1;
    135e:	6709                	lui	a4,0x2
    1360:	ffb70e13          	addi	t3,a4,-5 # 1ffb <pipe+0xb>
    for (int i = 0; i < 8192; i++)
    1364:	4f15                	li	t5,5
    1366:	b5b5                	j	11d2 <main+0x1d0>
        buf[i] = 1;
    1368:	6689                	lui	a3,0x2
    136a:	ffb68593          	addi	a1,a3,-5 # 1ffb <pipe+0xb>
    for (int i = 0; i < 8192; i++)
    136e:	4515                	li	a0,5
    1370:	bb3d                	j	10ae <main+0xac>
        buf[i] += 1;
    1372:	6709                	lui	a4,0x2
    1374:	ffa70e13          	addi	t3,a4,-6 # 1ffa <pipe+0xa>
    for (int i = 0; i < 8192; i++)
    1378:	4f19                	li	t5,6
    137a:	bda1                	j	11d2 <main+0x1d0>
        buf[i] = 1;
    137c:	6689                	lui	a3,0x2
    137e:	ffa68593          	addi	a1,a3,-6 # 1ffa <pipe+0xa>
    for (int i = 0; i < 8192; i++)
    1382:	4519                	li	a0,6
    1384:	b32d                	j	10ae <main+0xac>

0000000000001386 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1386:	1141                	addi	sp,sp,-16
    1388:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    138a:	c79ff0ef          	jal	ra,1002 <main>
}
    138e:	60a2                	ld	ra,8(sp)
    1390:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    1392:	3830006f          	j	1f14 <exit>

0000000000001396 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    1396:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    1398:	00f10593          	addi	a1,sp,15
    139c:	4605                	li	a2,1
    139e:	4501                	li	a0,0
int getchar() {
    13a0:	ec06                	sd	ra,24(sp)
    char byte = 0;
    13a2:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    13a6:	379000ef          	jal	ra,1f1e <read>
    return byte;
}
    13aa:	60e2                	ld	ra,24(sp)
    13ac:	00f14503          	lbu	a0,15(sp)
    13b0:	6105                	addi	sp,sp,32
    13b2:	8082                	ret

00000000000013b4 <putchar>:

int putchar(int c)
{
    13b4:	1141                	addi	sp,sp,-16
    13b6:	e406                	sd	ra,8(sp)
    13b8:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    13ba:	00001597          	auipc	a1,0x1
    13be:	d6e58593          	addi	a1,a1,-658 # 2128 <put.1156>
    return write(stdout, put, 1);
    13c2:	4605                	li	a2,1
    13c4:	4505                	li	a0,1
    put[0] = c;
    13c6:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    13ca:	35f000ef          	jal	ra,1f28 <write>
}
    13ce:	60a2                	ld	ra,8(sp)
    13d0:	2501                	sext.w	a0,a0
    13d2:	0141                	addi	sp,sp,16
    13d4:	8082                	ret

00000000000013d6 <puts>:

int puts(const char* s)
{
    13d6:	1141                	addi	sp,sp,-16
    13d8:	e022                	sd	s0,0(sp)
    13da:	e406                	sd	ra,8(sp)
    13dc:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    13de:	66e000ef          	jal	ra,1a4c <strlen>
    13e2:	862a                	mv	a2,a0
    13e4:	85a2                	mv	a1,s0
    13e6:	4505                	li	a0,1
    13e8:	341000ef          	jal	ra,1f28 <write>
    13ec:	00055763          	bgez	a0,13fa <puts+0x24>
    return r;
}
    13f0:	60a2                	ld	ra,8(sp)
    13f2:	6402                	ld	s0,0(sp)
    13f4:	557d                	li	a0,-1
    13f6:	0141                	addi	sp,sp,16
    13f8:	8082                	ret
    put[0] = c;
    13fa:	00001597          	auipc	a1,0x1
    13fe:	d2e58593          	addi	a1,a1,-722 # 2128 <put.1156>
    1402:	47a9                	li	a5,10
    return write(stdout, put, 1);
    1404:	4605                	li	a2,1
    1406:	4505                	li	a0,1
    put[0] = c;
    1408:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    140c:	31d000ef          	jal	ra,1f28 <write>
}
    1410:	60a2                	ld	ra,8(sp)
    1412:	6402                	ld	s0,0(sp)
    1414:	41f5551b          	sraiw	a0,a0,0x1f
    1418:	0141                	addi	sp,sp,16
    141a:	8082                	ret

000000000000141c <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    141c:	7115                	addi	sp,sp,-224
    141e:	ed06                	sd	ra,152(sp)
    1420:	e922                	sd	s0,144(sp)
    1422:	e526                	sd	s1,136(sp)
    1424:	e14a                	sd	s2,128(sp)
    1426:	fcce                	sd	s3,120(sp)
    1428:	f8d2                	sd	s4,112(sp)
    142a:	f4d6                	sd	s5,104(sp)
    142c:	f0da                	sd	s6,96(sp)
    142e:	ecde                	sd	s7,88(sp)
    1430:	e8e2                	sd	s8,80(sp)
    1432:	e4e6                	sd	s9,72(sp)
    1434:	e0ea                	sd	s10,64(sp)
    1436:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1438:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    143c:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    143e:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    1440:	f52e                	sd	a1,168(sp)
    1442:	f932                	sd	a2,176(sp)
    1444:	fd36                	sd	a3,184(sp)
    1446:	e1ba                	sd	a4,192(sp)
    1448:	e9c2                	sd	a6,208(sp)
    144a:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    144c:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    144e:	0c030b63          	beqz	t1,1524 <printf+0x108>
    1452:	8aaa                	mv	s5,a0
    1454:	0003071b          	sext.w	a4,t1
    1458:	4481                	li	s1,0
        if (c != '%') {
    145a:	02500b93          	li	s7,37
    put[0] = c;
    145e:	00001417          	auipc	s0,0x1
    1462:	cca40413          	addi	s0,s0,-822 # 2128 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    1466:	4c51                	li	s8,20
    put[0] = c;
    1468:	02500c93          	li	s9,37
    146c:	00001a17          	auipc	s4,0x1
    1470:	cc4a0a13          	addi	s4,s4,-828 # 2130 <put.1156+0x8>
    1474:	00001997          	auipc	s3,0x1
    1478:	d1498993          	addi	s3,s3,-748 # 2188 <digits>
    147c:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    1480:	0014879b          	addiw	a5,s1,1
    1484:	00fa8933          	add	s2,s5,a5
    1488:	13771163          	bne	a4,s7,15aa <printf+0x18e>
        c = fmt[++i] & 0xff;
    148c:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    1490:	080d0a63          	beqz	s10,1524 <printf+0x108>
        switch (c) {
    1494:	2489                	addiw	s1,s1,2
    1496:	009a8933          	add	s2,s5,s1
    149a:	257d0e63          	beq	s10,s7,16f6 <printf+0x2da>
    149e:	f9cd079b          	addiw	a5,s10,-100
    14a2:	0ff7f793          	andi	a5,a5,255
    14a6:	0cfc6263          	bltu	s8,a5,156a <printf+0x14e>
    14aa:	078a                	slli	a5,a5,0x2
    14ac:	97d2                	add	a5,a5,s4
    14ae:	439c                	lw	a5,0(a5)
    14b0:	97d2                	add	a5,a5,s4
    14b2:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    14b4:	67a2                	ld	a5,8(sp)
    14b6:	4398                	lw	a4,0(a5)
    14b8:	07a1                	addi	a5,a5,8
    14ba:	e43e                	sd	a5,8(sp)
    14bc:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    14c0:	26074663          	bltz	a4,172c <printf+0x310>
        buf[i++] = digits[x % base];
    14c4:	8bbd                	andi	a5,a5,15
    14c6:	97ce                	add	a5,a5,s3
    14c8:	0007c783          	lbu	a5,0(a5) # 2000 <fstat+0x4>
    } while ((x /= base) != 0);
    14cc:	40475d1b          	sraiw	s10,a4,0x4
    14d0:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    14d4:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    14d8:	020d0163          	beqz	s10,14fa <printf+0xde>
        buf[i++] = digits[x % base];
    14dc:	9d4e                	add	s10,s10,s3
    14de:	000d4783          	lbu	a5,0(s10)
    14e2:	4d05                	li	s10,1
    14e4:	00f108a3          	sb	a5,17(sp)
    if (sign)
    14e8:	00075963          	bgez	a4,14fa <printf+0xde>
        buf[i++] = digits[x % base];
    14ec:	4d09                	li	s10,2
        buf[i++] = '-';
    14ee:	181c                	addi	a5,sp,48
    14f0:	02d00713          	li	a4,45
    14f4:	97ea                	add	a5,a5,s10
    14f6:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    14fa:	9d5a                	add	s10,s10,s6
    14fc:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1500:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1504:	4605                	li	a2,1
    1506:	1d7d                	addi	s10,s10,-1
    1508:	85a2                	mv	a1,s0
    150a:	4505                	li	a0,1
    put[0] = c;
    150c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1510:	219000ef          	jal	ra,1f28 <write>
    while (--i >= 0)
    1514:	ffbd16e3          	bne	s10,s11,1500 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1518:	00094303          	lbu	t1,0(s2)
    151c:	0003071b          	sext.w	a4,t1
    1520:	f60310e3          	bnez	t1,1480 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    1524:	60ea                	ld	ra,152(sp)
    1526:	644a                	ld	s0,144(sp)
    1528:	64aa                	ld	s1,136(sp)
    152a:	690a                	ld	s2,128(sp)
    152c:	79e6                	ld	s3,120(sp)
    152e:	7a46                	ld	s4,112(sp)
    1530:	7aa6                	ld	s5,104(sp)
    1532:	7b06                	ld	s6,96(sp)
    1534:	6be6                	ld	s7,88(sp)
    1536:	6c46                	ld	s8,80(sp)
    1538:	6ca6                	ld	s9,72(sp)
    153a:	6d06                	ld	s10,64(sp)
    153c:	7de2                	ld	s11,56(sp)
    153e:	612d                	addi	sp,sp,224
    1540:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    1542:	67a2                	ld	a5,8(sp)
    1544:	0007bd03          	ld	s10,0(a5)
    1548:	07a1                	addi	a5,a5,8
    154a:	e43e                	sd	a5,8(sp)
    154c:	000d1b63          	bnez	s10,1562 <printf+0x146>
    1550:	aafd                	j	174e <printf+0x332>
    return write(stdout, put, 1);
    1552:	4605                	li	a2,1
    1554:	85a2                	mv	a1,s0
    1556:	4505                	li	a0,1
                for (; *s; s++)
    1558:	0d05                	addi	s10,s10,1
    put[0] = c;
    155a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    155e:	1cb000ef          	jal	ra,1f28 <write>
                for (; *s; s++)
    1562:	000d4783          	lbu	a5,0(s10)
    1566:	f7f5                	bnez	a5,1552 <printf+0x136>
    1568:	a02d                	j	1592 <printf+0x176>
    return write(stdout, put, 1);
    156a:	4605                	li	a2,1
    156c:	00001597          	auipc	a1,0x1
    1570:	bbc58593          	addi	a1,a1,-1092 # 2128 <put.1156>
    1574:	4505                	li	a0,1
    put[0] = c;
    1576:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    157a:	1af000ef          	jal	ra,1f28 <write>
    157e:	4605                	li	a2,1
    1580:	00001597          	auipc	a1,0x1
    1584:	ba858593          	addi	a1,a1,-1112 # 2128 <put.1156>
    1588:	4505                	li	a0,1
    put[0] = c;
    158a:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    158e:	19b000ef          	jal	ra,1f28 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1592:	00094303          	lbu	t1,0(s2)
    1596:	0003071b          	sext.w	a4,t1
    159a:	f80305e3          	beqz	t1,1524 <printf+0x108>
        if (c != '%') {
    159e:	0014879b          	addiw	a5,s1,1
    15a2:	00fa8933          	add	s2,s5,a5
    15a6:	ef7703e3          	beq	a4,s7,148c <printf+0x70>
    return write(stdout, put, 1);
    15aa:	4605                	li	a2,1
    15ac:	00001597          	auipc	a1,0x1
    15b0:	b7c58593          	addi	a1,a1,-1156 # 2128 <put.1156>
    15b4:	4505                	li	a0,1
    put[0] = c;
    15b6:	00640023          	sb	t1,0(s0)
            continue;
    15ba:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    15bc:	16d000ef          	jal	ra,1f28 <write>
            continue;
    15c0:	bfc9                	j	1592 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    15c2:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    15c4:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    15c6:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    15c8:	0007b883          	ld	a7,0(a5)
    15cc:	07a1                	addi	a5,a5,8
    15ce:	e43e                	sd	a5,8(sp)
        x = -xx;
    15d0:	43f8d713          	srai	a4,a7,0x3f
    15d4:	011747b3          	xor	a5,a4,a7
    15d8:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    15da:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    15dc:	02c7f733          	remu	a4,a5,a2
    15e0:	8d36                	mv	s10,a3
    15e2:	0685                	addi	a3,a3,1
    15e4:	00db0533          	add	a0,s6,a3
    15e8:	85be                	mv	a1,a5
    15ea:	974e                	add	a4,a4,s3
    15ec:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    15f0:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    15f4:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    15f8:	feb862e3          	bltu	a6,a1,15dc <printf+0x1c0>
    if (sign)
    15fc:	1208c063          	bltz	a7,171c <printf+0x300>
    while (--i >= 0)
    1600:	9d5a                	add	s10,s10,s6
    put[0] = c;
    1602:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1606:	4605                	li	a2,1
    1608:	85a2                	mv	a1,s0
    160a:	4505                	li	a0,1
    put[0] = c;
    160c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1610:	119000ef          	jal	ra,1f28 <write>
    while (--i >= 0)
    1614:	87ea                	mv	a5,s10
    1616:	1d7d                	addi	s10,s10,-1
    1618:	fefb15e3          	bne	s6,a5,1602 <printf+0x1e6>
    161c:	bf9d                	j	1592 <printf+0x176>
                printptr(va_arg(ap, uint64));
    161e:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    1620:	4605                	li	a2,1
    1622:	00001597          	auipc	a1,0x1
    1626:	b0658593          	addi	a1,a1,-1274 # 2128 <put.1156>
                printptr(va_arg(ap, uint64));
    162a:	0007bd83          	ld	s11,0(a5)
    162e:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    1632:	4505                	li	a0,1
    put[0] = c;
    1634:	03000793          	li	a5,48
    1638:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    163c:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    163e:	0eb000ef          	jal	ra,1f28 <write>
    put[0] = c;
    1642:	07800793          	li	a5,120
    return write(stdout, put, 1);
    1646:	4605                	li	a2,1
    1648:	00001597          	auipc	a1,0x1
    164c:	ae058593          	addi	a1,a1,-1312 # 2128 <put.1156>
    1650:	4505                	li	a0,1
    put[0] = c;
    1652:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1656:	4d41                	li	s10,16
    1658:	0d1000ef          	jal	ra,1f28 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    165c:	03cdd793          	srli	a5,s11,0x3c
    1660:	97ce                	add	a5,a5,s3
    put[0] = c;
    1662:	0007c783          	lbu	a5,0(a5)
    1666:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    1668:	4605                	li	a2,1
    166a:	85a2                	mv	a1,s0
    166c:	4505                	li	a0,1
    put[0] = c;
    166e:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1672:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1674:	0b5000ef          	jal	ra,1f28 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1678:	fe0d12e3          	bnez	s10,165c <printf+0x240>
    167c:	bf19                	j	1592 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    167e:	67a2                	ld	a5,8(sp)
    1680:	4394                	lw	a3,0(a5)
    1682:	07a1                	addi	a5,a5,8
    1684:	e43e                	sd	a5,8(sp)
    1686:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    168a:	0006d663          	bgez	a3,1696 <printf+0x27a>
        x = -xx;
    168e:	40f007bb          	negw	a5,a5
    1692:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    1696:	4729                	li	a4,10
    1698:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    169c:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    16a0:	964e                	add	a2,a2,s3
    16a2:	00064603          	lbu	a2,0(a2)
    16a6:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    16aa:	0a0d0963          	beqz	s10,175c <printf+0x340>
        buf[i++] = digits[x % base];
    16ae:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    16b2:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    16b6:	00c98733          	add	a4,s3,a2
    16ba:	00074703          	lbu	a4,0(a4)
    16be:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    16c2:	c3cd                	beqz	a5,1764 <printf+0x348>
        buf[i++] = digits[x % base];
    16c4:	97ce                	add	a5,a5,s3
    16c6:	0007c703          	lbu	a4,0(a5)
    16ca:	4d09                	li	s10,2
    16cc:	478d                	li	a5,3
    16ce:	00e10923          	sb	a4,18(sp)
    if (sign)
    16d2:	0206cd63          	bltz	a3,170c <printf+0x2f0>
    while (--i >= 0)
    16d6:	9d5a                	add	s10,s10,s6
    16d8:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    16dc:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    16e0:	4605                	li	a2,1
    16e2:	1d7d                	addi	s10,s10,-1
    16e4:	85a2                	mv	a1,s0
    16e6:	4505                	li	a0,1
    put[0] = c;
    16e8:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    16ec:	03d000ef          	jal	ra,1f28 <write>
    while (--i >= 0)
    16f0:	ffbd16e3          	bne	s10,s11,16dc <printf+0x2c0>
    16f4:	bd79                	j	1592 <printf+0x176>
    return write(stdout, put, 1);
    16f6:	4605                	li	a2,1
    16f8:	00001597          	auipc	a1,0x1
    16fc:	a3058593          	addi	a1,a1,-1488 # 2128 <put.1156>
    1700:	4505                	li	a0,1
    put[0] = c;
    1702:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    1706:	023000ef          	jal	ra,1f28 <write>
    170a:	b561                	j	1592 <printf+0x176>
        buf[i++] = '-';
    170c:	1818                	addi	a4,sp,48
    170e:	973e                	add	a4,a4,a5
    1710:	02d00693          	li	a3,45
    1714:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    1718:	8d3e                	mv	s10,a5
    171a:	bf75                	j	16d6 <printf+0x2ba>
        buf[i++] = '-';
    171c:	181c                	addi	a5,sp,48
    171e:	97b6                	add	a5,a5,a3
    1720:	02d00713          	li	a4,45
    1724:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    1728:	8d36                	mv	s10,a3
    172a:	bdd9                	j	1600 <printf+0x1e4>
        x = -xx;
    172c:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    1730:	00f7f693          	andi	a3,a5,15
    1734:	96ce                	add	a3,a3,s3
    1736:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    173a:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    173e:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    1742:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1746:	d80d1be3          	bnez	s10,14dc <printf+0xc0>
        buf[i++] = digits[x % base];
    174a:	4d05                	li	s10,1
    174c:	b34d                	j	14ee <printf+0xd2>
                s = "(null)";
    174e:	00001d17          	auipc	s10,0x1
    1752:	9b2d0d13          	addi	s10,s10,-1614 # 2100 <sharedmem+0x86>
                for (; *s; s++)
    1756:	02800793          	li	a5,40
    175a:	bbe5                	j	1552 <printf+0x136>
        buf[i++] = digits[x % base];
    175c:	4785                	li	a5,1
    if (sign)
    175e:	f606dce3          	bgez	a3,16d6 <printf+0x2ba>
    1762:	b76d                	j	170c <printf+0x2f0>
        buf[i++] = digits[x % base];
    1764:	4789                	li	a5,2
    1766:	4d05                	li	s10,1
    if (sign)
    1768:	f606d7e3          	bgez	a3,16d6 <printf+0x2ba>
    176c:	b745                	j	170c <printf+0x2f0>

000000000000176e <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    176e:	02000793          	li	a5,32
    1772:	00f50663          	beq	a0,a5,177e <isspace+0x10>
    1776:	355d                	addiw	a0,a0,-9
    1778:	00553513          	sltiu	a0,a0,5
    177c:	8082                	ret
    177e:	4505                	li	a0,1
}
    1780:	8082                	ret

0000000000001782 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    1782:	fd05051b          	addiw	a0,a0,-48
}
    1786:	00a53513          	sltiu	a0,a0,10
    178a:	8082                	ret

000000000000178c <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    178c:	02000613          	li	a2,32
    1790:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1792:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    1796:	ff77069b          	addiw	a3,a4,-9
    179a:	04c70d63          	beq	a4,a2,17f4 <atoi+0x68>
    179e:	0007079b          	sext.w	a5,a4
    17a2:	04d5f963          	bgeu	a1,a3,17f4 <atoi+0x68>
        s++;
    switch (*s) {
    17a6:	02b00693          	li	a3,43
    17aa:	04d70a63          	beq	a4,a3,17fe <atoi+0x72>
    17ae:	02d00693          	li	a3,45
    17b2:	06d70463          	beq	a4,a3,181a <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    17b6:	fd07859b          	addiw	a1,a5,-48
    17ba:	4625                	li	a2,9
    17bc:	873e                	mv	a4,a5
    17be:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    17c0:	4e01                	li	t3,0
    while (isdigit(*s))
    17c2:	04b66a63          	bltu	a2,a1,1816 <atoi+0x8a>
    int n = 0, neg = 0;
    17c6:	4501                	li	a0,0
    while (isdigit(*s))
    17c8:	4825                	li	a6,9
    17ca:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    17ce:	0025179b          	slliw	a5,a0,0x2
    17d2:	9d3d                	addw	a0,a0,a5
    17d4:	fd07031b          	addiw	t1,a4,-48
    17d8:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    17dc:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    17e0:	0685                	addi	a3,a3,1
    17e2:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    17e6:	0006071b          	sext.w	a4,a2
    17ea:	feb870e3          	bgeu	a6,a1,17ca <atoi+0x3e>
    return neg ? n : -n;
    17ee:	000e0563          	beqz	t3,17f8 <atoi+0x6c>
}
    17f2:	8082                	ret
        s++;
    17f4:	0505                	addi	a0,a0,1
    17f6:	bf71                	j	1792 <atoi+0x6>
    17f8:	4113053b          	subw	a0,t1,a7
    17fc:	8082                	ret
    while (isdigit(*s))
    17fe:	00154783          	lbu	a5,1(a0)
    1802:	4625                	li	a2,9
        s++;
    1804:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1808:	fd07859b          	addiw	a1,a5,-48
    180c:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1810:	4e01                	li	t3,0
    while (isdigit(*s))
    1812:	fab67ae3          	bgeu	a2,a1,17c6 <atoi+0x3a>
    1816:	4501                	li	a0,0
}
    1818:	8082                	ret
    while (isdigit(*s))
    181a:	00154783          	lbu	a5,1(a0)
    181e:	4625                	li	a2,9
        s++;
    1820:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1824:	fd07859b          	addiw	a1,a5,-48
    1828:	0007871b          	sext.w	a4,a5
    182c:	feb665e3          	bltu	a2,a1,1816 <atoi+0x8a>
        neg = 1;
    1830:	4e05                	li	t3,1
    1832:	bf51                	j	17c6 <atoi+0x3a>

0000000000001834 <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    1834:	16060d63          	beqz	a2,19ae <memset+0x17a>
    1838:	40a007b3          	neg	a5,a0
    183c:	8b9d                	andi	a5,a5,7
    183e:	00778713          	addi	a4,a5,7
    1842:	482d                	li	a6,11
    1844:	0ff5f593          	andi	a1,a1,255
    1848:	fff60693          	addi	a3,a2,-1
    184c:	17076263          	bltu	a4,a6,19b0 <memset+0x17c>
    1850:	16e6ea63          	bltu	a3,a4,19c4 <memset+0x190>
    1854:	16078563          	beqz	a5,19be <memset+0x18a>
    1858:	00b50023          	sb	a1,0(a0)
    185c:	4705                	li	a4,1
    185e:	00150e93          	addi	t4,a0,1
    1862:	14e78c63          	beq	a5,a4,19ba <memset+0x186>
    1866:	00b500a3          	sb	a1,1(a0)
    186a:	4709                	li	a4,2
    186c:	00250e93          	addi	t4,a0,2
    1870:	14e78d63          	beq	a5,a4,19ca <memset+0x196>
    1874:	00b50123          	sb	a1,2(a0)
    1878:	470d                	li	a4,3
    187a:	00350e93          	addi	t4,a0,3
    187e:	12e78b63          	beq	a5,a4,19b4 <memset+0x180>
    1882:	00b501a3          	sb	a1,3(a0)
    1886:	4711                	li	a4,4
    1888:	00450e93          	addi	t4,a0,4
    188c:	14e78163          	beq	a5,a4,19ce <memset+0x19a>
    1890:	00b50223          	sb	a1,4(a0)
    1894:	4715                	li	a4,5
    1896:	00550e93          	addi	t4,a0,5
    189a:	12e78c63          	beq	a5,a4,19d2 <memset+0x19e>
    189e:	00b502a3          	sb	a1,5(a0)
    18a2:	471d                	li	a4,7
    18a4:	00650e93          	addi	t4,a0,6
    18a8:	12e79763          	bne	a5,a4,19d6 <memset+0x1a2>
    18ac:	00750e93          	addi	t4,a0,7
    18b0:	00b50323          	sb	a1,6(a0)
    18b4:	4f1d                	li	t5,7
    18b6:	00859713          	slli	a4,a1,0x8
    18ba:	8f4d                	or	a4,a4,a1
    18bc:	01059e13          	slli	t3,a1,0x10
    18c0:	01c76e33          	or	t3,a4,t3
    18c4:	01859313          	slli	t1,a1,0x18
    18c8:	006e6333          	or	t1,t3,t1
    18cc:	02059893          	slli	a7,a1,0x20
    18d0:	011368b3          	or	a7,t1,a7
    18d4:	02859813          	slli	a6,a1,0x28
    18d8:	40f60333          	sub	t1,a2,a5
    18dc:	0108e833          	or	a6,a7,a6
    18e0:	03059693          	slli	a3,a1,0x30
    18e4:	00d866b3          	or	a3,a6,a3
    18e8:	03859713          	slli	a4,a1,0x38
    18ec:	97aa                	add	a5,a5,a0
    18ee:	ff837813          	andi	a6,t1,-8
    18f2:	8f55                	or	a4,a4,a3
    18f4:	00f806b3          	add	a3,a6,a5
    18f8:	e398                	sd	a4,0(a5)
    18fa:	07a1                	addi	a5,a5,8
    18fc:	fed79ee3          	bne	a5,a3,18f8 <memset+0xc4>
    1900:	ff837693          	andi	a3,t1,-8
    1904:	00de87b3          	add	a5,t4,a3
    1908:	01e6873b          	addw	a4,a3,t5
    190c:	0ad30663          	beq	t1,a3,19b8 <memset+0x184>
    1910:	00b78023          	sb	a1,0(a5)
    1914:	0017069b          	addiw	a3,a4,1
    1918:	08c6fb63          	bgeu	a3,a2,19ae <memset+0x17a>
    191c:	00b780a3          	sb	a1,1(a5)
    1920:	0027069b          	addiw	a3,a4,2
    1924:	08c6f563          	bgeu	a3,a2,19ae <memset+0x17a>
    1928:	00b78123          	sb	a1,2(a5)
    192c:	0037069b          	addiw	a3,a4,3
    1930:	06c6ff63          	bgeu	a3,a2,19ae <memset+0x17a>
    1934:	00b781a3          	sb	a1,3(a5)
    1938:	0047069b          	addiw	a3,a4,4
    193c:	06c6f963          	bgeu	a3,a2,19ae <memset+0x17a>
    1940:	00b78223          	sb	a1,4(a5)
    1944:	0057069b          	addiw	a3,a4,5
    1948:	06c6f363          	bgeu	a3,a2,19ae <memset+0x17a>
    194c:	00b782a3          	sb	a1,5(a5)
    1950:	0067069b          	addiw	a3,a4,6
    1954:	04c6fd63          	bgeu	a3,a2,19ae <memset+0x17a>
    1958:	00b78323          	sb	a1,6(a5)
    195c:	0077069b          	addiw	a3,a4,7
    1960:	04c6f763          	bgeu	a3,a2,19ae <memset+0x17a>
    1964:	00b783a3          	sb	a1,7(a5)
    1968:	0087069b          	addiw	a3,a4,8
    196c:	04c6f163          	bgeu	a3,a2,19ae <memset+0x17a>
    1970:	00b78423          	sb	a1,8(a5)
    1974:	0097069b          	addiw	a3,a4,9
    1978:	02c6fb63          	bgeu	a3,a2,19ae <memset+0x17a>
    197c:	00b784a3          	sb	a1,9(a5)
    1980:	00a7069b          	addiw	a3,a4,10
    1984:	02c6f563          	bgeu	a3,a2,19ae <memset+0x17a>
    1988:	00b78523          	sb	a1,10(a5)
    198c:	00b7069b          	addiw	a3,a4,11
    1990:	00c6ff63          	bgeu	a3,a2,19ae <memset+0x17a>
    1994:	00b785a3          	sb	a1,11(a5)
    1998:	00c7069b          	addiw	a3,a4,12
    199c:	00c6f963          	bgeu	a3,a2,19ae <memset+0x17a>
    19a0:	00b78623          	sb	a1,12(a5)
    19a4:	2735                	addiw	a4,a4,13
    19a6:	00c77463          	bgeu	a4,a2,19ae <memset+0x17a>
    19aa:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    19ae:	8082                	ret
    19b0:	472d                	li	a4,11
    19b2:	bd79                	j	1850 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    19b4:	4f0d                	li	t5,3
    19b6:	b701                	j	18b6 <memset+0x82>
    19b8:	8082                	ret
    19ba:	4f05                	li	t5,1
    19bc:	bded                	j	18b6 <memset+0x82>
    19be:	8eaa                	mv	t4,a0
    19c0:	4f01                	li	t5,0
    19c2:	bdd5                	j	18b6 <memset+0x82>
    19c4:	87aa                	mv	a5,a0
    19c6:	4701                	li	a4,0
    19c8:	b7a1                	j	1910 <memset+0xdc>
    19ca:	4f09                	li	t5,2
    19cc:	b5ed                	j	18b6 <memset+0x82>
    19ce:	4f11                	li	t5,4
    19d0:	b5dd                	j	18b6 <memset+0x82>
    19d2:	4f15                	li	t5,5
    19d4:	b5cd                	j	18b6 <memset+0x82>
    19d6:	4f19                	li	t5,6
    19d8:	bdf9                	j	18b6 <memset+0x82>

00000000000019da <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    19da:	00054783          	lbu	a5,0(a0)
    19de:	0005c703          	lbu	a4,0(a1)
    19e2:	00e79863          	bne	a5,a4,19f2 <strcmp+0x18>
    19e6:	0505                	addi	a0,a0,1
    19e8:	0585                	addi	a1,a1,1
    19ea:	fbe5                	bnez	a5,19da <strcmp>
    19ec:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    19ee:	9d19                	subw	a0,a0,a4
    19f0:	8082                	ret
    19f2:	0007851b          	sext.w	a0,a5
    19f6:	bfe5                	j	19ee <strcmp+0x14>

00000000000019f8 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    19f8:	87aa                	mv	a5,a0
    19fa:	0005c703          	lbu	a4,0(a1)
    19fe:	0785                	addi	a5,a5,1
    1a00:	0585                	addi	a1,a1,1
    1a02:	fee78fa3          	sb	a4,-1(a5)
    1a06:	fb75                	bnez	a4,19fa <strcpy+0x2>
        ;
    return os;
}
    1a08:	8082                	ret

0000000000001a0a <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    1a0a:	ce05                	beqz	a2,1a42 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1a0c:	00054703          	lbu	a4,0(a0)
    1a10:	0005c783          	lbu	a5,0(a1)
    1a14:	cb0d                	beqz	a4,1a46 <strncmp+0x3c>
    if (!n--)
    1a16:	167d                	addi	a2,a2,-1
    1a18:	00c506b3          	add	a3,a0,a2
    1a1c:	a819                	j	1a32 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1a1e:	00a68e63          	beq	a3,a0,1a3a <strncmp+0x30>
    1a22:	0505                	addi	a0,a0,1
    1a24:	00e79b63          	bne	a5,a4,1a3a <strncmp+0x30>
    1a28:	00054703          	lbu	a4,0(a0)
    1a2c:	0005c783          	lbu	a5,0(a1)
    1a30:	cb19                	beqz	a4,1a46 <strncmp+0x3c>
    1a32:	0005c783          	lbu	a5,0(a1)
    1a36:	0585                	addi	a1,a1,1
    1a38:	f3fd                	bnez	a5,1a1e <strncmp+0x14>
        ;
    return *l - *r;
    1a3a:	0007051b          	sext.w	a0,a4
    1a3e:	9d1d                	subw	a0,a0,a5
    1a40:	8082                	ret
        return 0;
    1a42:	4501                	li	a0,0
}
    1a44:	8082                	ret
    1a46:	4501                	li	a0,0
    return *l - *r;
    1a48:	9d1d                	subw	a0,a0,a5
    1a4a:	8082                	ret

0000000000001a4c <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    1a4c:	00757793          	andi	a5,a0,7
    1a50:	cf89                	beqz	a5,1a6a <strlen+0x1e>
    1a52:	87aa                	mv	a5,a0
    1a54:	a029                	j	1a5e <strlen+0x12>
    1a56:	0785                	addi	a5,a5,1
    1a58:	0077f713          	andi	a4,a5,7
    1a5c:	cb01                	beqz	a4,1a6c <strlen+0x20>
        if (!*s)
    1a5e:	0007c703          	lbu	a4,0(a5)
    1a62:	fb75                	bnez	a4,1a56 <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1a64:	40a78533          	sub	a0,a5,a0
}
    1a68:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1a6a:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    1a6c:	6394                	ld	a3,0(a5)
    1a6e:	00000597          	auipc	a1,0x0
    1a72:	6b25b583          	ld	a1,1714(a1) # 2120 <sharedmem+0xa6>
    1a76:	00000617          	auipc	a2,0x0
    1a7a:	69a63603          	ld	a2,1690(a2) # 2110 <sharedmem+0x96>
    1a7e:	a019                	j	1a84 <strlen+0x38>
    1a80:	6794                	ld	a3,8(a5)
    1a82:	07a1                	addi	a5,a5,8
    1a84:	00b68733          	add	a4,a3,a1
    1a88:	fff6c693          	not	a3,a3
    1a8c:	8f75                	and	a4,a4,a3
    1a8e:	8f71                	and	a4,a4,a2
    1a90:	db65                	beqz	a4,1a80 <strlen+0x34>
    for (; *s; s++)
    1a92:	0007c703          	lbu	a4,0(a5)
    1a96:	d779                	beqz	a4,1a64 <strlen+0x18>
    1a98:	0017c703          	lbu	a4,1(a5)
    1a9c:	0785                	addi	a5,a5,1
    1a9e:	d379                	beqz	a4,1a64 <strlen+0x18>
    1aa0:	0017c703          	lbu	a4,1(a5)
    1aa4:	0785                	addi	a5,a5,1
    1aa6:	fb6d                	bnez	a4,1a98 <strlen+0x4c>
    1aa8:	bf75                	j	1a64 <strlen+0x18>

0000000000001aaa <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1aaa:	00757713          	andi	a4,a0,7
{
    1aae:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1ab0:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1ab4:	cb19                	beqz	a4,1aca <memchr+0x20>
    1ab6:	ce25                	beqz	a2,1b2e <memchr+0x84>
    1ab8:	0007c703          	lbu	a4,0(a5)
    1abc:	04b70e63          	beq	a4,a1,1b18 <memchr+0x6e>
    1ac0:	0785                	addi	a5,a5,1
    1ac2:	0077f713          	andi	a4,a5,7
    1ac6:	167d                	addi	a2,a2,-1
    1ac8:	f77d                	bnez	a4,1ab6 <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    1aca:	4501                	li	a0,0
    if (n && *s != c) {
    1acc:	c235                	beqz	a2,1b30 <memchr+0x86>
    1ace:	0007c703          	lbu	a4,0(a5)
    1ad2:	04b70363          	beq	a4,a1,1b18 <memchr+0x6e>
        size_t k = ONES * c;
    1ad6:	00000517          	auipc	a0,0x0
    1ada:	63253503          	ld	a0,1586(a0) # 2108 <sharedmem+0x8e>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1ade:	471d                	li	a4,7
        size_t k = ONES * c;
    1ae0:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1ae4:	02c77a63          	bgeu	a4,a2,1b18 <memchr+0x6e>
    1ae8:	00000897          	auipc	a7,0x0
    1aec:	6388b883          	ld	a7,1592(a7) # 2120 <sharedmem+0xa6>
    1af0:	00000817          	auipc	a6,0x0
    1af4:	62083803          	ld	a6,1568(a6) # 2110 <sharedmem+0x96>
    1af8:	431d                	li	t1,7
    1afa:	a029                	j	1b04 <memchr+0x5a>
    1afc:	1661                	addi	a2,a2,-8
    1afe:	07a1                	addi	a5,a5,8
    1b00:	02c37963          	bgeu	t1,a2,1b32 <memchr+0x88>
    1b04:	6398                	ld	a4,0(a5)
    1b06:	8f29                	xor	a4,a4,a0
    1b08:	011706b3          	add	a3,a4,a7
    1b0c:	fff74713          	not	a4,a4
    1b10:	8f75                	and	a4,a4,a3
    1b12:	01077733          	and	a4,a4,a6
    1b16:	d37d                	beqz	a4,1afc <memchr+0x52>
    1b18:	853e                	mv	a0,a5
    1b1a:	97b2                	add	a5,a5,a2
    1b1c:	a021                	j	1b24 <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1b1e:	0505                	addi	a0,a0,1
    1b20:	00f50763          	beq	a0,a5,1b2e <memchr+0x84>
    1b24:	00054703          	lbu	a4,0(a0)
    1b28:	feb71be3          	bne	a4,a1,1b1e <memchr+0x74>
    1b2c:	8082                	ret
    return n ? (void*)s : 0;
    1b2e:	4501                	li	a0,0
}
    1b30:	8082                	ret
    return n ? (void*)s : 0;
    1b32:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1b34:	f275                	bnez	a2,1b18 <memchr+0x6e>
}
    1b36:	8082                	ret

0000000000001b38 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1b38:	1101                	addi	sp,sp,-32
    1b3a:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1b3c:	862e                	mv	a2,a1
{
    1b3e:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1b40:	4581                	li	a1,0
{
    1b42:	e426                	sd	s1,8(sp)
    1b44:	ec06                	sd	ra,24(sp)
    1b46:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1b48:	f63ff0ef          	jal	ra,1aaa <memchr>
    return p ? p - s : n;
    1b4c:	c519                	beqz	a0,1b5a <strnlen+0x22>
}
    1b4e:	60e2                	ld	ra,24(sp)
    1b50:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1b52:	8d05                	sub	a0,a0,s1
}
    1b54:	64a2                	ld	s1,8(sp)
    1b56:	6105                	addi	sp,sp,32
    1b58:	8082                	ret
    1b5a:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1b5c:	8522                	mv	a0,s0
}
    1b5e:	6442                	ld	s0,16(sp)
    1b60:	64a2                	ld	s1,8(sp)
    1b62:	6105                	addi	sp,sp,32
    1b64:	8082                	ret

0000000000001b66 <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1b66:	00b547b3          	xor	a5,a0,a1
    1b6a:	8b9d                	andi	a5,a5,7
    1b6c:	eb95                	bnez	a5,1ba0 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1b6e:	0075f793          	andi	a5,a1,7
    1b72:	e7b1                	bnez	a5,1bbe <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1b74:	6198                	ld	a4,0(a1)
    1b76:	00000617          	auipc	a2,0x0
    1b7a:	5aa63603          	ld	a2,1450(a2) # 2120 <sharedmem+0xa6>
    1b7e:	00000817          	auipc	a6,0x0
    1b82:	59283803          	ld	a6,1426(a6) # 2110 <sharedmem+0x96>
    1b86:	a029                	j	1b90 <stpcpy+0x2a>
    1b88:	e118                	sd	a4,0(a0)
    1b8a:	6598                	ld	a4,8(a1)
    1b8c:	05a1                	addi	a1,a1,8
    1b8e:	0521                	addi	a0,a0,8
    1b90:	00c707b3          	add	a5,a4,a2
    1b94:	fff74693          	not	a3,a4
    1b98:	8ff5                	and	a5,a5,a3
    1b9a:	0107f7b3          	and	a5,a5,a6
    1b9e:	d7ed                	beqz	a5,1b88 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1ba0:	0005c783          	lbu	a5,0(a1)
    1ba4:	00f50023          	sb	a5,0(a0)
    1ba8:	c785                	beqz	a5,1bd0 <stpcpy+0x6a>
    1baa:	0015c783          	lbu	a5,1(a1)
    1bae:	0505                	addi	a0,a0,1
    1bb0:	0585                	addi	a1,a1,1
    1bb2:	00f50023          	sb	a5,0(a0)
    1bb6:	fbf5                	bnez	a5,1baa <stpcpy+0x44>
        ;
    return d;
}
    1bb8:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1bba:	0505                	addi	a0,a0,1
    1bbc:	df45                	beqz	a4,1b74 <stpcpy+0xe>
            if (!(*d = *s))
    1bbe:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1bc2:	0585                	addi	a1,a1,1
    1bc4:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1bc8:	00f50023          	sb	a5,0(a0)
    1bcc:	f7fd                	bnez	a5,1bba <stpcpy+0x54>
}
    1bce:	8082                	ret
    1bd0:	8082                	ret

0000000000001bd2 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1bd2:	00b547b3          	xor	a5,a0,a1
    1bd6:	8b9d                	andi	a5,a5,7
    1bd8:	1a079863          	bnez	a5,1d88 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1bdc:	0075f793          	andi	a5,a1,7
    1be0:	16078463          	beqz	a5,1d48 <stpncpy+0x176>
    1be4:	ea01                	bnez	a2,1bf4 <stpncpy+0x22>
    1be6:	a421                	j	1dee <stpncpy+0x21c>
    1be8:	167d                	addi	a2,a2,-1
    1bea:	0505                	addi	a0,a0,1
    1bec:	14070e63          	beqz	a4,1d48 <stpncpy+0x176>
    1bf0:	1a060863          	beqz	a2,1da0 <stpncpy+0x1ce>
    1bf4:	0005c783          	lbu	a5,0(a1)
    1bf8:	0585                	addi	a1,a1,1
    1bfa:	0075f713          	andi	a4,a1,7
    1bfe:	00f50023          	sb	a5,0(a0)
    1c02:	f3fd                	bnez	a5,1be8 <stpncpy+0x16>
    1c04:	4805                	li	a6,1
    1c06:	1a061863          	bnez	a2,1db6 <stpncpy+0x1e4>
    1c0a:	40a007b3          	neg	a5,a0
    1c0e:	8b9d                	andi	a5,a5,7
    1c10:	4681                	li	a3,0
    1c12:	18061a63          	bnez	a2,1da6 <stpncpy+0x1d4>
    1c16:	00778713          	addi	a4,a5,7
    1c1a:	45ad                	li	a1,11
    1c1c:	18b76363          	bltu	a4,a1,1da2 <stpncpy+0x1d0>
    1c20:	1ae6eb63          	bltu	a3,a4,1dd6 <stpncpy+0x204>
    1c24:	1a078363          	beqz	a5,1dca <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1c28:	00050023          	sb	zero,0(a0)
    1c2c:	4685                	li	a3,1
    1c2e:	00150713          	addi	a4,a0,1
    1c32:	18d78f63          	beq	a5,a3,1dd0 <stpncpy+0x1fe>
    1c36:	000500a3          	sb	zero,1(a0)
    1c3a:	4689                	li	a3,2
    1c3c:	00250713          	addi	a4,a0,2
    1c40:	18d78e63          	beq	a5,a3,1ddc <stpncpy+0x20a>
    1c44:	00050123          	sb	zero,2(a0)
    1c48:	468d                	li	a3,3
    1c4a:	00350713          	addi	a4,a0,3
    1c4e:	16d78c63          	beq	a5,a3,1dc6 <stpncpy+0x1f4>
    1c52:	000501a3          	sb	zero,3(a0)
    1c56:	4691                	li	a3,4
    1c58:	00450713          	addi	a4,a0,4
    1c5c:	18d78263          	beq	a5,a3,1de0 <stpncpy+0x20e>
    1c60:	00050223          	sb	zero,4(a0)
    1c64:	4695                	li	a3,5
    1c66:	00550713          	addi	a4,a0,5
    1c6a:	16d78d63          	beq	a5,a3,1de4 <stpncpy+0x212>
    1c6e:	000502a3          	sb	zero,5(a0)
    1c72:	469d                	li	a3,7
    1c74:	00650713          	addi	a4,a0,6
    1c78:	16d79863          	bne	a5,a3,1de8 <stpncpy+0x216>
    1c7c:	00750713          	addi	a4,a0,7
    1c80:	00050323          	sb	zero,6(a0)
    1c84:	40f80833          	sub	a6,a6,a5
    1c88:	ff887593          	andi	a1,a6,-8
    1c8c:	97aa                	add	a5,a5,a0
    1c8e:	95be                	add	a1,a1,a5
    1c90:	0007b023          	sd	zero,0(a5)
    1c94:	07a1                	addi	a5,a5,8
    1c96:	feb79de3          	bne	a5,a1,1c90 <stpncpy+0xbe>
    1c9a:	ff887593          	andi	a1,a6,-8
    1c9e:	9ead                	addw	a3,a3,a1
    1ca0:	00b707b3          	add	a5,a4,a1
    1ca4:	12b80863          	beq	a6,a1,1dd4 <stpncpy+0x202>
    1ca8:	00078023          	sb	zero,0(a5)
    1cac:	0016871b          	addiw	a4,a3,1
    1cb0:	0ec77863          	bgeu	a4,a2,1da0 <stpncpy+0x1ce>
    1cb4:	000780a3          	sb	zero,1(a5)
    1cb8:	0026871b          	addiw	a4,a3,2
    1cbc:	0ec77263          	bgeu	a4,a2,1da0 <stpncpy+0x1ce>
    1cc0:	00078123          	sb	zero,2(a5)
    1cc4:	0036871b          	addiw	a4,a3,3
    1cc8:	0cc77c63          	bgeu	a4,a2,1da0 <stpncpy+0x1ce>
    1ccc:	000781a3          	sb	zero,3(a5)
    1cd0:	0046871b          	addiw	a4,a3,4
    1cd4:	0cc77663          	bgeu	a4,a2,1da0 <stpncpy+0x1ce>
    1cd8:	00078223          	sb	zero,4(a5)
    1cdc:	0056871b          	addiw	a4,a3,5
    1ce0:	0cc77063          	bgeu	a4,a2,1da0 <stpncpy+0x1ce>
    1ce4:	000782a3          	sb	zero,5(a5)
    1ce8:	0066871b          	addiw	a4,a3,6
    1cec:	0ac77a63          	bgeu	a4,a2,1da0 <stpncpy+0x1ce>
    1cf0:	00078323          	sb	zero,6(a5)
    1cf4:	0076871b          	addiw	a4,a3,7
    1cf8:	0ac77463          	bgeu	a4,a2,1da0 <stpncpy+0x1ce>
    1cfc:	000783a3          	sb	zero,7(a5)
    1d00:	0086871b          	addiw	a4,a3,8
    1d04:	08c77e63          	bgeu	a4,a2,1da0 <stpncpy+0x1ce>
    1d08:	00078423          	sb	zero,8(a5)
    1d0c:	0096871b          	addiw	a4,a3,9
    1d10:	08c77863          	bgeu	a4,a2,1da0 <stpncpy+0x1ce>
    1d14:	000784a3          	sb	zero,9(a5)
    1d18:	00a6871b          	addiw	a4,a3,10
    1d1c:	08c77263          	bgeu	a4,a2,1da0 <stpncpy+0x1ce>
    1d20:	00078523          	sb	zero,10(a5)
    1d24:	00b6871b          	addiw	a4,a3,11
    1d28:	06c77c63          	bgeu	a4,a2,1da0 <stpncpy+0x1ce>
    1d2c:	000785a3          	sb	zero,11(a5)
    1d30:	00c6871b          	addiw	a4,a3,12
    1d34:	06c77663          	bgeu	a4,a2,1da0 <stpncpy+0x1ce>
    1d38:	00078623          	sb	zero,12(a5)
    1d3c:	26b5                	addiw	a3,a3,13
    1d3e:	06c6f163          	bgeu	a3,a2,1da0 <stpncpy+0x1ce>
    1d42:	000786a3          	sb	zero,13(a5)
    1d46:	8082                	ret
            ;
        if (!n || !*s)
    1d48:	c645                	beqz	a2,1df0 <stpncpy+0x21e>
    1d4a:	0005c783          	lbu	a5,0(a1)
    1d4e:	ea078be3          	beqz	a5,1c04 <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1d52:	479d                	li	a5,7
    1d54:	02c7ff63          	bgeu	a5,a2,1d92 <stpncpy+0x1c0>
    1d58:	00000897          	auipc	a7,0x0
    1d5c:	3c88b883          	ld	a7,968(a7) # 2120 <sharedmem+0xa6>
    1d60:	00000817          	auipc	a6,0x0
    1d64:	3b083803          	ld	a6,944(a6) # 2110 <sharedmem+0x96>
    1d68:	431d                	li	t1,7
    1d6a:	6198                	ld	a4,0(a1)
    1d6c:	011707b3          	add	a5,a4,a7
    1d70:	fff74693          	not	a3,a4
    1d74:	8ff5                	and	a5,a5,a3
    1d76:	0107f7b3          	and	a5,a5,a6
    1d7a:	ef81                	bnez	a5,1d92 <stpncpy+0x1c0>
            *wd = *ws;
    1d7c:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1d7e:	1661                	addi	a2,a2,-8
    1d80:	05a1                	addi	a1,a1,8
    1d82:	0521                	addi	a0,a0,8
    1d84:	fec363e3          	bltu	t1,a2,1d6a <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1d88:	e609                	bnez	a2,1d92 <stpncpy+0x1c0>
    1d8a:	a08d                	j	1dec <stpncpy+0x21a>
    1d8c:	167d                	addi	a2,a2,-1
    1d8e:	0505                	addi	a0,a0,1
    1d90:	ca01                	beqz	a2,1da0 <stpncpy+0x1ce>
    1d92:	0005c783          	lbu	a5,0(a1)
    1d96:	0585                	addi	a1,a1,1
    1d98:	00f50023          	sb	a5,0(a0)
    1d9c:	fbe5                	bnez	a5,1d8c <stpncpy+0x1ba>
        ;
tail:
    1d9e:	b59d                	j	1c04 <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1da0:	8082                	ret
    1da2:	472d                	li	a4,11
    1da4:	bdb5                	j	1c20 <stpncpy+0x4e>
    1da6:	00778713          	addi	a4,a5,7
    1daa:	45ad                	li	a1,11
    1dac:	fff60693          	addi	a3,a2,-1
    1db0:	e6b778e3          	bgeu	a4,a1,1c20 <stpncpy+0x4e>
    1db4:	b7fd                	j	1da2 <stpncpy+0x1d0>
    1db6:	40a007b3          	neg	a5,a0
    1dba:	8832                	mv	a6,a2
    1dbc:	8b9d                	andi	a5,a5,7
    1dbe:	4681                	li	a3,0
    1dc0:	e4060be3          	beqz	a2,1c16 <stpncpy+0x44>
    1dc4:	b7cd                	j	1da6 <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1dc6:	468d                	li	a3,3
    1dc8:	bd75                	j	1c84 <stpncpy+0xb2>
    1dca:	872a                	mv	a4,a0
    1dcc:	4681                	li	a3,0
    1dce:	bd5d                	j	1c84 <stpncpy+0xb2>
    1dd0:	4685                	li	a3,1
    1dd2:	bd4d                	j	1c84 <stpncpy+0xb2>
    1dd4:	8082                	ret
    1dd6:	87aa                	mv	a5,a0
    1dd8:	4681                	li	a3,0
    1dda:	b5f9                	j	1ca8 <stpncpy+0xd6>
    1ddc:	4689                	li	a3,2
    1dde:	b55d                	j	1c84 <stpncpy+0xb2>
    1de0:	4691                	li	a3,4
    1de2:	b54d                	j	1c84 <stpncpy+0xb2>
    1de4:	4695                	li	a3,5
    1de6:	bd79                	j	1c84 <stpncpy+0xb2>
    1de8:	4699                	li	a3,6
    1dea:	bd69                	j	1c84 <stpncpy+0xb2>
    1dec:	8082                	ret
    1dee:	8082                	ret
    1df0:	8082                	ret

0000000000001df2 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1df2:	fff6071b          	addiw	a4,a2,-1
    1df6:	0cb57063          	bgeu	a0,a1,1eb6 <memmove+0xc4>
        while (n-- > 0)
    1dfa:	0ec05063          	blez	a2,1eda <memmove+0xe8>
    1dfe:	00750693          	addi	a3,a0,7
    1e02:	8e8d                	sub	a3,a3,a1
    1e04:	00b567b3          	or	a5,a0,a1
    1e08:	00f6b693          	sltiu	a3,a3,15
    1e0c:	8b9d                	andi	a5,a5,7
    1e0e:	0016c693          	xori	a3,a3,1
    1e12:	0017b793          	seqz	a5,a5
    1e16:	8ff5                	and	a5,a5,a3
    1e18:	c3f1                	beqz	a5,1edc <memmove+0xea>
    1e1a:	0007079b          	sext.w	a5,a4
    1e1e:	46a5                	li	a3,9
    1e20:	0af6fe63          	bgeu	a3,a5,1edc <memmove+0xea>
    1e24:	0036589b          	srliw	a7,a2,0x3
    1e28:	088e                	slli	a7,a7,0x3
    1e2a:	2601                	sext.w	a2,a2
    1e2c:	87ae                	mv	a5,a1
    1e2e:	86aa                	mv	a3,a0
    1e30:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1e32:	0007b803          	ld	a6,0(a5)
    1e36:	07a1                	addi	a5,a5,8
    1e38:	06a1                	addi	a3,a3,8
    1e3a:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1e3e:	ff179ae3          	bne	a5,a7,1e32 <memmove+0x40>
    1e42:	ff867813          	andi	a6,a2,-8
    1e46:	02081793          	slli	a5,a6,0x20
    1e4a:	9381                	srli	a5,a5,0x20
    1e4c:	00f506b3          	add	a3,a0,a5
    1e50:	95be                	add	a1,a1,a5
    1e52:	4107073b          	subw	a4,a4,a6
    1e56:	09060263          	beq	a2,a6,1eda <memmove+0xe8>
            *dst++ = *src++;
    1e5a:	0005c783          	lbu	a5,0(a1)
    1e5e:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1e62:	06e05c63          	blez	a4,1eda <memmove+0xe8>
            *dst++ = *src++;
    1e66:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1e6a:	4785                	li	a5,1
            *dst++ = *src++;
    1e6c:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1e70:	06e7d563          	bge	a5,a4,1eda <memmove+0xe8>
            *dst++ = *src++;
    1e74:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1e78:	4789                	li	a5,2
            *dst++ = *src++;
    1e7a:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1e7e:	04e7de63          	bge	a5,a4,1eda <memmove+0xe8>
            *dst++ = *src++;
    1e82:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1e86:	478d                	li	a5,3
            *dst++ = *src++;
    1e88:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1e8c:	04e7d763          	bge	a5,a4,1eda <memmove+0xe8>
            *dst++ = *src++;
    1e90:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1e94:	4791                	li	a5,4
            *dst++ = *src++;
    1e96:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1e9a:	04e7d063          	bge	a5,a4,1eda <memmove+0xe8>
            *dst++ = *src++;
    1e9e:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1ea2:	4795                	li	a5,5
            *dst++ = *src++;
    1ea4:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1ea8:	02e7d963          	bge	a5,a4,1eda <memmove+0xe8>
            *dst++ = *src++;
    1eac:	0065c783          	lbu	a5,6(a1)
    1eb0:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1eb4:	8082                	ret
    } else {
        dst += n;
    1eb6:	00c507b3          	add	a5,a0,a2
        src += n;
    1eba:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1ebc:	00c05f63          	blez	a2,1eda <memmove+0xe8>
    1ec0:	1702                	slli	a4,a4,0x20
    1ec2:	9301                	srli	a4,a4,0x20
    1ec4:	fff74713          	not	a4,a4
    1ec8:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1eca:	fff5c683          	lbu	a3,-1(a1)
    1ece:	17fd                	addi	a5,a5,-1
    1ed0:	15fd                	addi	a1,a1,-1
    1ed2:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1ed6:	fee79ae3          	bne	a5,a4,1eca <memmove+0xd8>
    }
    return vdst;
}
    1eda:	8082                	ret
    1edc:	02071693          	slli	a3,a4,0x20
    1ee0:	9281                	srli	a3,a3,0x20
    1ee2:	0685                	addi	a3,a3,1
    1ee4:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1ee6:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1ee8:	0005c703          	lbu	a4,0(a1)
    1eec:	0585                	addi	a1,a1,1
    1eee:	0785                	addi	a5,a5,1
    1ef0:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1ef4:	fed59ae3          	bne	a1,a3,1ee8 <memmove+0xf6>
    1ef8:	8082                	ret

0000000000001efa <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1efa:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1efe:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1f02:	2501                	sext.w	a0,a0
    1f04:	8082                	ret

0000000000001f06 <exec>:
    register long a7 __asm__("a7") = n;
    1f06:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1f0a:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f0c:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1f10:	2501                	sext.w	a0,a0
    1f12:	8082                	ret

0000000000001f14 <exit>:
    register long a7 __asm__("a7") = n;
    1f14:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1f18:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1f1c:	8082                	ret

0000000000001f1e <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1f1e:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f22:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1f26:	8082                	ret

0000000000001f28 <write>:
    register long a7 __asm__("a7") = n;
    1f28:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f2c:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1f30:	8082                	ret

0000000000001f32 <getpid>:
    register long a7 __asm__("a7") = n;
    1f32:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1f36:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1f3a:	2501                	sext.w	a0,a0
    1f3c:	8082                	ret

0000000000001f3e <getppid>:
    register long a7 __asm__("a7") = n;
    1f3e:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1f42:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1f46:	2501                	sext.w	a0,a0
    1f48:	8082                	ret

0000000000001f4a <open>:
    register long a7 __asm__("a7") = n;
    1f4a:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f4e:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1f52:	2501                	sext.w	a0,a0
    1f54:	8082                	ret

0000000000001f56 <mknod>:
    register long a7 __asm__("a7") = n;
    1f56:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f5a:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1f5e:	2501                	sext.w	a0,a0
    1f60:	8082                	ret

0000000000001f62 <dup>:
    register long a7 __asm__("a7") = n;
    1f62:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1f64:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1f68:	2501                	sext.w	a0,a0
    1f6a:	8082                	ret

0000000000001f6c <sched_yield>:
    register long a7 __asm__("a7") = n;
    1f6c:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1f70:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1f74:	2501                	sext.w	a0,a0
    1f76:	8082                	ret

0000000000001f78 <waitpid>:
    register long a7 __asm__("a7") = n;
    1f78:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f7c:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1f80:	2501                	sext.w	a0,a0
    1f82:	8082                	ret

0000000000001f84 <wait>:

pid_t wait(int *wstatus)
{
    1f84:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1f86:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1f8a:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f8c:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1f90:	2501                	sext.w	a0,a0
    1f92:	8082                	ret

0000000000001f94 <mkdir>:
    register long a7 __asm__("a7") = n;
    1f94:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1f98:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1f9c:	2501                	sext.w	a0,a0
    1f9e:	8082                	ret

0000000000001fa0 <close>:
    register long a7 __asm__("a7") = n;
    1fa0:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1fa4:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1fa8:	2501                	sext.w	a0,a0
    1faa:	8082                	ret

0000000000001fac <fork>:
    register long a7 __asm__("a7") = n;
    1fac:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1fb0:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1fb4:	2501                	sext.w	a0,a0
    1fb6:	8082                	ret

0000000000001fb8 <time_ms>:
    register long a7 __asm__("a7") = n;
    1fb8:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1fbc:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1fc0:	8082                	ret

0000000000001fc2 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1fc2:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1fc4:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1fc8:	00000073          	ecall
    1fcc:	87aa                	mv	a5,a0
    1fce:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1fd2:	97ba                	add	a5,a5,a4
    1fd4:	00f57c63          	bgeu	a0,a5,1fec <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1fd8:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1fdc:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1fe0:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1fe4:	00000073          	ecall
    1fe8:	fef568e3          	bltu	a0,a5,1fd8 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1fec:	4501                	li	a0,0
    1fee:	8082                	ret

0000000000001ff0 <pipe>:
    register long a7 __asm__("a7") = n;
    1ff0:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1ff4:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    1ff8:	2501                	sext.w	a0,a0
    1ffa:	8082                	ret

0000000000001ffc <fstat>:
    register long a7 __asm__("a7") = n;
    1ffc:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2000:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    2004:	2501                	sext.w	a0,a0
    2006:	8082                	ret

0000000000002008 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    2008:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    200a:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    200e:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2010:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    2014:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    2018:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    201c:	0206c163          	bltz	a3,203e <stat+0x36>
    register long a7 __asm__("a7") = n;
    2020:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    2024:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    2026:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2028:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    202c:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    2030:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    2034:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    2036:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    203a:	853e                	mv	a0,a5
    203c:	8082                	ret
        return -1;
    203e:	57fd                	li	a5,-1
    2040:	bfed                	j	203a <stat+0x32>

0000000000002042 <chdir>:
    register long a7 __asm__("a7") = n;
    2042:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    2046:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    204a:	2501                	sext.w	a0,a0
    204c:	8082                	ret

000000000000204e <link>:
    register long a7 __asm__("a7") = n;
    204e:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2052:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    2056:	2501                	sext.w	a0,a0
    2058:	8082                	ret

000000000000205a <unlink>:
    register long a7 __asm__("a7") = n;
    205a:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    205e:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    2062:	2501                	sext.w	a0,a0
    2064:	8082                	ret

0000000000002066 <setpriority>:
    register long a7 __asm__("a7") = n;
    2066:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    206a:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    206e:	8082                	ret

0000000000002070 <getpriority>:
    register long a7 __asm__("a7") = n;
    2070:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    2074:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    2078:	8082                	ret

000000000000207a <sharedmem>:
    register long a7 __asm__("a7") = n;
    207a:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    207e:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    2082:	8082                	ret
