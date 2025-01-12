Install KVM
===

### 0. Description
- **QEMU** is a generic and open source machine emulator and virtualizer.  
- **Libvirt** is collection of software that provides a convenient way to manage virtual machines and other virtualization functionality, such as storage and network interface management.  
- **Virt-Manager** is a desktop user interface for managing virtual machines through libvirt.  

### 1. Install kvm and management tools
```shell
pacman -S qemu libvirt virt-manager dmidecode
```

### 2. Install network connectivity
```shell
pacman -S iptables-nft dnsmasq bridge-utils
```

### 3. Start libvirtd service
```shell
systemctl start libvirtd
```

### 4. Test connection with virsh
```shell
virsh -c qemu:///system
```
