## -fleading-underscore

旧版本的 GCC（GNU Compiler Collection）在编译时，为了兼容某些老库，会在符号名前自动添加一个下划线。然而，新版本的 GCC 已经不再默认添加这个下划线。但是，如果需要，可以通过编译选项重新开启这个功能。

要在新版本的 GCC 中启用这个功能，可以使用`-fleading-underscore`编译选项。例如：

```bash
gcc -fleading-underscore -o outputfile sourcefile.c
```

这样，在编译过程中，GCC 会自动在符号名前添加下划线，从而实现与旧库的兼容。

```sh
$ uname -a
Linux raspberrypi 6.6.31+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.31-1+rpt1 (2024-05-29) aarch64 GNU/Linux
```

由于原作是在 Windows 上运行，为避免不可预知的错误，首先对所有文件进行了转换：

```sh
find . -type f -print0 | xargs -0 dos2unix
```

用到的工具：

- nasm
- qemu
- genisoimage

```sh
sudo apt install genisoimage
```

[osdev](https://wiki.osdev.org/Main_Page)

[DISK - READ SECTOR(S) INTO MEMORY](http://www.ctyme.com/intr/rb-0607.htm)

## Cross-compiler

[nasm](https://nasm.us)
[MinGW-w64](https://www.mingw-w64.org/)

## macOS

[mtools](https://formulae.brew.sh/formula/mtools)

```sh
brew install i386-elf-binutils i386-elf-gcc autoconf automake
```

[Grub](https://wiki.osdev.org/GRUB#Installing_GRUB_2_on_OS_X)

```sh
../grub/configure --disable-werror TARGET_CC=x86_64-elf-gcc TARGET_OBJCOPY=x86_64-elf-objcopy \
TARGET_STRIP=x86_64-elf-strip TARGET_NM=x86_64-elf-nm TARGET_RANLIB=x86_64-elf-ranlib --target=x86_64-elf
```

## 像书中那样查看文件行数

```sh
wc *.h *.c -l
```
