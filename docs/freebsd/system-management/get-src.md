Récupération des sources
===

### Vérification version actuelle
```shell
root@freebsd:~ # freebsd-version
13.1-RELEASE-p5
```

### Récupération via git

- Installation de git
```shell
root@freebsd:~ # pkg install git
```

- Clonage du référentiel
```shell
root@freebsd:~ # git clone -b releng/13.1 --depth 1 https://git.freebsd.org/src.git /usr/src/
Cloning into '/usr/src'...
remote: Enumerating objects: 91209, done.
remote: Counting objects: 100% (91209/91209), done.
remote: Compressing objects: 100% (78513/78513), done.
remote: Total 91209 (delta 19235), reused 45297 (delta 9416), pack-reused 0
Receiving objects: 100% (91209/91209), 295.59 MiB | 4.33 MiB/s, done.
Resolving deltas: 100% (19235/19235), done.
Updating files: 100% (87481/87481), done.
```
