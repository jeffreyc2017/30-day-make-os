#include <stddef.h>

#ifndef _STRING_H
#define _STRING_H

int strcmp(const char *s1, const char *s2);
int strncmp(const char *s1, const char *s2, size_t n);
int memcmp(const void *s1, const void *s2, size_t n);
size_t strlen(const char *str);
int strtol(char *nptr, char **endptr, int base);

#endif // _STRING_H
