OBJS_BOOTPACK = bootpack.obj naskfunc.obj hankaku.obj graphic.obj dsctbl.obj \
		int.obj fifo.obj keyboard.obj mouse.obj memory.obj sheet.obj timer.obj \
		mtask.obj window.obj console.obj file.obj
OBJS_BOOTPACK +=  stdio.obj strcmp.obj strncmp.obj

OBJS_API =	api001.obj api002.obj api003.obj api004.obj api005.obj api006.obj \
			api007.obj api008.obj api009.obj api010.obj api011.obj api012.obj \
			api013.obj api014.obj api015.obj api016.obj api017.obj api018.obj \
			api019.obj api020.obj

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

MAKE = make
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
	@echo $(UNAME)
	@echo $(RASPBERRY_PI)
	@echo $(RPI)
	@echo $(IS_RASPBERRY_PI)

# t@CśŹKĽ

haribote.img: haribote/ipl10.bin haribote/haribote.sys \
		a/a.hrb hello3/hello3.hrb hello4/hello4.hrb hello5/hello5.hrb \
		winhelo/winhelo.hrb winhelo2/winhelo2.hrb winhelo3/winhelo3.hrb \
		star1/star1.hrb stars/stars.hrb stars2/stars2.hrb \
		lines/lines.hrb walk/walk.hrb noodle/noodle.hrb \
		beepdown/beepdown.hrb color/color.hrb color2/color2.hrb \
		sosu/sosu.hrb sosu2/sosu2.hrb sosu3/sosu3.hrb
	# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=$@ bs=512 count=2880

	# Format the image as FAT12
	# This command causes the file starts from 0x4400. Use makfs.msdos instead.
	# mkfs.fat -F 12 $@
	mkfs.msdos -F 12 $@

	# Write the boot sector
	dd if=haribote/ipl10.bin of=$@ bs=512 count=1 conv=notrunc

	# copy to 0x4200
	mcopy -i $@ haribote/haribote.sys ::/
	mcopy -i $@ haribote/ipl10.nas ::/
	mcopy -i $@ Makefile ::/
	mcopy -i $@ a/a.hrb ::/
	mcopy -i $@ hello3/hello3.hrb ::/
	mcopy -i $@ hello4/hello4.hrb ::/
	mcopy -i $@ hello5/hello5.hrb ::/
	mcopy -i $@ winhelo/winhelo.hrb ::/
	mcopy -i $@ winhelo2/winhelo2.hrb ::/
	mcopy -i $@ winhelo3/winhelo3.hrb ::/
	mcopy -i $@ star1/star1.hrb ::/
	mcopy -i $@ stars/stars.hrb ::/
	mcopy -i $@ stars2/stars2.hrb ::/
	mcopy -i $@ lines/lines.hrb ::/
	mcopy -i $@ walk/walk.hrb ::/
	mcopy -i $@ noodle/noodle.hrb ::/
	mcopy -i $@ beepdown/beepdown.hrb ::/
	mcopy -i $@ color/color.hrb ::/
	mcopy -i $@ color2/color2.hrb ::/
	mcopy -i $@ sosu/sosu.hrb ::/
	mcopy -i $@ sosu2/sosu2.hrb ::/
	mcopy -i $@ sosu3/sosu3.hrb ::/

# R}h

img: haribote.img

run: src_only img
	qemu-system-i386 $(QEMU_FLAGS) -m 32 -vga std -drive \
	file=$(IMG),format=raw,if=floppy,index=0,media=disk

full:
	$(MAKE) -C haribote
	$(MAKE) -C apilib
	$(MAKE) -C a
	$(MAKE) -C hello3
	$(MAKE) -C hello4
	$(MAKE) -C hello5
	$(MAKE) -C winhelo
	$(MAKE) -C winhelo2
	$(MAKE) -C winhelo3
	$(MAKE) -C star1
	$(MAKE) -C stars
	$(MAKE) -C stars2
	$(MAKE) -C lines
	$(MAKE) -C walk
	$(MAKE) -C noodle
	$(MAKE) -C beepdown
	$(MAKE) -C color
	$(MAKE) -C color2
	$(MAKE) -C sosu
	$(MAKE) -C sosu2
	$(MAKE) -C sosu3
	$(MAKE) haribote.img

run_full: full run

run_os: haribote.img run

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

clean_full:
	$(MAKE) -C haribote	clean
	$(MAKE) -C apilib		clean
	$(MAKE) -C a			clean
	$(MAKE) -C hello3		clean
	$(MAKE) -C hello4		clean
	$(MAKE) -C hello5		clean
	$(MAKE) -C winhelo		clean
	$(MAKE) -C winhelo2	clean
	$(MAKE) -C winhelo3	clean
	$(MAKE) -C star1		clean
	$(MAKE) -C stars		clean
	$(MAKE) -C stars2		clean
	$(MAKE) -C lines		clean
	$(MAKE) -C walk		clean
	$(MAKE) -C noodle		clean
	$(MAKE) -C beepdown	clean
	$(MAKE) -C color		clean
	$(MAKE) -C color2		clean
	$(MAKE) -C sosu		clean
	$(MAKE) -C sosu2		clean
	$(MAKE) -C sosu3		clean

src_only_full :
	$(MAKE) -C haribote	src_only
	$(MAKE) -C apilib		src_only
	$(MAKE) -C a			src_only
	$(MAKE) -C hello3		src_only
	$(MAKE) -C hello4		src_only
	$(MAKE) -C hello5		src_only
	$(MAKE) -C winhelo		src_only
	$(MAKE) -C winhelo2	src_only
	$(MAKE) -C winhelo3	src_only
	$(MAKE) -C star1		src_only
	$(MAKE) -C stars		src_only
	$(MAKE) -C stars2		src_only
	$(MAKE) -C lines		src_only
	$(MAKE) -C walk		src_only
	$(MAKE) -C noodle		src_only
	$(MAKE) -C beepdown	src_only
	$(MAKE) -C color		src_only
	$(MAKE) -C color2		src_only
	$(MAKE) -C sosu		src_only
	$(MAKE) -C sosu2		src_only
	$(MAKE) -C sosu3		src_only
	-$(DEL) haribote.img

refresh: full clean_full
	-$(DEL) haribote.img

.PHONY: all run clean src_only
