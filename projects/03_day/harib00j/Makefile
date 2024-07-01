UTILS_FOLDER := ../../../utils
include $(UTILS_FOLDER)/platform_config.mk

NASM = nasm
CC = $(GCCPREFIX)gcc
AS = $(GCCPREFIX)as
LD = $(GCCPREFIX)ld
CFLAGS = -ffreestanding -nostdlib -nostartfiles
LDFLAGS = -Ttext 0x1000
DEL      = rm -f

# Default action
all: haribote.img

# ÉtÉ@ÉCÉãê∂ê¨ãKë•

ipl10.bin : ipl10.nas
	$(NASM) -f bin -o ipl10.bin ipl10.nas

asmhead.bin : asmhead.nas
	$(NASM) -f bin -o asmhead.bin asmhead.nas

bootpack.bin : bootpack.c
	# $(CC) $(CFLAGS) -c $< -o bootpack.o
	# $(AS) start.s -o start.o
	# $(LD) $(LDFLAGS) start.o bootpack.o -o $@

	$(CC) $(CFLAGS) -c $< -o bootpack.bin

naskfunc.obj : naskfunc.nas
	$(NASM) -f bin -o naskfunc.obj naskfunc.nas

haribote.sys : asmhead.bin bootpack.bin naskfunc.obj
	cat $^ > $@

haribote.img : ipl10.bin haribote.sys
	# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=$@ bs=512 count=2880

	# Format the image as FAT12
	# mkfs.msdos -F 12 $@

	# Write the boot sector
	dd if=ipl10.bin of=$@ bs=512 count=1 conv=notrunc

	mcopy -i $@ haribote.sys ::/

run :haribote.img
	qemu-system-x86_64 -drive file=haribote.img,format=raw,if=floppy

clean :
	-$(DEL) *.bin
	-$(DEL) *.elf
	-$(DEL) *.o
	-$(DEL) *.obj
	-$(DEL) haribote.sys

src_only : clean
	-$(DEL) haribote.img
