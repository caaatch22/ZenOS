    .align 4
    .section .data
    .global _app_num
_app_num:
    .quad 33
    .quad app_0_start
    .quad app_1_start
    .quad app_2_start
    .quad app_3_start
    .quad app_4_start
    .quad app_5_start
    .quad app_6_start
    .quad app_7_start
    .quad app_8_start
    .quad app_9_start
    .quad app_10_start
    .quad app_11_start
    .quad app_12_start
    .quad app_13_start
    .quad app_14_start
    .quad app_15_start
    .quad app_16_start
    .quad app_17_start
    .quad app_18_start
    .quad app_19_start
    .quad app_20_start
    .quad app_21_start
    .quad app_22_start
    .quad app_23_start
    .quad app_24_start
    .quad app_25_start
    .quad app_26_start
    .quad app_27_start
    .quad app_28_start
    .quad app_29_start
    .quad app_30_start
    .quad app_31_start
    .quad app_32_start
    .quad app_32_end

    .global _app_names
_app_names:
   .string "cat"
   .string "echo"
   .string "forktest0"
   .string "forktest1"
   .string "forktest2"
   .string "getchar"
   .string "hello"
   .string "hello_args"
   .string "ln"
   .string "ls"
   .string "matrix"
   .string "mkdir"
   .string "rm"
   .string "shell"
   .string "test_all"
   .string "test_exec"
   .string "test_exit"
   .string "test_file"
   .string "test_main"
   .string "test_mkdir"
   .string "test_mknod"
   .string "test_pid"
   .string "test_pipe"
   .string "test_priority"
   .string "test_readwrite"
   .string "test_shmem"
   .string "test_shmem1"
   .string "test_shmem2"
   .string "test_sleep"
   .string "test_stackoverflow"
   .string "top"
   .string "top1"
   .string "zombie"

    .section .data.app0
    .global app_0_start
app_0_start:
    .incbin "./user/target/bin/_cat.bin"

    .section .data.app1
    .global app_1_start
app_1_start:
    .incbin "./user/target/bin/_echo.bin"

    .section .data.app2
    .global app_2_start
app_2_start:
    .incbin "./user/target/bin/_forktest0.bin"

    .section .data.app3
    .global app_3_start
app_3_start:
    .incbin "./user/target/bin/_forktest1.bin"

    .section .data.app4
    .global app_4_start
app_4_start:
    .incbin "./user/target/bin/_forktest2.bin"

    .section .data.app5
    .global app_5_start
app_5_start:
    .incbin "./user/target/bin/_getchar.bin"

    .section .data.app6
    .global app_6_start
app_6_start:
    .incbin "./user/target/bin/_hello.bin"

    .section .data.app7
    .global app_7_start
app_7_start:
    .incbin "./user/target/bin/_hello_args.bin"

    .section .data.app8
    .global app_8_start
app_8_start:
    .incbin "./user/target/bin/_ln.bin"

    .section .data.app9
    .global app_9_start
app_9_start:
    .incbin "./user/target/bin/_ls.bin"

    .section .data.app10
    .global app_10_start
app_10_start:
    .incbin "./user/target/bin/_matrix.bin"

    .section .data.app11
    .global app_11_start
app_11_start:
    .incbin "./user/target/bin/_mkdir.bin"

    .section .data.app12
    .global app_12_start
app_12_start:
    .incbin "./user/target/bin/_rm.bin"

    .section .data.app13
    .global app_13_start
app_13_start:
    .incbin "./user/target/bin/_shell.bin"

    .section .data.app14
    .global app_14_start
app_14_start:
    .incbin "./user/target/bin/_test_all.bin"

    .section .data.app15
    .global app_15_start
app_15_start:
    .incbin "./user/target/bin/_test_exec.bin"

    .section .data.app16
    .global app_16_start
app_16_start:
    .incbin "./user/target/bin/_test_exit.bin"

    .section .data.app17
    .global app_17_start
app_17_start:
    .incbin "./user/target/bin/_test_file.bin"

    .section .data.app18
    .global app_18_start
app_18_start:
    .incbin "./user/target/bin/_test_main.bin"

    .section .data.app19
    .global app_19_start
app_19_start:
    .incbin "./user/target/bin/_test_mkdir.bin"

    .section .data.app20
    .global app_20_start
app_20_start:
    .incbin "./user/target/bin/_test_mknod.bin"

    .section .data.app21
    .global app_21_start
app_21_start:
    .incbin "./user/target/bin/_test_pid.bin"

    .section .data.app22
    .global app_22_start
app_22_start:
    .incbin "./user/target/bin/_test_pipe.bin"

    .section .data.app23
    .global app_23_start
app_23_start:
    .incbin "./user/target/bin/_test_priority.bin"

    .section .data.app24
    .global app_24_start
app_24_start:
    .incbin "./user/target/bin/_test_readwrite.bin"

    .section .data.app25
    .global app_25_start
app_25_start:
    .incbin "./user/target/bin/_test_shmem.bin"

    .section .data.app26
    .global app_26_start
app_26_start:
    .incbin "./user/target/bin/_test_shmem1.bin"

    .section .data.app27
    .global app_27_start
app_27_start:
    .incbin "./user/target/bin/_test_shmem2.bin"

    .section .data.app28
    .global app_28_start
app_28_start:
    .incbin "./user/target/bin/_test_sleep.bin"

    .section .data.app29
    .global app_29_start
app_29_start:
    .incbin "./user/target/bin/_test_stackoverflow.bin"

    .section .data.app30
    .global app_30_start
app_30_start:
    .incbin "./user/target/bin/_top.bin"

    .section .data.app31
    .global app_31_start
app_31_start:
    .incbin "./user/target/bin/_top1.bin"

    .section .data.app32
    .global app_32_start
app_32_start:
    .incbin "./user/target/bin/_zombie.bin"
app_32_end:

