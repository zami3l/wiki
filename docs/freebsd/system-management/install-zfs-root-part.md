Installation avec partition système ZFS
===

### 1. Partionnement
Pendant l'installation de FreeBSD, sélectionner le partionnement `shell`.

- Détruire le schéma des partionnements du disque
```shell
gpart destroy -F ada0
```

- Création du schéma GPT
```shell
gpart create -s gpt ada0
```

- Création des partitions
```shell
gpart add -t freebsd-boot -s 512k -l boot ada0
gpart add -t freebsd-swap -s 4g -l swap ada0
gpart add -t freebsd-zfs -s 10g -l system ada0
```

- Installation du bootloader
```shell
gpart bootcode -b /boot/pmbr -p /boot/gptzfsboot -i 1 ada0
```

### 2. ZFS Setup
- Création zpool `zroot` sur `/`
```shell
zpool create -m / -R /mnt zroot /dev/gpt/system
```
ou
```shell
zpool create -o mountpoint=/ -o altroot=/mnt zroot /dev/gpt/system
```

- Déclaration de l'environnement boot
```shell
zpool set bootfs=zroot zroot
```

### 3. Fstab
Montage automatique et chiffrement du swap via le fstab `/tmp/bsdinstall_etc/fstab`
```shell
# Device                       Mountpoint              FStype  Options         Dump    Pass#
/dev/gpt/swap.eli                 none                    swap    sw              0       0
```

### 4. Installation
Exécuter `exit` pour lancer l'installation.

### 5. Enable ZFS
Avant le redémarrage du serveur (Après l'installation), exécuter :
```shell
 sysrc zfs_enable="YES"
```