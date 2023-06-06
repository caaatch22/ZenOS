#ifndef ROOTFS_H
#define ROOTFS_H

#include "lock/sleeplock.h"
#include "common/defs.h"
#include "fs/buffer.h"

typedef struct ramdisk_dev {
  struct sleeplock dev_lock;
} ramdisk_dev_t;

void ramdisk_rw(buf_t *buf, uint32_t write);

#endif
