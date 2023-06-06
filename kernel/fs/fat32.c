#include "fs/fat32.h"
#include "fs/vfs.h"
#include "common/common.h"
#include "mm/kmalloc.h"
#include "utils/string.h"

/* On-disk directory entry structure */
/* Fields that start with "_" are something we don't use */
typedef struct short_name_entry {
    char        name[SHORT_NAME_SIZE];
    uint8_t       attr;
    uint8_t       _nt_res;
    uint8_t       _crt_time_tenth;
    uint16_t      _crt_time;
    uint16_t      _crt_date;
    uint16_t      _lst_acce_date;
    uint16_t      fst_clus_hi;
    uint16_t      _lst_wrt_time;
    uint16_t      _lst_wrt_date;
    uint16_t      fst_clus_lo;
    uint32_t      file_size;
} __attribute__((packed, aligned(4))) short_name_entry_t;

typedef struct long_name_entry {
    uint8_t       order;
    wchar       name1[5];
    uint8_t       attr;
    uint8_t       _type;
    uint8_t       checksum;
    wchar       name2[6];
    uint16_t      _fst_clus_lo;
    wchar       name3[2];
} __attribute__((packed, aligned(4))) long_name_entry_t;

union fat_disk_entry {
    short_name_entry_t  sne;
    long_name_entry_t   lne;
};

// FAT32 inode operation collection
struct inode_op fat32_inode_op = {
    .create = fat_alloc_entry,
    .lookup = fat_lookup_dir,
    .truncate = fat_truncate_file,
    .unlink = fat_remove_entry,
    .update = fat_update_entry,
    .getattr = fat_stat_file,

};

struct file_op fat32_file_op = {
    .read = fat_read_file,
    .write = fat_write_file,
    .readdir = fat_read_dir,
};

struct fat32_sb *fat32_init(char *boot_sector)
{
    //LOG_INFO("fat32_init", "enter\n");
    if (strncmp((char const*)(boot_sector + 82), "FAT32", 5)) {
        LOG_ERROR("not FAT32 volume\n");
        return NULL;
    }

    struct fat32_sb *fat = kmalloc(sizeof(struct fat32_sb));
    if (fat == NULL) {
        LOG_ERROR("fail to allocate fat_sb\n");
        return NULL;
    }

    memmove(&fat->bpb.byts_per_sec, boot_sector + 11, 2);            // avoid misaligned load on k210
    fat->bpb.sec_per_clus = *(boot_sector + 13);
    fat->bpb.rsvd_sec_cnt = *(uint16_t *)(boot_sector + 14);
    fat->bpb.fat_cnt = *(boot_sector + 16);
    fat->bpb.hidd_sec = *(uint32_t *)(boot_sector + 28);
    fat->bpb.tot_sec = *(uint32_t *)(boot_sector + 32);
    fat->bpb.fat_sz = *(uint32_t *)(boot_sector + 36);
    fat->bpb.root_clus = *(uint32_t *)(boot_sector + 44);
    fat->first_data_sec = fat->bpb.rsvd_sec_cnt + fat->bpb.fat_cnt * fat->bpb.fat_sz;
    fat->data_sec_cnt = fat->bpb.tot_sec - fat->first_data_sec;
    fat->data_clus_cnt = fat->data_sec_cnt / fat->bpb.sec_per_clus;
    fat->byts_per_clus = fat->bpb.sec_per_clus * fat->bpb.byts_per_sec;

    LOG_INFO("byts_per_sec: %d\n", fat->bpb.byts_per_sec);
    LOG_INFO("root_clus: %d\n", fat->bpb.root_clus);
    LOG_INFO("sec_per_clus: %d\n", fat->bpb.sec_per_clus);
    LOG_INFO("fat_cnt: %d\n", fat->bpb.fat_cnt);
    LOG_INFO("fat_sz: %d\n", fat->bpb.fat_sz);
    LOG_INFO("first_data_sec: %d\n", fat->first_data_sec);

    return fat;
}

// Convert to FAT32 super_block.
static inline struct fat32_sb *sb2fat(struct super_block *sb)
{
    return (struct fat32_sb *)sb->real_sb;
}

struct inode *fat32_root_init(struct super_block *sb)
{
    struct fat32_sb *fat = sb2fat(sb);
    struct fat32_dentry *root = kmalloc(sizeof(struct fat32_dentry));
    struct inode *iroot = sb->op.alloc_inode(sb);
    if (root == NULL || iroot == NULL) {
        if (root)
            kfree(root);
        return NULL;
    }

    root->attribute = (ATTR_DIRECTORY | ATTR_SYSTEM);
    root->first_clus = root->cur_clus = fat->bpb.root_clus;
    root->clus_cnt = 0;
    root->file_size = 0;

