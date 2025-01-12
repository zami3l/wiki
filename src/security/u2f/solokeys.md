Solokeys
===

## Solo-python

The tool [solo-python](https://github.com/solokeys/solo-python) is use for firmware update.

##### Installation with pip :

```shell
$ python -m pip install solo-python
# OR
$ pip install solo-python
```

The tool is installed here : `$HOME/.local/bin/solo`

##### Commands

```shell
solo ls  # lists all Solo keys connected to your machine
solo version  # outputs version of installed `solo` library and tool

solo key wink  # blinks the LED
solo key verify  # checks whether your Solo is genuine
solo key rng hexbytes  # outputs some random hex bytes generated on your key
solo key version  # outputs the version of the firmware on your key
```

##### Examples
- List
```shell
[zami3l]$ ~/.local/bin/solo ls
:: Solos
/dev/hidraw5: FIDO2 device
```

- Update
```shell
[zami3l]$ ~/.local/bin/solo key update
Wrote temporary copy of firmware-4.1.2.json to /tmp/tmpxxx.json
sha256sums coincide: 000000000000000000000000000000000000000000000000000000
Switching into bootloader mode...
using signature version >2.5.3
erasing firmware...
updated firmware 100%
time: 14.06 s
bootloader is verifying signature...
...pass!

Congratulations, your key was updated to the latest firmware version: 4.1.2
```

- Version solokeys
```shell
[zami3l]$ ~/.local/bin/solo key version
4.1.2 locked
```

