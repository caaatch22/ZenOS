#include "sbi.h"

void console_putchar(int c)
{
  sbi_call(SBI_CONSOLE_PUTCHAR, c, 0, 0);
}

int console_getchar()
{
  return sbi_call(SBI_CONSOLE_GETCHAR, 0, 0, 0);
}

void shutdown()
{
  sbi_call(SBI_SHUTDOWN, 0, 0, 0);
}

void set_timer(uint64 stime)
{
  sbi_call(SBI_SET_TIMER, stime, 0, 0);
}
