Boot via console série
===

### 0. Description

FreeBSD ne fournit pas d'image disque bootable directement en console de série.  
Il est donc nécessaire de modifier l'image [memdisk](https://download.freebsd.org/releases/amd64/amd64/ISO-IMAGES/13.2/FreeBSD-13.2-RELEASE-amd64-memstick.img).  

Dans cette exemple, je vais démarrer sur l'image memdisk depuis QEMU KVM et ajouter les options nécessaires.  

### 1.  Ajout des options de console série

Depuis la fenêtre d'installation de FreeBSD, sélectionner **shell**.  
Par défaut, la partition racine est montée en lecture seule, il est donc nécessaire d'exécuter la commande suivante :
```shell
mount -u -w /
```

Ajouter ensuite les options de console série :  `/boot/loader.conf`
```shell
boot_serial="YES"
comconsole_speed="115200"
console="comconsole"
```

Si vous souhaitez avoir la console graphique + la console série :  `/boot/loader.conf`
```shell
boot_multicons="YES"
boot_serial="YES"
comconsole_speed="115200"
console="comconsole,vidconsole"
```

Créer ensuite le fichier boot.config : `/boot.config` 
```shell
-P
```

Vous pouvez désormais arrêter le système `halt -p` et copier l'image sur une clé USB. 