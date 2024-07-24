# 修改点

## unrecognized instructions

```sh
; [INSTRSET "i486p"]				; 486の命令まで使いたいという記述
```

```sh
; [FORMAT "WCOFF"]				; オブジェクトファイルを作るモード
; [INSTRSET "i486p"]				; 486の命令まで使いたいという記述
[BITS 32]						; 32ビットモード用の機械語を作らせる
; [FILE "naskfunc.nas"]			; ソースファイル名情報
```

```sh
; [FILE "a_nask.nas"]				;
```

ipl\*.nas:

```sh
RESB	0x7dfe-$
```

to

```sh
RESB	0x7dfe-0x7c00-($-$$)
```

## 13_day harib10c ~ 14_day harib11e

运行起来显示很卡。规避方法是在 count++语句下加一行: sprintf(s, "%010d", count); 如此可取得与书中描述一致的效果。

```sh
	for (;;) {
		count++;
```

to

```sh
	for (;;) {
		count++;
		sprintf(s, "%010d", count);
```

## 14_day harib11d

Blank screen. In the book it uses 0xe0000000 as the VRAM address. Inserted a code block to fetch and set the VRAM to make it work.

```sh
		MOV		DWORD [VRAM],0xe0000000
```

to

```sh
		;MOV		DWORD [VRAM],0xe0000000
		;MOV		DWORD [VRAM],0x000a0000

; Query VBE Mode Info
		MOV		AX,0x9000
		MOV		ES,AX
		MOV		DI,0
		MOV		AX,0x4f00       ; VBE Get Mode Info
		INT		0x10

		MOV		CX,0x101
		MOV		AX,0x4f01
		INT		0x10

; Store VRAM address
		MOV		EAX,[ES:DI+0x28] ; Get linear framebuffer address
		MOV		[VRAM],EAX
```

## 20_day harib17b/c/d

Due to the different develop environment and tools, the function addresses are different.
In the bootpack.map the

```sh
                0x00000ca4                _asm_cons_putchar
```

so changed the hlt.nas:

```sh
;		CALL    2*8:0xbe3
		CALL    2*8:0xca4
```

## 30_day harib27e/f

在 Linux 上查看 img 文件是 0x430a0,需要 15 个柱面，因为没有使用 tek 压缩。将 9 改为 15（此值因开发环境不同可能有差异）

```sh
CYLS	EQU		9
```

to

```sh
CYLS	EQU		15
```
