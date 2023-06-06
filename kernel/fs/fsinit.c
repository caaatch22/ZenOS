#include "common/common.h"
#include "fs/vfs.h"
#include "fs/buffer.h"
#include "fs/fat32.h"
#include "mm/kmalloc.h"
#include "utils/string.h"


// extern struct inode_op fat32_inode_op;
// extern struct file_op fat32_file_op;
extern struct dentry_op rootfs_dentry_op;
extern struct fs_op fat_fs_op;


// Caller must hold img->lock.
/**
 * @brief init a SuperBlock for dev
 * 				including sb's: read_sb, inode, dentry...
 *
 * @param dev
 * @return struct superblock*
 */

struct super_block *dev_fs_init(struct inode *dev)
{
	struct super_block *sb = NULL;
	struct fat32_sb *fat = NULL;
	struct inode *iroot = NULL;
	char sb_buf[BUFFER_SIZE];

	if ((sb = kmalloc(sizeof(struct super_block))) == NULL) {
		return NULL;
	}

	init_sleeplock(&sb->sb_lock, "imgfs_sb");
	init_spinlock(&sb->cache_lock, "imgfs_dcache");
	sb->next = NULL;
	sb->ref = 0;
	sb->dev_num = dev->dev_num;

	sb->op = fat_fs_op;

	if ( (sb->op.read(sb, 0, (char*)sb_buf, 0, 0, BUFFER_SIZE)) == 0 )
		goto fail;
	if ( (fat = fat32_init(sb_buf)) == NULL)
		goto fail;

	sb->real_sb = fat;
	sb->blocksz = fat->bpb.byts_per_sec;

	if (sb->blocksz != BUFFER_SIZE)
		PANIC("in imgfs.c: dev_fs_init: blocksz not fit!!!");

	iroot = fat32_root_init(sb);

	sb->root = kmalloc(sizeof(struct dentry));
	memset(sb->root, 0, sizeof(struct dentry));
	if (iroot == NULL || sb->root == NULL)
		goto fail;

	iroot->entry = sb->root;
	sb->root->inode = iroot;
	sb->root->op = &rootfs_dentry_op;

	sb->dev = idup(dev);

	return sb;

fail:
	print("dev_fs_init: failed!!!!\n");
	if (iroot)
		fat_destroy_inode(iroot);
	if (fat)
		kfree(fat);
	if (sb)
		kfree(sb);
	return NULL;
}

static void fs_clean(struct super_block *sb, struct dentry *de)
{
	sb->op.destroy_inode(de->inode);
	for (struct dentry *child = de->child; child != NULL;) {
		struct dentry *temp = child->next;
		fs_clean(sb, child);
		child = temp;
	}
	kfree(de);
}

void fs_uninstall(struct super_block *sb)
{
	iput(sb->dev);
	fs_clean(sb, sb->root);
	kfree(sb->real_sb);
	kfree(sb);
}
