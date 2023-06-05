#include "defs.h"
#include "vfs.h"
#include "log.h"
#include "status.h"
#include "kmalloc.h"
// Virtual File System (only supports FAT32 so far).

extern struct super_block rootfs;
extern struct dentry_op rootfs_dentry_op;

static struct dentry *de_check_cache(struct dentry *parent, char *name);
int de_delete(struct dentry *de);

/**
 * File system inode
 *
 */

/**
 * @brief 当需要在指定位置创建inode时，就要用到dp（dir pointer）
 *
 * @param path 指定的路径。（相对路径的出发点由dp确定）
 * @param type 即inode->mode
 * @param dp
 * @return struct inode* 返回的inode是已经拿了锁的
 */
struct inode *create(char *path, uint32_t type, struct inode *dp)
{
	struct inode *ip;
	char name[MAX_NAME_SIZE + 1];
	struct dentry *de;

	if(type & S_IFMT){  // 如果是PO
			int mode = type & S_IFMT;
			switch (mode)
			{
			case S_IFDIR: type = 1; break;
			case S_IFREG: type = 2; break;
			case S_IFBLK: type = 3; break;
			default:
				panic("in fs.c: create: unrecognizeed type from user space");
				break;
			}
	}

	if((dp = nameiparentfrom(dp, path, name)) == NULL) {
		// root doesn't have parent
		if(strncmp(path, "/", MAX_NAME_SIZE) != 0){
			printf("in fs.c: create: wrong path :%s\n", path);
			return NULL;
		}
		__debug_error("fs.c:create","dp is root\n");
		dp = namei("/");
		ilock(dp);
		return dp;
	}

	ilock(dp);
	if (dp->state & I_STATE_FREE) {
		iunlockput(dp);
		return NULL;
	}

	struct super_block *sb = dp->sb;
	acquire(&sb->cache_lock);
	de = de_check_cache(dp->entry, name);
	release(&sb->cache_lock);

	if (de != NULL) {
		iunlockput(dp);
		ip = idup(de->inode);
		if (type != ip->mode) {
			iput(ip);
			ip = NULL;
		} else {
			ilock(ip);
		}
		return ip;
	}

	if ((de = kmalloc(sizeof(struct dentry))) == NULL) {
		iunlockput(dp);
		return NULL;
	}

	if ((ip = dp->op->create(dp, name, type)) == NULL) {
		iunlockput(dp);
		kfree(de);
		return NULL;
	}

	idup(ip);
	ip->state = I_STATE_VALID;
	ip->entry = de;

	safestrcpy(de->name, name, MAX_NAME_SIZE + 1);
	de->child = NULL;
	de->mount = NULL;
	de->inode = ip;
	de->op = &rootfs_dentry_op;

	acquire(&sb->cache_lock);
	de->parent = dp->entry;
	de->next = dp->entry->child;
	dp->entry->child = de;
	release(&sb->cache_lock);

	if (type != ip->mode) {
		iunlockput(dp);
		iput(ip);
		return NULL;
	}

	iunlockput(dp);
	ilock(ip);

	return ip;
}


// Caller must hold ip->lock.
int unlink(struct inode *ip)
{
	struct super_block *sb = ip->sb;
	struct dentry *de = ip->entry;

	__debug_info("unlink", "unlink %s\n", de->name);
	for (sb = &rootfs; sb != NULL; sb = sb->next) {
		if (sb->dev == ip) {
			__debug_warn("unlink", "%s is busy\n", de->name);
			return -1;
		}
	}

	sb = ip->sb;
	if (de == sb->root) {
		__debug_warn("unlink", "try to unlink root\n");
		return -1;
	}
	if (ip->op->unlink(ip) < 0) {
		__debug_warn("unlink", "fail\n");
		return -1;
	}

	acquire(&sb->cache_lock);
	if (ip->nlink == 0) {
		// No other files link to ip
		ip->state |= I_STATE_FREE;
		// Remove the dentry from cache, but do not free it.
		de_delete(de);
	}
	release(&sb->cache_lock);

	return 0;
}


