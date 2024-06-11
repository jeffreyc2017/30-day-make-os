# Compiler and linker options for x86 32-bit CPU
ifndef GCCPREFIX
# GCCPREFIX := x86_64-linux-gnu-
GCCPREFIX := i686-linux-gnu-
endif

CC = $(GCCPREFIX)gcc
AS = $(GCCPREFIX)as
NASM = nasm
LD = $(GCCPREFIX)ld
OBJCOPY = $(GCCPREFIX)objcopy
CFLAGS = -fleading-underscore -ffreestanding -nostdlib -nostartfiles -Wall -fno-pie -m32 -mtune=i486 -march=i486
# LDFLAGS = -m elf_i386 -Ttext 0x1000 -z noexecstack
LDFLAGS = -m elf_i386
DEL = rm -f

# Default action
all: haribote.img

# File generation rules

ipl10.bin: ipl10.nas
	$(NASM) -f bin -o ipl10.bin ipl10.nas -l ipl10.lst

asmhead.bin: asmhead.nas
	$(NASM) -f bin -o asmhead.bin asmhead.nas -l asmhead.lst

naskfunc.obj: naskfunc.nas
	$(NASM) -f elf32 -o naskfunc.obj naskfunc.nas -l naskfunc.lst

bootpack.elf: bootpack.c naskfunc.obj
	# # Compile bootpack.c to object file with Intel assembly syntax
	# $(CC) $(CFLAGS) -c -masm=intel bootpack.c -o bootpack.o

	# Compile bootpack.c to assembly with Intel syntax
	$(CC) $(CFLAGS) -S -masm=intel bootpack.c -o bootpack.s

	# Compile the assembly code to an object file
	$(CC) $(CFLAGS) -c bootpack.s -o bootpack.o

	# Link the object files to create the final executable
	$(LD) $(LDFLAGS) -o bootpack.elf bootpack.o naskfunc.obj

bootpack.bin: bootpack.elf
	$(OBJCOPY) -O binary bootpack.elf bootpack.bin

haribote.sys: asmhead.bin bootpack.bin
	cat $^ > $@

haribote.img: ipl10.bin haribote.sys
	# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=haribote.img bs=512 count=2880

	# Format the image as FAT12
	mkfs.fat -F 12 haribote.img

	# Write the boot sector
	dd if=ipl10.bin of=haribote.img bs=512 count=1 conv=notrunc

	mkdir -p ./floppy
	sudo mount -o loop haribote.img ./floppy
	sudo cp haribote.sys ./floppy
	sudo umount ./floppy
	-$(DEL) -r ./floppy

run: haribote.img
	qemu-system-i386 -m 32 -vga std -drive file=haribote.img,format=raw,if=floppy

clean:
	-$(DEL) *.bin
	-$(DEL) *.lst
	-$(DEL) *.elf
	-$(DEL) *.o
	-$(DEL) *.obj
	-$(DEL) bootpack.s
	-$(DEL) haribote.sys

src_only: clean
	-$(DEL) haribote.img
