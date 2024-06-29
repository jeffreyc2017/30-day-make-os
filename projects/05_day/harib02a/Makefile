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
	$(NASM) -f bin -o $@ $< -l ipl10.lst

naskfunc.elf: naskfunc.nas
	$(NASM) -f elf32 -o $@ $< -l naskfunc.lst

bootpack.o: bootpack.c
	# Compile bootpack.c to assembly with Intel syntax
	$(CC) $(CFLAGS) -S $< -o bootpack.s

	# Compile the assembly code to an object file
	$(CC) $(CFLAGS) -c bootpack.s -o $@

asmhead.bin: asmhead.nas
	$(NASM) -f bin -o $@ $< -l asmhead.lst

bootpack.hrb: bootpack.o naskfunc.elf
	$(LD) $(LDFLAGS) --oformat binary -o $@ -T bootpack.lds $^

haribote.sys: asmhead.bin bootpack.hrb
	cat asmhead.bin > $@
	cat bootpack.hrb >> $@

$(IMG): ipl10.bin haribote.sys
	# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=$@ bs=512 count=2880

	# Format the image as FAT12
	mkfs.msdos -F 12 $@

	# Write the boot sector
	dd if=ipl10.bin of=$@ bs=512 count=1 conv=notrunc

	mcopy -i $@ haribote.sys ::/

run: src_only $(IMG)
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

.PHONY: all run clean src_only RPI
