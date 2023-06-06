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
#include "mm/kmalloc.h"

extern char bss[];
extern char ebss[];

extern void rootfs_init();

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
    kmallocinit();
    kernel_vmenable();

    virtio_blk_init();
    rootfs_init();

    //fs_test();

    shutdown();
  }
  else {
    //other cores
  }

  LOG_INFO("Start scheduling!");
  scheduler();

}

// TODO: add this to proc
int threadid() {
  return 1;
}

#include "fs/vfs.h"

void fs_test()
{
  struct inode *ip;
  struct dentry *dp;
  ip = namei("/bin");
  dp = ip->entry->child;

  LOG_DEBUG("root dev_num: %d", ip->dev_num);
  LOG_DEBUG("name: %s", ip->entry->name);
  for (int i = 1; dp != NULL;dp=dp->next,i++)
    LOG_DEBUG("child %d: %s", i, dp->name);
  LOG_DEBUG("dev_num: %d", ip->sb->dev_num);
}
