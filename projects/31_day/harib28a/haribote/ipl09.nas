; haribote-ipl
; TAB=4

CYLS	EQU		15				; How far to read

		ORG		0x7c00			; Where this program will be loaded

; The following is for a standard FAT12 format floppy disk

		JMP		entry
		DB		0x90
		DB		"HARIBOTE"		; You can freely write the name of the boot sector (8 bytes)
		DW		512				; Size of one sector (must be 512)
		DB		1				; Size of a cluster (must be 1 sector)
		DW		1				; Where the FAT starts (normally set to the first sector)
		DB		2				; Number of FATs (must be 2)
		DW		224				; Size of the root directory area (usually set to 224 entries)
		DW		2880			; Size of this drive (must be 2880 sectors)
		DB		0xf0			; Type of media (must be 0xf0)
		DW		9				; Length of FAT area (must be 9 sectors)
		DW		18				; Number of sectors per track (must be 18)
		DW		2				; Number of heads (must be 2)
		DD		0				; Must be 0 as partitions are not used here
		DD		2880			; Write the size of this drive again
		DB		0,0,0x29		; Apparently, it's good to set this value
		DD		0xffffffff		; Probably the volume serial number
		DB		"HARIBOTEOS "	; Name of the disk (11 bytes)
		DB		"FAT12   "		; Name of the format (8 bytes)
		RESB	18				; Leave 18 bytes for now

; Main program

entry:
		MOV		AX,0			; Initialize registers
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX

; Read the disk

		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0			; Cylinder 0
		MOV		DH,0			; Head 0
		MOV		CL,2			; Sector 2
		MOV		BX,18*2*CYLS-1	; Total number of sectors to read
		CALL	readfast		; Fast reading

; After reading, execute haribote.sys!

		MOV		BYTE [0x0ff0],CYLS	; Note how far the IPL has read
		JMP		0xc200

error:
		MOV		AX,0
		MOV		ES,AX
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1			; Add 1 to SI
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; Display one character function
		MOV		BX,15			; Color code
		INT		0x10			; Call video BIOS
		JMP		putloop
fin:
		HLT						; Halt the CPU until something happens
		JMP		fin				; Infinite loop
msg:
		DB		0x0a, 0x0a		; Two newlines
		DB		"load error"
		DB		0x0a			; Newline
		DB		0

readfast:	; Use AL to read as much as possible at once
;	ES: Read address, CH: Cylinder, DH: Head, CL: Sector, BX: Number of sectors to read

		MOV		AX,ES			; < Calculate the maximum value of AL from ES >
		SHL		AX,3			; Divide AX by 32 and store the result in AH (SHL is the left shift instruction)
		AND		AH,0x7f			; AH is the remainder of AH divided by 128 (512*128=64K)
		MOV		AL,128			; AL = 128 - AH; Maximum number of sectors up to the nearest 64KB boundary
		SUB		AL,AH

		MOV		AH,BL			; < Calculate the maximum value of AL from BX to AH >
		CMP		BH,0			; if (BH != 0) { AH = 18; }
		JE		.skip1
		MOV		AH,18
.skip1:
		CMP		AL,AH			; if (AL > AH) { AL = AH; }
		JBE		.skip2
		MOV		AL,AH
.skip2:

		MOV		AH,19			; < Calculate the maximum value of AL from CL to AH >
		SUB		AH,CL			; AH = 19 - CL;
		CMP		AL,AH			; if (AL > AH) { AL = AH; }
		JBE		.skip3
		MOV		AL,AH
.skip3:

		PUSH	BX
		MOV		SI,0			; Register to count the number of failures
retry:
		MOV		AH,0x02			; AH=0x02 : Disk read
		MOV		BX,0
		MOV		DL,0x00			; Drive A
		PUSH	ES
		PUSH	DX
		PUSH	CX
		PUSH	AX
		INT		0x13			; Call disk BIOS
		JNC		next			; If no error, go to next
		ADD		SI,1			; Add 1 to SI
		CMP		SI,5			; Compare SI with 5
		JAE		error			; If SI >= 5, go to error
		MOV		AH,0x00
		MOV		DL,0x00			; Drive A
		INT		0x13			; Reset the drive
		POP		AX
		POP		CX
		POP		DX
		POP		ES
		JMP		retry
next:
		POP		AX
		POP		CX
		POP		DX
		POP		BX				; Receive the contents of ES in BX
		SHR		BX,5			; Convert BX from 16-byte units to 512-byte units
		MOV		AH,0
		ADD		BX,AX			; BX += AL;
		SHL		BX,5			; Convert BX from 512-byte units to 16-byte units
		MOV		ES,BX			; This makes ES += AL * 0x20;
		POP		BX
		SUB		BX,AX
		JZ		.ret
		ADD		CL,AL			; Add AL to CL
		CMP		CL,18			; Compare CL with 18
		JBE		readfast		; If CL <= 18, go to readfast
		MOV		CL,1
		ADD		DH,1
		CMP		DH,2
		JB		readfast		; If DH < 2, go to readfast
		MOV		DH,0
		ADD		CH,1
		JMP		readfast
.ret:
		RET

		RESB	0x7dfe-0x7c00-($-$$)		; Fill with 0x00 up to 0x7dfe

		DB		0x55, 0xaa
