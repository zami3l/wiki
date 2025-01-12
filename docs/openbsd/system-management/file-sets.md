# Installer un ensemble de packages après installation

### 0. Descriptions
Architecture : **AMD64**  
Version OpenBSD : **6.9**  

Si vous avez oublié d'installer l'un de ces ensembles de fichiers pendant l'installation: 

- compXX.tgz
- manXX.tgz
- gameXX.tgz
- xbaseXX.tgz
- xshareXX.tgz
- xfontXX.tgz
- xservXX.tgz

Vous pouvez les installer soit en bootant sur le CD d'installation OpenBSD et sélectionner "Upgrade" ou bien le faire manuellement.

### 1. Téléchargement

Dans cet exemple, nous allons ajouter les ensembles de packages liés à X11 manuellement.  
On télécharge : xbase69, xshare69, xfont69 et xserver69.  

```shell
openbsd# wget -P /tmp https://cdn.openbsd.org/pub/OpenBSD/`uname -r`/`uname -p`/{xbase69,xshare69,xfont69,xserver69}.tgz
```

### 2. Installation

Il ne nous reste plus qu'à les extraire à la racine d'OpenBSD:  

```shell
openbsd# cd /
openbsd# tar xzvphf /tmp/{xbase69,xshare69,xfont69,xserver69}.tgz
```
