#include "sbi.h"

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


