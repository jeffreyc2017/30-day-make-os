# copy helloos.img ..\z_tools\qemu\fdimage0.bin
# ..\z_tools\make.exe	-C ../z_tools/qemu
qemu-system-x86_64 -drive file=helloos.img,format=raw