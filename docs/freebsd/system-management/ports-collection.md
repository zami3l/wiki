Ports Collection
===

### 1. Mettre à jour la collection de ports
```shell
# Fetch
$ portsnap fetch
Looking up portsnap.FreeBSD.org mirrors... 4 mirrors found.
Fetching public key from ipv4.aws.portsnap.freebsd.org... done.
Fetching snapshot tag from ipv4.aws.portsnap.freebsd.org... done.
Fetching snapshot metadata... done.
Fetching snapshot generated at Sat Jun 26 02:11:14 CEST 2021:
0d34e8e8159fe8c4117534c25b488185421057c2b6c611          91 MB   53 MBps    02s
Extracting snapshot... done.
Verifying snapshot integrity... done.
Fetching snapshot tag from ipv4.aws.portsnap.freebsd.org... done.
Fetching snapshot metadata... done.
Updating from Sat Jun 26 02:11:14 CEST 2021 to Sat Jun 26 23:07:30 CEST 2021.
Fetching 5 metadata patches... done.
Applying metadata patches... done.
Fetching 0 metadata files... done.
Fetching 158 patches.
(158/158) 100.00%  done.
done.
Applying patches...
done.
Fetching 2 new ports or files... done.

# Extract (Seulement si c'est la première fois)
$ portsnap extract
[...]
Building new INDEX files... done.

# Update
$ portsnap update
```

### 2. Search and install ports
```shell
$ cd /usr/ports

# Search
$ make search name=crowdsec
```

```shell
# Install and clean
$ cd /usr/ports/security/crowdsec
$ make install clean
```

3. Mise à jour des ports

```shell
# Vérifier les packages à mettre à jour
$ pkg version -l "<"

# Ou via portmaster
$ portmaster -L
```

```shell
# Lire le fichier /usr/ports/UPDATING
$ less /usr/ports/UPDATING
```

```shell
# Procéder à la mise à jour
$ portmaster -a
```