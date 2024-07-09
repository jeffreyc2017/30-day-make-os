# 各章简要

| Day    | Section | Code     | Title                          | Description                                                                                               |
| ------ | ------- | -------- | ------------------------------ | --------------------------------------------------------------------------------------------------------- |
| 0 day  | 1       |          | 前言                           |                                                                                                           |
|        | 2       |          | 何谓操作系统                   |                                                                                                           |
|        | 3       |          | 开发操作系统的各种方法         |                                                                                                           |
|        | 4       |          | 无知则无畏                     |                                                                                                           |
|        | 5       |          | 如何开发操作系统               |                                                                                                           |
|        | 6       |          | 操作系统开发中的困难           |                                                                                                           |
|        | 7       |          | 学习本书时的注意事项（重要！） | 版权说明                                                                                                  |
|        | 8       |          | 各章内容摘要                   |                                                                                                           |
| 01 day | 1       | helloos0 | 先动手操作                     |                                                                                                           |
|        | 2       |          | 究竟做了些什么                 |                                                                                                           |
|        | 3       | helloos1 | 初次体验汇编程序               |                                                                                                           |
|        | 4       | helloos2 | 加工润色                       |                                                                                                           |
| 02 day | 1       |          | 介绍文本编辑器                 |                                                                                                           |
|        | 2       | helloos3 | 继续开发                       |                                                                                                           |
|        | 3       | helloos4 | 先制作启动区                   |                                                                                                           |
|        | 4       | helloos5 | Makefile 入门                  |                                                                                                           |
| 03 day | 1       | harib00a | 制作真正的 IPL                 | 软盘结构                                                                                                  |
|        | 2       | harib00b | 试错                           |                                                                                                           |
|        | 3       | harib00c | 读到 18 扇区                   |                                                                                                           |
|        | 4       | harib00d | 读入 10 个柱面                 |                                                                                                           |
|        | 5       | harib00e |                                |                                                                                                           |
|        | 6       | harib00f |                                |                                                                                                           |
|        | 7       | harib00g |                                |                                                                                                           |
|        | 8       | harib00h |                                |                                                                                                           |
|        | 9       | harib00i |                                |                                                                                                           |
|        | 10      | harib00j |                                |                                                                                                           |
| 04 day | 1       | harib01a |                                |                                                                                                           |
|        | 2       | harib01b |                                |                                                                                                           |
|        | 3       | harib01c |                                |                                                                                                           |
|        | 4       | harib01d |                                |                                                                                                           |
|        | 5       | harib01e |                                |                                                                                                           |
|        | 6       | harib01f |                                |                                                                                                           |
|        | 7       | harib01g |                                |                                                                                                           |
|        | 8       | harib01h |                                |                                                                                                           |
| 05 day | 1       | harib02a |                                | 保存内存中的启动信息，不用看                                                                              |
|        | 2       | harib02b |                                | 增加结构体定义，有 C 语言基础可以不用看                                                                   |
|        | 3       | harib02c |                                | 改为指针访问，有 C 语言基础可以不用看                                                                     |
|        | 4       | harib02d |                                | 显示字符，本质上是写 VRAM                                                                                 |
|        | 5       | harib02e |                                | 增加 ASCII 字符集，在 UTILS 下编写了一个 makefont 工具                                                    |
|        | 6       | harib02f |                                | 显示字符串，5 基础上的扩展                                                                                |
|        | 7       | harib02g |                                | sprintf，增加 C 语言实现。自定义标准头文件和库[^1]                                                        |
|        | 8       | harib02h |                                | 显示鼠标箭头，本质是写 VRAM                                                                               |
|        | 9       | harib02i | GDT 与 IDT 的初始化            | GDT 与 IDT                                                                                                |
| 06 day | 1       | harib03a | 分割源文件                     | 代码重构，不用重点看                                                                                      |
|        | 2       | harib03b | 整理 Makefile                  | 不用重点看                                                                                                |
|        | 3       | harib03c | 整理头文件                     | 代码重构，不用重点看                                                                                      |
|        | 4       |          | 意犹未尽                       | GDT 相关                                                                                                  |
|        | 5       | harib03d | 初始化 PIC                     |                                                                                                           |
|        | 6       | harib03e | 中断处理程序的制作             |                                                                                                           |
| 07 day | 1       | harib04a | 获取按键编码                   |                                                                                                           |
|        | 2       | harib04b | 加快中断处理                   |                                                                                                           |
|        | 3       | harib04c | 制作 FIFO 缓冲区               |                                                                                                           |
|        | 4       | harib04d | 改善 FIFO 缓冲区               |                                                                                                           |
|        | 5       | harib04e | 整理 FIFO 缓冲区               |                                                                                                           |
|        | 6       | harib04f | 总算讲到鼠标了                 |                                                                                                           |
|        | 7       | harib04g | 从鼠标接收数据                 |                                                                                                           |
| 08 day | 1       | harib05a | 鼠标解读(1)                    |                                                                                                           |
|        | 2       | harib05b | 稍事整理                       |                                                                                                           |
|        | 3       | harib05c | 鼠标解读(2)                    |                                                                                                           |
|        | 4       | harib05d | 移动鼠标指针                   |                                                                                                           |
|        | 5       |          | 通往 32 位模式之路             |                                                                                                           |
| 09 day | 1       | harib06a | 整理源文件                     | 参照书中的 Makefile 进行了整理，尽量与原书中的结构和名称保持一致。此处 Makefile 可做为基线                |
|        | 2       | harib06b | 内存容量检查(1)                | 运行结果为 32MB(这个结果是对的)，与书中 3072MB 不一致(书中问题是编译器优化导致的结果)                     |
|        | 3       | harib06c | 内存容量检查(2)                | 用汇编代码替换了 C 程序                                                                                   |
|        | 4       | harib06d | 挑战内存管理                   |                                                                                                           |
| 10 day | 1       | harib07a | 内存管理(续)                   |                                                                                                           |
|        | 2       | harib07b | 叠加处理                       | !运行黑屏(修改 bootpack.c 解决)[^4]                                                                       |
|        | 3       | harib07c | 提高叠加处理速度(1)            |                                                                                                           |
|        | 4       | harib07d | 提高叠加处理速度(2)            |                                                                                                           |
| 11 day | 1       | harib08a | 鼠标显示问题                   |                                                                                                           |
|        | 2       | harib08b | 实现画面外的支持               |                                                                                                           |
|        | 3       | harib08c | shtctl 的指定省略              |                                                                                                           |
|        | 4       | harib08d | 显示窗口                       |                                                                                                           |
|        | 5       | harib08e | 小实验                         |                                                                                                           |
|        | 6       | harib08f | 高速计数器                     |                                                                                                           |
|        | 7       | harib08g | 消除闪烁(1)                    |                                                                                                           |
|        | 8       | harib08h | 消除闪烁(2)                    |                                                                                                           |
| 12 day | 1       | harib09a | 使用定时器                     |                                                                                                           |
|        | 2       | harib09b | 计量时间                       |                                                                                                           |
|        | 3       | harib09c | 超时功能                       |                                                                                                           |
|        | 4       | harib09d | 使用多个定时器                 |                                                                                                           |
|        | 5       | harib09e | 加快中断处理(1)                |                                                                                                           |
|        | 6       | harib09f | 加快中断处理(2)                |                                                                                                           |
|        | 7       | harib09g | 加快中断处理(3)                |                                                                                                           |
| 13 day | 1       | harib10a |                                |                                                                                                           |
|        | 2       | harib10b |                                |                                                                                                           |
|        | 3       | harib10c |                                | ?运行起来显示很卡                                                                                         |
|        | 4       | harib10d |                                | ?运行起来显示很卡                                                                                         |
|        | 5       | harib10e |                                | ?运行起来显示很卡                                                                                         |
|        | 6       | harib10f |                                | ?运行起来显示很卡                                                                                         |
|        | 7       | harib10g |                                | ?运行起来显示很卡                                                                                         |
|        | 8       | harib10h |                                | ?运行起来显示很卡                                                                                         |
|        | 9       | harib10i |                                | ?运行起来显示很卡                                                                                         |
| 14 day | 1       | harib11a |                                | ?运行起来显示很卡                                                                                         |
|        | 2       | harib11b |                                | ?运行起来显示很卡                                                                                         |
|        | 3       | harib11c |                                | ?运行起来显示很卡                                                                                         |
|        | 4       | harib11d |                                | ?display issues                                                                                           |
|        | 5       | harib11e |                                | ?运行起来显示很卡, display is correct. There must be something changed for the display to work correctly. |
|        | 6       | harib11f |                                | works great. Must be something fixed to make it run smoothly.                                             |
|        | 7       | harib11g |                                | works great                                                                                               |
|        | 8       | harib11h |                                | works great                                                                                               |
|        | 9       | harib11i |                                | works great                                                                                               |
| 15 day | 1       | harib12a |                                | works great                                                                                               |
|        | 2       | harib12b |                                | works great                                                                                               |
|        | 3       | harib12c |                                | works great                                                                                               |
|        | 4       | harib12d |                                | works great                                                                                               |
|        | 5       | harib12e |                                | ?运行起来显示很卡                                                                                         |
|        | 6       | harib12f |                                | ?运行起来显示很卡                                                                                         |
|        | 7       | harib12g |                                | ?运行起来显示很卡                                                                                         |
| 16 day | 1       | harib13a |                                | ?运行起来显示很卡                                                                                         |
|        | 2       | harib13b |                                | ?运行起来显示很卡                                                                                         |
|        | 3       | harib13c |                                | black screen                                                                                              |
|        | 4       | harib13d |                                | black screen                                                                                              |
|        | 5       | harib13e |                                | ?运行起来显示很卡                                                                                         |
| 17 day | 1       | harib14a |                                | works perfect(anything changed?)                                                                          |
|        | 2       | harib14b |                                | works perfect                                                                                             |
|        | 3       | harib14c |                                | works perfect                                                                                             |
|        | 4       | harib14d |                                | works perfect                                                                                             |
|        | 5       | harib14e |                                | works perfect                                                                                             |
|        | 6       | harib14f |                                | works perfect                                                                                             |
|        | 7       | harib14g |                                | works perfect                                                                                             |
| 18 day | 1       | harib15a |                                |                                                                                                           |
|        | 2       | harib15b |                                |                                                                                                           |
|        | 3       | harib15c |                                |                                                                                                           |
|        | 4       | harib15d |                                |                                                                                                           |
|        | 5       | harib15e |                                |                                                                                                           |
|        | 6       | harib15f |                                | newly added strcmp.obj                                                                                    |
|        | 7       | harib15g |                                |                                                                                                           |
| 19 day | 1       | harib16a |                                |                                                                                                           |
|        | 2       | harib16b |                                |                                                                                                           |
|        | 3       | harib16c |                                |                                                                                                           |
|        | 4       | harib16d |                                |                                                                                                           |
|        | 5       | harib16e |                                |                                                                                                           |
| 20 day | 1       | harib17a | 程序整理                       | 代码重构                                                                                                  |
|        | 2       | harib17b | 显示单个字符的 API(1)          | 必须使用.hrb 这个文件扩展名才能执行                                                                       |
|        | 3       | harib17c | 显示单个字符的 API(2)          | 书中用的跳转是; CALL 2\*8:0xbe3 搜索指令并改为 0xe04 后仍不能正确显示字符[^5]                             |
|        | 4       | harib17d | 结束应用程序                   |                                                                                                           |
|        | 5       | harib17e | 不随操作系统版本而改变的 API   |                                                                                                           |
|        | 6       | harib17f | 为应用程序自由命名             |                                                                                                           |
|        | 7       | harib17g | 当心寄存器                     |                                                                                                           |
|        | 8       | harib17h | 用 API 显示字符串              |                                                                                                           |
| 21 day | 1       | harib18a |                                |                                                                                                           |
|        | 2       | harib18b |                                | 运行 a 后不返回提示符[^6]                                                                                 |
|        | 3       | harib18c |                                | 运行 a 后不返回提示符                                                                                     |
|        | 4       | harib18d |                                |                                                                                                           |
|        | 5       | harib18e |                                |                                                                                                           |
|        | 6       | harib18f |                                |                                                                                                           |
|        | 7       | harib18g |                                | works perfect                                                                                             |
| 22 day | 1       | harib19a |                                | Started to use mtools.                                                                                    |
|        | 2       | harib19b |                                | [^7]                                                                                                      |
|        | 3       | harib19c |                                |                                                                                                           |
|        | 4       | harib19d |                                |                                                                                                           |
|        | 5       | harib19e |                                | 如作者指出 hrb 文件使用了自定义的格式，并且使用作者开发的工具生成的。引入 app.lds                         |
|        | 6       | harib19f |                                |                                                                                                           |
|        | 7       | harib19g |                                |                                                                                                           |
| 23 day | 1       | harib20a |                                |                                                                                                           |
|        | 2       | harib20b |                                |                                                                                                           |
|        | 3       | harib20c |                                |                                                                                                           |
|        | 4       | harib20d |                                |                                                                                                           |
|        | 5       | harib20e |                                |                                                                                                           |
|        | 6       | harib20f |                                |                                                                                                           |
|        | 7       | harib20g |                                | 从此开始引入 bootpack.lds，不用再对 asmhead.nas 和 bootpack.c 做额外修改。以后把之前的代码都改过来。      |
|        | 8       | harib20h |                                |                                                                                                           |
| 24 day | 1       | harib21a |                                | blank screen                                                                                              |
|        | 2       | harib21b |                                |                                                                                                           |
|        | 3       | harib21c |                                |                                                                                                           |
|        | 4       | harib21d |                                |                                                                                                           |
|        | 5       | harib21e |                                |                                                                                                           |
|        | 6       | harib21f |                                |                                                                                                           |
|        | 7       | harib21g |                                | 遇到编译问题[^8]。将 app.lds 中.data 0x0400 改为 0x0800                                                   |
|        | 8       | harib21h |                                |                                                                                                           |
| 25 day | 1       | harib22a |                                |                                                                                                           |
|        | 2       | harib22b |                                |                                                                                                           |
|        | 3       | harib22c |                                |                                                                                                           |
|        | 4       | harib22d |                                |                                                                                                           |
|        | 5       | harib22e |                                |                                                                                                           |
|        | 6       | harib22f |                                |                                                                                                           |
|        | 7       | harib22g |                                |                                                                                                           |
|        | 8       | harib22h |                                |                                                                                                           |
|        | 9       | harib22i |                                |                                                                                                           |
|        | 10      | harib22j |                                |                                                                                                           |
| 26 day | 1       | harib23a |                                |                                                                                                           |
|        | 2       | harib23b |                                |                                                                                                           |
|        | 3       | harib23c |                                |                                                                                                           |
|        | 4       | harib23d |                                |                                                                                                           |
|        | 5       | harib23e |                                |                                                                                                           |
|        | 6       | harib23f |                                |                                                                                                           |
|        | 7       | harib23g |                                |                                                                                                           |
|        | 8       | harib23h |                                |                                                                                                           |
|        | 9       | harib23i |                                |                                                                                                           |
|        | 10      | harib23j |                                |                                                                                                           |
| 27 day | 1       | harib24a |                                |                                                                                                           |
|        | 2       | harib24b |                                |                                                                                                           |
|        | 3       | harib24c |                                |                                                                                                           |
|        | 4       | harib24d |                                |                                                                                                           |
|        | 5       | harib24e |                                |                                                                                                           |
|        | 6       | harib24f |                                |                                                                                                           |
|        | 7       | harib24g |                                |                                                                                                           |
| 28 day | 1       | harib25a |                                |                                                                                                           |
|        | 2       | harib25b |                                |                                                                                                           |
|        | 3       | harib25c |                                |                                                                                                           |
|        | 4       | harib25d |                                |                                                                                                           |
|        | 5       | harib25e |                                |                                                                                                           |
|        | 6       | harib25f |                                |                                                                                                           |
|        | 7       | harib25g |                                | 从此 ipl10->ipl20                                                                                         |
| 29 day | 1       | harib26a |                                |                                                                                                           |
|        | 2       | harib26b |                                | 此处引入 tek 压缩[^9]                                                                                     |
|        | 3       | harib26c |                                |                                                                                                           |
|        | 4       | harib26d |                                |                                                                                                           |
|        | 5       | harib26e |                                |                                                                                                           |
| 30 day | 1       | harib27a |                                |                                                                                                           |
|        | 2       | harib27b |                                |                                                                                                           |
|        | 3       | harib27c |                                |                                                                                                           |
|        | 4       | harib27d |                                |                                                                                                           |
|        | 5       | harib27e |                                | 从此 ipl20->ipl09                                                                                         |
|        | 6       | harib27f |                                |                                                                                                           |