    iroot->real_i = root;
    iroot->ref = 0;
	iroot->ino_num = 0;  // the inum won't work
	iroot->mode = T_DIR;
	iroot->state |= I_STATE_VALID;
	iroot->op = &fat32_inode_op;
	iroot->fop = &fat32_file_op;

    LOG_INFO("fat32_root_init", "root cluster: %d\n", root->first_clus);

    return iroot;
}

static inline void __alert_fs_err(const char *func)
{
    LOG_ERROR("%s: alert! something wrong happened!\n", func);
    LOG_ERROR("You might need to format your SD!\n");
}

/**
 * @param   fat         fat32 super block
 * @param   cluster     cluster number starts from 2, which means no 0 and 1
 */
static inline uint32_t first_sec_of_clus(struct fat32_sb *fat, uint32_t cluster)
{
    return ((cluster - 2) * fat->bpb.sec_per_clus) + fat->first_data_sec;
}

/**
 * For the given number of a data cluster, return the number of the sector in a FAT table.
 * @param   fat         fat32 super block
 * @param   cluster     number of a data cluster
 * @param   fat_num     number of FAT table from 1, shouldn't be larger than bpb::fat_cnt
 *                      we only use fat region 1 in xv6-k210, lazy to check legality
 */
static inline uint32_t fat_sec_of_clus(struct fat32_sb *fat, uint32_t cluster, uint8_t fat_num)
{
    return fat->bpb.rsvd_sec_cnt + (cluster << 2) / fat->bpb.byts_per_sec + fat->bpb.fat_sz * (fat_num - 1);
}

/**
 * For the given number of a data cluster, return the offest in the corresponding sector in a FAT table.
 * @param   fat         fat32 super block
 * @param   cluster     number of a data cluster
 */
static inline uint32_t fat_offset_of_clus(struct fat32_sb *fat, uint32_t cluster)
{
    return (cluster << 2) % fat->bpb.byts_per_sec;
}

/**
 * Read the FAT table content corresponded to the given cluster number.
 * @param   sb          super block, we need the functions in it
 * @param   cluster     the number of cluster which you want to read its content in FAT table
 */
static uint32_t read_fat(struct super_block *sb, uint32_t cluster)
{
    if (cluster >= FAT32_EOC) {
        return cluster;
    }
    struct fat32_sb *fat = sb2fat(sb);
    if (cluster > fat->data_clus_cnt + 1) {     // because cluster number starts at 2, not 0
        print("read_fat: cluster=%d exceed the sum=%d!\n", cluster, fat->data_clus_cnt);
        __alert_fs_err("read_fat");
        return 0;
    }
    uint32_t fat_sec = fat_sec_of_clus(fat, cluster, 1);
    uint32_t sec_off = fat_offset_of_clus(fat, cluster);
    // here should be a cache layer for FAT table, but not implemented yet.
    uint32_t next_clus;
    acquire_sleeplock(&sb->sb_lock);
    sb->op.read(sb, 0, (char *)&next_clus, fat_sec, sec_off, sizeof(next_clus));
    release_sleeplock(&sb->sb_lock);

    // LOG_INFO("cur:%d next:%d\n", cluster, next_clus);
    return next_clus;
}

/**
 * Write the FAT region content corresponded to the given cluster number.
 * @param   sb          super block
 * @param   cluster     the number of cluster to write its content in FAT table
 * @param   content     the content which should be the next cluster number of FAT end of chain flag
 */
static int write_fat(struct super_block *sb, uint32_t cluster, uint32_t content)
{
    struct fat32_sb *fat = sb2fat(sb);
    if (cluster > fat->data_clus_cnt + 1) {
        print("write_fat: cluster=%d exceed the sum=%d!\n", cluster, fat->data_clus_cnt);
        __alert_fs_err("write_fat");
        return -1;
    }
    uint32_t fat_sec = fat_sec_of_clus(fat, cluster, 1);
    uint32_t sec_off = fat_offset_of_clus(fat, cluster);
    acquire_sleeplock(&sb->sb_lock);
    sb->op.write(sb, 0, (char *)&content, fat_sec, sec_off, sizeof(content));
    release_sleeplock(&sb->sb_lock);
    return 0;
}

