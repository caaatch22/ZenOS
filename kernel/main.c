#include "defs.h"
#include "sbi.h"
#include "log.h"
#include "logo.h"

extern char bss[];
extern char ebss[];

volatile uint64 booted = 0;

void main(uint64 mhartid, uint64 dtb_address)
{
  if(!booted) {
    //the 1st core
    LOG_INFO("ZenOS boot routine processing\n");
    print(LOGO);
    shutdown();
  }
  else {
    //other cores
  }
}

// TODO: add this to proc
int threadid() {
  return 1;
}
