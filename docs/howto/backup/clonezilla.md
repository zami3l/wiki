Extract and mount clonezilla backup
===

0. Installation
```shell
pacman -S partclone
```

1. Extract 
```shell
# Create an empty image file
cd /destinationBackup
touch my-backup.img

# Extract the clonezilla files into the image file
cat sda1.ext4-ptcl-img.gz.a* | gzip -d -c | partclone.restore --restore_raw_file -C -s - -O my-backup.img
```

2. Mount
```shell
mount -o loop -t ext4 /destinationBackup/my-backup.img /mnt
```
