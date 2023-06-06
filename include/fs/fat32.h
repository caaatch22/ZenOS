#ifndef FAT32_H
#define FAT32_H

#include "lock/sleeplock.h"
#include "fs/fstat.h"
#include "fs/vfs.h"
#include "fs/buffer.h"

// FAT32 file attribute
#define ATTR_READ_ONLY 0x01
#define ATTR_HIDDEN 0x02
#define ATTR_SYSTEM 0x04
#define ATTR_VOLUME_ID 0x08
#define ATTR_DIRECTORY 0x10
#define ATTR_ARCHIVE 0x20
#define ATTR_LONG_NAME 0x0F

// FAT32 flags
// last fat chain flag
#define FAT32_EOC 0x0ffffff8
// last long entry flag
#define LAST_LONG_ENTRY     0x40
#define EMPTY_ENTRY 0xe5
// end of dir
#define END_OF_DIR 0x00
// filename capacity each entry
#define LONG_NAME_SIZE 13
#define SHORT_NAME_SIZE 11

#define FAT32_MAX_FILENAME  255
#define FAT32_MAX_PATH      260

#define FAT32_DENTRY_LENGTH 32  // FAT32 的目录项为32字节

/* FAT32 superblock */
struct fat32_sb {
    uint32_t  first_data_sec;
    uint32_t  data_sec_cnt;
    uint32_t  data_clus_cnt;
    uint32_t  byts_per_clus;
    struct {
        uint16_t  byts_per_sec;
        uint8_t   sec_per_clus;
        uint16_t  rsvd_sec_cnt;
        uint8_t   fat_cnt;            /* count of FAT regions */
        uint32_t  hidd_sec;           /* count of hidden sectors */
        uint32_t  tot_sec;            /* total count of sectors including all regions */
        uint32_t  fat_sz;             /* count of sectors for a FAT region */
        uint32_t  root_clus;
    } bpb;
};

/* Inode of FAT32 in-memory format */
struct fat32_dentry {  // 目录项，每个32字节（256bit）
    // char  filename[FAT32_MAX_FILENAME + 1];  // this is stored in dentry
    uint8_t attribute;              // file or directory
    uint8_t create_time_tenth;
    uint16_t create_time;
    uint16_t create_date;
    uint16_t last_access_date;
    uint32_t first_clus;
    uint16_t last_write_time;
    uint16_t last_write_date;
    uint32_t file_size;

    uint32_t ent_cnt;
    uint32_t cur_clus;
    uint32_t clus_cnt;
};


struct fat32_sb *fat32_init(char *boot_sector);
struct inode *fat32_root_init(struct super_block *sb);
struct inode *fat_lookup_dir(struct inode *dir, char *filename, uint32_t *poff);
struct inode *fat_alloc_inode(struct super_block *sb);
void fat_destroy_inode(struct inode *ip);
struct inode *fat_alloc_entry(struct inode *dir, char *name, int mode);
int fat_update_entry(struct inode *ip);
int fat_remove_entry(struct inode *ip);
int fat_truncate_file(struct inode *ip);
int fat_stat_file(struct inode *ip, struct kstat *st);
int fat_read_dir(struct inode *dir, struct dirent *dent, uint32_t off);
int fat_read_file(struct inode *ip, uint32_t user_dst, uint64_t dst, uint32_t off, uint32_t n);
int fat_write_file(struct inode *ip, uint32_t user_src, uint64_t src, uint32_t off, uint32_t n);

#endif
