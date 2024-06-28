# 默认目标
all: helloos.img

# 编译 ipl.bin

ipl.bin: ipl.nas
	nasm -f bin -o ipl.bin ipl.nas -l ipl.lst

# 生成 helloos.img

img: helloos.img

helloos.img: ipl.bin
	dd if=ipl.bin of=helloos.img bs=512 count=1 conv=notrunc

# 运行 QEMU

run: helloos.img
	qemu-system-x86_64 -drive file=helloos.img,format=raw

# 清理生成文件

clean:
	-rm -f ipl.bin

# 清理源代码以外的文件

src_only: clean
	-rm -f helloos.img
