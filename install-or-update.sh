#!/bin/bash

DF_DIR=~/.dotfiles_jepemo
OSNAME=
BIN_COMMON_FILES=git-pull-all

function get_os {
  if [ -z "$1" ] || ([ "$1" != "ubuntu" ] && [ "$1" != "arch" ]); then
      echo "You need to specify OS: <ubuntu> or <arch>"
      exit 0
  fi


  OS_NAME=$1
  echo "> Installing for $OS_NAME"
}


function create_dir {
    echo "> Creating dotfiles dir"
    rm -Rf $DF_DIR
    mkdir $DF_DIR
}


function copy_common {
    echo "> Copying common files"
    for f in $BIN_COMMON_FILES; do
      echo ">> Copying $f"
      cp -Rf bin/$f $DF_DIR/bin
    done

    cp -Rf conf/* ~/
}

function copy_os {
  echo "> Copying os files for $$OSNAME"
  if [ "$OSNAME" == "ubuntu" ]; then
    UBUNTU_FILES=bin/ubuntu/*
    for f in $UBUNTU_FILES; do
      echo ">> Copying ubuntu/$f"
      cp -Rf bin/ubuntu/$f $DF_DIR/bin
    done
  fi
}

function add_includes {
  echo "> Adding bash includes"
}


get_os
create_dir
copy_common
copy_os
add_includes
