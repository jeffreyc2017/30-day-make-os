DEL      = rm -f

# Default action
all: haribote.img

# Build boot sector binary
ipl10.bin: ipl10.nas
	nasm -f bin -o ipl10.bin ipl10.nas


haribote.sys : haribote.nas
	nasm -f bin -o haribote.sys haribote.nas


# Create disk image and write the boot sector
haribote.img: ipl10.bin haribote.sys
	# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=$@ bs=512 count=2880

	# Format the image as FAT12
	mformat -f 1440 -i $@ ::

	# Write the boot sector
	dd if=ipl10.bin of=$@ bs=512 count=1 conv=notrunc

	mcopy -i $@ haribote.sys ::/

# Run the image with QEMU
run: haribote.img
	qemu-system-x86_64 -drive file=$<,format=raw,if=floppy

# Clean build artifacts
clean :
	-$(DEL) ipl10.bin
	-$(DEL) haribote.sys

# Clean disk image
src_only: clean
	-$(DEL) haribote.img
