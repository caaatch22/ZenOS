#ifndef SBI_H
#define SBI_H

#include "defs.h"
#include "log.h"

//legacy functions
const uint64 SBI_LEGACY_SET_TIMER_EID = 0;
const uint64 SBI_LEGACY_CONSOLE_PUTCHAR_EID = 1;
const uint64 SBI_LEGACY_CONSOLE_GETCHAR_EID = 2;
const uint64 SBI_LEGACY_CLEAR_IPI_EID = 3;
const uint64 SBI_LEGACY_SEND_IPI_EID = 4;
const uint64 SBI_LEGACY_REMOTE_FENCE_I_EID = 5;
const uint64 SBI_LEGACY_REMOTE_SFENCE_VMA_EID = 6;
const uint64 SBI_LEGACY_REMOTE_SFENCE_VMA_ASID_EID = 7;
const uint64 SBI_LEGACY_SHUTDOWN_EID = 8;
//end

const uint64 SBI_TIME_EID = 0x54494D45;
const uint64 SBI_SET_TIMER_FID = 0;

const uint64 SBI_IPI_EID = 0x735049;
const uint64 SBI_SEND_IPI_FID = 0;

const uint64 SBI_HSM_EID = 0x48534;
const uint64 SBI_HART_START_FID = 0;
const uint64 SBI_HART_STOP_FID = 1;
const uint64 SBI_HART_GET_STATUS_FID = 2;
const uint64 SBI_HART_SUSPEND_FID = 3;

const uint64 SBI_SRST_EID = 0x53525354;
const uint64 SBI_SYSTEM_RESET_FID = 0;
const uint64 SBI_RESET_TYPE_SHUTDOWN = 0x0;
const uint64 SBI_RESET_TYPE_COLD_REBOOT = 0x1;
const uint64 SBI_RESET_TYPE_WARM_REBOOT = 0x2;
const uint64 SBI_RESET_REASON_NONE = 0x0;
const uint64 SBI_RESET_REASON_SYSTEM_FAILURE = 0x1;

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

int inline sbi_call(uint64 EID,uint64 FID, uint64 arg0, uint64 arg1, uint64 arg2){
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

void console_putchar(int);

int console_getchar(void);

void shutdown(void);

void set_timer(uint64);

#endif
