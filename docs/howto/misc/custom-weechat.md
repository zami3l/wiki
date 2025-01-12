Customization weechat
===

###. Buffers servers independent
```shell
/set irc.look.server_buffer independent
```

### Plugins
- Allow download scripts
```shell
/set script.scripts.download_enabled on
```

- Autosort alphabetical
```shell
# Install
/script install autosort.py
# If you want to manually run it
/autosort
```

- Autojoin
```shell
# Install
/script install autojoin.py
# If you ever want to save your list of joined channels
/autojoin --run
/save
```

- Emoji
```shell
# Install
/script install emoji.lua
```

- List buffer optimized
```shell
# Install
/script install listbuffer.py
```
