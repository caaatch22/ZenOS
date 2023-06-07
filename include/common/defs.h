#ifndef DEFS_H
#define DEFS_H

#define NULL ((void*) 0)

typedef unsigned char uint8_t;

typedef unsigned short uint16_t;
typedef unsigned short wchar;

typedef unsigned int uint32_t;

typedef unsigned long uint64_t;

typedef long long ssize_t;
typedef unsigned long long size_t;
typedef int pid_t;

typedef int bool;

#define TRUE 1
#define FALSE 0

#define NELEM(x) (sizeof(x)/sizeof((x)[0]))


struct utsname {
  char sysname[65];
  char nodename[65];
  char release[65];
  char version[65];
  char machine[65];
  char domainname[65];
};


#endif