struct inode *idup(struct inode *ip)
{
	acquire(&ip->sb->cache_lock);
	ip->sb->ref++;
	ip->ref++;
	release(&ip->sb->cache_lock);
	return ip;
}


void iput(struct inode *ip)
{
	// Lock the cache so that no one can get ip.
	struct super_block *sb = ip->sb;
	acquire(&sb->cache_lock);
	sb->ref--;
	if (ip->ref == 1) {
		// ref == 1 means no other process can have ip locked,
		// so this acquiresleep() won't block (or deadlock).
		acquiresleep(&ip->lock);
		release(&sb->cache_lock);

		// This file is removed, so its dentry should have been
		// deleted from the dentry tree.
		// This inode is invisible, just free it.
		if (ip->state & I_STATE_FREE) {
			ip->op->truncate(ip);
			kfree(ip->entry);
			sb->op.destroy_inode(ip);
			return;
		}
		else if (ip->state & I_STATE_DIRTY) {
			ip->op->update(ip);
		}
		releasesleep(&ip->lock);
		acquire(&sb->cache_lock);
	}
	ip->ref--;
	release(&sb->cache_lock);
}


void ilock(struct inode *ip)
{
	if (ip == 0 || ip->ref < 1){
		printf("lock ref:%d\n", ip->ref);
		panic("ilock");
	}

	acquiresleep(&ip->lock);
}


void iunlock(struct inode *ip)
{
	if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
		panic("iunlock");
	releasesleep(&ip->lock);
}


/**
 * File system dentry
 *
 */


/**
 * If de is a moint point, return the mounted root.
 */
static inline struct dentry *de_mnt_in(struct dentry *de)
{
	while (de->mount != NULL) {
		de = de->mount->root;
	}
	return de;
}

// Returns a dentry struct. If name is given, check ecache. It is difficult to cache entries
// by their whole path. But when parsing a path, we open all the directories through it,
// which forms a linked list from the final file to the root. Thus, we use the "parent" pointer
// to recognize whether an entry with the "name" as given is really the file we want in the right path.
// Should never get root by eget, it's easy to understand.
// Caller should hold super_block's cache_lock.
static struct dentry *de_check_cache(struct dentry *parent, char *name)
{
	struct dentry *pde = NULL;
	struct dentry *de = parent->child;
	for (; de != NULL; pde = de, de = de->next) {          // LRU algo
		if (strncmp(de->name, name, MAX_NAME_SIZE) == 0) {
			if (de != parent->child) {
				pde->next = de->next;
				de->next = parent->child;
				parent->child = de;
			}
			return de_mnt_in(de);
		}
	}
	return NULL;
}


// Caller must hold super_block's cache_lock.
int de_delete(struct dentry *de)
{
	if (de->child != NULL)
		panic("de_delete: has children");

	struct dentry **pde;
	for (pde = &de->parent->child; *pde != NULL; pde = &(*pde)->next) {
		if (*pde == de) {
			*pde = de->next;
			return 0;
		}
	}

	panic("de_delete: not in cache delete");
	return -1;
}

void de_print(struct super_block *sb, int level);

static void do_de_print(struct dentry *de, int level)
{
	struct dentry *child;
	for (child = de->child; child != NULL; child = child->next) {
		for (int i = 0; i < level; i++) {
			printf("\t");
		}
		LOG_INFO("%d %s\n", child->inode->ref, child->name);
		do_de_print(child, level + 1);
		if (child->mount) {
			release(&child->inode->sb->cache_lock);
			de_print(child->mount, level);
			acquire(&child->inode->sb->cache_lock);
		}
	}
}

