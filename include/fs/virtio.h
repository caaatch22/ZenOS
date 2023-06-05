#ifndef VIRTIO_H
#define VIRTIO_H

#include "common/common.h"
#include "arch/hw.h"
#include "fs/virtio_blk.h"
#include "fs/buffer.h"

#ifndef VIRTIO_QUEUE_SIZE
#define VIRTIO_QUEUE_SIZE (BUFFER_MAX_NUM & ~1l)
#define VIRTIO_DESC_RING_SIZE (16 * VIRTIO_QUENE_SIZE)
#define VIRTIO_AVAIL_RING_SIZE (6 + 2 * VIRTIO_QUENE_SIZE)
#define VIRTIO_USED_RING_SIZE (6 + 8 * VIRTIO_QUENE_SIZE)
#endif



#define VIRTIO_MMIO_REG(offset) ((volatile uint32_t *)(VIRT_MMIO_VIRTIO_BASE + offset))

#define VIRTIO_MMIO_MAGIC_OFF 0x000
#define VIRTIO_MMIO_VERSION_OFF 0x004
#define VIRTIO_MMIO_DEVID_OFF 0x008
#define VIRTIO_MMIO_VENDORID_OFF 0x00c

#define VIRTIO_MMIO_HOST_FEAT_OFF 0x010
#define VIRTIO_MMIO_HOST_FEAT_SEL_OFF 0x014

#define VIRTIO_MMIO_GUEST_FEAT_OFF 0x020
#define VIRTIO_MMIO_GUEST_FEAT_SEL_OFF 0x024
#define VIRTIO_MMIO_GUEST_PAGE_SIZE 0x028


#define VIRTIO_MMIO_QUEUE_SEL_OFF 0x030
#define VIRTIO_MMIO_QUEUE_NUM_MAX_OFF 0x034
#define VIRTIO_MMIO_QUEUE_NUM_OFF 0x038
#define VIRTIO_MMIO_QUEUE_ALIGN_OFF 0x03c
#define VIRTIO_MMIO_QUEUE_PFN_OFF 0x40
#define VIRTIO_MMIO_QUEUE_READY 0x044
#define VIRTIO_MMIO_QUEUE_NOTIFY_OFF 0x050

#define VIRTIO_MMIO_QUEUE_DESC_LO_OFF 0x080
#define VIRTIO_MMIO_QUEUE_DESC_HI_OFF 0x084
#define VIRTIO_MMIO_QUEUE_DRI_LO_OFF 0x090
#define VIRTIO_MMIO_QUEUE_DRI_HI_OFF 0x094
#define VIRTIO_MMIO_QUEUE_DEV_LO_OFF 0x0a0
#define VIRTIO_MMIO_QUEUE_DEV_HI_OFF 0x0a4

#define VIRTIO_MMIO_INTR_STATUS_OFF 0x060
#define VIRTIO_MMIO_INTR_ACK_OFF 0x064

#define VIRTIO_MMIO_STATUS_OFF 0x070

#define VIRTIO_MAGIC_VALUE 0x74726976u
#define VIRTIO_VERSION 0x1 //use legacy

#define VIRTIO_DEV_STATUS_FIELD_ACK 1
#define VIRTIO_DEV_STATUS_FIELD_DRI 2
#define VIRTIO_DEV_STATUS_FIELD_FAIL 128
#define VIRTIO_DEV_STATUS_FIELD_FEAT_OK 8
#define VIRTIO_DEV_STATUS_FIELD_DRI_OK 4
#define VIRTIO_DEV_STATUS_FIELD_DEV_NEEDS_RST 64

#define VIRTQ_DESC_F_NEXT 1
#define VIRTQ_DESC_F_WRITE 2
#define VIRTQ_DESC_F_INDIRECT 4
#define VIRTQ_AVAIL_F_NO_INTERRUPT 1
#define VIRTQ_USED_F_NO_NOTIFY 1

#define VIRTIO_F_RING_INDIRECT_DESC 28
#define VIRTIO_F_RING_EVENT_IDX 29
#define VIRTIO_F_VERSION_1 32
#define VIRTIO_F_ACCESS_PLATFORM 33
#define VIRTIO_F_RING_PACKED 34
#define VIRTIO_F_IN_ORDER 35
#define VIRTIO_F_ORDER_PLATFORM 36
#define VIRTIO_F_SR_IOV 37
#define VIRTIO_F_NOTIFICATION_DATA 38

typedef struct virtq_desc
{
  uint64_t addr;
  uint32_t len;
  uint16_t flags;
  uint16_t next;
} __attribute__ ((__packed__)) virtq_desc_t;

typedef struct virtq_avail {
  uint16_t flags;
  uint16_t idx;
  uint16_t ring[VIRTIO_QUEUE_SIZE];
  uint16_t used_event;
} __attribute__ ((__packed__)) virtq_avail_t;

typedef struct virtq_used_elem {
  uint32_t id;
  uint32_t len;
} __attribute__ ((__packed__)) virtq_used_elem_t;

typedef struct virtq_used {
  uint16_t flags;
  uint16_t idx;
  struct virtq_used_elem ring[VIRTIO_QUEUE_SIZE];
  uint16_t avail_event;
} __attribute__ ((__packed__)) virtq_used_t;

typedef struct virtq_page {
  struct virtq_desc desc_q[VIRTIO_QUEUE_SIZE];
  struct virtq_avail avail_q;
  uint16_t padding[VIRTIO_QUEUE_SIZE & 1];
  struct virtq_used used_q;
} __attribute__((__packed__)) virtq_page_t;


#endif
