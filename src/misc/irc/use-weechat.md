How to use Weechat
===

### 0. Description
[WeeChat](https://github.com/weechat/weechat) (Wee Enhanced Environment for Chat) is a free chat client, fast and light, designed for many operating systems. It is highly customizable and extensible with scripts.

### 1. Install
- Archlinux
```shell
$ pacman -S weechat
```

### 2. Join a new server
```shell
# Add nameserver
/server add [nameServer] [addressServer]/[portServer]
/save
# Set address
/set irc.server.[nameServer].addresses [addressServer]/[portServer]
# Set ssl
/set irc.server.[nameServer].ssl on
# If you want disable check ssl
/set irc.server.[nameServer].ssl_verify off
# Auto connect
/set irc.server.[nameServer].autoconnect on
# Auto join channel
/set irc.server.[nameServer].autojoin "#XXXXX,#XXXXX"
/save
```

### 3. Configure your identity
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
# Register
/msg nickserv register [MyPassword] [MyEmail]
# Verify email
/msg nickserver verify register zami3l [MyPassCode]
# Identity
/msg nickserv identify [MyPassword]
```

### 5. Create keystore
```shell
# Create passphrase
/secure passphrase [YourPassphrase]
# Set password for server irc
/secure set [nameServerPassword] [YourPassword]
# Use auto identify after connection
/set irc.server.[nameServer].command "/msg nickserver identify ${sec.data.[nameServerPassword]}"
```

### 6. SASL
```shell
# Set username and password
/set irc.server.[nameServer].sasl_username "zami3l"
/set irc.server.[nameServer].sasl_password "${sec.data.[nameServerPassword]}"
```

### 7. Others
```shell
# Protect nick
/msg nickserver set secure on
```

```shell
# Set new password
/msg nickserver set password "MyNewPassword"
```
```shell
# Delete ghost connection
/msg nickserver ghost zami3l "MyPassword"
```

```shell
# Info nick
/msg nickserver info Pseudo
```

```shell
# Set url
/msg nickserver set url MyWebsite
# Set email
/msg nickserver set email MyEmail
```

```shell
# Hide information
/msg nickserver hide email
```

```shell
# Check all settings
/set irc.server.[nameServer].*
```
