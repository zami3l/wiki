Création d'une autorité de certification et d'un certificat signé
===

### Autorité de certification

#### 1. Clé privée
- ECDSA
```shell
openssl ecparam -genkey -name secp521r1 -out RootCA.key
```

- RSA
```shell
openssl genrsa -out ca.key 4096
```

#### 2. Certificat auto-signé
```shell
openssl req -x509 -new -sha512 -nodes -key RootCA.key -days 36500 -out RootCA.crt -subj "/C=FR/O=LAN/OU=Root\ CA/CN=GlobalSign\ Root\ CA"
```

### Certificat signé par un CA

#### 1. Clé privée
- ECDSA
```shell
openssl ecparam -genkey -name secp521r1 -out RootCA.key
```

- RSA
```shell
openssl genrsa -out ca.key 4096
```

#### 2. Demande de signature de certificat
```shell
openssl req -new -sha512 -key firewall-lan.key -nodes -out firewall-lan.csr -subj "/C=FR/O=LAN/CN=firewall.lan"
```

#### 3. Certificat signé
```shell
openssl x509 -req -sha256 -days 36500 -in firewall-lan.csr -CA RootCA.crt -CAkey RootCA.key -CAcreateserial -out firewall-lan.crt
```
