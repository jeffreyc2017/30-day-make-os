; haribote-ipl
; TAB=4

CYLS    EQU     9               ; Number of cylinders to read

        ORG     0x7c00          ; This program is loaded at 0x7c00

; The following is for standard FAT12 format floppy disks, modified for USB

        JMP     entry
        DB      0x90
        DB      "HARIBOTE"      ; Boot sector name (8 bytes)
        DW      512             ; Sector size (must be 512)
        DB      1               ; Cluster size (must be 1 sector)
        DW      1               ; FAT start sector (usually 1)
        DB      2               ; Number of FATs (must be 2)
        DW      224             ; Root directory size (usually 224 entries)
        DW      2880            ; Drive size (must be 2880 sectors for floppy, adjust for USB)
        DB      0xf8            ; Media type (0xf0 for floppy, 0xf8 for hard drive/USB)
        DW      9               ; FAT size (must be 9 sectors)
        DW      18              ; Sectors per track (must be 18)
        DW      2               ; Number of heads (must be 2)
        DD      0               ; Hidden sectors (must be 0)
        DD      2880            ; Total sectors (must be 2880, adjust for USB)
        DB      0,0,0x29        ; Reserved
        DD      0xffffffff      ; Volume serial number
        DB      "HARIBOTEOS "   ; Volume label (11 bytes)
        DB      "FAT12   "      ; File system type (8 bytes)
        RESB    18              ; Reserved

; Program entry point

entry:
        MOV     AX,0            ; Initialize registers
        MOV     SS,AX
        MOV     SP,0x7c00
        MOV     DS,AX

; Read disk sectors

        MOV     AX,0x0820
        MOV     ES,AX
        MOV     CH,0            ; Cylinder 0
        MOV     DH,0            ; Head 0
        MOV     CL,2            ; Sector 2
        MOV     BX,18*2*CYLS-1  ; Total sectors to read
        CALL    readfast        ; Fast read

; Execute haribote.sys

        MOV     BYTE [0x0ff0],CYLS  ; Record the read position
        JMP     0xc200

error:
        MOV     AX,0
        MOV     ES,AX
        MOV     SI,msg
putloop:
        MOV     AL,[SI]
        ADD     SI,1            ; Increment SI
        CMP     AL,0
        JE      fin
        MOV     AH,0x0e         ; Teletype output function
        MOV     BX,15           ; Color code
        INT     0x10            ; BIOS video interrupt
        JMP     putloop
fin:
        HLT                     ; Halt CPU until reset
        JMP     fin             ; Infinite loop
msg:
        DB      0x0a, 0x0a      ; Two newlines
        DB      "load error"
        DB      0x0a            ; Newline
        DB      0

readfast:    ; Fast read using AL
;   ES: read address, CH: cylinder, DH: head, CL: sector, BX: total sectors

        MOV     AX,ES           ; Calculate maximum AL value from ES
        SHL     AX,3            ; Divide AX by 32, result in AH (SHL is shift left)
        AND     AH,0x7f         ; AH %= 128 (512 * 128 = 64K)
        MOV     AL,128          ; AL = 128 - AH; max sectors to nearest 64KB boundary
        SUB     AL,AH

        MOV     AH,BL           ; Calculate maximum AL value from BX
        CMP     BH,0            ; if (BH != 0) { AH = 18; }
        JE      .skip1
        MOV     AH,18
.skip1:
        CMP     AL,AH           ; if (AL > AH) { AL = AH; }
        JBE     .skip2
        MOV     AL,AH
.skip2:

        MOV     AH,19           ; Calculate maximum AL value from CL
        SUB     AH,CL           ; AH = 19 - CL;
        CMP     AL,AH           ; if (AL > AH) { AL = AH; }
        JBE     .skip3
        MOV     AL,AH
.skip3:

        PUSH    BX
        MOV     SI,0            ; Initialize retry counter
retry:
        MOV     AH,0x02         ; AH=0x02: disk read
        MOV     BX,0
        MOV     DL,0x80         ; USB drive
        PUSH    ES
        PUSH    DX
        PUSH    CX
        PUSH    AX
        INT     0x13            ; BIOS disk interrupt
        JNC     next            ; No error, proceed to next
        ADD     SI,1            ; Increment retry counter
        CMP     SI,5            ; Compare retry counter to 5
        JAE     error           ; If >= 5, jump to error
        MOV     AH,0x00
        MOV     DL,0x80         ; USB drive
        INT     0x13            ; Reset drive
        POP     AX
        POP     CX
        POP     DX
        POP     ES
        JMP     retry
next:
        POP     AX
        POP     CX
        POP     DX
        POP     BX              ; Restore ES from BX
        SHR     BX,5            ; Convert BX to 512-byte units
        MOV     AH,0
        ADD     BX,AX           ; BX += AL;
        SHL     BX,5            ; Convert BX to 16-byte units
        MOV     ES,BX           ; ES += AL * 0x20;
        POP     BX
        SUB     BX,AX
        JZ      .ret
        ADD     CL,AL           ; Add AL to CL
        CMP     CL,18           ; Compare CL to 18
        JBE     readfast        ; If <= 18, repeat readfast
        MOV     CL,1
        ADD     DH,1
        CMP     DH,2
        JB      readfast        ; If < 2, repeat readfast
        MOV     DH,0
        ADD     CH,1
        JMP     readfast
.ret:
        RET

        RESB    0x7dfe-0x7c00-($-$$)  ; Fill to 0x7dfe with 0x00

        DB      0x55, 0xaa
