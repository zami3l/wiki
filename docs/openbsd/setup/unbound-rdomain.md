# Configuration d'Unbound dans un rdomain

### 0. Descriptions

OpenBSD : **7.3**
Rdomain : **99**

Nous allons exécuter un serveur DNS Unbound dans un [rdomain](https://man.openbsd.org/rdomain.4) spécifique.
Cela pemet d'avoir une séparation des serveurs DNS en fonction des rdomaines configurés.

Actuellement nous avons déjà un serveur DNS qui écoute sur l'interface loopback sur le rdomain 0 :
```shell
root@openbsd:~ # ps axu -o rtable -U _unbound
USER       PID %CPU %MEM   VSZ   RSS TT  STAT   STARTED       TIME COMMAND          RTABLE
_unbound 30354  0.0  1.2 13924 12732 ??  Ic     Mon05PM    0:01.14 /usr/sbin/unboun      0
```

Je dispose également d'une deuxième interface loopback sur le rdomain 99 pour le second serveur DNS.

```shell
root@openbsd:~ # ifconfig lo
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 32768
        index 3 priority 0 llprio 3
        groups: lo
        inet6 ::1 prefixlen 128
        inet6 fe80::1%lo0 prefixlen 64 scopeid 0x3
        inet 127.0.0.1 netmask 0xff000000
lo1: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> rdomain 99 mtu 32768
        index 24 priority 0 llprio 3
        groups: lo
        inet6 ::1 prefixlen 128
        inet6 fe80::1%lo1 prefixlen 64 scopeid 0x18
        inet 127.0.0.1 netmask 0xff000000
```

### 1. Configuration

* Création du fichier de configuration
```shell
root@openbsd:~ # cp /var/unbound/etc/unbound.conf /var/unbound/etc/unbound99.conf
```
Modifier la configuration en fonction de vos besoins.
**Attention à ne pas garder les mêmes sockets, logs, etc. que votre rdomain 0.**

* Déclaration et activation du service 
```shell
root@openbsd:~ # ln -s /etc/rc.d/unbound /etc/rc.d/unbound99
root@openbsd:~ # rcctl enable unbound99
root@openbsd:~ # rcctl set unbound99 rtable 99
root@openbsd:~ # rcctl set unbound99 flags "-c /var/unbound/etc/unbound99.conf"
root@openbsd:~ # rcctl start unbound99
```

### 2. Vérification

Nous avons à présent deux services unbound qui tourne sur 2 rdomain différents.

- Processus
```shell
root@openbsd:~ # ps axu -o rtable -U _unbound
USER       PID %CPU %MEM   VSZ   RSS TT  STAT   STARTED       TIME COMMAND          RTABLE
_unbound 30354  0.0  1.2 13924 12732 ??  Ic     Mon05PM    0:01.15 /usr/sbin/unboun      0
_unbound 50796  0.0  1.2 12292 12380 ??  Ic     Mon11PM    0:00.10 /usr/sbin/unboun      99

```

- Netstat
```shell
root@openbsd:~ # netstat -T99 -f inet -ln
Active Internet connections (only servers)
Proto   Recv-Q Send-Q  Local Address          Foreign Address        TCP-State
tcp          0      0  127.0.0.1.53           *.*                    LISTEN
Active Internet connections (only servers)
Proto   Recv-Q Send-Q  Local Address          Foreign Address
udp          0      0  127.0.0.1.53           *.*
```

- Test
```shell
root@openbsd:~ # route -T99 exec dig A +short google.com @127.0.0.1
```