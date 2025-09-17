Création de pool
===

### Création basique d'un pool de stockage

```shell
zpool create -o ashift=12 -O atime=off -O compress=lz4 -O acltype=posixacl -O xattr=sa zstorage /dev/sdx
```

- **Ashift :**  
ashift=9 : blocs de 512 octets (2^9)  
ashift=12 : blocs de 4096 octets (4K) → recommandé pour disques modernes  
ashift=13 : blocs de 8192 octets (8K), utile pour certains SSD  

- **Atime (Propriété dataset) :**  
Met à jour la valeur posix `atime` indiquant le dernier accès en lecture d'un fichier.  
Gain de performance si désactivé.  

- **acltype (Propriété dataset) :**  
acltype=off : Pas d'ACL, permission standard de type POSIX (rwxrwxrwx)  
acltype=posixacl : Utilisation des ACL avancés (setfacl, getfacl, etc ...)  
acltype=nfsv4 : Utilisation d'ACL avancés ressemblant à ceux de Windows NTFS  

- **xattr (Propriété dataset) :**  
xattr (Extended attributes) permet d'ajouter des métadonnées supplémentaires à un fichier ou répertoire (Exemple : selinux, ACL samba/windows).  
xattr=off : Pas de support xattr  
xattr=sa : (SA = System attribute), Stockage des xattr directement dans les inodes ZFS, gain de performance  
xattr=dir : Stockage des xattr dans des fichiers cachés, performance plus lente. (Option par défaut sous Linux)  
