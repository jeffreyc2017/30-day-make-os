; haribote-ipl
; TAB=4

CYLS	EQU		15				; How far to read
DRVNO   EQU     0x80            ; Drive number (0x80: first HDD)

    ORG     0x7c00           ; Origin of the code. The BIOS loads the bootloader at address 0x7c00

; BPB Structure (BIOS Parameter Block) for FAT32

    JMP     SHORT   entry    ; Jump to the entry point of the bootloader code
    NOP                      ; No operation, used for alignment

BS_OEMName      DB  "HARIBOTE"       ; [8 bytes] OEM name or identifier
BPB_BytsPerSec  DW  0x0200           ; Bytes per sector (512 bytes). Standard for FAT12/16/32
BPB_SecPerClus  DB  0x08             ; Sectors per cluster (8 sectors per cluster). FAT32 standard
BPB_RsvdSecCnt  DW  0x0020           ; Reserved sectors count (32 reserved sectors). Usually for FAT32
BPB_NumFATs     DB  0x02             ; Number of FAT copies (2). Standard for FAT32
BPB_RootEntCnt  DW  0x0000           ; Root directory entries (0 for FAT32; root directory is in a cluster)
BPB_TotSec16    DW  0x0000           ; Total sectors for FAT12/16 (0 for FAT32; use BPB_TotSec32)
BPB_Media       DB  0xF8             ; Media descriptor (0xF8 for hard disks)
BPB_FATSz16     DW  0x0000           ; Sectors per FAT for FAT12/16 (0 for FAT32; use BPB_FATSz32)
BPB_SecPerTrk   DW  0x003F           ; Sectors per track (63 for hard disks)
BPB_NumHeads    DW  0x00FF           ; Number of heads (255 for hard disks)
BPB_HiDDSec     DD  0x00000000       ; Hidden sectors (usually 0)
BPB_TotSec32    DD  0x00EE5000       ; Total sectors for the USB drive (7,745,024 sectors)

; FAT32 specific fields
BPB_FATSz32     DD  0x00001F40       ; Sectors per FAT (8,000 sectors per FAT)
BPB_ExtFlags    DW  0x0000           ; Flags (FAT32 specific; 0 for default behavior)
BPB_FSVer       DW  0x0000           ; Filesystem version (0 for FAT32)
BPB_RootClus    DD  0x00000002       ; Root directory cluster (usually 2)
BPB_FSInfo      DW  0x0001           ; FSInfo sector (usually 1)
BPB_BkBootSec   DW  0x0006           ; Backup boot sector (usually 6)
                TIMES   12  DB  0    ; Reserved bytes (FAT32 specific)

; Extended BIOS Parameter Block fields
BS_DrvNum       DB  0x80             ; Drive number (0x80 for the first HDD)
BS_Reserved1    DB  0x00             ; Reserved byte
BS_BootSig      DB  0x29             ; Extended boot signature (0x29)
BS_VolID        DD  0xFFFFFFFF       ; Volume serial number (0xFFFFFFFF is a placeholder)
BS_VolLab       DB  "HARIBOTEOS "    ; [11 bytes] Volume label
BS_FilSysType   DB  "FAT32   "       ; [8 bytes] Filesystem type

                TIMES   18  DB  0   ; Padding to align the boot code start

; Boot code starts here, after the BPB and EBP sections

entry:
    MOV     AX, 0           ; Initialize AX register to 0
    MOV     SS, AX          ; Set Stack Segment (SS) to 0 (base address)
    MOV     ES, AX          ; Set Extra Segment (ES) to 0 (base address)
    MOV     DS, AX          ; Set Data Segment (DS) to 0 (base address)
    MOV     BX, AX          ; Initialize BX register to 0
    MOV     CX, AX          ; Initialize CX register to 0
    MOV     SP, 0x7c00      ; Set Stack Pointer (SP) to top of bootloader (0x7c00)

; Read disk and initialize the system

; Check if extended INT 0x13 is available

    MOV     AH, 0x41        ; BIOS interrupt 0x13, function 0x41: check if extended INT 13h is available
    MOV     BX, 0x55aa      ; Fixed value to check for extended INT 13h support
    INT     0x13            ; Call BIOS interrupt 0x13
    JC      nosupport       ; Jump to nosupport label if carry flag is set (indicates failure)

    MOV     DI, [DAPS.lba]

