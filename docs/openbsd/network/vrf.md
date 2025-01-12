# VRF - Virtual routing and forwarding

- Création d'une table de routage

```shell
openbsd# route -T 1 add default 10.10.10.254
```

- Visualisation des routes

```shell
openbsd# route -T 1 show
```

- Attribution d'une interface à un domaine de routage

```shell
openbsd# ifconfig vlan100 rdomain 2
```

De façon permenante :
```shell
openbsd# cat hostname.vlan100
rdomain 2
inet 10.10.10.1 255.255.255.0
up

!route -T2 add default 10.10.10.254
```

- Exécution d'une commande depuis une table de routage

```shell
openbsd# route -T 2 exec nc -zv mydomain.com 22
```

- Attribution d'une table de routage à un service

```shell
openbsd# rcctl set squid rtable 2
```

- Visualisation des processus avec leur table de routage

```shell
openbsd# ps axu -o rtable
```

- Visualiser des connexions réseaux dans une table de routage

```shell
openbsd# netstat -lan -f inet -T 2
```
