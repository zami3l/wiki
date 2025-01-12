Rebase commits
===

### Réécrire l'auteur et la signature des commits
```shell
git rebase -r --root --exec 'git commit --amend --no-edit --reset-author -S "$@"'
```