#include "common/common.h"
#include "fs/file.h"
#include "fs/fstat.h"
#include "proc/proc.h"
#include "mm/kmalloc.h"
#include "utils/string.h"
#include "fs/pipe.h"
#include "fs/fcntl.h"
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

/**
 * @brief Open a file
 * 
 * @param path kernel space string
 * @param flags how to open
 * @return int fd, -1 if failed
 */
int fileopen(char *path, int flags) {
  LOG_DEBUG("fileopen");
  LOG_INFO("fileopen %s, flags %x\n", path, flags);
  int fd;
  struct file *f;
  struct inode *ip;

  if (flags & O_CREAT) {
    // file does not exist, create it
    ip = create(path, flags & O_DIRECTORY ? T_DIR : T_FILE, NULL);
    if (ip == NULL) {
      LOG_INFO("Cannot create inode");
      return -1;
    }
  } else {
    // find inode by name
    if ((ip = namei(path)) == NULL) {
      LOG_INFO("Cannot find inode with name %s", path);
      return -2;
    }
    // the inode is found
    ilock(ip);

    // if the O_DIRECTORY flag is set, check if the inode is a directory
    if ((flags & O_DIRECTORY) && ip->mode != T_DIR) {
      iunlockput(ip);
      LOG_INFO("Can only open a dir if O_DIRECTORY is set");
      return -20; // -ENOTDIR
    }
  }

  // if (ip->mode == T_DEVICE && (ip->device.major < 0 || ip->device.major >= NDEV)) {
  //   iunlockput(ip);
  //   return -1;
  // }

  if ((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0) {
    if (f)
      fileclose(f);
    iunlockput(ip);
    return -1;
  }

  LOG_INFO("fileopen: alloc fd %d\n", fd);

  if (ip->mode != T_DIR && (flags & O_TRUNC)) {
    ip->op->truncate(ip);
  }

  f->type = FD_INODE;
  f->off = (flags & O_APPEND) ? ip->size : 0;
  f->ip = ip;
  f->readable = !(flags & O_WRONLY);
  f->writable = (flags & O_WRONLY) || (flags & O_RDWR);

  // LOG_ERROR("not support append flag right now");
  // if ((flags & O_APPEND) && ip->type == T_FILE) {
  //   struct kstat stat;
  //   stati(ip, &stat);
  //   f->off = stat.st_size;
  // }

  iunlock(ip);
  LOG_INFO("fileopen success, fd=%d", fd);
  return fd;
}


int fileopenat(int fd, char *filename, int flags, int mode)
{
  struct file *f = NULL;
  struct inode *dp = NULL, *ip;

  if(flags & O_CREAT){
    ip = create(filename, S_IFREG, dp);  // 我们还没有使用到权限位，忽略mode
    if(ip == NULL){
      return -1;
    }
  } else {
    if ((ip = nameifrom(dp, filename)) == NULL) {
      return -1;
    }
    ilock(ip);
    
    // if (S_ISDIR(ip->mode) && (flags & (O_WRONLY|O_RDWR))) {
    //   iunlockput(ip);
    //   return -1;
    // }
    // if ((flags & O_DIRECTORY) && !S_ISDIR(ip->mode)) {
    //   iunlockput(ip);
    //   return -1;
    // }
  }

	if((f = filealloc()) == NULL || (fd = fdalloc(f)) < 0){
		if (f) {
			fileclose(f);
		}
		iunlockput(ip);
		return -1;
	}

	if (!(ip->mode & T_DIR) && (flags & O_TRUNC) && (flags & (O_WRONLY|O_RDWR))) {
		ip->op->truncate(ip);
	}

	if (!(ip->mode & T_FILE) && !(ip->mode | T_DIR)) {
		f->type = FD_DEVICE;
	} else {
		f->type = FD_INODE;
		f->off = (flags & O_APPEND) ? ip->size : 0;
	}

	f->ip = ip;
	f->readable = !(flags & O_WRONLY);
	f->writable = (flags & O_WRONLY) || (flags & O_RDWR);

	iunlock(ip);

	return fd;
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


int filelink(struct file *oldfile, struct file *newfile) {
  if (oldfile->type != FD_INODE || newfile->type != FD_INODE) {
    LOG_INFO("filelink: not a inode");
    return -1;
  }
  ilock(oldfile->ip);
  if (oldfile->ip->mode != T_FILE) {
    LOG_INFO("filelink: not a file (1)");
    iunlock(oldfile->ip);
    return -1;
  }
  ilock(newfile->ip);
  if (newfile->ip->mode != T_FILE) {
    LOG_INFO("filelink: not a file (2)");
    iunlock(newfile->ip);
    iunlock(oldfile->ip);
    return -1;
  }
  // ilink not implement
  LOG_ERROR("ilink not implement");
  // int result = ilink(oldfile->ip, newfile->ip);
  int result = 0;
  iunlock(newfile->ip);
  iunlock(oldfile->ip);
  return result;
}