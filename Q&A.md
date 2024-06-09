### Q&A on x86 Assembly Instructions

**Q: Why is the following code used in x86 assembly? Why can't we use `MOV ES, 0x0820` directly?**

```asm
MOV AX, 0x0820
MOV ES, AX
```

**A:** In x86 assembly language, the instruction `MOV ES, 0x0820` is not valid because the `MOV` instruction does not support moving an immediate value directly into a segment register. Segment registers such as `ES`, `CS`, `SS`, `DS`, `FS`, and `GS` can only be loaded from a general-purpose register or memory.

Here's why you see the code written in two steps:

1. **MOV AX, 0x0820**: This instruction moves the immediate value `0x0820` into the general-purpose register `AX`.
2. **MOV ES, AX**: This instruction then moves the value in `AX` into the segment register `ES`.

The sequence ensures that the segment register `ES` is loaded correctly. Segment registers require intermediate steps because they are not directly addressable by immediate values in the `MOV` instruction.

This is a restriction of the x86 architecture. To move an immediate value into a segment register, you must first load the value into a general-purpose register, and then transfer it to the segment register.

## what’s the difference between

`nasm -f bin -o asmhead.bin asmhead.nas`
and
`nasm -f elf -o asmhead.bin asmhead.nas`

The difference between these two commands lies in the output format specified by the `-f` option in the NASM (Netwide Assembler) command.

1. **nasm -f bin -o asmhead.bin asmhead.nas**

   - **`-f bin`**: This tells NASM to generate a flat binary file. A flat binary file is a raw sequence of bytes with no headers or metadata. It's typically used for very low-level programming, such as boot loaders or direct hardware manipulation, where you need to control the exact bytes that are written to a specific location.
   - **Output file**: `asmhead.bin` will be a flat binary file, which means it's suitable for environments where you need to load the code directly into memory and execute it, such as a boot sector or embedded system.

2. **nasm -f elf -o asmhead.bin asmhead.nas**

   - **`-f elf`**: This tells NASM to generate an Executable and Linkable Format (ELF) file. ELF is a common file format for executables, object code, shared libraries, and core dumps in Unix-like operating systems. It includes metadata like sections, symbols, and headers, which are used by linkers and loaders.
   - **Output file**: `asmhead.bin` will be an ELF object file, which can be linked with other object files and libraries to create a complete executable. This is useful for developing software that runs in user space on operating systems like Linux.

### Key Differences

- **Binary Format (`-f bin`)**:

  - Produces a raw binary file.
  - No headers or metadata, just raw machine code.
  - Suitable for boot loaders, direct hardware programming, or other low-level code.
  - Can be directly executed by a system or loaded into memory by a bootloader.

- **ELF Format (`-f elf`)**:
  - Produces an ELF object file.
  - Contains headers, metadata, and sections.
  - Suitable for linking with other object files.
  - Used by operating systems like Linux for executables and shared libraries.
  - Requires a linker to produce an executable file.

In summary, use `-f bin` when you need a raw binary output for low-level tasks, and use `-f elf` when you are developing software that needs to be linked and run in a Unix-like operating system environment.

## Create a floppy disk image

The command you provided:

```bash
dd if=/dev/zero of=haribote.img bs=512 count=2880
```

creates a blank floppy disk image by writing zeros to it. Let's break down the command:

- `if=/dev/zero`: Input file is `/dev/zero`, which is a special file in Unix-like systems that provides as many null characters (zeros) as are read from it.
- `of=haribote.img`: Output file is `haribote.img`, the name of the disk image being created.
- `bs=512`: Block size is 512 bytes, which is the standard size of a sector on a floppy disk.
- `count=2880`: The number of blocks (sectors) to write, 2880 sectors corresponds to a standard 1.44MB floppy disk (512 bytes/sector \* 2880 sectors = 1,474,560 bytes or 1.44MB).

### Effects of This Command

Executing this command will create a 1.44MB disk image filled entirely with zeros. This means:

1. **Blank Disk Image**: The resulting `haribote.img` will be a completely blank disk with no file system, no bootloader, and no data.

2. **No File System**: There will be no FAT (File Allocation Table) or root directory, as these structures need to be created by formatting the disk image with a file system such as FAT12.

### Next Steps for Creating a Bootable FAT12 Disk Image

To make this disk image functional (e.g., as a bootable floppy with a FAT12 file system and a bootloader), you need to follow additional steps:

