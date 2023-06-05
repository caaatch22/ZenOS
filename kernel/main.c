#include "common/common.h"
#include "sbi/sbi.h"
#include "utils/string.h"
#include "mm/pmallocator.h"
#include "logo.h"

extern char bss[];
extern char ebss[];

void clean_kernel_stack() {
  memset(bss, ebss - bss, 0);
}

volatile uint64_t booted = 0;

void main(uint64_t mhartid, uint64_t dtb_address)
{
  if(!booted) {
    //the 1st core
    LOG_INFO("ZenOS boot routine processing\n");
    print(LOGO);
    clean_kernel_stack();
    pm_freelist_init();
    virtio_blk_init();

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
