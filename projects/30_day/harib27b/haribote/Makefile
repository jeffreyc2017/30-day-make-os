OBJS_BOOTPACK = bootpack.obj naskfunc.obj hankaku.obj graphic.obj dsctbl.obj \
		int.obj fifo.obj keyboard.obj mouse.obj memory.obj sheet.obj timer.obj \
		mtask.obj window.obj console.obj file.obj tek.obj
OBJS_BOOTPACK +=  stdio.obj string.obj setjmp.obj

UTILS_FOLDER := ../../../../utils
include $(UTILS_FOLDER)/platform_config.mk

HRB_LDS := $(UTILS_FOLDER)/linker_script/hrb.lds

MAKE = make
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

UTILS_FOLDER := ../../../../utils
MAKEFONT := $(UTILS_FOLDER)/makefont
CFLAGS += -I$(UTILS_FOLDER)

LIBC_DIR := $(UTILS_FOLDER)/libc
CFLAGS += -I $(LIBC_DIR)/include

APP_CFLAGS += -I $(LIBC_DIR)/include

# デフォルト動作

default : ipl20.bin haribote.sys

# ファイル生成規則

ipl20.bin: ipl20.nas
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
	$(LD) $(LDFLAGS) --oformat binary -o $@ --defsym=STACK_SIZE=3136*1024 -T $(HRB_LDS) $^ -Map $(basename $@).map

haribote.sys: asmhead.bin bootpack.hrb
	cat asmhead.bin > $@
	cat bootpack.hrb >> $@

# 一般規則

%.obj: %.nas
	$(NASM) $(NASM_FLAGS) -f elf32 -o $@ $< -l $*.lst

%.obj: %.c
	$(CC) $(CFLAGS) -c $< -o $@

vpath %.c $(LIBC_DIR)/src

%.obj: %.S
	$(CC) $(CFLAGS) -c $< -o $@

vpath %.S $(LIBC_DIR)/src

# コマンド

clean :
	-$(DEL) asmhead.bin
	-$(DEL) hankaku.bin
	-$(DEL) *.lst
	-$(DEL) *.obj
	-$(DEL) *.map
	-$(DEL) *.bim
	-$(DEL) *.hrb

src_only : clean
	-$(DEL) ipl20.bin
	-$(DEL) haribote.sys
