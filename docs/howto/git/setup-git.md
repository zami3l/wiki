Setup git
===

0. Installation
```shell
pacman -S git
```

1. Name and Email
```shell
git config --global user.name zami3l
git config --global user.email [My Email]
```

2. Sign commits
```shell
git config --global user.signingkey [Email GPG or ID GPG]

# Automatically sign all commits
git config --global commit.gpgSign true
git config --global tag.gpgSign true
```

3. Alias
```shell
# Alias for commits with sign
# Use : git cs "My commit"
git config --global alias.cs 'commit -m'

# View logs with sign
# Use : git logs
git config --global alias.logs 'log --show-signature'
```
