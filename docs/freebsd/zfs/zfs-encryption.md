Chiffrement ZFS
===

### Création volume chiffré
- Via mot de passe
```shell
zfs create -o encryption=on -o keylocation=prompt -o keyformat=passphrase zdata/data_encrypted
```
- Via clé HEX
```shell
openssl rand -hex 32 > /etc/keys/keyfile
zfs create -o encryption=on -o keylocation=file:///etc/keys/keyfile -o keyformat=hex zdata/data_encrypted
```
- Via clé RAW
```shell
truncate -s 32 /etc/keys/keyfile
zfs create -o encryption=on -o keylocation=file:///etc/keys/keyfile -o keyformat=raw zdata/data_encrypted
```

### Affichage des informations du volume
```shell
root@test-freebsd:~ # zfs get name,encryption,keylocation,keyformat zdata/encrypted
NAME                  PROPERTY     VALUE            SOURCE
zdata/data_encrypted  name         zdata/encrypted  -
zdata/data_encrypted  encryption   aes-256-gcm      -
zdata/data_encrypted  keylocation  prompt           local
zdata/data_encrypted  keyformat    passphrase       -
```

### Démontage
```
zfs umount zdata/data_encrypted
```

### Déchargement clé de chiffrement
```shell
zfs unload-key zdata/data_encrypted
```

### Chargement clé de chiffrement
```shell
zfs load-key zdata/data_encrypted
```

### Lister l'état des volumes
```shell
root@test-freebsd:~ # zfs list -o name,mounted
NAME                                            MOUNTED
zdata                                           no
zdata/data_encrypted                                 no
zroot                                           yes
```

### Montage
```shell
zfs mount zdata/data_encrypted
```