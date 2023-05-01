#ifndef STRING_H
#define STRING_H

#include "defs.h"

int   memcmp(const void*, const void*, uint32);

void* memmove(void* dst, const void* src, uint32 n);

void* memcpy(void* dst, const void* src, uint32 n);

void* memset(void* addr, int val, uint32 n);

int   strlen(const char*);

int   strncmp(const char*, const char*, uint32);

char* strncpy(char*, const char*, int);

#endif
