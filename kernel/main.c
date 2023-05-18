#include "defs.h"
#include "sbi.h"
#include "log.h"
#include "logo.h"
#include "hw.h"
#include "status.h"
#include "string.h"
#include "pmallocator.h"

extern char bss[];
extern char ebss[];
void clean_kernel_stack();

volatile uint64_t booted = 0;
cpu_status CPU_STATUS[NCPU];

void main(uint64_t mhartid, uint64_t dtb_address)
{
  if(!booted) {
    //the 1st core
    LOG_INFO("ZenOS boot routine processing\n");
    print(LOGO);
    clean_kernel_stack();
    pm_freelist_init();

    shutdown();
  }
  else {
    //other cores
  }
}

void clean_kernel_stack()
{
  memset(bss, ebss - bss, 0);
}

// TODO: add this to proc
int threadid() {
  return 1;
}
