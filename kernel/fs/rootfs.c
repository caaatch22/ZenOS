#include "common/common.h"
#include "fs/vfs.h"
#include "fs/fat32.h"
#include "utils/string.h"
#include "mm/kmalloc.h"
#include "fs/virtio_blk.h"
#include "fs/ramdisk.h"

struct inode *dummy_inode_create(struct inode *ip, char *name, int mode) { return NULL; }
struct inode *dummy_inode_lookup(struct inode *dir, char *filename, uint32_t *poff) { return NULL; }
int dummy_inode_iop1(struct inode *ip) { return -1; }
int dummy_file_rw(struct inode *ip, uint32_t usr, uint64_t dst, uint32_t off, uint32_t n) { return 0; }
int dummy_file_readdir(struct super_block *sb, struct inode *dp, struct dirent *dent, uint32_t off) { return -1; }

static int fs_write(struct super_block *sb, uint32_t usr, char *src, uint64_t sectorno, uint64_t off, uint64_t len);
static int fs_read(struct super_block *sb, uint32_t usr, char *dst, uint64_t sectorno, uint64_t off, uint64_t len);
static int fs_clear(struct super_block *sb, uint64_t sectorno, uint64_t sectorcnt);
static int fs_inode_getattr(struct inode *ip, struct kstat *st);
static int file_readdir(struct super_block *sb, struct inode * ip, struct dirent *dent, uint32_t off);

static int mount_init_fs();

extern int de_delete(struct dentry *de);
extern struct file_op devfs_file_op_console;
extern struct inode_op fat32_inode_op;
extern struct file_op fat32_file_op;

extern buf_list_t blk_buf_list;
extern struct blk_ops blk_op_table[];

int zero_read(struct inode *ip, uint32_t usr, uint64_t dst, uint32_t off, uint32_t n)
{
	memset((void*)dst, 0, n);
	return n;
}

int zero_write(struct inode *ip, uint32_t usr, uint64_t dst, uint32_t off, uint32_t n) { return n; }
int null_read(struct inode *ip, uint32_t usr, uint64_t dst, uint32_t off, uint32_t n) { return 0; }


struct inode_op rootfs_inode_op = {
	.create = dummy_inode_create,
	.lookup = dummy_inode_lookup,
	.getattr = fs_inode_getattr,
	.truncate = dummy_inode_iop1,
	.unlink = dummy_inode_iop1,
	.update = dummy_inode_iop1,
};

struct dentry_op rootfs_dentry_op = {
	.delete = de_delete,
};

struct file_op rootfs_file_op = {
	.read = dummy_file_rw,
	.write = dummy_file_rw,
	.readdir = file_readdir,
};

struct file_op devfs_file_op_zero = {
	.read = zero_read,
	.write = zero_write,
	.readdir = dummy_file_readdir,
};

struct file_op devfs_file_op_null = {
	.read = null_read,
	.write = zero_write,
	.readdir = dummy_file_readdir,
};

struct fs_op fat_fs_op = {
	.read = fs_read,
	.write = fs_write,
	.clear = fs_clear,
	.alloc_inode = fat_alloc_inode,
	.destroy_inode = fat_destroy_inode,
};

struct super_block procfs;
struct super_block devfs;
struct super_block rootfs = {
		.dev_num = RAMDISK_ID,
		.dev = NULL,
		.op.alloc_inode = fat_alloc_inode,
		.op.destroy_inode = fat_destroy_inode,
		.op.write = fs_write,
		.op.read = fs_read,
		.op.clear = fs_clear,
};

static struct dentry *dentry_fs_generate(struct super_block *sb,
							struct dentry *parent, char *name,
							int inum, int mode, int dev_num)
{
	struct inode *ip;
	struct dentry *de;

	ip = kmalloc(sizeof(struct inode));
	de = kmalloc(sizeof(struct dentry));

	memset(de, 0, sizeof(struct dentry));
	memset(ip, 0, sizeof(struct inode));

	// dentry init
	de->op = &rootfs_dentry_op;
	de->inode = ip;
	strncpy(de->name, name, MAXNAME);
	if(parent){
		de->next = parent->child;
		parent->child = de;
		de->parent = parent;
	}

	// inode init
	ip->entry = de;
	ip->ino_num = inum;
	ip->mode = mode;
	ip->nlink = 1;
	ip->fop = &rootfs_file_op;
	ip->op = &rootfs_inode_op;
	ip->sb = sb;
	ip->state = I_STATE_VALID;
	ip->dev_num = dev_num;
	init_sleeplock(&ip->lock, "inode_sleeplock");

	return de;
}

