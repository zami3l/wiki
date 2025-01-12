Generate certificat ssl with certbot
===

### Install certbot
```shell
$ pkg install py37-certbot
```

### Generate ECDSA certificat let's encrypt
- ECDSA
    ```shell
    $ certbot certonly --key-type ecdsa --cert-name zami3l.com -d zami3l.com --elliptic-curve secp256r1 --standalone
    ```

- RSA
    ```shell
    $ certbot certonly --key-type rsa --cert-name zami3l.com -d zami3l.com --rsa-key-size 4096 --standalone
    ```

### List certificat on host
```shell
$ certbot certificat
```
