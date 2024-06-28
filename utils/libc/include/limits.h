#ifndef _LIMITS_H
#define _LIMITS_H

/* Characteristics of integer types */

/* Minimum of signed integral types.  */
#define INT8_MIN         (-128)
#define INT16_MIN        (-32767-1)
#define INT32_MIN        (-2147483647-1)
#define INT64_MIN        (-9223372036854775807LL-1)

/* Maximum of signed integral types.  */
#define INT8_MAX         (127)
#define INT16_MAX        (32767)
#define INT32_MAX        (2147483647)
#define INT64_MAX        (9223372036854775807LL)

/* Maximum of unsigned integral types.  */
#define UINT8_MAX        (255)
#define UINT16_MAX       (65535)
#define UINT32_MAX       (4294967295U)
#define UINT64_MAX       (18446744073709551615ULL)

/* Minimum of signed integral types having a minimum size.  */
#define INT_LEAST8_MIN   INT8_MIN
#define INT_LEAST16_MIN  INT16_MIN
#define INT_LEAST32_MIN  INT32_MIN
#define INT_LEAST64_MIN  INT64_MIN

/* Maximum of signed integral types having a minimum size.  */
#define INT_LEAST8_MAX   INT8_MAX
#define INT_LEAST16_MAX  INT16_MAX
#define INT_LEAST32_MAX  INT32_MAX
#define INT_LEAST64_MAX  INT64_MAX

/* Maximum of unsigned integral types having a minimum size.  */
#define UINT_LEAST8_MAX  UINT8_MAX
#define UINT_LEAST16_MAX UINT16_MAX
#define UINT_LEAST32_MAX UINT32_MAX
#define UINT_LEAST64_MAX UINT64_MAX

/* Minimum of fast signed integral types having a minimum size.  */
#define INT_FAST8_MIN    INT8_MIN
#define INT_FAST16_MIN   INT32_MIN
#define INT_FAST32_MIN   INT32_MIN
#define INT_FAST64_MIN   INT64_MIN

/* Maximum of fast signed integral types having a minimum size.  */
#define INT_FAST8_MAX    INT8_MAX
#define INT_FAST16_MAX   INT32_MAX
#define INT_FAST32_MAX   INT32_MAX
#define INT_FAST64_MAX   INT64_MAX

/* Maximum of fast unsigned integral types having a minimum size.  */
#define UINT_FAST8_MAX   UINT8_MAX
#define UINT_FAST16_MAX  UINT32_MAX
#define UINT_FAST32_MAX  UINT32_MAX
#define UINT_FAST64_MAX  UINT64_MAX

/* Values to test for integral types holding `void *' pointer.  */
#define INTPTR_MIN       INT32_MIN
#define INTPTR_MAX       INT32_MAX
#define UINTPTR_MAX      UINT32_MAX

/* Minimum for largest signed integral type.  */
#define INTMAX_MIN       INT64_MIN
/* Maximum for largest signed integral type.  */
#define INTMAX_MAX       INT64_MAX
/* Maximum for largest unsigned integral type.  */
#define UINTMAX_MAX      UINT64_MAX

/* Limits of other integer types.  */

/* Limits of `ptrdiff_t' type.  */
#define PTRDIFF_MIN      INT32_MIN
#define PTRDIFF_MAX      INT32_MAX

/* Limits of `sig_atomic_t'.  */
#define SIG_ATOMIC_MIN   INT32_MIN
#define SIG_ATOMIC_MAX   INT32_MAX

/* Limit of `size_t' type.  */
#define SIZE_MAX         UINT32_MAX

/* Limits of `wchar_t'.  */
#define WCHAR_MIN        0
#define WCHAR_MAX        UINT16_MAX

/* Limits of `wint_t'.  */
#define WINT_MIN         0
#define WINT_MAX         UINT16_MAX

/* Signed.  */
#define SCHAR_MIN        INT8_MIN
#define SCHAR_MAX        INT8_MAX

#define SHRT_MIN         INT16_MIN
#define SHRT_MAX         INT16_MAX

#define INT_MIN          INT32_MIN
#define INT_MAX          INT32_MAX

#define LONG_MIN         INT32_MIN
#define LONG_MAX         INT32_MAX

#define LLONG_MIN        INT64_MIN
#define LLONG_MAX        INT64_MAX

/* Unsigned.  */
#define UCHAR_MAX        UINT8_MAX

#define USHRT_MAX        UINT16_MAX

#define UINT_MAX         UINT32_MAX

#define ULONG_MAX        UINT32_MAX

#define ULLONG_MAX       UINT64_MAX

/* Other */
#define CHAR_BIT         8

#endif /* _LIMITS_H */
