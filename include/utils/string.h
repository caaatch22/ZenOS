#ifndef STRING_H
#define STRING_H

#include "common/defs.h"

int   memcmp(const void* v1, const void* v2, uint32_t n);

void* memmove(void* dst, const void* src, uint32_t n);

void* memcpy(void* dst, const void* src, uint32_t n);

void* memset(void* addr, int val, uint32_t n);

int   strlen(const char* s);

int   strncmp(const char* p, const char* q, uint32_t n);

char* strncpy(char* s, const char* t, int n);

#endif
