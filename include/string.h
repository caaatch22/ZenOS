#ifndef STRING_H
#define STRING_H

#include "defs.h"

int   memcmp(const void*, const void*, uint32_t);

void* memmove(void* dst, const void* src, uint32_t n);

void* memcpy(void* dst, const void* src, uint32_t n);

void* memset(void* addr, int val, uint32_t n);

int   strlen(const char*);

int   strncmp(const char*, const char*, uint32_t);

char* strncpy(char*, const char*, int);

#endif
