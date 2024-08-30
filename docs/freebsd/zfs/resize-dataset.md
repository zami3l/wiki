Redimensionnement dataset
===

- Vérification du volume actuel
```shell
root@freebsd:~ # zfs get volsize zdata/bhyve/debian/system
NAME                     PROPERTY  VALUE    SOURCE
zdata/bhyve/debian/system  volsize   20G      local
```

- Agrandissement
```shell
root@freebsd:~ # zfs set volsize=40G zdata/bhyve/debian/system
```

- Vérification
```shell
root@freebsd:~ # zfs get volsize zdata/bhyve/debian/system
NAME                     PROPERTY  VALUE    SOURCE
zdata/bhyve/debian/system  volsize   40G      local
```