static uint32_t alloc_clus(struct super_block *sb)
{
    // should we keep a free cluster list? instead of searching fat every time.
    struct fat32_sb *fat = sb2fat(sb);
    uint32_t fat_sec = fat->bpb.rsvd_sec_cnt;
    uint32_t const ent_per_sec = fat->bpb.byts_per_sec / sizeof(uint32_t);

    char *buf = kmalloc(fat->bpb.byts_per_sec);
    if (buf == NULL) {
        return 0;
    }
    uint32_t clus = 0;
    acquire_sleeplock(&sb->sb_lock);
    for (uint32_t i = 0; i < fat->bpb.fat_sz; i++, fat_sec++) {
        sb->op.read(sb, 0, buf, fat_sec, 0, fat->bpb.byts_per_sec);
        for (uint32_t j = 0; j < ent_per_sec; j++) {
            if (((uint32_t *)buf)[j] == 0) {
                uint32_t flag = FAT32_EOC + 7;
                sb->op.write(sb, 0, (char*)&flag, fat_sec, j * sizeof(uint32_t), sizeof(uint32_t));

                clus = i * ent_per_sec + j;
                uint32_t sec = first_sec_of_clus(fat, clus);
                sb->op.clear(sb, sec, fat->bpb.sec_per_clus);
                goto end;
            }
        }
    }
end:
    release_sleeplock(&sb->sb_lock);
    kfree(buf);
    return clus;
    // PANIC("no clusters");
}

static void free_clus(struct super_block *sb, uint32_t cluster)
{
    write_fat(sb, cluster, 0);
}

/**
 * Read/Write a cluster, caller must hold relative locks
 */
static uint32_t rw_clus(struct super_block *sb, uint32_t cluster, int write, int user, uint64_t data, uint32_t off, uint32_t n)
{
    struct fat32_sb *fat = sb2fat(sb);
    if (off + n > fat->byts_per_clus)
        PANIC("rw_clus: offset out of range");

    uint32_t tot, m;
    uint16_t const bps = fat->bpb.byts_per_sec;
    uint32_t sec = first_sec_of_clus(fat, cluster) + off / bps;

    // LOG_INFO("data:%p\n", data);
    for (tot = 0; tot < n; tot += m, off += m, data += m, sec++) {
        m = bps - off % bps;
        if (n - tot < m) {
            m = n - tot;
        }
        if (write) {
            if (sb->op.write(sb, user, (char*)data, sec, off % bps, m) < 0) {
                break;
            }
        } else if (sb->op.read(sb, user, (char*)data, sec, off % bps, m) < 0) {
            break;
        }
    }
    // LOG_INFO("clus:%d off:%d len:%d tot:%d\n", cluster, off, n, tot);
    return tot;
}


/**
 * FAT32 operations.
 *
 *
 */

// Convert to the so-call inode of FAT32.
static inline struct fat32_dentry *i2fat(struct inode *ip)
{
    return (struct fat32_dentry *)ip->real_i;
}

// There is no real inode on disk, just return an in-mem structure.
struct inode *fat_alloc_inode(struct super_block *sb)
{
    struct inode *ip = kmalloc(sizeof(struct inode));
    if (ip == NULL) {
        return NULL;
    }

    ip->sb = sb;
    ip->entry = NULL;
    ip->ref = 0;
    ip->state = 0;
    ip->mode = 0;
    ip->size = 0;
    ip->nlink = 0;
    init_sleeplock(&ip->lock, "inode");

    return ip;
}

void fat_destroy_inode(struct inode *ip)
{
    if (ip == NULL || ip->real_i == NULL)
        PANIC("fat_destroy_inode");

    kfree(ip->real_i);
    kfree(ip);
}


/**
 * for the given entry, relocate the cur_clus field based on the off
 * @param   ip          to get its fat32_dentry and modify the cur_clus field
 * @param   off         the offset from the beginning of the relative file
 * @param   alloc       whether alloc new cluster when meeting end of FAT chains
 * @return              the offset from the new cur_clus or -1 if fail
 */
static int reloc_clus(struct inode *ip, uint32_t off, int alloc)
{
    struct fat32_dentry *entry = i2fat(ip);
    struct fat32_sb *fat = sb2fat(ip->sb);

    int clus_num = off / fat->byts_per_clus;
    while (clus_num > entry->clus_cnt) {
        int clus = read_fat(ip->sb, entry->cur_clus);
        if (clus >= FAT32_EOC) {
            if (!alloc || (clus = alloc_clus(ip->sb)) == 0) {
                goto fail;
            }
            if (write_fat(ip->sb, entry->cur_clus, clus) < 0) {
                goto fail;
            }
        } else if (clus < 2) {
            goto fail;
        }
        entry->cur_clus = clus;
        entry->clus_cnt++;
    }
    if (clus_num < entry->clus_cnt) {
        entry->cur_clus = entry->first_clus;
        entry->clus_cnt = 0;
        while (entry->clus_cnt < clus_num) {
            entry->cur_clus = read_fat(ip->sb, entry->cur_clus);
            if (entry->cur_clus >= FAT32_EOC) {
                PANIC("reloc_clus");
            }
            entry->clus_cnt++;
        }
    }
    return off % fat->byts_per_clus;

fail:
    entry->cur_clus = entry->first_clus;
    entry->clus_cnt = 0;
    return -1;
}

