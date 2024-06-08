此项目在 RaspberryPi 5 上运行。

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
