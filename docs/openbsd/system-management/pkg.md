# PKG

- Rechercher package
```shell
pkg_info -Q package_name
```

- Info package
```shell
pkg_info package_name
```

- Lister les packages disponibles pour une mise à jour
```shell
pkg_add -Uuns
```

- Mise à jour des packages
```shell
pkg_add -Uu
```

- Installer package
```shell
pkg_add package_name
```

- Lister package installé
```shell
pkg_info
```

- Lister les fichiers installés
```shell
pkg_info -L package_name
```

- Supprimer package
```shell
pkg_delete package_name
```
