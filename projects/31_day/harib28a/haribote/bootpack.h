#ifndef _BOOTPACK_H
#define _BOOTPACK_H

#include "asmhead.h"
#include "naskfunc.h"
#include "fifo.h"
#include "graphic.h"
#include "dsctbl.h"
#include "int.h"
#include "keyboard.h"
#include "mouse.h"
#include "memory.h"
#include "sheet.h"
#include "timer.h"
#include "mtask.h"
#include "window.h"
#include "console.h"
#include "file.h"
#include "tek.h"

/* bootpack.c */
struct TASK *open_constask(struct SHEET *sht, unsigned int memtotal);
struct SHEET *open_console(struct SHTCTL *shtctl, unsigned int memtotal);

#endif
