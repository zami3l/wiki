Configuration du VPN Mullvad sur OpenBSD
===

### 0. Description
Dans cet exemple, nous allons configurer un serveur VPS pour :
- Obtenir une interface wireguard avec la configuration générée par Mullvad
- Faire transiter tout le flux du serveur par ce vpn
- Garder un accès SSH sur le serveur sans passer par le VPN

### 1. Installation

- Installation du package wireguard
```shell
root@openbsd# pkg_add wireguard-tools
```

- Autorisation du forward :
```shell
# Temporaire
root@openbsd# sysctl net.inet.ip.forwarding=1
root@openbsd# sysctl net.inet6.ip6.forwarding=1

# Persistant
root@openbsd# echo "sysctl net.inet.ip.forwarding=1" >> /etc/sysctl.conf
root@openbsd# echo "sysctl net.inet6.ip6.forwarding=1" >> /etc/sysctl.conf
```

- Création des dossiers pour les configurations
```shell
root@openbsd# mkdir /etc/wireguard
root@openbsd# chmod 700 /etc/wireguard
```


### 2. Transposition

- Exemple d'un fichier VPN Mullvad généré :

```
[Interface]
PrivateKey = aAaAaAaAaAaAaAa/bBbBbBbBbBbBbBbBbBbBbBbBbBb=
Address = 10.10.10.2/32,aaaa:aaaa:aaaa:aaaa::aaaa:aaaa/128
DNS = 199.80.80.80

[Peer]
PublicKey = cCcCcCcCcCcCc/dDdDd/eEeEeEeEeEeEeEeEeEeEeEe=
AllowedIPs = 0.0.0.0/0,::0/0
Endpoint = 191.91.91.91:51820
```

- Transposition du fichier de configuration wireguard 

```shell
root@openbsd# vim /etc/wireguard/wg0.conf

[Interface]
PrivateKey = aAaAaAaAaAaAaAa/bBbBbBbBbBbBbBbBbBbBbBbBbBb=

[Peer]
PublicKey = cCcCcCcCcCcCc/dDdDd/eEeEeEeEeEeEeEeEeEeEeEe=
AllowedIPs = 0.0.0.0/0,::0/0
Endpoint = 191.91.91.91:51820
```

- Modification des permissions
```shell
root@openbsd# chmod 600 /etc/wireguard/wg0.conf
```

- Création de l'interface wg0

```shell
root@openbsd# vim /etc/hostname.wg0
inet 10.10.10.2 255.255.255.255
up

!/usr/local/bin/wg setconf wg0 /etc/wireguard/wg0.conf
```

### 3. Routage et Firewall

- Script de redirection du flux vers le VPN

L'adresse IP `192.168.1.254` représente la passerelle par défaut.

```shell
root@openbsd# vim /etc/wireguard/enable.sh

#!/bin/sh

route add 191.91.91.91 192.168.1.254
route change default 10.10.10.2
```

- Script de redirection du flux vers la passerelle par défaut

```shell
root@openbsd# vim /etc/wireguard/disable.sh

#!/bin/sh

route change default 192.168.1.254
```

- Ajout du NAT pour le VPN vers le WAN

```shell
root@openbsd# vim /etc/pf.conf

wan_if = "vio0"
vpn_if = "wg0"

match out on $wan_if inet from $vpn_if to any nat-to $wan_if
```

- Autoriser la connexion SSH sur le WAN

Avec cette configuration, si tout le flux est redirigé vers le VPN, la connexion en SSH sur l'adresse IP public du serveur ne fonctionnera plus.  
En effet, la requête arrive sur l'interface `wan_if` mais le serveur répondra sur l'interface `vpn_if`.  

Nous allons donc ajouter une règle pour by-pass le routage par défaut :  

```shell
pass in quick on $wan_if inet proto tcp from any to $wan_if port 22 reply-to 192.168.1.254
```

### 4. Démarrage

- Démarrage de l'interface wg0

```shell
root@openbsd# sh /etc/netstart wg0
```

- Chargement des règles firewall

```shell
root@openbsd# pfctl -f /etc/pf.conf
```

- Routage du flux vers le vpn

```shell
root@openbsd# sh /etc/wireguard/enable.sh
```

- Vérification du routage par défaut 

```shell
openbsd# route get 9.9.9.9
   route to: dns9.quad9.net
destination: 0.0.0.0
       mask: 0.0.0.0
    gateway: 10.10.10.2
  interface: wg0
 if address: 10.10.10.2
   priority: 8 (static)
      flags: <UP,GATEWAY,DONE,STATIC>
     use       mtu    expire
229604956         0         0
```

- Vérification du VPN

```shell
openbsd# curl https://am.i.mullvad.net/connected
You are connected to Mullvad (server xxxx-wireguard). Your IP address is 155.155.155.155
```
