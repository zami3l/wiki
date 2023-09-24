Configuration VPN Mullvad
===

### 0. Description
Dans cet exemple, nous allons configurer :  
- Un VPN Mullvad avec wireguard  
- Le tunnel WG sera accessible seulement sur le rdomain/fib 1

### 1. Installation

- Installation du package wireguard

```shell
pkg install wireguard
```

- Autorisation du forward (net.inet.ip.forwarding) dans `/etc/rc.conf` :

```shell
gateway_enable="YES"
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

- Transposition du fichier de configuration wireguard dans `/usr/local/etc/wireguard/wg0.conf`

```shell
[Interface]
Table = off
PrivateKey = aAaAaAaAaAaAaAa/bBbBbBbBbBbBbBbBbBbBbBbBbBb=

[Peer]
PublicKey = cCcCcCcCcCcCc/dDdDd/eEeEeEeEeEeEeEeEeEeEeEe=
AllowedIPs = 0.0.0.0/0
Endpoint = 191.91.91.91:51820
```

- Modification des permissions

```shell
chmod 600 /usr/local/etc/wireguard/wg0.conf
```

- Déclaration de l'interface wg0 dans `/etc/rc.conf`

```shell
# Wireguard / Mullvad
wireguard_interfaces="wg0"
ifconfig_wg0="inet 10.10.10.2 netmask 255.255.255.255 fib 1"
ifconfig_wg0_descr="WireGuard VPN Mullvad"
wireguard_enable="YES"
```

- Ajout rdomain/fib dans `/etc/rc.conf`
```shell
route_default_rdomain1="default 10.10.10.2 -fib 1"
static_routes="default_rdomain1"
```
### 4. Démarrage

- Démarrage de l'interface wg0

```shell
service netif restart ; service routing restart
```

- Vérification interface wg0
```shell
wg0: flags=80c1<UP,RUNNING,NOARP,MULTICAST> metric 0 mtu 1420
        description: WireGuard VPN Mullvad
        options=80000<LINKSTATE>
        inet 10.65.227.18 netmask 0xffffffff
        groups: wg
        fib: 1
        nd6 options=109<PERFORMNUD,IFDISABLED,NO_DAD>
```

- Vérification du VPN

```shell
setfib 1 curl https://am.i.mullvad.net/connected
You are connected to Mullvad (server xxxx-wireguard). Your IP address is 155.155.155.155
```
