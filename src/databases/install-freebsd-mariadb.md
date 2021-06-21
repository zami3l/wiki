Install MariaDB on FreeBSD
===

### 0. Versions
FreeBSD : **13.0**  
MariaDB : **10.5.10**

### 1. Search and install MariaDB server
```shell
$ pkg search mariadb
mariadb105-client-10.5.10      Multithreaded SQL database (client)
mariadb105-server-10.5.10      Multithreaded SQL database (server)

$ pkg install mariadb105-server-10.5.10 mariadb105-client-10.5.10
Updating FreeBSD repository catalogue...
FreeBSD repository is up to date.
All repositories are up to date.
The following 2 package(s) will be affected (of 0 checked):

New packages to be INSTALLED:
        mariadb105-client: 10.5.10
        mariadb105-server: 10.5.10

Number of packages to be installed: 9

The process will require 423 MiB more space.
46 MiB to be downloaded.

Proceed with this action? [y/N]: y
[1/2] Fetching mariadb105-server-10.5.10.txz: 100%   28 MiB   1.2MB/s    00:25
[2/2] Fetching mariadb105-client-10.5.10.txz: 100%    2 MiB 430.6kB/s    00:04
Checking integrity... done (0 conflicting)
[1/2] Installing mariadb105-client-10.5.10...
===> Creating groups.
Creating group 'mysql' with gid '88'.
===> Creating users
Creating user 'mysql' with uid '88'.
===> Creating homedir(s)
[2/2] Extracting mariadb105-client-10.5.10: 100%
```

### 2. Start and Enable service
```shell
# Enable
$ sysrc mysql_enable="YES"
mysql_enable:  -> YES

# Start
$ service mysql-server start
Installing MariaDB/MySQL system tables in '/var/db/mysql' ...
OK
[...]
Starting mysql.
```

### 3. Harden MariaDB
```shell
$ mysql_secure_installation

NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user. If you've just installed MariaDB, and
haven't set the root password yet, you should just press enter here.

Enter current password for root (enter for none):
OK, successfully used password, moving on...

Setting the root password or using the unix_socket ensures that nobody
can log into the MariaDB root user without the proper authorisation.

You already have your root account protected, so you can safely answer 'n'.

Switch to unix_socket authentication [Y/n] n
 ... skipping.

You already have your root account protected, so you can safely answer 'n'.

Change the root password? [Y/n] y
New password:
Re-enter new password:
Password updated successfully!
Reloading privilege tables..
 ... Success!

By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] y
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] y
 ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] y
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n] y
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
```

### 4. Connection test
```shell
$ mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 11
Server version: 10.5.10-MariaDB FreeBSD Ports

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
```

### 5. Checking service listen
```shell
sockstat -4 | grep mysql
mysql    mariadbd   1155  19 tcp4   127.0.0.1:3306        *:*
```

### 6. Limit mysql service to connecting from localhost
```shell
$ sysrc mysql_args="--bind-address=127.0.0.1"
mysql_args: -> --bind-address=127.0.0.1
```

### 7. Restart service for apply changes
```shell
$ service mysql-server restart
Stopping mysql.
Waiting for PIDS: 1155.
Starting mysql.
```