void de_print(struct super_block *sb, int level)
{
	acquire(&sb->cache_lock);

	struct dentry *root = sb->root;
	for (int i = 0; i < level; i++) {
		printf("\t");
	}
	if (sb->dev) {
		LOG_INFO("%d/%d %s mounted at %s\n",
			sb->ref, root->inode->ref, sb->dev->entry->name, root->parent->name);
	} else {
		LOG_INFO("%d/%d %s\n", sb->ref, root->inode->ref, root->name);
	}
	do_de_print(root, level + 1);

	release(&sb->cache_lock);
}


void rootfs_print()
{
	LOG_INFO("\nfile tree:\n");
	de_print(&rootfs, 0);
}


/**
 * File system path
 *
 */


/**
 * Seacher for the entry in a directory and return a structure. Besides, record the offset of
 * some continuous empty slots that can fit the length of filename.
 * Caller must hold entry->lock.
 * @param   dp          entry of a directory file
 * @param   filename    target filename
 * @param   poff        offset of proper empty entry slots from the beginning of the dir
 */
struct inode *dirlookup(struct inode *dir, char *filename, uint32_t *poff)
{
	if (dir->mode != T_DIR)
		panic("dirlookup");

	struct super_block *sb = dir->sb;
	struct dentry *de, *parent;
	if (strncmp(filename, ".", MAX_NAME_SIZE) == 0) {
		de = de_mnt_in(dir->entry);
		return idup(de->inode);
	}
	else if (strncmp(filename, "..", MAX_NAME_SIZE) == 0) {
		de = dir->entry;
		while (de == sb->root) { // It indicates that de is a root and may be a mount point.
			de = de->parent;
			if (de == NULL) { // Meet root of rootfs.
				de = sb->root;
				break;
			}
			sb = de->inode->sb;
		}
		de = de_mnt_in(de->parent == NULL ? de : de->parent); // Now we found the real parent.
		return idup(de->inode);
	}

	// Look through in memory
	acquire(&sb->cache_lock);
	de = de_check_cache(dir->entry, filename);
	release(&sb->cache_lock);
	if (de != NULL) {
		__debug_info("dirlookup", "cache hit: %s\n", filename);
		return idup(de->inode);
	}

	// Not in memory. Now look through in disk
	struct inode *ip = dir->op->lookup(dir, filename, poff);
	if (ip == NULL || (de = kmalloc(sizeof(struct dentry))) == NULL) {
		if (ip) {
			sb->op.destroy_inode(ip);
		}
		__debug_warn("dirlookup", "file not found: %s\n", filename);
		return NULL;
	}

	idup(ip);
	ip->entry = de;
	ip->state = I_STATE_VALID;

	safestrcpy(de->name, filename, MAX_NAME_SIZE + 1);
	de->child = NULL;
	de->mount = NULL;
	de->inode = ip;
	de->op = &rootfs_dentry_op;

	acquire(&sb->cache_lock);
	parent = dir->entry;
	de->parent = parent;
	de->next = parent->child;
	parent->child = de;
	release(&sb->cache_lock);

	return ip;
}

/**
 * @brief
 *
 * @param path
 * @param name file that we want in current directory
 * @param max
 * @return char* path left to check
 */
static char *skipelem(char *path, char *name, int max)	//get a partition in path, return left
{
	while (*path == '/') {
		path++;
	}
	if (*path == 0) { return NULL; }
	char *s = path;
	while (*path != '/' && *path != 0) {
		path++;
	}
	int len = path - s;
	if (len > max) {
		len = max;
	}
	name[len] = 0;
	memmove(name, s, len);
	while (*path == '/') {
		path++;
	}
	return path;
}

/**
 * @brief FAT32 version of namex in xv6's original file system.
 *
 * @param path
 * @param parent
 * @param name this is a return value
 * @param ip_spec
 * @return struct inode*
 */
