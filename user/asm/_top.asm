
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_top:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	ab19                	j	1516 <__start_main>

Disassembly of section .text:

0000000000001002 <main>:
int NCPU = 4;

char bigdata[1024 * 200]; // 200K

int main(int argc, char *argv[])
{
    1002:	9d010113          	addi	sp,sp,-1584
    struct cpu_stat stat_buf[8];
    struct mem_stat mstat;
    struct proc_stat pstat[20];
    int fd = open("cpu", O_RDWR);
    1006:	4589                	li	a1,2
    1008:	00001517          	auipc	a0,0x1
    100c:	25850513          	addi	a0,a0,600 # 2260 <sharedmem+0xe>
{
    1010:	62113423          	sd	ra,1576(sp)
    1014:	62813023          	sd	s0,1568(sp)
    1018:	60913c23          	sd	s1,1560(sp)
    101c:	61213823          	sd	s2,1552(sp)
    1020:	5f813023          	sd	s8,1504(sp)
    1024:	61313423          	sd	s3,1544(sp)
    1028:	61413023          	sd	s4,1536(sp)
    102c:	5f513c23          	sd	s5,1528(sp)
    1030:	5f613823          	sd	s6,1520(sp)
    1034:	5f713423          	sd	s7,1512(sp)
    1038:	5d913c23          	sd	s9,1496(sp)
    103c:	5da13823          	sd	s10,1488(sp)
    1040:	5db13423          	sd	s11,1480(sp)
    int fd = open("cpu", O_RDWR);
    1044:	0de010ef          	jal	ra,2122 <open>
    1048:	87aa                	mv	a5,a0
    int fd_mem = open("mem", O_RDWR);
    104a:	4589                	li	a1,2
    104c:	00001517          	auipc	a0,0x1
    1050:	21c50513          	addi	a0,a0,540 # 2268 <sharedmem+0x16>
    int fd = open("cpu", O_RDWR);
    1054:	843e                	mv	s0,a5
    1056:	ec3e                	sd	a5,24(sp)
    int fd_mem = open("mem", O_RDWR);
    1058:	0ca010ef          	jal	ra,2122 <open>
    105c:	87aa                	mv	a5,a0
    int fd_proc = open("proc", O_RDWR);
    105e:	4589                	li	a1,2
    1060:	00001517          	auipc	a0,0x1
    1064:	21050513          	addi	a0,a0,528 # 2270 <sharedmem+0x1e>
    int fd_mem = open("mem", O_RDWR);
    1068:	f03e                	sd	a5,32(sp)
    int fd_proc = open("proc", O_RDWR);
    106a:	0b8010ef          	jal	ra,2122 <open>
    106e:	87aa                	mv	a5,a0
    assert(fd >= 0, -1);
    1070:	fff44513          	not	a0,s0
    1074:	55fd                	li	a1,-1
    1076:	01f5551b          	srliw	a0,a0,0x1f
    int fd_proc = open("proc", O_RDWR);
    107a:	f43e                	sd	a5,40(sp)
    assert(fd >= 0, -1);
    107c:	0c3000ef          	jal	ra,193e <assert>

    int bytes = read(fd, stat_buf, sizeof(stat_buf));
    1080:	0c000613          	li	a2,192
    1084:	110c                	addi	a1,sp,160
    1086:	8522                	mv	a0,s0
    1088:	06e010ef          	jal	ra,20f6 <read>
    108c:	0005041b          	sext.w	s0,a0
    printf("cpu_device bytes read %d\n", bytes);
    1090:	85a2                	mv	a1,s0
    1092:	00001517          	auipc	a0,0x1
    1096:	1e650513          	addi	a0,a0,486 # 2278 <sharedmem+0x26>
    109a:	512000ef          	jal	ra,15ac <printf>

    assert(bytes == sizeof(struct cpu_stat) * NCPU, -2); // only four
    109e:	00033c17          	auipc	s8,0x33
    10a2:	4c6c0c13          	addi	s8,s8,1222 # 34564 <NCPU>
    10a6:	000c2783          	lw	a5,0(s8)
    10aa:	55f9                	li	a1,-2
    int pid;
    int runtime[] = {30,28,26,24,22,20,18,
    16,14,12,10,8,6,4,2};
    char name[] = {'n','a','m','e','0','0','\0'};
    int child_id;
    for (int i = 0; i < 15; i++)
    10ac:	4481                	li	s1,0
    assert(bytes == sizeof(struct cpu_stat) * NCPU, -2); // only four
    10ae:	00179513          	slli	a0,a5,0x1
    10b2:	953e                	add	a0,a0,a5
    10b4:	050e                	slli	a0,a0,0x3
    10b6:	8d01                	sub	a0,a0,s0
    10b8:	00153513          	seqz	a0,a0
    10bc:	083000ef          	jal	ra,193e <assert>
    int runtime[] = {30,28,26,24,22,20,18,
    10c0:	00033797          	auipc	a5,0x33
    10c4:	3f878793          	addi	a5,a5,1016 # 344b8 <bigdata+0x32000>
    10c8:	0007b883          	ld	a7,0(a5)
    10cc:	0087b803          	ld	a6,8(a5)
    10d0:	6b88                	ld	a0,16(a5)
    10d2:	6f8c                	ld	a1,24(a5)
    10d4:	7390                	ld	a2,32(a5)
    10d6:	7794                	ld	a3,40(a5)
    10d8:	7b98                	ld	a4,48(a5)
    10da:	5f9c                	lw	a5,56(a5)
    10dc:	f0c6                	sd	a7,96(sp)
    10de:	f4c2                	sd	a6,104(sp)
    10e0:	cd3e                	sw	a5,152(sp)
    char name[] = {'n','a','m','e','0','0','\0'};
    10e2:	656d67b7          	lui	a5,0x656d6
    10e6:	16e7879b          	addiw	a5,a5,366
    10ea:	c4be                	sw	a5,72(sp)
    10ec:	678d                	lui	a5,0x3
    10ee:	0307879b          	addiw	a5,a5,48
    int runtime[] = {30,28,26,24,22,20,18,
    10f2:	f8aa                	sd	a0,112(sp)
    10f4:	fcae                	sd	a1,120(sp)
    10f6:	e132                	sd	a2,128(sp)
    10f8:	e536                	sd	a3,136(sp)
    10fa:	e93a                	sd	a4,144(sp)
    char name[] = {'n','a','m','e','0','0','\0'};
    10fc:	04f11623          	sh	a5,76(sp)
    1100:	04010723          	sb	zero,78(sp)
    for (int i = 0; i < 15; i++)
    1104:	493d                	li	s2,15
    {
        pid = fork();
    1106:	07e010ef          	jal	ra,2184 <fork>
        if (pid == 0)
    110a:	8426                	mv	s0,s1
    110c:	2485                	addiw	s1,s1,1
    110e:	30050263          	beqz	a0,1412 <main+0x410>
    for (int i = 0; i < 15; i++)
    1112:	ff249ae3          	bne	s1,s2,1106 <main+0x104>
            }
        }
    }
    else
    {
        uint64 start_time = time_ms();
    1116:	07a010ef          	jal	ra,2190 <time_ms>
        // parent
        while (1)
        {
            sleep(1000);
            uint64 time_sec = (time_ms() - start_time) / 1000;
            if (time_sec > 40)
    111a:	67a9                	lui	a5,0xa
    111c:	02778793          	addi	a5,a5,39 # a027 <bigdata+0x7b6f>
        uint64 start_time = time_ms();
    1120:	f82a                	sd	a0,48(sp)
            if (time_sec > 40)
    1122:	fc3e                	sd	a5,56(sp)
            printf("----------------------------------------------------------------------\n\n");

            for (int i = 0; i < NCPU; i++)
            {

                printf("Core    %d\n", i);
    1124:	00001d97          	auipc	s11,0x1
    1128:	29cd8d93          	addi	s11,s11,668 # 23c0 <sharedmem+0x16e>
                // printf("busy cycle:    %l\n", stat_buf[i].sample_busy_duration);
                // printf("all cycle:     %l\n", stat_buf[i].sample_duration);
                // printf("uptime cycle:  %l\n", stat_buf[i].uptime);
                int per = (100 * stat_buf[i].sample_busy_duration) / stat_buf[i].sample_duration;
                printf("[\x1b[31m");
    112c:	00001c97          	auipc	s9,0x1
    1130:	28cc8c93          	addi	s9,s9,652 # 23b8 <sharedmem+0x166>
                {
                    printf("|");
                }
                for (; i < 50; i++)
                {
                    printf(" ");
    1134:	00001a17          	auipc	s4,0x1
    1138:	2b4a0a13          	addi	s4,s4,692 # 23e8 <sharedmem+0x196>
                    printf("|");
    113c:	00001997          	auipc	s3,0x1
    1140:	29498993          	addi	s3,s3,660 # 23d0 <sharedmem+0x17e>
            sleep(1000);
    1144:	3e800513          	li	a0,1000
    1148:	052010ef          	jal	ra,219a <sleep>
            uint64 time_sec = (time_ms() - start_time) / 1000;
    114c:	044010ef          	jal	ra,2190 <time_ms>
    1150:	77c2                	ld	a5,48(sp)
            if (time_sec > 40)
    1152:	7762                	ld	a4,56(sp)
            uint64 time_sec = (time_ms() - start_time) / 1000;
    1154:	3e800413          	li	s0,1000
    1158:	40f507b3          	sub	a5,a0,a5
    115c:	0287d433          	divu	s0,a5,s0
            if (time_sec > 40)
    1160:	34f76b63          	bltu	a4,a5,14b6 <main+0x4b4>
            bytes = read(fd, stat_buf, sizeof(stat_buf));
    1164:	6562                	ld	a0,24(sp)
    1166:	0c000613          	li	a2,192
    116a:	110c                	addi	a1,sp,160
    116c:	78b000ef          	jal	ra,20f6 <read>
    1170:	892a                	mv	s2,a0
            int bytes_mem = read(fd_mem, &mstat, sizeof(mstat));
    1172:	7502                	ld	a0,32(sp)
    1174:	4641                	li	a2,16
    1176:	088c                	addi	a1,sp,80
    1178:	77f000ef          	jal	ra,20f6 <read>
    117c:	84aa                	mv	s1,a0
            int bytes_proc = read(fd_proc, &pstat, sizeof(pstat));
    117e:	7522                	ld	a0,40(sp)
    1180:	46000613          	li	a2,1120
    1184:	128c                	addi	a1,sp,352
    1186:	771000ef          	jal	ra,20f6 <read>
            assert(bytes == sizeof(struct cpu_stat) * NCPU, -6); // only four
    118a:	000c2703          	lw	a4,0(s8)
            int p_cnt = bytes_proc / sizeof(struct proc_stat);
    118e:	0005079b          	sext.w	a5,a0
            assert(bytes == sizeof(struct cpu_stat) * NCPU, -6); // only four
    1192:	2901                	sext.w	s2,s2
    1194:	00171513          	slli	a0,a4,0x1
    1198:	953a                	add	a0,a0,a4
    119a:	050e                	slli	a0,a0,0x3
            int p_cnt = bytes_proc / sizeof(struct proc_stat);
    119c:	03800713          	li	a4,56
            assert(bytes == sizeof(struct cpu_stat) * NCPU, -6); // only four
    11a0:	41250533          	sub	a0,a0,s2
    11a4:	55e9                	li	a1,-6
    11a6:	00153513          	seqz	a0,a0
    11aa:	0a010b93          	addi	s7,sp,160
            for (int i = 0; i < NCPU; i++)
    11ae:	4b01                	li	s6,0
                for (; i < 50; i++)
    11b0:	03200a93          	li	s5,50
            int p_cnt = bytes_proc / sizeof(struct proc_stat);
    11b4:	02e7d933          	divu	s2,a5,a4
    11b8:	e84a                	sd	s2,16(sp)
            assert(bytes == sizeof(struct cpu_stat) * NCPU, -6); // only four
    11ba:	784000ef          	jal	ra,193e <assert>
            assert(bytes_mem == sizeof(struct mem_stat), -8);    // only four
    11be:	0004851b          	sext.w	a0,s1
    11c2:	1541                	addi	a0,a0,-16
    11c4:	55e1                	li	a1,-8
    11c6:	00153513          	seqz	a0,a0
    11ca:	774000ef          	jal	ra,193e <assert>
            printf("\x1b[2J");                                   // clear
    11ce:	00001517          	auipc	a0,0x1
    11d2:	0ca50513          	addi	a0,a0,202 # 2298 <sharedmem+0x46>
    11d6:	3d6000ef          	jal	ra,15ac <printf>
            printf("----------------------------------------------------------------------\n");
    11da:	00001517          	auipc	a0,0x1
    11de:	0c650513          	addi	a0,a0,198 # 22a0 <sharedmem+0x4e>
    11e2:	3ca000ef          	jal	ra,15ac <printf>
            printf(" uCore-SMP Resource Monitor                            Time: %l s\n", time_sec);
    11e6:	85a2                	mv	a1,s0
    11e8:	00001517          	auipc	a0,0x1
    11ec:	10050513          	addi	a0,a0,256 # 22e8 <sharedmem+0x96>
    11f0:	3bc000ef          	jal	ra,15ac <printf>
            printf("----------------------------------------------------------------------\n\n");
    11f4:	00001517          	auipc	a0,0x1
    11f8:	13c50513          	addi	a0,a0,316 # 2330 <sharedmem+0xde>
    11fc:	3b0000ef          	jal	ra,15ac <printf>
            for (int i = 0; i < NCPU; i++)
    1200:	000c2783          	lw	a5,0(s8)
            int p_cnt = bytes_proc / sizeof(struct proc_stat);
    1204:	0009071b          	sext.w	a4,s2
    1208:	e43a                	sd	a4,8(sp)
            for (int i = 0; i < NCPU; i++)
    120a:	08f05563          	blez	a5,1294 <main+0x292>
                printf("Core    %d\n", i);
    120e:	85da                	mv	a1,s6
    1210:	856e                	mv	a0,s11
    1212:	39a000ef          	jal	ra,15ac <printf>
                int per = (100 * stat_buf[i].sample_busy_duration) / stat_buf[i].sample_duration;
    1216:	010bb483          	ld	s1,16(s7)
    121a:	06400713          	li	a4,100
    121e:	008bb783          	ld	a5,8(s7)
    1222:	029704b3          	mul	s1,a4,s1
                printf("[\x1b[31m");
    1226:	8566                	mv	a0,s9
                int per = (100 * stat_buf[i].sample_busy_duration) / stat_buf[i].sample_duration;
    1228:	02f4d4b3          	divu	s1,s1,a5
                printf("[\x1b[31m");
    122c:	380000ef          	jal	ra,15ac <printf>
                int per = (100 * stat_buf[i].sample_busy_duration) / stat_buf[i].sample_duration;
    1230:	2481                	sext.w	s1,s1
                int tens = (per + 1) / 2;
    1232:	0014879b          	addiw	a5,s1,1
    1236:	01f7d41b          	srliw	s0,a5,0x1f
    123a:	9c3d                	addw	s0,s0,a5
    123c:	4014591b          	sraiw	s2,s0,0x1
    1240:	844a                	mv	s0,s2
                for (i = 0; i < tens; i++)
    1242:	26905863          	blez	s1,14b2 <main+0x4b0>
    1246:	4d01                	li	s10,0
    1248:	2d05                	addiw	s10,s10,1
                    printf("|");
    124a:	854e                	mv	a0,s3
    124c:	360000ef          	jal	ra,15ac <printf>
                for (i = 0; i < tens; i++)
    1250:	ff2d4ce3          	blt	s10,s2,1248 <main+0x246>
    1254:	01204363          	bgtz	s2,125a <main+0x258>
    1258:	4405                	li	s0,1
                for (; i < 50; i++)
    125a:	06200793          	li	a5,98
    125e:	0097c863          	blt	a5,s1,126e <main+0x26c>
    1262:	2405                	addiw	s0,s0,1
                    printf(" ");
    1264:	8552                	mv	a0,s4
    1266:	346000ef          	jal	ra,15ac <printf>
                for (; i < 50; i++)
    126a:	ff541ce3          	bne	s0,s5,1262 <main+0x260>
                }

                printf("\x1b[0m] %d%%\n", per);
    126e:	85a6                	mv	a1,s1
    1270:	00001517          	auipc	a0,0x1
    1274:	16850513          	addi	a0,a0,360 # 23d8 <sharedmem+0x186>
    1278:	334000ef          	jal	ra,15ac <printf>
                printf("\n");
    127c:	00001517          	auipc	a0,0x1
    1280:	01450513          	addi	a0,a0,20 # 2290 <sharedmem+0x3e>
    1284:	328000ef          	jal	ra,15ac <printf>
            for (int i = 0; i < NCPU; i++)
    1288:	000c2783          	lw	a5,0(s8)
    128c:	2b05                	addiw	s6,s6,1
    128e:	0be1                	addi	s7,s7,24
    1290:	f6fb4fe3          	blt	s6,a5,120e <main+0x20c>
            }

            printf("Memory\n");
    1294:	00001517          	auipc	a0,0x1
    1298:	0ec50513          	addi	a0,a0,236 # 2380 <sharedmem+0x12e>
    129c:	310000ef          	jal	ra,15ac <printf>
            printf("Total :   %l MB\n", mstat.physical_total / 1024 / 1024);
    12a0:	65c6                	ld	a1,80(sp)
    12a2:	00001517          	auipc	a0,0x1
    12a6:	0e650513          	addi	a0,a0,230 # 2388 <sharedmem+0x136>
            uint64 used = mstat.physical_total - mstat.physical_free;
            int use_per = (used * 100) / mstat.physical_total;
            printf("[\x1b[31m");
            int tens = (use_per + 1) / 2;
            int i = 0;
            for (i = 0; i < tens; i++)
    12aa:	4a81                	li	s5,0
            printf("Total :   %l MB\n", mstat.physical_total / 1024 / 1024);
    12ac:	81d1                	srli	a1,a1,0x14
    12ae:	2fe000ef          	jal	ra,15ac <printf>
            printf("Free  :   %l MB\n", mstat.physical_free / 1024 / 1024);
    12b2:	65e6                	ld	a1,88(sp)
    12b4:	00001517          	auipc	a0,0x1
    12b8:	0ec50513          	addi	a0,a0,236 # 23a0 <sharedmem+0x14e>
    12bc:	81d1                	srli	a1,a1,0x14
    12be:	2ee000ef          	jal	ra,15ac <printf>
            uint64 used = mstat.physical_total - mstat.physical_free;
    12c2:	67c6                	ld	a5,80(sp)
    12c4:	64e6                	ld	s1,88(sp)
            int use_per = (used * 100) / mstat.physical_total;
    12c6:	06400713          	li	a4,100
            printf("[\x1b[31m");
    12ca:	8566                	mv	a0,s9
            uint64 used = mstat.physical_total - mstat.physical_free;
    12cc:	409784b3          	sub	s1,a5,s1
            int use_per = (used * 100) / mstat.physical_total;
    12d0:	02e484b3          	mul	s1,s1,a4
    12d4:	02f4d4b3          	divu	s1,s1,a5
            printf("[\x1b[31m");
    12d8:	2d4000ef          	jal	ra,15ac <printf>
            int use_per = (used * 100) / mstat.physical_total;
    12dc:	2481                	sext.w	s1,s1
            int tens = (use_per + 1) / 2;
    12de:	0014879b          	addiw	a5,s1,1
    12e2:	01f7d41b          	srliw	s0,a5,0x1f
    12e6:	9c3d                	addw	s0,s0,a5
    12e8:	4014591b          	sraiw	s2,s0,0x1
    12ec:	844a                	mv	s0,s2
            for (i = 0; i < tens; i++)
    12ee:	1c905f63          	blez	s1,14cc <main+0x4ca>
    12f2:	2a85                	addiw	s5,s5,1
            {
                printf("|");
    12f4:	854e                	mv	a0,s3
    12f6:	2b6000ef          	jal	ra,15ac <printf>
            for (i = 0; i < tens; i++)
    12fa:	ff2acce3          	blt	s5,s2,12f2 <main+0x2f0>
    12fe:	01204363          	bgtz	s2,1304 <main+0x302>
    1302:	4405                	li	s0,1
            }
            for (; i < 50; i++)
    1304:	06200793          	li	a5,98
    1308:	0004091b          	sext.w	s2,s0
    130c:	0097ca63          	blt	a5,s1,1320 <main+0x31e>
    1310:	03200413          	li	s0,50
    1314:	2905                	addiw	s2,s2,1
            {
                printf(" ");
    1316:	8552                	mv	a0,s4
    1318:	294000ef          	jal	ra,15ac <printf>
            for (; i < 50; i++)
    131c:	fe891ce3          	bne	s2,s0,1314 <main+0x312>
            }

            printf("\x1b[0m] %d%%\n", use_per);
    1320:	85a6                	mv	a1,s1
    1322:	00001517          	auipc	a0,0x1
    1326:	0b650513          	addi	a0,a0,182 # 23d8 <sharedmem+0x186>
    132a:	282000ef          	jal	ra,15ac <printf>
            printf("\n");
    132e:	00001517          	auipc	a0,0x1
    1332:	f6250513          	addi	a0,a0,-158 # 2290 <sharedmem+0x3e>
    1336:	276000ef          	jal	ra,15ac <printf>
            printf("----------------------------------------------------------------------\n");
    133a:	00001517          	auipc	a0,0x1
    133e:	f6650513          	addi	a0,a0,-154 # 22a0 <sharedmem+0x4e>
    1342:	26a000ef          	jal	ra,15ac <printf>
            printf("Process | pid | ppid | heap | mem | cpu time\n", p_cnt);
    1346:	6422                	ld	s0,8(sp)
    1348:	00001517          	auipc	a0,0x1
    134c:	0a850513          	addi	a0,a0,168 # 23f0 <sharedmem+0x19e>
    1350:	85a2                	mv	a1,s0
    1352:	25a000ef          	jal	ra,15ac <printf>
            if (p_cnt > 0)
    1356:	0a805763          	blez	s0,1404 <main+0x402>
    135a:	67c2                	ld	a5,16(sp)
    135c:	1280                	addi	s0,sp,352
            {

                for (int i = 0; i < p_cnt; i++)
                {
                    if (pstat[i].state == ZOMBIE){
    135e:	4a95                	li	s5,5
    1360:	37fd                	addiw	a5,a5,-1
    1362:	1782                	slli	a5,a5,0x20
    1364:	9381                	srli	a5,a5,0x20
    1366:	00379b13          	slli	s6,a5,0x3
    136a:	40fb0b33          	sub	s6,s6,a5
    136e:	0b0e                	slli	s6,s6,0x3
    1370:	0b3c                	addi	a5,sp,408
    1372:	9b3e                	add	s6,s6,a5
                        continue;
                    }
                    printf("%s   ", pstat[i].name);
                    printf("%d   ", pstat[i].pid);
    1374:	00001917          	auipc	s2,0x1
    1378:	0b490913          	addi	s2,s2,180 # 2428 <sharedmem+0x1d6>
                    printf("%d   ", pstat[i].ppid);
                    printf("%l   ", pstat[i].heap_sz);
    137c:	00001497          	auipc	s1,0x1
    1380:	0b448493          	addi	s1,s1,180 # 2430 <sharedmem+0x1de>
                    }
                    else
                    {
                        printf("UNKNOWN");
                    }
                    printf("\n");
    1384:	00001b97          	auipc	s7,0x1
    1388:	f0cb8b93          	addi	s7,s7,-244 # 2290 <sharedmem+0x3e>
                    else if (pstat[i].state == USED)
    138c:	4d05                	li	s10,1
                    if (pstat[i].state == ZOMBIE){
    138e:	4c1c                	lw	a5,24(s0)
    1390:	07578663          	beq	a5,s5,13fc <main+0x3fa>
                    printf("%s   ", pstat[i].name);
    1394:	85a2                	mv	a1,s0
    1396:	00001517          	auipc	a0,0x1
    139a:	08a50513          	addi	a0,a0,138 # 2420 <sharedmem+0x1ce>
    139e:	20e000ef          	jal	ra,15ac <printf>
                    printf("%d   ", pstat[i].pid);
    13a2:	480c                	lw	a1,16(s0)
    13a4:	854a                	mv	a0,s2
    13a6:	206000ef          	jal	ra,15ac <printf>
                    printf("%d   ", pstat[i].ppid);
    13aa:	484c                	lw	a1,20(s0)
    13ac:	854a                	mv	a0,s2
    13ae:	1fe000ef          	jal	ra,15ac <printf>
                    printf("%l   ", pstat[i].heap_sz);
    13b2:	700c                	ld	a1,32(s0)
    13b4:	8526                	mv	a0,s1
    13b6:	1f6000ef          	jal	ra,15ac <printf>
                    printf("%l   ", pstat[i].total_size);
    13ba:	740c                	ld	a1,40(s0)
    13bc:	8526                	mv	a0,s1
    13be:	1ee000ef          	jal	ra,15ac <printf>
                    printf("%l   ", pstat[i].cpu_time);
    13c2:	780c                	ld	a1,48(s0)
    13c4:	8526                	mv	a0,s1
    13c6:	1e6000ef          	jal	ra,15ac <printf>
                    if (pstat[i].state == UNUSED)
    13ca:	4c1c                	lw	a5,24(s0)
    13cc:	0e078963          	beqz	a5,14be <main+0x4bc>
                    else if (pstat[i].state == USED)
    13d0:	11a78063          	beq	a5,s10,14d0 <main+0x4ce>
                    else if (pstat[i].state == SLEEPING)
    13d4:	4709                	li	a4,2
    13d6:	10e78463          	beq	a5,a4,14de <main+0x4dc>
                    else if (pstat[i].state == RUNNING)
    13da:	4711                	li	a4,4
    13dc:	10e78863          	beq	a5,a4,14ec <main+0x4ea>
                    else if (pstat[i].state == ZOMBIE)
    13e0:	13578463          	beq	a5,s5,1508 <main+0x506>
                    else if (pstat[i].state == RUNNABLE)
    13e4:	470d                	li	a4,3
    13e6:	10e78a63          	beq	a5,a4,14fa <main+0x4f8>
                        printf("UNKNOWN");
    13ea:	00001517          	auipc	a0,0x1
    13ee:	08e50513          	addi	a0,a0,142 # 2478 <sharedmem+0x226>
    13f2:	1ba000ef          	jal	ra,15ac <printf>
                    printf("\n");
    13f6:	855e                	mv	a0,s7
    13f8:	1b4000ef          	jal	ra,15ac <printf>
                for (int i = 0; i < p_cnt; i++)
    13fc:	03840413          	addi	s0,s0,56
    1400:	f96417e3          	bne	s0,s6,138e <main+0x38c>
                }
            }
            printf("----------------------------------------------------------------------\n\n");
    1404:	00001517          	auipc	a0,0x1
    1408:	f2c50513          	addi	a0,a0,-212 # 2330 <sharedmem+0xde>
    140c:	1a0000ef          	jal	ra,15ac <printf>
        {
    1410:	bb15                	j	1144 <main+0x142>
            sleep(1000 * (i + 1));
    1412:	3e800513          	li	a0,1000
    1416:	0295053b          	mulw	a0,a0,s1
            name[4]+= i;
    141a:	04c14783          	lbu	a5,76(sp)
            sleep(1000 * (i + 1));
    141e:	06100493          	li	s1,97
        for (int i = 0; i < 20; i++)
    1422:	07500913          	li	s2,117
            name[4]+= i;
    1426:	9fa1                	addw	a5,a5,s0
    1428:	04f10623          	sb	a5,76(sp)
            sleep(1000 * (i + 1));
    142c:	56f000ef          	jal	ra,219a <sleep>
            shm= sharedmem(name, 1024*512);  // 512 KB
    1430:	000805b7          	lui	a1,0x80
    1434:	00a8                	addi	a0,sp,72
    1436:	61d000ef          	jal	ra,2252 <sharedmem>
    143a:	0014879b          	addiw	a5,s1,1
            name[5]='a'+i;  // different name
    143e:	049106a3          	sb	s1,77(sp)
    1442:	0ff7f493          	andi	s1,a5,255
        for (int i = 0; i < 20; i++)
    1446:	ff2495e3          	bne	s1,s2,1430 <main+0x42e>
        shm[10] = 2;
    144a:	4709                	li	a4,2
    144c:	d518                	sw	a4,40(a0)
        int t = time_ms();
    144e:	543000ef          	jal	ra,2190 <time_ms>
    1452:	040a                	slli	s0,s0,0x2
            if (t2 > runtime[child_id]*1000)
    1454:	5c010793          	addi	a5,sp,1472
    1458:	0005049b          	sext.w	s1,a0
    145c:	943e                	add	s0,s0,a5
    145e:	3e800913          	li	s2,1000
            t2 = time_ms() - t;
    1462:	52f000ef          	jal	ra,2190 <time_ms>
            if (t2 > runtime[child_id]*1000)
    1466:	aa042703          	lw	a4,-1376(s0)
            t2 = time_ms() - t;
    146a:	409507b3          	sub	a5,a0,s1
            if (t2 > runtime[child_id]*1000)
    146e:	02e9073b          	mulw	a4,s2,a4
    1472:	fef778e3          	bgeu	a4,a5,1462 <main+0x460>
        }
    }

    return 0;
    1476:	62813083          	ld	ra,1576(sp)
    147a:	62013403          	ld	s0,1568(sp)
    147e:	61813483          	ld	s1,1560(sp)
    1482:	61013903          	ld	s2,1552(sp)
    1486:	60813983          	ld	s3,1544(sp)
    148a:	60013a03          	ld	s4,1536(sp)
    148e:	5f813a83          	ld	s5,1528(sp)
    1492:	5f013b03          	ld	s6,1520(sp)
    1496:	5e813b83          	ld	s7,1512(sp)
    149a:	5e013c03          	ld	s8,1504(sp)
    149e:	5d813c83          	ld	s9,1496(sp)
    14a2:	5d013d03          	ld	s10,1488(sp)
    14a6:	5c813d83          	ld	s11,1480(sp)
    14aa:	4501                	li	a0,0
    14ac:	63010113          	addi	sp,sp,1584
    14b0:	8082                	ret
                for (i = 0; i < tens; i++)
    14b2:	4401                	li	s0,0
    14b4:	b37d                	j	1262 <main+0x260>
                exit(0);
    14b6:	4501                	li	a0,0
    14b8:	435000ef          	jal	ra,20ec <exit>
    14bc:	b165                	j	1164 <main+0x162>
                        printf("UNUSED");
    14be:	00001517          	auipc	a0,0x1
    14c2:	f7a50513          	addi	a0,a0,-134 # 2438 <sharedmem+0x1e6>
    14c6:	0e6000ef          	jal	ra,15ac <printf>
    14ca:	b735                	j	13f6 <main+0x3f4>
            for (i = 0; i < tens; i++)
    14cc:	4901                	li	s2,0
    14ce:	b589                	j	1310 <main+0x30e>
                        printf("USED");
    14d0:	00001517          	auipc	a0,0x1
    14d4:	f7050513          	addi	a0,a0,-144 # 2440 <sharedmem+0x1ee>
    14d8:	0d4000ef          	jal	ra,15ac <printf>
    14dc:	bf29                	j	13f6 <main+0x3f4>
                        printf("SLEEPING");
    14de:	00001517          	auipc	a0,0x1
    14e2:	f6a50513          	addi	a0,a0,-150 # 2448 <sharedmem+0x1f6>
    14e6:	0c6000ef          	jal	ra,15ac <printf>
    14ea:	b731                	j	13f6 <main+0x3f4>
                        printf("RUNNING");
    14ec:	00001517          	auipc	a0,0x1
    14f0:	f6c50513          	addi	a0,a0,-148 # 2458 <sharedmem+0x206>
    14f4:	0b8000ef          	jal	ra,15ac <printf>
    14f8:	bdfd                	j	13f6 <main+0x3f4>
                        printf("RUNNABLE");
    14fa:	00001517          	auipc	a0,0x1
    14fe:	f6e50513          	addi	a0,a0,-146 # 2468 <sharedmem+0x216>
    1502:	0aa000ef          	jal	ra,15ac <printf>
    1506:	bdc5                	j	13f6 <main+0x3f4>
                        printf("ZOMBIE");
    1508:	00001517          	auipc	a0,0x1
    150c:	f5850513          	addi	a0,a0,-168 # 2460 <sharedmem+0x20e>
    1510:	09c000ef          	jal	ra,15ac <printf>
    1514:	b5cd                	j	13f6 <main+0x3f4>

0000000000001516 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1516:	1141                	addi	sp,sp,-16
    1518:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    151a:	ae9ff0ef          	jal	ra,1002 <main>
}
    151e:	60a2                	ld	ra,8(sp)
    1520:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    1522:	3cb0006f          	j	20ec <exit>

0000000000001526 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    1526:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    1528:	00f10593          	addi	a1,sp,15
    152c:	4605                	li	a2,1
    152e:	4501                	li	a0,0
int getchar() {
    1530:	ec06                	sd	ra,24(sp)
    char byte = 0;
    1532:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    1536:	3c1000ef          	jal	ra,20f6 <read>
    return byte;
}
    153a:	60e2                	ld	ra,24(sp)
    153c:	00f14503          	lbu	a0,15(sp)
    1540:	6105                	addi	sp,sp,32
    1542:	8082                	ret

0000000000001544 <putchar>:

int putchar(int c)
{
    1544:	1141                	addi	sp,sp,-16
    1546:	e406                	sd	ra,8(sp)
    1548:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    154a:	00001597          	auipc	a1,0x1
    154e:	f5e58593          	addi	a1,a1,-162 # 24a8 <put.1156>
    return write(stdout, put, 1);
    1552:	4605                	li	a2,1
    1554:	4505                	li	a0,1
    put[0] = c;
    1556:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    155a:	3a7000ef          	jal	ra,2100 <write>
}
    155e:	60a2                	ld	ra,8(sp)
    1560:	2501                	sext.w	a0,a0
    1562:	0141                	addi	sp,sp,16
    1564:	8082                	ret

0000000000001566 <puts>:

int puts(const char* s)
{
    1566:	1141                	addi	sp,sp,-16
    1568:	e022                	sd	s0,0(sp)
    156a:	e406                	sd	ra,8(sp)
    156c:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    156e:	6b6000ef          	jal	ra,1c24 <strlen>
    1572:	862a                	mv	a2,a0
    1574:	85a2                	mv	a1,s0
    1576:	4505                	li	a0,1
    1578:	389000ef          	jal	ra,2100 <write>
    157c:	00055763          	bgez	a0,158a <puts+0x24>
    return r;
}
    1580:	60a2                	ld	ra,8(sp)
    1582:	6402                	ld	s0,0(sp)
    1584:	557d                	li	a0,-1
    1586:	0141                	addi	sp,sp,16
    1588:	8082                	ret
    put[0] = c;
    158a:	00001597          	auipc	a1,0x1
    158e:	f1e58593          	addi	a1,a1,-226 # 24a8 <put.1156>
    1592:	47a9                	li	a5,10
    return write(stdout, put, 1);
    1594:	4605                	li	a2,1
    1596:	4505                	li	a0,1
    put[0] = c;
    1598:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    159c:	365000ef          	jal	ra,2100 <write>
}
    15a0:	60a2                	ld	ra,8(sp)
    15a2:	6402                	ld	s0,0(sp)
    15a4:	41f5551b          	sraiw	a0,a0,0x1f
    15a8:	0141                	addi	sp,sp,16
    15aa:	8082                	ret

00000000000015ac <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    15ac:	7115                	addi	sp,sp,-224
    15ae:	ed06                	sd	ra,152(sp)
    15b0:	e922                	sd	s0,144(sp)
    15b2:	e526                	sd	s1,136(sp)
    15b4:	e14a                	sd	s2,128(sp)
    15b6:	fcce                	sd	s3,120(sp)
    15b8:	f8d2                	sd	s4,112(sp)
    15ba:	f4d6                	sd	s5,104(sp)
    15bc:	f0da                	sd	s6,96(sp)
    15be:	ecde                	sd	s7,88(sp)
    15c0:	e8e2                	sd	s8,80(sp)
    15c2:	e4e6                	sd	s9,72(sp)
    15c4:	e0ea                	sd	s10,64(sp)
    15c6:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    15c8:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    15cc:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    15ce:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    15d0:	f52e                	sd	a1,168(sp)
    15d2:	f932                	sd	a2,176(sp)
    15d4:	fd36                	sd	a3,184(sp)
    15d6:	e1ba                	sd	a4,192(sp)
    15d8:	e9c2                	sd	a6,208(sp)
    15da:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    15dc:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    15de:	0c030b63          	beqz	t1,16b4 <printf+0x108>
    15e2:	8aaa                	mv	s5,a0
    15e4:	0003071b          	sext.w	a4,t1
    15e8:	4481                	li	s1,0
        if (c != '%') {
    15ea:	02500b93          	li	s7,37
    put[0] = c;
    15ee:	00001417          	auipc	s0,0x1
    15f2:	eba40413          	addi	s0,s0,-326 # 24a8 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    15f6:	4c51                	li	s8,20
    put[0] = c;
    15f8:	02500c93          	li	s9,37
    15fc:	00033a17          	auipc	s4,0x33
    1600:	efca0a13          	addi	s4,s4,-260 # 344f8 <bigdata+0x32040>
    1604:	00033997          	auipc	s3,0x33
    1608:	f4c98993          	addi	s3,s3,-180 # 34550 <digits>
    160c:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    1610:	0014879b          	addiw	a5,s1,1
    1614:	00fa8933          	add	s2,s5,a5
    1618:	13771163          	bne	a4,s7,173a <printf+0x18e>
        c = fmt[++i] & 0xff;
    161c:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    1620:	080d0a63          	beqz	s10,16b4 <printf+0x108>
        switch (c) {
    1624:	2489                	addiw	s1,s1,2
    1626:	009a8933          	add	s2,s5,s1
    162a:	257d0e63          	beq	s10,s7,1886 <printf+0x2da>
    162e:	f9cd079b          	addiw	a5,s10,-100
    1632:	0ff7f793          	andi	a5,a5,255
    1636:	0cfc6263          	bltu	s8,a5,16fa <printf+0x14e>
    163a:	078a                	slli	a5,a5,0x2
    163c:	97d2                	add	a5,a5,s4
    163e:	439c                	lw	a5,0(a5)
    1640:	97d2                	add	a5,a5,s4
    1642:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    1644:	67a2                	ld	a5,8(sp)
    1646:	4398                	lw	a4,0(a5)
    1648:	07a1                	addi	a5,a5,8
    164a:	e43e                	sd	a5,8(sp)
    164c:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    1650:	26074663          	bltz	a4,18bc <printf+0x310>
        buf[i++] = digits[x % base];
    1654:	8bbd                	andi	a5,a5,15
    1656:	97ce                	add	a5,a5,s3
    1658:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    165c:	40475d1b          	sraiw	s10,a4,0x4
    1660:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    1664:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    1668:	020d0163          	beqz	s10,168a <printf+0xde>
        buf[i++] = digits[x % base];
    166c:	9d4e                	add	s10,s10,s3
    166e:	000d4783          	lbu	a5,0(s10)
    1672:	4d05                	li	s10,1
    1674:	00f108a3          	sb	a5,17(sp)
    if (sign)
    1678:	00075963          	bgez	a4,168a <printf+0xde>
        buf[i++] = digits[x % base];
    167c:	4d09                	li	s10,2
        buf[i++] = '-';
    167e:	181c                	addi	a5,sp,48
    1680:	02d00713          	li	a4,45
    1684:	97ea                	add	a5,a5,s10
    1686:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    168a:	9d5a                	add	s10,s10,s6
    168c:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1690:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1694:	4605                	li	a2,1
    1696:	1d7d                	addi	s10,s10,-1
    1698:	85a2                	mv	a1,s0
    169a:	4505                	li	a0,1
    put[0] = c;
    169c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    16a0:	261000ef          	jal	ra,2100 <write>
    while (--i >= 0)
    16a4:	ffbd16e3          	bne	s10,s11,1690 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    16a8:	00094303          	lbu	t1,0(s2)
    16ac:	0003071b          	sext.w	a4,t1
    16b0:	f60310e3          	bnez	t1,1610 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    16b4:	60ea                	ld	ra,152(sp)
    16b6:	644a                	ld	s0,144(sp)
    16b8:	64aa                	ld	s1,136(sp)
    16ba:	690a                	ld	s2,128(sp)
    16bc:	79e6                	ld	s3,120(sp)
    16be:	7a46                	ld	s4,112(sp)
    16c0:	7aa6                	ld	s5,104(sp)
    16c2:	7b06                	ld	s6,96(sp)
    16c4:	6be6                	ld	s7,88(sp)
    16c6:	6c46                	ld	s8,80(sp)
    16c8:	6ca6                	ld	s9,72(sp)
    16ca:	6d06                	ld	s10,64(sp)
    16cc:	7de2                	ld	s11,56(sp)
    16ce:	612d                	addi	sp,sp,224
    16d0:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    16d2:	67a2                	ld	a5,8(sp)
    16d4:	0007bd03          	ld	s10,0(a5)
    16d8:	07a1                	addi	a5,a5,8
    16da:	e43e                	sd	a5,8(sp)
    16dc:	000d1b63          	bnez	s10,16f2 <printf+0x146>
    16e0:	aafd                	j	18de <printf+0x332>
    return write(stdout, put, 1);
    16e2:	4605                	li	a2,1
    16e4:	85a2                	mv	a1,s0
    16e6:	4505                	li	a0,1
                for (; *s; s++)
    16e8:	0d05                	addi	s10,s10,1
    put[0] = c;
    16ea:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    16ee:	213000ef          	jal	ra,2100 <write>
                for (; *s; s++)
    16f2:	000d4783          	lbu	a5,0(s10)
    16f6:	f7f5                	bnez	a5,16e2 <printf+0x136>
    16f8:	a02d                	j	1722 <printf+0x176>
    return write(stdout, put, 1);
    16fa:	4605                	li	a2,1
    16fc:	00001597          	auipc	a1,0x1
    1700:	dac58593          	addi	a1,a1,-596 # 24a8 <put.1156>
    1704:	4505                	li	a0,1
    put[0] = c;
    1706:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    170a:	1f7000ef          	jal	ra,2100 <write>
    170e:	4605                	li	a2,1
    1710:	00001597          	auipc	a1,0x1
    1714:	d9858593          	addi	a1,a1,-616 # 24a8 <put.1156>
    1718:	4505                	li	a0,1
    put[0] = c;
    171a:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    171e:	1e3000ef          	jal	ra,2100 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1722:	00094303          	lbu	t1,0(s2)
    1726:	0003071b          	sext.w	a4,t1
    172a:	f80305e3          	beqz	t1,16b4 <printf+0x108>
        if (c != '%') {
    172e:	0014879b          	addiw	a5,s1,1
    1732:	00fa8933          	add	s2,s5,a5
    1736:	ef7703e3          	beq	a4,s7,161c <printf+0x70>
    return write(stdout, put, 1);
    173a:	4605                	li	a2,1
    173c:	00001597          	auipc	a1,0x1
    1740:	d6c58593          	addi	a1,a1,-660 # 24a8 <put.1156>
    1744:	4505                	li	a0,1
    put[0] = c;
    1746:	00640023          	sb	t1,0(s0)
            continue;
    174a:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    174c:	1b5000ef          	jal	ra,2100 <write>
            continue;
    1750:	bfc9                	j	1722 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    1752:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    1754:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    1756:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    1758:	0007b883          	ld	a7,0(a5)
    175c:	07a1                	addi	a5,a5,8
    175e:	e43e                	sd	a5,8(sp)
        x = -xx;
    1760:	43f8d713          	srai	a4,a7,0x3f
    1764:	011747b3          	xor	a5,a4,a7
    1768:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    176a:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    176c:	02c7f733          	remu	a4,a5,a2
    1770:	8d36                	mv	s10,a3
    1772:	0685                	addi	a3,a3,1
    1774:	00db0533          	add	a0,s6,a3
    1778:	85be                	mv	a1,a5
    177a:	974e                	add	a4,a4,s3
    177c:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    1780:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    1784:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    1788:	feb862e3          	bltu	a6,a1,176c <printf+0x1c0>
    if (sign)
    178c:	1208c063          	bltz	a7,18ac <printf+0x300>
    while (--i >= 0)
    1790:	9d5a                	add	s10,s10,s6
    put[0] = c;
    1792:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1796:	4605                	li	a2,1
    1798:	85a2                	mv	a1,s0
    179a:	4505                	li	a0,1
    put[0] = c;
    179c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    17a0:	161000ef          	jal	ra,2100 <write>
    while (--i >= 0)
    17a4:	87ea                	mv	a5,s10
    17a6:	1d7d                	addi	s10,s10,-1
    17a8:	fefb15e3          	bne	s6,a5,1792 <printf+0x1e6>
    17ac:	bf9d                	j	1722 <printf+0x176>
                printptr(va_arg(ap, uint64));
    17ae:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    17b0:	4605                	li	a2,1
    17b2:	00001597          	auipc	a1,0x1
    17b6:	cf658593          	addi	a1,a1,-778 # 24a8 <put.1156>
                printptr(va_arg(ap, uint64));
    17ba:	0007bd83          	ld	s11,0(a5)
    17be:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    17c2:	4505                	li	a0,1
    put[0] = c;
    17c4:	03000793          	li	a5,48
    17c8:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    17cc:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    17ce:	133000ef          	jal	ra,2100 <write>
    put[0] = c;
    17d2:	07800793          	li	a5,120
    return write(stdout, put, 1);
    17d6:	4605                	li	a2,1
    17d8:	00001597          	auipc	a1,0x1
    17dc:	cd058593          	addi	a1,a1,-816 # 24a8 <put.1156>
    17e0:	4505                	li	a0,1
    put[0] = c;
    17e2:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    17e6:	4d41                	li	s10,16
    17e8:	119000ef          	jal	ra,2100 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    17ec:	03cdd793          	srli	a5,s11,0x3c
    17f0:	97ce                	add	a5,a5,s3
    put[0] = c;
    17f2:	0007c783          	lbu	a5,0(a5)
    17f6:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    17f8:	4605                	li	a2,1
    17fa:	85a2                	mv	a1,s0
    17fc:	4505                	li	a0,1
    put[0] = c;
    17fe:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1802:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1804:	0fd000ef          	jal	ra,2100 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1808:	fe0d12e3          	bnez	s10,17ec <printf+0x240>
    180c:	bf19                	j	1722 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    180e:	67a2                	ld	a5,8(sp)
    1810:	4394                	lw	a3,0(a5)
    1812:	07a1                	addi	a5,a5,8
    1814:	e43e                	sd	a5,8(sp)
    1816:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    181a:	0006d663          	bgez	a3,1826 <printf+0x27a>
        x = -xx;
    181e:	40f007bb          	negw	a5,a5
    1822:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    1826:	4729                	li	a4,10
    1828:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    182c:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    1830:	964e                	add	a2,a2,s3
    1832:	00064603          	lbu	a2,0(a2)
    1836:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    183a:	0a0d0963          	beqz	s10,18ec <printf+0x340>
        buf[i++] = digits[x % base];
    183e:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    1842:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    1846:	00c98733          	add	a4,s3,a2
    184a:	00074703          	lbu	a4,0(a4)
    184e:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    1852:	c3cd                	beqz	a5,18f4 <printf+0x348>
        buf[i++] = digits[x % base];
    1854:	97ce                	add	a5,a5,s3
    1856:	0007c703          	lbu	a4,0(a5)
    185a:	4d09                	li	s10,2
    185c:	478d                	li	a5,3
    185e:	00e10923          	sb	a4,18(sp)
    if (sign)
    1862:	0206cd63          	bltz	a3,189c <printf+0x2f0>
    while (--i >= 0)
    1866:	9d5a                	add	s10,s10,s6
    1868:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    186c:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1870:	4605                	li	a2,1
    1872:	1d7d                	addi	s10,s10,-1
    1874:	85a2                	mv	a1,s0
    1876:	4505                	li	a0,1
    put[0] = c;
    1878:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    187c:	085000ef          	jal	ra,2100 <write>
    while (--i >= 0)
    1880:	ffbd16e3          	bne	s10,s11,186c <printf+0x2c0>
    1884:	bd79                	j	1722 <printf+0x176>
    return write(stdout, put, 1);
    1886:	4605                	li	a2,1
    1888:	00001597          	auipc	a1,0x1
    188c:	c2058593          	addi	a1,a1,-992 # 24a8 <put.1156>
    1890:	4505                	li	a0,1
    put[0] = c;
    1892:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    1896:	06b000ef          	jal	ra,2100 <write>
    189a:	b561                	j	1722 <printf+0x176>
        buf[i++] = '-';
    189c:	1818                	addi	a4,sp,48
    189e:	973e                	add	a4,a4,a5
    18a0:	02d00693          	li	a3,45
    18a4:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    18a8:	8d3e                	mv	s10,a5
    18aa:	bf75                	j	1866 <printf+0x2ba>
        buf[i++] = '-';
    18ac:	181c                	addi	a5,sp,48
    18ae:	97b6                	add	a5,a5,a3
    18b0:	02d00713          	li	a4,45
    18b4:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    18b8:	8d36                	mv	s10,a3
    18ba:	bdd9                	j	1790 <printf+0x1e4>
        x = -xx;
    18bc:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    18c0:	00f7f693          	andi	a3,a5,15
    18c4:	96ce                	add	a3,a3,s3
    18c6:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    18ca:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    18ce:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    18d2:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    18d6:	d80d1be3          	bnez	s10,166c <printf+0xc0>
        buf[i++] = digits[x % base];
    18da:	4d05                	li	s10,1
    18dc:	b34d                	j	167e <printf+0xd2>
                s = "(null)";
    18de:	00001d17          	auipc	s10,0x1
    18e2:	ba2d0d13          	addi	s10,s10,-1118 # 2480 <sharedmem+0x22e>
                for (; *s; s++)
    18e6:	02800793          	li	a5,40
    18ea:	bbe5                	j	16e2 <printf+0x136>
        buf[i++] = digits[x % base];
    18ec:	4785                	li	a5,1
    if (sign)
    18ee:	f606dce3          	bgez	a3,1866 <printf+0x2ba>
    18f2:	b76d                	j	189c <printf+0x2f0>
        buf[i++] = digits[x % base];
    18f4:	4789                	li	a5,2
    18f6:	4d05                	li	s10,1
    if (sign)
    18f8:	f606d7e3          	bgez	a3,1866 <printf+0x2ba>
    18fc:	b745                	j	189c <printf+0x2f0>

00000000000018fe <srand>:
#include <ucore.h>

static uint64 seed;

void srand(unsigned s) {
    seed = s - 1;
    18fe:	357d                	addiw	a0,a0,-1
    1900:	1502                	slli	a0,a0,0x20
    1902:	9101                	srli	a0,a0,0x20
    1904:	00001797          	auipc	a5,0x1
    1908:	baa7b623          	sd	a0,-1108(a5) # 24b0 <seed>
}
    190c:	8082                	ret

000000000000190e <rand>:

int rand(void) {
    seed = 6364136223846793005ULL * seed + 1;
    190e:	00001797          	auipc	a5,0x1
    1912:	ba278793          	addi	a5,a5,-1118 # 24b0 <seed>
    1916:	6388                	ld	a0,0(a5)
    1918:	00001717          	auipc	a4,0x1
    191c:	b7073703          	ld	a4,-1168(a4) # 2488 <sharedmem+0x236>
    1920:	02e50533          	mul	a0,a0,a4
    1924:	0505                	addi	a0,a0,1
    1926:	e388                	sd	a0,0(a5)
    return seed >> 33;
}
    1928:	9105                	srli	a0,a0,0x21
    192a:	8082                	ret

000000000000192c <panic>:

void panic(char* m) {
    192c:	1141                	addi	sp,sp,-16
    192e:	e406                	sd	ra,8(sp)
    puts(m);
    1930:	c37ff0ef          	jal	ra,1566 <puts>
    exit(-100);
}
    1934:	60a2                	ld	ra,8(sp)
    exit(-100);
    1936:	f9c00513          	li	a0,-100
}
    193a:	0141                	addi	sp,sp,16
    exit(-100);
    193c:	af45                	j	20ec <exit>

000000000000193e <assert>:

void assert(int f, int code) {
    if(!f) {
    193e:	c111                	beqz	a0,1942 <assert+0x4>
        exit(code);
    }
    1940:	8082                	ret
        exit(code);
    1942:	852e                	mv	a0,a1
    1944:	a765                	j	20ec <exit>

0000000000001946 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    1946:	02000793          	li	a5,32
    194a:	00f50663          	beq	a0,a5,1956 <isspace+0x10>
    194e:	355d                	addiw	a0,a0,-9
    1950:	00553513          	sltiu	a0,a0,5
    1954:	8082                	ret
    1956:	4505                	li	a0,1
}
    1958:	8082                	ret

000000000000195a <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    195a:	fd05051b          	addiw	a0,a0,-48
}
    195e:	00a53513          	sltiu	a0,a0,10
    1962:	8082                	ret

0000000000001964 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    1964:	02000613          	li	a2,32
    1968:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    196a:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    196e:	ff77069b          	addiw	a3,a4,-9
    1972:	04c70d63          	beq	a4,a2,19cc <atoi+0x68>
    1976:	0007079b          	sext.w	a5,a4
    197a:	04d5f963          	bgeu	a1,a3,19cc <atoi+0x68>
        s++;
    switch (*s) {
    197e:	02b00693          	li	a3,43
    1982:	04d70a63          	beq	a4,a3,19d6 <atoi+0x72>
    1986:	02d00693          	li	a3,45
    198a:	06d70463          	beq	a4,a3,19f2 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    198e:	fd07859b          	addiw	a1,a5,-48
    1992:	4625                	li	a2,9
    1994:	873e                	mv	a4,a5
    1996:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1998:	4e01                	li	t3,0
    while (isdigit(*s))
    199a:	04b66a63          	bltu	a2,a1,19ee <atoi+0x8a>
    int n = 0, neg = 0;
    199e:	4501                	li	a0,0
    while (isdigit(*s))
    19a0:	4825                	li	a6,9
    19a2:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    19a6:	0025179b          	slliw	a5,a0,0x2
    19aa:	9d3d                	addw	a0,a0,a5
    19ac:	fd07031b          	addiw	t1,a4,-48
    19b0:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    19b4:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    19b8:	0685                	addi	a3,a3,1
    19ba:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    19be:	0006071b          	sext.w	a4,a2
    19c2:	feb870e3          	bgeu	a6,a1,19a2 <atoi+0x3e>
    return neg ? n : -n;
    19c6:	000e0563          	beqz	t3,19d0 <atoi+0x6c>
}
    19ca:	8082                	ret
        s++;
    19cc:	0505                	addi	a0,a0,1
    19ce:	bf71                	j	196a <atoi+0x6>
    19d0:	4113053b          	subw	a0,t1,a7
    19d4:	8082                	ret
    while (isdigit(*s))
    19d6:	00154783          	lbu	a5,1(a0)
    19da:	4625                	li	a2,9
        s++;
    19dc:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    19e0:	fd07859b          	addiw	a1,a5,-48
    19e4:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    19e8:	4e01                	li	t3,0
    while (isdigit(*s))
    19ea:	fab67ae3          	bgeu	a2,a1,199e <atoi+0x3a>
    19ee:	4501                	li	a0,0
}
    19f0:	8082                	ret
    while (isdigit(*s))
    19f2:	00154783          	lbu	a5,1(a0)
    19f6:	4625                	li	a2,9
        s++;
    19f8:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    19fc:	fd07859b          	addiw	a1,a5,-48
    1a00:	0007871b          	sext.w	a4,a5
    1a04:	feb665e3          	bltu	a2,a1,19ee <atoi+0x8a>
        neg = 1;
    1a08:	4e05                	li	t3,1
    1a0a:	bf51                	j	199e <atoi+0x3a>

0000000000001a0c <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    1a0c:	16060d63          	beqz	a2,1b86 <memset+0x17a>
    1a10:	40a007b3          	neg	a5,a0
    1a14:	8b9d                	andi	a5,a5,7
    1a16:	00778713          	addi	a4,a5,7
    1a1a:	482d                	li	a6,11
    1a1c:	0ff5f593          	andi	a1,a1,255
    1a20:	fff60693          	addi	a3,a2,-1
    1a24:	17076263          	bltu	a4,a6,1b88 <memset+0x17c>
    1a28:	16e6ea63          	bltu	a3,a4,1b9c <memset+0x190>
    1a2c:	16078563          	beqz	a5,1b96 <memset+0x18a>
    1a30:	00b50023          	sb	a1,0(a0)
    1a34:	4705                	li	a4,1
    1a36:	00150e93          	addi	t4,a0,1
    1a3a:	14e78c63          	beq	a5,a4,1b92 <memset+0x186>
    1a3e:	00b500a3          	sb	a1,1(a0)
    1a42:	4709                	li	a4,2
    1a44:	00250e93          	addi	t4,a0,2
    1a48:	14e78d63          	beq	a5,a4,1ba2 <memset+0x196>
    1a4c:	00b50123          	sb	a1,2(a0)
    1a50:	470d                	li	a4,3
    1a52:	00350e93          	addi	t4,a0,3
    1a56:	12e78b63          	beq	a5,a4,1b8c <memset+0x180>
    1a5a:	00b501a3          	sb	a1,3(a0)
    1a5e:	4711                	li	a4,4
    1a60:	00450e93          	addi	t4,a0,4
    1a64:	14e78163          	beq	a5,a4,1ba6 <memset+0x19a>
    1a68:	00b50223          	sb	a1,4(a0)
    1a6c:	4715                	li	a4,5
    1a6e:	00550e93          	addi	t4,a0,5
    1a72:	12e78c63          	beq	a5,a4,1baa <memset+0x19e>
    1a76:	00b502a3          	sb	a1,5(a0)
    1a7a:	471d                	li	a4,7
    1a7c:	00650e93          	addi	t4,a0,6
    1a80:	12e79763          	bne	a5,a4,1bae <memset+0x1a2>
    1a84:	00750e93          	addi	t4,a0,7
    1a88:	00b50323          	sb	a1,6(a0)
    1a8c:	4f1d                	li	t5,7
    1a8e:	00859713          	slli	a4,a1,0x8
    1a92:	8f4d                	or	a4,a4,a1
    1a94:	01059e13          	slli	t3,a1,0x10
    1a98:	01c76e33          	or	t3,a4,t3
    1a9c:	01859313          	slli	t1,a1,0x18
    1aa0:	006e6333          	or	t1,t3,t1
    1aa4:	02059893          	slli	a7,a1,0x20
    1aa8:	011368b3          	or	a7,t1,a7
    1aac:	02859813          	slli	a6,a1,0x28
    1ab0:	40f60333          	sub	t1,a2,a5
    1ab4:	0108e833          	or	a6,a7,a6
    1ab8:	03059693          	slli	a3,a1,0x30
    1abc:	00d866b3          	or	a3,a6,a3
    1ac0:	03859713          	slli	a4,a1,0x38
    1ac4:	97aa                	add	a5,a5,a0
    1ac6:	ff837813          	andi	a6,t1,-8
    1aca:	8f55                	or	a4,a4,a3
    1acc:	00f806b3          	add	a3,a6,a5
    1ad0:	e398                	sd	a4,0(a5)
    1ad2:	07a1                	addi	a5,a5,8
    1ad4:	fed79ee3          	bne	a5,a3,1ad0 <memset+0xc4>
    1ad8:	ff837693          	andi	a3,t1,-8
    1adc:	00de87b3          	add	a5,t4,a3
    1ae0:	01e6873b          	addw	a4,a3,t5
    1ae4:	0ad30663          	beq	t1,a3,1b90 <memset+0x184>
    1ae8:	00b78023          	sb	a1,0(a5)
    1aec:	0017069b          	addiw	a3,a4,1
    1af0:	08c6fb63          	bgeu	a3,a2,1b86 <memset+0x17a>
    1af4:	00b780a3          	sb	a1,1(a5)
    1af8:	0027069b          	addiw	a3,a4,2
    1afc:	08c6f563          	bgeu	a3,a2,1b86 <memset+0x17a>
    1b00:	00b78123          	sb	a1,2(a5)
    1b04:	0037069b          	addiw	a3,a4,3
    1b08:	06c6ff63          	bgeu	a3,a2,1b86 <memset+0x17a>
    1b0c:	00b781a3          	sb	a1,3(a5)
    1b10:	0047069b          	addiw	a3,a4,4
    1b14:	06c6f963          	bgeu	a3,a2,1b86 <memset+0x17a>
    1b18:	00b78223          	sb	a1,4(a5)
    1b1c:	0057069b          	addiw	a3,a4,5
    1b20:	06c6f363          	bgeu	a3,a2,1b86 <memset+0x17a>
    1b24:	00b782a3          	sb	a1,5(a5)
    1b28:	0067069b          	addiw	a3,a4,6
    1b2c:	04c6fd63          	bgeu	a3,a2,1b86 <memset+0x17a>
    1b30:	00b78323          	sb	a1,6(a5)
    1b34:	0077069b          	addiw	a3,a4,7
    1b38:	04c6f763          	bgeu	a3,a2,1b86 <memset+0x17a>
    1b3c:	00b783a3          	sb	a1,7(a5)
    1b40:	0087069b          	addiw	a3,a4,8
    1b44:	04c6f163          	bgeu	a3,a2,1b86 <memset+0x17a>
    1b48:	00b78423          	sb	a1,8(a5)
    1b4c:	0097069b          	addiw	a3,a4,9
    1b50:	02c6fb63          	bgeu	a3,a2,1b86 <memset+0x17a>
    1b54:	00b784a3          	sb	a1,9(a5)
    1b58:	00a7069b          	addiw	a3,a4,10
    1b5c:	02c6f563          	bgeu	a3,a2,1b86 <memset+0x17a>
    1b60:	00b78523          	sb	a1,10(a5)
    1b64:	00b7069b          	addiw	a3,a4,11
    1b68:	00c6ff63          	bgeu	a3,a2,1b86 <memset+0x17a>
    1b6c:	00b785a3          	sb	a1,11(a5)
    1b70:	00c7069b          	addiw	a3,a4,12
    1b74:	00c6f963          	bgeu	a3,a2,1b86 <memset+0x17a>
    1b78:	00b78623          	sb	a1,12(a5)
    1b7c:	2735                	addiw	a4,a4,13
    1b7e:	00c77463          	bgeu	a4,a2,1b86 <memset+0x17a>
    1b82:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    1b86:	8082                	ret
    1b88:	472d                	li	a4,11
    1b8a:	bd79                	j	1a28 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1b8c:	4f0d                	li	t5,3
    1b8e:	b701                	j	1a8e <memset+0x82>
    1b90:	8082                	ret
    1b92:	4f05                	li	t5,1
    1b94:	bded                	j	1a8e <memset+0x82>
    1b96:	8eaa                	mv	t4,a0
    1b98:	4f01                	li	t5,0
    1b9a:	bdd5                	j	1a8e <memset+0x82>
    1b9c:	87aa                	mv	a5,a0
    1b9e:	4701                	li	a4,0
    1ba0:	b7a1                	j	1ae8 <memset+0xdc>
    1ba2:	4f09                	li	t5,2
    1ba4:	b5ed                	j	1a8e <memset+0x82>
    1ba6:	4f11                	li	t5,4
    1ba8:	b5dd                	j	1a8e <memset+0x82>
    1baa:	4f15                	li	t5,5
    1bac:	b5cd                	j	1a8e <memset+0x82>
    1bae:	4f19                	li	t5,6
    1bb0:	bdf9                	j	1a8e <memset+0x82>

0000000000001bb2 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    1bb2:	00054783          	lbu	a5,0(a0)
    1bb6:	0005c703          	lbu	a4,0(a1)
    1bba:	00e79863          	bne	a5,a4,1bca <strcmp+0x18>
    1bbe:	0505                	addi	a0,a0,1
    1bc0:	0585                	addi	a1,a1,1
    1bc2:	fbe5                	bnez	a5,1bb2 <strcmp>
    1bc4:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    1bc6:	9d19                	subw	a0,a0,a4
    1bc8:	8082                	ret
    1bca:	0007851b          	sext.w	a0,a5
    1bce:	bfe5                	j	1bc6 <strcmp+0x14>

0000000000001bd0 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1bd0:	87aa                	mv	a5,a0
    1bd2:	0005c703          	lbu	a4,0(a1)
    1bd6:	0785                	addi	a5,a5,1
    1bd8:	0585                	addi	a1,a1,1
    1bda:	fee78fa3          	sb	a4,-1(a5)
    1bde:	fb75                	bnez	a4,1bd2 <strcpy+0x2>
        ;
    return os;
}
    1be0:	8082                	ret

