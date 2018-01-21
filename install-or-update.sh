#!/bin/bash

DF_DIR=~/.dotfiles_jepemo


if [ -z "$1" ] || ([ "$1" != "ubuntu" ] && [ "$1" != "arch" ]); then
    echo "You need to specify OS: <ubuntu> or <arch>"
    exit 0
fi


OS_NAME=$1
echo "> Installing for $OS_NAME"


function create_dir {
    rm -Rf $DF_DIR
    mkdir $DF_DIR
}


function copy_common {
    cp -R bin $DF_DIR/bin
}

create_dir
copy_common
