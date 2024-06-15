# 30dayMakeOS on Raspberry Pi

## conditions

此项目在 RaspberryPi 5 上运行。

1. 尽量保持原代码文件不做变更，仅做必要的修改以使编译通过；
2. 主要的修改在于 Makefile；
3. 原代码的目标机器是 32 位 x86 CPU;
4. 原代码使用 NASM(Netwide Assembler) syntax;

## -fleading-underscore

旧版本的 GCC（GNU Compiler Collection）在编译时，为了兼容某些老库，会在符号名前自动添加一个下划线。然而，新版本的 GCC 已经不再默认添加这个下划线。但是，如果需要，可以通过编译选项重新开启这个功能。

要在新版本的 GCC 中启用这个功能，可以使用`-fleading-underscore`编译选项。例如：

```bash
gcc -fleading-underscore -o outputfile sourcefile.c
```

这样，在编译过程中，GCC 会自动在符号名前添加下划线，从而实现与旧库的兼容。

```sh
$ uname -a
Linux raspberrypi 6.6.31+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.31-1+rpt1 (2024-05-29) aarch64 GNU/Linux
```

由于原作是在 Windows 上运行，为避免不可预知的错误，首先对所有文件进行了转换：

```sh
find . -type f -print0 | xargs -0 dos2unix
```

用到的工具：

- nasm
- qemu

