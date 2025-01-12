Initialisation de l'environnement jails
===

### 1. Création arborescence

- UFS
```shell
mkdir -p /usr/local/jails/{releases,containers}
```

Le répertoire `releases` contiendra la base/userland FreeBSD et `containers` contiendra les jails.

### 2. Téléchargement userland FreeBSD
```shell
fetch https://download.freebsd.org/ftp/releases/amd64/amd64/14.0-RELEASE/base.txz -o /usr/local/jails/releases/14.0-RELEASE-base.txz
```
