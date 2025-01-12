Configuration UCARP
===

UCARP permet à des hôtes de partager des adresses IP virtuelles communes afin de fournir une IP Failover (Redondance de service pour de la haute disponibilité).   
C'est une alternative aux protocoles VRRP de CISCO et CARP d'OpenBSD.

### 1.  Architecture
Les routeurs **R1** et **R2** sont sous FreeBSD (Plus précisément **BSD Router Project**).

![](network_ucarp.png)

### 2. Configuration routeurs

#### 2.1. Routeur R1

- Système
```shell
sysrc hostname=R1
sysrc ucarp_enable=YES
```

- WAN
```shell
sysrc ifconfig_em0="DHCP"
```

- LAN
```shell
sysrc ifconfig_em1="192.0.0.51/24"
```

- UCARP
```shell
sysrc ucarp_1_if="em1"
sysrc ucarp_1_src="192.0.0.51"
sysrc ucarp_1_pass="passcarp1"
sysrc ucarp_1_preempt="NO"
sysrc ucarp_1_addr="192.0.0.254"
```

- Services
```shell
service netif restart
service routing restart
service ucarp start
```

#### 2.2. Routeur R2

- Système
```shell
sysrc hostname=R2
sysrc ucarp_enable=YES
```

- WAN
```shell
sysrc ifconfig_em0="DHCP"
```

- LAN
```shell
sysrc ifconfig_em1="192.0.0.52/24"
```

- UCARP
```shell
sysrc ucarp_1_if="em1"
sysrc ucarp_1_src="192.0.0.52"
sysrc ucarp_1_pass="passcarp1"
sysrc ucarp_1_preempt="NO"
sysrc ucarp_1_addr="192.0.0.254"
```

- Services
```shell
service netif restart
service routing restart
service ucarp start
```

#### 2.3 Vérification

- R1
```shell
root@r1:~ # ifconfig em1
em1: flags=8863<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> metric 0 mtu 1500
        options=481209b<RXCSUM,TXCSUM,VLAN_MTU,VLAN_HWTAGGING,VLAN_HWCSUM,WOL_MAGIC,VLAN_HWFILTER,NOMAP>
        ether 0c:9f:7f:7b:00:01
        inet 192.0.0.51 netmask 0xffffff00 broadcast 192.0.0.255
        inet 192.0.0.254 netmask 0xffffffff broadcast 192.0.0.254
        inet6 fe80::e9f:7fff:fe7b:1%em1 prefixlen 64 scopeid 0x2
        media: Ethernet autoselect (1000baseT <full-duplex>)
        status: active
        nd6 options=21<PERFORMNUD,AUTO_LINKLOCAL>
```

```shell
root@r1:~ # grep ucarp /var/log/messages
Dec 19 15:50:20 r1 ucarp[68716]: [WARNING] Switching to state: MASTER
Dec 19 15:50:20 r1 ucarp[68716]: [WARNING] Spawning [/usr/local/sbin/ucarp-up em1 192.0.0.254]
```

- R2
```shell
root@r2:~ # ifconfig em1
em1: flags=8863<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> metric 0 mtu 1500
        options=481209b<RXCSUM,TXCSUM,VLAN_MTU,VLAN_HWTAGGING,VLAN_HWCSUM,WOL_MAGIC,VLAN_HWFILTER,NOMAP>
        ether 0c:f1:b9:2b:00:01
        inet 192.0.0.52 netmask 0xffffff00 broadcast 192.0.0.255
        inet6 fe80::ef1:b9ff:fe2b:1%em1 prefixlen 64 scopeid 0x2
        media: Ethernet autoselect (1000baseT <full-duplex>)
        status: active
        nd6 options=21<PERFORMNUD,AUTO_LINKLOCAL>
```

```shell
root@r2:~ # grep ucarp /var/log/messages
Dec 19 15:50:19 r2 ucarp[64677]: [WARNING] Switching to state: BACKUP
Dec 19 15:50:19 r2 ucarp[64677]: [WARNING] Spawning [/usr/local/sbin/ucarp-down em1 192.0.0.254]
```
