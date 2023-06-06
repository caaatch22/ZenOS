#ifndef BUFFER_H
#define BUFFER_H

#include "mm/pmallocator.h"
#include "lock/spinlock.h"
#include "lock/sleeplock.h"

#define BUFFER_SIZE 512
#define BUFFER_PAGE_OCCUPY 5
#define BUFFER_MAX_NUM ((uint64_t)(PAGE_SIZE / BUFFER_SIZE) * BUFFER_PAGE_OCCUPY) // allocated mem is not consecutive, so num is counted by page num;

#define BUFFER_HASH_SIZE BUFFER_MAX_NUM //TODO

typedef struct buf_hash_elem
{
  uint64_t sector;
  uint32_t dev_id;
  struct buf *buf;
} buf_hash_elem_t;

typedef struct buf_hash_map {
  struct buf_hash_elem map[BUFFER_HASH_SIZE];
} buf_hash_map_t;

struct buf_payload
{
  uint8_t payload[BUFFER_SIZE];
};

typedef struct buf {
  struct buf_payload *payload;
  uint32_t ref;
  uint8_t vaild;
  uint32_t dev_id;
  uint64_t sector;
  uint8_t dirty;
  uint8_t read_pending;
  uint8_t using;
  struct buf *next;
  struct buf *prev;
  struct sleeplock lock;
} buf_t;

typedef struct buf_list {
  struct buf buf_array[BUFFER_MAX_NUM];
  struct buf *head;
  struct buf_hash_map hash;
  spinlock_t buffer_lock;
} buf_list_t;

void buffer_init(void);                                  // buffer init;
buf_t *buffer_fetch(uint32_t, uint64_t, buf_list_t *);             // get a buf according a sector (use hash search to get its pointer) if no item found, alloc a buf and fetch it from the disk;
buf_t *buffer_hash_search(uint32_t, uint64_t, buf_hash_map_t *);   // hash search sector->pointer, if none, return null;
buf_t *buffer_alloc(buf_list_t *);                       // buf allocator, use a LRU scheme, if no existing free buf, evict the last one;
void buffer_evict(buf_t *, buf_list_t *);                // evict the elem from the lru list and delete its item in hash_map, if dirty, writeback;
void buffer_lru_top(buf_t *, buf_list_t *);
void buffer_flush(buf_t *);
void buffer_list_flush(buf_list_t *);
void buffer_release(buf_t *);

void buffer_hash_insert(buf_t *, buf_hash_map_t *); // insert a buf to its slot in hash map;
void buffer_hash_delete(buf_t *, buf_hash_map_t *); // delete a buf from hash map;

#endif
