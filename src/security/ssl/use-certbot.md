Generate certificat ssl with certbot
===

### Install certbot
```shell
$ pkg install py37-certbot
```

### Generate ECDSA certificate let's encrypt
- ECDSA
    ```shell
    $ certbot certonly --key-type ecdsa --cert-name crt-zami3l -d zami3l.com --elliptic-curve secp384r1 --standalone
    ```

- RSA
    ```shell
    $ certbot certonly --key-type rsa --cert-name crt-zami3l -d zami3l.com --rsa-key-size 4096 --standalone
    ```

### List certificates on host
```shell
$ certbot certificat
```

### Change certificates
Example for change elliptic curve from **secp256r1** to **secp384r1** :
```shell
$ certbot renew --key-type ecdsa --elliptic-curve secp384r1 --cert-name crt-zami3l --force-renewal
```

### Revoke certificates
```shell
# Name
$ certbot revoke --cert-name crt-zami3l
# Path
$ certbot revoke --cert-path /usr/local/etc/letsencrypt/live/zami3l.com/cert.pem
```
