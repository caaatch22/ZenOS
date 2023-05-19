#ifndef VIRTIO_H
#define VIRTIO_H

#include "defs.h"

#define VIRTIO_MMIO_MAGIC_OFF 0x000
#define VIRTIO_MMIO_VERSION_OFF 0x004
#define VIRTIO_MMIO_DEVID_OFF 0x008
#define VIRTIO_MMIO_VENDORID_OFF 0x00c

#define VIRTIO_MMIO_DEV_FEAT_OFF 0x010
#define VIRTIO_MMIO_DEV_FEAT_SEL_OFF 0x014

#define VIRTIO_MMIO_DRI_FEAT_OFF 0x020
#define VIRTIO_MMIO_DRI_FEAT_SEL_OFF 0x024

#define VIRTIO_MMIO_QUENE_SEL_OFF 0x030
#define VIRTIO_MMIO_QUENE_NUM_MAX_OFF 0x034
#define VIRTIO_MMIO_QUENE_NUM_OFF 0x038
#define VIRTIO_MMIO_QUENE_READY_OFF 0x044
#define VIRTIO_MMIO_QUENE_NOTIFY_OFF 0x050
#define VIRTIO_MMIO_QUENE_DESC_LO_OFF 0x080
#define VIRTIO_MMIO_QUENE_DESC_HI_OFF 0x084
#define VIRTIO_MMIO_QUENE_DRI_LO_OFF 0x090
#define VIRTIO_MMIO_QUENE_DRI_HI_OFF 0x094
#define VIRTIO_MMIO_QUENE_DEV_LO_OFF 0x0a0
#define VIRTIO_MMIO_QUENE_DEV_HI_OFF 0x0a4

#define VIRTIO_MMIO_INTR_STATUS_OFF 0x060
#define VIRTIO_MMIO_INTR_ACK_OFF 0x064

#define VIRTIO_MMIO_STATUS_OFF 0x070

#define VIRTIO_MAGIC_VALUA 0x74726976u
#define VIRTIO_VERSION 0x2

#define VIRTIO_DEV_STATUS_FIELD_ACK 1
#define VIRTIO_DEV_STATUS_FIELD_DRI 2
#define VIRTIO_DEV_STATUS_FIELD_FAIL 128
#define VIRTIO_DEV_STATUS_FIELD_FEAT_OK 8
#define VIRTIO_DEV_STATUS_FIELD_DRI_OK 4
#define VIRTIO_DEV_STATUS_FIELD_DEV_NEEDS_RST 64

#define VIRTQ_SIZE  1//TODO

#define VIRTQ_DESC_F_NEXT 1
#define VIRTQ_DESC_F_WRITE 2
#define VIRTQ_DESC_F_INDIRECT 4
#define VIRTQ_AVAIL_F_NO_INTERRUPT 1
#define VIRTQ_USED_F_NO_NOTIFY 1

typedef __attribute__ ((__packed__)) struct virtq_desc
{
  uint64_t addr;
  uint32_t len;
  uint16_t flags;
  uint16_t next;
} virtq_desc;

typedef __attribute__ ((__packed__)) struct virtq_avail {
  uint16_t flags;
  uint16_t idx;
  uint16_t ring[VIRTQ_SIZE];
  uint16_t used_event;
} virtq_avail;

typedef __attribute__ ((__packed__)) struct virtq_used {
  uint16_t flags;
  uint16_t idx;
  struct virtq_used_elem ring[VIRTQ_SIZE];
  uint16_t avail_event;
} virtq_used;

typedef __attribute__ ((__packed__)) struct virtq_used_elem {
  uint32_t id;
  uint32_t len;
} virtq_used_elem;

#endif
