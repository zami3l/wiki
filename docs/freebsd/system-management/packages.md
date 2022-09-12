Gestion des packages
===

- Rechercher packages
```shell
freebsd:~ # pkg search package_name
```

- Lister packages installés
```shell
freebsd:~ # pkg info
```

- Info packages installés
```shell
freebsd:~ # pkg info package_name
```

- Lister les fichiers installés
```shell
freebsd:~ # pkg info -l package_name
```

- Installation packages
```shell
root@bastion:~ # pkg install package_name
```

- Suppression packages
```shell
freebsd:~ # pkg delete package_name
```

- Suppression des dépendances inutilisées
```shell
freebsd:~ # pkg autoremove
```

- Mise à jour des packages
```shell
freebsd:~ # pkg update
freebsd:~ # pkg upgrade
```