/**
 * Caller must hold ip->lock.
 * Read from the file that ip corresponds to.
 * @param   ip          the inode
 * @param   user_dst    whether the dst is user space
 * @param   dst         data dst
 * @param   ip          the inode
 * @param   off         the offset from the beginning of the relative file
 * @param   n           number of bytes to read
 * @return              the total bytes that have been read
 */
int fat_read_file(struct inode *ip, uint32_t user_dst, uint64_t dst, uint32_t off, uint32_t n)
{
    struct fat32_dentry *entry = i2fat(ip);

    if (off > entry->file_size || off + n < off || (entry->attribute & ATTR_DIRECTORY)) {
        return 0;
    }
    if (off + n > entry->file_size) {
        n = entry->file_size - off;
    }

    uint32_t tot, m;
    uint32_t const bpc = ((struct fat32_sb *)(ip->sb->real_sb))->byts_per_clus;
    for (tot = 0; tot < n; tot += m, off += m, dst += m) {
        if (reloc_clus(ip, off, 0) < 0) {
            break;
        }
        m = bpc - off % bpc;
        if (n - tot < m) {
            m = n - tot;
        }
        if (rw_clus(ip->sb, entry->cur_clus, 0, user_dst, dst, off % bpc, m) != m) {
            break;
        }
    }
    // LOG_INFO("file:%s off:%d len:%d read:%d\n", ip->entry->filename, off, n, tot);
    return tot;
}

/**
 * Caller must hold ip->lock.
 * Write to the file that ip corresponds to.
 * @param   ip          the inode
 * @param   user_src    whether the src is user space
 * @param   src         data src
 * @param   ip          the inode
 * @param   off         the offset from the beginning of the relative file
 * @param   n           number of bytes to write
 * @return              the total bytes that have been written
 *                      or -1 if completely fail
 */
int fat_write_file(struct inode *ip, uint32_t user_src, uint64_t src, uint32_t off, uint32_t n)
{
    struct fat32_dentry *entry = i2fat(ip);

    if (off > entry->file_size || off + n < off || (uint64_t)off + n > 0xffffffff
        || (entry->attribute & ATTR_READ_ONLY)) {
        return -1;
    }
    if (entry->first_clus == 0) {   // so file_size if 0 too, which requests off == 0
        if ((entry->cur_clus = entry->first_clus = alloc_clus(ip->sb)) == 0) {
            return -1;
        }
        entry->clus_cnt = 0;
        ip->state |= I_STATE_DIRTY;
    }

    uint32_t tot, m;
    uint32_t const bpc = ((struct fat32_sb *)(ip->sb->real_sb))->byts_per_clus;
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
        if (reloc_clus(ip, off, 1) < 0) {
            break;
        }
        m = bpc - off % bpc;
        if (n - tot < m) {
            m = n - tot;
        }
        if (rw_clus(ip->sb, entry->cur_clus, 1, user_src, src, off % bpc, m) != m) {
            break;
        }
    }
    if (n > 0 && off > entry->file_size) {
        ip->size = entry->file_size = off;
        ip->state |= I_STATE_DIRTY;
    }
    LOG_INFO("fat_write_file, file:%s off:%d len:%d written:%d\n", ip->entry->name, off, n, tot);
    return tot;
}

// trim ' ' in the head and tail, '.' in head, and test legality
static char *formatname(char *name)
{
    static char illegal[] = { '\"', '*', '/', ':', '<', '>', '?', '\\', '|', 0 };
    char *p;
    while (*name == ' ' || *name == '.') { name++; }
    for (p = name; *p; p++) {
        char c = *p;
        if (c < 0x20 || strchr(illegal, c)) {
            return 0;
        }
    }
    while (p-- > name) {
        if (*p != ' ') {
            p[1] = '\0';
            break;
        }
    }
    return name;
}

static void generate_shortname(char *shortname, char *name)
{
    static char illegal[] = { '+', ',', ';', '=', '[', ']', 0 };   // these are legal in l-n-e but not s-n-e
    int i = 0;
    char c, *p = name;
    for (int j = strlen(name) - 1; j >= 0; j--) {
        if (name[j] == '.') {
            p = name + j;
            break;
        }
    }
    while (i < SHORT_NAME_SIZE && (c = *name++)) {
        if (i == 8 && p) {
            if (p + 1 < name) { break; }            // no '.'
            else {
                name = p + 1, p = 0;
                continue;
            }
        }
        if (c == ' ') { continue; }
        if (c == '.') {
            if (name > p) {                    // last '.'
                memset(shortname + i, ' ', 8 - i);
                i = 8, p = 0;
            }
            continue;
        }
        if (c >= 'a' && c <= 'z') {
            c += 'A' - 'a';
        } else {
            if (strchr(illegal, c) != NULL) {
                c = '_';
            }
        }
        shortname[i++] = c;
    }
    while (i < SHORT_NAME_SIZE) {
        shortname[i++] = ' ';
    }
}

