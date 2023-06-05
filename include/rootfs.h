#ifndef ROOTFS_H
#define ROOTFS_H

#include "spinlock.h"
#include "defs.h"
#include "buffer.h"

typedef struct rootfs_dev {
  struct spinlock dev_lock;
} rootfs_dev_t;

void rootfs_rw(buf_t *buf, uint32_t write);

#endif
