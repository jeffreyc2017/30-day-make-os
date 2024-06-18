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
NASM_FLAGS :=

ifdef DEBUG
QEMU_FLAGS += -s -S
QEMU_FLAGS += -monitor stdio
CFLAGS += -g
NASM_FLAGS += -F dwarf -g
endif

LDFLAGS = -m elf_i386
DEL = rm -f

IMG = haribote.img

UTILS_FOLDER := ../../../utils
MAKEFONT := $(UTILS_FOLDER)/makefont
CFLAGS += -I$(UTILS_FOLDER)

LIBC_DIR := $(UTILS_FOLDER)/libc
CFLAGS += -I $(LIBC_DIR)/include

all: target-os $(IMG)

target-os:
	@echo "Running on Raspberry Pi? $(IS_RASPBERRY_PI)"
	@echo "GCCPREFIX: $(GCCPREFIX)"
	@echo $(UNAME)
	@echo $(RASPBERRY_PI)
	@echo $(RPI)
	@echo $(IS_RASPBERRY_PI)

ipl10.bin: ipl10.nas
	$(NASM) -f bin -o $@ $< -l ipl10.lst

naskfunc.elf: naskfunc.nas
	$(NASM) $(NASM_FLAGS) -f elf32 -o $@ $< -l naskfunc.lst

hankaku.asm: hankaku.txt
	# Use the native gcc to build the tool on local machine.
	gcc -o $(MAKEFONT) $(UTILS_FOLDER)/makefont.c
	$(MAKEFONT) -i $< -o $@ -f 1

hankaku.elf: hankaku.asm
	$(NASM) $(NASM_FLAGS) -f elf32 -o $@ $< -l hankaku.lst

OBJ_FILES := bootpack.obj stdio.obj dsctbl.obj graphic.obj int.obj

%.obj: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# debug.obj: $(UTILS_FOLDER)/debug.c
# 	$(CC) $(CFLAGS) -c $< -o $@

stdio.obj: $(LIBC_DIR)/stdio/stdio.c
	$(CC) $(CFLAGS) -c $< -o $@

asmhead.bin: asmhead.nas
	$(NASM) $(NASM_FLAGS) -f bin -o $@ $< -l asmhead.lst

kernel.sys: $(OBJ_FILES) naskfunc.elf hankaku.elf
	$(LD) $(LDFLAGS) --oformat binary -o kernel.sys -T kernel.ld $^

haribote.sys: asmhead.bin kernel.sys
	cat asmhead.bin > haribote.sys
	cat kernel.sys >> haribote.sys

$(IMG): ipl10.bin haribote.sys
	# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=$(IMG) bs=512 count=2880

	# Format the image as FAT12
	mkfs.fat -F 12 $(IMG)

	# Write the boot sector
	dd if=ipl10.bin of=$(IMG) bs=512 count=1 conv=notrunc

	dd if=haribote.sys of=$(IMG) seek=33 bs=512 conv=notrunc

	# mkdir -p ./floppy
	# sudo mount -o loop $(IMG) ./floppy -o fat=12
	# sudo cp haribote.sys ./floppy
	# sudo umount ./floppy
	# -$(DEL) -r ./floppy

run: src_only $(IMG)
	qemu-system-i386 $(QEMU_FLAGS) -m 32 -vga std -drive \
	file=$(IMG),format=raw,if=floppy,index=0,media=disk

clean:
	-$(DEL) *.bin
	-$(DEL) *.lst
	-$(DEL) *.elf
	-$(DEL) *.o
	-$(DEL) *.obj
	-$(DEL) bootpack.s
	-$(DEL) haribote.sys
	-$(DEL) hankaku.asm

src_only: clean
	-$(DEL) $(IMG)

.PHONY: all run clean src_only
