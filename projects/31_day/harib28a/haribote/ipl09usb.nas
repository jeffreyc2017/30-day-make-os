; hello-os
; TAB=4

CYLS	EQU		20

	ORG		0x7c00

; BPB Structure

	JMP		SHORT	entry	; BS_jmpBoot
	NOP
BS_OEMName		DB	"HARIBOTE"		; [8 bytes] boot sector name
BPB_BytsPerSec	DW	0x0200			; the size of a sector (should be 512=0x0020)
BPB_SecPerClus	DB	0x01			; the size of a cluster (should be 1 sector)
BPB_RsvdSecCnt	DW	0x0001			; where FAT begins (usually from 1st sector)
BPB_NumFATs		DB	0x02			; the number of FATs (should be 2)
BPB_RootEntCnt	DW	0x0000			; the size of root directory area (usually 224 entries)
BPB_TotSec16	DW	0x0000			; the size of this drive (should be 2880 sectors)
BPB_Media		DB	0xf8			; the type of media (should be 0xf0)
BPB_FATSz16		DW	0x0000			; the length of FAT area (should be 9 sectors)
BPB_SecPerTrk	DW	0xffff			; the number of sectors per a track (should be 18)
BPB_NumHeads	DW	0x0001			; the number of heads (should be 2)
BPB_HiDDSec		DD	0x00000000		; should be zero since we will not use partition
BPB_TotSec32	DD	0x00ee5000		; the size of this drive (again)
BPB_FATSz32		DD	0x000000ed
BPB_ExtFlags	DW	0x0000
BPB_FSVer		DW	0x0000
BPB_RootClus	DD	0x00000000
BPB_FSInfo		DW	0x0001
BPB_BkBootSec	DW	0x0000
				TIMES	12	DB	0	; BPB_Reserved
BS_DrvNum		DB	0x80
BS_Reserved1	DB	0x00
BS_BootSig		DB	0x29
BS_VolID		DD	0xffffffff
BS_VolLab		DB	"HARIBOTEOS "	; [11 bytes] the name of the disk
BS_FilSysType	DB	"FAT12   "		; [8 bytes] the name of the format
				;RESB	18				; put 18 bytes of space anyway
				TIMES 	18	DB	0

; START	BS_BootCode 64(0x14)	448(0x1C0)

entry:
	MOV		AX, 0			; register initialization
	MOV		SS, AX
	MOV		ES, AX
	MOV		DS, AX
	MOV		BX, AX
	MOV		CX, AX
	MOV		SP, 0x7c00

; read disk

	MOV		[drv], DL

	MOV		AH, 0x41
	MOV		BX, 0x55aa		; fixed for INT 0x13
	INT		0x13			; AH=0x41 : check if extended INT 0x13 is available
	JC		nosupport		; if not supported

	XOR		AX, AX			; P xor P = 0 for all P
	ADD		AX, 1			; clear carry flag
	XOR		EDI, EDI

	MOV		AH, 0x45		; drive lock
	MOV		AL, 0x01
	MOV		DL, 0x80
	INT		0x13			; AH=0x45 : (extended) drive lock

	MOV		AX, 0
	MOV		DS, AX

loop:
	MOV		CL, 0
retry:
	PUSH	DS
	PUSHAD
	MOV		DL, [drv]
	MOV		AH, 0x42
	MOV		AL, 0x00
	MOV		SI, DAPS
	INT		0x13			; AH=0x42 : (extended) read disk
	JNC		next			; if error did not occur goto next

	ADD		CL, 1			; ++CL
	MOV		DL, 0x80
	MOV		AH, 0x00
	INT		0x13			; AH=0x00 : system reset
	CMP		CL, 6
	JGE		error			; if CL >= 6 goto error
	JMP		retry

next:

	XOR		EAX, EAX
	XOR		EBX, EBX
	XOR		ECX, ECX

	ADD		EDI, 1			; ++EDI
	MOV		ECX, lba0
	MOV		[ECX], EDI

	XOR		EAX, EAX
	XOR		ECX, ECX
	XOR		EBP, EBP

	MOV		AX, [addr]
	MOV		ECX, addr
	MOV		EBX, segm
	ADD		AX, 0x200
	ADC		BP, 0
	SHL		BP, 12
	ADD		BP, [segm]
	MOV		[EBX], BP

	MOV		[ECX], AX
	MOV		[EBX], BP

	CMP		EDI, 0x16a
	JL		loop

	MOV		ECX, 0xc200

	MOV		EAX, 0x0000
	MOV		EBX, EAX
	MOV		EDX, EAX
	MOV		EBP, EAX
	MOV		ESI, EAX
	MOV		EDI, EAX

	MOV		CH, 10
	MOV		[0x0ff0], CH

	MOV		ECX, EAX
	JMP		0x0000:0xc200

nosupport:
	MOV		SI, msg_nos
	JMP		putloop
error:
	POPAD
	POP		DS
	MOV		SI,msg
	JMP		putloop
putloop:
	MOV		AL,[SI]
	ADD		SI,1			; ++SI
	CMP		AL,0
	JE		fin
	MOV		AH,0x0e
	MOV		BX, [chclr]		; BX : color code
	INT		0x10			; AH=0x0e : putchar()
	JMP		putloop

fin:
	HLT
	JMP		fin

putloop_e:
	MOV		AL,[SI]
	ADD		SI,1			; ++SI
	CMP		AL,0
	JE		fin
	MOV		AH,0x0e
	MOV		BX, [chclr]		; BX : color code
	INT		0x10			; AH=0x0e : putchar()
	JMP		putloop_e

msg:
	;DB		0x0d, 0x0a		; CR LF
	DB		"load error"
	DB		0x0d, 0x0a		; CR LF
	DB		0

msg_nos:
	DB		0x0d, 0x0a		; CR LF
	DB		"extINT13H not supported"
	DB		0x0d, 0x0a		; CR LF
	DB		0

drv:
	DB		0x80			; 0x00: 1st FDD, 0x80: 1st HDD
chclr:
	DW		0x000f			; usually 15=0x000f

DAPS:
	DB		0x10			; Size of Structure (16 bytes, always this for DAPS)
	DB		0				; Always 0
count:
	DB		1				; Number of Sectors to Read (1x512)
	DB		0				; Always 0
addr:
	DW		0x8000			; Target Location for Reading To (0x8000 = 0x0800:0x0000)
segm:
	DW		0x0000			; Page Table (0, Disabled)
lba0:
	DD		1				; Read from 2nd block (code I want to load)
	DD		0


	TIMES	0x7dfe-0x7c00-($-$$)	DB	0
	DB		0x55, 0xaa		; boot signature