[osdev](https://wiki.osdev.org/Main_Page)

[DISK - READ SECTOR(S) INTO MEMORY](http://www.ctyme.com/intr/rb-0607.htm)

## ASM

You can find explanations of all assembly instructions in several resources:

1. **Intel and AMD Official Documentation**:

   - **Intel® 64 and IA-32 Architectures Software Developer’s Manuals**: These manuals cover all Intel assembly instructions in detail.
     - Available at: [Intel Developer Manuals](https://software.intel.com/en-us/articles/intel-sdm)
   - **AMD64 Architecture Programmer’s Manual**: Covers AMD-specific assembly instructions.
     - Available at: [AMD Developer Manuals](https://developer.amd.com/resources/developer-guides-manuals/)

2. **Websites and Online References**:

   - **The x86 Instruction Set Reference**: A comprehensive online reference for x86 instructions.
     - Available at: [x86 Assembly Language Reference Manual](https://www.felixcloutier.com/x86/)
   - **Wikipedia**: Provides explanations for many common assembly instructions and general information about the x86 and x86-64 instruction sets.
     - Available at: [Wikipedia x86 Instruction Listings](https://en.wikipedia.org/wiki/X86_instruction_listings)

3. **Books**:

   - **"Programming from the Ground Up" by Jonathan Bartlett**: A beginner-friendly book that explains assembly language programming.
   - **"The Art of Assembly Language" by Randall Hyde**: A detailed book that covers assembly language programming extensively.
   - **"Computer Systems: A Programmer's Perspective" by Randal E. Bryant and David R. O'Hallaron**: Includes a chapter on assembly language.

4. **Online Courses and Tutorials**:
   - **Coursera, Udemy, and edX**: Offer courses on computer architecture and assembly language programming.
   - **TutorialsPoint and GeeksforGeeks**: Provide tutorials and explanations on various assembly language instructions.

## BIOS

BIOS instructions and documentation can be found in several specialized resources:

1. **Manufacturer Documentation**:

   - **Intel® BIOS Programmer’s Reference**: Detailed guides for Intel BIOS development and programming.
     - Available at: [Intel BIOS and Firmware Documentation](https://www.intel.com/content/www/us/en/embedded/embedded-bios-overview.html)
   - **AMD BIOS and Kernel Developer’s Guide**: Information specific to AMD processors.
     - Available at: [AMD Developer Guides](https://developer.amd.com/resources/developer-guides-manuals/)

2. **BIOS Development Kits and SDKs**:

   - **UEFI Specifications**: The Unified Extensible Firmware Interface (UEFI) replaces the traditional BIOS in many systems. The UEFI specifications and related documents are essential for modern firmware development.
     - Available at: [UEFI Forum Specifications](https://uefi.org/specifications)
   - **Coreboot**: An open-source project aimed at replacing proprietary BIOS firmware. The documentation includes guides and instructions for building and developing BIOS.
     - Available at: [Coreboot Documentation](https://doc.coreboot.org/)

3. **Books**:

   - **"BIOS Disassembly Ninjutsu Uncovered" by Darmawan Salihun**: A detailed book on BIOS internals and reverse engineering.
   - **"Beyond BIOS: Developing with the Unified Extensible Firmware Interface" by Vincent Zimmer, Michael Rothman, and Suresh Marisetty**: Focuses on UEFI, the modern successor to traditional BIOS.

4. **Online Communities and Forums**:

   - **Tianocore EDK II**: An open-source implementation of the UEFI specification, with extensive documentation and community support.
     - Available at: [Tianocore GitHub](https://github.com/tianocore/tianocore.github.io/wiki)
   - **OSDev Wiki**: Provides various tutorials and information on BIOS and bootloading.
     - Available at: [OSDev Wiki BIOS](https://wiki.osdev.org/BIOS)

5. **Educational Resources and Tutorials**:
   - **BIOS and UEFI Programming Tutorials**: Online tutorials and courses that cover BIOS and UEFI programming, often available on platforms like YouTube, Coursera, and Udemy.

These resources will provide you with a comprehensive understanding of BIOS programming and instructions, from legacy BIOS to modern UEFI firmware.

To find explanations for the ASM `int` instructions used in BIOS calls, you can refer to the following resources:

1. **Ralf Brown's Interrupt List**: This is one of the most comprehensive and detailed lists of interrupt calls and their functionalities. It includes information on various BIOS interrupts (such as `int 10h` for video services, `int 13h` for disk services, etc.). You can access it [here](http://www.ctyme.com/rbrown.htm).

2. **PCGPE (PC Games Programmer's Encyclopedia)**: This resource provides detailed explanations of BIOS interrupts and other low-level programming topics. It is particularly useful for learning about older DOS-based BIOS calls.

3. **OSDev Wiki**: The OSDev Wiki has a section on BIOS interrupts, explaining various services and their usage. You can visit it [here](https://wiki.osdev.org/BIOS).

4. **Books and Manuals**:
   - _"The Art of Assembly Language Programming"_ by Randall Hyde
   - _"PC Intern: System Programming"_
   - _"The Undocumented PC"_ by Frank van Gilluwe

These books contain detailed explanations and examples of using BIOS interrupts.

5. **Online Forums and Communities**: Websites like Stack Overflow and Reddit have communities where you can ask questions and find discussions about BIOS interrupts and assembly programming.

6. **Official Documentation**: Although more general, Intel and AMD's official documentation might provide insights into processor interrupts and instructions which can be helpful when dealing with BIOS calls.

These resources should provide you with detailed information and explanations of ASM `int` instructions and BIOS calls.

## FAT12

A 1.44 MB floppy disk typically uses the FAT12 file system. FAT12 is specifically designed for smaller storage media, such as floppy disks, and can handle the limited number of sectors and small file sizes associated with them.

In some cases, writing directly to the image may suffice, especially if the filesystem structure is simple and does not require additional metadata or directory structures.

## Cross-compiler

[nasm](https://nasm.us)
[MinGW-w64](https://www.mingw-w64.org/)

## 04_day

存器在 C 语言编译后生成的机器语言中，用于记忆非常重要的值。因此这次我们只用 EAX 和 BCX。
这次还给 naskfunc.nas 增加了一行，那就是 INSTRSET 指令。它是用来告诉 nask“这个程序是给 486 用的哦”，nask 见了这一行之后就知道“哦，那见了 EAX 这个词，就解释成寄存器名”。如果什么都不指定，它就会认为那是为 8086 这种非常古老的、而且只有 16 位寄存器的 CPU 而写的程序，见了 EAX 这个词，会误解成标签（Label），或是常数。8086 那时候写的程序中，曾偶尔使用 EAX 来做标签，当时也没想到这个单词后来会成为寄存器名而不能再随便使用。
上面虽然写着 486 用，但并不是说会出现仅能在 486 中执行的机器语言，这只是单纯的词语解释的问题。所以 486 用的模式下，如果只使用 16 位寄存器，也能成为在 8086 中亦可执行的机器语言。
“纸娃娃操作系统”也支持 386，所以虽然这里指定的是 486，但并不是 386 中就不能用。可能会有人同，这里的 386，486 都是什么意思啊？我们来简单介绍一下电脑的 CPU（英特尔系列）家谱。
8086-+80186 286-386-486->Pentium→PentiumProPentiumlI→PentiumIII-Pentium4-\*...
从上面的家谱来看，386 已经是非常古老的 CPU 了。到 286 为止 CPU 是 16 位，而 386 以后 CPU 是 32 位。
现在，汇编这部分已经准备好了，下面来修改 C 语言吧。这次我们导人了变量。

> [!IMPORTANT]
> 此书面向 32 位 CPU
> The Raspberry Pi 5 uses a 64-bit 2.4 GHz quad-core ARM Cortex-A76 processor.

| 处理器型号        | 位数          |
| ----------------- | ------------- |
| Intel 8086        | 16 位         |
| Intel 8088        | 16 位         |
| Intel 80186       | 16 位         |
| Intel 80286       | 16 位         |
| Intel 80386       | 32 位         |
| Intel 80486       | 32 位         |
| Intel Pentium     | 32 位         |
| Intel Pentium Pro | 32 位         |
| Intel Pentium II  | 32 位         |
| Intel Pentium III | 32 位         |
| Intel Pentium 4   | 32 位或 64 位 |
| Intel Atom        | 32 位         |
| Intel Core 2 系列 | 64 位         |
| Intel Core i 系列 | 64 位         |
| Intel Xeon        | 32 位或 64 位 |
| AMD K5            | 32 位         |
| AMD K6            | 32 位         |
| AMD Athlon XP     | 32 位         |
| AMD Athlon        | 32 位或 64 位 |
| AMD Duron         | 32 位         |
| AMD Sempron       | 32 位         |
| AMD Opteron       | 64 位         |
| AMD Phenom        | 64 位         |
| AMD FX            | 64 位         |
| AMD Ryzen         | 64 位         |
| VIA C3            | 32 位         |
| VIA Nano          | 64 位         |

## References

- [Original book website](http://hrb.osask.jp)

- https://github.com/ghosind/HariboteOS

- [Intel 386 and AMD x86-64 Options](https://gcc.gnu.org/onlinedocs/gcc-4.7.2/gcc/i386-and-x86_002d64-Options.html)

## 修改点

### 0xc200

```sh
		JMP		0xc200
```

to

```sh
		JMP		0xc400
```

### entry point

```sh
		ORG		0xc400			; このプログラムがどこに読み込まれるのか
```

to

```sh
;		ORG		0xc400			; このプログラムがどこに読み込まれるのか

[SECTION .text]
[BITS 16]
entry:
```

### bootpack 启动

```sh
; bootpackの起動

		MOV		EBX,BOTPAK
		MOV		ECX,[EBX+16]
		ADD		ECX,3			; ECX += 3;
		SHR		ECX,2			; ECX /= 4;
		JZ		skip			; 転送するべきものがない
		MOV		ESI,[EBX+20]	; 転送元
		ADD		ESI,EBX
		MOV		EDI,[EBX+12]	; 転送先
;		CALL	memcpy
skip:
;		MOV		ESP,[EBX+12]	; スタック初期値
;		JMP		DWORD 2*8:0x0000001b
		MOV   ESP, 0xffff
		JMP   DWORD 2*8:0x00000000
```

### unrecognized instructions

```sh
; [INSTRSET "i486p"]				; 486の命令まで使いたいという記述
```

```sh
; [FORMAT "WCOFF"]				; オブジェクトファイルを作るモード
; [INSTRSET "i486p"]				; 486の命令まで使いたいという記述
[BITS 32]						; 32ビットモード用の機械語を作らせる
; [FILE "naskfunc.nas"]			; ソースファイル名情報
```

## 各章简要

| day    | section  | description                                                             |
| ------ | -------- | ----------------------------------------------------------------------- |
| 01 day | 1        |                                                                         |
| 02 day | 1        |                                                                         |
| 03 day | 1        |                                                                         |
| 04 day | 1        |                                                                         |
| 05 day | 1        | 保存内存中的启动信息，不用看                                            |
|        | 2        | 增加结构体定义，有 C 语言基础可以不用看                                 |
|        | 3        | 改为指针访问，有 C 语言基础可以不用看                                   |
|        | 4        | 显示字符，本质上是写 VRAM                                               |
|        | 5        | 增加 ASCII 字符集，在 UTILS 下编写了一个 makefont 工具                  |
|        | 6        | 显示字符串，5 基础上的扩展                                              |
|        | 7        | sprintf，增加 C 语言实现。暂未能像书中使用标准头文件和库\*              |
|        | 8        | 显示鼠标箭头，本质是写 VRAM                                             |
|        | 9\*      | GDT 与 IDT                                                              |
| 06 day | harib03a | 分割源文件。不用重点看。遗留问题：bootpack.obj 必须放在第二个链接位置\* |
|        | harib03b |                                                                         |
|        | harib03c |                                                                         |
|        | harib03d |                                                                         |
|        | harib03e |                                                                         |
| 07 day | harib04a |                                                                         |
|        | harib04b |                                                                         |
|        | harib04c |                                                                         |
|        | harib04d |                                                                         |
|        | harib04e |                                                                         |
|        | harib04f |                                                                         |
|        | harib04g |                                                                         |
| 08 day | harib05  |                                                                         |
|        | harib05  |                                                                         |
| 09 day | harib06  |                                                                         |
|        | harib06  |                                                                         |
| 10 day | harib07  |                                                                         |
|        | harib07  |                                                                         |
| 11 day | harib08  |                                                                         |
|        | harib08  |                                                                         |
| 12 day | harib09  |                                                                         |
|        | harib09  |                                                                         |
| 13 day | harib1   |                                                                         |
|        | harib1   |                                                                         |
| 14 day | harib1   |                                                                         |
|        | harib1   |                                                                         |
| 15 day | harib1   |                                                                         |
|        | harib1   |                                                                         |
| 16 day | harib1   |                                                                         |
|        | harib1   |                                                                         |
| 17 day | harib1   |                                                                         |
|        | harib1   |                                                                         |
| 18 day | harib1   |                                                                         |
|        | harib1   |                                                                         |
| 19 day | harib1   |                                                                         |
|        | harib1   |                                                                         |
| 20 day | harib1   |                                                                         |
|        | harib1   |                                                                         |
| 21 day | harib1   |                                                                         |
|        | harib1   |                                                                         |
| 22 day | harib1   |                                                                         |
|        | harib1   |                                                                         |
| 23 day | harib2   |                                                                         |
|        | harib2   |                                                                         |
| 24 day | harib2   |                                                                         |
|        | harib2   |                                                                         |
| 25 day | harib2   |                                                                         |
|        | harib2   |                                                                         |
| 26 day | harib2   |                                                                         |
|        | harib2   |                                                                         |
| 27 day | harib2   |                                                                         |
|        | harib2   |                                                                         |
| 28 day | harib2   |                                                                         |
|        | harib2   |                                                                         |
| 29 day | harib2   |                                                                         |
|        | harib2   |                                                                         |
| 30 day | harib27  |                                                                         |
|        | harib27  |                                                                         |
