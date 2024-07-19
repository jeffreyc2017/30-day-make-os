# BIOS Parameter Block (BPB) structure

- ORG 0x7c00: This sets the origin of the code to memory address 0x7c00. In the x86 architecture, the BIOS loads the boot sector of a bootable drive to this address and then transfers control to it.

- JMP SHORT entry: A jump instruction to the entry label. This is a typical starting point in a boot sector to jump over the BPB structure and continue execution. entry is a label that would be defined later in the code.

- NOP: A no-operation instruction, often used for padding.

## Floppy Disk

| Offset in Boot Sector | Length in Bytes | Mnemonic                                   | Data type | Data content  | Data comment                                                 |
| --------------------- | --------------- | ------------------------------------------ | --------- | ------------- | ------------------------------------------------------------ |
| 03                    | 8               | OEM_Identifier                             | DB        | "HARIBOTE"    | You can freely write the name of the boot sector (8 bytes)   |
| 0B                    | 2               | BytesPerSector                             | DW        | 512           | Size of one sector (must be 512)                             |
| 0D                    | 1               | SectorsPerCluster                          | DB        | 1             | Size of a cluster (must be 1 sector)                         |
| 0E                    | 2               | ReservedSectors                            | DW        | 1             | Where the FAT starts (normally set to the first sector)      |
| 10                    | 1               | NumberOfFATs                               | DB        | 2             | Number of FATs (must be 2)                                   |
| 11                    | 2               | RootEntries                                | DW        | 224           | Size of the root directory area (usually set to 224 entries) |
| 13                    | 2               | NumberOfSectors                            | DW        | 2880          | Size of this drive (must be 2880 sectors)                    |
| 15                    | 1               | MediaDescriptor                            | DB        | 0xf0          | Type of media (must be 0xf0)                                 |
| 16                    | 2               | SectorsPerFAT                              | DW        | 9             | Length of FAT area (must be 9 sectors)                       |
| 18                    | 2               | SectorsPerHead                             | DW        | 18            | Number of sectors per track (must be 18)                     |
| 1A                    | 2               | HeadsPerCylinder                           | DW        | 2             | Number of heads (must be 2)                                  |
| 1C                    | 4               | HiddenSectors                              | DD        | 0             | Must be 0 as partitions are not used here                    |
| 20                    | 4               | BigNumberOfSectors                         | DD        | 2880          | Write the size of this drive again                           |
| 24                    | 1               | BIOS drive number                          | DB        | 0             |                                                              |
| 25                    | 1               | Reserved                                   | DB        | 0             |                                                              |
| 26                    | 1               | Extended Boot Record signature = 29h       | DB        | 0x29          | Apparently, it's good to set this value                      |
| 27                    | 4               | Serial Number                              | DD        | 0xffffffff    | Probably the volume serial number                            |
| 2B                    | 11              | Volume label                               | DB        | "HARIBOTEOS " | Name of the disk (11 bytes)                                  |
| 36                    | 8               | System Identifier (FAT12, FAT16, or FAT32) | DB        | "FAT12 "      | Name of the format (8 bytes)                                 |

## USB drive

