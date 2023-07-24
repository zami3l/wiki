Réplication PostgreSQL
===

### 0. Description
OpenBSD : **7.3**   
PostgreSQL : **15.3**   
IP serveur primaire : **172.0.0.1**   
IP serveur secondaire : **172.0.0.2**   
Type de réplication : **Hot Standby**   

### 1. Serveur primaire

- Installation
```shell
pkg_add postgresql-server
```

- Initialisation base de données
```shell
doas -u _postgresql initdb -D /var/postgresql/data -U postgres -W -A scram-sha-256 -E UTF-8 --locale=fr_FR.UTF-8
```

- Ajout utilisateur réplication
```shell
doas -u _postgresql createuser repuser --replication -P -U postgres
```

- Configuration
`/var/postgresql/data/postgresql.conf` :
```
listen_addresses = 'localhost,172.0.0.1'
wal_level = replica
max_wal_senders = 10
wal_keep_size = 32
synchronous_commit = remote_apply
synchronous_standby_names = '*'
```

`/var/postgresql/data/pg_hba.conf` :
```shell
host    replication     repuser         172.0.0.2/32            scram-sha-256
```

- Démarrage du service
```shell
rcctl enable postgresql
rcctl start postgresql
```

### 2. Serveur secondaire

- Installation
```shell
pkg_add postgresql-server
```

- Récupération base de données du serveur primaire
```Synchronisation
doas -u _postgresql pg_basebackup -R -h 172.0.0.1 -U repuser -D /var/postgresql/data -P
```

- Adapter la configuration du serveur secondaire
```
listen_addresses = 'localhost,172.0.0.2'

hot_standby = on

primary_conninfo = 'host=172.0.0.1 port=5432 user=repuser'
```

- Démarrage du service
```shell
rcctl enable postgresql
rcctl start postgresql
```

### 3. Vérification

```shell
psql -U postres -c "select usename, application_name, client_addr, state, sync_priority, sync_state from pg_stat_replication;"
```