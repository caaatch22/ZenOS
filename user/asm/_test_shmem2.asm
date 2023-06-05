
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_test_shmem2:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a679                	j	138e <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <ucore.h>
#include <string.h>
#include <fcntl.h>

int main(int argc, char *argv[])
{
    1002:	1101                	addi	sp,sp,-32
    void *shmem2 = sharedmem("shmem2", 8192);
    1004:	6589                	lui	a1,0x2
    1006:	00001517          	auipc	a0,0x1
    100a:	08a50513          	addi	a0,a0,138 # 2090 <sharedmem+0xe>
{
    100e:	ec06                	sd	ra,24(sp)
    1010:	e822                	sd	s0,16(sp)
    1012:	e426                	sd	s1,8(sp)
    1014:	e04a                	sd	s2,0(sp)
    void *shmem2 = sharedmem("shmem2", 8192);
    1016:	06c010ef          	jal	ra,2082 <sharedmem>
    101a:	84aa                	mv	s1,a0
    sleep(1000);
    101c:	3e800513          	li	a0,1000
    1020:	7ab000ef          	jal	ra,1fca <sleep>
    void *shmem1 = sharedmem("shmem1", 0);
    1024:	4581                	li	a1,0
    1026:	00001517          	auipc	a0,0x1
    102a:	07250513          	addi	a0,a0,114 # 2098 <sharedmem+0x16>
    102e:	054010ef          	jal	ra,2082 <sharedmem>
    1032:	892a                	mv	s2,a0
    
    sleep(1000);
    1034:	3e800513          	li	a0,1000
    1038:	793000ef          	jal	ra,1fca <sleep>
    printf("[prog 2] shared mem 1 start: %p\n", shmem1);
    103c:	85ca                	mv	a1,s2
    103e:	00001517          	auipc	a0,0x1
    1042:	06250513          	addi	a0,a0,98 # 20a0 <sharedmem+0x1e>
    1046:	3de000ef          	jal	ra,1424 <printf>
    printf("[prog 2] shared mem 2 start: %p\n", shmem2);
    104a:	85a6                	mv	a1,s1
    104c:	00001517          	auipc	a0,0x1
    1050:	07c50513          	addi	a0,a0,124 # 20c8 <sharedmem+0x46>
    1054:	3d0000ef          	jal	ra,1424 <printf>

    char *buf = (char *)shmem2;
    for (int i = 0; i < 8192; i++)
    1058:	409007b3          	neg	a5,s1
    105c:	8b9d                	andi	a5,a5,7
    105e:	8426                	mv	s0,s1
    1060:	2c078763          	beqz	a5,132e <main+0x32c>
    {
        buf[i] = 2;
    1064:	4709                	li	a4,2
    1066:	00e48023          	sb	a4,0(s1)
    for (int i = 0; i < 8192; i++)
    106a:	4685                	li	a3,1
    106c:	2ad78c63          	beq	a5,a3,1324 <main+0x322>
        buf[i] = 2;
    1070:	00e480a3          	sb	a4,1(s1)
    for (int i = 0; i < 8192; i++)
    1074:	4709                	li	a4,2
    1076:	2ae78f63          	beq	a5,a4,1334 <main+0x332>
        buf[i] = 2;
    107a:	00e48123          	sb	a4,2(s1)
    for (int i = 0; i < 8192; i++)
    107e:	468d                	li	a3,3
    1080:	2cd78963          	beq	a5,a3,1352 <main+0x350>
        buf[i] = 2;
    1084:	00e481a3          	sb	a4,3(s1)
    for (int i = 0; i < 8192; i++)
    1088:	4691                	li	a3,4
    108a:	28d78063          	beq	a5,a3,130a <main+0x308>
        buf[i] = 2;
    108e:	00e48223          	sb	a4,4(s1)
    for (int i = 0; i < 8192; i++)
    1092:	4695                	li	a3,5
    1094:	2cd78e63          	beq	a5,a3,1370 <main+0x36e>
        buf[i] = 2;
    1098:	00e482a3          	sb	a4,5(s1)
    for (int i = 0; i < 8192; i++)
    109c:	469d                	li	a3,7
    109e:	2ed79363          	bne	a5,a3,1384 <main+0x382>
        buf[i] = 2;
    10a2:	6689                	lui	a3,0x2
    10a4:	00e48323          	sb	a4,6(s1)
    10a8:	ff968593          	addi	a1,a3,-7 # 1ff9 <pipe+0x1>
    for (int i = 0; i < 8192; i++)
    10ac:	451d                	li	a0,7
    10ae:	6709                	lui	a4,0x2
    10b0:	40f7063b          	subw	a2,a4,a5
    10b4:	0036571b          	srliw	a4,a2,0x3
    10b8:	97a6                	add	a5,a5,s1
    10ba:	070e                	slli	a4,a4,0x3
    10bc:	0006081b          	sext.w	a6,a2
    10c0:	973e                	add	a4,a4,a5
        buf[i] = 2;
    10c2:	00001697          	auipc	a3,0x1
    10c6:	04e6b683          	ld	a3,78(a3) # 2110 <sharedmem+0x8e>
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
        buf[i] = 2;
    10e6:	9626                	add	a2,a2,s1
    10e8:	4709                	li	a4,2
    10ea:	00e60023          	sb	a4,0(a2)
    for (int i = 0; i < 8192; i++)
    10ee:	fff5059b          	addiw	a1,a0,-1
    10f2:	0017861b          	addiw	a2,a5,1
    10f6:	cda1                	beqz	a1,114e <main+0x14c>
        buf[i] = 2;
    10f8:	9626                	add	a2,a2,s1
    10fa:	00e60023          	sb	a4,0(a2)
    for (int i = 0; i < 8192; i++)
    10fe:	ffe5059b          	addiw	a1,a0,-2
    1102:	0027861b          	addiw	a2,a5,2
    1106:	c5a1                	beqz	a1,114e <main+0x14c>
        buf[i] = 2;
    1108:	9626                	add	a2,a2,s1
    110a:	00e60023          	sb	a4,0(a2)
    for (int i = 0; i < 8192; i++)
    110e:	ffd5059b          	addiw	a1,a0,-3
    1112:	0037861b          	addiw	a2,a5,3
    1116:	cd85                	beqz	a1,114e <main+0x14c>
        buf[i] = 2;
    1118:	9626                	add	a2,a2,s1
    111a:	00e60023          	sb	a4,0(a2)
    for (int i = 0; i < 8192; i++)
    111e:	ffc5059b          	addiw	a1,a0,-4
    1122:	0047861b          	addiw	a2,a5,4
    1126:	c585                	beqz	a1,114e <main+0x14c>
        buf[i] = 2;
    1128:	9626                	add	a2,a2,s1
    112a:	00e60023          	sb	a4,0(a2)
    for (int i = 0; i < 8192; i++)
    112e:	ffb5069b          	addiw	a3,a0,-5
    1132:	0057861b          	addiw	a2,a5,5
    1136:	ce81                	beqz	a3,114e <main+0x14c>
        buf[i] = 2;
    1138:	00c486b3          	add	a3,s1,a2
    113c:	00e68023          	sb	a4,0(a3)
    for (int i = 0; i < 8192; i++)
    1140:	4699                	li	a3,6
    1142:	2799                	addiw	a5,a5,6
    1144:	00d50563          	beq	a0,a3,114e <main+0x14c>
        buf[i] = 2;
    1148:	97a6                	add	a5,a5,s1
    114a:	00e78023          	sb	a4,0(a5)
    }
    sleep(1000);
    114e:	3e800513          	li	a0,1000
    1152:	679000ef          	jal	ra,1fca <sleep>

    buf = (char *)shmem1;
    for (int i = 0; i < 8192; i++)
    1156:	412006b3          	neg	a3,s2
    115a:	8a9d                	andi	a3,a3,7
    115c:	1c068163          	beqz	a3,131e <main+0x31c>
    {
        buf[i] += 2;
    1160:	00094783          	lbu	a5,0(s2)
    1164:	4705                	li	a4,1
    1166:	2789                	addiw	a5,a5,2
    1168:	00f90023          	sb	a5,0(s2)
    for (int i = 0; i < 8192; i++)
    116c:	1ae68463          	beq	a3,a4,1314 <main+0x312>
        buf[i] += 2;
    1170:	00194783          	lbu	a5,1(s2)
    1174:	4709                	li	a4,2
    1176:	2789                	addiw	a5,a5,2
    1178:	00f900a3          	sb	a5,1(s2)
    for (int i = 0; i < 8192; i++)
    117c:	1ce68163          	beq	a3,a4,133e <main+0x33c>
        buf[i] += 2;
    1180:	00294783          	lbu	a5,2(s2)
    1184:	470d                	li	a4,3
    1186:	2789                	addiw	a5,a5,2
    1188:	00f90123          	sb	a5,2(s2)
    for (int i = 0; i < 8192; i++)
    118c:	1ae68e63          	beq	a3,a4,1348 <main+0x346>
        buf[i] += 2;
    1190:	00394783          	lbu	a5,3(s2)
    1194:	4711                	li	a4,4
    1196:	2789                	addiw	a5,a5,2
    1198:	00f901a3          	sb	a5,3(s2)
    for (int i = 0; i < 8192; i++)
    119c:	1ce68063          	beq	a3,a4,135c <main+0x35a>
        buf[i] += 2;
    11a0:	00494783          	lbu	a5,4(s2)
    11a4:	4715                	li	a4,5
    11a6:	2789                	addiw	a5,a5,2
    11a8:	00f90223          	sb	a5,4(s2)
    for (int i = 0; i < 8192; i++)
    11ac:	1ae68d63          	beq	a3,a4,1366 <main+0x364>
        buf[i] += 2;
    11b0:	00594783          	lbu	a5,5(s2)
    11b4:	471d                	li	a4,7
    11b6:	2789                	addiw	a5,a5,2
    11b8:	00f902a3          	sb	a5,5(s2)
    for (int i = 0; i < 8192; i++)
    11bc:	1ae69f63          	bne	a3,a4,137a <main+0x378>
        buf[i] += 2;
    11c0:	00694783          	lbu	a5,6(s2)
    11c4:	6709                	lui	a4,0x2
    11c6:	ff970e13          	addi	t3,a4,-7 # 1ff9 <pipe+0x1>
    11ca:	2789                	addiw	a5,a5,2
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
    11ec:	f285b583          	ld	a1,-216(a1) # 2110 <sharedmem+0x8e>
    11f0:	00001897          	auipc	a7,0x1
    11f4:	f288b883          	ld	a7,-216(a7) # 2118 <sharedmem+0x96>
    11f8:	00001817          	auipc	a6,0x1
    11fc:	f2883803          	ld	a6,-216(a6) # 2120 <sharedmem+0x9e>
        buf[i] += 2;
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
        buf[i] += 2;
    1232:	96ca                	add	a3,a3,s2
    1234:	0006c503          	lbu	a0,0(a3)
    for (int i = 0; i < 8192; i++)
    1238:	fff8079b          	addiw	a5,a6,-1
    123c:	0015861b          	addiw	a2,a1,1
        buf[i] += 2;
    1240:	2509                	addiw	a0,a0,2
    1242:	00a68023          	sb	a0,0(a3)
    for (int i = 0; i < 8192; i++)
    1246:	c3c1                	beqz	a5,12c6 <main+0x2c4>
        buf[i] += 2;
    1248:	00c906b3          	add	a3,s2,a2
    124c:	0006c503          	lbu	a0,0(a3)
    for (int i = 0; i < 8192; i++)
    1250:	ffe8079b          	addiw	a5,a6,-2
    1254:	0025861b          	addiw	a2,a1,2
        buf[i] += 2;
    1258:	2509                	addiw	a0,a0,2
    125a:	00a68023          	sb	a0,0(a3)
    for (int i = 0; i < 8192; i++)
    125e:	c7a5                	beqz	a5,12c6 <main+0x2c4>
        buf[i] += 2;
    1260:	964a                	add	a2,a2,s2
    1262:	00064503          	lbu	a0,0(a2)
    for (int i = 0; i < 8192; i++)
    1266:	ffd8079b          	addiw	a5,a6,-3
    126a:	0035869b          	addiw	a3,a1,3
        buf[i] += 2;
    126e:	2509                	addiw	a0,a0,2
    1270:	00a60023          	sb	a0,0(a2)
    for (int i = 0; i < 8192; i++)
    1274:	cba9                	beqz	a5,12c6 <main+0x2c4>
        buf[i] += 2;
    1276:	96ca                	add	a3,a3,s2
    1278:	0006c503          	lbu	a0,0(a3)
    for (int i = 0; i < 8192; i++)
    127c:	ffc8079b          	addiw	a5,a6,-4
    1280:	0045861b          	addiw	a2,a1,4
        buf[i] += 2;
    1284:	2509                	addiw	a0,a0,2
    1286:	00a68023          	sb	a0,0(a3)
    for (int i = 0; i < 8192; i++)
    128a:	cf95                	beqz	a5,12c6 <main+0x2c4>
        buf[i] += 2;
    128c:	964a                	add	a2,a2,s2
    128e:	00064783          	lbu	a5,0(a2)
    for (int i = 0; i < 8192; i++)
    1292:	ffb8071b          	addiw	a4,a6,-5
    1296:	0055869b          	addiw	a3,a1,5
        buf[i] += 2;
    129a:	2789                	addiw	a5,a5,2
    129c:	00f60023          	sb	a5,0(a2)
    for (int i = 0; i < 8192; i++)
    12a0:	c31d                	beqz	a4,12c6 <main+0x2c4>
        buf[i] += 2;
    12a2:	00d90733          	add	a4,s2,a3
    12a6:	00074683          	lbu	a3,0(a4)
    for (int i = 0; i < 8192; i++)
    12aa:	4619                	li	a2,6
    12ac:	0065879b          	addiw	a5,a1,6
        buf[i] += 2;
    12b0:	2689                	addiw	a3,a3,2
    12b2:	00d70023          	sb	a3,0(a4)
    for (int i = 0; i < 8192; i++)
    12b6:	00c80863          	beq	a6,a2,12c6 <main+0x2c4>
        buf[i] += 2;
    12ba:	993e                	add	s2,s2,a5
    12bc:	00094783          	lbu	a5,0(s2)
    12c0:	2789                	addiw	a5,a5,2
    12c2:	00f90023          	sb	a5,0(s2)
    }
    sleep(1000);
    12c6:	3e800513          	li	a0,1000
    12ca:	501000ef          	jal	ra,1fca <sleep>

    buf = (char *)shmem2;
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
    12e0:	43d000ef          	jal	ra,1f1c <exit>
    for (int i = 0; i < 8192; i++)
    12e4:	fe9418e3          	bne	s0,s1,12d4 <main+0x2d2>
        }
    }
    sleep(1000);
    12e8:	3e800513          	li	a0,1000
    12ec:	4df000ef          	jal	ra,1fca <sleep>

    printf("[prog 2] check good\n");
    12f0:	00001517          	auipc	a0,0x1
    12f4:	e0050513          	addi	a0,a0,-512 # 20f0 <sharedmem+0x6e>
    12f8:	12c000ef          	jal	ra,1424 <printf>

    return 0;
    12fc:	60e2                	ld	ra,24(sp)
    12fe:	6442                	ld	s0,16(sp)
    1300:	64a2                	ld	s1,8(sp)
    1302:	6902                	ld	s2,0(sp)
    1304:	4501                	li	a0,0
    1306:	6105                	addi	sp,sp,32
    1308:	8082                	ret
        buf[i] = 2;
    130a:	6689                	lui	a3,0x2
    130c:	ffc68593          	addi	a1,a3,-4 # 1ffc <pipe+0x4>
    for (int i = 0; i < 8192; i++)
    1310:	4511                	li	a0,4
    1312:	bb71                	j	10ae <main+0xac>
        buf[i] += 2;
    1314:	6709                	lui	a4,0x2
    1316:	fff70e13          	addi	t3,a4,-1 # 1fff <pipe+0x7>
    for (int i = 0; i < 8192; i++)
    131a:	4f05                	li	t5,1
    131c:	bd5d                	j	11d2 <main+0x1d0>
    sleep(1000);
    131e:	6e09                	lui	t3,0x2
    for (int i = 0; i < 8192; i++)
    1320:	4f01                	li	t5,0
    1322:	bd45                	j	11d2 <main+0x1d0>
        buf[i] = 2;
    1324:	6689                	lui	a3,0x2
    1326:	fff68593          	addi	a1,a3,-1 # 1fff <pipe+0x7>
    for (int i = 0; i < 8192; i++)
    132a:	4505                	li	a0,1
    132c:	b349                	j	10ae <main+0xac>
    printf("[prog 2] shared mem 2 start: %p\n", shmem2);
    132e:	6589                	lui	a1,0x2
    for (int i = 0; i < 8192; i++)
    1330:	4501                	li	a0,0
    1332:	bbb5                	j	10ae <main+0xac>
        buf[i] = 2;
    1334:	6689                	lui	a3,0x2
    1336:	ffe68593          	addi	a1,a3,-2 # 1ffe <pipe+0x6>
    for (int i = 0; i < 8192; i++)
    133a:	4509                	li	a0,2
    133c:	bb8d                	j	10ae <main+0xac>
        buf[i] += 2;
    133e:	6709                	lui	a4,0x2
    1340:	ffe70e13          	addi	t3,a4,-2 # 1ffe <pipe+0x6>
    for (int i = 0; i < 8192; i++)
    1344:	4f09                	li	t5,2
    1346:	b571                	j	11d2 <main+0x1d0>
        buf[i] += 2;
    1348:	6709                	lui	a4,0x2
    134a:	ffd70e13          	addi	t3,a4,-3 # 1ffd <pipe+0x5>
    for (int i = 0; i < 8192; i++)
    134e:	4f0d                	li	t5,3
    1350:	b549                	j	11d2 <main+0x1d0>
        buf[i] = 2;
    1352:	6689                	lui	a3,0x2
    1354:	ffd68593          	addi	a1,a3,-3 # 1ffd <pipe+0x5>
    for (int i = 0; i < 8192; i++)
    1358:	450d                	li	a0,3
    135a:	bb91                	j	10ae <main+0xac>
        buf[i] += 2;
    135c:	6709                	lui	a4,0x2
    135e:	ffc70e13          	addi	t3,a4,-4 # 1ffc <pipe+0x4>
    for (int i = 0; i < 8192; i++)
    1362:	4f11                	li	t5,4
    1364:	b5bd                	j	11d2 <main+0x1d0>
        buf[i] += 2;
    1366:	6709                	lui	a4,0x2
    1368:	ffb70e13          	addi	t3,a4,-5 # 1ffb <pipe+0x3>
    for (int i = 0; i < 8192; i++)
    136c:	4f15                	li	t5,5
    136e:	b595                	j	11d2 <main+0x1d0>
        buf[i] = 2;
    1370:	6689                	lui	a3,0x2
    1372:	ffb68593          	addi	a1,a3,-5 # 1ffb <pipe+0x3>
    for (int i = 0; i < 8192; i++)
    1376:	4515                	li	a0,5
    1378:	bb1d                	j	10ae <main+0xac>
        buf[i] += 2;
    137a:	6709                	lui	a4,0x2
    137c:	ffa70e13          	addi	t3,a4,-6 # 1ffa <pipe+0x2>
    for (int i = 0; i < 8192; i++)
    1380:	4f19                	li	t5,6
    1382:	bd81                	j	11d2 <main+0x1d0>
        buf[i] = 2;
    1384:	6689                	lui	a3,0x2
    1386:	ffa68593          	addi	a1,a3,-6 # 1ffa <pipe+0x2>
    for (int i = 0; i < 8192; i++)
    138a:	4519                	li	a0,6
    138c:	b30d                	j	10ae <main+0xac>

