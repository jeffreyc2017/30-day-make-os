; haribote-ipl
; TAB=4

        ORG     0x7c00          ; This program loads at memory address 0x7c00

; Standard FAT12 boot sector setup

        JMP     entry
        DB      0x90
        DB      "HARIBOTE"      ; Boot sector name (8 bytes)
        DW      512             ; Sector size (512 bytes)
        DB      1               ; Cluster size (1 sector)
        DW      1               ; FAT start sector (usually sector 1)
        DB      2               ; Number of FATs (2)
        DW      224             ; Root directory entries (usually 224)
        DW      2880            ; Total sectors on the disk (2880 for 1.44MB floppy)
        DB      0xf0            ; Media descriptor (0xf0 for removable media)
        DW      9               ; Sectors per FAT (9 sectors)
        DW      18              ; Sectors per track (18)
        DW      2               ; Number of heads (2)
        DD      0               ; Hidden sectors (0)
        DD      2880            ; Total sectors (again)
        DB      0,0,0x29        ; Physical drive number, reserved, extended boot signature
        DD      0xffffffff      ; Volume serial number
        DB      "HARIBOTEOS "   ; Volume label (11 bytes)
        DB      "FAT12   "      ; File system type (8 bytes)
        RESB    18              ; Reserved bytes

; Program entry point

entry:
        MOV     AX,0            ; Initialize registers
        MOV     SS,AX
        MOV     SP,0x7c00
        MOV     DS,AX

; Disk read setup

        MOV     AX,0x0820
        MOV     ES,AX
        MOV     CH,0            ; Cylinder 0
        MOV     DH,0            ; Head 0
        MOV     CL,2            ; Sector 2

        MOV     AH,0x02         ; BIOS read sector function
        MOV     AL,1            ; Number of sectors to read
        MOV     BX,0            ; Buffer offset
        MOV     DL,0x00         ; Drive number (0x00 for floppy A)
        INT     0x13            ; Call BIOS
        JC      error           ; Jump to error if carry flag is set

; Halt the CPU if read is successful

fin:
        HLT                     ; Halt the CPU
        JMP     fin             ; Infinite loop

; Error handler

error:
        MOV     SI,msg
putloop:
        MOV     AL,[SI]
        ADD     SI,1            ; Increment SI
        CMP     AL,0
        JE      fin             ; Jump to fin if AL is 0 (end of message)
        MOV     AH,0x0e         ; BIOS teletype function
        MOV     BX,15           ; Color code
        INT     0x10            ; Call BIOS
        JMP     putloop

msg:
        DB      0x0a, 0x0a      ; Two newlines
        DB      "load error"
        DB      0x0a            ; Newline
        DB      0

        ; Fill remaining bytes to 0x7dfe
        RESB    0x7dfe-0x7c00-($-$$)

        DB      0x55, 0xaa      ; Boot sector signature