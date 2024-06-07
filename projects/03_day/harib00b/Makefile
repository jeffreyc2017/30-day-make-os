DEL      = rm -f

# Default action
all: haribote.img

# Build boot sector binary
ipl.bin: ipl.nas
	nasm -f bin -o ipl.bin ipl.nas

# Create disk image and write the boot sector
haribote.img: ipl.bin
	# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=haribote.img bs=512 count=2880
	# Write the boot sector
	dd if=ipl.bin of=haribote.img bs=512 count=1 conv=notrunc

# Run the image with QEMU
run: haribote.img
	qemu-system-x86_64 -drive file=haribote.img,format=raw,if=floppy

# Clean build artifacts
clean:
	-$(DEL) ipl.bin

# Clean disk image
src_only: clean
	-$(DEL) haribote.img