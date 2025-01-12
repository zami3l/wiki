# PKG

- Rechercher package
```shell
root@bastion:~ # pkg_info -Q package_name
```

- Info package
```shell
root@bastion:~ # pkg_info package_name
```

- Installer package
```shell
root@bastion:~ # pkg_add package_name
```

- Lister package installé
```shell
root@bastion:~ # pkg_info
```

- Lister les fichiers installés
```shell
root@bastion:~ # pkg_info -L package_name
```

- Supprimer package
```shell
root@bastion:~ # pkg_delete package_name
```
