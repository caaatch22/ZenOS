#include "fs/virtio.h"
#include "fs/virtio_blk.h"
#include "common/common.h"
#include "fs/buffer.h"
#include "lock/spinlock.h"
#include "arch/hw.h"
#include "mm/vm.h"
#include "utils/string.h"
#include "proc/proc.h"

extern buf_list_t virtio_blk_buf_list;
virtio_blk_dev_t virtio_blk_dev;

void virtio_blk_init(void)
{
  uint32_t status = 0;
  uint64_t feature = 0;

  if(sizeof(virtq_page_t) > 2 * PAGE_SIZE)
    PANIC("buffer too big");

  init_spinlock(&virtio_blk_dev.dev_lock, "virtio_block");
  buffer_init();

  if(*VIRTIO_MMIO_REG(VIRTIO_MMIO_MAGIC_OFF) != VIRTIO_MAGIC_VALUE || \
    *VIRTIO_MMIO_REG(VIRTIO_MMIO_VERSION_OFF) != VIRTIO_VERSION || \
    *VIRTIO_MMIO_REG(VIRTIO_MMIO_DEVID_OFF) != VIRTIO_DEV_ID_BLK) {
    PANIC("virtio dev discovery error");
  }

  status |= VIRTIO_DEV_STATUS_FIELD_ACK || VIRTIO_DEV_STATUS_FIELD_DRI;
  *VIRTIO_MMIO_REG(VIRTIO_MMIO_STATUS_OFF) = status;

  *VIRTIO_MMIO_REG(VIRTIO_MMIO_HOST_FEAT_SEL_OFF) = 0;
  feature = *VIRTIO_MMIO_REG(VIRTIO_MMIO_HOST_FEAT_OFF);
  feature &= ~(1 << VIRTIO_BLK_F_RO);
  feature &= ~(1 << VIRTIO_BLK_F_SCSI);
  feature &= ~(1 << VIRTIO_BLK_F_CONFIG_WCE);
  feature &= ~(1 << VIRTIO_BLK_F_MQ);
  feature &= ~(1 << VIRTIO_F_ANY_LAYOUT);
  feature &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
  feature &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
  *VIRTIO_MMIO_REG(VIRTIO_MMIO_HOST_FEAT_OFF) = feature;
  PANIC("%x", feature);

  //lagacy, no feature ok

  status |= VIRTIO_DEV_STATUS_FIELD_DRI_OK;
  *VIRTIO_MMIO_REG(VIRTIO_MMIO_STATUS_OFF) = status;

  *VIRTIO_MMIO_REG(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PAGE_SIZE;

  *VIRTIO_MMIO_REG(VIRTIO_MMIO_QUEUE_SEL_OFF) = 0;
  uint32_t max_num = *VIRTIO_MMIO_REG(VIRTIO_MMIO_QUEUE_NUM_MAX_OFF);
  if(max_num == 0)
    PANIC("virtqueue not supported");
  if(max_num < VIRTIO_QUEUE_SIZE)
    PANIC("device queue size too small");
  *VIRTIO_MMIO_REG(VIRTIO_MMIO_QUEUE_NUM_OFF) = VIRTIO_QUEUE_SIZE;
  memset((void*)&virtio_blk_dev.ring_page, 0, sizeof(virtio_blk_dev.ring_page));
  *VIRTIO_MMIO_REG(VIRTIO_MMIO_QUEUE_PFN_OFF) = ((uint64_t)&virtio_blk_dev.ring_page) >> PA_PPN_SHIFT;

  for(uint32_t i = 0; i < VIRTIO_QUEUE_SIZE; i++)
    virtio_blk_dev.desc_free[i] = 1;

  LOG_DEBUG("virtio ok");
}

// find a free descriptor, mark it non-free, return its index.
uint32_t alloc_desc()
{
  for(int i = 0; i < VIRTIO_QUEUE_SIZE; i++) {
    if(virtio_blk_dev.desc_free[i]){
      virtio_blk_dev.desc_free[i] = 0;
      return i;
    }
  }
  return -1;
}

void free_desc(uint32_t i)
{
  if(virtio_blk_dev.desc_free[i] != 0)
    PANIC("attempt to free a free desc");
  virtio_blk_dev.ring_page.ring.desc_q[i].addr = 0;
  virtio_blk_dev.desc_free[i] = 1;
  wakeup(&virtio_blk_dev.desc_free[0]);
}

// free a chain of descriptors.
void free_chain(uint32_t i)
{
  while(1){
    free_desc(i);
    if(virtio_blk_dev.ring_page.ring.desc_q[i].flags & VIRTQ_DESC_F_NEXT)
      i = virtio_blk_dev.ring_page.ring.desc_q[i].next;
    else
      break;
  }
}

uint32_t alloc3_desc(uint32_t *idx)
{
  for(int i = 0; i < 3; i++){
    idx[i] = alloc_desc();
    if(idx[i] < 0){
      for(int j = 0; j < i; j++)
        free_desc(idx[j]);
      return -1;
    }
  }
  return 0;
}

void virtio_disk_rw(buf_t *buf, uint32_t write)
{
  uint64_t sector = buf->sector;

  acquire_spinlock(&virtio_blk_dev.dev_lock);

  // the spec says that legacy block operations use three
  // descriptors: one for type/reserved/sector, one for
  // the data, one for a 1-byte status result.

  // allocate the three descriptors.
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&virtio_blk_dev.desc_free[0], &virtio_blk_dev.dev_lock);
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  virtio_blk_req_hdr_t buf0;

  if(write)
    buf0.type = VIRTIO_BLK_T_OUT;
  else
    buf0.type = VIRTIO_BLK_T_IN;
  buf0.reserved = 0;
  buf0.sector = sector;

  virtio_blk_dev.ring_page.ring.desc_q[idx[0]].addr = (uint64_t)&buf0;    //run in kernel pagetable, one to one mapping
  virtio_blk_dev.ring_page.ring.desc_q[idx[0]].len = sizeof(buf0);
  virtio_blk_dev.ring_page.ring.desc_q[idx[0]].flags = VIRTQ_DESC_F_NEXT;
  virtio_blk_dev.ring_page.ring.desc_q[idx[0]].next = idx[1];

  virtio_blk_dev.ring_page.ring.desc_q[idx[1]].addr = (uint64_t) buf->payload->payload;
  virtio_blk_dev.ring_page.ring.desc_q[idx[1]].len = BUFFER_SIZE;

  if(write)
    virtio_blk_dev.ring_page.ring.desc_q[idx[1]].flags = 0;
  else
    virtio_blk_dev.ring_page.ring.desc_q[idx[1]].flags = VIRTQ_DESC_F_WRITE; // device writes b->data
  virtio_blk_dev.ring_page.ring.desc_q[idx[1]].flags |= VIRTQ_DESC_F_NEXT;
  virtio_blk_dev.ring_page.ring.desc_q[idx[1]].next = idx[2];

  virtio_blk_dev.ring_page.ring.desc_q[idx[2]].addr = (uint64_t) &virtio_blk_dev.info[idx[0]].status;
  virtio_blk_dev.ring_page.ring.desc_q[idx[2]].len = 1;
  virtio_blk_dev.ring_page.ring.desc_q[idx[2]].flags = VIRTQ_DESC_F_WRITE; // device writes the status
  virtio_blk_dev.ring_page.ring.desc_q[idx[2]].next = 0;

  // record struct buf for virtio_disk_intr().
  buf->read_pending = 1;
  virtio_blk_dev.info[idx[0]].buf = buf;

  virtio_blk_dev.ring_page.ring.avail_q.ring[virtio_blk_dev.ring_page.ring.avail_q.idx % VIRTIO_QUEUE_SIZE] = idx[0];
  __sync_synchronize();
  ++ virtio_blk_dev.ring_page.ring.avail_q.idx;

  *VIRTIO_MMIO_REG(VIRTIO_MMIO_QUEUE_NOTIFY_OFF) = 0; // value is queue number

  while(buf->read_pending == 1) {
    sleep(buf, &virtio_blk_dev.dev_lock);
  }

  virtio_blk_dev.info[idx[0]].buf = 0;
  free_chain(idx[0]);

  release_spinlock(&virtio_blk_dev.dev_lock);
}

void virtio_blk_intr()
{
  acquire_spinlock(&virtio_blk_dev.dev_lock);

  while((virtio_blk_dev.index % VIRTIO_QUEUE_SIZE) != (virtio_blk_dev.ring_page.ring.used_q.idx % VIRTIO_QUEUE_SIZE)){
    int idx = virtio_blk_dev.ring_page.ring.used_q.ring[virtio_blk_dev.ring_page.ring.used_q.idx].id;

    if(virtio_blk_dev.info[idx].status != 0)
      PANIC("virtio_disk_intr status");

    virtio_blk_dev.info[idx].buf->read_pending = 0;   // disk is done with buf
    wakeup(virtio_blk_dev.info[idx].buf);

    virtio_blk_dev.ring_page.ring.used_q.idx = (virtio_blk_dev.ring_page.ring.used_q.idx + 1) % VIRTIO_QUEUE_SIZE;
  }
  *VIRTIO_MMIO_REG(VIRTIO_MMIO_INTR_ACK_OFF) = *VIRTIO_MMIO_REG(VIRTIO_MMIO_INTR_STATUS_OFF) & 0x3;

  release_spinlock(&virtio_blk_dev.dev_lock);
}
