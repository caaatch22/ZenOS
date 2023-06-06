/**
 * A small-mem allocator implement inspired by the slab-mechanism of Linux.
 * However, our design is much easier and less considered. We ignore the
 * effect of the hardware-cache by excluding the CPU struct in the kmem_cache.
 */

#include "common/common.h"
#include "arch/hw.h"
#include "mm/pmallocator.h"
#include "mm/kmalloc.h"
#include "lock/spinlock.h"


#define KMEM_OBJ_MIN_SIZE   ((uint64_t)32)
#define KMEM_OBJ_MAX_SIZE 	((uint64_t)4048)
#define KMEM_OBJ_MAX_COUNT  (PAGE_SIZE / KMEM_OBJ_MIN_SIZE)

#define TABLE_END 	255
struct kmem_node {
	// `config` is meant to keep const after kmem_node init
	struct kmem_node *next;
	struct {
		//uint64_t obj_capa;			// the capacity of each object
		uint64_t obj_size;			// the size of each object
		uint64_t obj_addr;			// the start addr of first avail object
	} config;
	uint8_t avail;		// current available obj num
	uint8_t cnt;		// current allocated count of obj
	// size of `next` is not fixed according to config.obj_size
	uint8_t table[KMEM_OBJ_MAX_COUNT];	// linked list table,
};

// the size of fixed part in kmem_node
#define KMEM_NODE_FIX \
	(sizeof(struct kmem_node*) + 2 * sizeof(uint64_t) + 2 * sizeof(uint8_t))

struct kmem_allocator {
	struct spinlock lock;		// the lock to protect this allocator
	uint32_t obj_size;				// the obj size that allocator allocates
	uint16_t npages;
	uint16_t nobjs;
	struct kmem_node *list;		// point to first kmem_node
	struct kmem_allocator *next;	// point to next kmem_allocator

};

// the first allocator to allocate other allocators
struct kmem_allocator kmem_adam;

#define KMEM_TABLE_SIZE 	17
struct kmem_allocator *kmem_table[KMEM_TABLE_SIZE];
struct spinlock kmem_table_lock;

// hash map func
#define _hash(n) \
	((n) % KMEM_TABLE_SIZE)

#define ROUNDUP16(n) \
	(((n) + 15) & ~0x0f)

// as kmalloc() use pm_alloc() and pm_free,
// kmallocinit() should be called at least after kpminit()
void kmallocinit(void) {
	// init adam
	init_spinlock(&(kmem_adam.lock), "kmem_adam");
	kmem_adam.list = NULL;
	kmem_adam.next = NULL;
	kmem_adam.npages = 0;
	kmem_adam.nobjs = 0;
	kmem_adam.obj_size =
			ROUNDUP16(sizeof(struct kmem_allocator));

	// init kmem_table
	for (uint8_t i = 0; i < KMEM_TABLE_SIZE; i++) {
		kmem_table[i] = NULL;
	}
	int hash = _hash(kmem_adam.obj_size);
	kmem_table[hash] = &kmem_adam;
	init_spinlock(&kmem_table_lock, "kmem_table");

	// LOG_INFO("kmallocinit", "KMEM_NODE_FIX: %d\n", KMEM_NODE_FIX);
	// LOG_INFO("kmalloc", "init\n");
}

// the question comes that whether we should free an allocator?
// when should we do this?

// current solution doesn't not free an allocator

#define _malloc_allocator() \
	((struct kmem_allocator*)kmalloc(sizeof(struct kmem_allocator)))

// to calculate the capa
#define _calc_capa(roundup_size) \
	((PAGE_SIZE - ROUNDUP16(KMEM_NODE_FIX)) / ((roundup_size) + 1))

// get the allocator for coming allocation
// `raw_size` means the size may not be aligned
static struct kmem_allocator *get_allocator(uint64_t raw_size) {
	uint64_t roundup_size = ROUNDUP16(raw_size);
	uint64_t hash = _hash(roundup_size);

	// search if allocator already in table
	// if allocator exists, then kem_table_lock wouldn't be acquired
	for (struct kmem_allocator *tmp = kmem_table[hash];
			NULL != tmp; tmp = tmp->next) {
		if (roundup_size == tmp->obj_size) {
			return tmp;
		}
	}

	// enter critical section
	acquire_spinlock(&kmem_table_lock);
	// if the previous update have created the allocator
	// needed here
	if (NULL != kmem_table[hash] &&
			kmem_table[hash]->obj_size == roundup_size) {
		release_spinlock(&kmem_table_lock);
		return kmem_table[hash];
	}

	// if not found, then create

	// as sizeof(struct kmem_allocator) is guaranteed an
	// allocator at init time, `_malloc_allocator()` should
	// not enter `critical section` when calling `get_allocator()`
	struct kmem_allocator *tmp = _malloc_allocator();
	if (NULL != tmp) {
		init_spinlock(&(tmp->lock), "kmem_alloc");
		tmp->list = NULL;
		tmp->obj_size = roundup_size;
		tmp->npages = 0;
		tmp->nobjs = 0;
		tmp->next = kmem_table[hash];
		kmem_table[hash] = tmp;
	}

	release_spinlock(&kmem_table_lock);
	// leave critical section

	return tmp;
}

