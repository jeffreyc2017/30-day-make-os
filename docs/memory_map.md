# Memory map

8.5

| Memory                  | Content                                                            |
| ----------------------- | ------------------------------------------------------------------ |
| 0x00000000 ~ 0x000fffff | BIOS/VRAM, and used in bootloading. After that will be empty (1MB) |
| 0x00007c00 ~ 0x00007dff | IPL                                                                |
| 0x00008200 ~ 0x00034fff | floppy disk content                                                |
| 0x00100000 ~ 0x00267fff | Store floppy disk content (1440KB)                                 |
| 0x00268000 ~ 0x0026f7ff | Empty (30KB)                                                       |
| 0x0026f800 ~ 0x0026ffff | IDT (2KB)                                                          |
| 0x00270000 ~ 0x0027ffff | GDT (64KB)                                                         |
| 0x00280000 ~ 0x002fffff | bootpack.hrb (512KB)                                               |
| 0x00300000 ~ 0x003fffff | Stack and others (1MB)                                             |
| 0x00400000 ~            | Empty                                                              |

memcpy in asmhead.nas:

| Source                           | Destination         |
| -------------------------------- | ------------------- |
| 0x7c00 ~ 0x7dff (512B)           | 0x100000 ~ 0x1001ff |
| 0x8200 ~ 0x83ff (512B)           | 0x100200 ~ 0x1003ff |
| bootpack.hrb (512B)              | 0x280000 ~ 0x2801ff |
| bootpack.hrb .data SIZEOF(.data) | 0x310000 ~          |