static struct inode *lookup_path(char *path, int parent, char *name, struct inode *ip_spec)
{
	struct inode *ip, *next;  // 'ip' is the inode we are looking for
	struct proc_status *p = myproc();
	if (*path == '/') {  // 绝对路径
		if(strncmp("/proc/self/exe", path, 15) == 0){  // 我们没有这个伪文件系统，通过另一种方式实现。
			if( p->elf )
				return idup(p->elf);
			return NULL;
		}
		ip = de_mnt_in(rootfs.root)->inode;
		ip = idup(ip);
	} else if (*path != '\0') {  // 相对路径
		// 如果有指定的inode，则使用的指定的，否则使用cwd
		ip = ip_spec ? idup(ip_spec) : idup(p->cwd);
	} else {
		//__debug_warn("lookup_path", "path invalid\n");
		return NULL;
	}

	while ((path = skipelem(path, name, MAX_NAME_SIZE)) != 0) {
		ilock(ip);
		if (ip->mode != T_DIR) {
			iunlockput(ip);
			return NULL;
		}
		if (parent && *path == '\0') {
			iunlock(ip);
			return ip;
		}
		if ((next = dirlookup(ip, name, 0)) == NULL) {
			iunlockput(ip);
			__debug_warn("lookup_path", "dirlookup returns a NULL\n");
			return NULL;
		}
		__debug_info("lookup_path", "found: %s\n", next->entry->name);
		iunlockput(ip);
		ip = next;
	}
	if (parent) {
		iput(ip);
		return NULL;
	}
	__debug_info("lookup_path", "finally: %s\n", ip->entry->name);
	return ip;
}


//-------------------------------------
// the function of name~ won't hold the lock.
// once search done, they release the lock.
struct inode *namei(char *path)
{
	char name[MAX_NAME_SIZE + 1];
	return lookup_path(path, 0, name, NULL);
}

struct inode *nameiparent(char *path, char *name)
{
	return lookup_path(path, 1, name, NULL);
}

// from代表：以指定的dp为相对路径的起始点
struct inode *nameifrom(struct inode *dp, char *path)
{
	char name[MAX_NAME_SIZE + 1];
	return lookup_path(path, 0, name, dp);
}

struct inode *nameiparentfrom(struct inode *dp, char *path, char *name)
{
	return lookup_path(path, 1, name, dp);
}

// path is kernel space, and max must be bigger than 2.
/**
 * @brief 返回指定inode的绝对路径到path缓冲区中，
 *
 * @param ip
 * @param path 缓冲区
 * @param max 是path的最大长度
 * @return int 写入到path中的长度，包括'\0'
 */
int namepath(struct inode *ip, char *path, uint32_t max)
{
	// if (max < 2)
	// 	panic("namepath: what do you want from me by a max less than 2");

	struct super_block *sb = ip->sb;
	struct dentry *de = ip->entry;  // 当前inode的dentry

	if (de == rootfs.root) {
		path[0] = '/';
		path[1] = '\0';
		return 2;
	}

	int len;
	char *p = path + max - 1;
	*p = '\0';

	acquire(&sb->cache_lock);
	for (;;) {
		while (de == sb->root) { // It indicates that de is a root and may be a mount point.
			if ((de = de->parent) == NULL) { // Meet root of rootfs.
				break;
			}
			release(&sb->cache_lock);
			sb = de->inode->sb;
			acquire(&sb->cache_lock);
		}
		if (de == NULL)
			break;
		len = strlen(de->name);
		if ((p -= len) <= path) {
			release(&sb->cache_lock);
			return -1;
		}
		memmove(p, de->name, len);
		*--p = '/';
		de = de->parent;
	}
	release(&sb->cache_lock);

	len = max - (p - path);		// '\0' has been included
	memmove(path, p, len);		// memmove will handle overlap

	return len;
}


/**
 * Other file system operations.
 *
 *
 */

extern struct super_block *dev_fs_init(struct inode *dev);
extern void image_fs_uninstall(struct super_block *sb);

uint32_t get_number_dev(struct unique_number *un)
{
	uint32_t un_now;
	acquire(&un->lock);
	un_now = un->number++;
	release(&un->lock);
	return un_now;
}
struct unique_number dev_num = { // to assign unique devnum
	.get_number = get_number_dev,
};

