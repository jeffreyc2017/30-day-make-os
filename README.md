此项目在 RaspberryPi 5 上运行。

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
