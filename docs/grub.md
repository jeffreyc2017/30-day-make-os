# GRUB

## Step-by-Step Guide

### Install GRUB

First, install GRUB and GRUB EFI Modules on your Ubuntu system if it’s not already installed:

```sh
sudo apt update
sudo apt install grub2
sudo apt install grub-efi-amd64-bin
```

### Make a bootable USB drive for mac

1. Prepare the USB Drive with GPT Using fdisk

   1. Open fdisk on the USB Drive:

      ```sh
      sudo fdisk /dev/sdX
      ```

   2. Create a New GPT Partition Table:

      Press g to create a new empty GPT partition table.
      Press n to create a new partition.
      Press 1 to select the partition number.
      Press Enter to accept the default first sector.
      Press Enter again to accept the default last sector (to use the entire drive).
      Press t to change the partition type.
      Enter 1 to set the type to EFI (FAT-12/16/32).
      Press w to write the changes and exit fdisk.

   3. Format the Partition as FAT32:

      ```sh
      sudo mkfs.vfat -F 32 /dev/sdX1
      ```

   4. Mount the USB Drive:

      ```sh
      sudo mkdir -p /mnt/usb
      sudo mount /dev/sdX1 /mnt/usb
      ```

2. Write usb.img to a File on the USB Drive

   Copy the usb.img File:

   ```sh
   sudo cp /path/to/usb.img /mnt/usb/usb.img
   ```

3. Install GRUB

   ```sh
   sudo grub-install --target=x86_64-efi --efi-directory=/mnt/usb --boot-directory=/mnt/usb/boot --removable
   ```

4. Configure GRUB

   Create GRUB Configuration:

   ```sh
   sudo nano /mnt/usb/boot/grub/grub.cfg
   ```

5. Add the Following Content to grub.cfg:

   ```sh
   menuentry 'Boot usb.img' {
       insmod part_gpt
       insmod fat
       set root='hd0,gpt1'
       loopback loop /usb.img
       chainloader (loop)+1
   }
   ```

   Explanation:

   - insmod part_gpt: Load the GPT partition module.
   - insmod fat: Load the FAT filesystem module.
   - set root='hd0,gpt1': Set the root device to the first GPT partition on the first hard drive.
   - loopback loop /usb.img: Create a loopback device for the usb.img file.
   - chainloader (loop)+1: Chainload the first sector of the loopback device (which should be the boot sector of the usb.img).

6. Unmount the USB Drive

   ```sh
   sudo umount /mnt/usb
   ```

7. Test the USB Drive

   Safely Remove the USB Drive.
   Insert it into Your MacBook Pro and Boot:
   Hold down the Option (⌥) key during startup.
   Select the USB drive from the boot menu.

### For QEMU testing

To create a grub.img file and install GRUB onto it for testing with QEMU, follow these steps:

1. Create a Blank Disk Image:

   ```sh
   dd if=/dev/zero of=grub.img bs=1M count=64
   ```

   This command creates a 64MB blank disk image file named grub.img.

2. Partition the Disk Image:

   Use fdisk to create a partition table:

   ```sh
   fdisk grub.img
   ```

   Inside fdisk, create a new partition:

   - Type o to create a new empty DOS partition table.
   - Type n to create a new partition.
   - Choose p for primary partition.
   - Partition number: 1.
   - First sector: default (just press Enter).
   - Last sector: default (just press Enter).
   - Type a to toggle bootable flag on the new partition.
   - Type w to write changes and exit.

3. Create a Loop Device:

   ```sh

   sudo losetup -fP grub.img
   sudo losetup -l
   ```

   This will list all loop devices and their corresponding files. Note the loop device name (e.g., /dev/loopX).

4. Format the Partition:

   ```sh
   sudo mkfs.vfat /dev/loopXp1
   ```

   This command formats the first partition of the loop device with a FAT32 file system.

5. Mount the Partition:

   ```sh
   sudo mkdir /mnt/grub
   sudo mount /dev/loopXp1 /mnt/grub
   ```

6. Copy `haribote.img` to the USB Image:

   Copy the `haribote.img` file to the root of the mounted partition:

   ```sh
   sudo cp haribote.img /mnt/grub/
   ```

7. Install GRUB:

   ```sh
   sudo grub-install --target=i386-pc --boot-directory=/mnt/grub/boot /dev/loopX
   ```

   This installs GRUB onto the disk image.

8. Create a GRUB Configuration File:

   Create a basic grub.cfg file inside the mounted partition:

   ```sh
   sudo nano /mnt/grub/boot/grub/grub.cfg
   ```

   Add the following content:

   ```sh
   set timeout=5
   set default=0

   menuentry "Haribote OS" {
      insmod fat
      loopback loop0 /haribote.img
      chainloader (loop0)+1
   }
   ```

9. Unmount the Partition:

   ```sh
   sudo umount /mnt/grub
   sudo losetup -d /dev/loopX
   ```

10. Test with QEMU:

    ```sh
    qemu-system-x86_64 -drive format=raw,file=grub.img
    ```

    This should boot the grub.img file using QEMU, and you should see the GRUB menu with the "Test Entry".
