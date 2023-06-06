#ifndef __FILE_H
#define __FILE_H

#include "lock/spinlock.h"
#include "common/common.h"

struct poll_table;
struct file {
  enum { FD_NONE, FD_PIPE, FD_INODE, FD_DEVICE } type;
  int               ref;       // reference count
  char              readable;
  char              writable;
  struct pipe       *pipe;     // FD_PIPE
  uint32_t              off;       // the offset of dentry within a directory
  short             major;     // FD_DEVICE
  struct inode      *ip;

  struct spinlock  lock;        // haven't been used

  uint32_t (*poll)(struct file *, struct poll_table *);  // for poll/select
};


// used by readv / writev
struct iovec {
	void *iov_base; /* Starting address */
	uint64_t iov_len; /* Number of bytes to transfer */
};
// #define major(dev)  ((dev) >> 16 & 0xFFFF)
// #define minor(dev)  ((dev) & 0xFFFF)
// #define	mkdev(m,n)  ((uint)((m)<<16| (n)))

// map major device number to device functions.
struct devsw {
  int (*read)(int, uint64_t, int);
  int (*write)(int, uint64_t, int);
};

extern struct devsw devsw[];

#define CONSOLE 1

struct file*    filealloc(void);
void            fileclose(struct file*);
struct file*    filedup(struct file*);
// void            fileinit(void);
int             fileread(struct file*, uint64_t, int n);
int             filestat(struct file*, uint64_t addr);
int             filewrite(struct file*, uint64_t, int n);
int             filereaddir(struct file *f, uint64_t addr, uint64_t len);

int             filereadv(struct file *f, struct iovec ioarr[], int count);
int             filewritev(struct file *f, struct iovec ioarr[], int count);

struct file *   fd2file(int fd);
#endif
