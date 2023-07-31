Création zone DNSSEC avec PowerDNS
===

### 0. Description
OpenBSD : **7.3**   
PowerDNS : **4.7.3**   

### 1. Création zone
- Création
```shell
pdnsutil create-zone domain.org
```

-  Activation DNSSEC
```shell
pdnsutil secure-zone domain.org
```

- Migration NSEC -> NSEC3
```shell
pdnsutil set-nsec3 domain.org '1 0 99 d00d00d'
```
**1** : Hash algorithm (SHA1) si valeur à 1  
**0** : NSEC3 Opt-out si à 1  
**99** : Nombre d'itération pour le hachage (Max : 100)  
**d00d00d**: salt en hexa  (Génération hexa depuis une décimale : `echo 'obase=16 ; 67898055' | bc`)

### 2. Génération clé privée

- Lister les algorithmes
```shell
pdnsutil list-algorithms

DNSKEY algorithms supported by this installation of PowerDNS:
5 - RSASHA1
7 - RSASHA1-NSEC3-SHA1
8 - RSASHA256
10 - RSASHA512
13 - ECDSAP256SHA256
14 - ECDSAP384SHA384
15 - ED25519
```

- Générer les clés KSK et ZSK
```shell
pdnsutil add-zone-key domain.org KSK active unpublished ECDSAP256SHA256
pdnsutil add-zone-key domain.org ZSK active unpublished ECDSAP256SHA256
```

- Lister les DNSKEY
```shell
pdnsutil list-keys domain.org

Zone                          Type Act Pub Size    Algorithm       ID   Location    Keytag
------------------------------------------------------------------------------------------
domain.org                    ZSK  Act     256     ECDSAP256SHA256 4    cryptokeys  1053
domain.org                    KSK  Act Pub 256     ECDSAP256SHA256 2    cryptokeys  8964
domain.org                    KSK  Act     256     ECDSAP256SHA256 3    cryptokeys  12410
```

- Publier les nouvelles DNSKEY
```shell
pdnsutil publish-zone-key domain.org 3
pdnsutil publish-zone-key domain.org 4
```

- Dé-publier l'ancienne
```shell
pdnsutil publish-zone-key domain.org 2
```

- Supprimer les RRSIG
```
pdnsutil deactivate-zone-key domain.org 2
```

- Supprimer la DNSKEY
```shell
pdnsutil remove-zone-key domain.org 2
```

- Vérification
```shell
pdnsutil list-keys domain.org

Zone                          Type Act Pub Size    Algorithm       ID   Location    Keytag
------------------------------------------------------------------------------------------
domain.org                    ZSK  Act Pub 256     ECDSAP256SHA256 4    cryptokeys  1053
domain.org                    KSK  Act Pub 256     ECDSAP256SHA256 3    cryptokeys  12410
```

### 3. Ajouter NS

```shell
pdnsutil add-record domain.org @ NS ns1.domain.org
pdnsutil add-record domain.org @ NS ns2.domain.org
```

### 4. Vérification

```shell
pdnsutil check-zone domain.org
```
Cette commande ne doit renvoyer aucune erreur sur la zone.

### 5. Export

- Exporter la DNSKEY
```shell
pdnsutil export-zone-dnskey domain.org 3

domain.org IN DNSKEY 257 3 13 azertyuiopqsdfghjklmwxcvbnazerty/1234567890AZERTYUIOPQSDFGHJKLMWXCVBNazertyuiopqsdfghj==
```

- Ajouter un enregistrement DNSKEY
```shell
pdnsutil add-record domain.org @ DNSKEY "257 3 13 azertyuiopqsdfghjklmwxcvbnazerty/1234567890AZERTYUIOPQSDFGHJKLMWXCVBNazertyuiopqsdfghj=="
```

- Exporter les DS
```shell
pdnsutil export-zone-ds domain.org

domain.org. IN DS 12410 13 2 1234567890azertyuiopqsdfghjklmwxcvbn1234567890azertyuiopqsdfghjk ; ( SHA256 digest )
domain.org. IN DS 12410 13 4 azertyuiopqsdfghjklmwxcvbn1234567890azertyuiopqsdfghjklmwxcvbn1234567890azertyuiopqsdfghjklmwxcv ; ( SHA-384 digest )
```

Ces enregistrements sont à déclarer sur le site de gestion du domaine. (Par exemple OVH)
