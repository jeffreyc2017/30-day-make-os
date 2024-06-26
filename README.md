# 30dayMakeOS on Raspberry Pi

## preconditions

此项目在 RaspberryPi 5 上运行。

1. 尽量保持原代码文件不做变更，仅做必要的修改以使编译通过；
2. 主要的修改在于 Makefile；
3. 原代码的目标机器是 32 位 x86 CPU;
4. 原代码使用 NASM(Netwide Assembler) syntax;
5. 日文编码为 Japanese(Shift-JIS);

## Tools

- mtools

```sh
sudo apt install mtools
```

- i686-linux-gnu

```sh
sudo apt install gcc-i686-linux-gnu g++-i686-linux-gnu
```

## resources

[book](<resources/[30天自制操作系统].(川合秀实).周自恒等.扫描版.pdf>)
[web book](resources/30天自制操作系统.html)
[CD](resources/《30天自制操作系统》原版-30days-Origin.iso)
