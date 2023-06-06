#include "common/common.h"
#include "sbi/sbi.h"
#include "utils/string.h"
#include "mm/pmallocator.h"
#include "arch/cpu.h"
#include "trap/plic.h"
#include "proc/proc.h"
#include "trap/trap.h"
#include "logo.h"
#include "fs/virtio_blk.h"

extern char bss[];
extern char ebss[];

void clean_kernel_stack() {
  memset(bss, ebss - bss, 0);
}

volatile uint64_t first_booted = 0;

void main(uint64_t mhartid, uint64_t dtb_address)
{
  if(!first_booted) {
    //the 1st core
    LOG_INFO("ZenOS boot routine processing\n");
    print(LOGO);
    clean_kernel_stack();
    init_cpu();

    trapinit();
    trapinit_hart();
    pm_init();
    procinit();
    plicinit();
    plicinithart();

    kernel_vminit();
    kernel_vmenable();

    virtio_blk_init();
    buffer_init();


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
