# Hrb file format

From 22.5

    0x0000 (DWORD) ......请求操作系统为应用程序准备的数据段的大小
    0x0004 (DWORD) ......"Hari"（.hrb 文件的标记）
    0x0008 (DWORD) ......数据段内预备空间的大小
    0x000c (DWORD) ......ESP 初始值&数据部分传送目的地址
    0x0010 (DWORD) ......hrb 文件內数据部分的大小
    0×0014 (DWORD) ......hrb 文件内数据部分从哪里开始
    0x0018 (DWORD) ......Oxe9000000
    0x001c (DWORD) ......应用程序运行入口地址 - 0x20
    0x0020 (DWORD) ......malloc 空间的起始地址

Intel recommends aligning code and branch targets on 16-byte boundaries:

> 3.4.1.5 - Assembly/Compiler Coding Rule 12. (M impact, H generality)
> All branch targets should be 16-byte aligned.

For example the hello4.hrb

```sh
$ hexdump hello4.hrb
0000000 0400 0000 6148 6972 0000 0000 0000 0031
0000010 000e 0000 0071 0000 0000 e900 0010 0000
0000020 0000 0000 0000 0000 0000 0000 0000 0000
0000030 8955 83e5 08ec ec83 680c 0000 0031 19e8
0000040 0000 8300 10c4 1fe8 0000 9000 c3c9 9066
0000050 01ba 0000 8a00 2444 cd04 c340 ba53 0002
0000060 0000 5c8b 0824 40cd c35b 04ba 0000 cd00
0000070 6840 6c65 6f6c 202c 6f77 6c72 0a64 0000
000007f
```

• 0x0000: 0400 0000 - Size of the data segment requested by the OS (4 bytes)
• 0x0004: 6148 6972 - Signature “Hari” (4 bytes, hexadecimal 0x69726148)
• 0x0008: 0000 0000 - Size of the pre-allocated space in the data segment (4 bytes)
• 0x000c: 0000 0031 - Initial value of ESP & transfer destination address (4 bytes)
• 0x0010: 000e 0000 - Size of the data segment in the .hrb file (4 bytes)
• 0x0014: 0071 0000 - Starting point of the data segment in the .hrb file (4 bytes)
• 0x0018: e900 0010 - Constant 0xe9000000 (4 bytes)
• 0x001c: 0000 0000 - Entry address of the application - 0x20 (4 bytes), value is 0x00000010
• 0x0020: 0000 0000 - Starting address of the malloc space (4 bytes)

The .text segment starts from 0x30 which is aligned to 16-bytes boundary.
So the offset is calculated as below:

0x30 - 0x20 (which is the next position after the 0x001c DWORD field)

```sh
E9 cw	JMP rel16	Jump near, relative, displacement relative to next instruction.
```

> A relative offset (rel8, rel16, or rel32) is generally specified as a label in assembly code, but at the machine code level, it is encoded as a signed 8-, 16-, or 32-bit immediate value. This value is added to the value in the EIP register. (Here, the EIP register contains the address of the instruction following the JMP instruction). When using relative offsets, the opcode (for short vs.
near jumps) and the operand-size attribute (for near relative jumps) determines the size of the target operand (8, 16, or 32 bits).

<https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-2a-manual.pdf#page590>
<https://pdos.csail.mit.edu/6.828/2004/readings/i386/JMP.htm>
