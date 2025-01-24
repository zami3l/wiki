# Chroot

```shell
mount /dev/<DEVICE> /mnt
mount --bind /dev /mnt/dev
mount -t proc /proc /mnt/proc
mount --bind /sys /mnt/sys
mount --bind /run /mnt/run
```
