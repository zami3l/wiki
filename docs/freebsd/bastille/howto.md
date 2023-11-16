Commandes basique
===

### Commandes basique

- Lister les jails crées
```shell
bastille list           # Seulement ceux UP
bastille list -a        # All
```

- Créer un jail à partir de la RELEASE 14.0
```shell
bastille create jail1 14.0-RELEASE 172.0.0.1
```

- Se connecter en console au jail
```shell
bastille console jail1
```

- Editer la configuration du jail
```shell
bastille edit jail1
```

- Gestion du jail
```shell
bastille start jail1
bastille restart jail1
bastille stop jail1
bastille destroy jail1
```

- Renommer un jail
```shell
bastille rename jail1 jail2
```

- Cloner un jail
```shell
bastille clone jail1 jail2 172.0.0.2
```

- Monter/Démonter un répertoire sur un jail
```shell
bastille mount jail1 /data/postgresql /postgresql nullfs rw 0 0
bastille umount jail1 /postgresql
```

- Installation packages depuis l'hôte
```shell
bastille PKG jail1 install vim
```

- Gestion des services depuis l'hôte
```shell
bastille service jail1 openssh start
```

- Exécuter une commande depuis l'hôte
```shell
bastille cmd jail1 ifconfig
```

- Copier un fichier vers un jail
```shell
bastille cp jail1 /etc/pf.conf /etc/pf.conf
```

- Modifier un sysrc depuis l'hôte
```shell
bastille sysrc jail1 openssh_enable="YES"
```
