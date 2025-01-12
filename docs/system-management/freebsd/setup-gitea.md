Install Gitea on FreeBSD
===

### 0. Versions

FreeBSD : **13.0**  
MariaDB : **10.5.10**  
Gitea : **1.14.3**

### 1. Database Preparation

- Connect to database
```shell
$ mysql -u root -p
```
- Create user with password authentication
```sql
> SET old_passwords=0;
> CREATE USER 'gitea'@'localhost' IDENTIFIED BY 'MY_PASSWORD';
```

- Set charset and collation
```sql
> CREATE DATABASE giteadb CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
```

- Grant all privileges on the database to database user created above
```sql
> GRANT ALL PRIVILEGES ON giteadb.* TO 'gitea'@'localhost';
> FLUSH PRIVILEGES;
```

- Test connection to the database with gitea user
```shell
$ mysql -u gitea -h localhost -p giteadb
```

### 2. Install and Configure gitea

- Install pkg packages
```shell
$ pkg install gitea
```

- Configure gitea
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

### 3. Start and Enable service

- Enable
```shell
$ sysrc gitea_enable="YES"
gitea_enable:  -> YES
```

- Start
```shell
$ service gitea start
```
