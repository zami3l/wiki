FreeBSD - Wireless AC 9560 - Failed to load
===

### 1. Erreur

Je dispose d'une carte Intel Wireless AC 9560 sur mon PC MSI qui malgré la version de FreeBSD 13.2 ne fonctionne toujours pas par défaut.

La documentation officielle indique d'utiliser le driver [`iwm`](https://man.freebsd.org/cgi/man.cgi?query=if_iwm&sektion=4) avec cette configuration dans `/boot/loader.conf` :
```shell
if_iwm_load="YES"
iwm9000fw_load="YES"
```

J'obtiens à chaque fois cette erreur :
```shell
iwm0: <Intel(R) Dual Band Wireless AC 9560> mem 0xa4414000-0xa4417fff irq 16 at device 20.3 on pci0
iwm0: fw chunk addr 0x404000 len 712 failed to load
iwm0: iwm_pcie_load_section: Could not load the [0] uCode section
iwm0: iwm_start_fw: failed 60
iwm0: Failed to start INIT ucode: 60
```

Après plusieurs recherches, c'est un bug assez connu sur les cartes Wireless AC 9560 sur les PC MSI :
```
I am not sure if it is a hardware bug for newer intel wireless card, for 9560ac-cnvi and later Gen2 cards, MSI-X interrupt mode is enable by default, Intel wireless drivers on linux/Windows are supported and using MSI-X interrupt default, when rebooting to freebsd, iwm on freebsd only support MSI interrupt but the hardware is configure as MSI-X, so the interrupt will never happened and caused the issue.
Here are two solutions:
1. Implement MSI-X interrupt mode on iwm.
2. Disable MSI-X when init the hardware, and it is the solution what I am using.
```

Le lien vers la discussion : https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=243992

#### 2. Correction

J'ai finalement réussi à faire fonctionner cette carte en utilisant le driver [`iwlwifi`](https://wiki.freebsd.org/WiFi/Iwlwifi) avec cette configuration dans `/etc/rc.conf` :
```shell
wlans_iwlwifi0="wlan0"
ifconfig_wlan0="WPA SYNCDHCP"
# disable iwm - il est initialisé par défaut
devmatch_blocklist="if_iwm"
```

Merci à ce blog qui m'a permis de trouver une solution : https://teletype.in/@alex0x08/freebsd-ac9560-solution