# BIOS

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
