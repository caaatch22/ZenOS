#ifndef VFS_H
#define VFS_H

#include "common/defs.h"
#include "fs/fstat.h"
#include "lock/sleeplock.h"
#include "lock/spinlock.h"

#define MAX_DEV_TYPE 16
#define MAX_DEV_NUM 32
#define MAX_NAME_SIZE 255


struct unique_number {
	struct spinlock lock;
	uint32_t number;
	uint32_t (*get_number)(struct unique_number *un);
};

struct super_block;
struct inode;
struct dentry;

/**
 * This collection specifies how to access the disk.
 * All file ops end up calling to these.
 */
struct fs_op {
	// ??? inode is a part of VFS, is it nessary to set this port ???
	struct inode *(*alloc_inode)(struct super_block *sb);
	void (*destroy_inode)(struct inode *ip);
	// off: offset in the block
	int (*write)(struct super_block *sb, int usr, char *src, uint64_t blockno, uint64_t off, uint64_t len);
	int (*read)(struct super_block *sb, int usr, char *dst, uint64_t blockno, uint64_t off, uint64_t len);
	int (*clear)(struct super_block *sb, uint64_t blockno, uint64_t blockcnt);
};

struct inode_op {
	struct inode *(*create)(struct inode *ip, char *name, int mode);
	struct inode *(*lookup)(struct inode *dir, char *filename, uint32_t *poff);
	int (*truncate)(struct inode *ip);
	int (*unlink)(struct inode *ip);
	int (*update)(struct inode *ip);
	int (*getattr)(struct inode *ip, struct kstat *st);

};

struct dentry_op {
	int (*delete)(struct dentry *de);
	// int (*compare)(struct dentry *de, char *name);
};

struct file_op {
	// --read: off,在文件中偏移量；n,读取的大小
	int (*read)(struct inode *ip, int usr, uint64_t dst, uint32_t off, uint32_t n);
	int (*write)(struct inode *ip, int usr, uint64_t src, uint32_t off, uint32_t n);
	// read dentry from a directory
	int (*readdir)(struct inode *ip, struct dirent *dent, uint32_t off);
};


struct super_block {
	uint32_t				dev_num;		//
	int					ref;		// sum of refs of all its inodes
	uint32_t				blocksz;	// size of disk block
	void				*real_sb;	// real super_block, which in the format of their FS(eg:FAT32、ext4)

	struct inode			*dev;		// dev's inode
	struct dentry			*root;
	struct super_block	*next;

	struct sleeplock	sb_lock;	// must acquire when use op.
	struct spinlock		cache_lock;		// to check in this FS, if a file exist. must acquire this when check in de_tree

	struct fs_op			op;			// operations of R/W on this dev.(eg:on disk, it's R/W sector)
};


// For inode.state
#define I_STATE_VALID		(1 << 0)
#define I_STATE_DIRTY		(1 << 2)
#define I_STATE_FREE		(1 << 3)
#define I_STATE_LOCKED		(1 << 4)

struct inode {
	uint64_t			ino_num;
	int					ref;
	int					state;
	int					mode;		// file type of this inode. in stat.h
	int					size;
	int					nlink;	// useless on FAT
	void				*real_i;
	int					dev_num;

	struct super_block		*sb;
	struct dentry				*entry;
	struct sleeplock		lock;
	// struct spinlock		lock;

	// operate functions
	struct inode_op			*op;		//
	struct file_op			*fop;		// --file operation

};


#define MAXNAME 255

struct dentry {
	char				name[MAXNAME + 1];
	// int					ref;
	struct inode		*inode;
	struct dentry		*parent;
	struct dentry		*next;
	struct dentry		*child;
	struct dentry_op	*op;
	struct super_block	*mount;
};


#define IMODE_READ_ONLY		(1 << 0)
#define IMODE_HIDDEN		(1 << 1)
#define IMODE_DIRECTORY		(1 << 2)


void rootfs_init();
void rootfs_print();

struct inode *create(char *path, uint32_t type, struct inode *dp);
int unlink(struct inode *ip);

struct inode *idup(struct inode *ip);
void iput(struct inode *ip);
void ilock(struct inode *ip);
void iunlock(struct inode *ip);

struct inode *namei(char *path);
struct inode *nameiparent(char *path, char *name);
int namepath(struct inode *ip, char *path, uint32_t max);
struct inode *nameifrom(struct inode *dp, char *path);
struct inode *nameiparentfrom(struct inode *dp, char *path, char* name);

int do_mount(struct inode *dev, struct inode *mntpoint, char *type, uint32_t flag, void *data);
int do_umount(struct inode *mntpoint, uint32_t flag);

static inline void iunlockput(struct inode *ip)
{
	iunlock(ip);
	iput(ip);
}



#endif
