Activer socklog
===

Par défaut, VoidLinux n'a pas de système de journalisation. La plupart des distributions possède rsyslog, mais ici nous allons utiliser **socklog**.

### 1. Installation

```shell
xbps-install socklog
```

### 2. Activation

```shell
ln -s /etc/sv/socklog-unix /var/service/
ln -s /etc/sv/nanoklogd /var/service/
```

### 3. Logs

L’arborescence des logs est située ici :
```shell
[root:~]# cd /var/log/socklog
[root:/var/log/socklog]# ls -lrt
total 56
drwxr-s--- 2 root socklog 4096 31 mai   21:41 errors
drwxr-s--- 2 root socklog 4096 31 mai   21:41 debug
drwxr-s--- 2 root socklog 4096 31 mai   21:41 daemon
drwxr-s--- 2 root socklog 4096 31 mai   21:41 cron
drwxr-s--- 2 root socklog 4096 31 mai   21:41 xbps
drwxr-s--- 2 root socklog 4096 31 mai   21:41 user
drwxr-s--- 2 root socklog 4096 31 mai   21:41 tty12
drwxr-s--- 2 root socklog 4096 31 mai   21:41 secure
drwxr-s--- 2 root socklog 4096 31 mai   21:41 remote-udp
drwxr-s--- 2 root socklog 4096 31 mai   21:41 mail
drwxr-s--- 2 root socklog 4096 31 mai   21:41 lpr
drwxr-s--- 2 root socklog 4096  2 juin  09:41 kernel
drwxr-s--- 2 root socklog 4096  2 juin  10:46 everything
drwxr-s--- 2 root socklog 4096  2 juin  10:50 messages
```