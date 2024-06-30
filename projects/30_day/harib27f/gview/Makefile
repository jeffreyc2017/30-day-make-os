APP      = gview
STACK    = 4480k
MALLOC   = 0k

TOOLPATH =
INCPATH  = ../../z_tools/haribote/
APILIBPATH   = ../apilib/
HARIBOTEPATH = ../haribote/

UTILS_FOLDER := ../../../../utils
include $(UTILS_FOLDER)/platform_config.mk

MAKE     = make
NASM     = nasm
CC       = $(GCCPREFIX)gcc
LD       = $(GCCPREFIX)ld
MAKEFONT = $(TOOLPATH)makefont.exe
COPY     = cp
DEL      = rm -f

APP_CFLAGS 	= -Wall -Wno-format -Wno-unused -std=gnu99 -fno-pie -m32 -fleading-underscore -fno-stack-protector -nostdinc -nostdlib -I../
APP_LDFLAGS = -m elf_i386 --oformat binary -e _HariMain

LIBC_DIR := $(UTILS_FOLDER)/libc

APP_CFLAGS += -I $(LIBC_DIR)/include

# デフォルト動作

default :
	$(MAKE) $(APP).hrb

# ファイル生成規則

$(APP).bim : $(APP).obj bmp.obj jpeg.obj $(APILIBPATH)apilib.lib
	$(LD) $(APP_LDFLAGS) --oformat binary $^ -o $@ -T ../app.lds

haribote.img : ../haribote/ipl20.bin ../haribote/haribote.sys $(APP).hrb \
		Makefile
# Create an empty 1.44MB floppy image
	dd if=/dev/zero of=$@ bs=512 count=2880

	# Format the image as FAT12
	# This command causes the file starts from 0x4400. Use makfs.msdos instead.
	# mkfs.fat -F 12 $@
	mkfs.msdos -F 12 $@

	# Write the boot sector
	dd if=../haribote/ipl20.bin of=$@ bs=512 count=1 conv=notrunc

	mcopy -i $@ ../haribote/haribote.sys ::/
	mcopy -i $@ $(APP).hrb ::/
	mcopy -i $@ ../nihongo/nihongo.fnt ::/

# 一般規則

%.obj: %.c
	$(CC) $(APP_CFLAGS) -c $< -o $@
vpath %.c $(LIBC_DIR)/src

%.obj : %.nas Makefile
	$(NASM) $(NASM_FLAGS) -f elf32 -o $@ $< -l $*.lst

%.org : %.bim Makefile
	mv $*.bim $*.org

%.hrb : %.org Makefile
	$(COPY) $*.org $*.hrb

# コマンド

run :
	$(MAKE) haribote.img
	qemu-system-i386 $(QEMU_FLAGS) -m 32 -vga std -drive \
	file=$<,format=raw,if=floppy,index=0,media=disk

full :
	$(MAKE) -C $(APILIBPATH)
	$(MAKE) $(APP).hrb

run_full :
	$(MAKE) -C $(APILIBPATH)
	$(MAKE) -C ../haribote
	$(MAKE) run

clean :
	-$(DEL) *.lst
	-$(DEL) gview.obj
	-$(DEL) jpeg.obj
	-$(DEL) *.map
	-$(DEL) *.bim
	-$(DEL) *.org
	-$(DEL) haribote.img

src_only :
	$(MAKE) clean
	-$(DEL) $(APP).hrb
