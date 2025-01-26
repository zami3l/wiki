# Debian Sid

- Change release to `sid`
```shell
sed -i 's/bookworm/sid/g' /etc/apt/sources.list
```

- Update
```shell
apt update
```

- Upgrade
```shell
apt full-upgrade
```
