Installation de docker sur ArchLinux
===

### 1. Installation

```shell
arch# pacman -S docker docker-compose
```

### 2. Ajout de l'utilisateur au groupe Docker
**ATTENTION !!** Tout utilisateur ajouté au groupe `docker` peut s'octroyer les droits root.

```shell
arch# usermod -aG docker <USER>
```

### 3. Isolation de l'user namespaces
```shell
arch# vim /etc/docker/daemon.json
{
  "userns-remap": "default"
}
```

```shell
arch# echo "dockremap:165536:65536" >> /etc/subuid
arch# echo "dockremap:165536:65536" >> /etc/subgid
```

### 3. Démarrage du service docker
```shell
arch# systemctl start docker
```

