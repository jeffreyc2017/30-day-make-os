# GRUB

## Step-by-Step Guide

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

   1. First, install GRUB and GRUB EFI Modules on your Ubuntu system if it’s not already installed:

      ```sh
      sudo apt update
      sudo apt install grub2
      sudo apt install grub-efi-amd64-bin
      ```

   2. Install GRUB:

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
