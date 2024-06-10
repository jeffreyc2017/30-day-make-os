; haribote-os boot asm
; TAB=4

BOTPAK	EQU		0x00280000		; Destination for bootpack loading
DSKCAC	EQU		0x00100000		; Location of disk cache
DSKCAC0	EQU		0x00008000		; Location of disk cache (real mode)

; BOOT_INFO related
CYLS	EQU		0x0ff0			; Set by the boot sector
LEDS	EQU		0x0ff1
VMODE	EQU		0x0ff2			; Information about color depth
SCRNX	EQU		0x0ff4			; X resolution
SCRNY	EQU		0x0ff6			; Y resolution
VRAM	EQU		0x0ff8			; Start address of graphic buffer

		ORG		0xc400			; Where this program is loaded

; Set the screen mode

		MOV		AL,0x13			; VGA graphics, 320x200x8-bit color
		MOV		AH,0x00
		INT		0x10
		MOV		BYTE [VMODE],8	; Save screen mode for C language
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],200
		MOV		DWORD [VRAM],0x000a0000

; Get keyboard LED status from BIOS

		MOV		AH,0x02
		INT		0x16 			; keyboard BIOS
		MOV		[LEDS],AL

; Disable all interrupts accepted by PIC
; For initialization of PIC in AT-compatible machines,
; you need to do this before CLI to avoid hang-ups sometimes
; PIC initialization is done later

		MOV		AL,0xff
		OUT		0x21,AL
		NOP						; Some models might fail if OUT instructions are continuous
		OUT		0xa1,AL

		CLI						; Disable interrupts at CPU level

; Enable access to memory above 1MB by setting A20GATE

		CALL	waitkbdout
		MOV		AL,0xd1
		OUT		0x64,AL
		CALL	waitkbdout
		MOV		AL,0xdf			; enable A20
		OUT		0x60,AL
		CALL	waitkbdout

; Switch to protected mode

; [INSTRSET "i486p"]				; Specify using instructions up to 486

		LGDT	[GDTR0]			; Set provisional GDT
		MOV		EAX,CR0
		AND		EAX,0x7fffffff	; Set bit31 to 0 (disable paging)
		OR		EAX,0x00000001	; Set bit0 to 1 (switch to protected mode)
		MOV		CR0,EAX
		JMP		pipelineflush
pipelineflush:
		MOV		AX,1*8			;  Read-write segment, 32-bit
		MOV		DS,AX
		MOV		ES,AX
		MOV		FS,AX
		MOV		GS,AX
		MOV		SS,AX

; Transfer bootpack

		MOV		ESI,bootpack	; Source
		MOV		EDI,BOTPAK		; Destination
		MOV		ECX,512*1024/4
		CALL	memcpy

; Transfer disk data to the original position

; First, from the boot sector

		MOV		ESI,0x7c00		; Source
		MOV		EDI,DSKCAC		; Destination
		MOV		ECX,512/4
		CALL	memcpy

; Transfer the remaining data

		MOV		ESI,DSKCAC0+512	; Source
		MOV		EDI,DSKCAC+512	; Destination
		MOV		ECX,0
		MOV		CL,BYTE [CYLS]
		IMUL	ECX,512*18*2/4	; Convert cylinder count to byte count/4
		SUB		ECX,512/4		; Subtract IPL
		CALL	memcpy

; Everything to be done in asmhead is finished,
; Now leave it to bootpack

; Boot bootpack

		MOV		EBX,BOTPAK
		MOV		ECX,[EBX+16]
		ADD		ECX,3			; ECX += 3;
		SHR		ECX,2			; ECX /= 4;
		JZ		skip			; Nothing to transfer
		MOV		ESI,[EBX+20]	; Source
		ADD		ESI,EBX
		MOV		EDI,[EBX+12]	; Destination
;		CALL	memcpy
skip:
;		MOV		ESP,[EBX+12]	; Initial value of stack
;		JMP		DWORD 2*8:0x0000001b
		MOV   ESP, 0xffff
		JMP   DWORD 2*8:0x00000000

waitkbdout:
		IN		 AL,0x64
		AND		 AL,0x02
		JNZ		waitkbdout		; Jump to waitkbdout if the result of AND is not 0
		RET

memcpy:
		MOV		EAX,[ESI]
		ADD		ESI,4
		MOV		[EDI],EAX
		ADD		EDI,4
		SUB		ECX,1
		JNZ		memcpy			; Jump to memcpy if the result of subtraction is not 0
		RET
; memcpy can also be written using string instructions as long as you don't forget the address size prefix

		ALIGNB	16
GDT0:
		RESB	8				; Null selector
		DW		0xffff,0x0000,0x9200,0x00cf	; Read-write segment 32-bit
		DW		0xffff,0x0000,0x9a28,0x0047	; Execute segment 32-bit (for bootpack)

		DW		0
GDTR0:
		DW		8*3-1
		DD		GDT0

		ALIGNB	16
bootpack:
