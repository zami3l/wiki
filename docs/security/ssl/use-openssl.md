How to OpenSSL
===

#### - Visualisation du CSR
```shell
$ openssl req -text -in mydomain.csr -noout -verify
```

#### - Visualisation d'un certificat
```shell
$ openssl x509 -text -in mydomain.crt -noout
```

#### - Conversion CRT to PKCS#12
Extension PKCS#12 : .pfx ou .p12
```shell
$ openssl pkcs12 -export -name "mydomain-pkcs" -inkey mydomain.key -in mydomain.crt -out mydomain.pfx
```