[^1]: 见 utils/libc.
[^3]: The position of bootpack.obj when linking into haribote.sys.
[^4]: Need to check what's the cause of this issue. kernel.ld?
[^5]: JMP location.
[^6]: 运行 a 后不返回提示符
[^7]:

```sh
gcc -Wall -Wno-format -Wno-unused -std=gnu99 -fno-pie -m32 -fleading-underscore -c bug1.c -o bug1.obj
ld -m elf_i386 --oformat binary -e HariMain --oformat binary bug1.obj a_nask.obj -o bug1.hrb
ld: warning: cannot find entry symbol HariMain; defaulting to 0000000008048000
ld: bug1.obj: in function `_HariMain':
bug1.c:(.text+0x69): undefined reference to `___stack_chk_fail'
make: *** [Makefile:122: bug1.hrb] Error 1
```

Add compile flag `-fno-stack-protector` to let it pass.

[^8]:

```sh
ld: section .data VMA [0000000000000400,000000000000053f] overlaps section .text VMA [0000000000000030,0000000000000647]
```

hour is not displayed.

winhelo doesn't work.

[^9]:

```sh
30day-os-rpi/projects/29_day/harib26b/haribote$ make
gcc -fleading-underscore -ffreestanding -fno-stack-protector -nostdlib -nostdinc -nostartfiles -Wall -fno-pie -m32 -mtune=i486 -march=i486 -masm=intel -I../../../../utils -I ../../../../utils/libc/include -c tek.c -o tek.obj
tek.c:2:10: fatal error: setjmp.h: No such file or directory
    2 | #include <setjmp.h>
      |          ^~~~~~~~~~
compilation terminated.
make: *** [Makefile:104: tek.obj] Error 1
```