0000000000001be2 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    1be2:	ce05                	beqz	a2,1c1a <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1be4:	00054703          	lbu	a4,0(a0)
    1be8:	0005c783          	lbu	a5,0(a1)
    1bec:	cb0d                	beqz	a4,1c1e <strncmp+0x3c>
    if (!n--)
    1bee:	167d                	addi	a2,a2,-1
    1bf0:	00c506b3          	add	a3,a0,a2
    1bf4:	a819                	j	1c0a <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1bf6:	00a68e63          	beq	a3,a0,1c12 <strncmp+0x30>
    1bfa:	0505                	addi	a0,a0,1
    1bfc:	00e79b63          	bne	a5,a4,1c12 <strncmp+0x30>
    1c00:	00054703          	lbu	a4,0(a0)
    1c04:	0005c783          	lbu	a5,0(a1)
    1c08:	cb19                	beqz	a4,1c1e <strncmp+0x3c>
    1c0a:	0005c783          	lbu	a5,0(a1)
    1c0e:	0585                	addi	a1,a1,1
    1c10:	f3fd                	bnez	a5,1bf6 <strncmp+0x14>
        ;
    return *l - *r;
    1c12:	0007051b          	sext.w	a0,a4
    1c16:	9d1d                	subw	a0,a0,a5
    1c18:	8082                	ret
        return 0;
    1c1a:	4501                	li	a0,0
}
    1c1c:	8082                	ret
    1c1e:	4501                	li	a0,0
    return *l - *r;
    1c20:	9d1d                	subw	a0,a0,a5
    1c22:	8082                	ret

