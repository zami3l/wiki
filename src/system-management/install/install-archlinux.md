# How to install ArchLinux

### 0. Description
Archlinux Current Release : **2021.08.01**  
Firmware type : **UEFI**  
Disks type : **GPT**  
Disk sda : **20G**  
Disk sdb : **40G**  

### 1. Téléchargement
Vous trouverez l'iso d'ArchLinux ici : [Arch Linux](https://www.archlinux.org/download/)

### 2. Préparation de la clé USB bootable
```shell
dd if=/path/archlinux.iso of=/dev/sdx bs=4M
```

### 3. Changement du clavier en fr
```shell
root@archiso ~ # loadkeys fr
```

### 4. Partionnement des disques

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

##### 4.1. Définition de la table de partionnement en GPT
```shell
root@archiso ~ # sgdisk -m /dev/sda
root@archiso ~ # sgdisk -m /dev/sdb
```

##### 4.2 Création des partitions SYS et DATA

| description| disk | partition | type | size |
| --- | --- | --- | --- | --- |
| boot | sda | /dev/sda1 | ef00 | 512M |
| filesystem | sda | /dev/sda2 | 8300 | 19,5G |
| data | sdb | /dev/sdb1 | 8300 | 40G |

```shell
root@archiso ~ # cgdisk /dev/sda
root@archiso ~ # cgdisk /dev/sdb
```


##### 4.3. Création du LVM

| pv | vg | lv | size |
| --- | --- | --- | --- |
| /dev/sda2 | vg_sys | lv_swap | 4G |
| /dev/sda2 | vg_sys | lv_root | 15,5G |
| /dev/sdb1 | vg_data | lv_home | 20G |

###### 4.3.1. Volume physique
```shell
root@archiso ~ # pvcreate /dev/sda2
  Physical volume "/dev/sda2" successfully created.
root@archiso ~ # pvcreate /dev/sdb1
  Physical volume "/dev/sdb1" successfully created.
```

###### 4.3.2. Groupe de volumes
```shell
root@archiso ~ # vgcreate vg_sys /dev/sda2
  Volume group "vg_sys" successfully created
root@archiso ~ # vgcreate vg_data /dev/sdb1
  Volume group "vg_data" successfully created
```

###### 4.3.2. Volume logique
```shell
root@archiso ~ # lvcreate -L 4G -n lv_swap vg_sys
  Logical volume "lv_swap" created.
root@archiso ~ # lvcreate -l 100%FREE -n lv_root vg_sys
  Logical volume "lv_root" created.

root@archiso ~ # lvcreate -l 50%FREE -n lv_home vg_data
  Logical volume "lv_home" created.
```

##### 4.4. Chiffrement et montage de la partition root

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

##### 4.5. Formatage des partitions

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

#### 5. Montage du file systems
```shell
root@archiso ~ # mount /dev/mapper/luks_root /mnt
root@archiso ~ # mkdir /mnt/{boot,home}
root@archiso ~ # mount /dev/sda1 /mnt/boot
```

#### 6. Sélection des mirroirs
Select and Sort the 5 most recently synchronized https mirrors in France then sort them by speed and finally save the result in /etc/pacman.d/mirrorlist:
```shell
root@archiso ~ # reflector --verbose --country 'France' -l 3 -p https --sort rate --save /etc/pacman.d/mirrorlist
[2021-08-16 00:00:00] INFO: rating 3 mirror(s) by download speed
[2021-08-16 00:00:00] INFO: Server                                             Rate       Time
[2021-08-16 00:00:00] INFO: https://XXX/archlinux/   11243.82 KiB/s     0.51 s
[2021-08-16 00:00:00] INFO: https://XXX/archlinux/   11165.54 KiB/s     0.52 s
[2021-08-16 00:00:00] INFO: https://XXX/archlinux/  11249.43 KiB/s     0.51 s
```

#### 7. Installation des packages indispensables
```shell
root@archiso ~ # pacstrap /mnt base base-devel lvm2 cryptsetup linux linux-headers linux-firmware dosfstools grub os-prober efibootmgr
root@archiso ~ # pacstrap /mnt bash-completion vim dhcpcd git
```

#### 8. Génération du fstab
```shell
# Generate fstab
root@archiso ~ # genfstab -U -p /mnt >> /mnt/etc/fstab
```

#### 9. Configuration du système via le chroot
```shell
root@archiso ~ # arch-chroot /mnt
```

##### 9.1. Fuseau horaire
```shell
[root@archiso /]# ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
```

##### 9.2. Localisation

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

###### 9.2.3. Disposition des touches clavier
```shell
[root@archiso /]# echo "KEYMAP=fr-latin9" >> /etc/vconsole.conf
```

#### 10. Configuration réseaux

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

##### 11.1. Chargement lvm et luks
```shell
[root@archiso /]# vim /etc/mkinitcpio.conf
HOOKS=(... lvm2 encrypt udev keyboard keymap)
```

##### 11.2. Installation du kernel
```shell
mkinitcpio -p linux
```

#### 12. Boot loader

##### 12.1. Efivar
- Vérifier si efivar est monté
```shell
[root@archiso /]# mount | grep efivar
efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
```

- Si ce n'est pas le cas :
```shell
[root@archiso /]# mount -t efivarfs efivarfs /sys/firmware/efi/efivars
```

##### 12.2. Grub

###### 12.2.1. Récupération UUID lv_root
```shell
[root@archiso /]# blkid -s UUID -o value /dev/vg_sys/lv_root
00000000-0000-0000-0000-000000000000
```

###### 12.2.2. Configuration
- Uncomment GRUB_ENABLE_CRYPTODISK
- Change GRUB_CMDLINE_LINUX
```shell
[root@archiso /]# vim /etc/default/grub
GRUB_ENABLE_CRYPTODISK=y
GRUB_CMDLINE_LINUX="cryptdevice=UUID=00000000-0000-0000-0000-000000000000:luks_root root=/dev/mapper/luks_root"
```

###### 12.2.3. Installation
```shell
[root@archiso /]# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch_grub --recheck
Installing for x86_64-efi platform.
Installation finished. No error reported.
```

###### 12.2.3. Génération
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

#### 13. Configuration de la partition lv_home

##### 13.1. Génération key file pour la partition lv_home
```shell
[root@archiso /]# mkdir -m 700 /etc/luks-keys

[root@archiso /]# dd if=/dev/random of=/etc/luks-keys/home bs=1 count=256 status=progress
256+0 records in
256+0 records out
256 bytes copied, 0.000772168 s, 332 kB/s
```

##### 13.2. Chiffrement (avec key file) et montage de la partition lv_home

###### 13.2.1. Chiffrement
```shell
[root@archiso /]# cryptsetup luksFormat -v /dev/vg_data/lv_home /etc/luks-keys/home

WARNING!
========
This will overwrite data on /dev/vg_data/lv_home irrevocably.

Are you sure? (Type 'yes' in capital letters): YES
Key slot 0 created.
Command successful.
```

###### 13.2.2. Montage
```shell
[root@archiso /]# cryptsetup -d /etc/luks-keys/home open /dev/vg_data/lv_home luks_home
```

##### 13.3. Formatage
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

##### 13.4. Montage lv_home et lv_swap au boot
```shell
[root@archiso /]# vim /etc/crypttab
luks_home /dev/vg_data/lv_home  /etc/luks-keys/home
luks_swap /dev/vg_sys/lv_swap  /dev/urandom  swap,cipher=aes-xts-plain64,size=256

[root@archiso /]# vim /etc/fstab
/dev/mapper/luks_home        /home   ext4        defaults        0       2
/dev/mapper/luks_swap  none   swap   sw  0  0
```

#### 14. Mot de passe root
```shell
[root@archiso /]# passwd
```

#### 15. Maintenant, vous pouvez vous amuser avec ArchLinux =)
```
[root@archiso /]# exit
root@archiso ~ # umount -R /mnt
root@archiso ~ # reboot
```
