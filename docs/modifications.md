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

## 30_day

In 27d,e,f renamed bmp.nasm to bmp.nas so it can be found by the Makefile and compiled.
