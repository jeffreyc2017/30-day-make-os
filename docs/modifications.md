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

## 13_day harib10c ~

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

## 30_day

In 27d,e,f renamed bmp.nasm to bmp.nas so it can be found by the Makefile and compiled.
