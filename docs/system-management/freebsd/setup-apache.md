Configuration d'Apache
===

### 0. Versions
FreeBSD : **13.0**  
Apache : **2.4.48**

### 1. Installation
```shell
$ pkg install apache24
Updating FreeBSD repository catalogue...
FreeBSD repository is up to date.
All repositories are up to date.
Updating database digests format: 100%
Checking integrity... done (0 conflicting)
The following 1 package(s) will be affected (of 0 checked):

New packages to be INSTALLED:
        apache24: 2.4.48

Number of packages to be installed: 1

The process will require 27 MiB more space.

Proceed with this action? [y/N]: y
[1/1] Installing apache24-2.4.48...
===> Creating groups.
Using existing group 'www'.
===> Creating users
Using existing user 'www'.
[1/1] Extracting apache24-2.4.48: 100%
```

### 2. Activation et démarrage du service
```shell
# Enable
$ sysrc apache24_enable="YES"

# Start
service apache24 start
```

### 3. Configuration

- Suppression des informations du service
    ```shell
    $ vim /usr/local/etc/apache24/httpd.conf
    ServerTokens Prod
    ServerSignature Off
    ```

- Suppression des indexes
    ```shell
    # Remove Options Indexes
    $ vim /usr/local/etc/apache24/httpd.conf
    <Directory "/usr/local/www/apache24/data">
        Options FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>
    ```

- Désactivation du Etag
    ```shell
    $ vim /usr/local/etc/apache24/httpd.conf
    FileEtag None
    ```

- Désactivation des traces HTTP
    ```shell
    $ vim /usr/local/etc/apache24/httpd.conf
    TraceEnable off
    ```

- Ajout d'un timeout
    ```shell
    $ vim /usr/local/etc/apache24/httpd.conf
    Timeout 60
    ```
