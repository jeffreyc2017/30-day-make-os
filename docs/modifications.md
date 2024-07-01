## 修改点

### 0xc200

```sh
		JMP		0xc200
```

to

```sh
		JMP		0xc400
```

### entry point

```sh
		ORG		0xc400			; このプログラムがどこに読み込まれるのか
```

to

```sh
;		ORG		0xc400			; このプログラムがどこに読み込まれるのか

[SECTION .text]
[BITS 16]
entry:
```

### bootpack 启动

```sh
; bootpackの起動

		MOV		EBX,BOTPAK
		MOV		ECX,[EBX+16]
		ADD		ECX,3			; ECX += 3;
		SHR		ECX,2			; ECX /= 4;
		JZ		skip			; 転送するべきものがない
		MOV		ESI,[EBX+20]	; 転送元
		ADD		ESI,EBX
		MOV		EDI,[EBX+12]	; 転送先
;		CALL	memcpy
skip:
		MOV		ESP,[EBX+12]	; スタック初期値
		JMP		DWORD 2*8:0x0000001b
```

### unrecognized instructions

```sh
; [INSTRSET "i486p"]				; 486の命令まで使いたいという記述
```

```sh
; [FORMAT "WCOFF"]				; オブジェクトファイルを作るモード
; [INSTRSET "i486p"]				; 486の命令まで使いたいという記述
[BITS 32]						; 32ビットモード用の機械語を作らせる
; [FILE "naskfunc.nas"]			; ソースファイル名情報
```

### unrecognized instructions(2)

```sh
; [FILE "a_nask.nas"]				;
```

### 30_day

In 27d,e,f renamed bmp.nasm to bmp.nas so it can be found by the Makefile and compiled.
