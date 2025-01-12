Rsync
===

### Copie
```shell
rsync -az --progress source/ destination/
```

### Synchronisation (Full préservation)
```shell
rsync -axHAWXS --numeric-ids --info=progress2 source/ destination/
```

| Args | Description |
| ---- | ----------- |
| -a | all files, with permissions, etc.. |
| -x | stay on one file system |
| -H | preserve hard links (not included with -a) |
| -A | preserve ACLs/permissions (not included with -a) |
| -W | Disable calculating deltas/diffs of the files |
| -X | preserve extended attributes (not included with -a) |
| -S | handle sparse files efficiently |
| --numeric-ids | avoid mapping uid/gid values by user/group name |
