Installation
===

### 1. Package
```shell
pkg install bastille
```

### 2. Stockage ZFS
Données de bastille stockées dans : `/zroot/bastille`
```shell
zfs create zroot/bastille
```

Déclaration du volume ZFS dans `/usr/local/etc/bastille/bastille.conf`
```shell
## ZFS options
bastille_zfs_enable="YES"
bastille_zfs_zpool="zroot/bastille"
```

### 3. Réseau
Création de l'interface dédiée dans `/etc/rc.conf`
```shell
# Network Bastille
cloned_interfaces=lo1
ifconfig_lo1_name="bastille0"
```

Activation de l'interface loopback
```shell
service netif cloneup
```

### 4. Firewall
Ajout des règles suivantes dans `/etc/pf.conf`
```shell
######################
#      VARIABLES     #
######################

# -------------------#
# interfaces
# -------------------#
ext_if = "vtnet0"

######################
#       TABLES       #
######################
# Tables jails
table <jails> persist

######################
#         NAT        #
######################
# Jails
nat on $ext_if from <jails> to any -> ($ext_if)
rdr-anchor "rdr/*"

######################
#       RULES        #
######################
# Non précisé. A adapter selon vos règles
```
