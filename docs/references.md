# References

- [Original book website](http://hrb.osask.jp)
- https://viterbi-web.usc.edu/~yudewei/main/sources/books/30天自制操作系统/
- https://github.com/sky5454/30daysMakeOS-Origin-ISOfiles
- https://github.com/ghosind/HariboteOS
- [Intel 386 and AMD x86-64 Options](https://gcc.gnu.org/onlinedocs/gcc-4.7.2/gcc/i386-and-x86_002d64-Options.html)
- https://github.com/kamaboko123/30daysOS

```sh
30daysOS/day22/harib19f$ make run
ld -m elf_i386 -o bin/os.bin -T scripts/bootpack.lds -e HariMain --oformat=binary -Map=bin/os.map bin/bootpack.o bin/console.o bin/dsctbl.o bin/fifo.o bin/file.o bin/graphic.o bin/int.o bin/keyboard.o bin/memory.o bin/mouse.o bin/mtask.o bin/sheet.o bin/timer.o bin/window.o ../../tools/stdlibc/bin/stdlibc.o bin/asm_func.o ../../tools/makefont/bin/hankaku.o
ld: section .text.__x86.get_pc_thunk.bx LMA [00000000000058b2,00000000000058b5] overlaps section .data LMA [00000000000058b2,000000000000946d]
ld: bin/bootpack.o: in function `HariMain':
bootpack.c:(.text+0x12): undefined reference to `_GLOBAL_OFFSET_TABLE_'
ld: bin/console.o: in function `console_task':
console.c:(.text+0x13): undefined reference to `_GLOBAL_OFFSET_TABLE_'
ld: bin/console.o: in function `cons_putchar':
console.c:(.text+0x3d8): undefined reference to `_GLOBAL_OFFSET_TABLE_'
ld: bin/console.o: in function `cons_newline':
console.c:(.text+0x4ee): undefined reference to `_GLOBAL_OFFSET_TABLE_'
ld: bin/console.o: in function `cons_runcmd':
console.c:(.text+0x605): undefined reference to `_GLOBAL_OFFSET_TABLE_'
ld: bin/console.o:console.c:(.text+0x709): more undefined references to `_GLOBAL_OFFSET_TABLE_' follow
make: *** [Makefile:88: bin/os.bin] Error 1
```
