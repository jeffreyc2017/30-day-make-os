OBJS_BOOTPACK = bootpack.obj naskfunc.obj hankaku.obj graphic.obj dsctbl.obj \
		int.obj fifo.obj keyboard.obj mouse.obj memory.obj sheet.obj timer.obj \
		mtask.obj window.obj console.obj file.obj tek.obj
OBJS_BOOTPACK +=  stdio.obj strcmp.obj strncmp.obj

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
		 -masm=intel \
		 -xc

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
	$(NASM) $(NASM_FLAGS) -f bin -o $@ $< -l ipl20.lst

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

# 一般規則

%.obj: %.nas
	$(NASM) $(NASM_FLAGS) -f elf32 -o $@ $< -l $*.lst

%.obj: %.c
	$(CC) $(CFLAGS) -c $< -o $@

stdio.obj: $(LIBC_DIR)/stdio/stdio.c
	$(CC) $(CFLAGS) -c $< -o $@

strcmp.obj: $(LIBC_DIR)/string/strcmp.c
	$(CC) $(CFLAGS) -c $< -o $@

strncmp.obj: $(LIBC_DIR)/string/strncmp.c
	$(CC) $(CFLAGS) -c $< -o $@

rand.obj: $(LIBC_DIR)/stdlib/rand.c
	$(CC) $(CFLAGS) -c $< -o $@

setjmp.obj: $(LIBC_DIR)/setjmp/setjmp.c
	$(CC) $(CFLAGS) -c $< -o $@

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