0000000000001c24 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    1c24:	00757793          	andi	a5,a0,7
    1c28:	cf89                	beqz	a5,1c42 <strlen+0x1e>
    1c2a:	87aa                	mv	a5,a0
    1c2c:	a029                	j	1c36 <strlen+0x12>
    1c2e:	0785                	addi	a5,a5,1
    1c30:	0077f713          	andi	a4,a5,7
    1c34:	cb01                	beqz	a4,1c44 <strlen+0x20>
        if (!*s)
    1c36:	0007c703          	lbu	a4,0(a5)
    1c3a:	fb75                	bnez	a4,1c2e <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1c3c:	40a78533          	sub	a0,a5,a0
}
    1c40:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1c42:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    1c44:	6394                	ld	a3,0(a5)
    1c46:	00001597          	auipc	a1,0x1
    1c4a:	84a5b583          	ld	a1,-1974(a1) # 2490 <sharedmem+0x23e>
    1c4e:	00001617          	auipc	a2,0x1
    1c52:	84a63603          	ld	a2,-1974(a2) # 2498 <sharedmem+0x246>
    1c56:	a019                	j	1c5c <strlen+0x38>
    1c58:	6794                	ld	a3,8(a5)
    1c5a:	07a1                	addi	a5,a5,8
    1c5c:	00b68733          	add	a4,a3,a1
    1c60:	fff6c693          	not	a3,a3
    1c64:	8f75                	and	a4,a4,a3
    1c66:	8f71                	and	a4,a4,a2
    1c68:	db65                	beqz	a4,1c58 <strlen+0x34>
    for (; *s; s++)
    1c6a:	0007c703          	lbu	a4,0(a5)
    1c6e:	d779                	beqz	a4,1c3c <strlen+0x18>
    1c70:	0017c703          	lbu	a4,1(a5)
    1c74:	0785                	addi	a5,a5,1
    1c76:	d379                	beqz	a4,1c3c <strlen+0x18>
    1c78:	0017c703          	lbu	a4,1(a5)
    1c7c:	0785                	addi	a5,a5,1
    1c7e:	fb6d                	bnez	a4,1c70 <strlen+0x4c>
    1c80:	bf75                	j	1c3c <strlen+0x18>