void *kmalloc(uint32_t size) {
	// border check for `size`
	if (KMEM_OBJ_MIN_SIZE > size) {
		LOG_WARN("size %d too small, reset to %d\n", size, KMEM_OBJ_MIN_SIZE);
		size = KMEM_OBJ_MIN_SIZE;
	}
	else if (KMEM_OBJ_MAX_SIZE < size) {
		LOG_DEBUG("size %d out of border\n", size);
		return NULL;
	}
	struct kmem_allocator *alloc = get_allocator(size);
	// if failed to alloc
	if (NULL == alloc) {
		LOG_DEBUG("fail to get allocator\n");
		return NULL;
	}
	// enter critical section `alloc`
	acquire_spinlock(&(alloc->lock));

	// if no page available
	if (NULL == alloc->list) {
		struct kmem_node *tmp = (struct kmem_node*)pm_alloc();
		if (NULL == tmp) {
			release_spinlock(&(alloc->lock));
			LOG_WARN("fail to allocate a node\n");
			return NULL;
		}

		LOG_INFO("get one page\n");

		alloc->npages++;

		uint32_t roundup_size = ROUNDUP16(size);
		uint8_t capa = _calc_capa(roundup_size);
		tmp->next = NULL;
		tmp->config.obj_size = roundup_size;
		tmp->config.obj_addr = (uint64_t)tmp + ROUNDUP16(KMEM_NODE_FIX + capa);

		tmp->avail = 0;
		tmp->cnt = 0;
		for (uint8_t i = 0; i < capa - 1; i ++) {
			tmp->table[i] = i + 1;
		}
		tmp->table[capa - 1] = TABLE_END;

		alloc->list = tmp;
	}

	alloc->nobjs++;

	// now the allocator should be ready
	struct kmem_node *node = alloc->list;
	void *ret;		// the address to be returned
	ret = (void*)(node->config.obj_addr +
			((uint64_t)node->avail) * node->config.obj_size);
	// update `avail` and `cnt`
	node->cnt += 1;
	node->avail = node->table[node->avail];

	// if kmem_node is fully allocated
	if (TABLE_END == node->avail) {
		alloc->list = node->next;
	}

	release_spinlock(&(alloc->lock));
	// leave critical section `alloc`

	return ret;
}

// `addr` must be an address that's allocated before, pass an unallocated
// address may cause undetectable troubles.
void kfree(void *addr) {
	struct kmem_node *node = (struct kmem_node*)PAGE_ROUNDDOWN((uint64_t)addr);
	uint8_t avail = ((uint64_t)addr - node->config.obj_addr) / node->config.obj_size;

	struct kmem_allocator *alloc = get_allocator(node->config.obj_size);

	// LOG_INFO("kfree", "alloc: %p, addr: %p\n", alloc, addr);
	// enter critical section `alloc`
	acquire_spinlock(&(alloc->lock));

	alloc->nobjs--;

	// if `node` used to be fully allocated, then re-link it to `alloc`
	if (TABLE_END == node->avail) {
		node->next = alloc->list;
		alloc->list = node;
		// LOG_INFO("kfree", "pickup\n");
	}

	// node should be on alloc->list
	node->table[avail] = node->avail;
	node->avail = avail;
	node->cnt -= 1;

	// if kmem_node has no allocated obj
	if (0 == node->cnt) {
		// LOG_INFO("kfree", "drop\n");
		struct kmem_node **pprev = &(alloc->list);
		struct kmem_node *tmp = alloc->list;

		while (NULL != tmp && node != tmp) {
			pprev = &(tmp->next);
			tmp = tmp->next;
		}
		if (NULL == tmp) {
			LOG_DEBUG("free", "NULL == tmp\n");
			PANIC("kfree(): linked list broken!\n");
		}

		#ifdef DEBUG
		// display linked list of kmem_allocator
		for (struct kmem_node *it = alloc->list; NULL != it; it = it->next) {
			printf("%p -> ", it);
		}
		printf("\n");
		#endif

		*pprev = tmp->next;
		// LOG_INFO("kfree", "alloc->list = %p\n", alloc->list);
		// LOG_INFO("kfree", "tmp = %p\n", tmp);

		pm_free((pm_page_node *)node);
		alloc->npages--;

		LOG_INFO("kmalloc", "free one page\n");
	}

	release_spinlock(&(alloc->lock));
	// leave critical section `alloc`
}

// display the content of kmem_allocator
static void km_view_allocator(struct kmem_allocator *alloc) {
	// enter critical section
	acquire_spinlock(&(alloc->lock));

	LOG_INFO("\nkmem_allocator: size %d, addr: %p taken %d page(s), allocated %d obj(s)\n",
			alloc->obj_size, alloc, alloc->npages, alloc->nobjs);
	// LOG_INFO("kmem_allocator", "size %d, addr: %p\n",
	// 		alloc->obj_size, alloc);
	for (struct kmem_node *node = alloc->list; NULL != node; node = node->next) {
		LOG_INFO(
			"\tkmem_node:\n"
			"\tconfig.obj_size: %d\n"
			"\tconfig.obj_addr: %p\n"
			"\tavail: %d\n"
			"\tcnt: %d\n",
			node->config.obj_size,
			node->config.obj_addr,
			node->avail,
			node->cnt
		);
		print("\t[");
		for (uint8_t i = node->avail; TABLE_END != i; i = node->table[i]) {
			print("%d ", i);
		}
		print("]\n");
	}

	release_spinlock(&(alloc->lock));
	// leave critical section
}

// for debugging
void kmview(void)
{
	// display all the content in kmem_table

	// enter critical section
	acquire_spinlock(&kmem_table_lock);

	for (int i = 0; i < KMEM_TABLE_SIZE; i ++) {
		struct kmem_allocator *alloc = kmem_table[i];

		while (NULL != alloc) {
			km_view_allocator(alloc);
			alloc = alloc->next;
		}
	}

	release_spinlock(&kmem_table_lock);
	// leave critical section
}
