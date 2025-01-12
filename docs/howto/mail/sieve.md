Sieve
===

### Exécuter script sieve manuellement
- Sans action
```shell
sieve-filter -u user@domain.com /var/vmail/sieve/script.sieve 'INBOX'
```
- Avec action
```shell
sieve-filter -u user@domain.com -eW /var/vmail/sieve/script.sieve 'INBOX'
```