// Must be called by initcode.
extern struct unique_number dev_num;
void rootfs_init()
{
	// init dev_num
	init_spinlock(&dev_num.lock, "dev_number");
	dev_num.number = 1;
	int inum = 1;
	// rootfs -- in memory fs, mean root
	memset(&rootfs, 0, sizeof(struct super_block));
	init_sleeplock(&rootfs.sb_lock, "rootfs_sb");
	init_spinlock(&rootfs.cache_lock, "rootfs_dcache");
	rootfs.root = dentry_fs_generate(&rootfs, NULL, "/", inum++, T_DIR, 0);

	// devfs
	struct dentry *vda2, *vda3, *console, *zero, *null;
	memset(&devfs, 0, sizeof(struct super_block));
	init_sleeplock(&devfs.sb_lock, "devfs_sb");
	init_spinlock(&devfs.cache_lock, "devfs_dcache");
	devfs.root = dentry_fs_generate(&devfs, NULL, "/", inum++, T_DIR, 0);
	vda2 = dentry_fs_generate(&devfs, devfs.root, "vda2", inum++, T_DEVICE, dev_num.get_number(&dev_num));
	vda3 = dentry_fs_generate(&devfs, devfs.root, "vda3", inum++, T_DEVICE, dev_num.get_number(&dev_num));
	console = dentry_fs_generate(&devfs, devfs.root, "console", inum++, T_DEVICE, dev_num.get_number(&dev_num));
	zero = dentry_fs_generate(&devfs, devfs.root, "zero", inum++, T_DEVICE, dev_num.get_number(&dev_num));
	null = dentry_fs_generate(&devfs, devfs.root, "null", inum++, T_DEVICE, dev_num.get_number(&dev_num));

	// //virtfs
	// init_sleeplock(&virtfs.sb_lock, "virtfs_sb");
	// init_spinlock(&virtfs.cache_lock, "virtfs_dcache");
	// virtfs.root = dentry_fs_generate(&virtfs, NULL, "/", inum++, T_DIR, 0);
	// virtfs.dev_num = vda3->inode->dev_num;

	// vda2's fop will later init in mount,
	// Because it needs a new FS to R/W data on fat32.
	console->inode->fop = &devfs_file_op_console;
	zero->inode->fop = &devfs_file_op_zero;
	null->inode->fop = &devfs_file_op_null;

	blk_op_table[vda2->inode->dev_num].rw = ramdisk_rw;
	blk_op_table[vda3->inode->dev_num].rw = virtio_blk_rw;

	// procfs
	struct dentry *mounts, *meminfo;
	memset(&procfs, 0, sizeof(struct super_block));
	init_sleeplock(&procfs.sb_lock, "procfs_sb");
	init_spinlock(&procfs.cache_lock, "procfs_dcache");
	procfs.root = dentry_fs_generate(&procfs, NULL, "/", inum++, T_DIR, 0);
	mounts  = dentry_fs_generate(&procfs, procfs.root, "mounts", inum++, T_FILE, 0);
	meminfo = dentry_fs_generate(&procfs, procfs.root, "meminfo", inum++, T_FILE, 0);
	LOG_INFO("make devfs and procfs OK\n");

	// mount disk on "/"
	do_mount(vda2->inode, rootfs.root->inode, "fat32", 0, NULL);

  // uint64_t pos = INITRD_START + 512 * 1292 + 32;
  // LOG_DEBUG("%s", (char *)pos);
  // PANIC("test");

	LOG_INFO("mount vda2 OK\n");
	// make directories to mount all the FS above
	struct inode *dir;
	if ((dir = create("/dev", T_DIR, NULL)) == NULL)
		PANIC("in rootfs.c: create //dev wrong!");
	iunlockput(dir);
	dir = namei("/dev");
	ilock(dir);
	mount_init_fs(&devfs, dir);
	iunlockput(dir);

	if ((dir = create("/proc", T_DIR, NULL)) == NULL)
		PANIC("in rootfs.c: create //proc wrong!");
	iunlockput(dir);
	dir = namei("/proc");
	ilock(dir);
	mount_init_fs(&procfs, dir);
	iunlockput(dir);
}

