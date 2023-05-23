#include "buffer.h"
#include "defs.h"
#include "pmallocator.h"
#include "spinlock.h"
#include "log.h"
#include "virtio.h"

buf_list_t virtio_blk_buf_list;

void buffer_init(void)
{
  uint32_t count, buffer_index = 0;
  uint64_t pagehead, bufferhead;

  init_spinlock(&virtio_blk_buf_list.buffer_lock, "virtio_blk_buf_lock");

  for (count = 0; count < BUFFER_PAGE_OCCUPY; ++count) {
    pagehead = (uint64_t)pm_alloc();

    for (bufferhead = pagehead; (bufferhead - pagehead) <= (PAGE_SIZE - BUFFER_SIZE); bufferhead+=BUFFER_SIZE) {
      virtio_blk_buf_list.buf_array[buffer_index].payload = (struct buf_payload *)bufferhead;
      // init LRU cycle
      if(count == 0 && pagehead == bufferhead) {
        virtio_blk_buf_list.head = &virtio_blk_buf_list.buf_array[buffer_index];
        virtio_blk_buf_list.buf_array[buffer_index].next = &virtio_blk_buf_list.buf_array[buffer_index];
        virtio_blk_buf_list.buf_array[buffer_index].prev = &virtio_blk_buf_list.buf_array[buffer_index];
      }
      else {
        virtio_blk_buf_list.buf_array[buffer_index].prev = virtio_blk_buf_list.head;
        virtio_blk_buf_list.buf_array[buffer_index].next = virtio_blk_buf_list.head->next;
        virtio_blk_buf_list.buf_array[buffer_index].next->prev = &virtio_blk_buf_list.buf_array[buffer_index];
        virtio_blk_buf_list.buf_array[buffer_index].prev->next = &virtio_blk_buf_list.buf_array[buffer_index];
        virtio_blk_buf_list.head = &virtio_blk_buf_list.buf_array[buffer_index];
      }

      virtio_blk_buf_list.buf_array[buffer_index].vaild = 0;
    }
  }

  for (count = 0; count < BUFFER_HASH_SIZE; ++count) {
    virtio_blk_buf_list.hash.map[count] = NULL;
  }

}

buf_t *buffer_hash_search(uint64_t sector, buf_hash_map_t *hash)
{
  uint32_t count;
  for (count = 0; count < BUFFER_HASH_SIZE; ++count) {
    if (hash->map[(sector % BUFFER_HASH_SIZE + count) % BUFFER_HASH_SIZE]->sector == sector) // if collide, move to next slot;
      return hash->map[(sector % BUFFER_HASH_SIZE + count) % BUFFER_HASH_SIZE]->buf;
  }
  return NULL;
}

void buffer_hash_insert(buf_t *buf, buf_hash_map_t *hash)
{
  uint32_t count;
  for (count = 0; count < BUFFER_HASH_SIZE; ++count) {
    if(hash->map[(buf->sector%BUFFER_HASH_SIZE+count)%BUFFER_HASH_SIZE]==NULL) {
      hash->map[(buf->sector % BUFFER_HASH_SIZE + count) % BUFFER_HASH_SIZE] = buf;
      return;
    }
  }
  PANIC("attempt to insert to a full hash map");
  return;
}

void buffer_hash_delete(buf_t *buf, buf_hash_map_t *hash) {
  uint32_t count;
  for (count = 0; count < BUFFER_HASH_SIZE; ++count) {
    if(hash->map[(buf->sector%BUFFER_HASH_SIZE+count)%BUFFER_HASH_SIZE]->sector == buf->sector) {
      hash->map[(buf->sector % BUFFER_HASH_SIZE + count) % BUFFER_HASH_SIZE] = NULL;
      return;
    }
  }
  PANIC("attempt to delect a non-exist buf from hash");
  return;
}

buf_t *buffer_fetch(uint64_t sector, buf_list_t *buf_list)
{
  acquire_spinlock(&buf_list->buffer_lock);

  buf_t *target;
  target = buffer_hash_search(sector, &buf_list->hash);

  if(!target) {
    target = buffer_alloc(buf_list);
    virtio_blk_read(sector, target);
    target->dirty = 0;
    target->vaild = 1;
    buffer_hash_insert(target, &buf_list->hash);
  }

  buffer_lru_top(target, buf_list);

  release_spinlock(&buf_list->buffer_lock);

  return target;
}

buf_t *buffer_alloc(buf_list_t *buf_list)
{

}
