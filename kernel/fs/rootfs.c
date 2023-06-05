#include "arch/hw.h"
#include "fs/buffer.h"
#include "utils/string.h"
#include "fs/rootfs.h"
#include "lock/spinlock.h"
#include "common/common.h"

rootfs_dev_t rootfs_dev;

void rootfs_rw(buf_t *buf,uint32_t write)
{
  acquire_spinlock(&rootfs_dev.dev_lock);

  uint64_t sector = buf->sector;
  if(write) {
    memmove(INITRD_START + BUFFER_SIZE * sector, buf->payload->payload, BUFFER_SIZE);
  } else {
    memmove(buf->payload->payload, INITRD_START + BUFFER_SIZE * sector, BUFFER_SIZE);
  }

  release_spinlock(&rootfs_dev.dev_lock);
}
