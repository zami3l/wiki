Configuration de Nginx
===

### 0. Versions

OpenBSD : **6.9**  
Nginx : **1.18.0**

### 1. Installation

```shell
root@openbsd# pkg_add nginx
```

### 2. Configuration

- Création des dossiers

```shell
root@openbsd# mkdir -p /etc/nginx/{sites-available,sites-enabled,conf.d,ssl}
```

-> `conf.d` comprends des options en plus pour Nginx. Comme par exemple des options de sécurité.  
-> `site-enabled` comprends des liens symboliques pointant vers `site-available`. Seul les configurations présent dans `site-enabled` sont chargés par Nginx.  
-> `ssl` comprends tous les certificats ssl pour les sites web.  

- Configuration global de Nginx

Attention, ceci n'est qu'un exemple. Il est possible que des options de sécurité soit manquantes.

```shell
root@openbsd# vim /etc/nginx/nginx.com

worker_processes  auto;

events {
    worker_connections  1024;
}

http {

    charset                     utf-8;
    sendfile                    on;
    tcp_nopush                  on;
    tcp_nodelay                 on;
    log_not_found               off;
    client_body_buffer_size     1K;
    client_header_buffer_size   1k;
    client_max_body_size        1k;
    large_client_header_buffers 2 1k;


    # MIME
    include                     mime.types;
    default_type                application/octet-stream;

    # Logging
    access_log                  /var/www/logs/nginx/access.log;
    error_log                   /var/www/logs/nginx/error.log warn;

    # Disable Server Tokens
    server_tokens off;

    # Load conf
    include /etc/nginx/conf.d/*.conf;

    # Load website
    include /etc/nginx/sites-enabled/*;

}
```
- Configuration de sécurité

```shell
root@openbsd# vim /etc/nginx/conf.d/security.conf

# security headers

add_header X-XSS-Protection          "1; mode=block" always;
add_header X-Content-Type-Options    "nosniff" always;
add_header Referrer-Policy           "no-referrer-when-downgrade" always;
add_header Content-Security-Policy   "default-src 'self' http: https: data: blob: 'unsafe-inline'; frame-ancestors 'self';" always;
add_header Permissions-Policy        "interest-cohort=()" always;
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
```

- Configuration SSL

```shell
root@openbsd# vim /etc/nginx/conf.d/ssl_default.conf

# SSL Default

# Ciphers
ssl_protocols TLSv1.2 TLSv1.3;
ssl_prefer_server_ciphers on;
ssl_ciphers EECDH+ECDSA+AESGCM:EECDH+aRSA+AESGCM:EECDH+ECDSA+SHA512:EECDH+ECDSA+SHA384:EECDH+ECDSA+SHA256:ECDH+AESGCM:ECDH+AES256:DH+AESGCM:DH+AES256:RSA+AESGCM:!aNULL:!eNULL:!LOW:!RC4:!3DES:!MD5:!EXP:!PSK:!SRP:!DSS;

# Session
ssl_session_timeout    1d;
ssl_session_cache      shared:SSL:10m;
ssl_session_tickets    off;
```

### 3. Démarrage

```shell
root@openbsd# rcctl enable nginx
root@openbsd# rcctl start nginx
```
