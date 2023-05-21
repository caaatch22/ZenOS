#ifndef VIRTIO_BLK_H
#define VIRTIO_BLK_H

#include "virtio.h"
#include "spinlock.h"

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
} __attribute__ ((__packed__)) virtio_blk_config;

#define VIRTIO_BLK_T_IN 0
#define VIRTIO_BLK_T_OUT 1
#define VIRTIO_BLK_T_FLUSH 4
#define VIRTIO_BLK_T_DISCARD 11
#define VIRTIO_BLK_T_WRITE_ZEROES 13

#define VIRTIO_BLK_S_OK 0
#define VIRTIO_BLK_S_IOERR 1
#define VIRTIO_BLK_S_UNSUPP 2

typedef struct virtio_blk_req {
  uint32_t type;
  uint32_t reserved;
  uint64_t sector;
  uint8_t *data;
  uint8_t status;
} __attribute__ ((__packed__))  virtio_blk_req_t;

typedef struct block_dev {
  virtq_desc_t *desc_table;
  virtq_avail_t *avail_ring;
  virtq_used_t *used_ring;

  uint8_t desc_used[VIRTQ_SIZE];

  spinlock_t dev_lock;


} block_dev_t;

void virtio_blk_init(void);

#endif
