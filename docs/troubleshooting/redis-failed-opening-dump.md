Redis - Failed opening dump.rdb
===

### 1. Erreur

```
Dec 01 00:00:00 openbsd redis[10789]: 1 changes in 3600 seconds. Saving...
Dec 01 00:00:00 openbsd redis[10789]: Background saving started by pid 6676
Dec 01 00:00:00 openbsd redis[6676]: Failed opening the RDB file dump.rdb (in server root dir unknown) for saving: No such file or directory
Dec 01 00:00:00 openbsd redis[10789]: Background saving error
```

### 2. Correction

```shell
openbsd$ redis-cli

127.0.0.1:6379> CONFIG GET dir
1) "dir"
2) "/var/redis"

127.0.0.1:6379> SAVE
OK

127.0.0.1:6379> exit

openbsd$ ls /var/redis
dump.rdb
```
