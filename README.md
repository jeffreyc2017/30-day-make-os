# 30dayMakeOS

## 项目目标

《30 天自制操作系统》书中的代码在 windows 环境下开发，并使用了作者定制的工具。本项目的目标是能够在 Linux 环境下（包括 x86 和 ARM CPU，即 Intel/AMD CPU 和 Raspberry Pi）也可以运行并验证书中代码，

### 预置条件

1. 原代码的目标机器是 32 位 x86 CPU;
   > 本书以 IBM PC/AT 兼容机（也就是所谓的 Windows 个人电脑）为对象进行说明。至于其他机型 8，比如 Macintosh（苹果机）或者 PC-9821 等，虽然本书也参考了其中某些部分，但基本上无法开发出在这些机型上运行的操作系统，这一点还请见谅。严格地说，不是所有能称为 AT 兼容机的机型都可以开发我们这个操作系统，我们对机器的配置要求是 CPU 高于 386（因为我们要开发 32 位操作系统）。换句话说，只要是能运行 Windows 95 以上操作系统的机器就没有问题，况且现在市面上（包括二手市场）恐怕都很难找到 Windows 95 以下的机器了，所以我们现在用的机型一般都没问题
2. 原代码使用 NASM(Netwide Assembler) syntax;
3. 项目代码中的日文编码为 Japanese(Shift-JIS);
4. 原项目文件为 dos 格式，在 Linux 上需使用 dos2unix 进行文件格式转换。

### 目标效果

1. 尽量保持原代码文件不做变更，仅做必要的修改以使编译通过；
2. 主要的修改在于 Makefile，Makefile 文件结构尽量保持与原有代码中的 Makefile 结构一致；

## 工具

- mtools

```sh
sudo apt install mtools
```

- gcc

RaspberryPi 上需要安装 cross compile 以编译 x86_32 目标代码。

```sh
sudo apt install gcc-i686-linux-gnu g++-i686-linux-gnu
```

- NASM

```sh
sudo apt install nasm
```

- QEMU

```sh
sudo apt install qemu-system
```

- hexedit

```sh
sudo apt install hexedit
```

- hexdump

- VScode extension Hex Editor

## 运行环境

此项目在 RaspberryPi 5 和 x86 Ubuntu 上运行通过。

### RaspberryPi

```sh
$ uname -a
Linux raspberrypi 6.6.31+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.6.31-1+rpt1 (2024-05-29) aarch64 GNU/Linux

$ dos2unix --version
dos2unix 7.4.3 (2022-06-05)
With Unicode UTF-16 support.
With native language support.
With support to preserve the user and group ownership of files.
LOCALEDIR: /usr/share/locale
http://waterlan.home.xs4all.nl/dos2unix.html

$ mtools --version
mtools (GNU mtools) 4.0.32
configured with the following options: enable-xdf disable-vold disable-new-vold disable-debug enable-raw-term

$ nasm -v
NASM version 2.16.01

$ i686-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=i686-linux-gnu-gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc-cross/i686-linux-gnu/12/lto-wrapper
Target: i686-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Debian 12.2.0-14' --with-bugurl=file:///usr/share/doc/gcc-12/README.Bugs --enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++,m2 --prefix=/usr --with-gcc-major-version-only --program-suffix=-12 --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-vtable-verify --enable-plugin --enable-default-pie --with-system-zlib --enable-libphobos-checking=release --without-target-system-zlib --enable-targets=all --enable-multiarch --disable-werror --with-arch-32=i686 --with-multilib-list=m32,m64,mx32 --enable-multilib --with-tune=generic --enable-checking=release --build=aarch64-linux-gnu --host=aarch64-linux-gnu --target=i686-linux-gnu --program-prefix=i686-linux-gnu- --includedir=/usr/i686-linux-gnu/include
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 12.2.0 (Debian 12.2.0-14)

$ qemu-system-x86_64 --version
QEMU emulator version 7.2.9 (Debian 1:7.2+dfsg-7+deb12u5)
Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers
```

### x86 PC

## 资源文件

- [《30 天自制操作系统》](<resources/[30天自制操作系统].(川合秀实).周自恒等.扫描版.pdf>)
- [《30 天自制操作系统》网页版](resources/30天自制操作系统.html)
- [原书 CD 镜像包](resources/《30天自制操作系统》原版-30days-Origin.iso)
