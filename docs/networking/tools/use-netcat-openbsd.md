# Netcat-OpenBSD

### 1. Installation

```shell
$ pacman -S openbsd-netcat
```

### 2. Utilisation

-  Test port
```shell
root@openbsd# nc -zv dns.quad9.net 53
Connection to dns.quad9.net (9.9.9.9) 53 port [tcp/domain] succeeded!
```

- Test port via proxy
```shell
root@openbsd# nc -X connect -x proxy.example.net:3128 -zv quad9.net 443
Connection to quad9.net 443 port [tcp/https] succeeded!
```

- Test port via proxy avec authentification
```shell
root@openbsd# nc -X connect -P username -x proxy.example.net:3128 -zv quad9.net 443
Proxy password for username@proxy.example.net:
Connection to quad9.net 443 port [tcp/https] succeeded!
```
