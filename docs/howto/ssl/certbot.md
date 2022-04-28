Générer des certificats SSL avec CertBot
===

### Installation
- FreeBSD
```shell
# pkg install py37-certbot
```

- OpenBSD
```shell
# pkg_add certbot
```

### Générer un certificat let's encrypt
- ECDSA
```shell
$ certbot certonly --key-type ecdsa --cert-name crt-zami3l -d zami3l.com --elliptic-curve secp384r1 --standalone
```

- RSA
```shell
$ certbot certonly --key-type rsa --cert-name crt-zami3l -d zami3l.com --rsa-key-size 4096 --standalone
```

### Lister les certificats disponibles
```shell
$ certbot certificates
```

### Modifier un certificat existant
Exemple pour modifier un certificat de type `elliptic curve` de **secp256r1** en **secp384r1** :
```shell
$ certbot renew --key-type ecdsa --elliptic-curve secp384r1 --cert-name crt-zami3l --force-renewal
```

### Révoquer un certificat
```shell
# Via le nom
$ certbot revoke --cert-name crt-zami3l
# Via le chemin du certificat
$ certbot revoke --cert-path /usr/local/etc/letsencrypt/live/zami3l.com/cert.pem
```
