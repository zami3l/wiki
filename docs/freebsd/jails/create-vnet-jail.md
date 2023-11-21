Création VNET jail
===

### 1. VNET jail sans fichier de configuration
- Création interface epair (Interconnexion hôte <-> jail)
```shell
ifconfig epair99 create up
ifconfig bridge99 addm epair99a up
```

- Démarrage jail vnet
```shell
jail -c name=test_vnet host.hostname=test_vnet persist vnet vnet.interface=epair99b
```

- Exécution commande
```shell
jexec test_vnet netstat -4rn
```

- Arrêt jail vnet
```shell
jail -R test_vnet
```

- Suppression interface epair
```shell
ifconfig bridge99 deletem epair99a
ifconfig epair99a destroy
```

### 2. VNET jail avec fichier de configuration

- Fichier de configuration

La configuration du jail doit être située dans `/etc/jail.conf.d` avec comme nom de fichier celui du jail.
Exemple : `/etc/jail.conf.d/test_vnet`

```shell
test_vnet {

  # PERSIST
  persist;

  # LOGGING
  exec.consolelog = "/var/log/jails/${name}.log";

  # HOSTNAME/PATH
  host.hostname = "${name}";

  # NETWORK
  vnet;
  vnet.interface  = "epair99b";

  exec.prestart  = "ifconfig epair99 create up";
  exec.prestart  += "ifconfig epair99a up";
  exec.prestart  += "ifconfig bridge99 addm epair99a up";

  exec.start  += "/sbin/ifconfig lo0 127.0.0.1 up";
  exec.start  += "/sbin/ifconfig epair99b up";
  exec.start  += "/sbin/ifconfig epair99b 172.0.0.1/24";

  exec.poststop  = "ifconfig bridge99 deletem epair99a";
  exec.poststop  += "ifconfig epair99a destroy";

}
```

- Démarrage environnement jail
```shell
sysrc jail_enable="YES"
service jail start test_vnet
```

- Exécution commande
```shell
jexec test_vnet ifconfig
```

- Arrêt environnement jail
```shell
service jail stop test_vnet
```
