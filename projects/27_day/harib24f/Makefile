OBJS_BOOTPACK = bootpack.obj naskfunc.obj hankaku.obj graphic.obj dsctbl.obj \
		int.obj fifo.obj keyboard.obj mouse.obj memory.obj sheet.obj timer.obj \
		mtask.obj window.obj console.obj file.obj
OBJS_BOOTPACK += stdio.obj string.obj

OBJS_API =	api001.obj api002.obj api003.obj api004.obj api005.obj api006.obj \
			api007.obj api008.obj api009.obj api010.obj api011.obj api012.obj \
			api013.obj api014.obj api015.obj api016.obj api017.obj api018.obj \
			api019.obj api020.obj

UTILS_FOLDER := ../../../utils
include $(UTILS_FOLDER)/platform_config.mk

NASM = nasm
CC = $(GCCPREFIX)gcc
AS = $(GCCPREFIX)as
LD = $(GCCPREFIX)ld
AR = $(GCCPREFIX)ar
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

APP_CFLAGS 	= -Wall -Wno-format -Wno-unused -std=gnu99 -fno-pie -m32 -fleading-underscore -fno-stack-protector -nostdinc -nostdlib
APP_LDFLAGS = -m elf_i386 --oformat binary -e _HariMain

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

APP_CFLAGS += -I $(LIBC_DIR)/include

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
	$(NASM) $(NASM_FLAGS) -f bin -o $@ $< -l $(basename $@).lst

asmhead.bin: asmhead.nas
	$(NASM) $(NASM_FLAGS) -f bin -o $@ $< -l $(basename $@).lst

hankaku.asm: hankaku.txt
	# Use the native gcc to build the tool on local machine.
	gcc -o $(MAKEFONT) $(UTILS_FOLDER)/makefont.c
	$(MAKEFONT) -i $< -o $@ -f 1

hankaku.obj: hankaku.asm
	$(NASM) $(NASM_FLAGS) -f elf32 -o $@ $< -l $(basename $@).lst

bootpack.hrb: $(OBJS_BOOTPACK)
	$(LD) $(LDFLAGS) --oformat binary -o $@ -T bootpack.lds $^

haribote.sys: asmhead.bin bootpack.hrb
	cat asmhead.bin > $@
	cat bootpack.hrb >> $@

apilib.lib: $(OBJS_API)
	$(AR) rcs $@ $^

a.obj: a.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

a.hrb: a.obj apilib.lib
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

hello3.obj: hello3.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

hello3.hrb: hello3.obj apilib.lib
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

hello4.obj: hello4.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

hello4.hrb: hello4.obj apilib.lib
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

hello5.obj: hello5.nas
	$(NASM) $(NASM_FLAGS) -f elf32 -o hello5.obj $< -l hello5.lst

hello5.hrb: hello5.obj
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

winhelo.obj: winhelo.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

winhelo.hrb: winhelo.obj apilib.lib
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

winhelo2.obj: winhelo2.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

winhelo2.hrb: winhelo2.obj apilib.lib
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

winhelo3.obj: winhelo3.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

winhelo3.hrb: winhelo3.obj apilib.lib
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

star1.obj: star1.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

star1.hrb: star1.obj apilib.lib
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

stars.obj: stars.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

stars.hrb: stars.obj apilib.lib rand.obj
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

stars2.obj: stars2.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

stars2.hrb: stars2.obj apilib.lib rand.obj
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

lines.obj: lines.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

lines.hrb: lines.obj apilib.lib
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

walk.obj: walk.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

walk.hrb: walk.obj apilib.lib
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

noodle.obj: noodle.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

appstdio.obj: $(LIBC_DIR)/src/stdio.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

noodle.hrb: noodle.obj apilib.lib appstdio.obj
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

beepdown.obj: beepdown.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

beepdown.hrb: beepdown.obj apilib.lib
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

color.obj: color.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

color.hrb: color.obj apilib.lib
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

color2.obj: color2.c
	$(CC) $(APP_CFLAGS) -c $< -o $@

color2.hrb: color2.obj apilib.lib
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T app.lds

haribote.img: ipl10.bin haribote.sys \
		a.hrb hello3.hrb hello4.hrb hello5.hrb winhelo.hrb winhelo2.hrb \
		winhelo3.hrb star1.hrb stars.hrb stars2.hrb lines.hrb walk.hrb \
		noodle.hrb beepdown.hrb color.hrb color2.hrb
	# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=$@ bs=512 count=2880

	# Format the image as FAT12
	# This command causes the file starts from 0x4400. Use makfs.msdos instead.
	# mkfs.fat -F 12 $@
	mformat -f 1440 -i $@ ::

	# Write the boot sector
	dd if=ipl10.bin of=$@ bs=512 count=1 conv=notrunc

	# copy to 0x4200
	mcopy -i $@ haribote.sys ::/
	mcopy -i $@ ipl10.nas ::/
	mcopy -i $@ Makefile ::/
	mcopy -i $@ a.hrb ::/
	mcopy -i $@ hello3.hrb ::/
	mcopy -i $@ hello4.hrb ::/
	mcopy -i $@ hello5.hrb ::/
	mcopy -i $@ winhelo.hrb ::/
	mcopy -i $@ winhelo2.hrb ::/
	mcopy -i $@ winhelo3.hrb ::/
	mcopy -i $@ star1.hrb ::/
	mcopy -i $@ stars.hrb ::/
	mcopy -i $@ stars2.hrb ::/
	mcopy -i $@ lines.hrb ::/
	mcopy -i $@ walk.hrb ::/
	mcopy -i $@ noodle.hrb ::/
	mcopy -i $@ beepdown.hrb ::/
	mcopy -i $@ color.hrb ::/
	mcopy -i $@ color2.hrb ::/

# ęĘKĽ

%.obj: %.nas
	$(NASM) $(NASM_FLAGS) -f elf32 -o $@ $< -l $*.lst

%.obj: %.c
	$(CC) $(CFLAGS) -c $< -o $@
vpath %.c $(LIBC_DIR)/src

# R}h

img: haribote.img

run: img
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
