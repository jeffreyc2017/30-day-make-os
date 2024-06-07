# ..\z_tools\edimg.exe   imgin:../z_tools/fdimg0at.tek   wbinimg src:ipl.bin len:512 from:0 to:0   imgout:helloos.img
dd if=ipl.bin of=helloos.img bs=512 count=1 conv=notrunc