| Offset in Boot Sector | Length in Bytes | Mnemonic                                   | Data def       | Data type | Data content                                                   |
| --------------------- | --------------- | ------------------------------------------ | -------------- | --------- | -------------------------------------------------------------- |
| 03                    | 8               | OEM_Identifier                             | BS_OEMName     | DB        | "HARIBOTE" ; [8 bytes] boot sector name                        |
| 0B                    | 2               | BytesPerSector                             | BPB_BytsPerSec | DW        | 0x0200 ; the size of a sector (should be 512=0x0020)           |
| 0D                    | 1               | SectorsPerCluster                          | BPB_SecPerClus | DB        | 0x01 ; the size of a cluster (should be 1 sector)              |
| 0E                    | 2               | ReservedSectors                            | BPB_RsvdSecCnt | DW        | 0x0001 ; where FAT begins (usually from 1st sector)            |
| 10                    | 1               | NumberOfFATs                               | BPB_NumFATs    | DB        | 0x02 ; the number of FATs (should be 2)                        |
| 11                    | 2               | RootEntries                                | BPB_RootEntCnt | DW        | 0x0000 ; the size of root directory area (usually 224 entries) |
| 13                    | 2               | NumberOfSectors                            | BPB_TotSec16   | DW        | 0x0000 ; the size of this drive (should be 2880 sectors)       |
| 15                    | 1               | MediaDescriptor                            | BPB_Media      | DB        | 0xf8 ; the type of media (Any Hard Drive)                      |
| 16                    | 2               | SectorsPerFAT                              | BPB_FATSz16    | DW        | 0x0000 ; the length of FAT area (should be 9 sectors)          |
| 18                    | 2               | SectorsPerHead                             | BPB_SecPerTrk  | DW        | 0xffff ; the number of sectors per a track (should be 18)      |
| 1A                    | 2               | HeadsPerCylinder                           | BPB_NumHeads   | DW        | 0x0001 ; the number of heads (should be 2)                     |
| 1C                    | 4               | HiddenSectors                              | BPB_HiDDSec    | DD        | 0x00000000 ; should be zero since we will not use partition    |
| 20                    | 4               | BigNumberOfSectors                         | BPB_TotSec32   | DD        | 0x00ee5000 ; the size of this drive (again)                    |
| 24                    | 4               | BigSectorsPerFAT                           | BPB_FATSz32    | DD        | 0x000000ed                                                     |
| 28                    | 2               | ExtFlags                                   | BPB_ExtFlags   | DW        | 0x0000                                                         |
| 2A                    | 2               | FSVersion                                  | BPB_FSVer      | DW        | 0x0000                                                         |
| 2C                    | 4               | RootDirectoryStart                         | BPB_RootClus   | DD        | 0x00000000                                                     |
| 30                    | 2               | FSInfoSector                               | BPB_FSInfo     | DW        | 0x0001                                                         |
| 32                    | 2               | BackupBootSector                           | BPB_BkBootSec  | DW        | 0x0000                                                         |
| 34                    | 12              | Reserved                                   |                |           | TIMES 12 DB 0 ; BPB_Reserved                                   |
| 40                    | 1               | BIOS drive number                          | BS_DrvNum      | DB        | 0x80                                                           |
| 41                    | 1               | Reserved                                   | BS_Reserved1   | DB        | 0x00                                                           |
| 42                    | 1               | Extended Boot Record signature = 29h       | BS_BootSig     | DB        | 0x29                                                           |
| 43                    | 4               | Serial Number                              | BS_VolID       | DD        | 0xffffffff                                                     |
| 47                    | 11              | Volume label                               | BS_VolLab      | DB        | "HARIBOTEOS " ; [11 bytes] the name of the disk                |
| 52                    | 8               | System Identifier (FAT12, FAT16, or FAT32) | BS_FilSysType  | DB        | "FAT32 " ; [8 bytes] the name of the format                    |

### Calculations and Explanations

1.  Bytes per Sector (BPB_BytsPerSec):

    - Fixed at 512 bytes per sector (0x0200).

2.  Sectors per Cluster (BPB_SecPerClus):

    - Typically 8 sectors per cluster (0x08) for FAT32 on a large drive like 8GB.

3.  Reserved Sectors Count (BPB_RsvdSecCnt):

    - Typically 32 reserved sectors (0x0020) for FAT32.

4.  Total Sectors (BPB_TotSec32):

    - 8GB drive = 8 \* 1024 \* 1024 \* 1024 bytes.
    - Total sectors = 8 \* 1024 \* 1024 \* 1024 / 512 = 16,777,216 sectors.
    - However, since the actual usable sectors are a bit less due to reserved sectors, let's use a practical value of 7,745,024 sectors (0x00EE5000).

5.  Sectors per FAT (BPB_FATSz32):

    This requires a bit of calculation:

    - Number of Clusters = (Total Sectors - Reserved Sectors - (Number of FATs \* Sectors per FAT) - Root Directory Sectors) / Sectors per Cluster

    Estimating Sectors per FAT:

    - Assume 8,000 sectors per FAT initially (0x1F40).

    Adjust if necessary after calculating the number of clusters.

6.  Sectors per Track (BPB_SecPerTrk) and Number of Heads (BPB_NumHeads):

    - These are more relevant to older BIOS geometry but typically set as 63 sectors per track and 255 heads for modern USB drives.

7.  Hidden Sectors (BPB_HiDDSec):

    - Usually set to 0.

8.  FAT32-specific fields:

    - `BPB_RootClus` typically starts at cluster 2.
    - `BPB_FSInfo` usually 1.
    - `BPB_BkBootSec` usually 6.

## References

- https://en.wikipedia.org/wiki/BIOS_parameter_block
- https://averstak.tripod.com/fatdox/bootsec.htm
- https://academy.cba.mit.edu/classes/networking_communications/SD/FAT.pdf
- https://wiki.osdev.org/FAT
