OBJS_API =	api001.obj api002.obj api003.obj api004.obj api005.obj api006.obj \
			api007.obj api008.obj api009.obj api010.obj api011.obj api012.obj \
			api013.obj api014.obj api015.obj api016.obj api017.obj api018.obj \
			api019.obj api020.obj api021.obj api022.obj api023.obj api024.obj \
			api025.obj api026.obj api027.obj alloca.obj

UTILS_FOLDER := ../../../../utils
include $(UTILS_FOLDER)/platform_config.mk

NASM = nasm
CC = $(GCCPREFIX)gcc
AS = $(GCCPREFIX)as
LD = $(GCCPREFIX)ld
AR = $(GCCPREFIX)AR
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

MAKEFONT := $(UTILS_FOLDER)/makefont
CFLAGS += -I$(UTILS_FOLDER)

LIBC_DIR := $(UTILS_FOLDER)/libc
CFLAGS += -I $(LIBC_DIR)/include

APP_CFLAGS += -I $(LIBC_DIR)/include

# デフォルト動作

default: apilib.lib

# ファイル生成規則

apilib.lib: $(OBJS_API)
	$(AR) rcs $@ $^

# 一般規則

%.obj: %.nas
	$(NASM) $(NASM_FLAGS) -f elf32 -o $@ $< -l $*.lst

# コマンド

clean :
	-$(DEL) *.lst
	-$(DEL) *.obj

src_only : clean
	-$(DEL) apilib.lib
