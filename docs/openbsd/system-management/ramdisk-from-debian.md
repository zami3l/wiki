# Installation d'OpenBSD ramdisk depuis debian

### 0. Descriptions
Bootloader : **GRUB**
Debian : **Bulleyes**
OpenBSD : **7.3**

L'un de mes hébergeurs VPS ne propose pas la possiblité d'installer un OS autre que ceux fournit par défaut.  
Pour palier ce problème, nous allons ajouter une entrée à GRUB pour qu'il puisse démarrer sur le noyau ramdisk d'OpenBSD.

### 1. Téléchargement ramdisk
Depuis le serveur VPS :
```shell
root@debian:~ # cd /
root@debian:/ # wget https://cdn.openbsd.org/pub/OpenBSD/7.3/amd64/bsd.rd
```

### 2. Ajout entrée GRUB
Récupérer le menuentry de Debian situé dans `/boot/grub/grub.cfg` et ajouter le dans `/etc/grub.d/40_custom` : 

```shell
menuentry "openbsd" {
  load_video
  insmod gzio
  if [ x$grub_platform = xxen ]; then insmod xzio; insmod lzopio; fi
  insmod part_gpt
  insmod ext2
  if [ x$feature_platform_search_hint = xy ]; then
    search --no-floppy --fs-uuid --set=root c3fbef87-2f45-4b8e-9d48-6f7c37a06c20
  else
    search --no-floppy --fs-uuid --set=root c3fbef87-2f45-4b8e-9d48-6f7c37a06c20
  fi
  kopenbsd /bsd.rd
}
```

Pour forcer le démarrage par défaut sur l'entrée OpenBSD, modifier la valeur de `GRUB_DEFAULT` dans `/etc/default/grub` : 

```shell
GRUB_DEFAULT="openbsd"
```

Rechargement du GRUB :
```shell
root@debian:/ # update-grub
```

SI aucune erreur est trouvée, vous pouvez redémarrer et commencer l'installation d'OpenBSD !