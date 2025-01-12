Pousser vers plusieurs référentiels git
===

1. Ajout de plusieurs référentiels
```shell
zami3l# git remote set-url --add --push origin git@github.com:user/original-repo.git
zami3l# git remote set-url --add --push origin git@codeberg.org:user/new-ref-repo.git
```

2. Vérification
```shell
zami3l# git remote -v
origin  git@github.com:user/original-repo.git (fetch)
origin  git@github.com:user/original-repo.git (push)
origin  git@codeberg.org:user/new-ref-repo.git (push)
```

2. Push
```shell
zami3l# git push
```
