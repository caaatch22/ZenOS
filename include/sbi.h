#ifndef SBI_H
#define SBI_H

#include "defs.h"
const uint64 SBI_SET_TIMER = 0;
const uint64 SBI_CONSOLE_PUTCHAR = 1;
const uint64 SBI_CONSOLE_GETCHAR = 2;
const uint64 SBI_CLEAR_IPI = 3;
const uint64 SBI_SEND_IPI = 4;
const uint64 SBI_REMOTE_FENCE_I = 5;
const uint64 SBI_REMOTE_SFENCE_VMA = 6;
const uint64 SBI_REMOTE_SFENCE_VMA_ASID = 7;
const uint64 SBI_SHUTDOWN = 8;

int inline sbi_legacy_call(uint64 EID, uint64 arg0, uint64 arg1, uint64 arg2)
{
  register uint64 a0 asm("a0") = arg0;
  register uint64 a1 asm("a1") = arg1;
  register uint64 a2 asm("a2") = arg2;
  register uint64 a7 asm("a7") = EID;
  asm volatile("ecall"
               : "=r"(a0)
               : "r"(a0), "r"(a1), "r"(a2), "r"(a7)
               : "memory");
  return a0;
}

void console_putchar(int);

int console_getchar(void);

void shutdown(void);

void set_timer(uint64);

#endif
