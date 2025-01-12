#!/usr/bin/env bash

# ----------------
# ----- Args -----
# ----------------
while getopts ":s:d:t:m:" opt; do
  case ${opt} in
    s ) PATH_SRC=${OPTARG};;
    d ) PATH_DEST=${OPTARG};;
    t ) TYPE_FS=${OPTARG};;
    m ) PATH_MOUNT=${OPTARG};;
    * ) usage;;
  esac
done

# ----------------
# -- Functions ---
# ----------------
usage() { 
    echo "Usage: $0 [-s <PATH SOURCE>] [-d <PATH DESTINATION>] [-t <FILESYSTEM TYPE (optionnal)>] [-m <PATH MOUNT (optionnal)>]" 1>&2
    echo "Example: ./extract-clonezilla.sh -s sda1.ext4-ptcl-img.gz.* -d /backup/mybackup.img -t ext4 -m /mnt/mybackup"
    exit 1
}

check_args() {

    if [ -z "$PATH_SRC" ] || [ -z "$PATH_DEST" ]; then
        usage
    else
        DIR_DEST=`dirname $PATH_DEST`
        NAME_DEST=`basename $PATH_DEST`
    fi

    # Echo config
    echo SOURCE: $PATH_SRC
    echo DESTINATION: $PATH_DEST
    if [ -n "${TYPE_FS}" ]; then echo "FILESYSTEM: $TYPE_FS"; fi

}

restore() {

    # Add destination file
    mkdir -p $DIR_DEST
    touch $NAME_DEST

    # Restore backup clonezilla
    cat $PATH_SRC | gzip -d -c | partclone.restore --restore_raw_file -C -s - -O $PATH_DEST

}

mount() {

    if [ -n "$PATH_MOUNT" ]; then

        mkdir -p $PATH_MOUNT

        if [ -n "$TYPE_FS" ]; then
            mount -o loop -t $TYPE_FS $PATH_DEST $PATH_MOUNT
        else
            mount -o loop $PATH_DEST $PATH_MOUNT
        fi

        echo BACKUP MOUNTED : $PATH_MOUNT

    fi

}

# ----------------
# ----- Main -----
# ----------------

# Check and view args
check_args

# Restore backup
restore

# Mount volume
mount
