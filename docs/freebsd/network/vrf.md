# VRF - Virtual routing and forwarding

- Déclaration multi rdomain dans `/boot/loader.conf`  
Le redémarrage est nécessaire pour appliquer les modifications.
   
```shell
net.fibs="2"
```

- Création d'une table de routage

```shell
setfib -F 1 route add default 10.10.10.254
# OU
setfib 1 route add default 10.10.10.254
```

- Visualisation des routes

```shell
setfib 1 netstat -rn
```

- Attribution d'une interface à un domaine de routage

```shell
ifconfig igb0 inet 10.10.10.1 netmask 255.255.255.0 fib 1
```

- Attribution de façon permanente via `/etc/rc.conf` :

```shell
ifconfig_igb0="inet 10.10.10.1 netmask 255.255.255.0 fib 1"
ifconfig_igb0_descr="Interface rdomain 1"

route_default_rdomain1="default 10.10.10.254 -fib 1"
static_routes="default_rdomain1"
```

- Exécution d'une commande depuis une table de routage

```shell
setfib 1 nc -zv mydomain.com 22
```

- Attribution d'une table de routage à un service

```shell
sysrc squid_fib=1
# OU
# Ajouter manuellement la ligne dans /etc/rc.conf
squid_fib=1
```

- Visualisation des processus avec leur table de routage

```shell
ps axu -o fib
```

- Visualiser des connexions réseaux dans une table de routage

```shell
netstat -lan -f inet -F 1
```
