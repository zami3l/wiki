Pousser vers plusieurs référentiels git
===

### Commandes git

1. Ajout de plusieurs référentiels
```shell
$ git remote set-url --add --push origin git@github.com:user/original-repo.git
$ git remote set-url --add --push origin git@codeberg.org:user/new-ref-repo.git
```

2. Vérification
```shell
$ git remote -v
origin  git@github.com:user/original-repo.git (fetch)
origin  git@github.com:user/original-repo.git (push)
origin  git@codeberg.org:user/new-ref-repo.git (push)
```

3. Push
```shell
$ git push
```

### Manuel

Ajout manuel des référentiels via le fichier `.git/config`

```shell
$ vim ~/repo/.git/config

[remote "origin"]
        url = git@github.com:user/original-repo.git
        fetch = +refs/heads/*:refs/remotes/origin/*
        pushurl = git@github.com:user/original-repo.git
        pushurl = git@codeberg.org:user/new-ref-repo.git
```
