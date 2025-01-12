Redimensionnement disque et partitionnement
===

### 0. Description
Après un redimensionnement d'un dataset ZFS, il est nécessaire de corriger la table GPT ainsi qu'agrandir la partition et le système de fichiers.

### 1. Correction table GPT

- Lister les disques
```shell
debian# fdisk -l                      
GPT PMBR size mismatch (41943039 != 83886079) will be corrected by write.
The backup GPT table is not on the end of the device.     
[...]
```

- Correction
```shell
debian# parted
GNU Parted 3.6
Using /dev/nvme0n1
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) print all
Warning: Not all of the space available to /dev/nvme0n1 appears to be used, you can fix the GPT to use all of the space (an extra 41943040 blocks) or continue with the current setting? 
Fix/Ignore? Fix
[...]
(parted) quit
```

### 2. Agrandir une partition

```shell
debian# parted
GNU Parted 3.6
Using /dev/nvme0n1
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) print                                                            
Model: bhyve-NVMe (nvme)
Disk /dev/nvme0n1: 42.9GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name  Flags
 1      1049kB  538MB   537MB   fat32              boot, esp
 2      538MB   20.5GB  19.9GB  ext4

(parted) resizepart 2 100%                                                
Warning: Partition /dev/nvme0n1p2 is being used. Are you sure you want to continue?
Yes/No? yes                                                               
(parted) print                                                            
Model: bhyve-NVMe (nvme)
Disk /dev/nvme0n1: 42.9GB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name  Flags
 1      1049kB  538MB   537MB   fat32              boot, esp
 2      538MB   42.9GB  42.4GB  ext4

(parted) quit
```

### 3. Agrandir le système de fichiers

```shell
debian# /dev/nvme0n1p2
resize2fs 1.47.1 (20-May-2024)
Filesystem at /dev/nvme0n1p2 is mounted on /; on-line resizing required
old_desc_blocks = 3, new_desc_blocks = 5
The filesystem on /dev/nvme0n1p2 is now 10354427 (4k) blocks long.
```