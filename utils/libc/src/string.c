#include <stddef.h>
#include <string.h>
#include <limits.h>

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

size_t strlen(const char *str)
{
    const char *s;
    for (s = str; *s; ++s) {}
    return (size_t)(s - str);
}

// Helper function to check if a character is a space
static int is_space(char c) {
    return c == ' ' || c == '\t' || c == '\n' || c == '\v' || c == '\f' || c == '\r';
}

// Helper function to check if a character is a digit
static int is_digit(char c) {
    return c >= '0' && c <= '9';
}

// Helper function to check if a character is a letter
static int is_alpha(char c) {
    return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z');
}

// Helper function to convert a character to lowercase
static char to_lower(char c) {
    if (c >= 'A' && c <= 'Z') {
        return c + 32;
    }
    return c;
}

int strtol(char *nptr, char **endptr, int base) {
    const char *s = nptr;
    unsigned long acc;
    int c;
    unsigned long cutoff;
    int neg = 0, any, cutlim;

    // Skip white space
    while (is_space(*s)) {
        s++;
    }

    if (*s == '-') {
        neg = 1;
        s++;
    } else if (*s == '+') {
        s++;
    }

    // Determine base if not specified
    if ((base == 0 || base == 16) && *s == '0' && (*(s+1) == 'x' || *(s+1) == 'X')) {
        s += 2;
        base = 16;
    }
    if (base == 0) {
        base = *s == '0' ? 8 : 10;
    }

    cutoff = neg ? -(unsigned long)LONG_MIN : LONG_MAX;
    cutlim = cutoff % (unsigned long)base;
    cutoff /= (unsigned long)base;
    for (acc = 0, any = 0;; s++) {
        c = *s;
        if (is_digit(c)) {
            c -= '0';
        } else if (is_alpha(c)) {
            c = to_lower(c) - 'a' + 10;
        } else {
            break;
        }
        if (c >= base) {
            break;
        }
        if (any < 0 || acc > cutoff || (acc == cutoff && c > cutlim)) {
            any = -1;
        } else {
            any = 1;
            acc *= base;
            acc += c;
        }
    }
    if (any < 0) {
        acc = neg ? LONG_MIN : LONG_MAX;
        // Here you might set an error flag or use some OS-specific error handling
    } else if (neg) {
        acc = -acc;
    }
    if (endptr != NULL) {
        *endptr = (char *)(any ? s : nptr);
    }
    return (int)acc;
}
