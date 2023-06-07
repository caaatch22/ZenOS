#ifndef ELF_H
#define ELF_H


#include "common/defs.h"
// Format of an ELF executable file


#define ELF_MAGIC 0x464C457FU  // "\x7FELF" in little endian

// File header
struct elfhdr {
  uint32_t magic;  // must equal ELF_MAGIC
  unsigned char elf[12];
  unsigned short type;
  unsigned short machine;
  uint32_t version;
  uint64_t entry;
  uint64_t phoff;  //
  uint64_t shoff;
  uint32_t flags;
  unsigned short ehsize;
  unsigned short phentsize;
  unsigned short phnum;
  unsigned short shentsize;
  unsigned short shnum;
  unsigned short shstrndx;
};

// Program header Table
struct proghdr {
  uint32_t type;    // 本段的类型：load
  uint32_t flags;   // 本段的读写权限
  uint64_t off;     // 本段相对文件的起始地址
  uint64_t vaddr;   // 本段应在内存中的地址
  uint64_t paddr;
  uint64_t filesz;  // 本段大小
  uint64_t memsz;   // 本段在内存中的大小
  uint64_t align;   // 对齐信息
};

// Values for Proghdr type
#define ELF_PROG_LOAD           1

// Flag bits for Proghdr flags
#define ELF_PROG_FLAG_EXEC      1
#define ELF_PROG_FLAG_WRITE     2
#define ELF_PROG_FLAG_READ      4

// AUX
#define AT_NULL		0		/* End of vector */
#define AT_IGNORE	1		/* Entry should be ignored */
#define AT_EXECFD	2		/* File descriptor of program */
#define AT_PHDR		3		/* Program headers for program */
#define AT_PHENT	4		/* Size of program header entry */
#define AT_PHNUM	5		/* Number of program headers */
#define AT_PAGESZ	6		/* System page size */
#define AT_BASE		7		/* Base address of interpreter */
#define AT_FLAGS	8		/* Flags */
#define AT_ENTRY	9		/* Entry point of program */
#define AT_NOTELF	10		/* Program is not ELF */
#define AT_UID		11		/* Real uid */
#define AT_EUID		12		/* Effective uid */
#define AT_GID		13		/* Real gid */
#define AT_EGID		14		/* Effective gid */
#define AT_CLKTCK	17		/* Frequency of times() */

/* Some more special a_type values describing the hardware.  */
#define AT_PLATFORM	15		/* String identifying platform.  */
#define AT_HWCAP	16		/* Machine-dependent hints about processor capabilities.  */

/* This entry gives some information about the FPU initialization performed by the kernel.  */
#define AT_FPUCW	18		/* Used FPU control word.  */

/* Cache block sizes.  */
#define AT_DCACHEBSIZE	19		/* Data cache block size.  */
#define AT_ICACHEBSIZE	20		/* Instruction cache block size.  */
#define AT_UCACHEBSIZE	21		/* Unified cache block size.  */

/* A special ignored value for PPC, used by the kernel to control the interpretation of the AUXV. Must be > 16.  */
#define AT_IGNOREPPC	22		/* Entry should be ignored.  */

#define	AT_SECURE	23		/* Boolean, was exec setuid-like?  */

#define AT_BASE_PLATFORM 24		/* String identifying real platforms.*/

#define AT_RANDOM	25		/* Address of 16 random bytes.  */

#define AT_HWCAP2	26		/* More machine-dependent hints about processor capabilities.  */

#define AT_EXECFN	31		/* Filename of executable.  */

/* Pointer to the global system page used for system calls and other nice things.  */
#define AT_SYSINFO	32
#define AT_SYSINFO_EHDR	33

#endif