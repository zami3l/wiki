Installation de rTorrent sur OpenBSD
===

### 0. Versions

OpenBSD : **6.9**  
rTorrent : **0.9.6**

### 1. Installation

```shell
root@openbsd# pkg_add rtorrent
```

### 2. Configuration

- Création des dossiers nécessaires

Nous allons créer des dossiers pour stocker les téléchargements des torrents, les fichiers .torrent, etc.

```shell
root@openbsd# mkdir -p /seedbox/{download,session,torrent,watch}
```

- Ajout de l'utilisateur dédié

```shell
root@openbsd# useradd -d /seedbox -s /bin/ksh _rtorrent
```

- Copie du fichier de configuration

```shell
root@openbsd# cp /usr/local/share/examples/rtorrent/rtorrent.rc /seedbox/.rtorrent.rc
```

- Changement du propriétaire du dossier seedbox

```shell
root@openbsd# chown -R _rtorrent:wheel /seedbox
```

- Configuration de rtorrent

```shell
root@openbsd# su - _rtorrent
```

On modifie la configuration selon nos besoins :

```
# Aucune limitation de débit
download_rate = 0
upload_rate = 0

# Dossiers par défaut
directory = /seedbox/download
session = /seedbox/session

# Ajout automatique des fichiers *.torrent placés dans /seedbox/watch
schedule = watch_directory,5,5,load_start=/seedbox/watch/*.torrent

# Adresse publique pour les trackers
ip = 189.99.99.99

# Adresse locale pour l'écoute
bind = 10.10.10.2
# Port d'écoute associé
port_range = 62222-62222
port_random = no

# Vérification du hash
check_hash = yes

use_udp_trackers = yes

encryption = allow_incoming,try_outgoing,enable_retry

# Activation du DHT
dht = auto
# Port pour les DHT
dht_port = 63333

peer_exchange = yes
```

### 3. Ouverture des flux firewall

Mon flux passe par mon VPN Mullvad via Wireguard j'ouvre donc mon firewall en conséquence :

```
# Interface wireguard
vpn_if = "wg0"

# Ports
peer_port = "62222"
dth_port = "63333"

# On autorise l'accès des peers
pass in on $vpn_if inet proto udp from any to $vpn_if port $peer_port

# On autorise l'interface vpn à accéder au DHT depuis le port DHT
pass out on $vpn_if inet proto udp from $vpn_if port $dht_port to any
```

### 4. Démarrage de rtorrent

Nous pouvons maintenant déposer dans le dossier `/seedbox/watch` nos fichiers *.torrent.

Et exécuter rtorrent

```shell
_rtorrent@openbsd~ rtorrent
```
