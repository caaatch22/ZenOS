#ifndef STATUS_H
#define STATUS_H

#include"defs.h"
#include "vfs.h"

typedef struct context
{
  uint64_t ra;
  uint64_t s0;
  uint64_t s1;
  uint64_t s2;
  uint64_t s3;
  uint64_t s4;
  uint64_t s5;
  uint64_t s6;
  uint64_t s7;
  uint64_t s8;
  uint64_t s9;
  uint64_t s10;
  uint64_t s11;
} context;

typedef struct cpu_status
{
  context prev_context;
  struct proc_status *running_proc;
  uint32_t intr_disable_depth;
  uint64_t prev_intr_status;
} cpu_status;

typedef struct proc_status
{
  uint64_t proc_id;
  struct inode *cwd;
  struct inode *elf;
  // TODO
} proc_status;

struct trapframe {
  /*   0 */ uint64_t kernel_satp;   // kernel page table
  /*   8 */ uint64_t kernel_sp;     // top of process's kernel stack
  /*  16 */ uint64_t trap_function;   // usertrap()
  /*  24 */ uint64_t epc;           // saved user program counter
  /*  32 */ uint64_t kernel_hartid; // saved kernel tp
  /*  40 */ uint64_t ra;
  /*  48 */ uint64_t sp;
  /*  56 */ uint64_t gp;
  /*  64 */ uint64_t tp;
  /*  72 */ uint64_t t0;
  /*  80 */ uint64_t t1;
  /*  88 */ uint64_t t2;
  /*  96 */ uint64_t s0;
  /* 104 */ uint64_t s1;
  /* 112 */ uint64_t a0;
  /* 120 */ uint64_t a1;
  /* 128 */ uint64_t a2;
  /* 136 */ uint64_t a3;
  /* 144 */ uint64_t a4;
  /* 152 */ uint64_t a5;
  /* 160 */ uint64_t a6;
  /* 168 */ uint64_t a7;
  /* 176 */ uint64_t s2;
  /* 184 */ uint64_t s3;
  /* 192 */ uint64_t s4;
  /* 200 */ uint64_t s5;
  /* 208 */ uint64_t s6;
  /* 216 */ uint64_t s7;
  /* 224 */ uint64_t s8;
  /* 232 */ uint64_t s9;
  /* 240 */ uint64_t s10;
  /* 248 */ uint64_t s11;
  /* 256 */ uint64_t t3;
  /* 264 */ uint64_t t4;
  /* 272 */ uint64_t t5;
  /* 280 */ uint64_t t6;
};

cpu_status *mycpu();

#endif
