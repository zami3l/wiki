Rebase commits
===

### Réécrire l'auteur et la signature des commits
```shell
git rebase -r --root --exec 'git commit --amend --no-edit --reset-author -S "$@"'
```

### Ajouter des fichiers oubliés au dernier commit :

- On place les modifications en cours en stash
```shell
git stash push -m "tmp"
```

- On rebase le dernier commit
```shell
git rebase -i HEAD~1
```

- Dans le commit, on modifie `pick` par `edit`

- On est à présent revenue dans le commit, on récupère les fichiers qui sont dans le stash
```shell
git stash show
git checkout stash -- <my_files>
```

- On commit et on valide le rebase
```shell
git add <my_files>
git commit --amend
git rebase --continue
```

- On récupère nos fichiers stash
```shell
git stash pop
```