0000000000001c82 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1c82:	00757713          	andi	a4,a0,7
{
    1c86:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1c88:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1c8c:	cb19                	beqz	a4,1ca2 <memchr+0x20>
    1c8e:	ce25                	beqz	a2,1d06 <memchr+0x84>
    1c90:	0007c703          	lbu	a4,0(a5)
    1c94:	04b70e63          	beq	a4,a1,1cf0 <memchr+0x6e>
    1c98:	0785                	addi	a5,a5,1
    1c9a:	0077f713          	andi	a4,a5,7
    1c9e:	167d                	addi	a2,a2,-1
    1ca0:	f77d                	bnez	a4,1c8e <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    1ca2:	4501                	li	a0,0
    if (n && *s != c) {
    1ca4:	c235                	beqz	a2,1d08 <memchr+0x86>
    1ca6:	0007c703          	lbu	a4,0(a5)
    1caa:	04b70363          	beq	a4,a1,1cf0 <memchr+0x6e>
        size_t k = ONES * c;
    1cae:	00000517          	auipc	a0,0x0
    1cb2:	7f253503          	ld	a0,2034(a0) # 24a0 <sharedmem+0x24e>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1cb6:	471d                	li	a4,7
        size_t k = ONES * c;
    1cb8:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1cbc:	02c77a63          	bgeu	a4,a2,1cf0 <memchr+0x6e>
    1cc0:	00000897          	auipc	a7,0x0
    1cc4:	7d08b883          	ld	a7,2000(a7) # 2490 <sharedmem+0x23e>
    1cc8:	00000817          	auipc	a6,0x0
    1ccc:	7d083803          	ld	a6,2000(a6) # 2498 <sharedmem+0x246>
    1cd0:	431d                	li	t1,7
    1cd2:	a029                	j	1cdc <memchr+0x5a>
    1cd4:	1661                	addi	a2,a2,-8
    1cd6:	07a1                	addi	a5,a5,8
    1cd8:	02c37963          	bgeu	t1,a2,1d0a <memchr+0x88>
    1cdc:	6398                	ld	a4,0(a5)
    1cde:	8f29                	xor	a4,a4,a0
    1ce0:	011706b3          	add	a3,a4,a7
    1ce4:	fff74713          	not	a4,a4
    1ce8:	8f75                	and	a4,a4,a3
    1cea:	01077733          	and	a4,a4,a6
    1cee:	d37d                	beqz	a4,1cd4 <memchr+0x52>
    1cf0:	853e                	mv	a0,a5
    1cf2:	97b2                	add	a5,a5,a2
    1cf4:	a021                	j	1cfc <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1cf6:	0505                	addi	a0,a0,1
    1cf8:	00f50763          	beq	a0,a5,1d06 <memchr+0x84>
    1cfc:	00054703          	lbu	a4,0(a0)
    1d00:	feb71be3          	bne	a4,a1,1cf6 <memchr+0x74>
    1d04:	8082                	ret
    return n ? (void*)s : 0;
    1d06:	4501                	li	a0,0
}
    1d08:	8082                	ret
    return n ? (void*)s : 0;
    1d0a:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1d0c:	f275                	bnez	a2,1cf0 <memchr+0x6e>
}
    1d0e:	8082                	ret