/**
 * @brief
 * int mount(const char *source, const char *target,
 *        const char *filesystemtype, unsigned long mountflags,
 *        const void *data);
 */
// Ignore flag and data in our implement.
// Caller must hold all inodes' locks.
int do_mount(struct inode *dev, struct inode *mntpoint, char *type, uint32_t flag, void *data)
{
	// convert mode
	if(dev->mode & S_IFMT){
		switch (dev->mode & S_IFMT)
		{
		case S_IFDIR: dev->mode = T_DIR; break;
		case S_IFREG: dev->mode = T_FILE; break;
		case S_IFBLK: dev->mode = T_DEVICE; break;
		default:
			panic("int fs.c:do_mount:unrecogenized type!!");
			break;
		}
	}

	// checking
	if (strncmp("vfat", type, 5) != 0 &&
		strncmp("fat32", type, 6) != 0)
	{
		printf("in fs.c:unsupport fs\n");
		return -1;
	}

	// vda2 will mount at this place
	// if (mntpoint->entry == rootfs.root) {
	// 	__debug_warn("do_mount", "can not mount at \"/\"\n");
	// 	return -1;
	// }

	// __debug_info("do_mount", "dev:%s mntpnt:%s\n", dev->entry->filename, mntpoint->entry->filename);

	if (dev->mode == T_DIR || mntpoint->mode != T_DIR) {
		__debug_warn("do_mount", "Error file type: dev:%d mntpoint:%d\n",
			dev->mode, mntpoint->mode);
		return -1;
	}

	struct dentry *dmnt = mntpoint->entry;

	// init super_block of dev(including:sb's attribute, inode, dentry)
	struct super_block *dev_sb = dev_fs_init(dev);
	if (dev_sb == NULL)
		return -1;

	// put this dev into dentry_tree
	acquire(&rootfs.cache_lock); // borrow this lock

	struct super_block *tsr = &rootfs;  // tsr: temp_sb_rootfs
	while (tsr->next != NULL)
		tsr = tsr->next;
	tsr->next = dev_sb;

	dev_sb->root->parent = dmnt;
	safestrcpy(dev_sb->root->name, dmnt->name, sizeof(dmnt->name));
	dmnt->mount = dev_sb;

	release(&rootfs.cache_lock);

	idup(mntpoint);

	// }

	return 0;
}

// Caller must hold mntpoint->lock.
// flag is of no use in out implement.
int do_umount(struct inode *mntpoint, uint32_t flag)
{
	if (mntpoint->mode != T_DIR) {
		__debug_warn("do_umount", "try to umount file: %s\n", mntpoint->entry->name);
		return -1;
	}

	struct super_block *sb = mntpoint->sb;
	if (mntpoint->entry != sb->root || sb == &rootfs) {
		__debug_warn("do_umount", "%s is not a mount point\n", mntpoint->entry->name);
		return -1;
	}

	struct dentry *de = mntpoint->entry;
	struct super_block *sb_prnt = NULL;
	do { // Look up parent of the mount point.
		de = de->parent;
		if (de == NULL) { // Meet root of rootfs.
			break;
		}
		sb_prnt = de->inode->sb;
	} while (de == sb_prnt->root);

	// Lock parent to block cache check.
	acquire(&sb_prnt->cache_lock);
	// Check whether only we hold this ref.
	if (sb->ref > 1) {
		__debug_warn("do_umount", "mount point is busy\n");
		release(&sb_prnt->cache_lock);
		return -1;
	}
	// Unmount from dentry tree.
	de = mntpoint->entry;
	de->parent->mount = NULL;
	release(&sb_prnt->cache_lock);

	// Put the inode it mounts at.
	iput(de->parent->inode);

	// Remove from super_block list.
	acquire(&rootfs.cache_lock);
	sb_prnt = &rootfs;
	while (sb_prnt->next != sb)
		sb_prnt = sb_prnt->next;
	sb_prnt->next = sb->next;
	release(&rootfs.cache_lock);

	image_fs_uninstall(sb);

	return 0;
}



