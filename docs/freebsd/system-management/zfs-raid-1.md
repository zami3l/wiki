RAID-1 via ZFS
===

### 1. Ajout partition sur le pool

Nous partons du principe que le système est installé sur un pool d'une partition.  
Le but est d'ajouter une partition pour créer un RAID-1.

#### 1.1. Tableau partionnement

| label | type | size | pool |
| --- | --- | --- | --- |
| boot | freebsd-boot  | 512K |  |
| swap | freebsd-swap | 4G |  |
| system0 | freebsd-zfs | 10G | zroot |

#### 1.2. Visualisation des partitions avec `gpart` :

```shell
root@test-freebsd:~ # gpart show ada0
=>      40  41942960  ada0  GPT  (20G)
        40      1024      1  freebsd-boot  (512K)
      1064   8388608      2  freebsd-swap  (4.0G)
   8389672  20971520      3  freebsd-zfs  (10G)
```

#### 1.3. Visualisation du pool ZFS :

```shell
root@test-freebsd:~ # zpool status
  pool: zroot
 state: ONLINE
  scan: resilvered 254K in 00:00:00 with 0 errors on Wed Dec 00 00:00:00 2999
config:

        NAME           STATE     READ WRITE CKSUM
        zroot          ONLINE       0     0     0
          gpt/system0  ONLINE       0     0     0

errors: No known data errors
```

#### 1.4. Partionnement
Nous allons partitionner le disque `ada1` et ajouter une partition ZFS de 10G. Cette partition système permettra de créer un RAID-1 dans notre pool `zroot`.  

```shell
gpart create -s gpt da1
gpart add -t freebsd-zfs -l system1 -s 10g ada1
```

#### 1.5. Ajout partition au pool
```shell
root@test-freebsd:~ # zpool attach zroot /dev/gpt/system0 /dev/gpt/system1

root@test-freebsd:~ # zpool status
  pool: zroot
 state: ONLINE
  scan: resilvered 1.20G in 00:00:00 with 0 errors on Wed Dec 00 00:00:00 2999
config:

        NAME                   STATE     READ WRITE CKSUM
        zroot                  ONLINE       0     0     0
          mirror-0             ONLINE       0     0     0
            gpt/system0        ONLINE       0     0     0
            gpt/system1        ONLINE       0     0     0

errors: No known data errors
```

### 2. Suppression partition sur le pool
```shell
root@test-freebsd:~ # zpool detach zroot /dev/gpt/system1
```

### 3. Montage du pool à partir d'une clé USB FreeBSD
Dans le cas ou le système ne démarre plus, nous avons la possiblité de monter le pool `zroot` depuis une clé bootable :
```shell
root@usb-freebsd:~ # zpool import -R /mnt zroot
```