0000000000001d10 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1d10:	1101                	addi	sp,sp,-32
    1d12:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1d14:	862e                	mv	a2,a1
{
    1d16:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1d18:	4581                	li	a1,0
{
    1d1a:	e426                	sd	s1,8(sp)
    1d1c:	ec06                	sd	ra,24(sp)
    1d1e:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1d20:	f63ff0ef          	jal	ra,1c82 <memchr>
    return p ? p - s : n;
    1d24:	c519                	beqz	a0,1d32 <strnlen+0x22>
}
    1d26:	60e2                	ld	ra,24(sp)
    1d28:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1d2a:	8d05                	sub	a0,a0,s1
}
    1d2c:	64a2                	ld	s1,8(sp)
    1d2e:	6105                	addi	sp,sp,32
    1d30:	8082                	ret
    1d32:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1d34:	8522                	mv	a0,s0
}
    1d36:	6442                	ld	s0,16(sp)
    1d38:	64a2                	ld	s1,8(sp)
    1d3a:	6105                	addi	sp,sp,32
    1d3c:	8082                	ret

0000000000001d3e <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1d3e:	00b547b3          	xor	a5,a0,a1
    1d42:	8b9d                	andi	a5,a5,7
    1d44:	eb95                	bnez	a5,1d78 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1d46:	0075f793          	andi	a5,a1,7
    1d4a:	e7b1                	bnez	a5,1d96 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1d4c:	6198                	ld	a4,0(a1)
    1d4e:	00000617          	auipc	a2,0x0
    1d52:	74263603          	ld	a2,1858(a2) # 2490 <sharedmem+0x23e>
    1d56:	00000817          	auipc	a6,0x0
    1d5a:	74283803          	ld	a6,1858(a6) # 2498 <sharedmem+0x246>
    1d5e:	a029                	j	1d68 <stpcpy+0x2a>
    1d60:	e118                	sd	a4,0(a0)
    1d62:	6598                	ld	a4,8(a1)
    1d64:	05a1                	addi	a1,a1,8
    1d66:	0521                	addi	a0,a0,8
    1d68:	00c707b3          	add	a5,a4,a2
    1d6c:	fff74693          	not	a3,a4
    1d70:	8ff5                	and	a5,a5,a3
    1d72:	0107f7b3          	and	a5,a5,a6
    1d76:	d7ed                	beqz	a5,1d60 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1d78:	0005c783          	lbu	a5,0(a1)
    1d7c:	00f50023          	sb	a5,0(a0)
    1d80:	c785                	beqz	a5,1da8 <stpcpy+0x6a>
    1d82:	0015c783          	lbu	a5,1(a1)
    1d86:	0505                	addi	a0,a0,1
    1d88:	0585                	addi	a1,a1,1
    1d8a:	00f50023          	sb	a5,0(a0)
    1d8e:	fbf5                	bnez	a5,1d82 <stpcpy+0x44>
        ;
    return d;
}
    1d90:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1d92:	0505                	addi	a0,a0,1
    1d94:	df45                	beqz	a4,1d4c <stpcpy+0xe>
            if (!(*d = *s))
    1d96:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1d9a:	0585                	addi	a1,a1,1
    1d9c:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1da0:	00f50023          	sb	a5,0(a0)
    1da4:	f7fd                	bnez	a5,1d92 <stpcpy+0x54>
}
    1da6:	8082                	ret
    1da8:	8082                	ret

