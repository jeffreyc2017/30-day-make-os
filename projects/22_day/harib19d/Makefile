OBJS_BOOTPACK = bootpack.obj naskfunc.obj hankaku.obj graphic.obj dsctbl.obj \
		int.obj fifo.obj keyboard.obj mouse.obj memory.obj sheet.obj timer.obj \
		mtask.obj window.obj console.obj file.obj
OBJS_BOOTPACK +=  stdio.obj string.obj

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

APP_CFLAGS 	= -Wall -Wno-format -Wno-unused -std=gnu99 -fno-pie -m32 -fleading-underscore -fno-stack-protector
APP_LDFLAGS = -m elf_i386 --oformat binary -e HariMain

QEMU_FLAGS :=
NASM_FLAGS :=

ifdef DEBUG
# QEMU_FLAGS += -s -S
# QEMU_FLAGS += -monitor stdio
QEMU_FLAGS += -d in_asm
CFLAGS += -g
NASM_FLAGS += -g
endif

LDFLAGS = -m elf_i386
DEL = rm -f

IMG = haribote.img

UTILS_FOLDER := ../../../utils
MAKEFONT := $(UTILS_FOLDER)/makefont
CFLAGS += -I$(UTILS_FOLDER)

LIBC_DIR := $(UTILS_FOLDER)/libc
CFLAGS += -I $(LIBC_DIR)/include

# ftHgŽě

all: target-os $(IMG)

target-os:
	@echo "Running on Raspberry Pi? $(IS_RASPBERRY_PI)"
	@echo "GCCPREFIX: $(GCCPREFIX)"
	@echo "UNAME: $(UNAME)"
	@echo $(RASPBERRY_PI)
	@echo $(RPI)
	@echo $(IS_RASPBERRY_PI)

# t@CśŹKĽ

ipl10.bin: ipl10.nas
	$(NASM) $(NASM_FLAGS) -f bin -o $@ $< -l ipl10.lst

asmhead.bin: asmhead.nas
	$(NASM) $(NASM_FLAGS) -f bin -o $@ $< -l asmhead.lst

hankaku.asm: hankaku.txt
	# Use the native gcc to build the tool on local machine.
	gcc -o $(MAKEFONT) $(UTILS_FOLDER)/makefont.c
	$(MAKEFONT) -i $< -o $@ -f 1

hankaku.obj: hankaku.asm
	$(NASM) $(NASM_FLAGS) -f elf32 -o $@ $< -l hankaku.lst

bootpack.hrb: $(OBJS_BOOTPACK)
	$(LD) $(LDFLAGS) --oformat binary -o $@ -T bootpack.lds $^

haribote.sys: asmhead.bin bootpack.hrb
	cat asmhead.bin > haribote.sys
	cat bootpack.hrb >> haribote.sys

hello.hrb: hello.nas
	$(NASM) $(NASM_FLAGS) -f bin -o $@ $< -l hello.lst

hello2.hrb: hello2.nas
	$(NASM) $(NASM_FLAGS) -f bin -o $@ $< -l hello2.lst

a_nask.obj: a_nask.nas
	$(AS) -f elf $< -o $@

a.hrb: a_nask.obj a.c
	$(CC) $(APP_CFLAGS) -c a.c -o a.obj
	$(LD) $(APP_LDFLAGS) --oformat binary a.obj a_nask.obj -o $@

hello3.hrb: a_nask.obj hello3.c
	$(CC) $(APP_CFLAGS) -c hello3.c -o hello3.obj
	$(LD) $(APP_LDFLAGS) --oformat binary hello3.obj a_nask.obj -o $@

hello4.hrb: a_nask.obj hello4.c
	$(CC) $(APP_CFLAGS) -c hello4.c -o hello4.obj
	$(LD) $(APP_LDFLAGS) --oformat binary hello4.obj a_nask.obj -o $@

bug1.hrb: a_nask.obj bug1.c
	$(CC) $(APP_CFLAGS) -c bug1.c -o bug1.obj
	$(LD) $(APP_LDFLAGS) --oformat binary bug1.obj a_nask.obj -o $@

bug2.hrb: bug2.c
	$(CC) $(APP_CFLAGS) -c bug2.c -o bug2.obj
	$(LD) $(APP_LDFLAGS) --oformat binary bug2.obj -o $@

bug3.hrb: a_nask.obj bug3.c
	$(CC) $(APP_CFLAGS) -c bug3.c -o bug3.obj
	$(LD) $(APP_LDFLAGS) --oformat binary bug3.obj a_nask.obj -o $@

haribote.img: ipl10.bin haribote.sys \
		hello.hrb hello2.hrb a.hrb hello3.hrb bug1.hrb bug2.hrb bug3.hrb \
		hello4.hrb
	# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=$@ bs=512 count=2880

	# Format the image as FAT12
	# This command causes the file starts from 0x4400. Use makfs.msdos instead.
	# mkfs.fat -F 12 $@
	# mkfs.msdos -F 12 $@

	# Write the boot sector
	dd if=ipl10.bin of=$@ bs=512 count=1 conv=notrunc

	# copy to 0x4200
	mcopy -i $@ haribote.sys ::/
	mcopy -i $@ ipl10.nas ::/
	mcopy -i $@ Makefile ::/
	mcopy -i $@ hello.hrb ::/
	mcopy -i $@ hello2.hrb ::/
	mcopy -i $@ a.hrb ::/
	mcopy -i $@ hello3.hrb ::/
	mcopy -i $@ bug1.hrb ::/
	mcopy -i $@ bug2.hrb ::/
	mcopy -i $@ bug3.hrb ::/
	mcopy -i $@ hello4.hrb ::/

# ęĘKĽ

naskfunc.obj: naskfunc.nas
	$(NASM) $(NASM_FLAGS) -f elf32 -o $@ $< -l naskfunc.lst

a_nask.obj: a_nask.nas
	$(NASM) $(NASM_FLAGS) -f elf32 -o $@ $< -l a_nask.lst

%.obj: %.c
	$(CC) $(CFLAGS) -c $< -o $@
vpath %.c $(LIBC_DIR)/src

# R}h

img: haribote.img

run: src_only img
	qemu-system-i386 $(QEMU_FLAGS) -m 32 -vga std -drive \
	file=$(IMG),format=raw,if=floppy,index=0,media=disk

clean:
	-$(DEL) *.bin
	-$(DEL) *.lst
	-$(DEL) *.elf
	-$(DEL) *.o
	-$(DEL) *.obj
	-$(DEL) *.hrb
	-$(DEL) bootpack.s
	-$(DEL) haribote.sys
	-$(DEL) hankaku.asm
	-$(DEL) kernel.sys

src_only: clean
	-$(DEL) $(IMG)

.PHONY: all run clean src_only