000000000000138e <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    138e:	1141                	addi	sp,sp,-16
    1390:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    1392:	c71ff0ef          	jal	ra,1002 <main>
}
    1396:	60a2                	ld	ra,8(sp)
    1398:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    139a:	3830006f          	j	1f1c <exit>

000000000000139e <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    139e:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    13a0:	00f10593          	addi	a1,sp,15
    13a4:	4605                	li	a2,1
    13a6:	4501                	li	a0,0
int getchar() {
    13a8:	ec06                	sd	ra,24(sp)
    char byte = 0;
    13aa:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    13ae:	379000ef          	jal	ra,1f26 <read>
    return byte;
}
    13b2:	60e2                	ld	ra,24(sp)
    13b4:	00f14503          	lbu	a0,15(sp)
    13b8:	6105                	addi	sp,sp,32
    13ba:	8082                	ret

00000000000013bc <putchar>:

int putchar(int c)
{
    13bc:	1141                	addi	sp,sp,-16
    13be:	e406                	sd	ra,8(sp)
    13c0:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    13c2:	00001597          	auipc	a1,0x1
    13c6:	d7658593          	addi	a1,a1,-650 # 2138 <put.1156>
    return write(stdout, put, 1);
    13ca:	4605                	li	a2,1
    13cc:	4505                	li	a0,1
    put[0] = c;
    13ce:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    13d2:	35f000ef          	jal	ra,1f30 <write>
}
    13d6:	60a2                	ld	ra,8(sp)
    13d8:	2501                	sext.w	a0,a0
    13da:	0141                	addi	sp,sp,16
    13dc:	8082                	ret

