#ifndef VIRTIO_BLK_H
#define VIRTIO_BLK_H

#include "virtio.h"
#include "spinlock.h"
#include "buffer.h"

#ifndef VIRTIO_QUEUE_SIZE
#define VIRTIO_QUEUE_SIZE (BUFFER_MAX_NUM & ~1l)
#define VIRTIO_DESC_RING_SIZE (16 * VIRTIO_QUENE_SIZE)
#define VIRTIO_AVAIL_RING_SIZE (6 + 2 * VIRTIO_QUENE_SIZE)
#define VIRTIO_USED_RING_SIZE (6 + 8 * VIRTIO_QUENE_SIZE)
#endif

#define VIRTIO_DEV_ID_BLK 2

#define VIRTIO_BLK_F_SIZE_MAX 1
#define VIRTIO_BLK_F_SEG_MAX 2
#define VIRTIO_BLK_F_GEOMETRY 4
#define VIRTIO_BLK_F_RO 5
#define VIRTIO_BLK_F_BLK_SIZE 6
#define VIRTIO_BLK_F_FLUSH 9
#define VIRTIO_BLK_F_TOPOLOGY 10
#define VIRTIO_BLK_F_CONFIG_WCE 11
#define VIRTIO_BLK_F_DISCARD 13
#define VIRTIO_BLK_F_WRITE_ZEROES 14
#define VIRTIO_BLK_F_SCSI 7
#define VIRTIO_BLK_F_MQ 12
#define VIRTIO_F_ANY_LAYOUT 27
#define VIRTIO_RING_F_INDIRECT_DESC 28
#define VIRTIO_RING_F_EVENT_IDX 29


typedef struct virtio_blk_config {
  uint64_t capacity;
  uint32_t size_max;
  uint32_t seg_max;
  struct virtio_blk_geometry {
    uint16_t cylinders;
    uint8_t heads;
    uint8_t sectors;
  } geometry;
  uint32_t blk_size;
  struct virtio_blk_topology {
    uint8_t physical_block_exp;
    uint8_t alignment_offset;
    uint16_t min_to_size;
    uint32_t opt_to_size;
  } topology;
  uint8_t write_back;
  uint8_t unused0[3];
  uint32_t max_discard_sectors;
  uint32_t max_discard_seg;
  uint32_t discard_sector_alignment;
  uint32_t max_write_zeroes_sectors;
  uint32_t max_write_zeroes_seg;
  uint8_t write_zeroes_may_unmap;
  uint8_t unused1[3];
} __attribute__((__packed__)) virtio_blk_config;

#define VIRTIO_BLK_T_IN 0
#define VIRTIO_BLK_T_OUT 1
#define VIRTIO_BLK_T_FLUSH 4
#define VIRTIO_BLK_T_DISCARD 11
#define VIRTIO_BLK_T_WRITE_ZEROES 13

#define VIRTIO_BLK_S_OK 0
#define VIRTIO_BLK_S_IOERR 1
#define VIRTIO_BLK_S_UNSUPP 2

typedef struct virtio_blk_req_hdr {
  uint32_t type;
  uint32_t reserved;
  uint64_t sector;
  uint8_t *data;
} __attribute__ ((__packed__)) virtio_blk_req_hdr_t;

typedef struct virtio_blk_dev {
  union {
    uint8_t padding[PAGE_SIZE * 2];
    struct virtq_page ring;
  } ring_page;

  uint8_t desc_free[VIRTIO_QUEUE_SIZE];
  uint16_t index;

  struct {
    struct buf *buf;
    uint8_t status;
  } info[VIRTIO_QUEUE_SIZE];

  spinlock_t dev_lock;
} __attribute__ ((aligned (PAGE_SIZE))) virtio_blk_dev_t;

void virtio_blk_init(void);
void virtio_blk_rw(uint64_t, buf_t *, uint8_t);

#endif
