Cryptsetup
===

## Create LUKS partition
```bash
$ cryptsetup --verbose luksFormat --verify-passphrase /dev/sdX1
```

## Initialize and unlock LUKS partition
```bash
$ cryptsetup -v luksOpen /dev/sdX1 volumeEncrypted 
```

## Create a filesystem on device mapper
```bash
$ mkfs.ext4 /dev/mapper/volumeEncrypted
```

## Mount the device mapper on the directory
```bash
$ mkdir /mnt/volumeEncrypted && mount /dev/mapper/volumeEncrypted /mnt/volumeEncrypted
```

## Umount the device mapper
```bash
$ umount /mnt/volumeEncrypted
```

## Lock LUKS partition
```bash
$ cryptsetup -v luksClose volumeEncrypted 
```

## Bonus :

### Retrieve UUID of partitions
```bash
$ lsblk -f
```

### Create a alias for unlock/mount and unmount/lock for LUKS partition
```bash
# Unlock and mount
alias dopen='sudo cryptsetup -v luksOpen /dev/disk/by-uuid/00000000-1111-2222-3333-444444444444 volumeEncrypted && sudo mount --uuid aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee /mnt/private'

# Umount and lock
alias dclose='sudo umount /mnt/private ; sudo cryptsetup -v luksClose volumeEncrypted'
```

Representation of the example above :
```
NAME                    FSTYPE          UUID
sdb
│
├─[...]
│
└─sdb3                  crypto_LUKS     00000000-1111-2222-3333-444444444444              
  └─volumeEncrypted     ext4            aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee
```
