
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_top1:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	a955                	j	14b4 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
#include <ucore.h>
int NCPU = 4;

char bigdata[1024 * 200]; // 200K

int main(int argc, char *argv[]) {
    1002:	a1010113          	addi	sp,sp,-1520
    struct cpu_stat stat_buf[8];
    struct mem_stat mstat;
    struct proc_stat pstat[20];
    int fd = open("cpu", O_RDWR);
    1006:	4589                	li	a1,2
    1008:	00001517          	auipc	a0,0x1
    100c:	1f850513          	addi	a0,a0,504 # 2200 <sharedmem+0x10>
int main(int argc, char *argv[]) {
    1010:	5e113423          	sd	ra,1512(sp)
    1014:	5e813023          	sd	s0,1504(sp)
    1018:	5b813023          	sd	s8,1440(sp)
    101c:	5c913c23          	sd	s1,1496(sp)
    1020:	5d213823          	sd	s2,1488(sp)
    1024:	5d313423          	sd	s3,1480(sp)
    1028:	5d413023          	sd	s4,1472(sp)
    102c:	5b513c23          	sd	s5,1464(sp)
    1030:	5b613823          	sd	s6,1456(sp)
    1034:	5b713423          	sd	s7,1448(sp)
    1038:	59913c23          	sd	s9,1432(sp)
    103c:	59a13823          	sd	s10,1424(sp)
    1040:	59b13423          	sd	s11,1416(sp)
    int fd = open("cpu", O_RDWR);
    1044:	07c010ef          	jal	ra,20c0 <open>
    1048:	87aa                	mv	a5,a0
    int fd_mem = open("mem", O_RDWR);
    104a:	4589                	li	a1,2
    104c:	00001517          	auipc	a0,0x1
    1050:	1bc50513          	addi	a0,a0,444 # 2208 <sharedmem+0x18>
    int fd = open("cpu", O_RDWR);
    1054:	843e                	mv	s0,a5
    1056:	ec3e                	sd	a5,24(sp)
    int fd_mem = open("mem", O_RDWR);
    1058:	068010ef          	jal	ra,20c0 <open>
    105c:	87aa                	mv	a5,a0
    int fd_proc = open("proc", O_RDWR);
    105e:	4589                	li	a1,2
    1060:	00001517          	auipc	a0,0x1
    1064:	1b050513          	addi	a0,a0,432 # 2210 <sharedmem+0x20>
    int fd_mem = open("mem", O_RDWR);
    1068:	f03e                	sd	a5,32(sp)
    int fd_proc = open("proc", O_RDWR);
    106a:	056010ef          	jal	ra,20c0 <open>
    106e:	87aa                	mv	a5,a0
    assert(fd >= 0, -1);
    1070:	fff44513          	not	a0,s0
    1074:	55fd                	li	a1,-1
    1076:	01f5551b          	srliw	a0,a0,0x1f
    int fd_proc = open("proc", O_RDWR);
    107a:	f43e                	sd	a5,40(sp)
    assert(fd >= 0, -1);
    107c:	061000ef          	jal	ra,18dc <assert>

    int bytes = read(fd, stat_buf, sizeof(stat_buf));
    1080:	0c000613          	li	a2,192
    1084:	108c                	addi	a1,sp,96
    1086:	8522                	mv	a0,s0
    1088:	00c010ef          	jal	ra,2094 <read>
    108c:	0005041b          	sext.w	s0,a0
    printf("cpu_device bytes read %d\n", bytes);
    1090:	85a2                	mv	a1,s0
    1092:	00001517          	auipc	a0,0x1
    1096:	18650513          	addi	a0,a0,390 # 2218 <sharedmem+0x28>
    109a:	4b0000ef          	jal	ra,154a <printf>

    assert(bytes == sizeof(struct cpu_stat) * NCPU, -2); // only four
    109e:	00033c17          	auipc	s8,0x33
    10a2:	426c0c13          	addi	s8,s8,1062 # 344c4 <NCPU>
    10a6:	000c2783          	lw	a5,0(s8)
    10aa:	55f9                	li	a1,-2
    10ac:	00179513          	slli	a0,a5,0x1
    10b0:	953e                	add	a0,a0,a5
    10b2:	050e                	slli	a0,a0,0x3
    10b4:	8d01                	sub	a0,a0,s0
    10b6:	00153513          	seqz	a0,a0
    10ba:	023000ef          	jal	ra,18dc <assert>

    int pid;
    int runtime[] = { 6, 4, 2};
    char name[] = {'n', 'a', 'm', 'e', '0', '0', '\0'};
    10be:	656d67b7          	lui	a5,0x656d6
    10c2:	16e7879b          	addiw	a5,a5,366
    10c6:	c4be                	sw	a5,72(sp)
    10c8:	678d                	lui	a5,0x3
    10ca:	0307879b          	addiw	a5,a5,48
    10ce:	04f11623          	sh	a5,76(sp)
    10d2:	04010723          	sb	zero,78(sp)
    int child_id;
    for (int i = 0; i < 1; i++) {
        pid = fork();
    10d6:	04c010ef          	jal	ra,2122 <fork>
        if (pid == 0) {
    10da:	e159                	bnez	a0,1160 <main+0x15e>
            child_id = i;
            name[4] += i;

            sleep(1000 * (i + 1));
    10dc:	3e800513          	li	a0,1000
    10e0:	058010ef          	jal	ra,2138 <sleep>
    10e4:	06100413          	li	s0,97
    }

    if (pid == 0) {
        int *shm;

        for (int i = 0; i < 20; i++) {
    10e8:	07500493          	li	s1,117
            // waste some memory
            shm = sharedmem(name, 1024 * 512); // 512 KB
    10ec:	000805b7          	lui	a1,0x80
    10f0:	00a8                	addi	a0,sp,72
    10f2:	0fe010ef          	jal	ra,21f0 <sharedmem>
    10f6:	0014079b          	addiw	a5,s0,1
            // printf("shm=%p\n",shm);
            name[5] = 'a' + i; // different name
    10fa:	048106a3          	sb	s0,77(sp)
    10fe:	0ff7f413          	andi	s0,a5,255
        for (int i = 0; i < 20; i++) {
    1102:	fe9415e3          	bne	s0,s1,10ec <main+0xea>
        }

        shm[10] = 2;
    1106:	4709                	li	a4,2
    1108:	d518                	sw	a4,40(a0)
        int x = shm[10];
        int t = time_ms();
    110a:	024010ef          	jal	ra,212e <time_ms>
        // child
        while (1) {
            x = x * x - 3 * x;
            t2 = time_ms() - t;

            if (t2 > runtime[child_id] * 1000) {
    110e:	6405                	lui	s0,0x1
    1110:	0005049b          	sext.w	s1,a0
    1114:	77040413          	addi	s0,s0,1904 # 1770 <printf+0x226>
            t2 = time_ms() - t;
    1118:	016010ef          	jal	ra,212e <time_ms>
    111c:	409507b3          	sub	a5,a0,s1
            if (t2 > runtime[child_id] * 1000) {
    1120:	fef47ce3          	bgeu	s0,a5,1118 <main+0x116>
            printf("----------------------------------------------------------------------\n\n");
        }
    }

    return 0;
    1124:	5e813083          	ld	ra,1512(sp)
    1128:	5e013403          	ld	s0,1504(sp)
    112c:	5d813483          	ld	s1,1496(sp)
    1130:	5d013903          	ld	s2,1488(sp)
    1134:	5c813983          	ld	s3,1480(sp)
    1138:	5c013a03          	ld	s4,1472(sp)
    113c:	5b813a83          	ld	s5,1464(sp)
    1140:	5b013b03          	ld	s6,1456(sp)
    1144:	5a813b83          	ld	s7,1448(sp)
    1148:	5a013c03          	ld	s8,1440(sp)
    114c:	59813c83          	ld	s9,1432(sp)
    1150:	59013d03          	ld	s10,1424(sp)
    1154:	58813d83          	ld	s11,1416(sp)
    1158:	4501                	li	a0,0
    115a:	5f010113          	addi	sp,sp,1520
    115e:	8082                	ret
        uint64 start_time = time_ms();
    1160:	7cf000ef          	jal	ra,212e <time_ms>
            if (time_sec > 10)
    1164:	678d                	lui	a5,0x3
    1166:	af778793          	addi	a5,a5,-1289 # 2af7 <bigdata+0x69f>
        uint64 start_time = time_ms();
    116a:	f82a                	sd	a0,48(sp)
            if (time_sec > 10)
    116c:	fc3e                	sd	a5,56(sp)
                printf("Core    %d\n", i);
    116e:	00001d97          	auipc	s11,0x1
    1172:	1f2d8d93          	addi	s11,s11,498 # 2360 <sharedmem+0x170>
                printf("[\x1b[31m");
    1176:	00001c97          	auipc	s9,0x1
    117a:	1e2c8c93          	addi	s9,s9,482 # 2358 <sharedmem+0x168>
                    printf(" ");
    117e:	00001a17          	auipc	s4,0x1
    1182:	20aa0a13          	addi	s4,s4,522 # 2388 <sharedmem+0x198>
                    printf("|");
    1186:	00001997          	auipc	s3,0x1
    118a:	1ea98993          	addi	s3,s3,490 # 2370 <sharedmem+0x180>
            sleep(1000);
    118e:	3e800513          	li	a0,1000
    1192:	7a7000ef          	jal	ra,2138 <sleep>
            uint64 time_sec = (time_ms() - start_time) / 1000;
    1196:	799000ef          	jal	ra,212e <time_ms>
    119a:	77c2                	ld	a5,48(sp)
            if (time_sec > 10)
    119c:	7762                	ld	a4,56(sp)
            uint64 time_sec = (time_ms() - start_time) / 1000;
    119e:	3e800413          	li	s0,1000
    11a2:	40f507b3          	sub	a5,a0,a5
    11a6:	0287d433          	divu	s0,a5,s0
            if (time_sec > 10)
    11aa:	2af76563          	bltu	a4,a5,1454 <main+0x452>
            bytes = read(fd, stat_buf, sizeof(stat_buf));
    11ae:	6562                	ld	a0,24(sp)
    11b0:	0c000613          	li	a2,192
    11b4:	108c                	addi	a1,sp,96
    11b6:	6df000ef          	jal	ra,2094 <read>
    11ba:	892a                	mv	s2,a0
            int bytes_mem = read(fd_mem, &mstat, sizeof(mstat));
    11bc:	7502                	ld	a0,32(sp)
    11be:	4641                	li	a2,16
    11c0:	088c                	addi	a1,sp,80
    11c2:	6d3000ef          	jal	ra,2094 <read>
    11c6:	84aa                	mv	s1,a0
            int bytes_proc = read(fd_proc, &pstat, sizeof(pstat));
    11c8:	7522                	ld	a0,40(sp)
    11ca:	46000613          	li	a2,1120
    11ce:	120c                	addi	a1,sp,288
    11d0:	6c5000ef          	jal	ra,2094 <read>
            assert(bytes == sizeof(struct cpu_stat) * NCPU, -6); // only four
    11d4:	000c2703          	lw	a4,0(s8)
            int p_cnt = bytes_proc / sizeof(struct proc_stat);
    11d8:	0005079b          	sext.w	a5,a0
            assert(bytes == sizeof(struct cpu_stat) * NCPU, -6); // only four
    11dc:	2901                	sext.w	s2,s2
    11de:	00171513          	slli	a0,a4,0x1
    11e2:	953a                	add	a0,a0,a4
    11e4:	050e                	slli	a0,a0,0x3
            int p_cnt = bytes_proc / sizeof(struct proc_stat);
    11e6:	03800713          	li	a4,56
            assert(bytes == sizeof(struct cpu_stat) * NCPU, -6); // only four
    11ea:	41250533          	sub	a0,a0,s2
    11ee:	55e9                	li	a1,-6
    11f0:	00153513          	seqz	a0,a0
    11f4:	06010b93          	addi	s7,sp,96
            for (int i = 0; i < NCPU; i++) {
    11f8:	4b01                	li	s6,0
                for (; i < 50; i++) {
    11fa:	03200a93          	li	s5,50
            int p_cnt = bytes_proc / sizeof(struct proc_stat);
    11fe:	02e7d933          	divu	s2,a5,a4
    1202:	e84a                	sd	s2,16(sp)
            assert(bytes == sizeof(struct cpu_stat) * NCPU, -6); // only four
    1204:	6d8000ef          	jal	ra,18dc <assert>
            assert(bytes_mem == sizeof(struct mem_stat), -8);    // only four
    1208:	0004851b          	sext.w	a0,s1
    120c:	1541                	addi	a0,a0,-16
    120e:	55e1                	li	a1,-8
    1210:	00153513          	seqz	a0,a0
    1214:	6c8000ef          	jal	ra,18dc <assert>
            printf("\x1b[2J");                                   // clear
    1218:	00001517          	auipc	a0,0x1
    121c:	02050513          	addi	a0,a0,32 # 2238 <sharedmem+0x48>
    1220:	32a000ef          	jal	ra,154a <printf>
            printf("----------------------------------------------------------------------\n");
    1224:	00001517          	auipc	a0,0x1
    1228:	01c50513          	addi	a0,a0,28 # 2240 <sharedmem+0x50>
    122c:	31e000ef          	jal	ra,154a <printf>
            printf(" uCore-SMP Resource Monitor                            Time: %l s\n", time_sec);
    1230:	85a2                	mv	a1,s0
    1232:	00001517          	auipc	a0,0x1
    1236:	05650513          	addi	a0,a0,86 # 2288 <sharedmem+0x98>
    123a:	310000ef          	jal	ra,154a <printf>
            printf("----------------------------------------------------------------------\n\n");
    123e:	00001517          	auipc	a0,0x1
    1242:	09250513          	addi	a0,a0,146 # 22d0 <sharedmem+0xe0>
    1246:	304000ef          	jal	ra,154a <printf>
            for (int i = 0; i < NCPU; i++) {
    124a:	000c2783          	lw	a5,0(s8)
            int p_cnt = bytes_proc / sizeof(struct proc_stat);
    124e:	0009071b          	sext.w	a4,s2
    1252:	e43a                	sd	a4,8(sp)
            for (int i = 0; i < NCPU; i++) {
    1254:	08f05563          	blez	a5,12de <main+0x2dc>
                printf("Core    %d\n", i);
    1258:	85da                	mv	a1,s6
    125a:	856e                	mv	a0,s11
    125c:	2ee000ef          	jal	ra,154a <printf>
                int per = (100 * stat_buf[i].sample_busy_duration) / stat_buf[i].sample_duration;
    1260:	010bb483          	ld	s1,16(s7)
    1264:	06400713          	li	a4,100
    1268:	008bb783          	ld	a5,8(s7)
    126c:	029704b3          	mul	s1,a4,s1
                printf("[\x1b[31m");
    1270:	8566                	mv	a0,s9
                int per = (100 * stat_buf[i].sample_busy_duration) / stat_buf[i].sample_duration;
    1272:	02f4d4b3          	divu	s1,s1,a5
                printf("[\x1b[31m");
    1276:	2d4000ef          	jal	ra,154a <printf>
                int per = (100 * stat_buf[i].sample_busy_duration) / stat_buf[i].sample_duration;
    127a:	2481                	sext.w	s1,s1
                int tens = (per + 1) / 2;
    127c:	0014879b          	addiw	a5,s1,1
    1280:	01f7d41b          	srliw	s0,a5,0x1f
    1284:	9c3d                	addw	s0,s0,a5
    1286:	4014591b          	sraiw	s2,s0,0x1
    128a:	844a                	mv	s0,s2
                for (i = 0; i < tens; i++) {
    128c:	1c905263          	blez	s1,1450 <main+0x44e>
    1290:	4d01                	li	s10,0
    1292:	2d05                	addiw	s10,s10,1
                    printf("|");
    1294:	854e                	mv	a0,s3
    1296:	2b4000ef          	jal	ra,154a <printf>
                for (i = 0; i < tens; i++) {
    129a:	ff2d4ce3          	blt	s10,s2,1292 <main+0x290>
    129e:	01204363          	bgtz	s2,12a4 <main+0x2a2>
    12a2:	4405                	li	s0,1
                for (; i < 50; i++) {
    12a4:	06200793          	li	a5,98
    12a8:	0097c863          	blt	a5,s1,12b8 <main+0x2b6>
    12ac:	2405                	addiw	s0,s0,1
                    printf(" ");
    12ae:	8552                	mv	a0,s4
    12b0:	29a000ef          	jal	ra,154a <printf>
                for (; i < 50; i++) {
    12b4:	ff541ce3          	bne	s0,s5,12ac <main+0x2aa>
                printf("\x1b[0m] %d%%\n", per);
    12b8:	85a6                	mv	a1,s1
    12ba:	00001517          	auipc	a0,0x1
    12be:	0be50513          	addi	a0,a0,190 # 2378 <sharedmem+0x188>
    12c2:	288000ef          	jal	ra,154a <printf>
                printf("\n");
    12c6:	00001517          	auipc	a0,0x1
    12ca:	f6a50513          	addi	a0,a0,-150 # 2230 <sharedmem+0x40>
    12ce:	27c000ef          	jal	ra,154a <printf>
            for (int i = 0; i < NCPU; i++) {
    12d2:	000c2783          	lw	a5,0(s8)
    12d6:	2b05                	addiw	s6,s6,1
    12d8:	0be1                	addi	s7,s7,24
    12da:	f6fb4fe3          	blt	s6,a5,1258 <main+0x256>
            printf("Memory\n");
    12de:	00001517          	auipc	a0,0x1
    12e2:	04250513          	addi	a0,a0,66 # 2320 <sharedmem+0x130>
    12e6:	264000ef          	jal	ra,154a <printf>
            printf("Total :   %l MB\n", mstat.physical_total / 1024 / 1024);
    12ea:	65c6                	ld	a1,80(sp)
    12ec:	00001517          	auipc	a0,0x1
    12f0:	03c50513          	addi	a0,a0,60 # 2328 <sharedmem+0x138>
            for (i = 0; i < tens; i++) {
    12f4:	4a81                	li	s5,0
            printf("Total :   %l MB\n", mstat.physical_total / 1024 / 1024);
    12f6:	81d1                	srli	a1,a1,0x14
    12f8:	252000ef          	jal	ra,154a <printf>
            printf("Free  :   %l MB\n", mstat.physical_free / 1024 / 1024);
    12fc:	65e6                	ld	a1,88(sp)
    12fe:	00001517          	auipc	a0,0x1
    1302:	04250513          	addi	a0,a0,66 # 2340 <sharedmem+0x150>
    1306:	81d1                	srli	a1,a1,0x14
    1308:	242000ef          	jal	ra,154a <printf>
            uint64 used = mstat.physical_total - mstat.physical_free;
    130c:	67c6                	ld	a5,80(sp)
    130e:	64e6                	ld	s1,88(sp)
            int use_per = (used * 100) / mstat.physical_total;
    1310:	06400713          	li	a4,100
            printf("[\x1b[31m");
    1314:	8566                	mv	a0,s9
            uint64 used = mstat.physical_total - mstat.physical_free;
    1316:	409784b3          	sub	s1,a5,s1
            int use_per = (used * 100) / mstat.physical_total;
    131a:	02e484b3          	mul	s1,s1,a4
    131e:	02f4d4b3          	divu	s1,s1,a5
            printf("[\x1b[31m");
    1322:	228000ef          	jal	ra,154a <printf>
            int use_per = (used * 100) / mstat.physical_total;
    1326:	2481                	sext.w	s1,s1
            int tens = (use_per + 1) / 2;
    1328:	0014879b          	addiw	a5,s1,1
    132c:	01f7d41b          	srliw	s0,a5,0x1f
    1330:	9c3d                	addw	s0,s0,a5
    1332:	4014591b          	sraiw	s2,s0,0x1
    1336:	844a                	mv	s0,s2
            for (i = 0; i < tens; i++) {
    1338:	12905963          	blez	s1,146a <main+0x468>
    133c:	2a85                	addiw	s5,s5,1
                printf("|");
    133e:	854e                	mv	a0,s3
    1340:	20a000ef          	jal	ra,154a <printf>
            for (i = 0; i < tens; i++) {
    1344:	ff2acce3          	blt	s5,s2,133c <main+0x33a>
    1348:	01204363          	bgtz	s2,134e <main+0x34c>
    134c:	4405                	li	s0,1
            for (; i < 50; i++) {
    134e:	06200793          	li	a5,98
    1352:	0004091b          	sext.w	s2,s0
    1356:	0097ca63          	blt	a5,s1,136a <main+0x368>
    135a:	03200413          	li	s0,50
    135e:	2905                	addiw	s2,s2,1
                printf(" ");
    1360:	8552                	mv	a0,s4
    1362:	1e8000ef          	jal	ra,154a <printf>
            for (; i < 50; i++) {
    1366:	fe891ce3          	bne	s2,s0,135e <main+0x35c>
            printf("\x1b[0m] %d%%\n", use_per);
    136a:	85a6                	mv	a1,s1
    136c:	00001517          	auipc	a0,0x1
    1370:	00c50513          	addi	a0,a0,12 # 2378 <sharedmem+0x188>
    1374:	1d6000ef          	jal	ra,154a <printf>
            printf("\n");
    1378:	00001517          	auipc	a0,0x1
    137c:	eb850513          	addi	a0,a0,-328 # 2230 <sharedmem+0x40>
    1380:	1ca000ef          	jal	ra,154a <printf>
            printf("----------------------------------------------------------------------\n");
    1384:	00001517          	auipc	a0,0x1
    1388:	ebc50513          	addi	a0,a0,-324 # 2240 <sharedmem+0x50>
    138c:	1be000ef          	jal	ra,154a <printf>
            printf("Process | pid | ppid | heap | mem | cpu time\n", p_cnt);
    1390:	6422                	ld	s0,8(sp)
    1392:	00001517          	auipc	a0,0x1
    1396:	ffe50513          	addi	a0,a0,-2 # 2390 <sharedmem+0x1a0>
    139a:	85a2                	mv	a1,s0
    139c:	1ae000ef          	jal	ra,154a <printf>
            if (p_cnt > 0) {
    13a0:	0a805163          	blez	s0,1442 <main+0x440>
    13a4:	67c2                	ld	a5,16(sp)
    13a6:	1204                	addi	s1,sp,288
                    printf("%d   ", pstat[i].pid);
    13a8:	00001a97          	auipc	s5,0x1
    13ac:	020a8a93          	addi	s5,s5,32 # 23c8 <sharedmem+0x1d8>
    13b0:	37fd                	addiw	a5,a5,-1
    13b2:	1782                	slli	a5,a5,0x20
    13b4:	9381                	srli	a5,a5,0x20
    13b6:	00379413          	slli	s0,a5,0x3
    13ba:	8c1d                	sub	s0,s0,a5
    13bc:	040e                	slli	s0,s0,0x3
    13be:	0abc                	addi	a5,sp,344
    13c0:	943e                	add	s0,s0,a5
                    printf("%l   ", pstat[i].heap_sz);
    13c2:	00001917          	auipc	s2,0x1
    13c6:	00e90913          	addi	s2,s2,14 # 23d0 <sharedmem+0x1e0>
                    } else if (pstat[i].state == USED) {
    13ca:	4b05                	li	s6,1
                    } else if (pstat[i].state == SLEEPING) {
    13cc:	4b89                	li	s7,2
                    } else if (pstat[i].state == RUNNING) {
    13ce:	4d11                	li	s10,4
                    printf("%s   ", pstat[i].name);
    13d0:	85a6                	mv	a1,s1
    13d2:	00001517          	auipc	a0,0x1
    13d6:	fee50513          	addi	a0,a0,-18 # 23c0 <sharedmem+0x1d0>
    13da:	170000ef          	jal	ra,154a <printf>
                    printf("%d   ", pstat[i].pid);
    13de:	488c                	lw	a1,16(s1)
    13e0:	8556                	mv	a0,s5
    13e2:	168000ef          	jal	ra,154a <printf>
                    printf("%d   ", pstat[i].ppid);
    13e6:	48cc                	lw	a1,20(s1)
    13e8:	8556                	mv	a0,s5
    13ea:	160000ef          	jal	ra,154a <printf>
                    printf("%l   ", pstat[i].heap_sz);
    13ee:	708c                	ld	a1,32(s1)
    13f0:	854a                	mv	a0,s2
    13f2:	158000ef          	jal	ra,154a <printf>
                    printf("%l   ", pstat[i].total_size);
    13f6:	748c                	ld	a1,40(s1)
    13f8:	854a                	mv	a0,s2
    13fa:	150000ef          	jal	ra,154a <printf>
                    printf("%l   ", pstat[i].cpu_time);
    13fe:	788c                	ld	a1,48(s1)
    1400:	854a                	mv	a0,s2
    1402:	148000ef          	jal	ra,154a <printf>
                    if (pstat[i].state == UNUSED) {
    1406:	4c9c                	lw	a5,24(s1)
    1408:	cbb1                	beqz	a5,145c <main+0x45a>
                    } else if (pstat[i].state == USED) {
    140a:	07678263          	beq	a5,s6,146e <main+0x46c>
                    } else if (pstat[i].state == SLEEPING) {
    140e:	07778763          	beq	a5,s7,147c <main+0x47a>
                    } else if (pstat[i].state == RUNNING) {
    1412:	09a78363          	beq	a5,s10,1498 <main+0x496>
                    } else if (pstat[i].state == ZOMBIE) {
    1416:	4715                	li	a4,5
    1418:	08e78763          	beq	a5,a4,14a6 <main+0x4a4>
                    } else if (pstat[i].state == RUNNABLE) {
    141c:	470d                	li	a4,3
    141e:	06e78663          	beq	a5,a4,148a <main+0x488>
                        printf("UNKNOWN");
    1422:	00001517          	auipc	a0,0x1
    1426:	ff650513          	addi	a0,a0,-10 # 2418 <sharedmem+0x228>
    142a:	120000ef          	jal	ra,154a <printf>
                    printf("\n");
    142e:	03848493          	addi	s1,s1,56
    1432:	00001517          	auipc	a0,0x1
    1436:	dfe50513          	addi	a0,a0,-514 # 2230 <sharedmem+0x40>
    143a:	110000ef          	jal	ra,154a <printf>
                for (int i = 0; i < p_cnt; i++) {
    143e:	f89419e3          	bne	s0,s1,13d0 <main+0x3ce>
            printf("----------------------------------------------------------------------\n\n");
    1442:	00001517          	auipc	a0,0x1
    1446:	e8e50513          	addi	a0,a0,-370 # 22d0 <sharedmem+0xe0>
    144a:	100000ef          	jal	ra,154a <printf>
        while (1) {
    144e:	b381                	j	118e <main+0x18c>
                for (i = 0; i < tens; i++) {
    1450:	4401                	li	s0,0
    1452:	bda9                	j	12ac <main+0x2aa>
                exit(0);
    1454:	4501                	li	a0,0
    1456:	435000ef          	jal	ra,208a <exit>
    145a:	bb91                	j	11ae <main+0x1ac>
                        printf("UNUSED");
    145c:	00001517          	auipc	a0,0x1
    1460:	f7c50513          	addi	a0,a0,-132 # 23d8 <sharedmem+0x1e8>
    1464:	0e6000ef          	jal	ra,154a <printf>
    1468:	b7d9                	j	142e <main+0x42c>
            for (i = 0; i < tens; i++) {
    146a:	4901                	li	s2,0
    146c:	b5fd                	j	135a <main+0x358>
                        printf("USED");
    146e:	00001517          	auipc	a0,0x1
    1472:	f7250513          	addi	a0,a0,-142 # 23e0 <sharedmem+0x1f0>
    1476:	0d4000ef          	jal	ra,154a <printf>
    147a:	bf55                	j	142e <main+0x42c>
                        printf("SLEEPING");
    147c:	00001517          	auipc	a0,0x1
    1480:	f6c50513          	addi	a0,a0,-148 # 23e8 <sharedmem+0x1f8>
    1484:	0c6000ef          	jal	ra,154a <printf>
    1488:	b75d                	j	142e <main+0x42c>
                        printf("RUNNABLE");
    148a:	00001517          	auipc	a0,0x1
    148e:	f7e50513          	addi	a0,a0,-130 # 2408 <sharedmem+0x218>
    1492:	0b8000ef          	jal	ra,154a <printf>
    1496:	bf61                	j	142e <main+0x42c>
                        printf("RUNNING");
    1498:	00001517          	auipc	a0,0x1
    149c:	f6050513          	addi	a0,a0,-160 # 23f8 <sharedmem+0x208>
    14a0:	0aa000ef          	jal	ra,154a <printf>
    14a4:	b769                	j	142e <main+0x42c>
                        printf("ZOMBIE");
    14a6:	00001517          	auipc	a0,0x1
    14aa:	f5a50513          	addi	a0,a0,-166 # 2400 <sharedmem+0x210>
    14ae:	09c000ef          	jal	ra,154a <printf>
    14b2:	bfb5                	j	142e <main+0x42c>

00000000000014b4 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    14b4:	1141                	addi	sp,sp,-16
    14b6:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    14b8:	b4bff0ef          	jal	ra,1002 <main>
}
    14bc:	60a2                	ld	ra,8(sp)
    14be:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    14c0:	3cb0006f          	j	208a <exit>

00000000000014c4 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    14c4:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    14c6:	00f10593          	addi	a1,sp,15
    14ca:	4605                	li	a2,1
    14cc:	4501                	li	a0,0
int getchar() {
    14ce:	ec06                	sd	ra,24(sp)
    char byte = 0;
    14d0:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    14d4:	3c1000ef          	jal	ra,2094 <read>
    return byte;
}
    14d8:	60e2                	ld	ra,24(sp)
    14da:	00f14503          	lbu	a0,15(sp)
    14de:	6105                	addi	sp,sp,32
    14e0:	8082                	ret

00000000000014e2 <putchar>:

int putchar(int c)
{
    14e2:	1141                	addi	sp,sp,-16
    14e4:	e406                	sd	ra,8(sp)
    14e6:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    14e8:	00001597          	auipc	a1,0x1
    14ec:	f6058593          	addi	a1,a1,-160 # 2448 <put.1156>
    return write(stdout, put, 1);
    14f0:	4605                	li	a2,1
    14f2:	4505                	li	a0,1
    put[0] = c;
    14f4:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    14f8:	3a7000ef          	jal	ra,209e <write>
}
    14fc:	60a2                	ld	ra,8(sp)
    14fe:	2501                	sext.w	a0,a0
    1500:	0141                	addi	sp,sp,16
    1502:	8082                	ret

0000000000001504 <puts>:

int puts(const char* s)
{
    1504:	1141                	addi	sp,sp,-16
    1506:	e022                	sd	s0,0(sp)
    1508:	e406                	sd	ra,8(sp)
    150a:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    150c:	6b6000ef          	jal	ra,1bc2 <strlen>
    1510:	862a                	mv	a2,a0
    1512:	85a2                	mv	a1,s0
    1514:	4505                	li	a0,1
    1516:	389000ef          	jal	ra,209e <write>
    151a:	00055763          	bgez	a0,1528 <puts+0x24>
    return r;
}
    151e:	60a2                	ld	ra,8(sp)
    1520:	6402                	ld	s0,0(sp)
    1522:	557d                	li	a0,-1
    1524:	0141                	addi	sp,sp,16
    1526:	8082                	ret
    put[0] = c;
    1528:	00001597          	auipc	a1,0x1
    152c:	f2058593          	addi	a1,a1,-224 # 2448 <put.1156>
    1530:	47a9                	li	a5,10
    return write(stdout, put, 1);
    1532:	4605                	li	a2,1
    1534:	4505                	li	a0,1
    put[0] = c;
    1536:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    153a:	365000ef          	jal	ra,209e <write>
}
    153e:	60a2                	ld	ra,8(sp)
    1540:	6402                	ld	s0,0(sp)
    1542:	41f5551b          	sraiw	a0,a0,0x1f
    1546:	0141                	addi	sp,sp,16
    1548:	8082                	ret

000000000000154a <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    154a:	7115                	addi	sp,sp,-224
    154c:	ed06                	sd	ra,152(sp)
    154e:	e922                	sd	s0,144(sp)
    1550:	e526                	sd	s1,136(sp)
    1552:	e14a                	sd	s2,128(sp)
    1554:	fcce                	sd	s3,120(sp)
    1556:	f8d2                	sd	s4,112(sp)
    1558:	f4d6                	sd	s5,104(sp)
    155a:	f0da                	sd	s6,96(sp)
    155c:	ecde                	sd	s7,88(sp)
    155e:	e8e2                	sd	s8,80(sp)
    1560:	e4e6                	sd	s9,72(sp)
    1562:	e0ea                	sd	s10,64(sp)
    1564:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1566:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    156a:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    156c:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    156e:	f52e                	sd	a1,168(sp)
    1570:	f932                	sd	a2,176(sp)
    1572:	fd36                	sd	a3,184(sp)
    1574:	e1ba                	sd	a4,192(sp)
    1576:	e9c2                	sd	a6,208(sp)
    1578:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    157a:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    157c:	0c030b63          	beqz	t1,1652 <printf+0x108>
    1580:	8aaa                	mv	s5,a0
    1582:	0003071b          	sext.w	a4,t1
    1586:	4481                	li	s1,0
        if (c != '%') {
    1588:	02500b93          	li	s7,37
    put[0] = c;
    158c:	00001417          	auipc	s0,0x1
    1590:	ebc40413          	addi	s0,s0,-324 # 2448 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    1594:	4c51                	li	s8,20
    put[0] = c;
    1596:	02500c93          	li	s9,37
    159a:	00033a17          	auipc	s4,0x33
    159e:	ebea0a13          	addi	s4,s4,-322 # 34458 <bigdata+0x32000>
    15a2:	00033997          	auipc	s3,0x33
    15a6:	f0e98993          	addi	s3,s3,-242 # 344b0 <digits>
    15aa:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    15ae:	0014879b          	addiw	a5,s1,1
    15b2:	00fa8933          	add	s2,s5,a5
    15b6:	13771163          	bne	a4,s7,16d8 <printf+0x18e>
        c = fmt[++i] & 0xff;
    15ba:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    15be:	080d0a63          	beqz	s10,1652 <printf+0x108>
        switch (c) {
    15c2:	2489                	addiw	s1,s1,2
    15c4:	009a8933          	add	s2,s5,s1
    15c8:	257d0e63          	beq	s10,s7,1824 <printf+0x2da>
    15cc:	f9cd079b          	addiw	a5,s10,-100
    15d0:	0ff7f793          	andi	a5,a5,255
    15d4:	0cfc6263          	bltu	s8,a5,1698 <printf+0x14e>
    15d8:	078a                	slli	a5,a5,0x2
    15da:	97d2                	add	a5,a5,s4
    15dc:	439c                	lw	a5,0(a5)
    15de:	97d2                	add	a5,a5,s4
    15e0:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    15e2:	67a2                	ld	a5,8(sp)
    15e4:	4398                	lw	a4,0(a5)
    15e6:	07a1                	addi	a5,a5,8
    15e8:	e43e                	sd	a5,8(sp)
    15ea:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    15ee:	26074663          	bltz	a4,185a <printf+0x310>
        buf[i++] = digits[x % base];
    15f2:	8bbd                	andi	a5,a5,15
    15f4:	97ce                	add	a5,a5,s3
    15f6:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    15fa:	40475d1b          	sraiw	s10,a4,0x4
    15fe:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    1602:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    1606:	020d0163          	beqz	s10,1628 <printf+0xde>
        buf[i++] = digits[x % base];
    160a:	9d4e                	add	s10,s10,s3
    160c:	000d4783          	lbu	a5,0(s10)
    1610:	4d05                	li	s10,1
    1612:	00f108a3          	sb	a5,17(sp)
    if (sign)
    1616:	00075963          	bgez	a4,1628 <printf+0xde>
        buf[i++] = digits[x % base];
    161a:	4d09                	li	s10,2
        buf[i++] = '-';
    161c:	181c                	addi	a5,sp,48
    161e:	02d00713          	li	a4,45
    1622:	97ea                	add	a5,a5,s10
    1624:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    1628:	9d5a                	add	s10,s10,s6
    162a:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    162e:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1632:	4605                	li	a2,1
    1634:	1d7d                	addi	s10,s10,-1
    1636:	85a2                	mv	a1,s0
    1638:	4505                	li	a0,1
    put[0] = c;
    163a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    163e:	261000ef          	jal	ra,209e <write>
    while (--i >= 0)
    1642:	ffbd16e3          	bne	s10,s11,162e <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1646:	00094303          	lbu	t1,0(s2)
    164a:	0003071b          	sext.w	a4,t1
    164e:	f60310e3          	bnez	t1,15ae <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    1652:	60ea                	ld	ra,152(sp)
    1654:	644a                	ld	s0,144(sp)
    1656:	64aa                	ld	s1,136(sp)
    1658:	690a                	ld	s2,128(sp)
    165a:	79e6                	ld	s3,120(sp)
    165c:	7a46                	ld	s4,112(sp)
    165e:	7aa6                	ld	s5,104(sp)
    1660:	7b06                	ld	s6,96(sp)
    1662:	6be6                	ld	s7,88(sp)
    1664:	6c46                	ld	s8,80(sp)
    1666:	6ca6                	ld	s9,72(sp)
    1668:	6d06                	ld	s10,64(sp)
    166a:	7de2                	ld	s11,56(sp)
    166c:	612d                	addi	sp,sp,224
    166e:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    1670:	67a2                	ld	a5,8(sp)
    1672:	0007bd03          	ld	s10,0(a5)
    1676:	07a1                	addi	a5,a5,8
    1678:	e43e                	sd	a5,8(sp)
    167a:	000d1b63          	bnez	s10,1690 <printf+0x146>
    167e:	aafd                	j	187c <printf+0x332>
    return write(stdout, put, 1);
    1680:	4605                	li	a2,1
    1682:	85a2                	mv	a1,s0
    1684:	4505                	li	a0,1
                for (; *s; s++)
    1686:	0d05                	addi	s10,s10,1
    put[0] = c;
    1688:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    168c:	213000ef          	jal	ra,209e <write>
                for (; *s; s++)
    1690:	000d4783          	lbu	a5,0(s10)
    1694:	f7f5                	bnez	a5,1680 <printf+0x136>
    1696:	a02d                	j	16c0 <printf+0x176>
    return write(stdout, put, 1);
    1698:	4605                	li	a2,1
    169a:	00001597          	auipc	a1,0x1
    169e:	dae58593          	addi	a1,a1,-594 # 2448 <put.1156>
    16a2:	4505                	li	a0,1
    put[0] = c;
    16a4:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    16a8:	1f7000ef          	jal	ra,209e <write>
    16ac:	4605                	li	a2,1
    16ae:	00001597          	auipc	a1,0x1
    16b2:	d9a58593          	addi	a1,a1,-614 # 2448 <put.1156>
    16b6:	4505                	li	a0,1
    put[0] = c;
    16b8:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    16bc:	1e3000ef          	jal	ra,209e <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    16c0:	00094303          	lbu	t1,0(s2)
    16c4:	0003071b          	sext.w	a4,t1
    16c8:	f80305e3          	beqz	t1,1652 <printf+0x108>
        if (c != '%') {
    16cc:	0014879b          	addiw	a5,s1,1
    16d0:	00fa8933          	add	s2,s5,a5
    16d4:	ef7703e3          	beq	a4,s7,15ba <printf+0x70>
    return write(stdout, put, 1);
    16d8:	4605                	li	a2,1
    16da:	00001597          	auipc	a1,0x1
    16de:	d6e58593          	addi	a1,a1,-658 # 2448 <put.1156>
    16e2:	4505                	li	a0,1
    put[0] = c;
    16e4:	00640023          	sb	t1,0(s0)
            continue;
    16e8:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    16ea:	1b5000ef          	jal	ra,209e <write>
            continue;
    16ee:	bfc9                	j	16c0 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    16f0:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    16f2:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    16f4:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    16f6:	0007b883          	ld	a7,0(a5)
    16fa:	07a1                	addi	a5,a5,8
    16fc:	e43e                	sd	a5,8(sp)
        x = -xx;
    16fe:	43f8d713          	srai	a4,a7,0x3f
    1702:	011747b3          	xor	a5,a4,a7
    1706:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    1708:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    170a:	02c7f733          	remu	a4,a5,a2
    170e:	8d36                	mv	s10,a3
    1710:	0685                	addi	a3,a3,1
    1712:	00db0533          	add	a0,s6,a3
    1716:	85be                	mv	a1,a5
    1718:	974e                	add	a4,a4,s3
    171a:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    171e:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    1722:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    1726:	feb862e3          	bltu	a6,a1,170a <printf+0x1c0>
    if (sign)
    172a:	1208c063          	bltz	a7,184a <printf+0x300>
    while (--i >= 0)
    172e:	9d5a                	add	s10,s10,s6
    put[0] = c;
    1730:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1734:	4605                	li	a2,1
    1736:	85a2                	mv	a1,s0
    1738:	4505                	li	a0,1
    put[0] = c;
    173a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    173e:	161000ef          	jal	ra,209e <write>
    while (--i >= 0)
    1742:	87ea                	mv	a5,s10
    1744:	1d7d                	addi	s10,s10,-1
    1746:	fefb15e3          	bne	s6,a5,1730 <printf+0x1e6>
    174a:	bf9d                	j	16c0 <printf+0x176>
                printptr(va_arg(ap, uint64));
    174c:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    174e:	4605                	li	a2,1
    1750:	00001597          	auipc	a1,0x1
    1754:	cf858593          	addi	a1,a1,-776 # 2448 <put.1156>
                printptr(va_arg(ap, uint64));
    1758:	0007bd83          	ld	s11,0(a5)
    175c:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    1760:	4505                	li	a0,1
    put[0] = c;
    1762:	03000793          	li	a5,48
    1766:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    176a:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    176c:	133000ef          	jal	ra,209e <write>
    put[0] = c;
    1770:	07800793          	li	a5,120
    return write(stdout, put, 1);
    1774:	4605                	li	a2,1
    1776:	00001597          	auipc	a1,0x1
    177a:	cd258593          	addi	a1,a1,-814 # 2448 <put.1156>
    177e:	4505                	li	a0,1
    put[0] = c;
    1780:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1784:	4d41                	li	s10,16
    1786:	119000ef          	jal	ra,209e <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    178a:	03cdd793          	srli	a5,s11,0x3c
    178e:	97ce                	add	a5,a5,s3
    put[0] = c;
    1790:	0007c783          	lbu	a5,0(a5)
    1794:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    1796:	4605                	li	a2,1
    1798:	85a2                	mv	a1,s0
    179a:	4505                	li	a0,1
    put[0] = c;
    179c:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    17a0:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    17a2:	0fd000ef          	jal	ra,209e <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    17a6:	fe0d12e3          	bnez	s10,178a <printf+0x240>
    17aa:	bf19                	j	16c0 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    17ac:	67a2                	ld	a5,8(sp)
    17ae:	4394                	lw	a3,0(a5)
    17b0:	07a1                	addi	a5,a5,8
    17b2:	e43e                	sd	a5,8(sp)
    17b4:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    17b8:	0006d663          	bgez	a3,17c4 <printf+0x27a>
        x = -xx;
    17bc:	40f007bb          	negw	a5,a5
    17c0:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    17c4:	4729                	li	a4,10
    17c6:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    17ca:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    17ce:	964e                	add	a2,a2,s3
    17d0:	00064603          	lbu	a2,0(a2)
    17d4:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    17d8:	0a0d0963          	beqz	s10,188a <printf+0x340>
        buf[i++] = digits[x % base];
    17dc:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    17e0:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    17e4:	00c98733          	add	a4,s3,a2
    17e8:	00074703          	lbu	a4,0(a4)
    17ec:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    17f0:	c3cd                	beqz	a5,1892 <printf+0x348>
        buf[i++] = digits[x % base];
    17f2:	97ce                	add	a5,a5,s3
    17f4:	0007c703          	lbu	a4,0(a5)
    17f8:	4d09                	li	s10,2
    17fa:	478d                	li	a5,3
    17fc:	00e10923          	sb	a4,18(sp)
    if (sign)
    1800:	0206cd63          	bltz	a3,183a <printf+0x2f0>
    while (--i >= 0)
    1804:	9d5a                	add	s10,s10,s6
    1806:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    180a:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    180e:	4605                	li	a2,1
    1810:	1d7d                	addi	s10,s10,-1
    1812:	85a2                	mv	a1,s0
    1814:	4505                	li	a0,1
    put[0] = c;
    1816:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    181a:	085000ef          	jal	ra,209e <write>
    while (--i >= 0)
    181e:	ffbd16e3          	bne	s10,s11,180a <printf+0x2c0>
    1822:	bd79                	j	16c0 <printf+0x176>
    return write(stdout, put, 1);
    1824:	4605                	li	a2,1
    1826:	00001597          	auipc	a1,0x1
    182a:	c2258593          	addi	a1,a1,-990 # 2448 <put.1156>
    182e:	4505                	li	a0,1
    put[0] = c;
    1830:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    1834:	06b000ef          	jal	ra,209e <write>
    1838:	b561                	j	16c0 <printf+0x176>
        buf[i++] = '-';
    183a:	1818                	addi	a4,sp,48
    183c:	973e                	add	a4,a4,a5
    183e:	02d00693          	li	a3,45
    1842:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    1846:	8d3e                	mv	s10,a5
    1848:	bf75                	j	1804 <printf+0x2ba>
        buf[i++] = '-';
    184a:	181c                	addi	a5,sp,48
    184c:	97b6                	add	a5,a5,a3
    184e:	02d00713          	li	a4,45
    1852:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    1856:	8d36                	mv	s10,a3
    1858:	bdd9                	j	172e <printf+0x1e4>
        x = -xx;
    185a:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    185e:	00f7f693          	andi	a3,a5,15
    1862:	96ce                	add	a3,a3,s3
    1864:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    1868:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    186c:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    1870:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1874:	d80d1be3          	bnez	s10,160a <printf+0xc0>
        buf[i++] = digits[x % base];
    1878:	4d05                	li	s10,1
    187a:	b34d                	j	161c <printf+0xd2>
                s = "(null)";
    187c:	00001d17          	auipc	s10,0x1
    1880:	ba4d0d13          	addi	s10,s10,-1116 # 2420 <sharedmem+0x230>
                for (; *s; s++)
    1884:	02800793          	li	a5,40
    1888:	bbe5                	j	1680 <printf+0x136>
        buf[i++] = digits[x % base];
    188a:	4785                	li	a5,1
    if (sign)
    188c:	f606dce3          	bgez	a3,1804 <printf+0x2ba>
    1890:	b76d                	j	183a <printf+0x2f0>
        buf[i++] = digits[x % base];
    1892:	4789                	li	a5,2
    1894:	4d05                	li	s10,1
    if (sign)
    1896:	f606d7e3          	bgez	a3,1804 <printf+0x2ba>
    189a:	b745                	j	183a <printf+0x2f0>

000000000000189c <srand>:
#include <ucore.h>

static uint64 seed;

void srand(unsigned s) {
    seed = s - 1;
    189c:	357d                	addiw	a0,a0,-1
    189e:	1502                	slli	a0,a0,0x20
    18a0:	9101                	srli	a0,a0,0x20
    18a2:	00001797          	auipc	a5,0x1
    18a6:	baa7b723          	sd	a0,-1106(a5) # 2450 <seed>
}
    18aa:	8082                	ret

00000000000018ac <rand>:

int rand(void) {
    seed = 6364136223846793005ULL * seed + 1;
    18ac:	00001797          	auipc	a5,0x1
    18b0:	ba478793          	addi	a5,a5,-1116 # 2450 <seed>
    18b4:	6388                	ld	a0,0(a5)
    18b6:	00001717          	auipc	a4,0x1
    18ba:	b7273703          	ld	a4,-1166(a4) # 2428 <sharedmem+0x238>
    18be:	02e50533          	mul	a0,a0,a4
    18c2:	0505                	addi	a0,a0,1
    18c4:	e388                	sd	a0,0(a5)
    return seed >> 33;
}
    18c6:	9105                	srli	a0,a0,0x21
    18c8:	8082                	ret

00000000000018ca <panic>:

void panic(char* m) {
    18ca:	1141                	addi	sp,sp,-16
    18cc:	e406                	sd	ra,8(sp)
    puts(m);
    18ce:	c37ff0ef          	jal	ra,1504 <puts>
    exit(-100);
}
    18d2:	60a2                	ld	ra,8(sp)
    exit(-100);
    18d4:	f9c00513          	li	a0,-100
}
    18d8:	0141                	addi	sp,sp,16
    exit(-100);
    18da:	af45                	j	208a <exit>

00000000000018dc <assert>:

void assert(int f, int code) {
    if(!f) {
    18dc:	c111                	beqz	a0,18e0 <assert+0x4>
        exit(code);
    }
    18de:	8082                	ret
        exit(code);
    18e0:	852e                	mv	a0,a1
    18e2:	a765                	j	208a <exit>

00000000000018e4 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    18e4:	02000793          	li	a5,32
    18e8:	00f50663          	beq	a0,a5,18f4 <isspace+0x10>
    18ec:	355d                	addiw	a0,a0,-9
    18ee:	00553513          	sltiu	a0,a0,5
    18f2:	8082                	ret
    18f4:	4505                	li	a0,1
}
    18f6:	8082                	ret

00000000000018f8 <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    18f8:	fd05051b          	addiw	a0,a0,-48
}
    18fc:	00a53513          	sltiu	a0,a0,10
    1900:	8082                	ret

0000000000001902 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1902:	02000613          	li	a2,32
    1906:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    1908:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    190c:	ff77069b          	addiw	a3,a4,-9
    1910:	04c70d63          	beq	a4,a2,196a <atoi+0x68>
    1914:	0007079b          	sext.w	a5,a4
    1918:	04d5f963          	bgeu	a1,a3,196a <atoi+0x68>
        s++;
    switch (*s) {
    191c:	02b00693          	li	a3,43
    1920:	04d70a63          	beq	a4,a3,1974 <atoi+0x72>
    1924:	02d00693          	li	a3,45
    1928:	06d70463          	beq	a4,a3,1990 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    192c:	fd07859b          	addiw	a1,a5,-48
    1930:	4625                	li	a2,9
    1932:	873e                	mv	a4,a5
    1934:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1936:	4e01                	li	t3,0
    while (isdigit(*s))
    1938:	04b66a63          	bltu	a2,a1,198c <atoi+0x8a>
    int n = 0, neg = 0;
    193c:	4501                	li	a0,0
    while (isdigit(*s))
    193e:	4825                	li	a6,9
    1940:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1944:	0025179b          	slliw	a5,a0,0x2
    1948:	9d3d                	addw	a0,a0,a5
    194a:	fd07031b          	addiw	t1,a4,-48
    194e:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1952:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1956:	0685                	addi	a3,a3,1
    1958:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    195c:	0006071b          	sext.w	a4,a2
    1960:	feb870e3          	bgeu	a6,a1,1940 <atoi+0x3e>
    return neg ? n : -n;
    1964:	000e0563          	beqz	t3,196e <atoi+0x6c>
}
    1968:	8082                	ret
        s++;
    196a:	0505                	addi	a0,a0,1
    196c:	bf71                	j	1908 <atoi+0x6>
    196e:	4113053b          	subw	a0,t1,a7
    1972:	8082                	ret
    while (isdigit(*s))
    1974:	00154783          	lbu	a5,1(a0)
    1978:	4625                	li	a2,9
        s++;
    197a:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    197e:	fd07859b          	addiw	a1,a5,-48
    1982:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1986:	4e01                	li	t3,0
    while (isdigit(*s))
    1988:	fab67ae3          	bgeu	a2,a1,193c <atoi+0x3a>
    198c:	4501                	li	a0,0
}
    198e:	8082                	ret
    while (isdigit(*s))
    1990:	00154783          	lbu	a5,1(a0)
    1994:	4625                	li	a2,9
        s++;
    1996:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    199a:	fd07859b          	addiw	a1,a5,-48
    199e:	0007871b          	sext.w	a4,a5
    19a2:	feb665e3          	bltu	a2,a1,198c <atoi+0x8a>
        neg = 1;
    19a6:	4e05                	li	t3,1
    19a8:	bf51                	j	193c <atoi+0x3a>

00000000000019aa <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    19aa:	16060d63          	beqz	a2,1b24 <memset+0x17a>
    19ae:	40a007b3          	neg	a5,a0
    19b2:	8b9d                	andi	a5,a5,7
    19b4:	00778713          	addi	a4,a5,7
    19b8:	482d                	li	a6,11
    19ba:	0ff5f593          	andi	a1,a1,255
    19be:	fff60693          	addi	a3,a2,-1
    19c2:	17076263          	bltu	a4,a6,1b26 <memset+0x17c>
    19c6:	16e6ea63          	bltu	a3,a4,1b3a <memset+0x190>
    19ca:	16078563          	beqz	a5,1b34 <memset+0x18a>
    19ce:	00b50023          	sb	a1,0(a0)
    19d2:	4705                	li	a4,1
    19d4:	00150e93          	addi	t4,a0,1
    19d8:	14e78c63          	beq	a5,a4,1b30 <memset+0x186>
    19dc:	00b500a3          	sb	a1,1(a0)
    19e0:	4709                	li	a4,2
    19e2:	00250e93          	addi	t4,a0,2
    19e6:	14e78d63          	beq	a5,a4,1b40 <memset+0x196>
    19ea:	00b50123          	sb	a1,2(a0)
    19ee:	470d                	li	a4,3
    19f0:	00350e93          	addi	t4,a0,3
    19f4:	12e78b63          	beq	a5,a4,1b2a <memset+0x180>
    19f8:	00b501a3          	sb	a1,3(a0)
    19fc:	4711                	li	a4,4
    19fe:	00450e93          	addi	t4,a0,4
    1a02:	14e78163          	beq	a5,a4,1b44 <memset+0x19a>
    1a06:	00b50223          	sb	a1,4(a0)
    1a0a:	4715                	li	a4,5
    1a0c:	00550e93          	addi	t4,a0,5
    1a10:	12e78c63          	beq	a5,a4,1b48 <memset+0x19e>
    1a14:	00b502a3          	sb	a1,5(a0)
    1a18:	471d                	li	a4,7
    1a1a:	00650e93          	addi	t4,a0,6
    1a1e:	12e79763          	bne	a5,a4,1b4c <memset+0x1a2>
    1a22:	00750e93          	addi	t4,a0,7
    1a26:	00b50323          	sb	a1,6(a0)
    1a2a:	4f1d                	li	t5,7
    1a2c:	00859713          	slli	a4,a1,0x8
    1a30:	8f4d                	or	a4,a4,a1
    1a32:	01059e13          	slli	t3,a1,0x10
    1a36:	01c76e33          	or	t3,a4,t3
    1a3a:	01859313          	slli	t1,a1,0x18
    1a3e:	006e6333          	or	t1,t3,t1
    1a42:	02059893          	slli	a7,a1,0x20
    1a46:	011368b3          	or	a7,t1,a7
    1a4a:	02859813          	slli	a6,a1,0x28
    1a4e:	40f60333          	sub	t1,a2,a5
    1a52:	0108e833          	or	a6,a7,a6
    1a56:	03059693          	slli	a3,a1,0x30
    1a5a:	00d866b3          	or	a3,a6,a3
    1a5e:	03859713          	slli	a4,a1,0x38
    1a62:	97aa                	add	a5,a5,a0
    1a64:	ff837813          	andi	a6,t1,-8
    1a68:	8f55                	or	a4,a4,a3
    1a6a:	00f806b3          	add	a3,a6,a5
    1a6e:	e398                	sd	a4,0(a5)
    1a70:	07a1                	addi	a5,a5,8
    1a72:	fed79ee3          	bne	a5,a3,1a6e <memset+0xc4>
    1a76:	ff837693          	andi	a3,t1,-8
    1a7a:	00de87b3          	add	a5,t4,a3
    1a7e:	01e6873b          	addw	a4,a3,t5
    1a82:	0ad30663          	beq	t1,a3,1b2e <memset+0x184>
    1a86:	00b78023          	sb	a1,0(a5)
    1a8a:	0017069b          	addiw	a3,a4,1
    1a8e:	08c6fb63          	bgeu	a3,a2,1b24 <memset+0x17a>
    1a92:	00b780a3          	sb	a1,1(a5)
    1a96:	0027069b          	addiw	a3,a4,2
    1a9a:	08c6f563          	bgeu	a3,a2,1b24 <memset+0x17a>
    1a9e:	00b78123          	sb	a1,2(a5)
    1aa2:	0037069b          	addiw	a3,a4,3
    1aa6:	06c6ff63          	bgeu	a3,a2,1b24 <memset+0x17a>
    1aaa:	00b781a3          	sb	a1,3(a5)
    1aae:	0047069b          	addiw	a3,a4,4
    1ab2:	06c6f963          	bgeu	a3,a2,1b24 <memset+0x17a>
    1ab6:	00b78223          	sb	a1,4(a5)
    1aba:	0057069b          	addiw	a3,a4,5
    1abe:	06c6f363          	bgeu	a3,a2,1b24 <memset+0x17a>
    1ac2:	00b782a3          	sb	a1,5(a5)
    1ac6:	0067069b          	addiw	a3,a4,6
    1aca:	04c6fd63          	bgeu	a3,a2,1b24 <memset+0x17a>
    1ace:	00b78323          	sb	a1,6(a5)
    1ad2:	0077069b          	addiw	a3,a4,7
    1ad6:	04c6f763          	bgeu	a3,a2,1b24 <memset+0x17a>
    1ada:	00b783a3          	sb	a1,7(a5)
    1ade:	0087069b          	addiw	a3,a4,8
    1ae2:	04c6f163          	bgeu	a3,a2,1b24 <memset+0x17a>
    1ae6:	00b78423          	sb	a1,8(a5)
    1aea:	0097069b          	addiw	a3,a4,9
    1aee:	02c6fb63          	bgeu	a3,a2,1b24 <memset+0x17a>
    1af2:	00b784a3          	sb	a1,9(a5)
    1af6:	00a7069b          	addiw	a3,a4,10
    1afa:	02c6f563          	bgeu	a3,a2,1b24 <memset+0x17a>
    1afe:	00b78523          	sb	a1,10(a5)
    1b02:	00b7069b          	addiw	a3,a4,11
    1b06:	00c6ff63          	bgeu	a3,a2,1b24 <memset+0x17a>
    1b0a:	00b785a3          	sb	a1,11(a5)
    1b0e:	00c7069b          	addiw	a3,a4,12
    1b12:	00c6f963          	bgeu	a3,a2,1b24 <memset+0x17a>
    1b16:	00b78623          	sb	a1,12(a5)
    1b1a:	2735                	addiw	a4,a4,13
    1b1c:	00c77463          	bgeu	a4,a2,1b24 <memset+0x17a>
    1b20:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    1b24:	8082                	ret
    1b26:	472d                	li	a4,11
    1b28:	bd79                	j	19c6 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1b2a:	4f0d                	li	t5,3
    1b2c:	b701                	j	1a2c <memset+0x82>
    1b2e:	8082                	ret
    1b30:	4f05                	li	t5,1
    1b32:	bded                	j	1a2c <memset+0x82>
    1b34:	8eaa                	mv	t4,a0
    1b36:	4f01                	li	t5,0
    1b38:	bdd5                	j	1a2c <memset+0x82>
    1b3a:	87aa                	mv	a5,a0
    1b3c:	4701                	li	a4,0
    1b3e:	b7a1                	j	1a86 <memset+0xdc>
    1b40:	4f09                	li	t5,2
    1b42:	b5ed                	j	1a2c <memset+0x82>
    1b44:	4f11                	li	t5,4
    1b46:	b5dd                	j	1a2c <memset+0x82>
    1b48:	4f15                	li	t5,5
    1b4a:	b5cd                	j	1a2c <memset+0x82>
    1b4c:	4f19                	li	t5,6
    1b4e:	bdf9                	j	1a2c <memset+0x82>

0000000000001b50 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    1b50:	00054783          	lbu	a5,0(a0)
    1b54:	0005c703          	lbu	a4,0(a1)
    1b58:	00e79863          	bne	a5,a4,1b68 <strcmp+0x18>
    1b5c:	0505                	addi	a0,a0,1
    1b5e:	0585                	addi	a1,a1,1
    1b60:	fbe5                	bnez	a5,1b50 <strcmp>
    1b62:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    1b64:	9d19                	subw	a0,a0,a4
    1b66:	8082                	ret
    1b68:	0007851b          	sext.w	a0,a5
    1b6c:	bfe5                	j	1b64 <strcmp+0x14>

0000000000001b6e <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1b6e:	87aa                	mv	a5,a0
    1b70:	0005c703          	lbu	a4,0(a1)
    1b74:	0785                	addi	a5,a5,1
    1b76:	0585                	addi	a1,a1,1
    1b78:	fee78fa3          	sb	a4,-1(a5)
    1b7c:	fb75                	bnez	a4,1b70 <strcpy+0x2>
        ;
    return os;
}
    1b7e:	8082                	ret

0000000000001b80 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    1b80:	ce05                	beqz	a2,1bb8 <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1b82:	00054703          	lbu	a4,0(a0)
    1b86:	0005c783          	lbu	a5,0(a1)
    1b8a:	cb0d                	beqz	a4,1bbc <strncmp+0x3c>
    if (!n--)
    1b8c:	167d                	addi	a2,a2,-1
    1b8e:	00c506b3          	add	a3,a0,a2
    1b92:	a819                	j	1ba8 <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1b94:	00a68e63          	beq	a3,a0,1bb0 <strncmp+0x30>
    1b98:	0505                	addi	a0,a0,1
    1b9a:	00e79b63          	bne	a5,a4,1bb0 <strncmp+0x30>
    1b9e:	00054703          	lbu	a4,0(a0)
    1ba2:	0005c783          	lbu	a5,0(a1)
    1ba6:	cb19                	beqz	a4,1bbc <strncmp+0x3c>
    1ba8:	0005c783          	lbu	a5,0(a1)
    1bac:	0585                	addi	a1,a1,1
    1bae:	f3fd                	bnez	a5,1b94 <strncmp+0x14>
        ;
    return *l - *r;
    1bb0:	0007051b          	sext.w	a0,a4
    1bb4:	9d1d                	subw	a0,a0,a5
    1bb6:	8082                	ret
        return 0;
    1bb8:	4501                	li	a0,0
}
    1bba:	8082                	ret
    1bbc:	4501                	li	a0,0
    return *l - *r;
    1bbe:	9d1d                	subw	a0,a0,a5
    1bc0:	8082                	ret

0000000000001bc2 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    1bc2:	00757793          	andi	a5,a0,7
    1bc6:	cf89                	beqz	a5,1be0 <strlen+0x1e>
    1bc8:	87aa                	mv	a5,a0
    1bca:	a029                	j	1bd4 <strlen+0x12>
    1bcc:	0785                	addi	a5,a5,1
    1bce:	0077f713          	andi	a4,a5,7
    1bd2:	cb01                	beqz	a4,1be2 <strlen+0x20>
        if (!*s)
    1bd4:	0007c703          	lbu	a4,0(a5)
    1bd8:	fb75                	bnez	a4,1bcc <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1bda:	40a78533          	sub	a0,a5,a0
}
    1bde:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1be0:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    1be2:	6394                	ld	a3,0(a5)
    1be4:	00001597          	auipc	a1,0x1
    1be8:	84c5b583          	ld	a1,-1972(a1) # 2430 <sharedmem+0x240>
    1bec:	00001617          	auipc	a2,0x1
    1bf0:	84c63603          	ld	a2,-1972(a2) # 2438 <sharedmem+0x248>
    1bf4:	a019                	j	1bfa <strlen+0x38>
    1bf6:	6794                	ld	a3,8(a5)
    1bf8:	07a1                	addi	a5,a5,8
    1bfa:	00b68733          	add	a4,a3,a1
    1bfe:	fff6c693          	not	a3,a3
    1c02:	8f75                	and	a4,a4,a3
    1c04:	8f71                	and	a4,a4,a2
    1c06:	db65                	beqz	a4,1bf6 <strlen+0x34>
    for (; *s; s++)
    1c08:	0007c703          	lbu	a4,0(a5)
    1c0c:	d779                	beqz	a4,1bda <strlen+0x18>
    1c0e:	0017c703          	lbu	a4,1(a5)
    1c12:	0785                	addi	a5,a5,1
    1c14:	d379                	beqz	a4,1bda <strlen+0x18>
    1c16:	0017c703          	lbu	a4,1(a5)
    1c1a:	0785                	addi	a5,a5,1
    1c1c:	fb6d                	bnez	a4,1c0e <strlen+0x4c>
    1c1e:	bf75                	j	1bda <strlen+0x18>

0000000000001c20 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1c20:	00757713          	andi	a4,a0,7
{
    1c24:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1c26:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1c2a:	cb19                	beqz	a4,1c40 <memchr+0x20>
    1c2c:	ce25                	beqz	a2,1ca4 <memchr+0x84>
    1c2e:	0007c703          	lbu	a4,0(a5)
    1c32:	04b70e63          	beq	a4,a1,1c8e <memchr+0x6e>
    1c36:	0785                	addi	a5,a5,1
    1c38:	0077f713          	andi	a4,a5,7
    1c3c:	167d                	addi	a2,a2,-1
    1c3e:	f77d                	bnez	a4,1c2c <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    1c40:	4501                	li	a0,0
    if (n && *s != c) {
    1c42:	c235                	beqz	a2,1ca6 <memchr+0x86>
    1c44:	0007c703          	lbu	a4,0(a5)
    1c48:	04b70363          	beq	a4,a1,1c8e <memchr+0x6e>
        size_t k = ONES * c;
    1c4c:	00000517          	auipc	a0,0x0
    1c50:	7f453503          	ld	a0,2036(a0) # 2440 <sharedmem+0x250>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1c54:	471d                	li	a4,7
        size_t k = ONES * c;
    1c56:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1c5a:	02c77a63          	bgeu	a4,a2,1c8e <memchr+0x6e>
    1c5e:	00000897          	auipc	a7,0x0
    1c62:	7d28b883          	ld	a7,2002(a7) # 2430 <sharedmem+0x240>
    1c66:	00000817          	auipc	a6,0x0
    1c6a:	7d283803          	ld	a6,2002(a6) # 2438 <sharedmem+0x248>
    1c6e:	431d                	li	t1,7
    1c70:	a029                	j	1c7a <memchr+0x5a>
    1c72:	1661                	addi	a2,a2,-8
    1c74:	07a1                	addi	a5,a5,8
    1c76:	02c37963          	bgeu	t1,a2,1ca8 <memchr+0x88>
    1c7a:	6398                	ld	a4,0(a5)
    1c7c:	8f29                	xor	a4,a4,a0
    1c7e:	011706b3          	add	a3,a4,a7
    1c82:	fff74713          	not	a4,a4
    1c86:	8f75                	and	a4,a4,a3
    1c88:	01077733          	and	a4,a4,a6
    1c8c:	d37d                	beqz	a4,1c72 <memchr+0x52>
    1c8e:	853e                	mv	a0,a5
    1c90:	97b2                	add	a5,a5,a2
    1c92:	a021                	j	1c9a <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1c94:	0505                	addi	a0,a0,1
    1c96:	00f50763          	beq	a0,a5,1ca4 <memchr+0x84>
    1c9a:	00054703          	lbu	a4,0(a0)
    1c9e:	feb71be3          	bne	a4,a1,1c94 <memchr+0x74>
    1ca2:	8082                	ret
    return n ? (void*)s : 0;
    1ca4:	4501                	li	a0,0
}
    1ca6:	8082                	ret
    return n ? (void*)s : 0;
    1ca8:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1caa:	f275                	bnez	a2,1c8e <memchr+0x6e>
}
    1cac:	8082                	ret

0000000000001cae <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1cae:	1101                	addi	sp,sp,-32
    1cb0:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1cb2:	862e                	mv	a2,a1
{
    1cb4:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1cb6:	4581                	li	a1,0
{
    1cb8:	e426                	sd	s1,8(sp)
    1cba:	ec06                	sd	ra,24(sp)
    1cbc:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1cbe:	f63ff0ef          	jal	ra,1c20 <memchr>
    return p ? p - s : n;
    1cc2:	c519                	beqz	a0,1cd0 <strnlen+0x22>
}
    1cc4:	60e2                	ld	ra,24(sp)
    1cc6:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1cc8:	8d05                	sub	a0,a0,s1
}
    1cca:	64a2                	ld	s1,8(sp)
    1ccc:	6105                	addi	sp,sp,32
    1cce:	8082                	ret
    1cd0:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1cd2:	8522                	mv	a0,s0
}
    1cd4:	6442                	ld	s0,16(sp)
    1cd6:	64a2                	ld	s1,8(sp)
    1cd8:	6105                	addi	sp,sp,32
    1cda:	8082                	ret

0000000000001cdc <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1cdc:	00b547b3          	xor	a5,a0,a1
    1ce0:	8b9d                	andi	a5,a5,7
    1ce2:	eb95                	bnez	a5,1d16 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1ce4:	0075f793          	andi	a5,a1,7
    1ce8:	e7b1                	bnez	a5,1d34 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1cea:	6198                	ld	a4,0(a1)
    1cec:	00000617          	auipc	a2,0x0
    1cf0:	74463603          	ld	a2,1860(a2) # 2430 <sharedmem+0x240>
    1cf4:	00000817          	auipc	a6,0x0
    1cf8:	74483803          	ld	a6,1860(a6) # 2438 <sharedmem+0x248>
    1cfc:	a029                	j	1d06 <stpcpy+0x2a>
    1cfe:	e118                	sd	a4,0(a0)
    1d00:	6598                	ld	a4,8(a1)
    1d02:	05a1                	addi	a1,a1,8
    1d04:	0521                	addi	a0,a0,8
    1d06:	00c707b3          	add	a5,a4,a2
    1d0a:	fff74693          	not	a3,a4
    1d0e:	8ff5                	and	a5,a5,a3
    1d10:	0107f7b3          	and	a5,a5,a6
    1d14:	d7ed                	beqz	a5,1cfe <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1d16:	0005c783          	lbu	a5,0(a1)
    1d1a:	00f50023          	sb	a5,0(a0)
    1d1e:	c785                	beqz	a5,1d46 <stpcpy+0x6a>
    1d20:	0015c783          	lbu	a5,1(a1)
    1d24:	0505                	addi	a0,a0,1
    1d26:	0585                	addi	a1,a1,1
    1d28:	00f50023          	sb	a5,0(a0)
    1d2c:	fbf5                	bnez	a5,1d20 <stpcpy+0x44>
        ;
    return d;
}
    1d2e:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1d30:	0505                	addi	a0,a0,1
    1d32:	df45                	beqz	a4,1cea <stpcpy+0xe>
            if (!(*d = *s))
    1d34:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1d38:	0585                	addi	a1,a1,1
    1d3a:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1d3e:	00f50023          	sb	a5,0(a0)
    1d42:	f7fd                	bnez	a5,1d30 <stpcpy+0x54>
}
    1d44:	8082                	ret
    1d46:	8082                	ret

0000000000001d48 <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1d48:	00b547b3          	xor	a5,a0,a1
    1d4c:	8b9d                	andi	a5,a5,7
    1d4e:	1a079863          	bnez	a5,1efe <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1d52:	0075f793          	andi	a5,a1,7
    1d56:	16078463          	beqz	a5,1ebe <stpncpy+0x176>
    1d5a:	ea01                	bnez	a2,1d6a <stpncpy+0x22>
    1d5c:	a421                	j	1f64 <stpncpy+0x21c>
    1d5e:	167d                	addi	a2,a2,-1
    1d60:	0505                	addi	a0,a0,1
    1d62:	14070e63          	beqz	a4,1ebe <stpncpy+0x176>
    1d66:	1a060863          	beqz	a2,1f16 <stpncpy+0x1ce>
    1d6a:	0005c783          	lbu	a5,0(a1)
    1d6e:	0585                	addi	a1,a1,1
    1d70:	0075f713          	andi	a4,a1,7
    1d74:	00f50023          	sb	a5,0(a0)
    1d78:	f3fd                	bnez	a5,1d5e <stpncpy+0x16>
    1d7a:	4805                	li	a6,1
    1d7c:	1a061863          	bnez	a2,1f2c <stpncpy+0x1e4>
    1d80:	40a007b3          	neg	a5,a0
    1d84:	8b9d                	andi	a5,a5,7
    1d86:	4681                	li	a3,0
    1d88:	18061a63          	bnez	a2,1f1c <stpncpy+0x1d4>
    1d8c:	00778713          	addi	a4,a5,7
    1d90:	45ad                	li	a1,11
    1d92:	18b76363          	bltu	a4,a1,1f18 <stpncpy+0x1d0>
    1d96:	1ae6eb63          	bltu	a3,a4,1f4c <stpncpy+0x204>
    1d9a:	1a078363          	beqz	a5,1f40 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1d9e:	00050023          	sb	zero,0(a0)
    1da2:	4685                	li	a3,1
    1da4:	00150713          	addi	a4,a0,1
    1da8:	18d78f63          	beq	a5,a3,1f46 <stpncpy+0x1fe>
    1dac:	000500a3          	sb	zero,1(a0)
    1db0:	4689                	li	a3,2
    1db2:	00250713          	addi	a4,a0,2
    1db6:	18d78e63          	beq	a5,a3,1f52 <stpncpy+0x20a>
    1dba:	00050123          	sb	zero,2(a0)
    1dbe:	468d                	li	a3,3
    1dc0:	00350713          	addi	a4,a0,3
    1dc4:	16d78c63          	beq	a5,a3,1f3c <stpncpy+0x1f4>
    1dc8:	000501a3          	sb	zero,3(a0)
    1dcc:	4691                	li	a3,4
    1dce:	00450713          	addi	a4,a0,4
    1dd2:	18d78263          	beq	a5,a3,1f56 <stpncpy+0x20e>
    1dd6:	00050223          	sb	zero,4(a0)
    1dda:	4695                	li	a3,5
    1ddc:	00550713          	addi	a4,a0,5
    1de0:	16d78d63          	beq	a5,a3,1f5a <stpncpy+0x212>
    1de4:	000502a3          	sb	zero,5(a0)
    1de8:	469d                	li	a3,7
    1dea:	00650713          	addi	a4,a0,6
    1dee:	16d79863          	bne	a5,a3,1f5e <stpncpy+0x216>
    1df2:	00750713          	addi	a4,a0,7
    1df6:	00050323          	sb	zero,6(a0)
    1dfa:	40f80833          	sub	a6,a6,a5
    1dfe:	ff887593          	andi	a1,a6,-8
    1e02:	97aa                	add	a5,a5,a0
    1e04:	95be                	add	a1,a1,a5
    1e06:	0007b023          	sd	zero,0(a5)
    1e0a:	07a1                	addi	a5,a5,8
    1e0c:	feb79de3          	bne	a5,a1,1e06 <stpncpy+0xbe>
    1e10:	ff887593          	andi	a1,a6,-8
    1e14:	9ead                	addw	a3,a3,a1
    1e16:	00b707b3          	add	a5,a4,a1
    1e1a:	12b80863          	beq	a6,a1,1f4a <stpncpy+0x202>
    1e1e:	00078023          	sb	zero,0(a5)
    1e22:	0016871b          	addiw	a4,a3,1
    1e26:	0ec77863          	bgeu	a4,a2,1f16 <stpncpy+0x1ce>
    1e2a:	000780a3          	sb	zero,1(a5)
    1e2e:	0026871b          	addiw	a4,a3,2
    1e32:	0ec77263          	bgeu	a4,a2,1f16 <stpncpy+0x1ce>
    1e36:	00078123          	sb	zero,2(a5)
    1e3a:	0036871b          	addiw	a4,a3,3
    1e3e:	0cc77c63          	bgeu	a4,a2,1f16 <stpncpy+0x1ce>
    1e42:	000781a3          	sb	zero,3(a5)
    1e46:	0046871b          	addiw	a4,a3,4
    1e4a:	0cc77663          	bgeu	a4,a2,1f16 <stpncpy+0x1ce>
    1e4e:	00078223          	sb	zero,4(a5)
    1e52:	0056871b          	addiw	a4,a3,5
    1e56:	0cc77063          	bgeu	a4,a2,1f16 <stpncpy+0x1ce>
    1e5a:	000782a3          	sb	zero,5(a5)
    1e5e:	0066871b          	addiw	a4,a3,6
    1e62:	0ac77a63          	bgeu	a4,a2,1f16 <stpncpy+0x1ce>
    1e66:	00078323          	sb	zero,6(a5)
    1e6a:	0076871b          	addiw	a4,a3,7
    1e6e:	0ac77463          	bgeu	a4,a2,1f16 <stpncpy+0x1ce>
    1e72:	000783a3          	sb	zero,7(a5)
    1e76:	0086871b          	addiw	a4,a3,8
    1e7a:	08c77e63          	bgeu	a4,a2,1f16 <stpncpy+0x1ce>
    1e7e:	00078423          	sb	zero,8(a5)
    1e82:	0096871b          	addiw	a4,a3,9
    1e86:	08c77863          	bgeu	a4,a2,1f16 <stpncpy+0x1ce>
    1e8a:	000784a3          	sb	zero,9(a5)
    1e8e:	00a6871b          	addiw	a4,a3,10
    1e92:	08c77263          	bgeu	a4,a2,1f16 <stpncpy+0x1ce>
    1e96:	00078523          	sb	zero,10(a5)
    1e9a:	00b6871b          	addiw	a4,a3,11
    1e9e:	06c77c63          	bgeu	a4,a2,1f16 <stpncpy+0x1ce>
    1ea2:	000785a3          	sb	zero,11(a5)
    1ea6:	00c6871b          	addiw	a4,a3,12
    1eaa:	06c77663          	bgeu	a4,a2,1f16 <stpncpy+0x1ce>
    1eae:	00078623          	sb	zero,12(a5)
    1eb2:	26b5                	addiw	a3,a3,13
    1eb4:	06c6f163          	bgeu	a3,a2,1f16 <stpncpy+0x1ce>
    1eb8:	000786a3          	sb	zero,13(a5)
    1ebc:	8082                	ret
            ;
        if (!n || !*s)
    1ebe:	c645                	beqz	a2,1f66 <stpncpy+0x21e>
    1ec0:	0005c783          	lbu	a5,0(a1)
    1ec4:	ea078be3          	beqz	a5,1d7a <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1ec8:	479d                	li	a5,7
    1eca:	02c7ff63          	bgeu	a5,a2,1f08 <stpncpy+0x1c0>
    1ece:	00000897          	auipc	a7,0x0
    1ed2:	5628b883          	ld	a7,1378(a7) # 2430 <sharedmem+0x240>
    1ed6:	00000817          	auipc	a6,0x0
    1eda:	56283803          	ld	a6,1378(a6) # 2438 <sharedmem+0x248>
    1ede:	431d                	li	t1,7
    1ee0:	6198                	ld	a4,0(a1)
    1ee2:	011707b3          	add	a5,a4,a7
    1ee6:	fff74693          	not	a3,a4
    1eea:	8ff5                	and	a5,a5,a3
    1eec:	0107f7b3          	and	a5,a5,a6
    1ef0:	ef81                	bnez	a5,1f08 <stpncpy+0x1c0>
            *wd = *ws;
    1ef2:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1ef4:	1661                	addi	a2,a2,-8
    1ef6:	05a1                	addi	a1,a1,8
    1ef8:	0521                	addi	a0,a0,8
    1efa:	fec363e3          	bltu	t1,a2,1ee0 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1efe:	e609                	bnez	a2,1f08 <stpncpy+0x1c0>
    1f00:	a08d                	j	1f62 <stpncpy+0x21a>
    1f02:	167d                	addi	a2,a2,-1
    1f04:	0505                	addi	a0,a0,1
    1f06:	ca01                	beqz	a2,1f16 <stpncpy+0x1ce>
    1f08:	0005c783          	lbu	a5,0(a1)
    1f0c:	0585                	addi	a1,a1,1
    1f0e:	00f50023          	sb	a5,0(a0)
    1f12:	fbe5                	bnez	a5,1f02 <stpncpy+0x1ba>
        ;
tail:
    1f14:	b59d                	j	1d7a <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1f16:	8082                	ret
    1f18:	472d                	li	a4,11
    1f1a:	bdb5                	j	1d96 <stpncpy+0x4e>
    1f1c:	00778713          	addi	a4,a5,7
    1f20:	45ad                	li	a1,11
    1f22:	fff60693          	addi	a3,a2,-1
    1f26:	e6b778e3          	bgeu	a4,a1,1d96 <stpncpy+0x4e>
    1f2a:	b7fd                	j	1f18 <stpncpy+0x1d0>
    1f2c:	40a007b3          	neg	a5,a0
    1f30:	8832                	mv	a6,a2
    1f32:	8b9d                	andi	a5,a5,7
    1f34:	4681                	li	a3,0
    1f36:	e4060be3          	beqz	a2,1d8c <stpncpy+0x44>
    1f3a:	b7cd                	j	1f1c <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1f3c:	468d                	li	a3,3
    1f3e:	bd75                	j	1dfa <stpncpy+0xb2>
    1f40:	872a                	mv	a4,a0
    1f42:	4681                	li	a3,0
    1f44:	bd5d                	j	1dfa <stpncpy+0xb2>
    1f46:	4685                	li	a3,1
    1f48:	bd4d                	j	1dfa <stpncpy+0xb2>
    1f4a:	8082                	ret
    1f4c:	87aa                	mv	a5,a0
    1f4e:	4681                	li	a3,0
    1f50:	b5f9                	j	1e1e <stpncpy+0xd6>
    1f52:	4689                	li	a3,2
    1f54:	b55d                	j	1dfa <stpncpy+0xb2>
    1f56:	4691                	li	a3,4
    1f58:	b54d                	j	1dfa <stpncpy+0xb2>
    1f5a:	4695                	li	a3,5
    1f5c:	bd79                	j	1dfa <stpncpy+0xb2>
    1f5e:	4699                	li	a3,6
    1f60:	bd69                	j	1dfa <stpncpy+0xb2>
    1f62:	8082                	ret
    1f64:	8082                	ret
    1f66:	8082                	ret

0000000000001f68 <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1f68:	fff6071b          	addiw	a4,a2,-1
    1f6c:	0cb57063          	bgeu	a0,a1,202c <memmove+0xc4>
        while (n-- > 0)
    1f70:	0ec05063          	blez	a2,2050 <memmove+0xe8>
    1f74:	00750693          	addi	a3,a0,7
    1f78:	8e8d                	sub	a3,a3,a1
    1f7a:	00b567b3          	or	a5,a0,a1
    1f7e:	00f6b693          	sltiu	a3,a3,15
    1f82:	8b9d                	andi	a5,a5,7
    1f84:	0016c693          	xori	a3,a3,1
    1f88:	0017b793          	seqz	a5,a5
    1f8c:	8ff5                	and	a5,a5,a3
    1f8e:	c3f1                	beqz	a5,2052 <memmove+0xea>
    1f90:	0007079b          	sext.w	a5,a4
    1f94:	46a5                	li	a3,9
    1f96:	0af6fe63          	bgeu	a3,a5,2052 <memmove+0xea>
    1f9a:	0036589b          	srliw	a7,a2,0x3
    1f9e:	088e                	slli	a7,a7,0x3
    1fa0:	2601                	sext.w	a2,a2
    1fa2:	87ae                	mv	a5,a1
    1fa4:	86aa                	mv	a3,a0
    1fa6:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1fa8:	0007b803          	ld	a6,0(a5)
    1fac:	07a1                	addi	a5,a5,8
    1fae:	06a1                	addi	a3,a3,8
    1fb0:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1fb4:	ff179ae3          	bne	a5,a7,1fa8 <memmove+0x40>
    1fb8:	ff867813          	andi	a6,a2,-8
    1fbc:	02081793          	slli	a5,a6,0x20
    1fc0:	9381                	srli	a5,a5,0x20
    1fc2:	00f506b3          	add	a3,a0,a5
    1fc6:	95be                	add	a1,a1,a5
    1fc8:	4107073b          	subw	a4,a4,a6
    1fcc:	09060263          	beq	a2,a6,2050 <memmove+0xe8>
            *dst++ = *src++;
    1fd0:	0005c783          	lbu	a5,0(a1)
    1fd4:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1fd8:	06e05c63          	blez	a4,2050 <memmove+0xe8>
            *dst++ = *src++;
    1fdc:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1fe0:	4785                	li	a5,1
            *dst++ = *src++;
    1fe2:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1fe6:	06e7d563          	bge	a5,a4,2050 <memmove+0xe8>
            *dst++ = *src++;
    1fea:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1fee:	4789                	li	a5,2
            *dst++ = *src++;
    1ff0:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1ff4:	04e7de63          	bge	a5,a4,2050 <memmove+0xe8>
            *dst++ = *src++;
    1ff8:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1ffc:	478d                	li	a5,3
            *dst++ = *src++;
    1ffe:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    2002:	04e7d763          	bge	a5,a4,2050 <memmove+0xe8>
            *dst++ = *src++;
    2006:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    200a:	4791                	li	a5,4
            *dst++ = *src++;
    200c:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    2010:	04e7d063          	bge	a5,a4,2050 <memmove+0xe8>
            *dst++ = *src++;
    2014:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    2018:	4795                	li	a5,5
            *dst++ = *src++;
    201a:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    201e:	02e7d963          	bge	a5,a4,2050 <memmove+0xe8>
            *dst++ = *src++;
    2022:	0065c783          	lbu	a5,6(a1)
    2026:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    202a:	8082                	ret
    } else {
        dst += n;
    202c:	00c507b3          	add	a5,a0,a2
        src += n;
    2030:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    2032:	00c05f63          	blez	a2,2050 <memmove+0xe8>
    2036:	1702                	slli	a4,a4,0x20
    2038:	9301                	srli	a4,a4,0x20
    203a:	fff74713          	not	a4,a4
    203e:	973e                	add	a4,a4,a5
            *--dst = *--src;
    2040:	fff5c683          	lbu	a3,-1(a1)
    2044:	17fd                	addi	a5,a5,-1
    2046:	15fd                	addi	a1,a1,-1
    2048:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    204c:	fee79ae3          	bne	a5,a4,2040 <memmove+0xd8>
    }
    return vdst;
}
    2050:	8082                	ret
    2052:	02071693          	slli	a3,a4,0x20
    2056:	9281                	srli	a3,a3,0x20
    2058:	0685                	addi	a3,a3,1
    205a:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    205c:	87aa                	mv	a5,a0
            *dst++ = *src++;
    205e:	0005c703          	lbu	a4,0(a1)
    2062:	0585                	addi	a1,a1,1
    2064:	0785                	addi	a5,a5,1
    2066:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    206a:	fed59ae3          	bne	a1,a3,205e <memmove+0xf6>
    206e:	8082                	ret

0000000000002070 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    2070:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2074:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    2078:	2501                	sext.w	a0,a0
    207a:	8082                	ret

000000000000207c <exec>:
    register long a7 __asm__("a7") = n;
    207c:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    2080:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2082:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    2086:	2501                	sext.w	a0,a0
    2088:	8082                	ret

000000000000208a <exit>:
    register long a7 __asm__("a7") = n;
    208a:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    208e:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    2092:	8082                	ret

0000000000002094 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    2094:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    2098:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    209c:	8082                	ret

000000000000209e <write>:
    register long a7 __asm__("a7") = n;
    209e:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    20a2:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    20a6:	8082                	ret

00000000000020a8 <getpid>:
    register long a7 __asm__("a7") = n;
    20a8:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    20ac:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    20b0:	2501                	sext.w	a0,a0
    20b2:	8082                	ret

00000000000020b4 <getppid>:
    register long a7 __asm__("a7") = n;
    20b4:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    20b8:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    20bc:	2501                	sext.w	a0,a0
    20be:	8082                	ret

00000000000020c0 <open>:
    register long a7 __asm__("a7") = n;
    20c0:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    20c4:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    20c8:	2501                	sext.w	a0,a0
    20ca:	8082                	ret

00000000000020cc <mknod>:
    register long a7 __asm__("a7") = n;
    20cc:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    20d0:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    20d4:	2501                	sext.w	a0,a0
    20d6:	8082                	ret

00000000000020d8 <dup>:
    register long a7 __asm__("a7") = n;
    20d8:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    20da:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    20de:	2501                	sext.w	a0,a0
    20e0:	8082                	ret

00000000000020e2 <sched_yield>:
    register long a7 __asm__("a7") = n;
    20e2:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    20e6:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    20ea:	2501                	sext.w	a0,a0
    20ec:	8082                	ret

00000000000020ee <waitpid>:
    register long a7 __asm__("a7") = n;
    20ee:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    20f2:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    20f6:	2501                	sext.w	a0,a0
    20f8:	8082                	ret

00000000000020fa <wait>:

pid_t wait(int *wstatus)
{
    20fa:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    20fc:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    2100:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2102:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    2106:	2501                	sext.w	a0,a0
    2108:	8082                	ret

000000000000210a <mkdir>:
    register long a7 __asm__("a7") = n;
    210a:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    210e:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    2112:	2501                	sext.w	a0,a0
    2114:	8082                	ret

0000000000002116 <close>:
    register long a7 __asm__("a7") = n;
    2116:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    211a:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    211e:	2501                	sext.w	a0,a0
    2120:	8082                	ret

0000000000002122 <fork>:
    register long a7 __asm__("a7") = n;
    2122:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    2126:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    212a:	2501                	sext.w	a0,a0
    212c:	8082                	ret

000000000000212e <time_ms>:
    register long a7 __asm__("a7") = n;
    212e:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    2132:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    2136:	8082                	ret

0000000000002138 <sleep>:

int sleep(unsigned long long time_in_ms)
{
    2138:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    213a:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    213e:	00000073          	ecall
    2142:	87aa                	mv	a5,a0
    2144:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    2148:	97ba                	add	a5,a5,a4
    214a:	00f57c63          	bgeu	a0,a5,2162 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    214e:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    2152:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    2156:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    215a:	00000073          	ecall
    215e:	fef568e3          	bltu	a0,a5,214e <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    2162:	4501                	li	a0,0
    2164:	8082                	ret

0000000000002166 <pipe>:
    register long a7 __asm__("a7") = n;
    2166:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    216a:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    216e:	2501                	sext.w	a0,a0
    2170:	8082                	ret

0000000000002172 <fstat>:
    register long a7 __asm__("a7") = n;
    2172:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2176:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    217a:	2501                	sext.w	a0,a0
    217c:	8082                	ret

000000000000217e <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    217e:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    2180:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    2184:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2186:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    218a:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    218e:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    2192:	0206c163          	bltz	a3,21b4 <stat+0x36>
    register long a7 __asm__("a7") = n;
    2196:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    219a:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    219c:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    219e:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    21a2:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    21a6:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    21aa:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    21ac:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    21b0:	853e                	mv	a0,a5
    21b2:	8082                	ret
        return -1;
    21b4:	57fd                	li	a5,-1
    21b6:	bfed                	j	21b0 <stat+0x32>

00000000000021b8 <chdir>:
    register long a7 __asm__("a7") = n;
    21b8:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    21bc:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    21c0:	2501                	sext.w	a0,a0
    21c2:	8082                	ret

00000000000021c4 <link>:
    register long a7 __asm__("a7") = n;
    21c4:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    21c8:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    21cc:	2501                	sext.w	a0,a0
    21ce:	8082                	ret

00000000000021d0 <unlink>:
    register long a7 __asm__("a7") = n;
    21d0:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    21d4:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    21d8:	2501                	sext.w	a0,a0
    21da:	8082                	ret

00000000000021dc <setpriority>:
    register long a7 __asm__("a7") = n;
    21dc:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    21e0:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    21e4:	8082                	ret

00000000000021e6 <getpriority>:
    register long a7 __asm__("a7") = n;
    21e6:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    21ea:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    21ee:	8082                	ret

00000000000021f0 <sharedmem>:
    register long a7 __asm__("a7") = n;
    21f0:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    21f4:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    21f8:	8082                	ret
