Create ssl key with Diffie Hellman algorithm
===

### 0. Description
The Diffie-Hellman algorithm is a key exchange algorithm, used in particular when opening a connection to a secure site via SSL / TLS.

### 1. Diffie Hellman Group
Diffie-Hellman Groups are used to determine the strength of the key used in the Diffie-Hellman key exchange process. Higher Diffie-Hellman Group numbers are more secure, but Higher Diffie-Hellman Groups require additional processing resources to compute the key.

| DH Group | Description |
| --- | --- |
| Diffie-Hellman Group 1 | 768-bit group |
| Diffie-Hellman Group 2 | 1024-bit group |
| Diffie-Hellman Group 5 | 1536-bit group |
| Diffie-Hellman Group 14 | 2048-bit group |
| Diffie-Hellman Group 15 | 3072-bit group |
| Diffie-Hellman Group 16 | 4096-bit group |
| Diffie-Hellman Group 17 | 6144-bit group |
| Diffie-Hellman Group 18 | 8192-bit group |
| Diffie-Hellman Group 19 | 256-bit elliptic curve group |
| Diffie-Hellman Group 20 | 384-bit elliptic curve group | 
| Diffie-Hellman Group 21 | 521-bit elliptic curve group |
| Diffie-Hellman Group 24 | 2048-bit, 256 bit subgroup |

### 2. Generate dh 4096 bit
```shell
$ openssl dhparam -text -5 4096 -out dhparam.pem
```
