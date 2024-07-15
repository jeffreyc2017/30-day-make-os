/*
From 22 day section 5

0x0000 (DWORD) ......Size of the data segment requested by the operating system for the application
0x0004 (DWORD) ......"Hari" (signature of the .hrb file)
0x0008 (DWORD) ......Size of the pre-allocated space in the data segment
0x000c (DWORD) ......Initial value of ESP & transfer destination address of the data segment
0x0010 (DWORD) ......Size of the data segment in the .hrb file
0x0014 (DWORD) ......Starting point of the data segment in the .hrb file
0x0018 (DWORD) ......0xe9000000
0x001c (DWORD) ......Entry address of the application - 0x20
0x0020 (DWORD) ......Starting address of the malloc space
*/

OUTPUT_FORMAT("binary");

/* Define parameters with default values */
STACK_SIZE = DEFINED(STACK_SIZE) ? STACK_SIZE : 64 * 1024;
SIGNATURE = 0x69726148; /* 'H' = 0x48, 'a' = 0x61, 'r' = 0x72, 'i' = 0x69 */
MMAREA_SIZE = 0;
STACK_INIT = DEFINED(STACK_INIT) ? STACK_INIT : 0x310000;
DATA_SIZE = SIZEOF(.data);
DATA_INIT_ADDR = LOADADDR(.data);
CONSTANT_0xE9000000 = 0xE9000000;
ENTRY_ADDR_OFFSET = _HariMain - 0x20;
HEAP_START_ADDR = DEFINED(HEAP_START_ADDR) ? HEAP_START_ADDR : 0;

SECTIONS
{
    .head 0x0 : {
        LONG(STACK_SIZE)
        LONG(SIGNATURE)
        LONG(MMAREA_SIZE)
        LONG(STACK_INIT)
        LONG(DATA_SIZE)
        LONG(DATA_INIT_ADDR)
        LONG(CONSTANT_0xE9000000)
        LONG(ENTRY_ADDR_OFFSET)
        LONG(HEAP_START_ADDR)
    }

    .text : { *(.text) }

    .data STACK_INIT : AT ( ADDR(.text) + SIZEOF(.text) ) {
        *(.data)
        *(.rodata*)
        *(.bss)
    }

    /DISCARD/ : { *(.eh_frame) }
}