static uint8_t cal_checksum(uint8_t* shortname)
{
    uint8_t sum = 0;
    for (int i = SHORT_NAME_SIZE; i != 0; i--) {
        sum = ((sum & 1) ? 0x80 : 0) + (sum >> 1) + *shortname++;
    }
    return sum;
}

/**
 * Generate an on disk format entry and write to the disk.
 * Caller must hold dir->lock unless in fat_alloc_entry.
 * @param   dir         the directory inode
 * @param   ep          entry to write on disk
 * @param   off         offset int the dp, should be calculated via dirlookup before calling this
 */
static int fat_make_entry(struct inode *dir, struct fat32_dentry *ep, char *filename, uint32_t off, int islong)
{
    struct fat32_dentry *dp = i2fat(dir);
    if (!(dp->attribute & ATTR_DIRECTORY))
        PANIC("fat_make_entry: not dir");
    if (off % sizeof(union fat_disk_entry))
        PANIC("fat_make_entry: not aligned");

    union fat_disk_entry de;
    memset(&de, 0, sizeof(de));
    if (!islong) {
        strncpy(de.sne.name, filename, sizeof(de.sne.name));
    } else {
        char shortname[SHORT_NAME_SIZE + 1];
        memset(shortname, 0, sizeof(shortname));
        generate_shortname(shortname, filename);
        de.lne.checksum = cal_checksum((uint8_t *)shortname);
        de.lne.attr = ATTR_LONG_NAME;
        for (int i = ep->ent_cnt - 1; i > 0; i--) {
            if ((de.lne.order = i) == ep->ent_cnt - 1) {
                de.lne.order |= LAST_LONG_ENTRY;
            }
            char *p = filename + (i - 1) * LONG_NAME_SIZE;
            uint8_t *w = (uint8_t *)de.lne.name1;
            int end = 0;
            for (int j = 1; j <= LONG_NAME_SIZE; j++) {
                if (end) {
                    *w++ = 0xff;            // on k210, unaligned reading is illegal
                    *w++ = 0xff;
                } else {
                    if ((*w++ = *p++) == 0) {
                        end = 1;
                    }
                    *w++ = 0;
                }
                switch (j) {
                    case 5:     w = (uint8_t *)de.lne.name2; break;
                    case 11:    w = (uint8_t *)de.lne.name3; break;
                }
            }
            int off2 = reloc_clus(dir, off, 1);
            // LOG_INFO("name:%s clus:%d off:%d\n", ep->filename, dp->cur_clus, off2);
            if (off2 < 0 || rw_clus(dir->sb, dp->cur_clus, 1, 0, (uint64_t)&de, off2, sizeof(de)) != sizeof(de))
                return -1;
            off += sizeof(de);
        }
        memset(&de, 0, sizeof(de));
        strncpy(de.sne.name, shortname, sizeof(de.sne.name));
    }
    de.sne.attr = ep->attribute;
    de.sne.fst_clus_hi = (uint16_t)(ep->first_clus >> 16);      // first clus high 16 bits
    de.sne.fst_clus_lo = (uint16_t)(ep->first_clus & 0xffff);     // low 16 bits
    de.sne.file_size = ep->file_size;                         // filesize is updated in eupdate()
    int off2 = reloc_clus(dir, off, 1);
    // LOG_INFO("name:%s clus:%d off:%d\n", ep->filename, dp->cur_clus, off2);
    if (off2 < 0 || rw_clus(dir->sb, dp->cur_clus, 1, 0, (uint64_t)&de, off2, sizeof(de)) != sizeof(de))
        return -1;
    return 0;
}

static struct fat32_dentry *fat_lookup_dir_ent(struct inode *dir, char *filename, uint32_t *poff);

/**
 * Allocate an entry on disk. If the file already exists, just return it.
 * Caller must hold dir->lock.
 * @param   dir         the directory inode
 * @param   name        the file to allocate on disk
 * @param   mode        dir or file (read/write control is not consider yet)
 * @return              the inode structure of the new file
 */
struct inode *fat_alloc_entry(struct inode *dir, char *name, int mode)
{
    if (dir->state & I_STATE_FREE || !(name = formatname(name))) {        // detect illegal character
        return NULL;
    }
    struct fat32_dentry *dp = i2fat(dir);
    if (!(dp->attribute & ATTR_DIRECTORY))
        PANIC("ealloc not dir");

    struct super_block *sb = dir->sb;
    struct inode *ip;
    uint32_t off = 0;
    /* If the file exists on disk. */
    if ((ip = fat_lookup_dir(dir, name, &off)) != NULL) {      // entry exists
        return ip;
    }
    if ((ip = fat_alloc_inode(sb)) == NULL) {
        return NULL;
    }
    ip->op = dir->op;
    ip->fop = dir->fop;
    ip->mode = mode;