00000000000013de <puts>:

int puts(const char* s)
{
    13de:	1141                	addi	sp,sp,-16
    13e0:	e022                	sd	s0,0(sp)
    13e2:	e406                	sd	ra,8(sp)
    13e4:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    13e6:	66e000ef          	jal	ra,1a54 <strlen>
    13ea:	862a                	mv	a2,a0
    13ec:	85a2                	mv	a1,s0
    13ee:	4505                	li	a0,1
    13f0:	341000ef          	jal	ra,1f30 <write>
    13f4:	00055763          	bgez	a0,1402 <puts+0x24>
    return r;
}
    13f8:	60a2                	ld	ra,8(sp)
    13fa:	6402                	ld	s0,0(sp)
    13fc:	557d                	li	a0,-1
    13fe:	0141                	addi	sp,sp,16
    1400:	8082                	ret
    put[0] = c;
    1402:	00001597          	auipc	a1,0x1
    1406:	d3658593          	addi	a1,a1,-714 # 2138 <put.1156>
    140a:	47a9                	li	a5,10
    return write(stdout, put, 1);
    140c:	4605                	li	a2,1
    140e:	4505                	li	a0,1
    put[0] = c;
    1410:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    1414:	31d000ef          	jal	ra,1f30 <write>
}
    1418:	60a2                	ld	ra,8(sp)
    141a:	6402                	ld	s0,0(sp)
    141c:	41f5551b          	sraiw	a0,a0,0x1f
    1420:	0141                	addi	sp,sp,16
    1422:	8082                	ret

