Démarrage de mfsBSD
===


### 0. Description

L'un de mes hébergeurs VPS ne propose pas la possiblité d'installer un OS autre que ceux fournit par défaut.
Pour palier ce problème, nous allons ajouter ajouter mfsBSD qui permet de démarrer depuis la RAM.

### 1. Préparation et Démarrage

Ecriture de l'image sur le disque :

```shell
wget --no-check-certificate -qO- https://mfsbsd.vx.sk/files/images/13/amd64/mfsbsd-se-13.2-RELEASE-amd64.img | dd of=/dev/da0 bs=1M
```

Attention, si ecriture depuis un système FreeBSD, il est nécessaire de modifier un paramètre sysctl :

```shell
sysctl kern.geom.debugflags=0x10
```

Nous pouvons à présent redémarrer pour booter sur mfsBSD.

### 2. Démarrage

Login : root
Password : mfsroot

Une fois connecté, ajouter le fichier MANIFEST nécessaire pour l'installation de FreeBSD.

```shell
mkdir /usr/freebsd-dist
cd /usr/freebsd-dist/
fetch https://download.freebsd.org/releases/amd64/13.2-RELEASE/MANIFEST
```

### 3. Installation

Exécuter la commande `bsdinstall` pour démarrer l'installation.