; Perform disk operations using the drive number in DL

    MOV     AH, 0x45        ; BIOS interrupt 0x13, function 0x45: lock the drive
    MOV     AL, 0x01        ; Lock drive 0x80
    MOV     DL, DRVNO       ; Drive number 0x80 (first HDD)
    INT     0x13            ; Call BIOS interrupt 0x13 to lock the drive

loop:
    MOV     CL, 0           ; Clear CL register (used for retry counter)
retry:
    MOV     DL, DRVNO       ; Load drive number from memory
    MOV     AH, 0x42        ; BIOS interrupt 0x13, function 0x42: extended read disk
    MOV     SI, DAPS        ; Load address of Disk Address Packet (DAPS)
    INT     0x13            ; Call BIOS interrupt 0x13 to read the disk
    JNC     next            ; Jump to next if no carry (indicates success)

    ADD     CL, 1           ; Increment retry counter
    MOV     DL, DRVNO       ; Reset drive
    MOV     AH, 0x00        ; BIOS interrupt 0x13, function 0x00: reset drive
    INT     0x13            ; Call BIOS interrupt 0x13
    CMP     CL, 6           ; Compare retry counter with 6
    JGE     error           ; Jump to error if retry counter >= 6
    JMP     retry           ; Jump back to retry reading disk

next:
    ADD     DI, 1           ; Increment DI (used to track sectors read)
    MOV     [DAPS.lba], DI  ; Store incremented DI to LBA address

    MOV     AX, [DAPS.addr] ; Load address from memory (target location for reading)
    ADD     AX, 0x200       ; Add 0x200 to AX (offset adjustment)
    MOV     [DAPS.addr], AX ; Store address in DAPS.addr
    ADC     BP, 0           ; Add carry to BP (for address calculation)
    SHL     BP, 12          ; Shift BP left by 12 (address scaling)
    ADD     BP, [DAPS.segm] ; Add segment base address to BP
    MOV     [DAPS.segm], BP ; Store computed address in DAPS.segm

    CMP     DI, 0x21c       ; check if all sectors read
    JL      loop            ;

    MOV     BYTE [0x0ff0], CYLS  ; Note how far the IPL has read
    JMP     0xc200          ; Jump to address 0xc200 in segment 0x0000

nosupport:
    MOV     SI, msg_nos     ; Load address of "extINT13H not supported" message
putloop:
    MOV     AL, [SI]        ; Load character from message into AL
    ADD     SI, 1           ; Increment message pointer (SI)
    CMP     AL, 0           ; Compare AL with 0 (end of message)
    JE      fin             ; Jump to fin if end of message
    MOV     AH, 0x0e        ; BIOS interrupt 0x10, function 0x0e: teletype output
    MOV     BX, 15          ; Load color code for output
    INT     0x10            ; Call BIOS interrupt 0x10 to output character
    JMP     putloop         ; Jump back to putloop to display next character

error:
    MOV     SI, msg         ; Load address of "load error" message
    JMP     putloop         ; Jump to putloop to display the message

fin:
    HLT                     ; Halt the CPU (end of bootloader execution)
    JMP     fin             ; Infinite loop to prevent further execution

msg:
    DB      "load error"    ; Error message to display
    DB      0x0d, 0x0a      ; CR LF (Carriage Return and Line Feed)
    DB      0               ; Null terminator for the string

msg_nos:
    DB      0x0d, 0x0a      ; CR LF (Carriage Return and Line Feed)
    DB      "extINT13H not supported" ; Message indicating extended INT 13h not supported
    DB      0x0d, 0x0a      ; CR LF (Carriage Return and Line Feed)
    DB      0               ; Null terminator for the string

align 4
DAPS:
    .packet_size    DB      0x10            ; Size of Disk Address Packet (16 bytes)
    .reserved       DB      0               ; Reserved, always 0
    .block_count    DW      1               ; Number of blocks to transfer (1 sector = 512 bytes)
    .addr           DW      0x8000          ; Target location for reading data to (0x8000)
    .segm           DW      0x0000          ; Segment address (0x0000)
    .lba            DQ      0               ; Read from LBA 1 (second block)

    TIMES   0x7dfe-0x7c00-($-$$)  DB  0  ; Fill the remainder of the boot sector with zeros
    DB      0x55, 0xaa      ; Boot signature (0x55AA), required for BIOS to recognize bootable disk
