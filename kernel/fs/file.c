#include "common/common.h"
#include "fs/file.h"
#include "fs/fstat.h"
#include "proc/proc.h"
#include "mm/kmalloc.h"
#include "utils/string.h"
#include "fs/pipe.h"
// Allocate a file structure.

struct devsw devsw[MAX_DEV_NUM];

struct file *filealloc(void)
{
  struct file *f;
  f = (struct file *)kmalloc(sizeof(struct file));
  if (f == NULL) {
    return NULL;
  }

  f->ref = 1;
  return f;
}

// Increment ref count for file f.
struct file *filedup(struct file *f)
{
  // acquire(&ftable.lock);
  if(f->ref < 1)
    PANIC("filedup");
  f->ref++;
  // release(&ftable.lock);
  return f;
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void fileclose(struct file *f)
{
  if(f->ref < 1)
    PANIC("fileclose");
  if(--f->ref > 0){
    return;
  }

  if(f->type == FD_PIPE){
    pipeclose(f->pipe, f->writable);
  } else if (f->type == FD_INODE) {
    iput(f->ip);
  } else if (f->type == FD_DEVICE) {

  }

  kfree(f);
}

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
// XXX file->mode is temporary, need to change it to fit POSIX
int filestat(struct file *f, uint64_t addr)
{
  // struct proc *p = myproc();
  struct kstat st;

  if(f->type == FD_INODE){
    ilock(f->ip);
    f->ip->op->getattr(f->ip, &st);
    iunlock(f->ip);
    // if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
  } else if(f->type == FD_DEVICE){
    //f->ip->op->getattr(f->ip, &st);
    memset(&st, 0, sizeof(st));
    st.mode = 8192;
    st.ino_num = 2;
    st.rdev = 2;
    //st.blocks = 18446744073709551615;
  } else {
    return -1;
  }

  switch (st.mode)  // 加上POSIX的stat的mode
  {
  case 1: st.mode = (S_IFDIR|0x1ff);break;
  case 2: st.mode = (S_IFREG|0x1ff);break;
  case 3: st.mode = (S_IFBLK|0x1ff);break;
  default:
    print("in file.c: filestat: unrecognized st.mode: %d\n", st.mode);
    break;
  }

  // temper thing
  st.nlink = 1;

  if(copyout2(addr, (char *)&st, sizeof(st)) < 0)
    return -1;
  return 0;
}

// Read from file f.
// addr is a user virtual address.
int fileread(struct file *f, uint64_t addr, int n)
{
  int r = 0;
  struct inode *ip;

  if(f->readable == 0)
    return -1;

  switch (f->type) {
    case FD_PIPE:
        r = piperead(f->pipe, addr, n);
        break;
    case FD_DEVICE:
        if(f->major < 0 || f->major >= MAX_DEV_NUM || !devsw[f->major].read)
          return -1;
        r = devsw[f->major].read(1, addr, n);
        break;
    case FD_INODE:
        ip = f->ip;
        ilock(ip);
          if((r = ip->fop->read(ip, 1, addr, f->off, n)) > 0)
            f->off += r;
        iunlock(ip);
        break;
    default:
      PANIC("fileread");
  }

  return r;
}

// Write to file f.
// addr is a user virtual address.
int filewrite(struct file *f, uint64_t addr, int n)
{
  int ret = 0;

  if(f->writable == 0)
    return -1;

  if(f->type == FD_PIPE){
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    if(f->major < 0 || f->major >= MAX_DEV_NUM || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    struct inode *ip = f->ip;
    ilock(ip);
    if (ip->fop->write(ip, 1, addr, f->off, n) == n) {
      ret = n;
      f->off += n;
    } else {
      ret = -1;
    }
    iunlock(ip);
  } else {
    PANIC("filewrite");
  }

  return ret;
}


// Read from dir f.
// addr is a user virtual address.
int filereaddir(struct file *f, uint64_t addr, uint64_t len)
{
	if (f->type != FD_INODE || f->readable == 0)
		return -1;

	struct dirent dent;
	struct inode *ip = f->ip;

	if (!(ip->mode & T_DIR))
		return -1;
	// if (!rangeinseg(addr, addr + n))
	// 	return -1;

	int ret ;
	uint32_t off = f->off;
	uint64_t old = addr;

	ilock(ip);
	for (;;) {
		ret = ip->fop->readdir(ip->sb, ip, &dent, off);
		if (ret <= 0 || dent.d_reclen > len) // 0 is end, -1 is err
			break;

		if (copyout2(addr, (char *)&dent, dent.d_reclen) < 0) {
			ret = -1;
			break;
		}

		off += ret;
		addr += dent.d_reclen;
		len -= dent.d_reclen;

	}
	//acquire_spinlock(&f->lock);
	f->off = off;
	//release_spinlock(&f->lock);
	iunlock(ip);

	if (ret < 0)
		return -ret;
	return addr - old;
}


int filereadv(struct file *f, struct iovec ioarr[], int count)
{
  int r_count = 0;
  for(int i=0; i < count; i++){
    r_count += fileread(f, (uint64_t)ioarr[i].iov_base, (int)ioarr[i].iov_len);
  }
  return r_count;
}


int filewritev(struct file *f, struct iovec ioarr[], int count)
{
  int w_count = 0;
  for(int i=0; i < count; i++){
    w_count += filewrite(f, (uint64_t)ioarr[i].iov_base, (int)ioarr[i].iov_len);
  }
  return w_count;
}

struct file *fd2file(int fd)
{
  return curr_proc()->ofiles[fd];
}


