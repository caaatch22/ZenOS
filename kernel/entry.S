# the first code executing after sbi jump to 0x80000000

.section .text
.globl _entry
.equ INISTACKSIZE, 4096

_entry:
  la sp, _initialstack # from start.c (defined as an array)
  li a0, INISTACKSIZE
  csrr a1, mhartid # per-cpu stack
  addi a1, a1, 1 # point to the top of stacks
  mul a0, a0, a1
  add sp, sp, a0
  call start

_errspin:
  j _errspin # will never enter this portion