0000000000001424 <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    1424:	7115                	addi	sp,sp,-224
    1426:	ed06                	sd	ra,152(sp)
    1428:	e922                	sd	s0,144(sp)
    142a:	e526                	sd	s1,136(sp)
    142c:	e14a                	sd	s2,128(sp)
    142e:	fcce                	sd	s3,120(sp)
    1430:	f8d2                	sd	s4,112(sp)
    1432:	f4d6                	sd	s5,104(sp)
    1434:	f0da                	sd	s6,96(sp)
    1436:	ecde                	sd	s7,88(sp)
    1438:	e8e2                	sd	s8,80(sp)
    143a:	e4e6                	sd	s9,72(sp)
    143c:	e0ea                	sd	s10,64(sp)
    143e:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1440:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    1444:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    1446:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    1448:	f52e                	sd	a1,168(sp)
    144a:	f932                	sd	a2,176(sp)
    144c:	fd36                	sd	a3,184(sp)
    144e:	e1ba                	sd	a4,192(sp)
    1450:	e9c2                	sd	a6,208(sp)
    1452:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    1454:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1456:	0c030b63          	beqz	t1,152c <printf+0x108>
    145a:	8aaa                	mv	s5,a0
    145c:	0003071b          	sext.w	a4,t1
    1460:	4481                	li	s1,0
        if (c != '%') {
    1462:	02500b93          	li	s7,37
    put[0] = c;
    1466:	00001417          	auipc	s0,0x1
    146a:	cd240413          	addi	s0,s0,-814 # 2138 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    146e:	4c51                	li	s8,20
    put[0] = c;
    1470:	02500c93          	li	s9,37
    1474:	00001a17          	auipc	s4,0x1
    1478:	ccca0a13          	addi	s4,s4,-820 # 2140 <put.1156+0x8>
    147c:	00001997          	auipc	s3,0x1
    1480:	d1c98993          	addi	s3,s3,-740 # 2198 <digits>
    1484:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    1488:	0014879b          	addiw	a5,s1,1
    148c:	00fa8933          	add	s2,s5,a5
    1490:	13771163          	bne	a4,s7,15b2 <printf+0x18e>
        c = fmt[++i] & 0xff;
    1494:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    1498:	080d0a63          	beqz	s10,152c <printf+0x108>
        switch (c) {
    149c:	2489                	addiw	s1,s1,2
    149e:	009a8933          	add	s2,s5,s1
    14a2:	257d0e63          	beq	s10,s7,16fe <printf+0x2da>
    14a6:	f9cd079b          	addiw	a5,s10,-100
    14aa:	0ff7f793          	andi	a5,a5,255
    14ae:	0cfc6263          	bltu	s8,a5,1572 <printf+0x14e>
    14b2:	078a                	slli	a5,a5,0x2
    14b4:	97d2                	add	a5,a5,s4
    14b6:	439c                	lw	a5,0(a5)
    14b8:	97d2                	add	a5,a5,s4
    14ba:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    14bc:	67a2                	ld	a5,8(sp)
    14be:	4398                	lw	a4,0(a5)
    14c0:	07a1                	addi	a5,a5,8
    14c2:	e43e                	sd	a5,8(sp)
    14c4:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    14c8:	26074663          	bltz	a4,1734 <printf+0x310>
        buf[i++] = digits[x % base];
    14cc:	8bbd                	andi	a5,a5,15
    14ce:	97ce                	add	a5,a5,s3
    14d0:	0007c783          	lbu	a5,0(a5) # 2000 <pipe+0x8>
    } while ((x /= base) != 0);
    14d4:	40475d1b          	sraiw	s10,a4,0x4
    14d8:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    14dc:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    14e0:	020d0163          	beqz	s10,1502 <printf+0xde>
        buf[i++] = digits[x % base];
    14e4:	9d4e                	add	s10,s10,s3
    14e6:	000d4783          	lbu	a5,0(s10)
    14ea:	4d05                	li	s10,1
    14ec:	00f108a3          	sb	a5,17(sp)
    if (sign)
    14f0:	00075963          	bgez	a4,1502 <printf+0xde>
        buf[i++] = digits[x % base];
    14f4:	4d09                	li	s10,2
        buf[i++] = '-';
    14f6:	181c                	addi	a5,sp,48
    14f8:	02d00713          	li	a4,45
    14fc:	97ea                	add	a5,a5,s10
    14fe:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    1502:	9d5a                	add	s10,s10,s6
    1504:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1508:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    150c:	4605                	li	a2,1
    150e:	1d7d                	addi	s10,s10,-1
    1510:	85a2                	mv	a1,s0
    1512:	4505                	li	a0,1
    put[0] = c;
    1514:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1518:	219000ef          	jal	ra,1f30 <write>
    while (--i >= 0)
    151c:	ffbd16e3          	bne	s10,s11,1508 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1520:	00094303          	lbu	t1,0(s2)
    1524:	0003071b          	sext.w	a4,t1
    1528:	f60310e3          	bnez	t1,1488 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    152c:	60ea                	ld	ra,152(sp)
    152e:	644a                	ld	s0,144(sp)
    1530:	64aa                	ld	s1,136(sp)
    1532:	690a                	ld	s2,128(sp)
    1534:	79e6                	ld	s3,120(sp)
    1536:	7a46                	ld	s4,112(sp)
    1538:	7aa6                	ld	s5,104(sp)
    153a:	7b06                	ld	s6,96(sp)
    153c:	6be6                	ld	s7,88(sp)
    153e:	6c46                	ld	s8,80(sp)
    1540:	6ca6                	ld	s9,72(sp)
    1542:	6d06                	ld	s10,64(sp)
    1544:	7de2                	ld	s11,56(sp)
    1546:	612d                	addi	sp,sp,224
    1548:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    154a:	67a2                	ld	a5,8(sp)
    154c:	0007bd03          	ld	s10,0(a5)
    1550:	07a1                	addi	a5,a5,8
    1552:	e43e                	sd	a5,8(sp)
    1554:	000d1b63          	bnez	s10,156a <printf+0x146>
    1558:	aafd                	j	1756 <printf+0x332>
    return write(stdout, put, 1);
    155a:	4605                	li	a2,1
    155c:	85a2                	mv	a1,s0
    155e:	4505                	li	a0,1
                for (; *s; s++)
    1560:	0d05                	addi	s10,s10,1
    put[0] = c;
    1562:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1566:	1cb000ef          	jal	ra,1f30 <write>
                for (; *s; s++)
    156a:	000d4783          	lbu	a5,0(s10)
    156e:	f7f5                	bnez	a5,155a <printf+0x136>
    1570:	a02d                	j	159a <printf+0x176>
    return write(stdout, put, 1);
    1572:	4605                	li	a2,1
    1574:	00001597          	auipc	a1,0x1
    1578:	bc458593          	addi	a1,a1,-1084 # 2138 <put.1156>
    157c:	4505                	li	a0,1
    put[0] = c;
    157e:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    1582:	1af000ef          	jal	ra,1f30 <write>
    1586:	4605                	li	a2,1
    1588:	00001597          	auipc	a1,0x1
    158c:	bb058593          	addi	a1,a1,-1104 # 2138 <put.1156>
    1590:	4505                	li	a0,1
    put[0] = c;
    1592:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    1596:	19b000ef          	jal	ra,1f30 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    159a:	00094303          	lbu	t1,0(s2)
    159e:	0003071b          	sext.w	a4,t1
    15a2:	f80305e3          	beqz	t1,152c <printf+0x108>
        if (c != '%') {
    15a6:	0014879b          	addiw	a5,s1,1
    15aa:	00fa8933          	add	s2,s5,a5
    15ae:	ef7703e3          	beq	a4,s7,1494 <printf+0x70>
    return write(stdout, put, 1);
    15b2:	4605                	li	a2,1
    15b4:	00001597          	auipc	a1,0x1
    15b8:	b8458593          	addi	a1,a1,-1148 # 2138 <put.1156>
    15bc:	4505                	li	a0,1
    put[0] = c;
    15be:	00640023          	sb	t1,0(s0)
            continue;
    15c2:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    15c4:	16d000ef          	jal	ra,1f30 <write>
            continue;
    15c8:	bfc9                	j	159a <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    15ca:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    15cc:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    15ce:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    15d0:	0007b883          	ld	a7,0(a5)
    15d4:	07a1                	addi	a5,a5,8
    15d6:	e43e                	sd	a5,8(sp)
        x = -xx;
    15d8:	43f8d713          	srai	a4,a7,0x3f
    15dc:	011747b3          	xor	a5,a4,a7
    15e0:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    15e2:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    15e4:	02c7f733          	remu	a4,a5,a2
    15e8:	8d36                	mv	s10,a3
    15ea:	0685                	addi	a3,a3,1
    15ec:	00db0533          	add	a0,s6,a3
    15f0:	85be                	mv	a1,a5
    15f2:	974e                	add	a4,a4,s3
    15f4:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    15f8:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    15fc:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    1600:	feb862e3          	bltu	a6,a1,15e4 <printf+0x1c0>
    if (sign)
    1604:	1208c063          	bltz	a7,1724 <printf+0x300>
    while (--i >= 0)
    1608:	9d5a                	add	s10,s10,s6
    put[0] = c;
    160a:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    160e:	4605                	li	a2,1
    1610:	85a2                	mv	a1,s0
    1612:	4505                	li	a0,1
    put[0] = c;
    1614:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1618:	119000ef          	jal	ra,1f30 <write>
    while (--i >= 0)
    161c:	87ea                	mv	a5,s10
    161e:	1d7d                	addi	s10,s10,-1
    1620:	fefb15e3          	bne	s6,a5,160a <printf+0x1e6>
    1624:	bf9d                	j	159a <printf+0x176>
                printptr(va_arg(ap, uint64));
    1626:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    1628:	4605                	li	a2,1
    162a:	00001597          	auipc	a1,0x1
    162e:	b0e58593          	addi	a1,a1,-1266 # 2138 <put.1156>
                printptr(va_arg(ap, uint64));
    1632:	0007bd83          	ld	s11,0(a5)
    1636:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    163a:	4505                	li	a0,1
    put[0] = c;
    163c:	03000793          	li	a5,48
    1640:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    1644:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    1646:	0eb000ef          	jal	ra,1f30 <write>
    put[0] = c;
    164a:	07800793          	li	a5,120
    return write(stdout, put, 1);
    164e:	4605                	li	a2,1
    1650:	00001597          	auipc	a1,0x1
    1654:	ae858593          	addi	a1,a1,-1304 # 2138 <put.1156>
    1658:	4505                	li	a0,1
    put[0] = c;
    165a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    165e:	4d41                	li	s10,16
    1660:	0d1000ef          	jal	ra,1f30 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    1664:	03cdd793          	srli	a5,s11,0x3c
    1668:	97ce                	add	a5,a5,s3
    put[0] = c;
    166a:	0007c783          	lbu	a5,0(a5)
    166e:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    1670:	4605                	li	a2,1
    1672:	85a2                	mv	a1,s0
    1674:	4505                	li	a0,1
    put[0] = c;
    1676:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    167a:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    167c:	0b5000ef          	jal	ra,1f30 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1680:	fe0d12e3          	bnez	s10,1664 <printf+0x240>
    1684:	bf19                	j	159a <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    1686:	67a2                	ld	a5,8(sp)
    1688:	4394                	lw	a3,0(a5)
    168a:	07a1                	addi	a5,a5,8
    168c:	e43e                	sd	a5,8(sp)
    168e:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    1692:	0006d663          	bgez	a3,169e <printf+0x27a>
        x = -xx;
    1696:	40f007bb          	negw	a5,a5
    169a:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    169e:	4729                	li	a4,10
    16a0:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    16a4:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    16a8:	964e                	add	a2,a2,s3
    16aa:	00064603          	lbu	a2,0(a2)
    16ae:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    16b2:	0a0d0963          	beqz	s10,1764 <printf+0x340>
        buf[i++] = digits[x % base];
    16b6:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    16ba:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    16be:	00c98733          	add	a4,s3,a2
    16c2:	00074703          	lbu	a4,0(a4)
    16c6:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    16ca:	c3cd                	beqz	a5,176c <printf+0x348>
        buf[i++] = digits[x % base];
    16cc:	97ce                	add	a5,a5,s3
    16ce:	0007c703          	lbu	a4,0(a5)
    16d2:	4d09                	li	s10,2
    16d4:	478d                	li	a5,3
    16d6:	00e10923          	sb	a4,18(sp)
    if (sign)
    16da:	0206cd63          	bltz	a3,1714 <printf+0x2f0>
    while (--i >= 0)
    16de:	9d5a                	add	s10,s10,s6
    16e0:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    16e4:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    16e8:	4605                	li	a2,1
    16ea:	1d7d                	addi	s10,s10,-1
    16ec:	85a2                	mv	a1,s0
    16ee:	4505                	li	a0,1
    put[0] = c;
    16f0:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    16f4:	03d000ef          	jal	ra,1f30 <write>
    while (--i >= 0)
    16f8:	ffbd16e3          	bne	s10,s11,16e4 <printf+0x2c0>
    16fc:	bd79                	j	159a <printf+0x176>
    return write(stdout, put, 1);
    16fe:	4605                	li	a2,1
    1700:	00001597          	auipc	a1,0x1
    1704:	a3858593          	addi	a1,a1,-1480 # 2138 <put.1156>
    1708:	4505                	li	a0,1
    put[0] = c;
    170a:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    170e:	023000ef          	jal	ra,1f30 <write>
    1712:	b561                	j	159a <printf+0x176>
        buf[i++] = '-';
    1714:	1818                	addi	a4,sp,48
    1716:	973e                	add	a4,a4,a5
    1718:	02d00693          	li	a3,45
    171c:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    1720:	8d3e                	mv	s10,a5
    1722:	bf75                	j	16de <printf+0x2ba>
        buf[i++] = '-';
    1724:	181c                	addi	a5,sp,48
    1726:	97b6                	add	a5,a5,a3
    1728:	02d00713          	li	a4,45
    172c:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    1730:	8d36                	mv	s10,a3
    1732:	bdd9                	j	1608 <printf+0x1e4>
        x = -xx;
    1734:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    1738:	00f7f693          	andi	a3,a5,15
    173c:	96ce                	add	a3,a3,s3
    173e:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    1742:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    1746:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    174a:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    174e:	d80d1be3          	bnez	s10,14e4 <printf+0xc0>
        buf[i++] = digits[x % base];
    1752:	4d05                	li	s10,1
    1754:	b34d                	j	14f6 <printf+0xd2>
                s = "(null)";
    1756:	00001d17          	auipc	s10,0x1
    175a:	9b2d0d13          	addi	s10,s10,-1614 # 2108 <sharedmem+0x86>
                for (; *s; s++)
    175e:	02800793          	li	a5,40
    1762:	bbe5                	j	155a <printf+0x136>
        buf[i++] = digits[x % base];
    1764:	4785                	li	a5,1
    if (sign)
    1766:	f606dce3          	bgez	a3,16de <printf+0x2ba>
    176a:	b76d                	j	1714 <printf+0x2f0>
        buf[i++] = digits[x % base];
    176c:	4789                	li	a5,2
    176e:	4d05                	li	s10,1
    if (sign)
    1770:	f606d7e3          	bgez	a3,16de <printf+0x2ba>
    1774:	b745                	j	1714 <printf+0x2f0>

0000000000001776 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1776:	02000793          	li	a5,32
    177a:	00f50663          	beq	a0,a5,1786 <isspace+0x10>
    177e:	355d                	addiw	a0,a0,-9
    1780:	00553513          	sltiu	a0,a0,5
    1784:	8082                	ret
    1786:	4505                	li	a0,1
}
    1788:	8082                	ret

000000000000178a <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    178a:	fd05051b          	addiw	a0,a0,-48
}
    178e:	00a53513          	sltiu	a0,a0,10
    1792:	8082                	ret

0000000000001794 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1794:	02000613          	li	a2,32
    1798:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    179a:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    179e:	ff77069b          	addiw	a3,a4,-9
    17a2:	04c70d63          	beq	a4,a2,17fc <atoi+0x68>
    17a6:	0007079b          	sext.w	a5,a4
    17aa:	04d5f963          	bgeu	a1,a3,17fc <atoi+0x68>
        s++;
    switch (*s) {
    17ae:	02b00693          	li	a3,43
    17b2:	04d70a63          	beq	a4,a3,1806 <atoi+0x72>
    17b6:	02d00693          	li	a3,45
    17ba:	06d70463          	beq	a4,a3,1822 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    17be:	fd07859b          	addiw	a1,a5,-48
    17c2:	4625                	li	a2,9
    17c4:	873e                	mv	a4,a5
    17c6:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    17c8:	4e01                	li	t3,0
    while (isdigit(*s))
    17ca:	04b66a63          	bltu	a2,a1,181e <atoi+0x8a>
    int n = 0, neg = 0;
    17ce:	4501                	li	a0,0
    while (isdigit(*s))
    17d0:	4825                	li	a6,9
    17d2:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    17d6:	0025179b          	slliw	a5,a0,0x2
    17da:	9d3d                	addw	a0,a0,a5
    17dc:	fd07031b          	addiw	t1,a4,-48
    17e0:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    17e4:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    17e8:	0685                	addi	a3,a3,1
    17ea:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    17ee:	0006071b          	sext.w	a4,a2
    17f2:	feb870e3          	bgeu	a6,a1,17d2 <atoi+0x3e>
    return neg ? n : -n;
    17f6:	000e0563          	beqz	t3,1800 <atoi+0x6c>
}
    17fa:	8082                	ret
        s++;
    17fc:	0505                	addi	a0,a0,1
    17fe:	bf71                	j	179a <atoi+0x6>
    1800:	4113053b          	subw	a0,t1,a7
    1804:	8082                	ret
    while (isdigit(*s))
    1806:	00154783          	lbu	a5,1(a0)
    180a:	4625                	li	a2,9
        s++;
    180c:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1810:	fd07859b          	addiw	a1,a5,-48
    1814:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1818:	4e01                	li	t3,0
    while (isdigit(*s))
    181a:	fab67ae3          	bgeu	a2,a1,17ce <atoi+0x3a>
    181e:	4501                	li	a0,0
}
    1820:	8082                	ret
    while (isdigit(*s))
    1822:	00154783          	lbu	a5,1(a0)
    1826:	4625                	li	a2,9
        s++;
    1828:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    182c:	fd07859b          	addiw	a1,a5,-48
    1830:	0007871b          	sext.w	a4,a5
    1834:	feb665e3          	bltu	a2,a1,181e <atoi+0x8a>
        neg = 1;
    1838:	4e05                	li	t3,1
    183a:	bf51                	j	17ce <atoi+0x3a>

000000000000183c <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    183c:	16060d63          	beqz	a2,19b6 <memset+0x17a>
    1840:	40a007b3          	neg	a5,a0
    1844:	8b9d                	andi	a5,a5,7
    1846:	00778713          	addi	a4,a5,7
    184a:	482d                	li	a6,11
    184c:	0ff5f593          	andi	a1,a1,255
    1850:	fff60693          	addi	a3,a2,-1
    1854:	17076263          	bltu	a4,a6,19b8 <memset+0x17c>
    1858:	16e6ea63          	bltu	a3,a4,19cc <memset+0x190>
    185c:	16078563          	beqz	a5,19c6 <memset+0x18a>
    1860:	00b50023          	sb	a1,0(a0)
    1864:	4705                	li	a4,1
    1866:	00150e93          	addi	t4,a0,1
    186a:	14e78c63          	beq	a5,a4,19c2 <memset+0x186>
    186e:	00b500a3          	sb	a1,1(a0)
    1872:	4709                	li	a4,2
    1874:	00250e93          	addi	t4,a0,2
    1878:	14e78d63          	beq	a5,a4,19d2 <memset+0x196>
    187c:	00b50123          	sb	a1,2(a0)
    1880:	470d                	li	a4,3
    1882:	00350e93          	addi	t4,a0,3
    1886:	12e78b63          	beq	a5,a4,19bc <memset+0x180>
    188a:	00b501a3          	sb	a1,3(a0)
    188e:	4711                	li	a4,4
    1890:	00450e93          	addi	t4,a0,4
    1894:	14e78163          	beq	a5,a4,19d6 <memset+0x19a>
    1898:	00b50223          	sb	a1,4(a0)
    189c:	4715                	li	a4,5
    189e:	00550e93          	addi	t4,a0,5
    18a2:	12e78c63          	beq	a5,a4,19da <memset+0x19e>
    18a6:	00b502a3          	sb	a1,5(a0)
    18aa:	471d                	li	a4,7
    18ac:	00650e93          	addi	t4,a0,6
    18b0:	12e79763          	bne	a5,a4,19de <memset+0x1a2>
    18b4:	00750e93          	addi	t4,a0,7
    18b8:	00b50323          	sb	a1,6(a0)
    18bc:	4f1d                	li	t5,7
    18be:	00859713          	slli	a4,a1,0x8
    18c2:	8f4d                	or	a4,a4,a1
    18c4:	01059e13          	slli	t3,a1,0x10
    18c8:	01c76e33          	or	t3,a4,t3
    18cc:	01859313          	slli	t1,a1,0x18
    18d0:	006e6333          	or	t1,t3,t1
    18d4:	02059893          	slli	a7,a1,0x20
    18d8:	011368b3          	or	a7,t1,a7
    18dc:	02859813          	slli	a6,a1,0x28
    18e0:	40f60333          	sub	t1,a2,a5
    18e4:	0108e833          	or	a6,a7,a6
    18e8:	03059693          	slli	a3,a1,0x30
    18ec:	00d866b3          	or	a3,a6,a3
    18f0:	03859713          	slli	a4,a1,0x38
    18f4:	97aa                	add	a5,a5,a0
    18f6:	ff837813          	andi	a6,t1,-8
    18fa:	8f55                	or	a4,a4,a3
    18fc:	00f806b3          	add	a3,a6,a5
    1900:	e398                	sd	a4,0(a5)
    1902:	07a1                	addi	a5,a5,8
    1904:	fed79ee3          	bne	a5,a3,1900 <memset+0xc4>
    1908:	ff837693          	andi	a3,t1,-8
    190c:	00de87b3          	add	a5,t4,a3
    1910:	01e6873b          	addw	a4,a3,t5
    1914:	0ad30663          	beq	t1,a3,19c0 <memset+0x184>
    1918:	00b78023          	sb	a1,0(a5)
    191c:	0017069b          	addiw	a3,a4,1
    1920:	08c6fb63          	bgeu	a3,a2,19b6 <memset+0x17a>
    1924:	00b780a3          	sb	a1,1(a5)
    1928:	0027069b          	addiw	a3,a4,2
    192c:	08c6f563          	bgeu	a3,a2,19b6 <memset+0x17a>
    1930:	00b78123          	sb	a1,2(a5)
    1934:	0037069b          	addiw	a3,a4,3
    1938:	06c6ff63          	bgeu	a3,a2,19b6 <memset+0x17a>
    193c:	00b781a3          	sb	a1,3(a5)
    1940:	0047069b          	addiw	a3,a4,4
    1944:	06c6f963          	bgeu	a3,a2,19b6 <memset+0x17a>
    1948:	00b78223          	sb	a1,4(a5)
    194c:	0057069b          	addiw	a3,a4,5
    1950:	06c6f363          	bgeu	a3,a2,19b6 <memset+0x17a>
    1954:	00b782a3          	sb	a1,5(a5)
    1958:	0067069b          	addiw	a3,a4,6
    195c:	04c6fd63          	bgeu	a3,a2,19b6 <memset+0x17a>
    1960:	00b78323          	sb	a1,6(a5)
    1964:	0077069b          	addiw	a3,a4,7
    1968:	04c6f763          	bgeu	a3,a2,19b6 <memset+0x17a>
    196c:	00b783a3          	sb	a1,7(a5)
    1970:	0087069b          	addiw	a3,a4,8
    1974:	04c6f163          	bgeu	a3,a2,19b6 <memset+0x17a>
    1978:	00b78423          	sb	a1,8(a5)
    197c:	0097069b          	addiw	a3,a4,9
    1980:	02c6fb63          	bgeu	a3,a2,19b6 <memset+0x17a>
    1984:	00b784a3          	sb	a1,9(a5)
    1988:	00a7069b          	addiw	a3,a4,10
    198c:	02c6f563          	bgeu	a3,a2,19b6 <memset+0x17a>
    1990:	00b78523          	sb	a1,10(a5)
    1994:	00b7069b          	addiw	a3,a4,11
    1998:	00c6ff63          	bgeu	a3,a2,19b6 <memset+0x17a>
    199c:	00b785a3          	sb	a1,11(a5)
    19a0:	00c7069b          	addiw	a3,a4,12
    19a4:	00c6f963          	bgeu	a3,a2,19b6 <memset+0x17a>
    19a8:	00b78623          	sb	a1,12(a5)
    19ac:	2735                	addiw	a4,a4,13
    19ae:	00c77463          	bgeu	a4,a2,19b6 <memset+0x17a>
    19b2:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    19b6:	8082                	ret
    19b8:	472d                	li	a4,11
    19ba:	bd79                	j	1858 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    19bc:	4f0d                	li	t5,3
    19be:	b701                	j	18be <memset+0x82>
    19c0:	8082                	ret
    19c2:	4f05                	li	t5,1
    19c4:	bded                	j	18be <memset+0x82>
    19c6:	8eaa                	mv	t4,a0
    19c8:	4f01                	li	t5,0
    19ca:	bdd5                	j	18be <memset+0x82>
    19cc:	87aa                	mv	a5,a0
    19ce:	4701                	li	a4,0
    19d0:	b7a1                	j	1918 <memset+0xdc>
    19d2:	4f09                	li	t5,2
    19d4:	b5ed                	j	18be <memset+0x82>
    19d6:	4f11                	li	t5,4
    19d8:	b5dd                	j	18be <memset+0x82>
    19da:	4f15                	li	t5,5
    19dc:	b5cd                	j	18be <memset+0x82>
    19de:	4f19                	li	t5,6
    19e0:	bdf9                	j	18be <memset+0x82>

00000000000019e2 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    19e2:	00054783          	lbu	a5,0(a0)
    19e6:	0005c703          	lbu	a4,0(a1)
    19ea:	00e79863          	bne	a5,a4,19fa <strcmp+0x18>
    19ee:	0505                	addi	a0,a0,1
    19f0:	0585                	addi	a1,a1,1
    19f2:	fbe5                	bnez	a5,19e2 <strcmp>
    19f4:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    19f6:	9d19                	subw	a0,a0,a4
    19f8:	8082                	ret
    19fa:	0007851b          	sext.w	a0,a5
    19fe:	bfe5                	j	19f6 <strcmp+0x14>

0000000000001a00 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1a00:	87aa                	mv	a5,a0
    1a02:	0005c703          	lbu	a4,0(a1)
    1a06:	0785                	addi	a5,a5,1
    1a08:	0585                	addi	a1,a1,1
    1a0a:	fee78fa3          	sb	a4,-1(a5)
    1a0e:	fb75                	bnez	a4,1a02 <strcpy+0x2>
        ;
    return os;
}
    1a10:	8082                	ret

0000000000001a12 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    1a12:	ce05                	beqz	a2,1a4a <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1a14:	00054703          	lbu	a4,0(a0)
    1a18:	0005c783          	lbu	a5,0(a1)
    1a1c:	cb0d                	beqz	a4,1a4e <strncmp+0x3c>
    if (!n--)
    1a1e:	167d                	addi	a2,a2,-1
    1a20:	00c506b3          	add	a3,a0,a2
    1a24:	a819                	j	1a3a <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1a26:	00a68e63          	beq	a3,a0,1a42 <strncmp+0x30>
    1a2a:	0505                	addi	a0,a0,1
    1a2c:	00e79b63          	bne	a5,a4,1a42 <strncmp+0x30>
    1a30:	00054703          	lbu	a4,0(a0)
    1a34:	0005c783          	lbu	a5,0(a1)
    1a38:	cb19                	beqz	a4,1a4e <strncmp+0x3c>
    1a3a:	0005c783          	lbu	a5,0(a1)
    1a3e:	0585                	addi	a1,a1,1
    1a40:	f3fd                	bnez	a5,1a26 <strncmp+0x14>
        ;
    return *l - *r;
    1a42:	0007051b          	sext.w	a0,a4
    1a46:	9d1d                	subw	a0,a0,a5
    1a48:	8082                	ret
        return 0;
    1a4a:	4501                	li	a0,0
}
    1a4c:	8082                	ret
    1a4e:	4501                	li	a0,0
    return *l - *r;
    1a50:	9d1d                	subw	a0,a0,a5
    1a52:	8082                	ret

0000000000001a54 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    1a54:	00757793          	andi	a5,a0,7
    1a58:	cf89                	beqz	a5,1a72 <strlen+0x1e>
    1a5a:	87aa                	mv	a5,a0
    1a5c:	a029                	j	1a66 <strlen+0x12>
    1a5e:	0785                	addi	a5,a5,1
    1a60:	0077f713          	andi	a4,a5,7
    1a64:	cb01                	beqz	a4,1a74 <strlen+0x20>
        if (!*s)
    1a66:	0007c703          	lbu	a4,0(a5)
    1a6a:	fb75                	bnez	a4,1a5e <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1a6c:	40a78533          	sub	a0,a5,a0
}
    1a70:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1a72:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    1a74:	6394                	ld	a3,0(a5)
    1a76:	00000597          	auipc	a1,0x0
    1a7a:	6b25b583          	ld	a1,1714(a1) # 2128 <sharedmem+0xa6>
    1a7e:	00000617          	auipc	a2,0x0
    1a82:	69a63603          	ld	a2,1690(a2) # 2118 <sharedmem+0x96>
    1a86:	a019                	j	1a8c <strlen+0x38>
    1a88:	6794                	ld	a3,8(a5)
    1a8a:	07a1                	addi	a5,a5,8
    1a8c:	00b68733          	add	a4,a3,a1
    1a90:	fff6c693          	not	a3,a3
    1a94:	8f75                	and	a4,a4,a3
    1a96:	8f71                	and	a4,a4,a2
    1a98:	db65                	beqz	a4,1a88 <strlen+0x34>
    for (; *s; s++)
    1a9a:	0007c703          	lbu	a4,0(a5)
    1a9e:	d779                	beqz	a4,1a6c <strlen+0x18>
    1aa0:	0017c703          	lbu	a4,1(a5)
    1aa4:	0785                	addi	a5,a5,1
    1aa6:	d379                	beqz	a4,1a6c <strlen+0x18>
    1aa8:	0017c703          	lbu	a4,1(a5)
    1aac:	0785                	addi	a5,a5,1
    1aae:	fb6d                	bnez	a4,1aa0 <strlen+0x4c>
    1ab0:	bf75                	j	1a6c <strlen+0x18>

0000000000001ab2 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1ab2:	00757713          	andi	a4,a0,7
{
    1ab6:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1ab8:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1abc:	cb19                	beqz	a4,1ad2 <memchr+0x20>
    1abe:	ce25                	beqz	a2,1b36 <memchr+0x84>
    1ac0:	0007c703          	lbu	a4,0(a5)
    1ac4:	04b70e63          	beq	a4,a1,1b20 <memchr+0x6e>
    1ac8:	0785                	addi	a5,a5,1
    1aca:	0077f713          	andi	a4,a5,7
    1ace:	167d                	addi	a2,a2,-1
    1ad0:	f77d                	bnez	a4,1abe <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    1ad2:	4501                	li	a0,0
    if (n && *s != c) {
    1ad4:	c235                	beqz	a2,1b38 <memchr+0x86>
    1ad6:	0007c703          	lbu	a4,0(a5)
    1ada:	04b70363          	beq	a4,a1,1b20 <memchr+0x6e>
        size_t k = ONES * c;
    1ade:	00000517          	auipc	a0,0x0
    1ae2:	65253503          	ld	a0,1618(a0) # 2130 <sharedmem+0xae>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1ae6:	471d                	li	a4,7
        size_t k = ONES * c;
    1ae8:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1aec:	02c77a63          	bgeu	a4,a2,1b20 <memchr+0x6e>
    1af0:	00000897          	auipc	a7,0x0
    1af4:	6388b883          	ld	a7,1592(a7) # 2128 <sharedmem+0xa6>
    1af8:	00000817          	auipc	a6,0x0
    1afc:	62083803          	ld	a6,1568(a6) # 2118 <sharedmem+0x96>
    1b00:	431d                	li	t1,7
    1b02:	a029                	j	1b0c <memchr+0x5a>
    1b04:	1661                	addi	a2,a2,-8
    1b06:	07a1                	addi	a5,a5,8
    1b08:	02c37963          	bgeu	t1,a2,1b3a <memchr+0x88>
    1b0c:	6398                	ld	a4,0(a5)
    1b0e:	8f29                	xor	a4,a4,a0
    1b10:	011706b3          	add	a3,a4,a7
    1b14:	fff74713          	not	a4,a4
    1b18:	8f75                	and	a4,a4,a3
    1b1a:	01077733          	and	a4,a4,a6
    1b1e:	d37d                	beqz	a4,1b04 <memchr+0x52>
    1b20:	853e                	mv	a0,a5
    1b22:	97b2                	add	a5,a5,a2
    1b24:	a021                	j	1b2c <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1b26:	0505                	addi	a0,a0,1
    1b28:	00f50763          	beq	a0,a5,1b36 <memchr+0x84>
    1b2c:	00054703          	lbu	a4,0(a0)
    1b30:	feb71be3          	bne	a4,a1,1b26 <memchr+0x74>
    1b34:	8082                	ret
    return n ? (void*)s : 0;
    1b36:	4501                	li	a0,0
}
    1b38:	8082                	ret
    return n ? (void*)s : 0;
    1b3a:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1b3c:	f275                	bnez	a2,1b20 <memchr+0x6e>
}
    1b3e:	8082                	ret

0000000000001b40 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1b40:	1101                	addi	sp,sp,-32
    1b42:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1b44:	862e                	mv	a2,a1
{
    1b46:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1b48:	4581                	li	a1,0
{
    1b4a:	e426                	sd	s1,8(sp)
    1b4c:	ec06                	sd	ra,24(sp)
    1b4e:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1b50:	f63ff0ef          	jal	ra,1ab2 <memchr>
    return p ? p - s : n;
    1b54:	c519                	beqz	a0,1b62 <strnlen+0x22>
}
    1b56:	60e2                	ld	ra,24(sp)
    1b58:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1b5a:	8d05                	sub	a0,a0,s1
}
    1b5c:	64a2                	ld	s1,8(sp)
    1b5e:	6105                	addi	sp,sp,32
    1b60:	8082                	ret
    1b62:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1b64:	8522                	mv	a0,s0
}
    1b66:	6442                	ld	s0,16(sp)
    1b68:	64a2                	ld	s1,8(sp)
    1b6a:	6105                	addi	sp,sp,32
    1b6c:	8082                	ret

0000000000001b6e <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1b6e:	00b547b3          	xor	a5,a0,a1
    1b72:	8b9d                	andi	a5,a5,7
    1b74:	eb95                	bnez	a5,1ba8 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1b76:	0075f793          	andi	a5,a1,7
    1b7a:	e7b1                	bnez	a5,1bc6 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1b7c:	6198                	ld	a4,0(a1)
    1b7e:	00000617          	auipc	a2,0x0
    1b82:	5aa63603          	ld	a2,1450(a2) # 2128 <sharedmem+0xa6>
    1b86:	00000817          	auipc	a6,0x0
    1b8a:	59283803          	ld	a6,1426(a6) # 2118 <sharedmem+0x96>
    1b8e:	a029                	j	1b98 <stpcpy+0x2a>
    1b90:	e118                	sd	a4,0(a0)
    1b92:	6598                	ld	a4,8(a1)
    1b94:	05a1                	addi	a1,a1,8
    1b96:	0521                	addi	a0,a0,8
    1b98:	00c707b3          	add	a5,a4,a2
    1b9c:	fff74693          	not	a3,a4
    1ba0:	8ff5                	and	a5,a5,a3
    1ba2:	0107f7b3          	and	a5,a5,a6
    1ba6:	d7ed                	beqz	a5,1b90 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1ba8:	0005c783          	lbu	a5,0(a1)
    1bac:	00f50023          	sb	a5,0(a0)
    1bb0:	c785                	beqz	a5,1bd8 <stpcpy+0x6a>
    1bb2:	0015c783          	lbu	a5,1(a1)
    1bb6:	0505                	addi	a0,a0,1
    1bb8:	0585                	addi	a1,a1,1
    1bba:	00f50023          	sb	a5,0(a0)
    1bbe:	fbf5                	bnez	a5,1bb2 <stpcpy+0x44>
        ;
    return d;
}
    1bc0:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1bc2:	0505                	addi	a0,a0,1
    1bc4:	df45                	beqz	a4,1b7c <stpcpy+0xe>
            if (!(*d = *s))
    1bc6:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1bca:	0585                	addi	a1,a1,1
    1bcc:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1bd0:	00f50023          	sb	a5,0(a0)
    1bd4:	f7fd                	bnez	a5,1bc2 <stpcpy+0x54>
}
    1bd6:	8082                	ret
    1bd8:	8082                	ret

