# Compiler and linker options
CC = aarch64-linux-gnu-gcc
# AS = aarch64-linux-gnu-as
AS = nasm
LD = aarch64-linux-gnu-ld
CFLAGS = -ffreestanding -nostdlib -nostartfiles -Wall -fno-pie
LDFLAGS = -Ttext 0x1000
DEL      = rm -f

# Default action
all: haribote.img

# ÉtÉ@ÉCÉãê∂ê¨ãKë•

ipl10.bin : ipl10.nas
	$(AS) -f bin -o ipl10.bin ipl10.nas -l ipl10.lst

asmhead.bin : asmhead.nas
	$(AS) -f elf -o asmhead.bin asmhead.nas -l asmhead.lst

bootpack.bin : bootpack.c
	# $(CC) $(CFLAGS) -c $< -o bootpack.o
	# $(AS) start.s -o start.o
	# $(LD) $(LDFLAGS) start.o bootpack.o -o $@

	$(CC) $(CFLAGS) -c $< -o bootpack.bin

naskfunc.obj : naskfunc.nas
	$(AS) -f elf -o naskfunc.obj naskfunc.nas -l naskfunc.lst

haribote.sys : asmhead.bin bootpack.bin naskfunc.obj
	# cat $^ > $@
	# $(LD) -m aarch64elf --oformat binary asmhead.bin bootpack.bin naskfunc.obj -o haribote.sys -T haribote.ld
	aarch64-linux-gnu-ld -r -b binary -o temp.o asmhead.bin bootpack.bin naskfunc.obj
	aarch64-linux-gnu-objcopy -O binary temp.o haribote.sys

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
	-$(DEL) *.lst
	-$(DEL) *.elf
	-$(DEL) *.o
	-$(DEL) *.obj
	-$(DEL) haribote.sys

src_only : clean
	-$(DEL) haribote.img
