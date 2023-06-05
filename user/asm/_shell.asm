
/home/ubuntu/Desktop/ZenOS/user/build/riscv64/_shell:     file format elf64-littleriscv


Disassembly of section .startup:

0000000000001000 <_start>:
.text
.globl _start
_start:
    tail __start_main
    1000:	ae59                	j	1396 <__start_main>

Disassembly of section .text:

0000000000001002 <push>:
char line[128] = {};

int top = 0;

void push(char c) {
    line[top++] = c;
    1002:	00001717          	auipc	a4,0x1
    1006:	2ae70713          	addi	a4,a4,686 # 22b0 <top>
    100a:	4314                	lw	a3,0(a4)
    100c:	00001797          	auipc	a5,0x1
    1010:	22478793          	addi	a5,a5,548 # 2230 <line>
    1014:	0016861b          	addiw	a2,a3,1
    1018:	97b6                	add	a5,a5,a3
    101a:	c310                	sw	a2,0(a4)
    101c:	00a78023          	sb	a0,0(a5)
}
    1020:	8082                	ret

0000000000001022 <pop>:

void pop() {
    --top;
    1022:	00001717          	auipc	a4,0x1
    1026:	28e70713          	addi	a4,a4,654 # 22b0 <top>
    102a:	431c                	lw	a5,0(a4)
    102c:	37fd                	addiw	a5,a5,-1
    102e:	c31c                	sw	a5,0(a4)
}
    1030:	8082                	ret

0000000000001032 <is_empty>:

int is_empty() {
    return top == 0;
    1032:	00001517          	auipc	a0,0x1
    1036:	27e52503          	lw	a0,638(a0) # 22b0 <top>
}
    103a:	00153513          	seqz	a0,a0
    103e:	8082                	ret

0000000000001040 <clear>:

void clear() {
    top = 0;
    1040:	00001797          	auipc	a5,0x1
    1044:	2607a823          	sw	zero,624(a5) # 22b0 <top>
}
    1048:	8082                	ret

000000000000104a <print_help>:

void print_help(){
    printf(
    104a:	00001517          	auipc	a0,0x1
    104e:	09650513          	addi	a0,a0,150 # 20e0 <sharedmem+0xe>
    1052:	aee9                	j	142c <printf>

0000000000001054 <parse_line>:
}

char args_buffer[1024];
char *argv[10]; 
char *args_buffer_cur;
void parse_line(){
    1054:	715d                	addi	sp,sp,-80
    1056:	e0a2                	sd	s0,64(sp)
    1058:	f84a                	sd	s2,48(sp)
    105a:	e486                	sd	ra,72(sp)
    105c:	fc26                	sd	s1,56(sp)
    105e:	f44e                	sd	s3,40(sp)
    1060:	f052                	sd	s4,32(sp)
    1062:	ec56                	sd	s5,24(sp)
    1064:	e85a                	sd	s6,16(sp)
    char *end;

    start = line;
    end = line;

    while (*end)
    1066:	00001417          	auipc	s0,0x1
    106a:	1ca40413          	addi	s0,s0,458 # 2230 <line>
    106e:	00044783          	lbu	a5,0(s0)
    args_buffer_cur = args_buffer;
    1072:	00001917          	auipc	s2,0x1
    1076:	6a690913          	addi	s2,s2,1702 # 2718 <args_buffer_cur>
    107a:	00001517          	auipc	a0,0x1
    107e:	29e50513          	addi	a0,a0,670 # 2318 <args_buffer>
    1082:	00a93023          	sd	a0,0(s2)
    while (*end)
    1086:	0e078c63          	beqz	a5,117e <parse_line+0x12a>
    108a:	00001a17          	auipc	s4,0x1
    108e:	23ea0a13          	addi	s4,s4,574 # 22c8 <argv>
    1092:	8ad2                	mv	s5,s4
    int argc = 0;
    1094:	4b01                	li	s6,0
    {
        while (*start == ' ') {
    1096:	02000493          	li	s1,32
    109a:	00979763          	bne	a5,s1,10a8 <parse_line+0x54>
    109e:	00144783          	lbu	a5,1(s0)
            start++;
    10a2:	0405                	addi	s0,s0,1
        while (*start == ' ') {
    10a4:	fe978de3          	beq	a5,s1,109e <parse_line+0x4a>
    10a8:	85a2                	mv	a1,s0
        }

        end = start;
        while (*end != ' ' && *end != '\0') {
    10aa:	c791                	beqz	a5,10b6 <parse_line+0x62>
    10ac:	00144783          	lbu	a5,1(s0)
            end++;
    10b0:	0405                	addi	s0,s0,1
        while (*end != ' ' && *end != '\0') {
    10b2:	fe979ce3          	bne	a5,s1,10aa <parse_line+0x56>
        }

        int arg_len = end - start;
    10b6:	40b409bb          	subw	s3,s0,a1
        if(arg_len==0)
    10ba:	06098363          	beqz	s3,1120 <parse_line+0xcc>
            break;
        // printf("arg_len %d\n", arg_len);
        argv[argc] = args_buffer_cur;
        stpncpy(args_buffer_cur, start, arg_len);
    10be:	864e                	mv	a2,s3
        argv[argc] = args_buffer_cur;
    10c0:	00aab023          	sd	a0,0(s5)
        stpncpy(args_buffer_cur, start, arg_len);
    10c4:	367000ef          	jal	ra,1c2a <stpncpy>
        args_buffer_cur += arg_len;
    10c8:	00093783          	ld	a5,0(s2)
        *args_buffer_cur = 0;
        args_buffer_cur++;
        argc++;
    10cc:	2b05                	addiw	s6,s6,1
    10ce:	0aa1                	addi	s5,s5,8
        args_buffer_cur += arg_len;
    10d0:	01378633          	add	a2,a5,s3
    10d4:	00c93023          	sd	a2,0(s2)
        *args_buffer_cur = 0;
    10d8:	00060023          	sb	zero,0(a2)
        args_buffer_cur++;
    10dc:	00093503          	ld	a0,0(s2)
    while (*end)
    10e0:	00044783          	lbu	a5,0(s0)
        args_buffer_cur++;
    10e4:	0505                	addi	a0,a0,1
    10e6:	00a93023          	sd	a0,0(s2)
    while (*end)
    10ea:	fbc5                	bnez	a5,109a <parse_line+0x46>
        start = end;
    }
    argv[argc] = 0; // NULL terminate
    10ec:	003b1793          	slli	a5,s6,0x3
    10f0:	97d2                	add	a5,a5,s4
    10f2:	0007b023          	sd	zero,0(a5)
    
    if (argc == 0){
        return;
    }

    if (strcmp(argv[0], "exit") == 0) {
    10f6:	000a3503          	ld	a0,0(s4)
    10fa:	00001597          	auipc	a1,0x1
    10fe:	03658593          	addi	a1,a1,54 # 2130 <sharedmem+0x5e>
    1102:	131000ef          	jal	ra,1a32 <strcmp>
    1106:	e50d                	bnez	a0,1130 <parse_line+0xdc>
        exit(0);
    1108:	665000ef          	jal	ra,1f6c <exit>
            exit_pid = waitpid(pid, &xstate);
            assert(pid == exit_pid, -1);
            printf("Shell: Process %d exited with code %d\n", pid, xstate);
        }
    }
}
    110c:	60a6                	ld	ra,72(sp)
    110e:	6406                	ld	s0,64(sp)
    1110:	74e2                	ld	s1,56(sp)
    1112:	7942                	ld	s2,48(sp)
    1114:	79a2                	ld	s3,40(sp)
    1116:	7a02                	ld	s4,32(sp)
    1118:	6ae2                	ld	s5,24(sp)
    111a:	6b42                	ld	s6,16(sp)
    111c:	6161                	addi	sp,sp,80
    111e:	8082                	ret
    argv[argc] = 0; // NULL terminate
    1120:	003b1793          	slli	a5,s6,0x3
    1124:	97d2                	add	a5,a5,s4
    1126:	0007b023          	sd	zero,0(a5)
    if (argc == 0){
    112a:	fe0b01e3          	beqz	s6,110c <parse_line+0xb8>
    112e:	b7e1                	j	10f6 <parse_line+0xa2>
    } else if (strcmp(argv[0], "help") == 0) {
    1130:	000a3503          	ld	a0,0(s4)
    1134:	00001597          	auipc	a1,0x1
    1138:	00458593          	addi	a1,a1,4 # 2138 <sharedmem+0x66>
    113c:	0f7000ef          	jal	ra,1a32 <strcmp>
    1140:	c905                	beqz	a0,1170 <parse_line+0x11c>
    } else if (strcmp(argv[0], "cd") == 0) {
    1142:	000a3503          	ld	a0,0(s4)
    1146:	00001597          	auipc	a1,0x1
    114a:	ffa58593          	addi	a1,a1,-6 # 2140 <sharedmem+0x6e>
    114e:	0e5000ef          	jal	ra,1a32 <strcmp>
    1152:	e91d                	bnez	a0,1188 <parse_line+0x134>
        int err = chdir(argv[1]);
    1154:	008a3503          	ld	a0,8(s4)
    1158:	743000ef          	jal	ra,209a <chdir>
        if(err){
    115c:	d945                	beqz	a0,110c <parse_line+0xb8>
            printf("Shell: can not cd %s\n", argv[1]);
    115e:	008a3583          	ld	a1,8(s4)
    1162:	00001517          	auipc	a0,0x1
    1166:	fe650513          	addi	a0,a0,-26 # 2148 <sharedmem+0x76>
    116a:	2c2000ef          	jal	ra,142c <printf>
    116e:	bf79                	j	110c <parse_line+0xb8>
    printf(
    1170:	00001517          	auipc	a0,0x1
    1174:	f7050513          	addi	a0,a0,-144 # 20e0 <sharedmem+0xe>
    1178:	2b4000ef          	jal	ra,142c <printf>
}
    117c:	bf41                	j	110c <parse_line+0xb8>
    argv[argc] = 0; // NULL terminate
    117e:	00001797          	auipc	a5,0x1
    1182:	1407b523          	sd	zero,330(a5) # 22c8 <argv>
    if (argc == 0){
    1186:	b759                	j	110c <parse_line+0xb8>
        int pid = fork();
    1188:	67d000ef          	jal	ra,2004 <fork>
    118c:	842a                	mv	s0,a0
        if (pid == 0) {
    118e:	e115                	bnez	a0,11b2 <parse_line+0x15e>
            if (execv(argv[0], argv) < 0) {
    1190:	000a3503          	ld	a0,0(s4)
    1194:	00001597          	auipc	a1,0x1
    1198:	13458593          	addi	a1,a1,308 # 22c8 <argv>
    119c:	5b7000ef          	jal	ra,1f52 <execv>
    11a0:	02054d63          	bltz	a0,11da <parse_line+0x186>
            panic("unreachable!");
    11a4:	00001517          	auipc	a0,0x1
    11a8:	fdc50513          	addi	a0,a0,-36 # 2180 <sharedmem+0xae>
    11ac:	600000ef          	jal	ra,17ac <panic>
    11b0:	bfb1                	j	110c <parse_line+0xb8>
            exit_pid = waitpid(pid, &xstate);
    11b2:	006c                	addi	a1,sp,12
            int xstate = 0;
    11b4:	c602                	sw	zero,12(sp)
            exit_pid = waitpid(pid, &xstate);
    11b6:	61b000ef          	jal	ra,1fd0 <waitpid>
            assert(pid == exit_pid, -1);
    11ba:	40a40533          	sub	a0,s0,a0
    11be:	00153513          	seqz	a0,a0
    11c2:	55fd                	li	a1,-1
    11c4:	5fa000ef          	jal	ra,17be <assert>
            printf("Shell: Process %d exited with code %d\n", pid, xstate);
    11c8:	4632                	lw	a2,12(sp)
    11ca:	85a2                	mv	a1,s0
    11cc:	00001517          	auipc	a0,0x1
    11d0:	fc450513          	addi	a0,a0,-60 # 2190 <sharedmem+0xbe>
    11d4:	258000ef          	jal	ra,142c <printf>
    11d8:	bf15                	j	110c <parse_line+0xb8>
                printf("Shell: %s: No such file\n", argv[0]);
    11da:	000a3583          	ld	a1,0(s4)
    11de:	00001517          	auipc	a0,0x1
    11e2:	f8250513          	addi	a0,a0,-126 # 2160 <sharedmem+0x8e>
    11e6:	246000ef          	jal	ra,142c <printf>
                exit(-9);
    11ea:	555d                	li	a0,-9
    11ec:	581000ef          	jal	ra,1f6c <exit>
    11f0:	bf55                	j	11a4 <parse_line+0x150>

00000000000011f2 <main>:


int main() {
    11f2:	715d                	addi	sp,sp,-80

    if (open("console", O_RDWR) < 0) {
    11f4:	4589                	li	a1,2
    11f6:	00001517          	auipc	a0,0x1
    11fa:	fc250513          	addi	a0,a0,-62 # 21b8 <sharedmem+0xe6>
int main() {
    11fe:	e486                	sd	ra,72(sp)
    1200:	e0a2                	sd	s0,64(sp)
    1202:	fc26                	sd	s1,56(sp)
    1204:	f84a                	sd	s2,48(sp)
    1206:	f44e                	sd	s3,40(sp)
    1208:	f052                	sd	s4,32(sp)
    120a:	ec56                	sd	s5,24(sp)
    120c:	e85a                	sd	s6,16(sp)
    120e:	e45e                	sd	s7,8(sp)
    1210:	e062                	sd	s8,0(sp)
    if (open("console", O_RDWR) < 0) {
    1212:	591000ef          	jal	ra,1fa2 <open>
    1216:	12054563          	bltz	a0,1340 <main+0x14e>
        mknod("console", 1, 0);
        open("console", O_RDWR);
    }

    dup(0); // stdout
    121a:	4501                	li	a0,0
    121c:	59f000ef          	jal	ra,1fba <dup>
    dup(0); // stderr
    1220:	4501                	li	a0,0
    1222:	599000ef          	jal	ra,1fba <dup>

    if (open("cpu", O_RDWR) < 0) {
    1226:	4589                	li	a1,2
    1228:	00001517          	auipc	a0,0x1
    122c:	f9850513          	addi	a0,a0,-104 # 21c0 <sharedmem+0xee>
    1230:	573000ef          	jal	ra,1fa2 <open>
    1234:	14054863          	bltz	a0,1384 <main+0x192>
        mknod("cpu", 2, 0);
        // open("cpu", O_RDWR);
    }
        if (open("mem", O_RDWR) < 0) {
    1238:	4589                	li	a1,2
    123a:	00001517          	auipc	a0,0x1
    123e:	f8e50513          	addi	a0,a0,-114 # 21c8 <sharedmem+0xf6>
    1242:	561000ef          	jal	ra,1fa2 <open>
    1246:	12054663          	bltz	a0,1372 <main+0x180>
        mknod("mem", 3, 0);
        // open("mem", O_RDWR);
    }
    if (open("proc", O_RDWR) < 0) {
    124a:	4589                	li	a1,2
    124c:	00001517          	auipc	a0,0x1
    1250:	f8450513          	addi	a0,a0,-124 # 21d0 <sharedmem+0xfe>
    1254:	54f000ef          	jal	ra,1fa2 <open>
    1258:	10054463          	bltz	a0,1360 <main+0x16e>
        mknod("proc", 4, 0);
        // open("proc", O_RDWR);
    }
    printf("C user shell\n");
    125c:	00001517          	auipc	a0,0x1
    1260:	f7c50513          	addi	a0,a0,-132 # 21d8 <sharedmem+0x106>
    1264:	1c8000ef          	jal	ra,142c <printf>
    printf(">> ");
    1268:	00001517          	auipc	a0,0x1
    126c:	f8050513          	addi	a0,a0,-128 # 21e8 <sharedmem+0x116>
    1270:	1bc000ef          	jal	ra,142c <printf>
    1274:	00001917          	auipc	s2,0x1
    1278:	03c90913          	addi	s2,s2,60 # 22b0 <top>
    127c:	00001a97          	auipc	s5,0x1
    1280:	fb4a8a93          	addi	s5,s5,-76 # 2230 <line>
    while (1) {
        char c = getchar();
        switch (c) {
    1284:	44b5                	li	s1,13
            case LF:
            case CR:
                printf("\n");
    1286:	00001b97          	auipc	s7,0x1
    128a:	f6ab8b93          	addi	s7,s7,-150 # 21f0 <sharedmem+0x11e>
                    push('\0');
                    parse_line();

                    clear();
                }
                printf(">> ");
    128e:	00001b17          	auipc	s6,0x1
    1292:	f5ab0b13          	addi	s6,s6,-166 # 21e8 <sharedmem+0x116>
                break;
            case BS:
            case DL:
                if (!is_empty()) {
                    putchar(BS);
                    printf(" ");
    1296:	00001c17          	auipc	s8,0x1
    129a:	f62c0c13          	addi	s8,s8,-158 # 21f8 <sharedmem+0x126>
        switch (c) {
    129e:	07f00a13          	li	s4,127
    12a2:	49a9                	li	s3,10
        char c = getchar();
    12a4:	102000ef          	jal	ra,13a6 <getchar>
    12a8:	842a                	mv	s0,a0
        switch (c) {
    12aa:	0ff57513          	andi	a0,a0,255
    12ae:	00950963          	beq	a0,s1,12c0 <main+0xce>
    12b2:	02a4c963          	blt	s1,a0,12e4 <main+0xf2>
    12b6:	47a1                	li	a5,8
    12b8:	04f50463          	beq	a0,a5,1300 <main+0x10e>
    12bc:	03351663          	bne	a0,s3,12e8 <main+0xf6>
                printf("\n");
    12c0:	855e                	mv	a0,s7
    12c2:	16a000ef          	jal	ra,142c <printf>
    return top == 0;
    12c6:	00092783          	lw	a5,0(s2)
                if (!is_empty()) {
    12ca:	efa9                	bnez	a5,1324 <main+0x132>
                printf(">> ");
    12cc:	855a                	mv	a0,s6
    12ce:	15e000ef          	jal	ra,142c <printf>
        char c = getchar();
    12d2:	0d4000ef          	jal	ra,13a6 <getchar>
    12d6:	842a                	mv	s0,a0
        switch (c) {
    12d8:	0ff57513          	andi	a0,a0,255
    12dc:	fe9502e3          	beq	a0,s1,12c0 <main+0xce>
    12e0:	fca4dbe3          	bge	s1,a0,12b6 <main+0xc4>
    12e4:	01450e63          	beq	a0,s4,1300 <main+0x10e>
                    putchar(BS);
                    pop();
                }
                break;
            default:
                putchar(c);
    12e8:	0dc000ef          	jal	ra,13c4 <putchar>
    line[top++] = c;
    12ec:	00092783          	lw	a5,0(s2)
    12f0:	0017871b          	addiw	a4,a5,1
    12f4:	97d6                	add	a5,a5,s5
    12f6:	00e92023          	sw	a4,0(s2)
        char c = getchar();
    12fa:	00878023          	sb	s0,0(a5)
}
    12fe:	b75d                	j	12a4 <main+0xb2>
                if (!is_empty()) {
    1300:	00092783          	lw	a5,0(s2)
    1304:	d3c5                	beqz	a5,12a4 <main+0xb2>
                    putchar(BS);
    1306:	4521                	li	a0,8
    1308:	0bc000ef          	jal	ra,13c4 <putchar>
                    printf(" ");
    130c:	8562                	mv	a0,s8
    130e:	11e000ef          	jal	ra,142c <printf>
                    putchar(BS);
    1312:	4521                	li	a0,8
    1314:	0b0000ef          	jal	ra,13c4 <putchar>
    --top;
    1318:	00092783          	lw	a5,0(s2)
    131c:	37fd                	addiw	a5,a5,-1
    131e:	00f92023          	sw	a5,0(s2)
}
    1322:	b749                	j	12a4 <main+0xb2>
    line[top++] = c;
    1324:	0017871b          	addiw	a4,a5,1
    1328:	97d6                	add	a5,a5,s5
    132a:	00078023          	sb	zero,0(a5)
    132e:	00e92023          	sw	a4,0(s2)
                    parse_line();
    1332:	d23ff0ef          	jal	ra,1054 <parse_line>
    top = 0;
    1336:	00001797          	auipc	a5,0x1
    133a:	f607ad23          	sw	zero,-134(a5) # 22b0 <top>
}
    133e:	b779                	j	12cc <main+0xda>
        mknod("console", 1, 0);
    1340:	4585                	li	a1,1
    1342:	4601                	li	a2,0
    1344:	00001517          	auipc	a0,0x1
    1348:	e7450513          	addi	a0,a0,-396 # 21b8 <sharedmem+0xe6>
    134c:	463000ef          	jal	ra,1fae <mknod>
        open("console", O_RDWR);
    1350:	4589                	li	a1,2
    1352:	00001517          	auipc	a0,0x1
    1356:	e6650513          	addi	a0,a0,-410 # 21b8 <sharedmem+0xe6>
    135a:	449000ef          	jal	ra,1fa2 <open>
    135e:	bd75                	j	121a <main+0x28>
        mknod("proc", 4, 0);
    1360:	4601                	li	a2,0
    1362:	4591                	li	a1,4
    1364:	00001517          	auipc	a0,0x1
    1368:	e6c50513          	addi	a0,a0,-404 # 21d0 <sharedmem+0xfe>
    136c:	443000ef          	jal	ra,1fae <mknod>
    1370:	b5f5                	j	125c <main+0x6a>
        mknod("mem", 3, 0);
    1372:	4601                	li	a2,0
    1374:	458d                	li	a1,3
    1376:	00001517          	auipc	a0,0x1
    137a:	e5250513          	addi	a0,a0,-430 # 21c8 <sharedmem+0xf6>
    137e:	431000ef          	jal	ra,1fae <mknod>
    1382:	b5e1                	j	124a <main+0x58>
        mknod("cpu", 2, 0);
    1384:	4601                	li	a2,0
    1386:	4589                	li	a1,2
    1388:	00001517          	auipc	a0,0x1
    138c:	e3850513          	addi	a0,a0,-456 # 21c0 <sharedmem+0xee>
    1390:	41f000ef          	jal	ra,1fae <mknod>
    1394:	b555                	j	1238 <main+0x46>

0000000000001396 <__start_main>:
#include <ucore.h>

extern int main(int argc, char *argv[]);

void __start_main(int argc, char* argv[])
{
    1396:	1141                	addi	sp,sp,-16
    1398:	e406                	sd	ra,8(sp)
    exit(main(argc, argv));
    139a:	e59ff0ef          	jal	ra,11f2 <main>
}
    139e:	60a2                	ld	ra,8(sp)
    13a0:	0141                	addi	sp,sp,16
    exit(main(argc, argv));
    13a2:	3cb0006f          	j	1f6c <exit>

00000000000013a6 <getchar>:
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <ucore.h>

int getchar() {
    13a6:	1101                	addi	sp,sp,-32
    char byte = 0;
    read(stdin, &byte, 1);
    13a8:	00f10593          	addi	a1,sp,15
    13ac:	4605                	li	a2,1
    13ae:	4501                	li	a0,0
int getchar() {
    13b0:	ec06                	sd	ra,24(sp)
    char byte = 0;
    13b2:	000107a3          	sb	zero,15(sp)
    read(stdin, &byte, 1);
    13b6:	3c1000ef          	jal	ra,1f76 <read>
    return byte;
}
    13ba:	60e2                	ld	ra,24(sp)
    13bc:	00f14503          	lbu	a0,15(sp)
    13c0:	6105                	addi	sp,sp,32
    13c2:	8082                	ret

00000000000013c4 <putchar>:

int putchar(int c)
{
    13c4:	1141                	addi	sp,sp,-16
    13c6:	e406                	sd	ra,8(sp)
    13c8:	87aa                	mv	a5,a0
    static char put[2] = {0, 0};
    put[0] = c;
    13ca:	00001597          	auipc	a1,0x1
    13ce:	eee58593          	addi	a1,a1,-274 # 22b8 <put.1156>
    return write(stdout, put, 1);
    13d2:	4605                	li	a2,1
    13d4:	4505                	li	a0,1
    put[0] = c;
    13d6:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    13da:	3a7000ef          	jal	ra,1f80 <write>
}
    13de:	60a2                	ld	ra,8(sp)
    13e0:	2501                	sext.w	a0,a0
    13e2:	0141                	addi	sp,sp,16
    13e4:	8082                	ret

00000000000013e6 <puts>:

int puts(const char* s)
{
    13e6:	1141                	addi	sp,sp,-16
    13e8:	e022                	sd	s0,0(sp)
    13ea:	e406                	sd	ra,8(sp)
    13ec:	842a                	mv	s0,a0
    int r;
    r = -(write(stdout, (void*)s, strlen(s)) < 0 || putchar('\n') < 0);
    13ee:	6b6000ef          	jal	ra,1aa4 <strlen>
    13f2:	862a                	mv	a2,a0
    13f4:	85a2                	mv	a1,s0
    13f6:	4505                	li	a0,1
    13f8:	389000ef          	jal	ra,1f80 <write>
    13fc:	00055763          	bgez	a0,140a <puts+0x24>
    return r;
}
    1400:	60a2                	ld	ra,8(sp)
    1402:	6402                	ld	s0,0(sp)
    1404:	557d                	li	a0,-1
    1406:	0141                	addi	sp,sp,16
    1408:	8082                	ret
    put[0] = c;
    140a:	00001597          	auipc	a1,0x1
    140e:	eae58593          	addi	a1,a1,-338 # 22b8 <put.1156>
    1412:	47a9                	li	a5,10
    return write(stdout, put, 1);
    1414:	4605                	li	a2,1
    1416:	4505                	li	a0,1
    put[0] = c;
    1418:	00f58023          	sb	a5,0(a1)
    return write(stdout, put, 1);
    141c:	365000ef          	jal	ra,1f80 <write>
}
    1420:	60a2                	ld	ra,8(sp)
    1422:	6402                	ld	s0,0(sp)
    1424:	41f5551b          	sraiw	a0,a0,0x1f
    1428:	0141                	addi	sp,sp,16
    142a:	8082                	ret

000000000000142c <printf>:
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
}

// Print to the console. only understands %d, %x, %p, %s.
void printf(const char* fmt, ...) {
    142c:	7115                	addi	sp,sp,-224
    142e:	ed06                	sd	ra,152(sp)
    1430:	e922                	sd	s0,144(sp)
    1432:	e526                	sd	s1,136(sp)
    1434:	e14a                	sd	s2,128(sp)
    1436:	fcce                	sd	s3,120(sp)
    1438:	f8d2                	sd	s4,112(sp)
    143a:	f4d6                	sd	s5,104(sp)
    143c:	f0da                	sd	s6,96(sp)
    143e:	ecde                	sd	s7,88(sp)
    1440:	e8e2                	sd	s8,80(sp)
    1442:	e4e6                	sd	s9,72(sp)
    1444:	e0ea                	sd	s10,64(sp)
    1446:	fc6e                	sd	s11,56(sp)
    va_list ap;
    int i, c;
    char *s;

    va_start(ap, fmt);
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1448:	00054303          	lbu	t1,0(a0)
void printf(const char* fmt, ...) {
    144c:	e5be                	sd	a5,200(sp)
    va_start(ap, fmt);
    144e:	113c                	addi	a5,sp,168
void printf(const char* fmt, ...) {
    1450:	f52e                	sd	a1,168(sp)
    1452:	f932                	sd	a2,176(sp)
    1454:	fd36                	sd	a3,184(sp)
    1456:	e1ba                	sd	a4,192(sp)
    1458:	e9c2                	sd	a6,208(sp)
    145a:	edc6                	sd	a7,216(sp)
    va_start(ap, fmt);
    145c:	e43e                	sd	a5,8(sp)
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    145e:	0c030b63          	beqz	t1,1534 <printf+0x108>
    1462:	8aaa                	mv	s5,a0
    1464:	0003071b          	sext.w	a4,t1
    1468:	4481                	li	s1,0
        if (c != '%') {
    146a:	02500b93          	li	s7,37
    put[0] = c;
    146e:	00001417          	auipc	s0,0x1
    1472:	e4a40413          	addi	s0,s0,-438 # 22b8 <put.1156>
            continue;
        }
        c = fmt[++i] & 0xff;
        if (c == 0)
            break;
        switch (c) {
    1476:	4c51                	li	s8,20
    put[0] = c;
    1478:	02500c93          	li	s9,37
    147c:	00001a17          	auipc	s4,0x1
    1480:	2a4a0a13          	addi	s4,s4,676 # 2720 <args_buffer_cur+0x8>
    1484:	00001997          	auipc	s3,0x1
    1488:	2f498993          	addi	s3,s3,756 # 2778 <digits>
    148c:	01010b13          	addi	s6,sp,16
        if (c != '%') {
    1490:	0014879b          	addiw	a5,s1,1
    1494:	00fa8933          	add	s2,s5,a5
    1498:	13771163          	bne	a4,s7,15ba <printf+0x18e>
        c = fmt[++i] & 0xff;
    149c:	00094d03          	lbu	s10,0(s2)
        if (c == 0)
    14a0:	080d0a63          	beqz	s10,1534 <printf+0x108>
        switch (c) {
    14a4:	2489                	addiw	s1,s1,2
    14a6:	009a8933          	add	s2,s5,s1
    14aa:	257d0e63          	beq	s10,s7,1706 <printf+0x2da>
    14ae:	f9cd079b          	addiw	a5,s10,-100
    14b2:	0ff7f793          	andi	a5,a5,255
    14b6:	0cfc6263          	bltu	s8,a5,157a <printf+0x14e>
    14ba:	078a                	slli	a5,a5,0x2
    14bc:	97d2                	add	a5,a5,s4
    14be:	439c                	lw	a5,0(a5)
    14c0:	97d2                	add	a5,a5,s4
    14c2:	8782                	jr	a5
                break;
            case 'l':
                printint64(va_arg(ap, int64), 10, 1);
                break;
            case 'x':
                printint(va_arg(ap, int), 16, 1);
    14c4:	67a2                	ld	a5,8(sp)
    14c6:	4398                	lw	a4,0(a5)
    14c8:	07a1                	addi	a5,a5,8
    14ca:	e43e                	sd	a5,8(sp)
    14cc:	0ff77793          	andi	a5,a4,255
    if (sign && (sign = xx < 0))
    14d0:	26074663          	bltz	a4,173c <printf+0x310>
        buf[i++] = digits[x % base];
    14d4:	8bbd                	andi	a5,a5,15
    14d6:	97ce                	add	a5,a5,s3
    14d8:	0007c783          	lbu	a5,0(a5)
    } while ((x /= base) != 0);
    14dc:	40475d1b          	sraiw	s10,a4,0x4
    14e0:	00fd7d13          	andi	s10,s10,15
        buf[i++] = digits[x % base];
    14e4:	00f10823          	sb	a5,16(sp)
    } while ((x /= base) != 0);
    14e8:	020d0163          	beqz	s10,150a <printf+0xde>
        buf[i++] = digits[x % base];
    14ec:	9d4e                	add	s10,s10,s3
    14ee:	000d4783          	lbu	a5,0(s10)
    14f2:	4d05                	li	s10,1
    14f4:	00f108a3          	sb	a5,17(sp)
    if (sign)
    14f8:	00075963          	bgez	a4,150a <printf+0xde>
        buf[i++] = digits[x % base];
    14fc:	4d09                	li	s10,2
        buf[i++] = '-';
    14fe:	181c                	addi	a5,sp,48
    1500:	02d00713          	li	a4,45
    1504:	97ea                	add	a5,a5,s10
    1506:	fee78023          	sb	a4,-32(a5)
    while (--i >= 0)
    150a:	9d5a                	add	s10,s10,s6
    150c:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    1510:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1514:	4605                	li	a2,1
    1516:	1d7d                	addi	s10,s10,-1
    1518:	85a2                	mv	a1,s0
    151a:	4505                	li	a0,1
    put[0] = c;
    151c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1520:	261000ef          	jal	ra,1f80 <write>
    while (--i >= 0)
    1524:	ffbd16e3          	bne	s10,s11,1510 <printf+0xe4>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1528:	00094303          	lbu	t1,0(s2)
    152c:	0003071b          	sext.w	a4,t1
    1530:	f60310e3          	bnez	t1,1490 <printf+0x64>
                putchar(c);
                break;
        }
    }
    va_end(ap);
    1534:	60ea                	ld	ra,152(sp)
    1536:	644a                	ld	s0,144(sp)
    1538:	64aa                	ld	s1,136(sp)
    153a:	690a                	ld	s2,128(sp)
    153c:	79e6                	ld	s3,120(sp)
    153e:	7a46                	ld	s4,112(sp)
    1540:	7aa6                	ld	s5,104(sp)
    1542:	7b06                	ld	s6,96(sp)
    1544:	6be6                	ld	s7,88(sp)
    1546:	6c46                	ld	s8,80(sp)
    1548:	6ca6                	ld	s9,72(sp)
    154a:	6d06                	ld	s10,64(sp)
    154c:	7de2                	ld	s11,56(sp)
    154e:	612d                	addi	sp,sp,224
    1550:	8082                	ret
                if ((s = va_arg(ap, char *)) == 0)
    1552:	67a2                	ld	a5,8(sp)
    1554:	0007bd03          	ld	s10,0(a5)
    1558:	07a1                	addi	a5,a5,8
    155a:	e43e                	sd	a5,8(sp)
    155c:	000d1b63          	bnez	s10,1572 <printf+0x146>
    1560:	aafd                	j	175e <printf+0x332>
    return write(stdout, put, 1);
    1562:	4605                	li	a2,1
    1564:	85a2                	mv	a1,s0
    1566:	4505                	li	a0,1
                for (; *s; s++)
    1568:	0d05                	addi	s10,s10,1
    put[0] = c;
    156a:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    156e:	213000ef          	jal	ra,1f80 <write>
                for (; *s; s++)
    1572:	000d4783          	lbu	a5,0(s10)
    1576:	f7f5                	bnez	a5,1562 <printf+0x136>
    1578:	a02d                	j	15a2 <printf+0x176>
    return write(stdout, put, 1);
    157a:	4605                	li	a2,1
    157c:	00001597          	auipc	a1,0x1
    1580:	d3c58593          	addi	a1,a1,-708 # 22b8 <put.1156>
    1584:	4505                	li	a0,1
    put[0] = c;
    1586:	01940023          	sb	s9,0(s0)
    return write(stdout, put, 1);
    158a:	1f7000ef          	jal	ra,1f80 <write>
    158e:	4605                	li	a2,1
    1590:	00001597          	auipc	a1,0x1
    1594:	d2858593          	addi	a1,a1,-728 # 22b8 <put.1156>
    1598:	4505                	li	a0,1
    put[0] = c;
    159a:	01a40023          	sb	s10,0(s0)
    return write(stdout, put, 1);
    159e:	1e3000ef          	jal	ra,1f80 <write>
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    15a2:	00094303          	lbu	t1,0(s2)
    15a6:	0003071b          	sext.w	a4,t1
    15aa:	f80305e3          	beqz	t1,1534 <printf+0x108>
        if (c != '%') {
    15ae:	0014879b          	addiw	a5,s1,1
    15b2:	00fa8933          	add	s2,s5,a5
    15b6:	ef7703e3          	beq	a4,s7,149c <printf+0x70>
    return write(stdout, put, 1);
    15ba:	4605                	li	a2,1
    15bc:	00001597          	auipc	a1,0x1
    15c0:	cfc58593          	addi	a1,a1,-772 # 22b8 <put.1156>
    15c4:	4505                	li	a0,1
    put[0] = c;
    15c6:	00640023          	sb	t1,0(s0)
            continue;
    15ca:	84be                	mv	s1,a5
    return write(stdout, put, 1);
    15cc:	1b5000ef          	jal	ra,1f80 <write>
            continue;
    15d0:	bfc9                	j	15a2 <printf+0x176>
                printint64(va_arg(ap, int64), 10, 1);
    15d2:	67a2                	ld	a5,8(sp)
        buf[i++] = digits[x % base];
    15d4:	4681                	li	a3,0
        buf[i++] = digits[x % base];
    15d6:	4629                	li	a2,10
                printint64(va_arg(ap, int64), 10, 1);
    15d8:	0007b883          	ld	a7,0(a5)
    15dc:	07a1                	addi	a5,a5,8
    15de:	e43e                	sd	a5,8(sp)
        x = -xx;
    15e0:	43f8d713          	srai	a4,a7,0x3f
    15e4:	011747b3          	xor	a5,a4,a7
    15e8:	8f99                	sub	a5,a5,a4
    } while ((x /= base) != 0);
    15ea:	4825                	li	a6,9
        buf[i++] = digits[x % base];
    15ec:	02c7f733          	remu	a4,a5,a2
    15f0:	8d36                	mv	s10,a3
    15f2:	0685                	addi	a3,a3,1
    15f4:	00db0533          	add	a0,s6,a3
    15f8:	85be                	mv	a1,a5
    15fa:	974e                	add	a4,a4,s3
    15fc:	00074703          	lbu	a4,0(a4)
    } while ((x /= base) != 0);
    1600:	02c7d7b3          	divu	a5,a5,a2
        buf[i++] = digits[x % base];
    1604:	fee50fa3          	sb	a4,-1(a0)
    } while ((x /= base) != 0);
    1608:	feb862e3          	bltu	a6,a1,15ec <printf+0x1c0>
    if (sign)
    160c:	1208c063          	bltz	a7,172c <printf+0x300>
    while (--i >= 0)
    1610:	9d5a                	add	s10,s10,s6
    put[0] = c;
    1612:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    1616:	4605                	li	a2,1
    1618:	85a2                	mv	a1,s0
    161a:	4505                	li	a0,1
    put[0] = c;
    161c:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1620:	161000ef          	jal	ra,1f80 <write>
    while (--i >= 0)
    1624:	87ea                	mv	a5,s10
    1626:	1d7d                	addi	s10,s10,-1
    1628:	fefb15e3          	bne	s6,a5,1612 <printf+0x1e6>
    162c:	bf9d                	j	15a2 <printf+0x176>
                printptr(va_arg(ap, uint64));
    162e:	67a2                	ld	a5,8(sp)
    return write(stdout, put, 1);
    1630:	4605                	li	a2,1
    1632:	00001597          	auipc	a1,0x1
    1636:	c8658593          	addi	a1,a1,-890 # 22b8 <put.1156>
                printptr(va_arg(ap, uint64));
    163a:	0007bd83          	ld	s11,0(a5)
    163e:	00878713          	addi	a4,a5,8
    return write(stdout, put, 1);
    1642:	4505                	li	a0,1
    put[0] = c;
    1644:	03000793          	li	a5,48
    1648:	00f40023          	sb	a5,0(s0)
                printptr(va_arg(ap, uint64));
    164c:	e43a                	sd	a4,8(sp)
    return write(stdout, put, 1);
    164e:	133000ef          	jal	ra,1f80 <write>
    put[0] = c;
    1652:	07800793          	li	a5,120
    return write(stdout, put, 1);
    1656:	4605                	li	a2,1
    1658:	00001597          	auipc	a1,0x1
    165c:	c6058593          	addi	a1,a1,-928 # 22b8 <put.1156>
    1660:	4505                	li	a0,1
    put[0] = c;
    1662:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    1666:	4d41                	li	s10,16
    1668:	119000ef          	jal	ra,1f80 <write>
        putchar(digits[x >> (sizeof(uint64) * 8 - 4)]);
    166c:	03cdd793          	srli	a5,s11,0x3c
    1670:	97ce                	add	a5,a5,s3
    put[0] = c;
    1672:	0007c783          	lbu	a5,0(a5)
    1676:	3d7d                	addiw	s10,s10,-1
    return write(stdout, put, 1);
    1678:	4605                	li	a2,1
    167a:	85a2                	mv	a1,s0
    167c:	4505                	li	a0,1
    put[0] = c;
    167e:	00f40023          	sb	a5,0(s0)
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1682:	0d92                	slli	s11,s11,0x4
    return write(stdout, put, 1);
    1684:	0fd000ef          	jal	ra,1f80 <write>
    for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1688:	fe0d12e3          	bnez	s10,166c <printf+0x240>
    168c:	bf19                	j	15a2 <printf+0x176>
                printint(va_arg(ap, int), 10, 1);
    168e:	67a2                	ld	a5,8(sp)
    1690:	4394                	lw	a3,0(a5)
    1692:	07a1                	addi	a5,a5,8
    1694:	e43e                	sd	a5,8(sp)
    1696:	0ff6f793          	andi	a5,a3,255
    if (sign && (sign = xx < 0))
    169a:	0006d663          	bgez	a3,16a6 <printf+0x27a>
        x = -xx;
    169e:	40f007bb          	negw	a5,a5
    16a2:	0ff7f793          	andi	a5,a5,255
        buf[i++] = digits[x % base];
    16a6:	4729                	li	a4,10
    16a8:	02e7e63b          	remw	a2,a5,a4
    } while ((x /= base) != 0);
    16ac:	02e7cd3b          	divw	s10,a5,a4
        buf[i++] = digits[x % base];
    16b0:	964e                	add	a2,a2,s3
    16b2:	00064603          	lbu	a2,0(a2)
    16b6:	00c10823          	sb	a2,16(sp)
    } while ((x /= base) != 0);
    16ba:	0a0d0963          	beqz	s10,176c <printf+0x340>
        buf[i++] = digits[x % base];
    16be:	02ed663b          	remw	a2,s10,a4
    } while ((x /= base) != 0);
    16c2:	02ed47bb          	divw	a5,s10,a4
        buf[i++] = digits[x % base];
    16c6:	00c98733          	add	a4,s3,a2
    16ca:	00074703          	lbu	a4,0(a4)
    16ce:	00e108a3          	sb	a4,17(sp)
    } while ((x /= base) != 0);
    16d2:	c3cd                	beqz	a5,1774 <printf+0x348>
        buf[i++] = digits[x % base];
    16d4:	97ce                	add	a5,a5,s3
    16d6:	0007c703          	lbu	a4,0(a5)
    16da:	4d09                	li	s10,2
    16dc:	478d                	li	a5,3
    16de:	00e10923          	sb	a4,18(sp)
    if (sign)
    16e2:	0206cd63          	bltz	a3,171c <printf+0x2f0>
    while (--i >= 0)
    16e6:	9d5a                	add	s10,s10,s6
    16e8:	00f10d93          	addi	s11,sp,15
    put[0] = c;
    16ec:	000d4783          	lbu	a5,0(s10)
    return write(stdout, put, 1);
    16f0:	4605                	li	a2,1
    16f2:	1d7d                	addi	s10,s10,-1
    16f4:	85a2                	mv	a1,s0
    16f6:	4505                	li	a0,1
    put[0] = c;
    16f8:	00f40023          	sb	a5,0(s0)
    return write(stdout, put, 1);
    16fc:	085000ef          	jal	ra,1f80 <write>
    while (--i >= 0)
    1700:	ffbd16e3          	bne	s10,s11,16ec <printf+0x2c0>
    1704:	bd79                	j	15a2 <printf+0x176>
    return write(stdout, put, 1);
    1706:	4605                	li	a2,1
    1708:	00001597          	auipc	a1,0x1
    170c:	bb058593          	addi	a1,a1,-1104 # 22b8 <put.1156>
    1710:	4505                	li	a0,1
    put[0] = c;
    1712:	01740023          	sb	s7,0(s0)
    return write(stdout, put, 1);
    1716:	06b000ef          	jal	ra,1f80 <write>
    171a:	b561                	j	15a2 <printf+0x176>
        buf[i++] = '-';
    171c:	1818                	addi	a4,sp,48
    171e:	973e                	add	a4,a4,a5
    1720:	02d00693          	li	a3,45
    1724:	fed70023          	sb	a3,-32(a4)
        buf[i++] = digits[x % base];
    1728:	8d3e                	mv	s10,a5
    172a:	bf75                	j	16e6 <printf+0x2ba>
        buf[i++] = '-';
    172c:	181c                	addi	a5,sp,48
    172e:	97b6                	add	a5,a5,a3
    1730:	02d00713          	li	a4,45
    1734:	fee78023          	sb	a4,-32(a5)
        buf[i++] = digits[x % base];
    1738:	8d36                	mv	s10,a3
    173a:	bdd9                	j	1610 <printf+0x1e4>
        x = -xx;
    173c:	40f007bb          	negw	a5,a5
        buf[i++] = digits[x % base];
    1740:	00f7f693          	andi	a3,a5,15
    1744:	96ce                	add	a3,a3,s3
    1746:	0006c683          	lbu	a3,0(a3)
        x = -xx;
    174a:	0ff7fd13          	andi	s10,a5,255
    } while ((x /= base) != 0);
    174e:	004d5d13          	srli	s10,s10,0x4
        buf[i++] = digits[x % base];
    1752:	00d10823          	sb	a3,16(sp)
    } while ((x /= base) != 0);
    1756:	d80d1be3          	bnez	s10,14ec <printf+0xc0>
        buf[i++] = digits[x % base];
    175a:	4d05                	li	s10,1
    175c:	b34d                	j	14fe <printf+0xd2>
                s = "(null)";
    175e:	00001d17          	auipc	s10,0x1
    1762:	aa2d0d13          	addi	s10,s10,-1374 # 2200 <sharedmem+0x12e>
                for (; *s; s++)
    1766:	02800793          	li	a5,40
    176a:	bbe5                	j	1562 <printf+0x136>
        buf[i++] = digits[x % base];
    176c:	4785                	li	a5,1
    if (sign)
    176e:	f606dce3          	bgez	a3,16e6 <printf+0x2ba>
    1772:	b76d                	j	171c <printf+0x2f0>
        buf[i++] = digits[x % base];
    1774:	4789                	li	a5,2
    1776:	4d05                	li	s10,1
    if (sign)
    1778:	f606d7e3          	bgez	a3,16e6 <printf+0x2ba>
    177c:	b745                	j	171c <printf+0x2f0>

000000000000177e <srand>:
#include <ucore.h>

static uint64 seed;

void srand(unsigned s) {
    seed = s - 1;
    177e:	357d                	addiw	a0,a0,-1
    1780:	1502                	slli	a0,a0,0x20
    1782:	9101                	srli	a0,a0,0x20
    1784:	00001797          	auipc	a5,0x1
    1788:	b2a7be23          	sd	a0,-1220(a5) # 22c0 <seed>
}
    178c:	8082                	ret

000000000000178e <rand>:

int rand(void) {
    seed = 6364136223846793005ULL * seed + 1;
    178e:	00001797          	auipc	a5,0x1
    1792:	b3278793          	addi	a5,a5,-1230 # 22c0 <seed>
    1796:	6388                	ld	a0,0(a5)
    1798:	00001717          	auipc	a4,0x1
    179c:	a7873703          	ld	a4,-1416(a4) # 2210 <LF+0x6>
    17a0:	02e50533          	mul	a0,a0,a4
    17a4:	0505                	addi	a0,a0,1
    17a6:	e388                	sd	a0,0(a5)
    return seed >> 33;
}
    17a8:	9105                	srli	a0,a0,0x21
    17aa:	8082                	ret

00000000000017ac <panic>:

void panic(char* m) {
    17ac:	1141                	addi	sp,sp,-16
    17ae:	e406                	sd	ra,8(sp)
    puts(m);
    17b0:	c37ff0ef          	jal	ra,13e6 <puts>
    exit(-100);
}
    17b4:	60a2                	ld	ra,8(sp)
    exit(-100);
    17b6:	f9c00513          	li	a0,-100
}
    17ba:	0141                	addi	sp,sp,16
    exit(-100);
    17bc:	af45                	j	1f6c <exit>

00000000000017be <assert>:

void assert(int f, int code) {
    if(!f) {
    17be:	c111                	beqz	a0,17c2 <assert+0x4>
        exit(code);
    }
    17c0:	8082                	ret
        exit(code);
    17c2:	852e                	mv	a0,a1
    17c4:	a765                	j	1f6c <exit>

00000000000017c6 <isspace>:
#define HIGHS      (ONES * (UCHAR_MAX / 2 + 1))
#define HASZERO(x) (((x)-ONES) & ~(x) & HIGHS)

int isspace(int c)
{
    return c == ' ' || (unsigned)c - '\t' < 5;
    17c6:	02000793          	li	a5,32
    17ca:	00f50663          	beq	a0,a5,17d6 <isspace+0x10>
    17ce:	355d                	addiw	a0,a0,-9
    17d0:	00553513          	sltiu	a0,a0,5
    17d4:	8082                	ret
    17d6:	4505                	li	a0,1
}
    17d8:	8082                	ret

00000000000017da <isdigit>:

int isdigit(int c)
{
    return (unsigned)c - '0' < 10;
    17da:	fd05051b          	addiw	a0,a0,-48
}
    17de:	00a53513          	sltiu	a0,a0,10
    17e2:	8082                	ret

00000000000017e4 <atoi>:
    return c == ' ' || (unsigned)c - '\t' < 5;
    17e4:	02000613          	li	a2,32
    17e8:	4591                	li	a1,4

int atoi(const char* s)
{
    int n = 0, neg = 0;
    while (isspace(*s))
    17ea:	00054703          	lbu	a4,0(a0)
    return c == ' ' || (unsigned)c - '\t' < 5;
    17ee:	ff77069b          	addiw	a3,a4,-9
    17f2:	04c70d63          	beq	a4,a2,184c <atoi+0x68>
    17f6:	0007079b          	sext.w	a5,a4
    17fa:	04d5f963          	bgeu	a1,a3,184c <atoi+0x68>
        s++;
    switch (*s) {
    17fe:	02b00693          	li	a3,43
    1802:	04d70a63          	beq	a4,a3,1856 <atoi+0x72>
    1806:	02d00693          	li	a3,45
    180a:	06d70463          	beq	a4,a3,1872 <atoi+0x8e>
        neg = 1;
    case '+':
        s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
    180e:	fd07859b          	addiw	a1,a5,-48
    1812:	4625                	li	a2,9
    1814:	873e                	mv	a4,a5
    1816:	86aa                	mv	a3,a0
    int n = 0, neg = 0;
    1818:	4e01                	li	t3,0
    while (isdigit(*s))
    181a:	04b66a63          	bltu	a2,a1,186e <atoi+0x8a>
    int n = 0, neg = 0;
    181e:	4501                	li	a0,0
    while (isdigit(*s))
    1820:	4825                	li	a6,9
    1822:	0016c603          	lbu	a2,1(a3)
        n = 10 * n - (*s++ - '0');
    1826:	0025179b          	slliw	a5,a0,0x2
    182a:	9d3d                	addw	a0,a0,a5
    182c:	fd07031b          	addiw	t1,a4,-48
    1830:	0015189b          	slliw	a7,a0,0x1
    while (isdigit(*s))
    1834:	fd06059b          	addiw	a1,a2,-48
        n = 10 * n - (*s++ - '0');
    1838:	0685                	addi	a3,a3,1
    183a:	4068853b          	subw	a0,a7,t1
    while (isdigit(*s))
    183e:	0006071b          	sext.w	a4,a2
    1842:	feb870e3          	bgeu	a6,a1,1822 <atoi+0x3e>
    return neg ? n : -n;
    1846:	000e0563          	beqz	t3,1850 <atoi+0x6c>
}
    184a:	8082                	ret
        s++;
    184c:	0505                	addi	a0,a0,1
    184e:	bf71                	j	17ea <atoi+0x6>
    1850:	4113053b          	subw	a0,t1,a7
    1854:	8082                	ret
    while (isdigit(*s))
    1856:	00154783          	lbu	a5,1(a0)
    185a:	4625                	li	a2,9
        s++;
    185c:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    1860:	fd07859b          	addiw	a1,a5,-48
    1864:	0007871b          	sext.w	a4,a5
    int n = 0, neg = 0;
    1868:	4e01                	li	t3,0
    while (isdigit(*s))
    186a:	fab67ae3          	bgeu	a2,a1,181e <atoi+0x3a>
    186e:	4501                	li	a0,0
}
    1870:	8082                	ret
    while (isdigit(*s))
    1872:	00154783          	lbu	a5,1(a0)
    1876:	4625                	li	a2,9
        s++;
    1878:	00150693          	addi	a3,a0,1
    while (isdigit(*s))
    187c:	fd07859b          	addiw	a1,a5,-48
    1880:	0007871b          	sext.w	a4,a5
    1884:	feb665e3          	bltu	a2,a1,186e <atoi+0x8a>
        neg = 1;
    1888:	4e05                	li	t3,1
    188a:	bf51                	j	181e <atoi+0x3a>

000000000000188c <memset>:

void* memset(void* dest, int c, size_t n)
{
    char* p = dest;
    for(int i = 0; i < n; ++i, *(p++) = c);
    188c:	16060d63          	beqz	a2,1a06 <memset+0x17a>
    1890:	40a007b3          	neg	a5,a0
    1894:	8b9d                	andi	a5,a5,7
    1896:	00778713          	addi	a4,a5,7
    189a:	482d                	li	a6,11
    189c:	0ff5f593          	andi	a1,a1,255
    18a0:	fff60693          	addi	a3,a2,-1
    18a4:	17076263          	bltu	a4,a6,1a08 <memset+0x17c>
    18a8:	16e6ea63          	bltu	a3,a4,1a1c <memset+0x190>
    18ac:	16078563          	beqz	a5,1a16 <memset+0x18a>
    18b0:	00b50023          	sb	a1,0(a0)
    18b4:	4705                	li	a4,1
    18b6:	00150e93          	addi	t4,a0,1
    18ba:	14e78c63          	beq	a5,a4,1a12 <memset+0x186>
    18be:	00b500a3          	sb	a1,1(a0)
    18c2:	4709                	li	a4,2
    18c4:	00250e93          	addi	t4,a0,2
    18c8:	14e78d63          	beq	a5,a4,1a22 <memset+0x196>
    18cc:	00b50123          	sb	a1,2(a0)
    18d0:	470d                	li	a4,3
    18d2:	00350e93          	addi	t4,a0,3
    18d6:	12e78b63          	beq	a5,a4,1a0c <memset+0x180>
    18da:	00b501a3          	sb	a1,3(a0)
    18de:	4711                	li	a4,4
    18e0:	00450e93          	addi	t4,a0,4
    18e4:	14e78163          	beq	a5,a4,1a26 <memset+0x19a>
    18e8:	00b50223          	sb	a1,4(a0)
    18ec:	4715                	li	a4,5
    18ee:	00550e93          	addi	t4,a0,5
    18f2:	12e78c63          	beq	a5,a4,1a2a <memset+0x19e>
    18f6:	00b502a3          	sb	a1,5(a0)
    18fa:	471d                	li	a4,7
    18fc:	00650e93          	addi	t4,a0,6
    1900:	12e79763          	bne	a5,a4,1a2e <memset+0x1a2>
    1904:	00750e93          	addi	t4,a0,7
    1908:	00b50323          	sb	a1,6(a0)
    190c:	4f1d                	li	t5,7
    190e:	00859713          	slli	a4,a1,0x8
    1912:	8f4d                	or	a4,a4,a1
    1914:	01059e13          	slli	t3,a1,0x10
    1918:	01c76e33          	or	t3,a4,t3
    191c:	01859313          	slli	t1,a1,0x18
    1920:	006e6333          	or	t1,t3,t1
    1924:	02059893          	slli	a7,a1,0x20
    1928:	011368b3          	or	a7,t1,a7
    192c:	02859813          	slli	a6,a1,0x28
    1930:	40f60333          	sub	t1,a2,a5
    1934:	0108e833          	or	a6,a7,a6
    1938:	03059693          	slli	a3,a1,0x30
    193c:	00d866b3          	or	a3,a6,a3
    1940:	03859713          	slli	a4,a1,0x38
    1944:	97aa                	add	a5,a5,a0
    1946:	ff837813          	andi	a6,t1,-8
    194a:	8f55                	or	a4,a4,a3
    194c:	00f806b3          	add	a3,a6,a5
    1950:	e398                	sd	a4,0(a5)
    1952:	07a1                	addi	a5,a5,8
    1954:	fed79ee3          	bne	a5,a3,1950 <memset+0xc4>
    1958:	ff837693          	andi	a3,t1,-8
    195c:	00de87b3          	add	a5,t4,a3
    1960:	01e6873b          	addw	a4,a3,t5
    1964:	0ad30663          	beq	t1,a3,1a10 <memset+0x184>
    1968:	00b78023          	sb	a1,0(a5)
    196c:	0017069b          	addiw	a3,a4,1
    1970:	08c6fb63          	bgeu	a3,a2,1a06 <memset+0x17a>
    1974:	00b780a3          	sb	a1,1(a5)
    1978:	0027069b          	addiw	a3,a4,2
    197c:	08c6f563          	bgeu	a3,a2,1a06 <memset+0x17a>
    1980:	00b78123          	sb	a1,2(a5)
    1984:	0037069b          	addiw	a3,a4,3
    1988:	06c6ff63          	bgeu	a3,a2,1a06 <memset+0x17a>
    198c:	00b781a3          	sb	a1,3(a5)
    1990:	0047069b          	addiw	a3,a4,4
    1994:	06c6f963          	bgeu	a3,a2,1a06 <memset+0x17a>
    1998:	00b78223          	sb	a1,4(a5)
    199c:	0057069b          	addiw	a3,a4,5
    19a0:	06c6f363          	bgeu	a3,a2,1a06 <memset+0x17a>
    19a4:	00b782a3          	sb	a1,5(a5)
    19a8:	0067069b          	addiw	a3,a4,6
    19ac:	04c6fd63          	bgeu	a3,a2,1a06 <memset+0x17a>
    19b0:	00b78323          	sb	a1,6(a5)
    19b4:	0077069b          	addiw	a3,a4,7
    19b8:	04c6f763          	bgeu	a3,a2,1a06 <memset+0x17a>
    19bc:	00b783a3          	sb	a1,7(a5)
    19c0:	0087069b          	addiw	a3,a4,8
    19c4:	04c6f163          	bgeu	a3,a2,1a06 <memset+0x17a>
    19c8:	00b78423          	sb	a1,8(a5)
    19cc:	0097069b          	addiw	a3,a4,9
    19d0:	02c6fb63          	bgeu	a3,a2,1a06 <memset+0x17a>
    19d4:	00b784a3          	sb	a1,9(a5)
    19d8:	00a7069b          	addiw	a3,a4,10
    19dc:	02c6f563          	bgeu	a3,a2,1a06 <memset+0x17a>
    19e0:	00b78523          	sb	a1,10(a5)
    19e4:	00b7069b          	addiw	a3,a4,11
    19e8:	00c6ff63          	bgeu	a3,a2,1a06 <memset+0x17a>
    19ec:	00b785a3          	sb	a1,11(a5)
    19f0:	00c7069b          	addiw	a3,a4,12
    19f4:	00c6f963          	bgeu	a3,a2,1a06 <memset+0x17a>
    19f8:	00b78623          	sb	a1,12(a5)
    19fc:	2735                	addiw	a4,a4,13
    19fe:	00c77463          	bgeu	a4,a2,1a06 <memset+0x17a>
    1a02:	00b786a3          	sb	a1,13(a5)
    return dest;
}
    1a06:	8082                	ret
    1a08:	472d                	li	a4,11
    1a0a:	bd79                	j	18a8 <memset+0x1c>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1a0c:	4f0d                	li	t5,3
    1a0e:	b701                	j	190e <memset+0x82>
    1a10:	8082                	ret
    1a12:	4f05                	li	t5,1
    1a14:	bded                	j	190e <memset+0x82>
    1a16:	8eaa                	mv	t4,a0
    1a18:	4f01                	li	t5,0
    1a1a:	bdd5                	j	190e <memset+0x82>
    1a1c:	87aa                	mv	a5,a0
    1a1e:	4701                	li	a4,0
    1a20:	b7a1                	j	1968 <memset+0xdc>
    1a22:	4f09                	li	t5,2
    1a24:	b5ed                	j	190e <memset+0x82>
    1a26:	4f11                	li	t5,4
    1a28:	b5dd                	j	190e <memset+0x82>
    1a2a:	4f15                	li	t5,5
    1a2c:	b5cd                	j	190e <memset+0x82>
    1a2e:	4f19                	li	t5,6
    1a30:	bdf9                	j	190e <memset+0x82>

0000000000001a32 <strcmp>:

int strcmp(const char* l, const char* r)
{
    for (; *l == *r && *l; l++, r++)
    1a32:	00054783          	lbu	a5,0(a0)
    1a36:	0005c703          	lbu	a4,0(a1)
    1a3a:	00e79863          	bne	a5,a4,1a4a <strcmp+0x18>
    1a3e:	0505                	addi	a0,a0,1
    1a40:	0585                	addi	a1,a1,1
    1a42:	fbe5                	bnez	a5,1a32 <strcmp>
    1a44:	4501                	li	a0,0
        ;
    return *(unsigned char*)l - *(unsigned char*)r;
}
    1a46:	9d19                	subw	a0,a0,a4
    1a48:	8082                	ret
    1a4a:	0007851b          	sext.w	a0,a5
    1a4e:	bfe5                	j	1a46 <strcmp+0x14>

0000000000001a50 <strcpy>:
char * strcpy(char *s, const char *t) {
    char *os;

    os = s;
    while ((*s++ = *t++) != 0)
    1a50:	87aa                	mv	a5,a0
    1a52:	0005c703          	lbu	a4,0(a1)
    1a56:	0785                	addi	a5,a5,1
    1a58:	0585                	addi	a1,a1,1
    1a5a:	fee78fa3          	sb	a4,-1(a5)
    1a5e:	fb75                	bnez	a4,1a52 <strcpy+0x2>
        ;
    return os;
}
    1a60:	8082                	ret

0000000000001a62 <strncmp>:
int strncmp(const char* _l, const char* _r, size_t n)
{
    const unsigned char *l = (void*)_l, *r = (void*)_r;
    if (!n--)
    1a62:	ce05                	beqz	a2,1a9a <strncmp+0x38>
        return 0;
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1a64:	00054703          	lbu	a4,0(a0)
    1a68:	0005c783          	lbu	a5,0(a1)
    1a6c:	cb0d                	beqz	a4,1a9e <strncmp+0x3c>
    if (!n--)
    1a6e:	167d                	addi	a2,a2,-1
    1a70:	00c506b3          	add	a3,a0,a2
    1a74:	a819                	j	1a8a <strncmp+0x28>
    for (; *l && *r && n && *l == *r; l++, r++, n--)
    1a76:	00a68e63          	beq	a3,a0,1a92 <strncmp+0x30>
    1a7a:	0505                	addi	a0,a0,1
    1a7c:	00e79b63          	bne	a5,a4,1a92 <strncmp+0x30>
    1a80:	00054703          	lbu	a4,0(a0)
    1a84:	0005c783          	lbu	a5,0(a1)
    1a88:	cb19                	beqz	a4,1a9e <strncmp+0x3c>
    1a8a:	0005c783          	lbu	a5,0(a1)
    1a8e:	0585                	addi	a1,a1,1
    1a90:	f3fd                	bnez	a5,1a76 <strncmp+0x14>
        ;
    return *l - *r;
    1a92:	0007051b          	sext.w	a0,a4
    1a96:	9d1d                	subw	a0,a0,a5
    1a98:	8082                	ret
        return 0;
    1a9a:	4501                	li	a0,0
}
    1a9c:	8082                	ret
    1a9e:	4501                	li	a0,0
    return *l - *r;
    1aa0:	9d1d                	subw	a0,a0,a5
    1aa2:	8082                	ret

0000000000001aa4 <strlen>:
size_t strlen(const char* s)
{
    const char* a = s;
    typedef size_t __attribute__((__may_alias__)) word;
    const word* w;
    for (; (uintptr_t)s % SS; s++)
    1aa4:	00757793          	andi	a5,a0,7
    1aa8:	cf89                	beqz	a5,1ac2 <strlen+0x1e>
    1aaa:	87aa                	mv	a5,a0
    1aac:	a029                	j	1ab6 <strlen+0x12>
    1aae:	0785                	addi	a5,a5,1
    1ab0:	0077f713          	andi	a4,a5,7
    1ab4:	cb01                	beqz	a4,1ac4 <strlen+0x20>
        if (!*s)
    1ab6:	0007c703          	lbu	a4,0(a5)
    1aba:	fb75                	bnez	a4,1aae <strlen+0xa>
    for (w = (const void*)s; !HASZERO(*w); w++)
        ;
    s = (const void*)w;
    for (; *s; s++)
        ;
    return s - a;
    1abc:	40a78533          	sub	a0,a5,a0
}
    1ac0:	8082                	ret
    for (; (uintptr_t)s % SS; s++)
    1ac2:	87aa                	mv	a5,a0
    for (w = (const void*)s; !HASZERO(*w); w++)
    1ac4:	6394                	ld	a3,0(a5)
    1ac6:	00000597          	auipc	a1,0x0
    1aca:	7525b583          	ld	a1,1874(a1) # 2218 <LF+0xe>
    1ace:	00000617          	auipc	a2,0x0
    1ad2:	75263603          	ld	a2,1874(a2) # 2220 <LF+0x16>
    1ad6:	a019                	j	1adc <strlen+0x38>
    1ad8:	6794                	ld	a3,8(a5)
    1ada:	07a1                	addi	a5,a5,8
    1adc:	00b68733          	add	a4,a3,a1
    1ae0:	fff6c693          	not	a3,a3
    1ae4:	8f75                	and	a4,a4,a3
    1ae6:	8f71                	and	a4,a4,a2
    1ae8:	db65                	beqz	a4,1ad8 <strlen+0x34>
    for (; *s; s++)
    1aea:	0007c703          	lbu	a4,0(a5)
    1aee:	d779                	beqz	a4,1abc <strlen+0x18>
    1af0:	0017c703          	lbu	a4,1(a5)
    1af4:	0785                	addi	a5,a5,1
    1af6:	d379                	beqz	a4,1abc <strlen+0x18>
    1af8:	0017c703          	lbu	a4,1(a5)
    1afc:	0785                	addi	a5,a5,1
    1afe:	fb6d                	bnez	a4,1af0 <strlen+0x4c>
    1b00:	bf75                	j	1abc <strlen+0x18>

0000000000001b02 <memchr>:

void* memchr(const void* src, int c, size_t n)
{
    const unsigned char* s = src;
    c = (unsigned char)c;
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1b02:	00757713          	andi	a4,a0,7
{
    1b06:	87aa                	mv	a5,a0
    c = (unsigned char)c;
    1b08:	0ff5f593          	andi	a1,a1,255
    for (; ((uintptr_t)s & ALIGN) && n && *s != c; s++, n--)
    1b0c:	cb19                	beqz	a4,1b22 <memchr+0x20>
    1b0e:	ce25                	beqz	a2,1b86 <memchr+0x84>
    1b10:	0007c703          	lbu	a4,0(a5)
    1b14:	04b70e63          	beq	a4,a1,1b70 <memchr+0x6e>
    1b18:	0785                	addi	a5,a5,1
    1b1a:	0077f713          	andi	a4,a5,7
    1b1e:	167d                	addi	a2,a2,-1
    1b20:	f77d                	bnez	a4,1b0e <memchr+0xc>
            ;
        s = (const void*)w;
    }
    for (; n && *s != c; s++, n--)
        ;
    return n ? (void*)s : 0;
    1b22:	4501                	li	a0,0
    if (n && *s != c) {
    1b24:	c235                	beqz	a2,1b88 <memchr+0x86>
    1b26:	0007c703          	lbu	a4,0(a5)
    1b2a:	04b70363          	beq	a4,a1,1b70 <memchr+0x6e>
        size_t k = ONES * c;
    1b2e:	00000517          	auipc	a0,0x0
    1b32:	6fa53503          	ld	a0,1786(a0) # 2228 <LF+0x1e>
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1b36:	471d                	li	a4,7
        size_t k = ONES * c;
    1b38:	02a58533          	mul	a0,a1,a0
        for (w = (const void*)s; n >= SS && !HASZERO(*w ^ k); w++, n -= SS)
    1b3c:	02c77a63          	bgeu	a4,a2,1b70 <memchr+0x6e>
    1b40:	00000897          	auipc	a7,0x0
    1b44:	6d88b883          	ld	a7,1752(a7) # 2218 <LF+0xe>
    1b48:	00000817          	auipc	a6,0x0
    1b4c:	6d883803          	ld	a6,1752(a6) # 2220 <LF+0x16>
    1b50:	431d                	li	t1,7
    1b52:	a029                	j	1b5c <memchr+0x5a>
    1b54:	1661                	addi	a2,a2,-8
    1b56:	07a1                	addi	a5,a5,8
    1b58:	02c37963          	bgeu	t1,a2,1b8a <memchr+0x88>
    1b5c:	6398                	ld	a4,0(a5)
    1b5e:	8f29                	xor	a4,a4,a0
    1b60:	011706b3          	add	a3,a4,a7
    1b64:	fff74713          	not	a4,a4
    1b68:	8f75                	and	a4,a4,a3
    1b6a:	01077733          	and	a4,a4,a6
    1b6e:	d37d                	beqz	a4,1b54 <memchr+0x52>
    1b70:	853e                	mv	a0,a5
    1b72:	97b2                	add	a5,a5,a2
    1b74:	a021                	j	1b7c <memchr+0x7a>
    for (; n && *s != c; s++, n--)
    1b76:	0505                	addi	a0,a0,1
    1b78:	00f50763          	beq	a0,a5,1b86 <memchr+0x84>
    1b7c:	00054703          	lbu	a4,0(a0)
    1b80:	feb71be3          	bne	a4,a1,1b76 <memchr+0x74>
    1b84:	8082                	ret
    return n ? (void*)s : 0;
    1b86:	4501                	li	a0,0
}
    1b88:	8082                	ret
    return n ? (void*)s : 0;
    1b8a:	4501                	li	a0,0
    for (; n && *s != c; s++, n--)
    1b8c:	f275                	bnez	a2,1b70 <memchr+0x6e>
}
    1b8e:	8082                	ret

0000000000001b90 <strnlen>:

size_t strnlen(const char* s, size_t n)
{
    1b90:	1101                	addi	sp,sp,-32
    1b92:	e822                	sd	s0,16(sp)
    const char* p = memchr(s, 0, n);
    1b94:	862e                	mv	a2,a1
{
    1b96:	842e                	mv	s0,a1
    const char* p = memchr(s, 0, n);
    1b98:	4581                	li	a1,0
{
    1b9a:	e426                	sd	s1,8(sp)
    1b9c:	ec06                	sd	ra,24(sp)
    1b9e:	84aa                	mv	s1,a0
    const char* p = memchr(s, 0, n);
    1ba0:	f63ff0ef          	jal	ra,1b02 <memchr>
    return p ? p - s : n;
    1ba4:	c519                	beqz	a0,1bb2 <strnlen+0x22>
}
    1ba6:	60e2                	ld	ra,24(sp)
    1ba8:	6442                	ld	s0,16(sp)
    return p ? p - s : n;
    1baa:	8d05                	sub	a0,a0,s1
}
    1bac:	64a2                	ld	s1,8(sp)
    1bae:	6105                	addi	sp,sp,32
    1bb0:	8082                	ret
    1bb2:	60e2                	ld	ra,24(sp)
    return p ? p - s : n;
    1bb4:	8522                	mv	a0,s0
}
    1bb6:	6442                	ld	s0,16(sp)
    1bb8:	64a2                	ld	s1,8(sp)
    1bba:	6105                	addi	sp,sp,32
    1bbc:	8082                	ret

0000000000001bbe <stpcpy>:
char* stpcpy(char* restrict d, const char* s)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if ((uintptr_t)s % SS == (uintptr_t)d % SS) {
    1bbe:	00b547b3          	xor	a5,a0,a1
    1bc2:	8b9d                	andi	a5,a5,7
    1bc4:	eb95                	bnez	a5,1bf8 <stpcpy+0x3a>
        for (; (uintptr_t)s % SS; s++, d++)
    1bc6:	0075f793          	andi	a5,a1,7
    1bca:	e7b1                	bnez	a5,1c16 <stpcpy+0x58>
            if (!(*d = *s))
                return d;
        wd = (void*)d;
        ws = (const void*)s;
        for (; !HASZERO(*ws); *wd++ = *ws++)
    1bcc:	6198                	ld	a4,0(a1)
    1bce:	00000617          	auipc	a2,0x0
    1bd2:	64a63603          	ld	a2,1610(a2) # 2218 <LF+0xe>
    1bd6:	00000817          	auipc	a6,0x0
    1bda:	64a83803          	ld	a6,1610(a6) # 2220 <LF+0x16>
    1bde:	a029                	j	1be8 <stpcpy+0x2a>
    1be0:	e118                	sd	a4,0(a0)
    1be2:	6598                	ld	a4,8(a1)
    1be4:	05a1                	addi	a1,a1,8
    1be6:	0521                	addi	a0,a0,8
    1be8:	00c707b3          	add	a5,a4,a2
    1bec:	fff74693          	not	a3,a4
    1bf0:	8ff5                	and	a5,a5,a3
    1bf2:	0107f7b3          	and	a5,a5,a6
    1bf6:	d7ed                	beqz	a5,1be0 <stpcpy+0x22>
            ;
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; (*d = *s); s++, d++)
    1bf8:	0005c783          	lbu	a5,0(a1)
    1bfc:	00f50023          	sb	a5,0(a0)
    1c00:	c785                	beqz	a5,1c28 <stpcpy+0x6a>
    1c02:	0015c783          	lbu	a5,1(a1)
    1c06:	0505                	addi	a0,a0,1
    1c08:	0585                	addi	a1,a1,1
    1c0a:	00f50023          	sb	a5,0(a0)
    1c0e:	fbf5                	bnez	a5,1c02 <stpcpy+0x44>
        ;
    return d;
}
    1c10:	8082                	ret
        for (; (uintptr_t)s % SS; s++, d++)
    1c12:	0505                	addi	a0,a0,1
    1c14:	df45                	beqz	a4,1bcc <stpcpy+0xe>
            if (!(*d = *s))
    1c16:	0005c783          	lbu	a5,0(a1)
        for (; (uintptr_t)s % SS; s++, d++)
    1c1a:	0585                	addi	a1,a1,1
    1c1c:	0075f713          	andi	a4,a1,7
            if (!(*d = *s))
    1c20:	00f50023          	sb	a5,0(a0)
    1c24:	f7fd                	bnez	a5,1c12 <stpcpy+0x54>
}
    1c26:	8082                	ret
    1c28:	8082                	ret

0000000000001c2a <stpncpy>:
char* stpncpy(char* restrict d, const char* s, size_t n)
{
    typedef size_t __attribute__((__may_alias__)) word;
    word* wd;
    const word* ws;
    if (((uintptr_t)s & ALIGN) == ((uintptr_t)d & ALIGN)) {
    1c2a:	00b547b3          	xor	a5,a0,a1
    1c2e:	8b9d                	andi	a5,a5,7
    1c30:	1a079863          	bnez	a5,1de0 <stpncpy+0x1b6>
        for (; ((uintptr_t)s & ALIGN) && n && (*d = *s); n--, s++, d++)
    1c34:	0075f793          	andi	a5,a1,7
    1c38:	16078463          	beqz	a5,1da0 <stpncpy+0x176>
    1c3c:	ea01                	bnez	a2,1c4c <stpncpy+0x22>
    1c3e:	a421                	j	1e46 <stpncpy+0x21c>
    1c40:	167d                	addi	a2,a2,-1
    1c42:	0505                	addi	a0,a0,1
    1c44:	14070e63          	beqz	a4,1da0 <stpncpy+0x176>
    1c48:	1a060863          	beqz	a2,1df8 <stpncpy+0x1ce>
    1c4c:	0005c783          	lbu	a5,0(a1)
    1c50:	0585                	addi	a1,a1,1
    1c52:	0075f713          	andi	a4,a1,7
    1c56:	00f50023          	sb	a5,0(a0)
    1c5a:	f3fd                	bnez	a5,1c40 <stpncpy+0x16>
    1c5c:	4805                	li	a6,1
    1c5e:	1a061863          	bnez	a2,1e0e <stpncpy+0x1e4>
    1c62:	40a007b3          	neg	a5,a0
    1c66:	8b9d                	andi	a5,a5,7
    1c68:	4681                	li	a3,0
    1c6a:	18061a63          	bnez	a2,1dfe <stpncpy+0x1d4>
    1c6e:	00778713          	addi	a4,a5,7
    1c72:	45ad                	li	a1,11
    1c74:	18b76363          	bltu	a4,a1,1dfa <stpncpy+0x1d0>
    1c78:	1ae6eb63          	bltu	a3,a4,1e2e <stpncpy+0x204>
    1c7c:	1a078363          	beqz	a5,1e22 <stpncpy+0x1f8>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1c80:	00050023          	sb	zero,0(a0)
    1c84:	4685                	li	a3,1
    1c86:	00150713          	addi	a4,a0,1
    1c8a:	18d78f63          	beq	a5,a3,1e28 <stpncpy+0x1fe>
    1c8e:	000500a3          	sb	zero,1(a0)
    1c92:	4689                	li	a3,2
    1c94:	00250713          	addi	a4,a0,2
    1c98:	18d78e63          	beq	a5,a3,1e34 <stpncpy+0x20a>
    1c9c:	00050123          	sb	zero,2(a0)
    1ca0:	468d                	li	a3,3
    1ca2:	00350713          	addi	a4,a0,3
    1ca6:	16d78c63          	beq	a5,a3,1e1e <stpncpy+0x1f4>
    1caa:	000501a3          	sb	zero,3(a0)
    1cae:	4691                	li	a3,4
    1cb0:	00450713          	addi	a4,a0,4
    1cb4:	18d78263          	beq	a5,a3,1e38 <stpncpy+0x20e>
    1cb8:	00050223          	sb	zero,4(a0)
    1cbc:	4695                	li	a3,5
    1cbe:	00550713          	addi	a4,a0,5
    1cc2:	16d78d63          	beq	a5,a3,1e3c <stpncpy+0x212>
    1cc6:	000502a3          	sb	zero,5(a0)
    1cca:	469d                	li	a3,7
    1ccc:	00650713          	addi	a4,a0,6
    1cd0:	16d79863          	bne	a5,a3,1e40 <stpncpy+0x216>
    1cd4:	00750713          	addi	a4,a0,7
    1cd8:	00050323          	sb	zero,6(a0)
    1cdc:	40f80833          	sub	a6,a6,a5
    1ce0:	ff887593          	andi	a1,a6,-8
    1ce4:	97aa                	add	a5,a5,a0
    1ce6:	95be                	add	a1,a1,a5
    1ce8:	0007b023          	sd	zero,0(a5)
    1cec:	07a1                	addi	a5,a5,8
    1cee:	feb79de3          	bne	a5,a1,1ce8 <stpncpy+0xbe>
    1cf2:	ff887593          	andi	a1,a6,-8
    1cf6:	9ead                	addw	a3,a3,a1
    1cf8:	00b707b3          	add	a5,a4,a1
    1cfc:	12b80863          	beq	a6,a1,1e2c <stpncpy+0x202>
    1d00:	00078023          	sb	zero,0(a5)
    1d04:	0016871b          	addiw	a4,a3,1
    1d08:	0ec77863          	bgeu	a4,a2,1df8 <stpncpy+0x1ce>
    1d0c:	000780a3          	sb	zero,1(a5)
    1d10:	0026871b          	addiw	a4,a3,2
    1d14:	0ec77263          	bgeu	a4,a2,1df8 <stpncpy+0x1ce>
    1d18:	00078123          	sb	zero,2(a5)
    1d1c:	0036871b          	addiw	a4,a3,3
    1d20:	0cc77c63          	bgeu	a4,a2,1df8 <stpncpy+0x1ce>
    1d24:	000781a3          	sb	zero,3(a5)
    1d28:	0046871b          	addiw	a4,a3,4
    1d2c:	0cc77663          	bgeu	a4,a2,1df8 <stpncpy+0x1ce>
    1d30:	00078223          	sb	zero,4(a5)
    1d34:	0056871b          	addiw	a4,a3,5
    1d38:	0cc77063          	bgeu	a4,a2,1df8 <stpncpy+0x1ce>
    1d3c:	000782a3          	sb	zero,5(a5)
    1d40:	0066871b          	addiw	a4,a3,6
    1d44:	0ac77a63          	bgeu	a4,a2,1df8 <stpncpy+0x1ce>
    1d48:	00078323          	sb	zero,6(a5)
    1d4c:	0076871b          	addiw	a4,a3,7
    1d50:	0ac77463          	bgeu	a4,a2,1df8 <stpncpy+0x1ce>
    1d54:	000783a3          	sb	zero,7(a5)
    1d58:	0086871b          	addiw	a4,a3,8
    1d5c:	08c77e63          	bgeu	a4,a2,1df8 <stpncpy+0x1ce>
    1d60:	00078423          	sb	zero,8(a5)
    1d64:	0096871b          	addiw	a4,a3,9
    1d68:	08c77863          	bgeu	a4,a2,1df8 <stpncpy+0x1ce>
    1d6c:	000784a3          	sb	zero,9(a5)
    1d70:	00a6871b          	addiw	a4,a3,10
    1d74:	08c77263          	bgeu	a4,a2,1df8 <stpncpy+0x1ce>
    1d78:	00078523          	sb	zero,10(a5)
    1d7c:	00b6871b          	addiw	a4,a3,11
    1d80:	06c77c63          	bgeu	a4,a2,1df8 <stpncpy+0x1ce>
    1d84:	000785a3          	sb	zero,11(a5)
    1d88:	00c6871b          	addiw	a4,a3,12
    1d8c:	06c77663          	bgeu	a4,a2,1df8 <stpncpy+0x1ce>
    1d90:	00078623          	sb	zero,12(a5)
    1d94:	26b5                	addiw	a3,a3,13
    1d96:	06c6f163          	bgeu	a3,a2,1df8 <stpncpy+0x1ce>
    1d9a:	000786a3          	sb	zero,13(a5)
    1d9e:	8082                	ret
            ;
        if (!n || !*s)
    1da0:	c645                	beqz	a2,1e48 <stpncpy+0x21e>
    1da2:	0005c783          	lbu	a5,0(a1)
    1da6:	ea078be3          	beqz	a5,1c5c <stpncpy+0x32>
            goto tail;
        wd = (void*)d;
        ws = (const void*)s;
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1daa:	479d                	li	a5,7
    1dac:	02c7ff63          	bgeu	a5,a2,1dea <stpncpy+0x1c0>
    1db0:	00000897          	auipc	a7,0x0
    1db4:	4688b883          	ld	a7,1128(a7) # 2218 <LF+0xe>
    1db8:	00000817          	auipc	a6,0x0
    1dbc:	46883803          	ld	a6,1128(a6) # 2220 <LF+0x16>
    1dc0:	431d                	li	t1,7
    1dc2:	6198                	ld	a4,0(a1)
    1dc4:	011707b3          	add	a5,a4,a7
    1dc8:	fff74693          	not	a3,a4
    1dcc:	8ff5                	and	a5,a5,a3
    1dce:	0107f7b3          	and	a5,a5,a6
    1dd2:	ef81                	bnez	a5,1dea <stpncpy+0x1c0>
            *wd = *ws;
    1dd4:	e118                	sd	a4,0(a0)
        for (; n >= sizeof(size_t) && !HASZERO(*ws); n -= sizeof(size_t), ws++, wd++)
    1dd6:	1661                	addi	a2,a2,-8
    1dd8:	05a1                	addi	a1,a1,8
    1dda:	0521                	addi	a0,a0,8
    1ddc:	fec363e3          	bltu	t1,a2,1dc2 <stpncpy+0x198>
        d = (void*)wd;
        s = (const void*)ws;
    }
    for (; n && (*d = *s); n--, s++, d++)
    1de0:	e609                	bnez	a2,1dea <stpncpy+0x1c0>
    1de2:	a08d                	j	1e44 <stpncpy+0x21a>
    1de4:	167d                	addi	a2,a2,-1
    1de6:	0505                	addi	a0,a0,1
    1de8:	ca01                	beqz	a2,1df8 <stpncpy+0x1ce>
    1dea:	0005c783          	lbu	a5,0(a1)
    1dee:	0585                	addi	a1,a1,1
    1df0:	00f50023          	sb	a5,0(a0)
    1df4:	fbe5                	bnez	a5,1de4 <stpncpy+0x1ba>
        ;
tail:
    1df6:	b59d                	j	1c5c <stpncpy+0x32>
    memset(d, 0, n);
    return d;
}
    1df8:	8082                	ret
    1dfa:	472d                	li	a4,11
    1dfc:	bdb5                	j	1c78 <stpncpy+0x4e>
    1dfe:	00778713          	addi	a4,a5,7
    1e02:	45ad                	li	a1,11
    1e04:	fff60693          	addi	a3,a2,-1
    1e08:	e6b778e3          	bgeu	a4,a1,1c78 <stpncpy+0x4e>
    1e0c:	b7fd                	j	1dfa <stpncpy+0x1d0>
    1e0e:	40a007b3          	neg	a5,a0
    1e12:	8832                	mv	a6,a2
    1e14:	8b9d                	andi	a5,a5,7
    1e16:	4681                	li	a3,0
    1e18:	e4060be3          	beqz	a2,1c6e <stpncpy+0x44>
    1e1c:	b7cd                	j	1dfe <stpncpy+0x1d4>
    for(int i = 0; i < n; ++i, *(p++) = c);
    1e1e:	468d                	li	a3,3
    1e20:	bd75                	j	1cdc <stpncpy+0xb2>
    1e22:	872a                	mv	a4,a0
    1e24:	4681                	li	a3,0
    1e26:	bd5d                	j	1cdc <stpncpy+0xb2>
    1e28:	4685                	li	a3,1
    1e2a:	bd4d                	j	1cdc <stpncpy+0xb2>
    1e2c:	8082                	ret
    1e2e:	87aa                	mv	a5,a0
    1e30:	4681                	li	a3,0
    1e32:	b5f9                	j	1d00 <stpncpy+0xd6>
    1e34:	4689                	li	a3,2
    1e36:	b55d                	j	1cdc <stpncpy+0xb2>
    1e38:	4691                	li	a3,4
    1e3a:	b54d                	j	1cdc <stpncpy+0xb2>
    1e3c:	4695                	li	a3,5
    1e3e:	bd79                	j	1cdc <stpncpy+0xb2>
    1e40:	4699                	li	a3,6
    1e42:	bd69                	j	1cdc <stpncpy+0xb2>
    1e44:	8082                	ret
    1e46:	8082                	ret
    1e48:	8082                	ret

0000000000001e4a <memmove>:
    char *dst;
    const char *src;

    dst = vdst;
    src = vsrc;
    if (src > dst) {
    1e4a:	fff6071b          	addiw	a4,a2,-1
    1e4e:	0cb57063          	bgeu	a0,a1,1f0e <memmove+0xc4>
        while (n-- > 0)
    1e52:	0ec05063          	blez	a2,1f32 <memmove+0xe8>
    1e56:	00750693          	addi	a3,a0,7
    1e5a:	8e8d                	sub	a3,a3,a1
    1e5c:	00b567b3          	or	a5,a0,a1
    1e60:	00f6b693          	sltiu	a3,a3,15
    1e64:	8b9d                	andi	a5,a5,7
    1e66:	0016c693          	xori	a3,a3,1
    1e6a:	0017b793          	seqz	a5,a5
    1e6e:	8ff5                	and	a5,a5,a3
    1e70:	c3f1                	beqz	a5,1f34 <memmove+0xea>
    1e72:	0007079b          	sext.w	a5,a4
    1e76:	46a5                	li	a3,9
    1e78:	0af6fe63          	bgeu	a3,a5,1f34 <memmove+0xea>
    1e7c:	0036589b          	srliw	a7,a2,0x3
    1e80:	088e                	slli	a7,a7,0x3
    1e82:	2601                	sext.w	a2,a2
    1e84:	87ae                	mv	a5,a1
    1e86:	86aa                	mv	a3,a0
    1e88:	98ae                	add	a7,a7,a1
            *dst++ = *src++;
    1e8a:	0007b803          	ld	a6,0(a5)
    1e8e:	07a1                	addi	a5,a5,8
    1e90:	06a1                	addi	a3,a3,8
    1e92:	ff06bc23          	sd	a6,-8(a3)
        while (n-- > 0)
    1e96:	ff179ae3          	bne	a5,a7,1e8a <memmove+0x40>
    1e9a:	ff867813          	andi	a6,a2,-8
    1e9e:	02081793          	slli	a5,a6,0x20
    1ea2:	9381                	srli	a5,a5,0x20
    1ea4:	00f506b3          	add	a3,a0,a5
    1ea8:	95be                	add	a1,a1,a5
    1eaa:	4107073b          	subw	a4,a4,a6
    1eae:	09060263          	beq	a2,a6,1f32 <memmove+0xe8>
            *dst++ = *src++;
    1eb2:	0005c783          	lbu	a5,0(a1)
    1eb6:	00f68023          	sb	a5,0(a3)
        while (n-- > 0)
    1eba:	06e05c63          	blez	a4,1f32 <memmove+0xe8>
            *dst++ = *src++;
    1ebe:	0015c603          	lbu	a2,1(a1)
        while (n-- > 0)
    1ec2:	4785                	li	a5,1
            *dst++ = *src++;
    1ec4:	00c680a3          	sb	a2,1(a3)
        while (n-- > 0)
    1ec8:	06e7d563          	bge	a5,a4,1f32 <memmove+0xe8>
            *dst++ = *src++;
    1ecc:	0025c603          	lbu	a2,2(a1)
        while (n-- > 0)
    1ed0:	4789                	li	a5,2
            *dst++ = *src++;
    1ed2:	00c68123          	sb	a2,2(a3)
        while (n-- > 0)
    1ed6:	04e7de63          	bge	a5,a4,1f32 <memmove+0xe8>
            *dst++ = *src++;
    1eda:	0035c603          	lbu	a2,3(a1)
        while (n-- > 0)
    1ede:	478d                	li	a5,3
            *dst++ = *src++;
    1ee0:	00c681a3          	sb	a2,3(a3)
        while (n-- > 0)
    1ee4:	04e7d763          	bge	a5,a4,1f32 <memmove+0xe8>
            *dst++ = *src++;
    1ee8:	0045c603          	lbu	a2,4(a1)
        while (n-- > 0)
    1eec:	4791                	li	a5,4
            *dst++ = *src++;
    1eee:	00c68223          	sb	a2,4(a3)
        while (n-- > 0)
    1ef2:	04e7d063          	bge	a5,a4,1f32 <memmove+0xe8>
            *dst++ = *src++;
    1ef6:	0055c603          	lbu	a2,5(a1)
        while (n-- > 0)
    1efa:	4795                	li	a5,5
            *dst++ = *src++;
    1efc:	00c682a3          	sb	a2,5(a3)
        while (n-- > 0)
    1f00:	02e7d963          	bge	a5,a4,1f32 <memmove+0xe8>
            *dst++ = *src++;
    1f04:	0065c783          	lbu	a5,6(a1)
    1f08:	00f68323          	sb	a5,6(a3)
        while (n-- > 0)
    1f0c:	8082                	ret
    } else {
        dst += n;
    1f0e:	00c507b3          	add	a5,a0,a2
        src += n;
    1f12:	95b2                	add	a1,a1,a2
        while (n-- > 0)
    1f14:	00c05f63          	blez	a2,1f32 <memmove+0xe8>
    1f18:	1702                	slli	a4,a4,0x20
    1f1a:	9301                	srli	a4,a4,0x20
    1f1c:	fff74713          	not	a4,a4
    1f20:	973e                	add	a4,a4,a5
            *--dst = *--src;
    1f22:	fff5c683          	lbu	a3,-1(a1)
    1f26:	17fd                	addi	a5,a5,-1
    1f28:	15fd                	addi	a1,a1,-1
    1f2a:	00d78023          	sb	a3,0(a5)
        while (n-- > 0)
    1f2e:	fee79ae3          	bne	a5,a4,1f22 <memmove+0xd8>
    }
    return vdst;
}
    1f32:	8082                	ret
    1f34:	02071693          	slli	a3,a4,0x20
    1f38:	9281                	srli	a3,a3,0x20
    1f3a:	0685                	addi	a3,a3,1
    1f3c:	96ae                	add	a3,a3,a1
        while (n-- > 0)
    1f3e:	87aa                	mv	a5,a0
            *dst++ = *src++;
    1f40:	0005c703          	lbu	a4,0(a1)
    1f44:	0585                	addi	a1,a1,1
    1f46:	0785                	addi	a5,a5,1
    1f48:	fee78fa3          	sb	a4,-1(a5)
        while (n-- > 0)
    1f4c:	fed59ae3          	bne	a1,a3,1f40 <memmove+0xf6>
    1f50:	8082                	ret

0000000000001f52 <execv>:
    __asm_syscall("r"(a7), "0"(a0))
}

static inline long __syscall2(long n, long a, long b)
{
    register long a7 __asm__("a7") = n;
    1f52:	11900893          	li	a7,281
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f56:	00000073          	ecall
#include <ucore_syscall_ids.h>

int execv(const char *pathname, char *const argv[])
{
    return syscall(SYS_execv, pathname, argv);
}
    1f5a:	2501                	sext.w	a0,a0
    1f5c:	8082                	ret

0000000000001f5e <exec>:
    register long a7 __asm__("a7") = n;
    1f5e:	11900893          	li	a7,281
    register long a1 __asm__("a1") = b;
    1f62:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1f64:	00000073          	ecall

int exec(const char *pathname)
{
    return syscall(SYS_execv, pathname, NULL);
}
    1f68:	2501                	sext.w	a0,a0
    1f6a:	8082                	ret

0000000000001f6c <exit>:
    register long a7 __asm__("a7") = n;
    1f6c:	05d00893          	li	a7,93
    __asm_syscall("r"(a7), "0"(a0))
    1f70:	00000073          	ecall

void exit(int status)
{
    syscall(SYS_exit, status);
}
    1f74:	8082                	ret

0000000000001f76 <read>:
}

static inline long __syscall3(long n, long a, long b, long c)
{
    register long a7 __asm__("a7") = n;
    1f76:	03f00893          	li	a7,63
    register long a0 __asm__("a0") = a;
    register long a1 __asm__("a1") = b;
    register long a2 __asm__("a2") = c;
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f7a:	00000073          	ecall
ssize_t read(int fd, void *dst, size_t len)
{
    return syscall(SYS_read, fd, dst, len);
}
    1f7e:	8082                	ret

0000000000001f80 <write>:
    register long a7 __asm__("a7") = n;
    1f80:	04000893          	li	a7,64
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1f84:	00000073          	ecall
ssize_t write(int fd, void *src, size_t len)
{
    return syscall(SYS_write, fd, src, len);
}
    1f88:	8082                	ret

0000000000001f8a <getpid>:
    register long a7 __asm__("a7") = n;
    1f8a:	0ac00893          	li	a7,172
    __asm_syscall("r"(a7))
    1f8e:	00000073          	ecall

pid_t getpid(void)
{
    return syscall(SYS_getpid);
}
    1f92:	2501                	sext.w	a0,a0
    1f94:	8082                	ret

0000000000001f96 <getppid>:
    register long a7 __asm__("a7") = n;
    1f96:	0ad00893          	li	a7,173
    __asm_syscall("r"(a7))
    1f9a:	00000073          	ecall

pid_t getppid(void)
{
    return syscall(SYS_getppid);
}
    1f9e:	2501                	sext.w	a0,a0
    1fa0:	8082                	ret

0000000000001fa2 <open>:
    register long a7 __asm__("a7") = n;
    1fa2:	03800893          	li	a7,56
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1fa6:	00000073          	ecall

int open(const char *pathname, int flags)
{
    return syscall(SYS_open, pathname, flags);
}
    1faa:	2501                	sext.w	a0,a0
    1fac:	8082                	ret

0000000000001fae <mknod>:
    register long a7 __asm__("a7") = n;
    1fae:	02100893          	li	a7,33
    __asm_syscall("r"(a7), "0"(a0), "r"(a1), "r"(a2))
    1fb2:	00000073          	ecall

int mknod(const char *pathname, short major, short minor)
{
    return syscall(SYS_mknod, pathname, major, minor);
}
    1fb6:	2501                	sext.w	a0,a0
    1fb8:	8082                	ret

0000000000001fba <dup>:
    register long a7 __asm__("a7") = n;
    1fba:	48dd                	li	a7,23
    __asm_syscall("r"(a7), "0"(a0))
    1fbc:	00000073          	ecall

int dup(int oldfd)
{
    return syscall(SYS_dup, oldfd);
}
    1fc0:	2501                	sext.w	a0,a0
    1fc2:	8082                	ret

0000000000001fc4 <sched_yield>:
    register long a7 __asm__("a7") = n;
    1fc4:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    1fc8:	00000073          	ecall

int sched_yield(void)
{
    return syscall(SYS_sched_yield);
}
    1fcc:	2501                	sext.w	a0,a0
    1fce:	8082                	ret

0000000000001fd0 <waitpid>:
    register long a7 __asm__("a7") = n;
    1fd0:	05f00893          	li	a7,95
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1fd4:	00000073          	ecall

pid_t waitpid(pid_t pid, int *wstatus)
{
    return syscall(SYS_waitpid, pid, wstatus);
}
    1fd8:	2501                	sext.w	a0,a0
    1fda:	8082                	ret

0000000000001fdc <wait>:

pid_t wait(int *wstatus)
{
    1fdc:	85aa                	mv	a1,a0
    register long a7 __asm__("a7") = n;
    1fde:	05f00893          	li	a7,95
    register long a0 __asm__("a0") = a;
    1fe2:	557d                	li	a0,-1
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    1fe4:	00000073          	ecall
    return waitpid(-1, wstatus);
}
    1fe8:	2501                	sext.w	a0,a0
    1fea:	8082                	ret

0000000000001fec <mkdir>:
    register long a7 __asm__("a7") = n;
    1fec:	02200893          	li	a7,34
    __asm_syscall("r"(a7), "0"(a0))
    1ff0:	00000073          	ecall

int mkdir(const char *pathname)
{
    return syscall(SYS_mkdir, pathname);
}
    1ff4:	2501                	sext.w	a0,a0
    1ff6:	8082                	ret

0000000000001ff8 <close>:
    register long a7 __asm__("a7") = n;
    1ff8:	03900893          	li	a7,57
    __asm_syscall("r"(a7), "0"(a0))
    1ffc:	00000073          	ecall

int close(int fd)
{
    return syscall(SYS_close, fd);
}
    2000:	2501                	sext.w	a0,a0
    2002:	8082                	ret

0000000000002004 <fork>:
    register long a7 __asm__("a7") = n;
    2004:	0dc00893          	li	a7,220
    __asm_syscall("r"(a7))
    2008:	00000073          	ecall

pid_t fork(void)
{
    return syscall(SYS_fork);
}
    200c:	2501                	sext.w	a0,a0
    200e:	8082                	ret

0000000000002010 <time_ms>:
    register long a7 __asm__("a7") = n;
    2010:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    2014:	00000073          	ecall

uint64 time_ms()
{
    return syscall(SYS_time_ms);
}
    2018:	8082                	ret

000000000000201a <sleep>:

int sleep(unsigned long long time_in_ms)
{
    201a:	872a                	mv	a4,a0
    register long a7 __asm__("a7") = n;
    201c:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    2020:	00000073          	ecall
    2024:	87aa                	mv	a5,a0
    2026:	00000073          	ecall
    unsigned long long s = time_ms();
    while (time_ms() < s + time_in_ms)
    202a:	97ba                	add	a5,a5,a4
    202c:	00f57c63          	bgeu	a0,a5,2044 <sleep+0x2a>
    register long a7 __asm__("a7") = n;
    2030:	07c00893          	li	a7,124
    __asm_syscall("r"(a7))
    2034:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    2038:	09900893          	li	a7,153
    __asm_syscall("r"(a7))
    203c:	00000073          	ecall
    2040:	fef568e3          	bltu	a0,a5,2030 <sleep+0x16>
    {
        sched_yield();
    }
    return 0;
}
    2044:	4501                	li	a0,0
    2046:	8082                	ret

0000000000002048 <pipe>:
    register long a7 __asm__("a7") = n;
    2048:	03b00893          	li	a7,59
    __asm_syscall("r"(a7), "0"(a0))
    204c:	00000073          	ecall

int pipe(int pipefd[2])
{
    return syscall(SYS_pipe2, pipefd);
}
    2050:	2501                	sext.w	a0,a0
    2052:	8082                	ret

0000000000002054 <fstat>:
    register long a7 __asm__("a7") = n;
    2054:	05000893          	li	a7,80
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2058:	00000073          	ecall

int fstat(int fd, struct stat *statbuf)
{
    return syscall(SYS_fstat, fd, statbuf);
}
    205c:	2501                	sext.w	a0,a0
    205e:	8082                	ret

0000000000002060 <stat>:

int stat(const char *pathname, struct stat *statbuf)
{
    2060:	87ae                	mv	a5,a1
    register long a7 __asm__("a7") = n;
    2062:	03800893          	li	a7,56
    register long a1 __asm__("a1") = b;
    2066:	4581                	li	a1,0
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2068:	00000073          	ecall
    int fd;
    int r;

    fd = open(pathname, O_RDONLY);
    if (fd < 0)
    206c:	02051693          	slli	a3,a0,0x20
    return syscall(SYS_open, pathname, flags);
    2070:	0005071b          	sext.w	a4,a0
    if (fd < 0)
    2074:	0206c163          	bltz	a3,2096 <stat+0x36>
    register long a7 __asm__("a7") = n;
    2078:	05000893          	li	a7,80
    register long a0 __asm__("a0") = a;
    207c:	853a                	mv	a0,a4
    register long a1 __asm__("a1") = b;
    207e:	85be                	mv	a1,a5
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    2080:	00000073          	ecall
    register long a7 __asm__("a7") = n;
    2084:	03900893          	li	a7,57
    return syscall(SYS_fstat, fd, statbuf);
    2088:	0005079b          	sext.w	a5,a0
    register long a0 __asm__("a0") = a;
    208c:	853a                	mv	a0,a4
    __asm_syscall("r"(a7), "0"(a0))
    208e:	00000073          	ecall
        return -1;
    r = fstat(fd, statbuf);
    close(fd);
    return r;
}
    2092:	853e                	mv	a0,a5
    2094:	8082                	ret
        return -1;
    2096:	57fd                	li	a5,-1
    2098:	bfed                	j	2092 <stat+0x32>

000000000000209a <chdir>:
    register long a7 __asm__("a7") = n;
    209a:	03100893          	li	a7,49
    __asm_syscall("r"(a7), "0"(a0))
    209e:	00000073          	ecall

int chdir(const char *path){
    return syscall(SYS_chdir, path);
}
    20a2:	2501                	sext.w	a0,a0
    20a4:	8082                	ret

00000000000020a6 <link>:
    register long a7 __asm__("a7") = n;
    20a6:	02500893          	li	a7,37
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    20aa:	00000073          	ecall


int link(const char *oldpath, const char *newpath){
    return syscall(SYS_link, oldpath, newpath);

}
    20ae:	2501                	sext.w	a0,a0
    20b0:	8082                	ret

00000000000020b2 <unlink>:
    register long a7 __asm__("a7") = n;
    20b2:	02600893          	li	a7,38
    __asm_syscall("r"(a7), "0"(a0))
    20b6:	00000073          	ecall

int unlink(const char *pathname){
    return syscall(SYS_unlink, pathname);
}
    20ba:	2501                	sext.w	a0,a0
    20bc:	8082                	ret

00000000000020be <setpriority>:
    register long a7 __asm__("a7") = n;
    20be:	08c00893          	li	a7,140
    __asm_syscall("r"(a7), "0"(a0))
    20c2:	00000073          	ecall

int64 setpriority(int64 priority){
    return syscall(SYS_setpriority, priority);
}
    20c6:	8082                	ret

00000000000020c8 <getpriority>:
    register long a7 __asm__("a7") = n;
    20c8:	08d00893          	li	a7,141
    __asm_syscall("r"(a7))
    20cc:	00000073          	ecall

int64 getpriority(){
    return syscall(SYS_getpriority);
}
    20d0:	8082                	ret

00000000000020d2 <sharedmem>:
    register long a7 __asm__("a7") = n;
    20d2:	11a00893          	li	a7,282
    __asm_syscall("r"(a7), "0"(a0), "r"(a1))
    20d6:	00000073          	ecall

void* sharedmem(char* name, size_t len){
    return (void*) syscall(SYS_sharedmem, name, len);
}
    20da:	8082                	ret
