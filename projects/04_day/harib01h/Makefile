UTILS_FOLDER := ../../../utils
include $(UTILS_FOLDER)/platform_config.mk

NASM = nasm
CC = $(GCCPREFIX)gcc
AS = $(GCCPREFIX)as
LD = $(GCCPREFIX)ld
OBJCOPY = $(GCCPREFIX)objcopy
OBJDUMP = $(GCCPREFIX)objdump
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

QEMU_FLAGS :=

ifdef DEBUG
QEMU_FLAGS += -gdb tcp::1234 -S
CFLAGS += -g
endif

LDFLAGS = -m elf_i386
DEL = rm -f

IMG = haribote.img

all: $(IMG)

ipl10.bin: ipl10.nas
	$(NASM) -f bin -o $@ $< -l $(basename $@).lst

asmhead.bin: asmhead.nas
	$(NASM) -f bin -o $@ $< -l $(basename $@).lst

naskfunc.obj: naskfunc.nas
	$(NASM) -f elf32 -o $@ $< -l $(basename $@).lst

bootpack.hrb: bootpack.obj naskfunc.obj
	$(LD) $(LDFLAGS) --oformat binary -o $@ -T bootpack.lds $^

haribote.sys: asmhead.bin bootpack.hrb
	cat asmhead.bin > $@
	cat bootpack.hrb >> $@

haribote.img: ipl10.bin haribote.sys
	# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=$@ bs=512 count=2880

	# Format the image as FAT12
	mkfs.msdos -F 12 $@

	# Write the boot sector
	dd if=ipl10.bin of=$@ bs=512 count=1 conv=notrunc

	mcopy -i $@ haribote.sys ::/

%.obj: %.c
	$(CC) $(CFLAGS) -c $< -o $@

img: haribote.img

run: src_only img
	qemu-system-i386 $(QEMU_FLAGS) -m 32 -vga std -drive file=$(IMG),format=raw,if=floppy,index=0,media=disk

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

.phony: all run clean src_only