0000000000001daa <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1daa:	00b547b3          	xor	a5,a0,a1
    1dae:	8b9d                	andi	a5,a5,7
    1db0:	1a079863          	bnez	a5,1f60 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1db4:	0075f793          	andi	a5,a1,7
    1db8:	16078463          	beqz	a5,1f20 <stpncpy+0x176>
    1dbc:	ea01                	bnez	a2,1dcc <stpncpy+0x22>
    1dbe:	a421                	j	1fc6 <stpncpy+0x21c>
    1dc0:	167d                	addi	a2,a2,-1
    1dc2:	0505                	addi	a0,a0,1
    1dc4:	14070e63          	beqz	a4,1f20 <stpncpy+0x176>
    1dc8:	1a060863          	beqz	a2,1f78 <stpncpy+0x1ce>
    1dcc:	0005c783          	lbu	a5,0(a1)
    1dd0:	0585                	addi	a1,a1,1
    1dd2:	0075f713          	andi	a4,a1,7
    1dd6:	00f50023          	sb	a5,0(a0)
    1dda:	f3fd                	bnez	a5,1dc0 <stpncpy+0x16>
    1ddc:	4805                	li	a6,1
    1dde:	1a061863          	bnez	a2,1f8e <stpncpy+0x1e4>
    1de2:	40a007b3          	neg	a5,a0
    1de6:	8b9d                	andi	a5,a5,7
    1de8:	4681                	li	a3,0
    1dea:	18061a63          	bnez	a2,1f7e <stpncpy+0x1d4>
    1dee:	00778713          	addi	a4,a5,7
    1df2:	45ad                	li	a1,11
    1df4:	18b76363          	bltu	a4,a1,1f7a <stpncpy+0x1d0>
    1df8:	1ae6eb63          	bltu	a3,a4,1fae <stpncpy+0x204>
    1dfc:	1a078363          	beqz	a5,1fa2 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1e00:	00050023          	sb	zero,0(a0)
    1e04:	4685                	li	a3,1
    1e06:	00150713          	addi	a4,a0,1
    1e0a:	18d78f63          	beq	a5,a3,1fa8 <stpncpy+0x1fe>
    1e0e:	000500a3          	sb	zero,1(a0)
    1e12:	4689                	li	a3,2
    1e14:	00250713          	addi	a4,a0,2
    1e18:	18d78e63          	beq	a5,a3,1fb4 <stpncpy+0x20a>
    1e1c:	00050123          	sb	zero,2(a0)
    1e20:	468d                	li	a3,3
    1e22:	00350713          	addi	a4,a0,3
    1e26:	16d78c63          	beq	a5,a3,1f9e <stpncpy+0x1f4>
    1e2a:	000501a3          	sb	zero,3(a0)
    1e2e:	4691                	li	a3,4
    1e30:	00450713          	addi	a4,a0,4
    1e34:	18d78263          	beq	a5,a3,1fb8 <stpncpy+0x20e>
    1e38:	00050223          	sb	zero,4(a0)
    1e3c:	4695                	li	a3,5
    1e3e:	00550713          	addi	a4,a0,5
    1e42:	16d78d63          	beq	a5,a3,1fbc <stpncpy+0x212>
    1e46:	000502a3          	sb	zero,5(a0)
    1e4a:	469d                	li	a3,7
    1e4c:	00650713          	addi	a4,a0,6
    1e50:	16d79863          	bne	a5,a3,1fc0 <stpncpy+0x216>
    1e54:	00750713          	addi	a4,a0,7
    1e58:	00050323          	sb	zero,6(a0)
    1e5c:	40f80833          	sub	a6,a6,a5
    1e60:	ff887593          	andi	a1,a6,-8
    1e64:	97aa                	add	a5,a5,a0
    1e66:	95be                	add	a1,a1,a5
    1e68:	0007b023          	sd	zero,0(a5)
    1e6c:	07a1                	addi	a5,a5,8
    1e6e:	feb79de3          	bne	a5,a1,1e68 <stpncpy+0xbe>
    1e72:	ff887593          	andi	a1,a6,-8
    1e76:	9ead                	addw	a3,a3,a1
    1e78:	00b707b3          	add	a5,a4,a1
    1e7c:	12b80863          	beq	a6,a1,1fac <stpncpy+0x202>
    1e80:	00078023          	sb	zero,0(a5)
    1e84:	0016871b          	addiw	a4,a3,1
    1e88:	0ec77863          	bgeu	a4,a2,1f78 <stpncpy+0x1ce>
    1e8c:	000780a3          	sb	zero,1(a5)
    1e90:	0026871b          	addiw	a4,a3,2
    1e94:	0ec77263          	bgeu	a4,a2,1f78 <stpncpy+0x1ce>
    1e98:	00078123          	sb	zero,2(a5)
    1e9c:	0036871b          	addiw	a4,a3,3
    1ea0:	0cc77c63          	bgeu	a4,a2,1f78 <stpncpy+0x1ce>
    1ea4:	000781a3          	sb	zero,3(a5)
    1ea8:	0046871b          	addiw	a4,a3,4
    1eac:	0cc77663          	bgeu	a4,a2,1f78 <stpncpy+0x1ce>
    1eb0:	00078223          	sb	zero,4(a5)
    1eb4:	0056871b          	addiw	a4,a3,5
    1eb8:	0cc77063          	bgeu	a4,a2,1f78 <stpncpy+0x1ce>
    1ebc:	000782a3          	sb	zero,5(a5)
    1ec0:	0066871b          	addiw	a4,a3,6
    1ec4:	0ac77a63          	bgeu	a4,a2,1f78 <stpncpy+0x1ce>
    1ec8:	00078323          	sb	zero,6(a5)
    1ecc:	0076871b          	addiw	a4,a3,7
    1ed0:	0ac77463          	bgeu	a4,a2,1f78 <stpncpy+0x1ce>
    1ed4:	000783a3          	sb	zero,7(a5)
    1ed8:	0086871b          	addiw	a4,a3,8
    1edc:	08c77e63          	bgeu	a4,a2,1f78 <stpncpy+0x1ce>
    1ee0:	00078423          	sb	zero,8(a5)
    1ee4:	0096871b          	addiw	a4,a3,9
    1ee8:	08c77863          	bgeu	a4,a2,1f78 <stpncpy+0x1ce>
    1eec:	000784a3          	sb	zero,9(a5)
    1ef0:	00a6871b          	addiw	a4,a3,10
    1ef4:	08c77263          	bgeu	a4,a2,1f78 <stpncpy+0x1ce>
    1ef8:	00078523          	sb	zero,10(a5)
    1efc:	00b6871b          	addiw	a4,a3,11
    1f00:	06c77c63          	bgeu	a4,a2,1f78 <stpncpy+0x1ce>
    1f04:	000785a3          	sb	zero,11(a5)
    1f08:	00c6871b          	addiw	a4,a3,12
    1f0c:	06c77663          	bgeu	a4,a2,1f78 <stpncpy+0x1ce>
    1f10:	00078623          	sb	zero,12(a5)
    1f14:	26b5                	addiw	a3,a3,13
    1f16:	06c6f163          	bgeu	a3,a2,1f78 <stpncpy+0x1ce>
    1f1a:	000786a3          	sb	zero,13(a5)
    1f1e:	8082                	ret
            ;
        if (!n || !*s)
    1f20:	c645                	beqz	a2,1fc8 <stpncpy+0x21e>
    1f22:	0005c783          	lbu	a5,0(a1)
    1f26:	ea078be3          	beqz	a5,1ddc <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1f2a:	479d                	li	a5,7
    1f2c:	02c7ff63          	bgeu	a5,a2,1f6a <stpncpy+0x1c0>
    1f30:	00000897          	auipc	a7,0x0
    1f34:	5608b883          	ld	a7,1376(a7) # 2490 <sharedmem+0x23e>
    1f38:	00000817          	auipc	a6,0x0
    1f3c:	56083803          	ld	a6,1376(a6) # 2498 <sharedmem+0x246>
    1f40:	431d                	li	t1,7
    1f42:	6198                	ld	a4,0(a1)
    1f44:	011707b3          	add	a5,a4,a7
    1f48:	fff74693          	not	a3,a4
    1f4c:	8ff5                	and	a5,a5,a3
    1f4e:	0107f7b3          	and	a5,a5,a6
    1f52:	ef81                	bnez	a5,1f6a <stpncpy+0x1c0>
            *wd = *ws;
    1f54:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1f56:	1661                	addi	a2,a2,-8
    1f58:	05a1                	addi	a1,a1,8
    1f5a:	0521                	addi	a0,a0,8
    1f5c:	fec363e3          	bltu	t1,a2,1f42 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1f60:	e609                	bnez	a2,1f6a <stpncpy+0x1c0>
    1f62:	a08d                	j	1fc4 <stpncpy+0x21a>
    1f64:	167d                	addi	a2,a2,-1
    1f66:	0505                	addi	a0,a0,1
    1f68:	ca01                	beqz	a2,1f78 <stpncpy+0x1ce>
    1f6a:	0005c783          	lbu	a5,0(a1)
    1f6e:	0585                	addi	a1,a1,1
    1f70:	00f50023          	sb	a5,0(a0)
    1f74:	fbe5                	bnez	a5,1f64 <stpncpy+0x1ba>
        ;
