How to use Veracrypt
===

### 1. Create a keyfile (Recommended)
```shell
$ veracrypt -t --create-keyfile
```

### 2. Create a new veracrypt volume (mode interactive)
- Whitout keyfile
    ```shell
    $ veracrypt -t -c
    ```

- With keyfile
    ```shell
    $ veracrypt -t -k keyfile.key -c
    ```

### 3. Mount the veracrypt volume
- Whitout keyfile
    ```shell
    $ veracrypt ./encrypt /mnt/encrypt
    ```

- With keyfile
    ```shell
    $ veracrypt -k keyfile ./encrypt /mnt/encrypt
    ```

### 4. Unmount volume
- Specific volume
    ```shell
    $ veracrypt -d encrypt
    ```

- All volumes
    ```shell
    $ veracrypt -d
    ```
