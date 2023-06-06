#include "fs/buffer.h"
#include "common/common.h"
#include "mm/pmallocator.h"
#include "lock/spinlock.h"
#include "fs/virtio_blk.h"
#include "fs/vfs.h"

extern struct blk_ops blk_op_table[];

buf_list_t blk_buf_list;

void buffer_init(void)
{
  uint32_t count, buffer_index = 0;
  uint64_t pagehead, bufferhead;

  init_spinlock(&blk_buf_list.buffer_lock, "blk_buf_lock");

  for (count = 0; count < BUFFER_PAGE_OCCUPY; ++count) {
    pagehead = (uint64_t)pm_alloc();

    for (bufferhead = pagehead; (bufferhead - pagehead) <= (PAGE_SIZE - BUFFER_SIZE); bufferhead+=BUFFER_SIZE) {
      blk_buf_list.buf_array[buffer_index].payload = (struct buf_payload *)bufferhead;
      // init LRU cycle
      if(count == 0 && pagehead == bufferhead) {
        blk_buf_list.head = &blk_buf_list.buf_array[buffer_index];
        blk_buf_list.buf_array[buffer_index].next = &blk_buf_list.buf_array[buffer_index];
        blk_buf_list.buf_array[buffer_index].prev = &blk_buf_list.buf_array[buffer_index];
      }
      else {
        blk_buf_list.buf_array[buffer_index].prev = blk_buf_list.head;
        blk_buf_list.buf_array[buffer_index].next = blk_buf_list.head->next;
        blk_buf_list.buf_array[buffer_index].next->prev = &blk_buf_list.buf_array[buffer_index];
        blk_buf_list.buf_array[buffer_index].prev->next = &blk_buf_list.buf_array[buffer_index];
        blk_buf_list.head = &blk_buf_list.buf_array[buffer_index];
      }

      blk_buf_list.buf_array[buffer_index].vaild = 0;
    }
  }

  for (count = 0; count < BUFFER_HASH_SIZE; ++count) {
    blk_buf_list.hash.map[count].buf = NULL;
    blk_buf_list.hash.map[count].dev_id = (uint32_t)-1;
    blk_buf_list.hash.map[count].sector = (uint64_t)-1;
  }
}

buf_t *buffer_hash_search(uint32_t dev_id, uint64_t sector, buf_hash_map_t *hash)
{
  uint32_t count;
  for (count = 0; count < BUFFER_HASH_SIZE; ++count) {
    if (hash->map[(sector + count) % BUFFER_HASH_SIZE].buf != NULL && \
        hash->map[(sector + count) % BUFFER_HASH_SIZE].sector == sector && \
        hash->map[(sector + count) % BUFFER_HASH_SIZE].dev_id == dev_id ) // if collide, move to next slot;
      return hash->map[(sector + count) % BUFFER_HASH_SIZE].buf;

    if(hash->map[(sector + count) % BUFFER_HASH_SIZE].buf == NULL)
      break;
  }
    return NULL;
}

void buffer_hash_insert(buf_t *buf, buf_hash_map_t *hash)
{
  uint32_t count;
  for (count = 0; count < BUFFER_HASH_SIZE; ++count) {
    if(hash->map[(buf->sector % BUFFER_HASH_SIZE + count) % BUFFER_HASH_SIZE].buf == NULL) {
      hash->map[(buf->sector % BUFFER_HASH_SIZE + count) % BUFFER_HASH_SIZE].buf = buf;
      hash->map[(buf->sector % BUFFER_HASH_SIZE + count) % BUFFER_HASH_SIZE].sector = buf->sector;
      hash->map[(buf->sector % BUFFER_HASH_SIZE + count) % BUFFER_HASH_SIZE].dev_id = buf->dev_id;
      return;
    }
  }
  PANIC("attempt to insert to a full hash map");
  return;
}

void buffer_hash_delete(buf_t *buf, buf_hash_map_t *hash) {
  uint32_t count;
  for (count = 0; count < BUFFER_HASH_SIZE; ++count) {
    if(hash->map[(buf->sector%BUFFER_HASH_SIZE+count)%BUFFER_HASH_SIZE].sector == buf->sector && \
       hash->map[(buf->sector%BUFFER_HASH_SIZE+count)%BUFFER_HASH_SIZE].dev_id == buf->dev_id ) {
      hash->map[(buf->sector % BUFFER_HASH_SIZE + count) % BUFFER_HASH_SIZE].buf = NULL;
      return;
    }
  }
  PANIC("attempt to delect a non-exist buf from hash");
  return;
}

buf_t *buffer_fetch(uint32_t dev_id, uint64_t sector, buf_list_t *buf_list)
{
  acquire_spinlock(&buf_list->buffer_lock);
  buf_t *target;
  target = buffer_hash_search(dev_id, sector, &buf_list->hash);

  if(!target) {
    target = buffer_alloc(buf_list);
    target->sector = sector;
    target->dev_id = dev_id;
    target->read_pending = 1;
    init_sleeplock(&target->lock,"buffer_lock");
    buffer_hash_insert(target, &buf_list->hash);

    release_spinlock(&buf_list->buffer_lock);

    acquire_sleeplock(&target->lock);


    blk_op_table[dev_id].rw(target, 0); // will request a read and sleep;
    release_sleeplock(&target->lock);
    acquire_spinlock(&buf_list->buffer_lock);
    target->dirty = 0;
    target->vaild = 1;
    target->read_pending = 0;
    buffer_hash_insert(target, &buf_list->hash);
  }

  while (target->read_pending == 1)
    ;
  buffer_lru_top(target, buf_list);

  release_spinlock(&buf_list->buffer_lock);
  acquire_sleeplock(&target->lock);
  return target;
}

buf_t *buffer_alloc(buf_list_t *buf_list)
{
  buf_t *buf = buf_list->head->next;

  if(buf->vaild != 0)
    buffer_evict(buf, buf_list);

  return buf;
}

void buffer_release(buf_t *buf) {
  release_sleeplock(&buf->lock);
}

void buffer_evict(buf_t *buf, buf_list_t *buf_list)
{
  acquire_sleeplock(&buf->lock);
  if(buf->vaild != 1)
    PANIC("attempt to evict a unvaild buffer");

  if(buf->dirty == 1)
    buffer_flush(buf);
  buffer_hash_delete(buf, &buf_list->hash);

  buf->vaild = 0;
  release_sleeplock(&buf->lock);
}

void buffer_lru_top(buf_t *buf, buf_list_t *buf_list)
{
  if(buf->vaild != 1)
    PANIC("attempt to top a unvaild buffer");

  buf->next->prev = buf->prev;
  buf->prev->next = buf->next;

  buf->prev = buf_list->head;
  buf->next = buf_list->head->next;
  buf->prev->next = buf;
  buf->next->prev = buf;
  buf_list->head = buf;

}

void buffer_flush(buf_t *buf)
{
  blk_op_table[buf->dev_id].rw(buf, 1);
}

void buffer_list_flush(buf_list_t *buf_list)
{
  acquire_spinlock(&buf_list->buffer_lock);
  int count;
  for (count = 0; count < BUFFER_MAX_NUM && buf_list->buf_array[count].vaild == 1 ; ++count) {
    if(buf_list->buf_array[count].dirty == 1)
      buffer_flush(&buf_list->buf_array[count]);
  }
  release_spinlock(&buf_list->buffer_lock);
}