tail:
    1f76:	b59d                	j	1ddc <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1f78:	8082                	ret
    1f7a:	472d                	li	a4,11
    1f7c:	bdb5                	j	1df8 <stpncpy+0x4e>
    1f7e:	00778713          	addi	a4,a5,7
    1f82:	45ad                	li	a1,11
    1f84:	fff60693          	addi	a3,a2,-1
    1f88:	e6b778e3          	bgeu	a4,a1,1df8 <stpncpy+0x4e>
    1f8c:	b7fd                	j	1f7a <stpncpy+0x1d0>
    1f8e:	40a007b3          	neg	a5,a0
    1f92:	8832                	mv	a6,a2
    1f94:	8b9d                	andi	a5,a5,7
    1f96:	4681                	li	a3,0
    1f98:	e4060be3          	beqz	a2,1dee <stpncpy+0x44>
    1f9c:	b7cd                	j	1f7e <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1f9e:	468d                	li	a3,3
    1fa0:	bd75                	j	1e5c <stpncpy+0xb2>
    1fa2:	872a                	mv	a4,a0
    1fa4:	4681                	li	a3,0
    1fa6:	bd5d                	j	1e5c <stpncpy+0xb2>
    1fa8:	4685                	li	a3,1
    1faa:	bd4d                	j	1e5c <stpncpy+0xb2>
    1fac:	8082                	ret
    1fae:	87aa                	mv	a5,a0
    1fb0:	4681                	li	a3,0
    1fb2:	b5f9                	j	1e80 <stpncpy+0xd6>
    1fb4:	4689                	li	a3,2
    1fb6:	b55d                	j	1e5c <stpncpy+0xb2>
    1fb8:	4691                	li	a3,4
    1fba:	b54d                	j	1e5c <stpncpy+0xb2>
    1fbc:	4695                	li	a3,5
    1fbe:	bd79                	j	1e5c <stpncpy+0xb2>
    1fc0:	4699                	li	a3,6
    1fc2:	bd69                	j	1e5c <stpncpy+0xb2>
    1fc4:	8082                	ret
    1fc6:	8082                	ret
    1fc8:	8082                	ret