0000000000001bda <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1bda:	00b547b3          	xor	a5,a0,a1
    1bde:	8b9d                	andi	a5,a5,7
    1be0:	1a079863          	bnez	a5,1d90 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1be4:	0075f793          	andi	a5,a1,7
    1be8:	16078463          	beqz	a5,1d50 <stpncpy+0x176>
    1bec:	ea01                	bnez	a2,1bfc <stpncpy+0x22>
    1bee:	a421                	j	1df6 <stpncpy+0x21c>
    1bf0:	167d                	addi	a2,a2,-1
    1bf2:	0505                	addi	a0,a0,1
    1bf4:	14070e63          	beqz	a4,1d50 <stpncpy+0x176>
    1bf8:	1a060863          	beqz	a2,1da8 <stpncpy+0x1ce>
    1bfc:	0005c783          	lbu	a5,0(a1)
    1c00:	0585                	addi	a1,a1,1
    1c02:	0075f713          	andi	a4,a1,7
    1c06:	00f50023          	sb	a5,0(a0)
    1c0a:	f3fd                	bnez	a5,1bf0 <stpncpy+0x16>
    1c0c:	4805                	li	a6,1
    1c0e:	1a061863          	bnez	a2,1dbe <stpncpy+0x1e4>
    1c12:	40a007b3          	neg	a5,a0
    1c16:	8b9d                	andi	a5,a5,7
    1c18:	4681                	li	a3,0
    1c1a:	18061a63          	bnez	a2,1dae <stpncpy+0x1d4>
    1c1e:	00778713          	addi	a4,a5,7
    1c22:	45ad                	li	a1,11
    1c24:	18b76363          	bltu	a4,a1,1daa <stpncpy+0x1d0>
    1c28:	1ae6eb63          	bltu	a3,a4,1dde <stpncpy+0x204>
    1c2c:	1a078363          	beqz	a5,1dd2 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1c30:	00050023          	sb	zero,0(a0)
    1c34:	4685                	li	a3,1
    1c36:	00150713          	addi	a4,a0,1
    1c3a:	18d78f63          	beq	a5,a3,1dd8 <stpncpy+0x1fe>
    1c3e:	000500a3          	sb	zero,1(a0)
    1c42:	4689                	li	a3,2
    1c44:	00250713          	addi	a4,a0,2
    1c48:	18d78e63          	beq	a5,a3,1de4 <stpncpy+0x20a>
    1c4c:	00050123          	sb	zero,2(a0)
    1c50:	468d                	li	a3,3
    1c52:	00350713          	addi	a4,a0,3
    1c56:	16d78c63          	beq	a5,a3,1dce <stpncpy+0x1f4>
    1c5a:	000501a3          	sb	zero,3(a0)
    1c5e:	4691                	li	a3,4
    1c60:	00450713          	addi	a4,a0,4
    1c64:	18d78263          	beq	a5,a3,1de8 <stpncpy+0x20e>
    1c68:	00050223          	sb	zero,4(a0)
    1c6c:	4695                	li	a3,5
    1c6e:	00550713          	addi	a4,a0,5
    1c72:	16d78d63          	beq	a5,a3,1dec <stpncpy+0x212>
    1c76:	000502a3          	sb	zero,5(a0)
    1c7a:	469d                	li	a3,7
    1c7c:	00650713          	addi	a4,a0,6
    1c80:	16d79863          	bne	a5,a3,1df0 <stpncpy+0x216>
    1c84:	00750713          	addi	a4,a0,7
    1c88:	00050323          	sb	zero,6(a0)
    1c8c:	40f80833          	sub	a6,a6,a5
    1c90:	ff887593          	andi	a1,a6,-8
    1c94:	97aa                	add	a5,a5,a0
    1c96:	95be                	add	a1,a1,a5
    1c98:	0007b023          	sd	zero,0(a5)
    1c9c:	07a1                	addi	a5,a5,8
    1c9e:	feb79de3          	bne	a5,a1,1c98 <stpncpy+0xbe>
    1ca2:	ff887593          	andi	a1,a6,-8
    1ca6:	9ead                	addw	a3,a3,a1
    1ca8:	00b707b3          	add	a5,a4,a1
    1cac:	12b80863          	beq	a6,a1,1ddc <stpncpy+0x202>
    1cb0:	00078023          	sb	zero,0(a5)
    1cb4:	0016871b          	addiw	a4,a3,1
    1cb8:	0ec77863          	bgeu	a4,a2,1da8 <stpncpy+0x1ce>
    1cbc:	000780a3          	sb	zero,1(a5)
    1cc0:	0026871b          	addiw	a4,a3,2
    1cc4:	0ec77263          	bgeu	a4,a2,1da8 <stpncpy+0x1ce>
    1cc8:	00078123          	sb	zero,2(a5)
    1ccc:	0036871b          	addiw	a4,a3,3
    1cd0:	0cc77c63          	bgeu	a4,a2,1da8 <stpncpy+0x1ce>
    1cd4:	000781a3          	sb	zero,3(a5)
    1cd8:	0046871b          	addiw	a4,a3,4
    1cdc:	0cc77663          	bgeu	a4,a2,1da8 <stpncpy+0x1ce>
    1ce0:	00078223          	sb	zero,4(a5)
    1ce4:	0056871b          	addiw	a4,a3,5
    1ce8:	0cc77063          	bgeu	a4,a2,1da8 <stpncpy+0x1ce>
    1cec:	000782a3          	sb	zero,5(a5)
    1cf0:	0066871b          	addiw	a4,a3,6
    1cf4:	0ac77a63          	bgeu	a4,a2,1da8 <stpncpy+0x1ce>
    1cf8:	00078323          	sb	zero,6(a5)
    1cfc:	0076871b          	addiw	a4,a3,7
    1d00:	0ac77463          	bgeu	a4,a2,1da8 <stpncpy+0x1ce>
    1d04:	000783a3          	sb	zero,7(a5)
    1d08:	0086871b          	addiw	a4,a3,8
    1d0c:	08c77e63          	bgeu	a4,a2,1da8 <stpncpy+0x1ce>
    1d10:	00078423          	sb	zero,8(a5)
    1d14:	0096871b          	addiw	a4,a3,9
    1d18:	08c77863          	bgeu	a4,a2,1da8 <stpncpy+0x1ce>
    1d1c:	000784a3          	sb	zero,9(a5)
    1d20:	00a6871b          	addiw	a4,a3,10
    1d24:	08c77263          	bgeu	a4,a2,1da8 <stpncpy+0x1ce>
    1d28:	00078523          	sb	zero,10(a5)
    1d2c:	00b6871b          	addiw	a4,a3,11
    1d30:	06c77c63          	bgeu	a4,a2,1da8 <stpncpy+0x1ce>
    1d34:	000785a3          	sb	zero,11(a5)
    1d38:	00c6871b          	addiw	a4,a3,12
    1d3c:	06c77663          	bgeu	a4,a2,1da8 <stpncpy+0x1ce>
    1d40:	00078623          	sb	zero,12(a5)
    1d44:	26b5                	addiw	a3,a3,13
    1d46:	06c6f163          	bgeu	a3,a2,1da8 <stpncpy+0x1ce>
    1d4a:	000786a3          	sb	zero,13(a5)
    1d4e:	8082                	ret
            ;
        if (!n || !*s)
    1d50:	c645                	beqz	a2,1df8 <stpncpy+0x21e>
    1d52:	0005c783          	lbu	a5,0(a1)
    1d56:	ea078be3          	beqz	a5,1c0c <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1d5a:	479d                	li	a5,7
    1d5c:	02c7ff63          	bgeu	a5,a2,1d9a <stpncpy+0x1c0>
    1d60:	00000897          	auipc	a7,0x0
    1d64:	3c88b883          	ld	a7,968(a7) # 2128 <sharedmem+0xa6>
    1d68:	00000817          	auipc	a6,0x0
    1d6c:	3b083803          	ld	a6,944(a6) # 2118 <sharedmem+0x96>
    1d70:	431d                	li	t1,7
    1d72:	6198                	ld	a4,0(a1)
    1d74:	011707b3          	add	a5,a4,a7
    1d78:	fff74693          	not	a3,a4
    1d7c:	8ff5                	and	a5,a5,a3
    1d7e:	0107f7b3          	and	a5,a5,a6
    1d82:	ef81                	bnez	a5,1d9a <stpncpy+0x1c0>
            *wd = *ws;
    1d84:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1d86:	1661                	addi	a2,a2,-8
    1d88:	05a1                	addi	a1,a1,8
    1d8a:	0521                	addi	a0,a0,8
    1d8c:	fec363e3          	bltu	t1,a2,1d72 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1d90:	e609                	bnez	a2,1d9a <stpncpy+0x1c0>
    1d92:	a08d                	j	1df4 <stpncpy+0x21a>
    1d94:	167d                	addi	a2,a2,-1
    1d96:	0505                	addi	a0,a0,1
    1d98:	ca01                	beqz	a2,1da8 <stpncpy+0x1ce>
    1d9a:	0005c783          	lbu	a5,0(a1)
    1d9e:	0585                	addi	a1,a1,1
    1da0:	00f50023          	sb	a5,0(a0)
    1da4:	fbe5                	bnez	a5,1d94 <stpncpy+0x1ba>
        ;
tail:
    1da6:	b59d                	j	1c0c <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1da8:	8082                	ret
    1daa:	472d                	li	a4,11
    1dac:	bdb5                	j	1c28 <stpncpy+0x4e>
    1dae:	00778713          	addi	a4,a5,7
    1db2:	45ad                	li	a1,11
    1db4:	fff60693          	addi	a3,a2,-1
    1db8:	e6b778e3          	bgeu	a4,a1,1c28 <stpncpy+0x4e>
    1dbc:	b7fd                	j	1daa <stpncpy+0x1d0>
    1dbe:	40a007b3          	neg	a5,a0
    1dc2:	8832                	mv	a6,a2
    1dc4:	8b9d                	andi	a5,a5,7
    1dc6:	4681                	li	a3,0
    1dc8:	e4060be3          	beqz	a2,1c1e <stpncpy+0x44>
    1dcc:	b7cd                	j	1dae <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1dce:	468d                	li	a3,3
    1dd0:	bd75                	j	1c8c <stpncpy+0xb2>
    1dd2:	872a                	mv	a4,a0
    1dd4:	4681                	li	a3,0
    1dd6:	bd5d                	j	1c8c <stpncpy+0xb2>
    1dd8:	4685                	li	a3,1
    1dda:	bd4d                	j	1c8c <stpncpy+0xb2>
    1ddc:	8082                	ret
    1dde:	87aa                	mv	a5,a0
    1de0:	4681                	li	a3,0
    1de2:	b5f9                	j	1cb0 <stpncpy+0xd6>
    1de4:	4689                	li	a3,2
    1de6:	b55d                	j	1c8c <stpncpy+0xb2>
    1de8:	4691                	li	a3,4
    1dea:	b54d                	j	1c8c <stpncpy+0xb2>
    1dec:	4695                	li	a3,5
    1dee:	bd79                	j	1c8c <stpncpy+0xb2>
    1df0:	4699                	li	a3,6
    1df2:	bd69                	j	1c8c <stpncpy+0xb2>
    1df4:	8082                	ret
    1df6:	8082                	ret
    1df8:	8082                	ret

