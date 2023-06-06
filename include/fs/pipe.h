#ifndef PIPE_H
#define PIPE_H

#include "common/defs.h"
#include "lock/spinlock.h"
#include "fs/file.h"

#define PIPESIZE 2048

struct pipe {
    char data[PIPESIZE];
    uint32_t nread;    // number of bytes read
    uint32_t nwrite;   // number of bytes written
    int readopen;  // read fd is still open
    int writeopen; // write fd is still open
    struct spinlock lock;
};

int pipealloc(struct file **f0, struct file **f1);
void pipeclose(struct pipe *pi, int writable);
int pipewrite(struct pipe *pi, uint64_t addr, int n);
int piperead(struct pipe *pi, uint64_t addr, int n);

#endif