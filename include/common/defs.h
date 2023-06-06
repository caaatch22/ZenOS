#ifndef DEFS_H
#define DEFS_H

#define NULL ((void*) 0)

typedef unsigned char uint8_t;

typedef unsigned short uint16_t;
typedef unsigned short wchar;

typedef unsigned int uint32_t;

typedef unsigned long uint64_t;

typedef int bool;

#define TRUE 1
#define FALSE 0

#define NELEM(x) (sizeof(x)/sizeof((x)[0]))

#endif
