# Compiler and linker options for x86 32-bit CPU

IS_RASPBERRY_PI := $(if $(RPI),1,0)
UNAME := $(shell uname -a)
RASPBERRY_PI := $(findstring raspberrypi,$(UNAME))

ifeq ($(RASPBERRY_PI),raspberrypi)
	IS_RASPBERRY_PI := 1
else
	IS_RASPBERRY_PI := 0
endif

# Default GCCPREFIX for x86 PC
GCCPREFIX :=

# Set GCCPREFIX for Raspberry Pi
ifeq ($(IS_RASPBERRY_PI),1)
	GCCPREFIX := i686-linux-gnu-
endif

NASM = nasm
CC = $(GCCPREFIX)gcc
AS = $(GCCPREFIX)as
LD = $(GCCPREFIX)ld
OBJCOPY = $(GCCPREFIX)objcopy
CFLAGS = -fleading-underscore \
		 -ffreestanding \
		 -fno-stack-protector \
		 -nostdlib \
		 -nostdinc \
		 -nostartfiles \
		 -Wall \
		 -fno-pie \
		 -m32 \
		 -mtune=i486 -march=i486 \
		 -masm=intel

LDFLAGS = -m elf_i386
DEL = rm -f

IMG = haribote.img

# Default action
all: haribote.img

# File generation rules

ipl10.bin: ipl10.nas
	$(NASM) -f bin -o $@ $< -l $*.lst

asmhead.bin: asmhead.nas
	$(NASM) -f bin -o $@ $< -l $*.lst

naskfunc.obj: naskfunc.nas
	$(NASM) -f elf32 -o $@ $< -l naskfunc.lst

bootpack.hrb: bootpack.obj naskfunc.obj
	$(LD) $(LDFLAGS) --oformat binary -o $@ -T app.lds $^

haribote.sys: asmhead.bin bootpack.hrb
	cat asmhead.bin > $@
	cat bootpack.hrb >> $@
haribote.img: ipl10.bin haribote.sys
	# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=$@ bs=512 count=2880

	# Format the image as FAT12
	# This command causes the file starts from 0x4400. Use makfs.msdos instead.
	# mkfs.fat -F 12 $@
	mkfs.msdos -F 12 $@

	# Write the boot sector
	dd if=ipl10.bin of=$@ bs=512 count=1 conv=notrunc

	mcopy -i $@ haribote.sys ::/
	
%.obj: %.c
	$(CC) $(CFLAGS) -c $< -o $@

img: haribote.img

run: img
	qemu-system-i386 -drive file=$(IMG),format=raw,if=floppy

clean:
	-$(DEL) *.bin
	-$(DEL) *.lst
	-$(DEL) *.elf
	-$(DEL) *.o
	-$(DEL) *.obj
	-$(DEL) bootpack.s
	-$(DEL) haribote.sys

src_only: clean
	-$(DEL) $(IMG)
