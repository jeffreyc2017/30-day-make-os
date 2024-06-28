#include <stddef.h>
#include <string.h>

int strcmp(const char *s1,const char *s2) {
  while (*s1 == *s2) {
    if (*s1 == '\0') {
      return 0;
    }

    s1++;
    s2++;
  }

  return *s1 - *s2;
}

int strncmp(const char *s1, const char *s2, size_t n) {
  for (size_t i = 0; i < n; i++, s1++, s2++) {
    if (*s1 != *s2) {
      return *s1 - *s2;
    }

    if (*s1 == '\0') {
      return 0;
    }
  }

  return 0;
}

int memcmp(const void *s1, const void *s2, size_t n)
{
    const unsigned char *p1 = s1, *p2 = s2;

    for (size_t i = 0; i < n; i++) {
        if (p1[i] != p2[i]) {
            return p1[i] - p2[i];
        }
    }

    return 0;
}
