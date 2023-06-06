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
#include "proc/scheduler.h"

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

    // uint64_t pos = INITRD_START + 512 * 1292 + 32;
    // LOG_DEBUG("%s", (char *)pos);
    // PANIC("test");

    virtio_blk_init();

    //for fs test, it will search a file/dir put into the img in build time
    rootfs_init();
    fs_test("/bin/test");
    //end

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

#include "fs/vfs.h"

void fs_test(char *path)
{
  LOG_DEBUG("fs_test begin");
  struct inode *ip;
  struct dentry *dp;
  ip = namei(path);

  LOG_DEBUG("parent: %s, name: %s, inode: %d", ip->entry->parent->name, ip->entry->name, ip->ino_num);
}