0000000000001fca <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1fca:	fff6071b          	addiw	a4,a2,-1
    1fce:	0cb57063          	bgeu	a0,a1,208e <memmove+0xc4>
        while (n-- > 0)
    1fd2:	0ec05063          	blez	a2,20b2 <memmove+0xe8>
    1fd6:	00750693          	addi	a3,a0,7
    1fda:	8e8d                	sub	a3,a3,a1
    1fdc:	00b567b3          	or	a5,a0,a1
    1fe0:	00f6b693          	sltiu	a3,a3,15
    1fe4:	8b9d                	andi	a5,a5,7
    1fe6:	0016c693          	xori	a3,a3,1
    1fea:	0017b793          	seqz	a5,a5
    1fee:	8ff5                	and	a5,a5,a3
    1ff0:	c3f1                	beqz	a5,20b4 <memmove+0xea>
    1ff2:	0007079b          	sext.w	a5,a4
    1ff6:	46a5                	li	a3,9
    1ff8:	0af6fe63          	bgeu	a3,a5,20b4 <memmove+0xea>
    1ffc:	0036589b          	srliw	a7,a2,0x3
    2000:	088e                	slli	a7,a7,0x3
    2002:	2601                	sext.w	a2,a2
    2004:	87ae                	mv	a5,a1
    2006:	86aa                	mv	a3,a0
    2008:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    200a:	0007b803          	ld	a6,0(a5)
    200e:	07a1                	addi	a5,a5,8
    2010:	06a1                	addi	a3,a3,8
    2012:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    2016:	ff179ae3          	bne	a5,a7,200a <memmove+0x40>
    201a:	ff867813          	andi	a6,a2,-8
    201e:	02081793          	slli	a5,a6,0x20
    2022:	9381                	srli	a5,a5,0x20
    2024:	00f506b3          	add	a3,a0,a5
    2028:	95be                	add	a1,a1,a5
    202a:	4107073b          	subw	a4,a4,a6
    202e:	09060263          	beq	a2,a6,20b2 <memmove+0xe8>
            *dst++ = *src++;
    2032:	0005c783          	lbu	a5,0(a1)
    2036:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    203a:	06e05c63          	blez	a4,20b2 <memmove+0xe8>
            *dst++ = *src++;
    203e:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    2042:	4785                	li	a5,1
            *dst++ = *src++;
    2044:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    2048:	06e7d563          	bge	a5,a4,20b2 <memmove+0xe8>
            *dst++ = *src++;
    204c:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    2050:	4789                	li	a5,2
            *dst++ = *src++;
    2052:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    2056:	04e7de63          	bge	a5,a4,20b2 <memmove+0xe8>
            *dst++ = *src++;
    205a:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    205e:	478d                	li	a5,3
            *dst++ = *src++;
    2060:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    2064:	04e7d763          	bge	a5,a4,20b2 <memmove+0xe8>
            *dst++ = *src++;
    2068:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    206c:	4791                	li	a5,4
            *dst++ = *src++;
    206e:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    2072:	04e7d063          	bge	a5,a4,20b2 <memmove+0xe8>
            *dst++ = *src++;
    2076:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    207a:	4795                	li	a5,5
            *dst++ = *src++;
    207c:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    2080:	02e7d963          	bge	a5,a4,20b2 <memmove+0xe8>
            *dst++ = *src++;
    2084:	0065c783          	lbu	a5,6(a1)
    2088:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    208c:	8082                	ret
    } else {
        dst += n;
    208e:	00c507b3          	add	a5,a0,a2
        src += n;
    2092:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    2094:	00c05f63          	blez	a2,20b2 <memmove+0xe8>
    2098:	1702                	slli	a4,a4,0x20
    209a:	9301                	srli	a4,a4,0x20
    209c:	fff74713          	not	a4,a4
    20a0:	973e                	add	a4,a4,a5
            *--dst = *--src;
    20a2:	fff5c683          	lbu	a3,-1(a1)
    20a6:	17fd                	addi	a5,a5,-1
    20a8:	15fd                	addi	a1,a1,-1
    20aa:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    20ae:	fee79ae3          	bne	a5,a4,20a2 <memmove+0xd8>
    }
    return vdst;
}
    20b2:	8082                	ret
    20b4:	02071693          	slli	a3,a4,0x20
    20b8:	9281                	srli	a3,a3,0x20
    20ba:	0685                	addi	a3,a3,1
    20bc:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    20be:	87aa                	mv	a5,a0
            *dst++ = *src++;
    20c0:	0005c703          	lbu	a4,0(a1)
    20c4:	0585                	addi	a1,a1,1
    20c6:	0785                	addi	a5,a5,1
    20c8:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    20cc:	fed59ae3          	bne	a1,a3,20c0 <memmove+0xf6>
    20d0:	8082                	ret

00000000000020d2 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    20d2:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    20d6:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    20da:	2501                	sext.w	a0,a0
    20dc:	8082                	ret

00000000000020de <exec>:
    register long a7 __asm__("a7") = n;
    20de:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    20e2:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    20e4:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    20e8:	2501                	sext.w	a0,a0
    20ea:	8082                	ret

00000000000020ec <exit>:
    register long a7 __asm__("a7") = n;
    20ec:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    20f0:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    20f4:	8082                	ret

00000000000020f6 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    20f6:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    20fa:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    20fe:	8082                	ret

0000000000002100 <write>:
    register long a7 __asm__("a7") = n;
    2100:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    2104:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    2108:	8082                	ret

000000000000210a <getpid>:
    register long a7 __asm__("a7") = n;
    210a:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    210e:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    2112:	2501                	sext.w	a0,a0
    2114:	8082                	ret

0000000000002116 <getppid>:
    register long a7 __asm__("a7") = n;
    2116:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    211a:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    211e:	2501                	sext.w	a0,a0
    2120:	8082                	ret

0000000000002122 <open>:
    register long a7 __asm__("a7") = n;
    2122:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2126:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    212a:	2501                	sext.w	a0,a0
    212c:	8082                	ret

000000000000212e <mknod>:
    register long a7 __asm__("a7") = n;
    212e:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    2132:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    2136:	2501                	sext.w	a0,a0
    2138:	8082                	ret

000000000000213a <dup>:
    register long a7 __asm__("a7") = n;
    213a:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    213c:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    2140:	2501                	sext.w	a0,a0
    2142:	8082                	ret

0000000000002144 <sched_yield>:
    register long a7 __asm__("a7") = n;
    2144:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    2148:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    214c:	2501                	sext.w	a0,a0
    214e:	8082                	ret

0000000000002150 <waitpid>:
    register long a7 __asm__("a7") = n;
    2150:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2154:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    2158:	2501                	sext.w	a0,a0
    215a:	8082                	ret

000000000000215c <wait>:

pid_t wait(int *wstatus)
{
    215c:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    215e:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    2162:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2164:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    2168:	2501                	sext.w	a0,a0
    216a:	8082                	ret

000000000000216c <mkdir>:
    register long a7 __asm__("a7") = n;
    216c:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    2170:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    2174:	2501                	sext.w	a0,a0
    2176:	8082                	ret

0000000000002178 <close>:
    register long a7 __asm__("a7") = n;
    2178:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    217c:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    2180:	2501                	sext.w	a0,a0
    2182:	8082                	ret

0000000000002184 <fork>:
    register long a7 __asm__("a7") = n;
    2184:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    2188:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    218c:	2501                	sext.w	a0,a0
    218e:	8082                	ret

0000000000002190 <time_ms>:
    register long a7 __asm__("a7") = n;
    2190:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    2194:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    2198:	8082                	ret

000000000000219a <sleep>:

int sleep(unsigned long long time_in_ms)
{
    219a:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    219c:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    21a0:	00000073          	ecall
    21a4:	87aa                	mv	a5,a0
    21a6:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    21aa:	97ba                	add	a5,a5,a4
    21ac:	00f57c63          	bgeu	a0,a5,21c4 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    21b0:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    21b4:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    21b8:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    21bc:	00000073          	ecall
    21c0:	fef568e3          	bltu	a0,a5,21b0 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    21c4:	4501                	li	a0,0
    21c6:	8082                	ret

00000000000021c8 <pipe>:
    register long a7 __asm__("a7") = n;
    21c8:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    21cc:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    21d0:	2501                	sext.w	a0,a0
    21d2:	8082                	ret

00000000000021d4 <fstat>:
    register long a7 __asm__("a7") = n;
    21d4:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    21d8:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    21dc:	2501                	sext.w	a0,a0
    21de:	8082                	ret

00000000000021e0 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    21e0:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    21e2:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    21e6:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    21e8:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    21ec:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    21f0:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    21f4:	0206c163          	bltz	a3,2216 <stat+0x36>
    register long a7 __asm__("a7") = n;
    21f8:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    21fc:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    21fe:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2200:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    2204:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    2208:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    220c:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    220e:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    2212:	853e                	mv	a0,a5
    2214:	8082                	ret
        return -1;
    2216:	57fd                	li	a5,-1
    2218:	bfed                	j	2212 <stat+0x32>

000000000000221a <chdir>:
    register long a7 __asm__("a7") = n;
    221a:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    221e:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    2222:	2501                	sext.w	a0,a0
    2224:	8082                	ret

0000000000002226 <link>:
    register long a7 __asm__("a7") = n;
    2226:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    222a:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    222e:	2501                	sext.w	a0,a0
    2230:	8082                	ret

0000000000002232 <unlink>:
    register long a7 __asm__("a7") = n;
    2232:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    2236:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    223a:	2501                	sext.w	a0,a0
    223c:	8082                	ret

000000000000223e <setpriority>:
    register long a7 __asm__("a7") = n;
    223e:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    2242:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    2246:	8082                	ret

0000000000002248 <getpriority>:
    register long a7 __asm__("a7") = n;
    2248:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    224c:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    2250:	8082                	ret

0000000000002252 <sharedmem>:
    register long a7 __asm__("a7") = n;
    2252:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2256:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    225a:	8082                	ret
