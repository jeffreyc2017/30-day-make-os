#include <stdio.h>

int main() {
    unsigned int x = 0x01020304;
    unsigned char *c = (unsigned char*)&x;

    if (*c == 0x04) {
        printf("Little-endian\n");
    } else {
        printf("Big-endian\n");
    }
    return 0;
}
