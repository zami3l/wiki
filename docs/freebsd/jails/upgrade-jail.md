Mise à jour des prisons (jails)
===

### 0. Règles

- Ne pas utiliser **freebsd-update(8)** dans une prison. Il doit être exécuté depuis l'hôte.
- Ne pas mettre à jour une prison vers une version supérieur à celle de l'hôte.

### 1. Vérification version hôte / prison

Depuis le jail, exécuter `uname -UK`   
-U : Noyau jail   
-K : Noyau hôte   
```shell
root@host:~ # uname -UK
1400097 1401000
```

### 2. Mise à jour majeur

```shell
root@host:~ freebsd-update -j myjail --currently-running 14.0-RELEASE -r 14.1-RELEASE upgrade
[...]
To install the downloaded upgrades, run 'freebsd-update [options] install'.
```

```shell
root@host:~ freebsd-update -j myjail install
Installing updates...
Kernel updates have been installed.  Please reboot and run
'freebsd-update [options] install' again to finish installing updates.
```

```shell
root@host:~ bastille restart myjail
[myjail]:
myjail: removed

[myjail]:
myjail: created
```

```shell
root@host:~ freebsd-update -j myjail install
Installing updates...Scanning /usr/local/bastille/jails/forgejo/root/usr/share/certs/untrusted for certificates...
Scanning /usr/local/bastille/jails/forgejo/root/usr/share/certs/trusted for certificates...
 done.
```
