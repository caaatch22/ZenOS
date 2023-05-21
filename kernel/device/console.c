#include "device/console.h"
#include "sbi/sbi.h"

void consputc(int c)
{
  console_putchar(c);
}

void console_init()
{
  // DO NOTHING
}