    struct fat32_dentry *ep;
    if ((ep = kmalloc(sizeof(struct fat32_dentry))) == NULL) {
        kfree(ip);
        return NULL;
    }
    ep->attribute = mode == T_DIR ? ATTR_DIRECTORY : 0;
    ep->file_size = 0;
    ep->first_clus = 0;
    ep->clus_cnt = 0;
    ep->cur_clus = 0;
    ep->ent_cnt = (strlen(name) + LONG_NAME_SIZE - 1) / LONG_NAME_SIZE + 1;
    // safestrcpy(ep->filename, name, sizeof(ep->filename));
    ip->real_i = ep;
    reloc_clus(dir, off, 0);
    ip->ino_num = ((uint64_t)dp->cur_clus << 32) | (off % sb2fat(sb)->byts_per_clus);

    if (mode == T_DIR) {    // generate "." and ".." for ep
        if ((ep->cur_clus = ep->first_clus = alloc_clus(sb)) < 0
            || fat_make_entry(ip, ep, ".          ", 0, 0) < 0
            || fat_make_entry(ip, dp, "..         ", 32, 0) < 0)
        {
            if (ep->first_clus > 0)
                free_clus(sb, ep->first_clus);
            goto fail;
        }
    }
    else {  // what is this for?
        ep->attribute |= ATTR_ARCHIVE;
    }

    if (fat_make_entry(dir, ep, name, off, 1) < 0)
        goto fail;

    return ip;

fail:
    __alert_fs_err("fat_alloc_entry");
    kfree(ip);
    kfree(ep);
    return NULL;
}

/**
 * Update the inode info to disk. On FAT32, it's actually
 * update the directory entry. We only update filesize
 * and first cluster in our case.
 */
int fat_update_entry(struct inode *ip)
{
    if (!(ip->state & I_STATE_DIRTY))
        return 0;
    if (ip->state & I_STATE_FREE)
        return -1;

    struct fat32_sb *fat = sb2fat(ip->sb);
    struct fat32_dentry *entry = i2fat(ip);
    uint32_t clus = ip->ino_num >> 32;
    uint32_t off = (ip->ino_num & 0xffffffff) + ((entry->ent_cnt - 1) << 5);

    union fat_disk_entry de;

    // The short entry steps over the cluster.
    if (off >= fat->byts_per_clus) {
        clus = read_fat(ip->sb, clus);
        if (clus == 0) { goto fail; }
        off %= fat->byts_per_clus;
    }

    // Read from disk.
    if (rw_clus(ip->sb, clus, 0, 0, (uint64_t)&de, off, sizeof(de)) != sizeof(de))
        goto fail;
    de.sne.fst_clus_hi = (uint16_t)(entry->first_clus >> 16);
    de.sne.fst_clus_lo = (uint16_t)(entry->first_clus & 0xffff);
    de.sne.file_size = entry->file_size;
    // Wirte back.
    if (rw_clus(ip->sb, clus, 1, 0, (uint64_t)&de, off, sizeof(de)) != sizeof(de))
        goto fail;
    ip->state &= ~I_STATE_DIRTY;

    return 0;

fail:
    __alert_fs_err("fat_update_entry");
    return -1;
}

/**
 * Remove the entry in its parent directory.
 * The content of the file is removed by 'truncate'.
 */
int fat_remove_entry(struct inode *ip)
{
    if (ip->state & I_STATE_FREE)
        return -1;

    struct fat32_sb *fat = sb2fat(ip->sb);
    struct fat32_dentry *entry = i2fat(ip);
    uint32_t clus = ip->ino_num >> 32;
    uint32_t off = ip->ino_num & 0xffffffff;

    // LOG_INFO("clus:%d off:%d entcnt:%d\n", clus, off, entry->ent_cnt);
    uint8_t flag = EMPTY_ENTRY;
    for (int i = 0; i < entry->ent_cnt; i++) {
        // LOG_INFO("name:%s clus:%d off:%d i:%d\n", entry->filename, clus, off, i);
        if (rw_clus(ip->sb, clus, 1, 0, (uint64_t)&flag, off, 1) != 1)
            goto fail;
        if ((off += 32) >= fat->byts_per_clus) {
            if ((clus = read_fat(ip->sb, clus)) == 0 || clus >= FAT32_EOC) {
                goto fail;
            }
            off %= fat->byts_per_clus;
            // LOG_INFO("entries over clus! new_clus:%d new_off:%d\n", clus, off);
        }
    }

    return 0;

fail:
    __alert_fs_err("eremove");
    return -1;
}

/**
 * Truncate the file content.
 * Caller must hold ip->lock.
 */
