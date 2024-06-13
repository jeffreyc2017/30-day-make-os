# Compiler and linker options for x86 32-bit CPU
ifndef GCCPREFIX
# GCCPREFIX := x86_64-linux-gnu-
# GCCPREFIX := i686-linux-gnu-
GCCPREFIX :=
endif

CC = $(GCCPREFIX)gcc
AS = $(GCCPREFIX)as
NASM = nasm
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

# LDFLAGS = -m elf_i386 -Ttext 0x1000 -z noexecstack
LDFLAGS = -m elf_i386
DEL = rm -f

IMG = haribote.img

# Default action
all: $(IMG)

# File generation rules

ipl10.bin: ipl10.nas
	$(NASM) -f bin -o ipl10.bin ipl10.nas -l ipl10.lst

# asmhead.bin: asmhead.nas
# 	$(NASM) -f bin -o asmhead.bin asmhead.nas -l asmhead.lst

# naskfunc.obj: naskfunc.nas
#	$(NASM) -f elf32 -o naskfunc.obj naskfunc.nas -l naskfunc.lst

# bootpack.elf: bootpack.c naskfunc.obj
# 	# # Compile bootpack.c to object file with Intel assembly syntax
# 	# $(CC) $(CFLAGS) -c bootpack.c -o bootpack.o

# 	# Compile bootpack.c to assembly with Intel syntax
# 	$(CC) $(CFLAGS) -S bootpack.c -o bootpack.s

# 	# Compile the assembly code to an object file
# 	$(CC) $(CFLAGS) -c bootpack.s -o bootpack.o

# 	# Link the object files to create the final executable
# 	$(LD) $(LDFLAGS) -e _HariMain -o bootpack.elf bootpack.o naskfunc.obj

# bootpack.bin: bootpack.elf
# 	$(OBJCOPY) -S -O binary bootpack.elf bootpack.bin

# check: bootpack.o bootpack.elf
# 	$(OBJDUMP) -x bootpack.o | grep table_rgb
# 	$(OBJDUMP) -x bootpack.elf | grep table_rgb
# 	$(OBJDUMP) -s -j .data bootpack.elf

# haribote.sys: asmhead.elf bootpack.bin
# 	cat $^ > $@

asmhead.elf: asmhead.nas
	$(NASM) -f elf32 -o $@ $< -l asmhead.lst

naskfunc.bin: naskfunc.nas
	$(NASM) -f elf32 $< -o $@ -l naskfunc.lst

bootpack.bin: bootpack.c
	$(CC) $(CFLAGS) -c $< -o $@

haribote.sys: asmhead.elf bootpack.bin naskfunc.bin
	$(LD) -m elf_i386 --oformat binary $^ -o $@ -T haribote.ld

$(IMG): ipl10.bin haribote.sys
	# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=$(IMG) bs=512 count=2880

	# Format the image as FAT12
	mkfs.fat -F 12 $(IMG)

	# Write the boot sector
	dd if=ipl10.bin of=$(IMG) bs=512 count=1 conv=notrunc

	mkdir -p ./floppy
	sudo mount -o loop $(IMG) ./floppy -o fat=12
	sudo cp haribote.sys ./floppy
	sudo umount ./floppy
	-$(DEL) -r ./floppy

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
