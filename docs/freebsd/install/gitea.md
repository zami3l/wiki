Configuration de Gitea
===

### 0. Versions

FreeBSD : **13.0**  
MariaDB : **10.5.10**  
Gitea : **1.14.3**

### 1. Préparation

- Connexion à la base de données
```shell
$ mysql -u root -p
```
- Création de l'utlisateur gitea
```sql
> SET old_passwords=0;
> CREATE USER 'gitea'@'localhost' IDENTIFIED BY 'MY_PASSWORD';
```

- Paramétrage de l'encodage
```sql
> CREATE DATABASE giteadb CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
```

- Ajout des privilèges
```sql
> GRANT ALL PRIVILEGES ON giteadb.* TO 'gitea'@'localhost';
> FLUSH PRIVILEGES;
```

- Test de connexion
```shell
$ mysql -u gitea -h localhost -p giteadb
```

### 2. Installation et Configuration

- Installation des packages
```shell
$ pkg install gitea
```

- Configuration
```shell
$ vim /usr/local/etc/gitea/conf/app.ini

[database]
DB_TYPE  = mysql
HOST     = 127.0.0.1:3306
NAME     = giteadb
USER     = gitea
PASSWD   = MY_PASSWORD

[oauth2]
JWT_SECRET = XXXX # 32-bytes string

[repository]
ROOT = /var/db/gitea/gitea-repositories

[security]
INSTALL_LOCK = true
INTERNAL_TOKEN = XXXX # 64-bytes string
SECRET_KEY   = OTHER_PASSWORD

[server]
DOMAIN       = localhost
HTTP_ADDR    = 127.0.0.1
HTTP_PORT    = 3000
ROOT_URL     = http://localhost:3000/
DISABLE_SSH  = false
```

### 3. Activation et démarrage du service

- Activation
```shell
$ sysrc gitea_enable="YES"
gitea_enable:  -> YES
```

- Démarrage
```shell
$ service gitea start
```
