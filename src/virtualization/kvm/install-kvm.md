Installation de KVM
===

### 0. Description
- **QEMU** est un logiciel libre de machine virtuelle, pouvant émuler un processeur et, plus généralement, une architecture différente si besoin.
- **Libvirt** est une bibliothèque, une API, un daemon et des outils en logiciel libre de gestion de la virtualisation.
- **Virt-Manager** est une interface graphique de gestion de machines virtuelles.

### 1. Installation de kvm et des outils de managements et de connectivités réseaux
```shell
pacman -S qemu libvirt virt-manager dmidecode iptables-nft dnsmasq bridge-utils
```

### 2. Démarrage du service libvirtd
```shell
archlinux# systemctl start libvirtd
```

### 3. Test de connexion avec virsh
```shell
archlinux# virsh -c qemu:///system
```
