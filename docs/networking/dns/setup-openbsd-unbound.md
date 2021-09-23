Configuration d'Unbound dans OpenBSD
===

### 0. Descriptions
OpenBSD : **6.9**  
Unbound : **1.13.1**  
Conf Unbound : **/var/unbound/etc/unbound.conf**  

### 1. Architecture

![Exemple d'architecture](../../.img/networking/example_architecture.png)

### 2. Configuration

#### 2.1. Ecoute et Accès

On définit dans un premier temps les interfaces qui serviront de serveur DNS.  
On autorise ensuite les réseaux/hôtes qui pourront utiliser le serveur DNS.  

```shell
server:

        interface: 127.0.0.1            # LOCALHOST
        interface: ::1                  # LOCALHOST
        interface: 192.168.10.254       # LAN
        interface: 192.168.110.254      # INFRA
        interface: 192.168.120.254      # WIFI

        access-control: 0.0.0.0/0 refuse
        access-control: ::0/0 refuse
        access-control: ::1 allow
        access-control: 127.0.0.0/8 allow
        access-control: 192.168.10.254/24 allow
        access-control: 192.168.110.254/24 allow
        access-control: 192.168.120.254/24 allow
```

#### 2.2. Sécurisation

On définit des options liées à la sécurité et confidentialité.

```shell
        # "id.server" and "hostname.bind" queries are refused.
        hide-identity: yes
        # "version.server" and "version.bind" queries are refused.
        hide-version: yes
        # Cache elements are prefetched before they expire to keep the cache up to date.
        prefetch: yes

        # Perform DNSSEC validation.
        auto-trust-anchor-file: "/var/unbound/db/root.key"
        val-log-level: 2

        # Synthesize NXDOMAINs from DNSSEC NSEC chains.
        aggressive-nsec: yes

        # TTL timeout
        cache-min-ttl: 3600
        serve-expired: yes
```

#### 2.3. Déclaration des zones DNS

On déclare deux zones locales : `infra.lan` et `home.lan`

```shell
        local-zone: "infra.lan." static

        local-data: "tv.infra.lan. 86400 IN A 192.168.110.x"
        local-data: "camera.infra.lan. 86400 IN A 192.168.110.x"

        local-zone: "home.lan." static

        local-data: "pc-1.home.lan. 86400 IN A 192.168.10.x"
        local-data: "pc-2.home.lan. 86400 IN A 192.168.10.x"
        local-data: "pc-imprimante.home.lan. 86400 IN A 192.168.10.x"
        local-data: "tablette.home.lan. 86400 IN A 192.168.120.x"
        local-data: "mobile.home.lan. 86400 IN A 192.168.120.x"
```

#### 2.4. Déclaration des zones DNS inverses

On définit également les deux zones inverses.

```shell
        local-data-ptr: "192.168.110.x 86400 tv.infra.lan."
        local-data-ptr: "192.168.110.x 86400 camera.infra.lan."

        local-data-ptr: "192.168.10.x 86400 pc-1.home.lan."
        local-data-ptr: "192.168.10.x 86400 pc-2.home.lan."
        local-data-ptr: "192.168.10.x 86400 imprimante.home.lan."
        local-data-ptr: "192.168.120.x 86400 tablette.home.lan."
        local-data-ptr: "192.168.120.x 86400 mobile.home.lan."
```

### 3. Démarrage du service unbound
```shell
openbsd# rcctl start unbound
```

### 4. Test

On peut tester si notre configuration avec `dig`.

```shell
pc-1# dig tablette.home.lan @192.168.10.254

; <<>> DiG 9.16.20 <<>> tablette.home.lan @192.168.10.254
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 49336
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;tablette.home.lan.            IN      A

;; ANSWER SECTION:
tablette.home.lan.     86400   IN      A       192.168.120.x

;; Query time: 0 msec
;; SERVER: 192.168.10.254#53(192.168.10.254)
;; WHEN: XXX XXX 00 00:00:00 CEST XXXX
;; MSG SIZE  rcvd: 111
```

Même chose avec la zone inverse.

```shell
pc-1# dig -x 192.168.10.x @192.168.10.254

; <<>> DiG 9.16.20 <<>> -x 192.168.10.x
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 55099
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;x.10.168.192.in-addr.arpa.  IN      PTR

;; ANSWER SECTION:
x.10.168.192.in-addr.arpa. 86400 IN  PTR     imprimante.home.lan.

;; Query time: 0 msec
;; SERVER: 192.168.10.254#53(192.168.10.254)
;; WHEN: XXX XXX 00 00:00:00 CEST XXXX
;; MSG SIZE  rcvd: 84
```

### 5. Fichier de configuration

Le fichier de configuration complet :

```shell
openbsd# cat /var/unbound/etc/unbound.conf

server:

        # Logging (default is no).
        # Uncomment this section if you want to enable logging.
        # Note enabling logging makes the server (significantly) slower.
        # verbosity: 2
        # log-queries: yes
        # log-replies: yes
        # log-tag-queryreply: yes
        # log-local-actions: yes

        interface: 127.0.0.1            # LOCALHOST
        interface: ::1                  # LOCALHOST
        interface: 192.168.10.254       # LAN
        interface: 192.168.110.254      # INFRA
        interface: 192.168.120.254      # WIFI

        access-control: 0.0.0.0/0 refuse
        access-control: ::0/0 refuse
        access-control: ::1 allow
        access-control: 127.0.0.0/8 allow
        access-control: 192.168.10.254/24 allow
        access-control: 192.168.110.254/24 allow
        access-control: 192.168.120.254/24 allow

        # "id.server" and "hostname.bind" queries are refused.
        hide-identity: yes
        # "version.server" and "version.bind" queries are refused.
        hide-version: yes
        # Cache elements are prefetched before they expire to keep the cache up to date.
        prefetch: yes

        # Perform DNSSEC validation.
        auto-trust-anchor-file: "/var/unbound/db/root.key"
        val-log-level: 2

        # Synthesize NXDOMAINs from DNSSEC NSEC chains.
        aggressive-nsec: yes

        # TTL timeout
        cache-min-ttl: 3600
        serve-expired: yes

        # Local domain : .infra.lan
        local-zone: "infra.lan." static
        # IPv4
        local-data: "tv.infra.lan. 86400 IN A 192.168.110.x"
        local-data: "camera.infra.lan. 86400 IN A 192.168.110.x"
		# PTR IPv4
        local-data-ptr: "192.168.110.x 86400 tv.infra.lan."
        local-data-ptr: "192.168.110.x 86400 camera.infra.lan."

        # Local domain : .home.lan
        local-zone: "home.lan." static
        # IPv4
        local-data: "pc-1.home.lan. 86400 IN A 192.168.10.x"
        local-data: "pc-2.home.lan. 86400 IN A 192.168.10.x"
        local-data: "pc-imprimante.home.lan. 86400 IN A 192.168.10.x"
        local-data: "tablette.home.lan. 86400 IN A 192.168.120.x"
        local-data: "mobile.home.lan. 86400 IN A 192.168.120.x"
		# PTR IPv4
        local-data-ptr: "192.168.10.x 86400 pc-1.home.lan."
        local-data-ptr: "192.168.10.x 86400 pc-2.home.lan."
        local-data-ptr: "192.168.10.x 86400 imprimante.home.lan."
        local-data-ptr: "192.168.120.x 86400 tablette.home.lan."
        local-data-ptr: "192.168.120.x 86400 mobile.home.lan."

# Enable the usage of the unbound-control command.
remote-control:
        control-enable: yes
        control-interface: /var/run/unbound.sock

```
