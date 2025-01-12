# Console série

### 1. Linux

- Piconom avec adaptateur USB <-> RS232
```shell
root@arch# picocom -b 115200 /dev/ttyUSB0
```

### 2. OpenBSD

- cu avec adaptateur USB <-> RS232

```shell
root@obsd# cu -l cuaU0 -s 115200
```
