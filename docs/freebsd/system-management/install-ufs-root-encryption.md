Installation avec partition système UFS chiffrée
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
gpart add -t freebsd-boot -l boot -s 512k ada0
gpart add -t freebsd-ufs -l bootfs -s 1g ada0
gpart add -t freebsd-swap -l swap -s 4g ada0
gpart add -t freebsd-ufs -l system ada0
```

- Formatage UFS partition boot
```shell
newfs -U /dev/gpt/bootfs
```

- Installation du bootloader
```shell
gpart bootcode -b /boot/pmbr -p /boot/gptboot -i 1 ada0
```


### 2. Intialisation partition système chiffrée
Attention, l'utilisation des labels GPT (Dans notre cas `/dev/gpt/system`) ne semble pas fonctionner pour monter au démarrage une partition chiffrée. Il est donc nécessaire d'utiliser le nom de la partition (`/dev/ada0p4`).

- Initialisation
```shell
geli init -b -s 4096 /dev/ada0p4
```

- Montage
```shell
geli attach /dev/ada0p4
```

- Formatage UFS
```shell
newfs -U /dev/ada0p4.eli
```

### 3. Montage des partitions pour l'installation
- Partition système
```shell
mount /dev/ada0p4.eli /mnt
```
- Partition boot
```shell
mkdir /mnt/bootfs
# La partition /dev/gpt/bootfs n'est pas chiffrée, elle est nécessaire au démarrage pour FreeBSD
mount /dev/gpt/bootfs /mnt/bootfs
mkdir /mnt/bootfs/boot
ln -s bootfs/boot /mnt/boot
```

### 4. Fstab
Déclarer les partitions à monter au démarrage via le fstab `/tmp/bsdinstall_etc/fstab`.
```shell
# Device			Mountpoint	FStype	Options			Dump	Pass
/dev/gpt/bootfs		/bootfs		ufs		rw,noatime		1		1
/dev/gpt/swap.eli	none		swap	sw				0		0
/dev/ada0p4.eli		/			ufs		rw,noatime		2		2
```

### 5. Loader
Indiquer au système qu'il doit charger geli et le chemin de la partition système dans le fichier `/tmp/bsdinstall_boot/loader.conf`.
```shell
geom_eli_load="YES"
vfs.root.mountfrom="ufs:ada0p4.eli"
```

### 6. Installation
Exécuter `exit` pour lancer l'installation.