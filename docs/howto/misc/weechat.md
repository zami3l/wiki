How to use Weechat
===

### 0. Description
[WeeChat](https://github.com/weechat/weechat) (Wee Enhanced Environment for Chat) is a free chat client, fast and light, designed for many operating systems. It is highly customizable and extensible with scripts.

### 1. Installation
- Archlinux
    ```shell
    $ pacman -S weechat
    ```

### 2. Joindre un nouveau serveur
```shell
# Ajouter un serveur
/server add [nameServer] [addressServer]/[portServer]
/save
# Ajouter une addresse serveur
/set irc.server.[nameServer].addresses [addressServer]/[portServer]
# Activer ssl
/set irc.server.[nameServer].ssl on
# Désactiver la vérification SSL (Seulement si nécessaire)
/set irc.server.[nameServer].ssl_verify off
# Reconnexion auto au serveur
/set irc.server.[nameServer].autoconnect on
# Connexion auto à X salons
/set irc.server.[nameServer].autojoin "#XXXXX,#XXXXX"
# Sauvegarder
/save
```

### 3. Configurer son identité
```shell
# Set nickname
/set irc.server.[nameServer].nicks "zami3l"
# Set username
/set irc.server[nameServer].username "Zami3l"
# Set real name
/set irc.server.[nameServer].username "Zami3l"
```

### 4. NickServer
```shell
# S'enregistrer
/msg NickServ register [MyPassword] [MyEmail]
# Vérifier son email
/msg NickServ verify register zami3l [MyPassCode]
# S'authentifier
/msg NickServ identify [MyPassword]
```

### 5. Créer son coffre-fort
```shell
# Créer sa passphrase
/secure passphrase [YourPassphrase]
# Set password
/secure set [nameServerPassword] [YourPassword]
# S'authentifier automatiquement après la connexion
/set irc.server.[nameServer].command "/msg NickServ identify ${sec.data.[nameServerPassword]}"
```

### 6. SASL
```shell
# Set username et password
/set irc.server.[nameServer].sasl_username "zami3l"
/set irc.server.[nameServer].sasl_password "${sec.data.[nameServerPassword]}"
```

### 7. Autres
- Protéger son username
```shell
/msg NickServ set secure on
```

- Configurer son password
```shell
/msg NickServ set password "MyNewPassword"
```

- Supprimer le ghost connexion
```shell
/msg NickServ ghost zami3l "MyPassword"
```

- Voir les informations username
```shell
/msg NickServ info Pseudo
```

- Ajouter URL et email
```shell
# Set url
/msg NickServ set url MyWebsite
# Set email
/msg NickServ set email MyEmail
```

- Cacher son email
```shell
/msg NickServ hide email
```

- Afficher la configuration du serveur
```shell
/set irc.server.[nameServer].*
```

- Encodage
```shell
# Voir la configuration
/charset
# Set encodage
/set charset.default.decode "ISO-8859-15"
```