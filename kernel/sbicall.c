#include "sbi.h"

int sbi_legacy_call(uint64 EID, uint64 arg0, uint64 arg1, uint64 arg2)
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

int sbi_call(uint64 EID,uint64 FID, uint64 arg0, uint64 arg1, uint64 arg2){
  register uint64 a0 asm("a0") = arg0;
  register uint64 a1 asm("a1") = arg1;
  register uint64 a2 asm("a2") = arg2;
  register uint64 a6 asm("a6") = FID;
  register uint64 a7 asm("a7") = EID;

  asm volatile("ecall"
               : "=r"(a0),"=r"(a1)
               : "r"(a0), "r"(a1), "r"(a2), "r"(a6),"r"(a7)
               : "memory");

  if(a0){
    LOG_ERROR("sbi_call error: EID: %x FID: %x ERROR: %x\n", a7, a6, a0);
  }

  return a1;
}

void console_putchar(int c)
{
  sbi_legacy_call(SBI_LEGACY_CONSOLE_PUTCHAR_EID, c, 0, 0);
}

int console_getchar()
{
  return sbi_legacy_call(SBI_LEGACY_CONSOLE_GETCHAR_EID, 0, 0, 0);
}

void shutdown()
{
  sbi_call(SBI_SRST_EID, SBI_SYSTEM_RESET_FID, SBI_RESET_TYPE_SHUTDOWN, 0, 0);
}

void set_timer(uint64 stime)
{
  sbi_legacy_call(SBI_LEGACY_SET_TIMER_EID, stime, 0, 0);
}