1. **Format the Disk Image with FAT12**:

   ```bash
   mkfs.vfat -F 12 haribote.img
   ```

2. **Write the Bootloader**:
   Assuming you have a bootloader binary called `bootloader.bin`:

   ```bash
   dd if=bootloader.bin of=haribote.img bs=512 count=1 conv=notrunc
   ```

   This command writes your bootloader to the first sector of the disk image without truncating the image, ensuring the rest of the file system remains intact.

3. **Mount the Image and Add Files** (optional):
   If you want to add files to the FAT12 file system, you can mount the image using a loop device:
   ```bash
   sudo mount -o loop haribote.img /mnt
   sudo cp yourfile.txt /mnt
   sudo umount /mnt
   ```

### Conclusion

The initial `dd` command will not by itself break the FAT or root directory, as it creates a blank disk image with no file system at all. However, after creating the image, you must format it with a FAT12 file system and then write the bootloader to the first sector to make it a bootable FAT12 disk image. Following these steps ensures that the FAT and root directory are correctly established and not inadvertently broken.

## 1st sector of FAT12

The first sector of a FAT12 disk is not unused; it is reserved for the boot sector, which contains important information about the disk and its file system. Here’s a detailed breakdown of the role and contents of the first sector in a FAT12 disk:

### First Sector (Boot Sector)

1. **Boot Sector**: The first sector (sector 0) of a FAT12 disk is the boot sector. It serves several critical functions:
   - **Boot Code**: If the disk is bootable, this sector contains the bootloader code that is executed by the BIOS when the system boots from the disk.
   - **BIOS Parameter Block (BPB)**: This structure provides important details about the disk layout, such as the number of bytes per sector, sectors per cluster, number of reserved sectors, number of FAT copies, maximum number of root directory entries, total number of sectors, media descriptor, and other file system-specific parameters.

### Typical Layout of a FAT12 Disk

1. **Boot Sector**: Contains the boot code and BPB (sector 0).
2. **Reserved Sectors**: Usually just one sector (the boot sector itself), but sometimes more.
3. **FAT Region**: Contains the File Allocation Table(s), which manage the allocation of clusters on the disk.
4. **Root Directory Region**: A fixed-size area that contains the root directory entries.
5. **Data Region**: Contains the actual file and directory data, managed in clusters.

### Example Boot Sector Structure

A typical boot sector structure for a FAT12 disk might look like this:

- **Jump Instruction** (3 bytes): Tells the CPU to skip to the boot code.
- **OEM Name** (8 bytes): Identifies the disk format.
- **BIOS Parameter Block (BPB)** (25 bytes): Contains disk layout information.
- **Extended BPB** (26 bytes): Additional parameters (optional).
- **Boot Code**: The machine code to be executed on boot (usually up to 448 bytes in a 512-byte sector).
- **Boot Signature** (2 bytes): A signature value (0x55, 0xAA) indicating a valid boot sector.

### Writing a Bootloader Without Disrupting FAT12

When writing a bootloader to a FAT12 disk, it is crucial to ensure that the FAT12 structures remain intact. Here’s a corrected approach:

1. **Create a Blank Disk Image**:

   ```bash
   dd if=/dev/zero of=haribote.img bs=512 count=2880
   ```

2. **Format the Disk Image with FAT12**:

   ```bash
   mkfs.vfat -F 12 haribote.img
   ```

3. **Write the Bootloader to the Boot Sector**:
   Assuming your bootloader is `bootloader.bin`:
   ```bash
   dd if=bootloader.bin of=haribote.img bs=512 count=1 conv=notrunc
   ```
   Ensure that `bootloader.bin` includes both the necessary boot code and the BPB.

By following these steps, you ensure that the first sector (boot sector) is properly formatted and includes both the bootloader and the necessary FAT12 disk layout information, preserving the integrity of the FAT12 file system.

## The start address of haribote.img is 0x4400 instead of 0x4200

03 day section 5 mentioned.

Tools used to check the haribote.img to confirm the haribote.sys location:

```sh
hexedit haribote.img
xxd haribote.img | less
sudo apt install sleuthkit
mmls haribote.img
fsstat haribote.img
xxd -s 0x004400 -l 512 haribote.img
xxd -s 0x004200 -l 512 haribote.img
fls haribote.img
icat haribote.img 4
istat haribote.img 4
```