int fat_truncate_file(struct inode *ip)
{
    struct fat32_dentry *entry = i2fat(ip);

    for (uint32_t clus = entry->first_clus; clus >= 2 && clus < FAT32_EOC; ) {
        uint32_t next = read_fat(ip->sb, clus);
        if (next < 2) {
            __alert_fs_err("fat_truncate_file");
            return -1;
        }
        free_clus(ip->sb, clus);
        clus = next;
    }
    ip->size = entry->file_size = 0;
    entry->first_clus = 0;

    ip->state |= I_STATE_DIRTY;
    return 0;
}

int fat_stat_file(struct inode *ip, struct kstat *st)
{
    struct fat32_dentry *ep = i2fat(ip);
    struct fat32_sb *fat = sb2fat(ip->sb);

    memset(st, 0, sizeof(struct kstat));
    st->blksize = fat->byts_per_clus;
    st->size = ep->file_size;
    st->blocks = (st->size + st->blksize - 1) / st->blksize;
    st->dev_num = ip->sb->dev_num;
    st->ino_num = ep->first_clus;
    st->mode = ip->mode;

    return 0;
}

/**
 * Read filename from directory entry.
 * @param   buffer      pointer to the array that stores the name
 * @param   d           pointer to the raw format entry buffer
 */
static void read_entry_name(char *buffer, union fat_disk_entry *d)
{
    if (d->lne.attr == ATTR_LONG_NAME) {                       // long entry branch
        wchar temp[NELEM(d->lne.name1)];
        memmove(temp, d->lne.name1, sizeof(temp));
        snstr(buffer, temp, NELEM(d->lne.name1));
        buffer += NELEM(d->lne.name1);
        snstr(buffer, d->lne.name2, NELEM(d->lne.name2));
        buffer += NELEM(d->lne.name2);
        snstr(buffer, d->lne.name3, NELEM(d->lne.name3));
    } else {
        // assert: only "." and ".." will enter this branch
        memset(buffer, 0, SHORT_NAME_SIZE + 2); // plus '.' and '\0'
        int i;
        for (i = 0; d->sne.name[i] != ' ' && i < 8; i++) {
            buffer[i] = d->sne.name[i];
        }
        if (d->sne.name[8] != ' ') {
            buffer[i++] = '.';
        }
        for (int j = 8; j < SHORT_NAME_SIZE; j++, i++) {
            if (d->sne.name[j] == ' ') { break; }
            buffer[i] = d->sne.name[j];
        }
    }
}

/**
 * Read entry_info from directory entry.
 * @param   entry       pointer to the structure that stores the entry info
 * @param   d           pointer to the raw format entry buffer
 */
static void read_entry_info(struct fat32_dentry *entry, union fat_disk_entry *d)
{
    entry->attribute = d->sne.attr;
    entry->first_clus = ((uint32_t)d->sne.fst_clus_hi << 16) | d->sne.fst_clus_lo;
    entry->file_size = d->sne.file_size;
    entry->cur_clus = entry->first_clus;
    entry->clus_cnt = 0;
}

/**
 * Read a directory from off, parse the next entry(ies) associated with one file, or find empty entry slots.
 * Caller must hold dir->lock.
 * @param   dir     the directory inode
 * @param   ep      the struct to be written with info
 * @param   off     offset off the directory
 * @param   count   to write the count of entries
 * @return  -1      meet the end of dir
 *          0       find empty slots
 *          1       find a file with all its entries
 */
int fat_dir_next(struct inode *dir, struct fat32_dentry *ep, char *namebuf, uint32_t off, int *count)
{
    if (dir->state & I_STATE_FREE)
        return -1;

    struct fat32_dentry *dp = i2fat(dir);
    if (!(dp->attribute & ATTR_DIRECTORY))
        PANIC("enext not dir");
    if (off % 32)
        PANIC("enext not align");

    union fat_disk_entry de;
    int empty = 0, cnt = 0;
    memset(namebuf, 0, FAT32_MAX_FILENAME + 1);
    for (int off2; (off2 = reloc_clus(dir, off, 0)) != -1; off += sizeof(de))
    {
        if (rw_clus(dir->sb, dp->cur_clus, 0, 0, (uint64_t)&de, off2, sizeof(de)) != sizeof(de)
            || de.lne.order == END_OF_DIR) {
            return -1;
        }
        if (de.lne.order == EMPTY_ENTRY) {
            if (cnt) {      // We have met a l-n-e, but why we come across an empty one?
                goto excep; // Maybe the entry is being removed by its so-call inode.
            }
            empty++;
            continue;
        } else if (empty) {
            *count = empty;
            return 0;
        }
        if (de.lne.attr == ATTR_LONG_NAME) {
            if (de.lne.order & LAST_LONG_ENTRY) {
                cnt = (de.lne.order & ~LAST_LONG_ENTRY) + 1;   // plus the s-n-e;
                *count = cnt;
            } else if (cnt == 0) {    // Should not occur unless some inode is removing this entry
                goto excep;
            }
            read_entry_name(namebuf + (--cnt - 1) * LONG_NAME_SIZE, &de);
        } else {
            if (cnt == 0) {     // Without l-n-e
                *count = 1;
                read_entry_name(namebuf, &de);
            }
            read_entry_info(ep, &de);
            return 1;
        }
    }
    return -1;

excep:
    *count = 0;     // Caller will re-read
    return 0;
}


/**
 * Read a directory from off, and stat the next file. Skip empty entries.
 * @return  bytes that the entries take up, or 0 if no entries
 */
int fat_read_dir(struct super_block *sb, struct inode *ip, struct dirent *dent, uint32_t off)
{
    if (!(i2fat(ip)->attribute & ATTR_DIRECTORY))
        return -1;

    int count = 0;
    uint32_t off2 = off - off % 32;

    struct fat32_dentry entry;
    int ret;
    while ((ret = fat_dir_next(ip, &entry, dent->d_name, off2, &count)) == 0) {
        // Skip empty entries.
        off2 += count << 5;
    }

    // Meet end of dir
    if (ret < 0) {
        return 0;
    }
    ret = off2 + (count << 5) - off;

    int size = sizeof(struct dirent) - sizeof(dent->d_name) + strlen(dent->d_name) + 1;
    size += (sizeof(uint64_t) - (size % sizeof(uint64_t))) % sizeof(uint64_t); // Align to 8.

    dent->d_ino_num = entry.first_clus;
    dent->d_off = off2;
    dent->d_reclen = size;
    dent->d_type = (entry.attribute & ATTR_DIRECTORY) ? T_DIR : T_FILE;

    return ret;
}


/**
 * Seacher for the entry in a directory and return a structure. Besides, record the offset of
 * some continuous empty slots that can fit the length of filename.
 *
 * Doesn't handle "." and "..", vfs will do that.
 * Doesn't check cache, vfs also takes care of that.
 *
 * Caller must hold dir->lock.
 * @param   dir         the directory inode
 * @param   filename    target filename
 * @param   poff        offset of proper empty entry slots from the beginning of the dir
 */
static struct fat32_dentry *fat_lookup_dir_ent(struct inode *dir, char *filename, uint32_t *poff)
{
    if (!(i2fat(dir)->attribute & ATTR_DIRECTORY))
        PANIC("dirlookup not DIR");
    if (dir->state & I_STATE_FREE)
        return NULL;

    struct fat32_dentry *ep = kmalloc(sizeof(struct fat32_dentry));
    if (ep == NULL) { return NULL; }

    int len = strlen(filename);
    int entcnt = (len + LONG_NAME_SIZE - 1) / LONG_NAME_SIZE + 1;   // count of l-n-entries, rounds up. plus s-n-e
    int count = 0;
    int type;
    uint32_t off = 0;
    char namebuf[FAT32_MAX_FILENAME + 1];
    reloc_clus(dir, 0, 0);
    while ((type = fat_dir_next(dir, ep, namebuf, off, &count) != -1)) {
        if (type == 0) {
            if (poff && count >= entcnt) {
                *poff = off;
                poff = NULL;
            }
        } else if (strncmp(filename, namebuf, FAT32_MAX_FILENAME) == 0) {
            if (poff) {
                *poff = off;
            }
            ep->ent_cnt = entcnt;
            return ep;
        }
        off += count << 5;
    }
    if (poff) {
        *poff = off;
    }
    kfree(ep);
    return NULL;
}

/**
 * Call to 'fat_lookup_dir_ent', and stuff the fat32_dentry into an inode.
 *
 * Caller must hold dir->lock.
 */
struct inode *fat_lookup_dir(struct inode *dir, char *filename, uint32_t *poff)
{
    struct super_block *sb = dir->sb;
    struct inode *ip = fat_alloc_inode(sb);
    if (ip == NULL) {
        return NULL;
    }

    uint32_t off = 0;    // Anyhow, we need this on FAT32
    struct fat32_dentry *ep = fat_lookup_dir_ent(dir, filename, &off);
    if (ep == NULL) {
        kfree(ip);
        if (poff) {
            *poff = off;
        }
        return NULL;
    }

    ip->op = dir->op;
	ip->fop = dir->fop;
    ip->real_i = ep;
    ip->size = ep->file_size;
    ip->mode = (ep->attribute & ATTR_DIRECTORY) ? T_DIR : T_FILE;

    struct fat32_dentry *dp = i2fat(dir);
    uint32_t coff = reloc_clus(dir, off, 0);
    ip->ino_num = ((uint64_t)dp->cur_clus << 32) | coff;
    LOG_INFO("name:%s ipos: clus=%d coff=%d inum=%p sizeof(uint64)=%d\n",
                filename, dp->cur_clus, coff, ip->ino_num, sizeof(uint64_t));

    if (poff) {
        *poff = off;
    }

    return ip;
}
