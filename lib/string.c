#include "string.h"
#include "defs.h"

void* memset(void* dst, int c, uint32_t n) 
{
  char* cdst = (char*)dst;
  for (int i = 0; i < n; i++) {
    cdst[i] = c;
  }
  return dst;
}

int memcmp(const void* v1, const void* v2, uint32_t n) 
{
  const uint8_t *s1 = v1;
  const uint8_t *s2 = v2;

  while (n--) {
    if (*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}

void* memmove(void* dst, const void* src, uint32_t n) 
{
  const char* s;
  char* d;

  if (n == 0)
    return dst;

  s = src;
  d = dst;
  if (s < d && s + n > d) {
    s += n;
    d += n;
    while (n-- > 0)
      *--d = *--s;
  }
  else
    while (n-- > 0)
      *d++ = *s++;

  return dst;
}

// memcpy exists to placate GCC.  Use memmove.
void* memcpy(void* dst, const void* src, uint32_t n) 
{
    return memmove(dst, src, n);
}

int strncmp(const char* p, const char* q, uint32_t n) 
{
  while (n > 0 && *p && *p == *q)
    n--, p++, q++;
  if (n == 0)
    return 0;
  return (uint8_t)*p - (uint8_t)*q;
}

char* strncpy(char* s, const char* t, int n) 
{
  char* os;

  os = s;
  while (n-- > 0 && (*s++ = *t++) != 0)
    ;
  while (n-- > 0)
    *s++ = 0;
  return os;
}

int strlen(const char* s) 
{
  int n;
  for (n = 0; s[n]; n++)
    ;
  return n;
}

char* strchr(const char* s, char c) 
{
  for (; *s; s++)
    if (*s == c)
      return (char*)s;
  return 0;
}