/**
 * @brief write data to disk
 * @param sb useless now; later to fit other file system
 * @param usr is the data from user_space ? or kernel?
 * @param off offset in this buf
 *
 */
static int fs_write(struct super_block *sb, uint32_t usr, char *src, uint64_t sectorno, uint64_t off, uint64_t len)
{
	if (off + len > BUFFER_SIZE)
		PANIC("rootfs write out of boundry");

	LOG_INFO("sec:%d off:%d len:%d\n", sectorno, off, len);
	struct buf *b = buffer_fetch(sb->dev_num, sectorno, &blk_buf_list);
	int ret;

	if (usr) {
		ret = copyin2((uint64_t)(b->payload) + off, (uint64_t)src, len);
	}
	else {
		memmove((uint64_t)(b->payload) + off, src, len);
		ret = 0;
	}

	buffer_release(b);

	return ret;
}


static int fs_read(struct super_block *sb, uint32_t usr, char *dst, uint64_t sectorno, uint64_t off, uint64_t len)
{
	if (off + len > BUFFER_SIZE)
		PANIC("rootfs read out of boundry");
	LOG_INFO("sec:%d off:%d len:%d dst:%p", sectorno, off, len, dst);

	struct buf *b = buffer_fetch(sb->dev_num, sectorno, &blk_buf_list);

	int ret;
	if (usr) {
		ret = copyout2((uint64_t)dst, (uint64_t)(b->payload) + off, len);
	}
	else {
		memmove(dst, (uint64_t)(b->payload) + off, len);
		ret = 0;
	}


	buffer_release(b);

	return ret < 0 ? -1 : len;
}

static int fs_clear(struct super_block *sb, uint64_t sectorno, uint64_t sectorcnt)
{
	return 0;
}


static int fs_inode_getattr(struct inode *ip, struct kstat *st)
{
	memset(st, 0, sizeof(struct kstat));
	st->blksize = ip->sb->blocksz;
	st->size = ip->size;
	st->blocks = (st->size + st->blksize - 1) / st->blksize;
	st->dev_num = ip->sb->dev_num;
	st->rdev = ip->dev_num;
	st->ino_num = ip->ino_num;
	st->mode = ip->mode;
	st->nlink = ip->nlink;
	return 0;
}


int file_readdir(struct super_block *sb, struct inode *dp, struct dirent *dent, uint32_t off)
{
	struct dentry *entry = dp->entry;
	//if (!S_ISDIR(dp->mode))
	if(dp->mode != T_DIR)
		return -1;

	int childnum = off >> 5;
	acquire_spinlock(&sb->cache_lock);
	struct dentry *child;
	for (child = entry->child; child != NULL && childnum > 0; child = child->next)
	{
		childnum--;
	}
	release_spinlock(&sb->cache_lock);

	if (!child)
		return 0;

	struct inode *ip = child->inode;
	strncpy(dent->d_name, child->name, 128);
	int size = sizeof(struct dirent) - sizeof(dent->d_name) + strlen(dent->d_name) + 1;
	size += (sizeof(uint64_t) - (size % sizeof(uint64_t))) % sizeof(uint64_t); // Align to 8.
	dent->d_ino_num = ip->ino_num;
	dent->d_off = off;
	dent->d_reclen = size;
	// dent->d_type = S_ISDIR(ip->mode) ? T_DIR : (ip->dev_num ? T_DEVICE : T_FILE);
	dent->d_type = ip->mode;
	return FAT32_DENTRY_LENGTH;  // 一个FAT32目录项的长度, 32字节
}


static int mount_init_fs(struct super_block *fs, struct inode *mntpoint)
{
	acquire_spinlock(&rootfs.cache_lock);

	// put on super_block-chain
	struct super_block *tsr = &rootfs;  // tsr: temp_sb_rootfs
	while (tsr->next != NULL)
		tsr = tsr->next;
	tsr->next = fs;

	// update the dentry-tree
	fs->root->parent = mntpoint->entry;
	strncpy(fs->root->name, mntpoint->entry->name, sizeof(mntpoint->entry->name));
	mntpoint->entry->mount = fs;

	release_spinlock(&rootfs.cache_lock);

	idup(mntpoint);

	return 0;
}
