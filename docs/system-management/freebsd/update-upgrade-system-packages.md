Updating and Upgrading FreeBSD
===

### 0. Description
FreeBSD : **FreeBSD 13.0-RELEASE-p2 amd64**  
[Wiki FreeBSD English](https://docs.freebsd.org/en/books/handbook/cutting-edge/)  
[Wiki FreeBSD French](https://docs.freebsd.org/fr/books/handbook/cutting-edge/)  

### 1. Applying Security Patches
```shell
freebsd# freebsd-update fetch
freebsd# freebsd-update install
```

If anything goes wrong, freebsd-update has the ability to roll back the last set of changes.
```shell
freebsd# freebsd-update rollback
Uninstalling updates... done.
```
### 2. Updating and Apply all packages packages

```shell
freebsd# pkg update
freebsd# pkg upgrade
```

### 3. Verify FreeBSD version
```shell
freebsd# freebsd-version
13.0-RELEASE-p3
```
