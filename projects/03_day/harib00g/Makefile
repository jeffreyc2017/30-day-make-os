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

# Run the image with QEMU
run: haribote.img
	qemu-system-x86_64 -drive file=haribote.img,format=raw,if=floppy

# Clean build artifacts
clean :
	-$(DEL) ipl10.bin
	-$(DEL) haribote.sys

# Clean disk image
src_only: clean
	-$(DEL) haribote.img
