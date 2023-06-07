#include "arch/hw.h"
#include "fs/buffer.h"
#include "utils/string.h"
#include "fs/ramdisk.h"
#include "lock/spinlock.h"
#include "common/common.h"

ramdisk_dev_t ramdisk_dev;

void ramdisk_rw(buf_t *buf,uint32_t write)
{
  acquire_sleeplock(&ramdisk_dev.dev_lock);

  uint64_t sector = buf->sector;
  if(write) {
    memmove((void *)(INITRD_START + BUFFER_SIZE * sector), buf->payload->payload, BUFFER_SIZE);
  }
  else
  {
    memmove(buf->payload->payload, (void *)(INITRD_START + BUFFER_SIZE * sector), BUFFER_SIZE);
  }
  release_sleeplock(&ramdisk_dev.dev_lock);
}
