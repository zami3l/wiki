Création thick jail
===

### 1. Préparation environnement jail

- UFS : Création répertoire
```shell
mkdir -p /usr/local/jails/containers/test_jail
```

- Extraction userland
```shell
tar -xf /usr/local/jails/releases/14.0-RELEASE-base.txz -C /usr/local/jails/containers/test_jail --unlink
```

- Ajout fichier pour le fuseau horaire et le serveur DNS
```shell
cp /etc/resolv.conf /usr/local/jails/containers/test_jail/etc/resolv.conf
cp /etc/localtime /usr/local/jails/containers/test_jail/etc/localtime
```

- Application des correctifs
```shell
freebsd-update -b /usr/local/jails/containers/test_jail fetch install
```

### 2. Fichier de configuration jail
La configuration du jail doit être située dans `/etc/jail.conf.d` avec comme nom de fichier celui du jail.
Exemple : `/etc/jail.conf.d/test_jail`

```shell
test_jail {

  # STARTUP/LOGGING
  exec.start = "/bin/sh /etc/rc";
  exec.stop = "/bin/sh /etc/rc.shutdown";
  exec.consolelog = "/var/log/jails/${name}.log";

  # PERMISSIONS
  allow.raw_sockets;
  exec.clean;
  mount.devfs;

  # HOSTNAME/PATH
  host.hostname = "${name}";
  path = "/usr/local/jails/containers/${name}";

  # NETWORK
  interface = vtnet0;
  ip4.addr = 172.0.0.1;

}
```

### 3. Démarrage environnement jail
```shell
sysrc jail_enable="YES"
service jail start test_jail
```


### 4. Exécution commandes
```shell
jexec test_jail ifconfig
pkg -j test_jail install vim
```


### 6. Connexion
```shell
jexec test_jail
```

### 6. Arrêt environnement jail
```shell
service jail stop test_jail
```
