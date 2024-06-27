#ifndef SETJMP_H
#define SETJMP_H

#include <stdint.h>

// Define the size of the jmp_buf structure
typedef struct {
    uint32_t regs[6];  // A simple implementation for registers
} jmp_buf[1];

// Function prototypes
int setjmp(jmp_buf env);
void longjmp(jmp_buf env, int val);

#endif /* SETJMP_H */
