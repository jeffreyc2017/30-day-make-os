# Compiler and linker options
CC = aarch64-linux-gnu-gcc
AS = aarch64-linux-gnu-as
LD = aarch64-linux-gnu-ld
CFLAGS = -ffreestanding -nostdlib -nostartfiles
LDFLAGS = -Ttext 0x1000
DEL      = rm -f

# Default action
all: haribote.img

# ÉtÉ@ÉCÉãê∂ê¨ãKë•

ipl10.bin : ipl10.nas
	nasm -f bin -o ipl10.bin ipl10.nas

asmhead.bin : asmhead.nas
	nasm -f bin -o asmhead.bin asmhead.nas

bootpack.bin : bootpack.c
	$(CC) $(CFLAGS) -c $< -o bootpack.o
	# $(AS) start.s -o start.o
	# $(LD) $(LDFLAGS) start.o bootpack.o -o $@
	$(LD) $(LDFLAGS) bootpack.o -o $@

# 3MB+64KB=3136KB

haribote.sys : asmhead.bin bootpack.bin
	cat $^ > $@

haribote.img : ipl10.bin haribote.sys
	# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=haribote.img bs=512 count=2880

	# Format the image as FAT12
	mkfs.fat -F 12 haribote.img

	# Write the boot sector
	dd if=ipl10.bin of=haribote.img bs=512 count=1 conv=notrunc

	dd if=haribote.sys of=haribote.img seek=33 bs=512 conv=notrunc

	mkdir -p ./floppy
	sudo mount -o loop haribote.img ./floppy
	sudo cp haribote.sys ./floppy
	sudo umount ./floppy
	-$(DEL) -r ./floppy

run :haribote.img
	qemu-system-x86_64 -drive file=haribote.img,format=raw,if=floppy

clean :
	-$(DEL) *.bin
	-$(DEL) *.elf
	-$(DEL) *.o
	-$(DEL) haribote.sys

src_only : clean
	-$(DEL) haribote.img
