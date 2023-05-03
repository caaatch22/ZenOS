# the first code executing after sbi jump to 0x80200000
.equ INISTACKSIZE, 4096
.equ NCPU, 2

.section .text.entry
.globl _entry

_entry:
  la sp, _initialstack # defined below
  li t0, INISTACKSIZE
  addi t1, a0, 1 # point to the top of stacks
  mul t0, t0, t1 # per-cpu stacks
  add sp, sp, t0
  add tp, a0, x0
  call main

_errspin:
  j _errspin # will never enter this portion

.section .bss.initialstack
.globl _initialstack
.align 8

_initialstack:
  .space INISTACKSIZE*NCPU

.globl _e_initialstack
e_initialstack:
