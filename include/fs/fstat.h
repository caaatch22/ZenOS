#ifndef FSTAT_H
#define FSTAT_H

#include "common/defs.h"
#include "fs/vfs.h"

#ifndef MAX_NAME_SIZE 
#define MAX_NAME_SIZE 255
#endif

// xv6自用stat->mode
#define T_DIR     1   // Directory
#define T_FILE    2   // File
#define T_DEVICE  3   // Device

/*
 * S_IFDIR	Defines a directory.
 * S_IFREG	Defines a regular file.
 * S_IFIFO	Defines a pipe.
 * S_IFCHR	Defines a character device.
 * S_IFBLK	Defines a block device.
 * S_IFLNK	Defines a symbolic link.
 * S_IFSOCK	Defines a socket.
 * from: https://www.ibm.com/docs/en/aix/7.2?topic=files-stath-file
 */
#define S_IFMT 0xF000       // type mask from type
#define S_IFSOCK 0xC000		// socket
#define S_IFLNK 0xA000		  // symbolic link
#define S_IFREG 0x8000		  // regular file
#define S_IFBLK 0x6000		  // block device
#define S_IFDIR 0x4000		  // directory
#define S_IFCHR 0x2000		  // character device
#define S_IFIFO 0x1000		  // FIFO

struct kstat {
  uint32_t dev_num;
  uint64_t ino_num;
  uint16_t mode;
  uint32_t nlink;
  uint32_t rdev;
  uint64_t size;
  uint32_t blksize;
  uint64_t blocks;
};

struct dirent {
  uint64_t d_ino_num;
  uint64_t d_off;
  uint8_t d_type;
  char d_name[MAX_NAME_SIZE + 1];
};

#endif