0000000000001dfa <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1dfa:	fff6071b          	addiw	a4,a2,-1
    1dfe:	0cb57063          	bgeu	a0,a1,1ebe <memmove+0xc4>
        while (n-- > 0)
    1e02:	0ec05063          	blez	a2,1ee2 <memmove+0xe8>
    1e06:	00750693          	addi	a3,a0,7
    1e0a:	8e8d                	sub	a3,a3,a1
    1e0c:	00b567b3          	or	a5,a0,a1
    1e10:	00f6b693          	sltiu	a3,a3,15
    1e14:	8b9d                	andi	a5,a5,7
    1e16:	0016c693          	xori	a3,a3,1
    1e1a:	0017b793          	seqz	a5,a5
    1e1e:	8ff5                	and	a5,a5,a3
    1e20:	c3f1                	beqz	a5,1ee4 <memmove+0xea>
    1e22:	0007079b          	sext.w	a5,a4
    1e26:	46a5                	li	a3,9
    1e28:	0af6fe63          	bgeu	a3,a5,1ee4 <memmove+0xea>
    1e2c:	0036589b          	srliw	a7,a2,0x3
    1e30:	088e                	slli	a7,a7,0x3
    1e32:	2601                	sext.w	a2,a2
    1e34:	87ae                	mv	a5,a1
    1e36:	86aa                	mv	a3,a0
    1e38:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1e3a:	0007b803          	ld	a6,0(a5)
    1e3e:	07a1                	addi	a5,a5,8
    1e40:	06a1                	addi	a3,a3,8
    1e42:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1e46:	ff179ae3          	bne	a5,a7,1e3a <memmove+0x40>
    1e4a:	ff867813          	andi	a6,a2,-8
    1e4e:	02081793          	slli	a5,a6,0x20
    1e52:	9381                	srli	a5,a5,0x20
    1e54:	00f506b3          	add	a3,a0,a5
    1e58:	95be                	add	a1,a1,a5
    1e5a:	4107073b          	subw	a4,a4,a6
    1e5e:	09060263          	beq	a2,a6,1ee2 <memmove+0xe8>
            *dst++ = *src++;
    1e62:	0005c783          	lbu	a5,0(a1)
    1e66:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1e6a:	06e05c63          	blez	a4,1ee2 <memmove+0xe8>
            *dst++ = *src++;
    1e6e:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1e72:	4785                	li	a5,1
            *dst++ = *src++;
    1e74:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1e78:	06e7d563          	bge	a5,a4,1ee2 <memmove+0xe8>
            *dst++ = *src++;
    1e7c:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1e80:	4789                	li	a5,2
            *dst++ = *src++;
    1e82:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1e86:	04e7de63          	bge	a5,a4,1ee2 <memmove+0xe8>
            *dst++ = *src++;
    1e8a:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1e8e:	478d                	li	a5,3
            *dst++ = *src++;
    1e90:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1e94:	04e7d763          	bge	a5,a4,1ee2 <memmove+0xe8>
            *dst++ = *src++;
    1e98:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1e9c:	4791                	li	a5,4
            *dst++ = *src++;
    1e9e:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1ea2:	04e7d063          	bge	a5,a4,1ee2 <memmove+0xe8>
            *dst++ = *src++;
    1ea6:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1eaa:	4795                	li	a5,5
            *dst++ = *src++;
    1eac:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1eb0:	02e7d963          	bge	a5,a4,1ee2 <memmove+0xe8>
            *dst++ = *src++;
    1eb4:	0065c783          	lbu	a5,6(a1)
    1eb8:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1ebc:	8082                	ret
    } else {
        dst += n;
    1ebe:	00c507b3          	add	a5,a0,a2
        src += n;
    1ec2:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1ec4:	00c05f63          	blez	a2,1ee2 <memmove+0xe8>
    1ec8:	1702                	slli	a4,a4,0x20
    1eca:	9301                	srli	a4,a4,0x20
    1ecc:	fff74713          	not	a4,a4
    1ed0:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1ed2:	fff5c683          	lbu	a3,-1(a1)
    1ed6:	17fd                	addi	a5,a5,-1
    1ed8:	15fd                	addi	a1,a1,-1
    1eda:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1ede:	fee79ae3          	bne	a5,a4,1ed2 <memmove+0xd8>
    }
    return vdst;
}
    1ee2:	8082                	ret
    1ee4:	02071693          	slli	a3,a4,0x20
    1ee8:	9281                	srli	a3,a3,0x20
    1eea:	0685                	addi	a3,a3,1
    1eec:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1eee:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1ef0:	0005c703          	lbu	a4,0(a1)
    1ef4:	0585                	addi	a1,a1,1
    1ef6:	0785                	addi	a5,a5,1
    1ef8:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1efc:	fed59ae3          	bne	a1,a3,1ef0 <memmove+0xf6>
    1f00:	8082                	ret

0000000000001f02 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1f02:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f06:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1f0a:	2501                	sext.w	a0,a0
    1f0c:	8082                	ret

0000000000001f0e <exec>:
    register long a7 __asm__("a7") = n;
    1f0e:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1f12:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f14:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1f18:	2501                	sext.w	a0,a0
    1f1a:	8082                	ret

0000000000001f1c <exit>:
    register long a7 __asm__("a7") = n;
    1f1c:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1f20:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1f24:	8082                	ret

0000000000001f26 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1f26:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f2a:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1f2e:	8082                	ret

0000000000001f30 <write>:
    register long a7 __asm__("a7") = n;
    1f30:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f34:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1f38:	8082                	ret

0000000000001f3a <getpid>:
    register long a7 __asm__("a7") = n;
    1f3a:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1f3e:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1f42:	2501                	sext.w	a0,a0
    1f44:	8082                	ret

0000000000001f46 <getppid>:
    register long a7 __asm__("a7") = n;
    1f46:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1f4a:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1f4e:	2501                	sext.w	a0,a0
    1f50:	8082                	ret

0000000000001f52 <open>:
    register long a7 __asm__("a7") = n;
    1f52:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f56:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1f5a:	2501                	sext.w	a0,a0
    1f5c:	8082                	ret

0000000000001f5e <mknod>:
    register long a7 __asm__("a7") = n;
    1f5e:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f62:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1f66:	2501                	sext.w	a0,a0
    1f68:	8082                	ret

0000000000001f6a <dup>:
    register long a7 __asm__("a7") = n;
    1f6a:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1f6c:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1f70:	2501                	sext.w	a0,a0
    1f72:	8082                	ret

0000000000001f74 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1f74:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1f78:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1f7c:	2501                	sext.w	a0,a0
    1f7e:	8082                	ret

0000000000001f80 <waitpid>:
    register long a7 __asm__("a7") = n;
    1f80:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f84:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1f88:	2501                	sext.w	a0,a0
    1f8a:	8082                	ret

0000000000001f8c <wait>:

pid_t wait(int *wstatus)
{
    1f8c:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1f8e:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1f92:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f94:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1f98:	2501                	sext.w	a0,a0
    1f9a:	8082                	ret

0000000000001f9c <mkdir>:
    register long a7 __asm__("a7") = n;
    1f9c:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1fa0:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1fa4:	2501                	sext.w	a0,a0
    1fa6:	8082                	ret

0000000000001fa8 <close>:
    register long a7 __asm__("a7") = n;
    1fa8:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1fac:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    1fb0:	2501                	sext.w	a0,a0
    1fb2:	8082                	ret

0000000000001fb4 <fork>:
    register long a7 __asm__("a7") = n;
    1fb4:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    1fb8:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    1fbc:	2501                	sext.w	a0,a0
    1fbe:	8082                	ret

0000000000001fc0 <time_ms>:
    register long a7 __asm__("a7") = n;
    1fc0:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1fc4:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    1fc8:	8082                	ret

0000000000001fca <sleep>:

int sleep(unsigned long long time_in_ms)
{
    1fca:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    1fcc:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1fd0:	00000073          	ecall
    1fd4:	87aa                	mv	a5,a0
    1fd6:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    1fda:	97ba                	add	a5,a5,a4
    1fdc:	00f57c63          	bgeu	a0,a5,1ff4 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    1fe0:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1fe4:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    1fe8:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    1fec:	00000073          	ecall
    1ff0:	fef568e3          	bltu	a0,a5,1fe0 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    1ff4:	4501                	li	a0,0
    1ff6:	8082                	ret

0000000000001ff8 <pipe>:
    register long a7 __asm__("a7") = n;
    1ff8:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    1ffc:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    2000:	2501                	sext.w	a0,a0
    2002:	8082                	ret

0000000000002004 <fstat>:
    register long a7 __asm__("a7") = n;
    2004:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2008:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    200c:	2501                	sext.w	a0,a0
    200e:	8082                	ret

0000000000002010 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    2010:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    2012:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    2016:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2018:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    201c:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    2020:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    2024:	0206c163          	bltz	a3,2046 <stat+0x36>
    register long a7 __asm__("a7") = n;
    2028:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    202c:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    202e:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2030:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    2034:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    2038:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    203c:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    203e:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    2042:	853e                	mv	a0,a5
    2044:	8082                	ret
        return -1;
    2046:	57fd                	li	a5,-1
    2048:	bfed                	j	2042 <stat+0x32>

000000000000204a <chdir>:
    register long a7 __asm__("a7") = n;
    204a:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    204e:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    2052:	2501                	sext.w	a0,a0
    2054:	8082                	ret

0000000000002056 <link>:
    register long a7 __asm__("a7") = n;
    2056:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    205a:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    205e:	2501                	sext.w	a0,a0
    2060:	8082                	ret

0000000000002062 <unlink>:
    register long a7 __asm__("a7") = n;
    2062:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    2066:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    206a:	2501                	sext.w	a0,a0
    206c:	8082                	ret

000000000000206e <setpriority>:
    register long a7 __asm__("a7") = n;
    206e:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    2072:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    2076:	8082                	ret

0000000000002078 <getpriority>:
    register long a7 __asm__("a7") = n;
    2078:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    207c:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    2080:	8082                	ret

0000000000002082 <sharedmem>:
    register long a7 __asm__("a7") = n;
    2082:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2086:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    208a:	8082                	ret
