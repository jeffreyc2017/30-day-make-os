# Hrb file format

From 22.5

    0x0000 (DWORD) ......请求操作系统为应用程序准备的数据段的大小
    0x0004 (DWORD) ......"Hari"（.hrb 文件的标记）
    0x0008 (DWORD) ......数据段内预备空间的大小
    0x000c (DWORD) ......ESP 初始值&数据部分传送目的地址
    0x0010 (DWORD) ......hrb 文件內数据部分的大小
    0×0014 (DWORD) ......hrb 文件内数据部分从哪里开始
    0x0018 (DWORD) ......Oxe9000000
    0x001c (DWORD) ......应用程序运行入口地址 - 0x20
    0x0020 (DWORD) ......malloc 空间的起始地址
