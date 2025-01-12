# How to install ArchLinux

### 0. Description
Archlinux Current Release : **2021.08.01**  
Firmware type : **UEFI**  
Disks type : **GPT**  
Disk sda : **20G**  
Disk sdb : **40G**  

### 1. Download iso
You will find the Archlinux iso here : [Arch Linux](https://www.archlinux.org/download/)

### 2. Prepare an installation on usb
```shell
dd if=/path/archlinux.iso of=/dev/sdx bs=4M
```

### 3. Set the keyboard layout
```shell
root@archiso ~ # loadkeys fr
```

### 4. Partition the disks

```shell
root@archiso ~ # fdisk -l

Disk /dev/sda: 20 GiB, 21474836480 bytes, 41943040 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdb: 40 GiB, 42949672960 bytes, 83886080 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop0: 662.07 MiB, 694231040 bytes, 1355920 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```

##### 4.1. Use GPT partition table
```shell
root@archiso ~ # sgdisk -m /dev/sda
root@archiso ~ # sgdisk -m /dev/sdb
```

##### 4.2 Create partition sys and data

| description| disk | partition | type | size |
| --- | --- | --- | --- | --- |
| boot | sda | /dev/sda1 | ef00 | 512M |
| filesystem | sda | /dev/sda2 | 8300 | 19,5G |
| data | sdb | /dev/sdb1 | 8300 | 40G |

```shell
root@archiso ~ # cgdisk /dev/sda
root@archiso ~ # cgdisk /dev/sdb
```


##### 4.3. Create LVM

| pv | vg | lv | size |
| --- | --- | --- | --- |
| /dev/sda2 | vg_sys | lv_swap | 4G |
| /dev/sda2 | vg_sys | lv_root | 15,5G |
| /dev/sdb1 | vg_data | lv_home | 20G |

###### 4.3.1. Physical volume
```shell
root@archiso ~ # pvcreate /dev/sda2
  Physical volume "/dev/sda2" successfully created.
root@archiso ~ # pvcreate /dev/sdb1
  Physical volume "/dev/sdb1" successfully created.
```

###### 4.3.2. Volume group 
```shell
root@archiso ~ # vgcreate vg_sys /dev/sda2
  Volume group "vg_sys" successfully created
root@archiso ~ # vgcreate vg_data /dev/sdb1
  Volume group "vg_data" successfully created
```

###### 4.3.2. Logical volume 
```shell
root@archiso ~ # lvcreate -L 4G -n lv_swap vg_sys
  Logical volume "lv_swap" created.
root@archiso ~ # lvcreate -l 100%FREE -n lv_root vg_sys
  Logical volume "lv_root" created.

root@archiso ~ # lvcreate -l 50%FREE -n lv_home vg_data
  Logical volume "lv_home" created.
```

##### 4.4. Encrypt and Mount root partition

```shell
root@archiso ~ # cryptsetup luksFormat /dev/vg_sys/lv_root

WARNING!
========
This will overwrite data on /dev/vg_sys/lv_root irrevocably.

Are you sure? (Type 'yes' in capital letters): YES
Enter passphrase for /dev/vg_sys/lv_root:
Verify passphrase:
cryptsetup luksFormat /dev/vg_sys/lv_root  15.03s user 4.02s system 69% cpu 27.453 total

root@archiso ~ # cryptsetup open /dev/vg_sys/lv_root luks_root
Enter passphrase for /dev/vg_sys/lv_root:
```

##### 4.5. Format the partitions

```shell
root@archiso ~ # mkfs.fat -F32 /dev/sda1
mkfs.fat 4.2 (2021-01-31)

root@archiso ~ # mkfs.ext4 /dev/mapper/luks_root
mke2fs 1.46.3 (27-Jul-2021)
Creating filesystem with 4058112 4k blocks and 1015808 inodes
Filesystem UUID: 8bbf4ac4-d802-4412-924b-6c528fecf283
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done
```

#### 5. Mount the file systems
```shell
root@archiso ~ # mount /dev/mapper/luks_root /mnt
root@archiso ~ # mkdir /mnt/{boot,home}
root@archiso ~ # mount /dev/sda1 /mnt/boot
```

#### 6. Select the mirrors
```shell
# Select and Sort the 5 most recently synchronized https mirrors in France then sort them by speed and finally save the result in /etc/pacman.d/mirrorlist:
root@archiso ~ # reflector --verbose --country 'France' -l 3 -p https --sort rate --save /etc/pacman.d/mirrorlist
[2021-08-16 00:00:00] INFO: rating 3 mirror(s) by download speed
[2021-08-16 00:00:00] INFO: Server                                             Rate       Time
[2021-08-16 00:00:00] INFO: https://XXX/archlinux/   11243.82 KiB/s     0.51 s
[2021-08-16 00:00:00] INFO: https://XXX/archlinux/   11165.54 KiB/s     0.52 s
[2021-08-16 00:00:00] INFO: https://XXX/archlinux/  11249.43 KiB/s     0.51 s
```

#### 7. Install essential packages
```shell
root@archiso ~ # pacstrap /mnt base base-devel lvm2 cryptsetup linux linux-headers linux-firmware dosfstools grub os-prober efibootmgr
root@archiso ~ # pacstrap /mnt bash-completion vim dhcpcd git
```

#### 8. Generate fstab
```shell
# Generate fstab
root@archiso ~ # genfstab -U -p /mnt >> /mnt/etc/fstab
```

#### 9. Go to chroot to configure the system !!
```shell
root@archiso ~ # arch-chroot /mnt
```

##### 9.1. Time zone
```shell
[root@archiso /]# ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
```

##### 9.2. Localization

###### 9.2.1. Locales
```shell
# Select fr_FR.UTF-8 UTF-8
[root@archiso /]# vim /etc/locale.gen

[root@archiso /]# locale-gen
Generating locales...
  fr_FR.UTF-8... done
Generation complete.
```

###### 9.2.2. LANG variable
```shell
[root@archiso /]# echo -e "LANG=fr_FR.UTF-8 \nLC_COLLATE=C" >> /etc/locale.conf
```

###### 9.2.3. Keyboard layout
```shell
[root@archiso /]# echo "KEYMAP=fr-latin9" >> /etc/vconsole.conf
```

#### 10. Network configuration

##### 10.1. Hostname
```shell
# Set hostname
[root@archiso /]# echo "fsociety" >> /etc/hostname
```

##### 10.2. Hosts
```shell
[root@archiso /]# vim /etc/hosts
127.0.0.1	localhost
::1		localhost
```

#### 11. Initramfs

##### 11.1. Activate lvm and luks for mkinitcpio
```shell
[root@archiso /]# vim /etc/mkinitcpio.conf
HOOKS=(... lvm2 encrypt udev keyboard keymap)
```

##### 11.2. Install kernel
```shell
mkinitcpio -p linux
```

#### 12. Boot loader

##### 12.1. Efivar
- Check if efivar mounted
```shell
[root@archiso /]# mount | grep efivar
efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
```

- If not mount
```shell
[root@archiso /]# mount -t efivarfs efivarfs /sys/firmware/efi/efivars
```

##### 12.2. Grub

###### 12.2.1. Get UUID lv_root
```shell
[root@archiso /]# blkid -s UUID -o value /dev/vg_sys/lv_root
00000000-0000-0000-0000-000000000000
```

###### 12.2.2. Configure
- Uncomment GRUB_ENABLE_CRYPTODISK
- Change GRUB_CMDLINE_LINUX
```shell
[root@archiso /]# vim /etc/default/grub
GRUB_ENABLE_CRYPTODISK=y
GRUB_CMDLINE_LINUX="cryptdevice=UUID=00000000-0000-0000-0000-000000000000:luks_root root=/dev/mapper/luks_root"
```

###### 12.2.3. Install
```shell
[root@archiso /]# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch_grub --recheck
Installing for x86_64-efi platform.
Installation finished. No error reported.
```

###### 12.2.3. Generate
```shell
[root@archiso /]# grub-mkconfig -o /boot/grub/grub.cfg
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-linux
Found initrd image: /boot/initramfs-linux.img
Found fallback initrd image(s) in /boot:  initramfs-linux-fallback.img
Warning: os-prober will not be executed to detect other bootable partitions.
Systems on them will not be added to the GRUB boot configuration.
Check GRUB_DISABLE_OS_PROBER documentation entry.
Adding boot menu entry for UEFI Firmware Settings ...
done
```

#### 13. Configuration lv_home

##### 13.1. Generate key file luks for lv_home partition
```shell
[root@archiso /]# mkdir -m 700 /etc/luks-keys

[root@archiso /]# dd if=/dev/random of=/etc/luks-keys/home bs=1 count=256 status=progress
256+0 records in
256+0 records out
256 bytes copied, 0.000772168 s, 332 kB/s
```

##### 13.2. Encrypt and Mount lv_home partition with key file

###### 13.2.1. Encrypt
```shell
[root@archiso /]# cryptsetup luksFormat -v /dev/vg_data/lv_home /etc/luks-keys/home

WARNING!
========
This will overwrite data on /dev/vg_data/lv_home irrevocably.

Are you sure? (Type 'yes' in capital letters): YES
Key slot 0 created.
Command successful.
```

###### 13.2.2. Mount
```shell
[root@archiso /]# cryptsetup -d /etc/luks-keys/home open /dev/vg_data/lv_home luks_home
```

##### 13.3. Format the partition
```shell
[root@archiso /]# mkfs.ext4 /dev/mapper/luks_home
mke2fs 1.46.3 (27-Jul-2021)
Creating filesystem with 5237760 4k blocks and 1310720 inodes
Filesystem UUID: d3630024-4072-4ff2-9859-c8844e394c41
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000

Allocating group tables: done
Writing inode tables: done
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done
```

##### 13.4. Mount at boot time lv_home and lv_swap
```shell
[root@archiso /]# vim /etc/crypttab
luks_home /dev/vg_data/lv_home  /etc/luks-keys/home
luks_swap /dev/vg_sys/lv_swap  /dev/urandom  swap,cipher=aes-xts-plain64,size=256

[root@archiso /]# vim /etc/fstab
/dev/mapper/luks_home        /home   ext4        defaults        0       2
/dev/mapper/luks_swap  none   swap   sw  0  0
```

#### 14. Root password
```shell
[root@archiso /]# passwd
```

#### 15. Enjoy with Arch Linux 
```
[root@archiso /]# exit
root@archiso ~ # umount -R /mnt
root@archiso ~ # reboot
```
