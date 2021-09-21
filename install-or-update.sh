#!/usr/bin/env bash


# Install

# export DF_DIR=~/src/dotfiles
#export OSNAME=
#export BIN_COMMON_FILES=git-pull-all
#export CONF_FILES=".bash_includes.sh"

#function get_os {
#  if [ -z "$1" ] || ([ "$1" != "ubuntu" ] && [ "$1" != "arch" ]); then
#      echo "You need to specify OS: <ubuntu> or <arch>"
#      exit 0
  # fi


  # OS_NAME=$1
#  echo "> Installing for $OS_NAME"
#}


#function create_dir {
#    echo "> Creating dotfiles dir"
#    rm -Rf $DF_DIR
#    mkdir $DF_DIR
#}


# function copy_common {
#     echo "> Copying common files"
#     mkdir $DF_DIR/bin
#     for f in $BIN_COMMON_FILES; do
#       echo ">> Copying $f to $f $DF_DIR/bin/"
#       cp -Rf bin/$f $DF_DIR/bin/
#     done

#     for f in $CONF_FILES; do
#       echo ">> Copying $f"
#       cp -Rf conf/$f ~/
#     done
# }

# function copy_os {
#   echo "> Copying os files for $OS_NAME"
#   if [ "$OS_NAME" == "ubuntu" ]; then
#     UBUNTU_FILES=bin/ubuntu/*
#     for f in $UBUNTU_FILES; do
#       echo ">> Copying $f to $DF_DIR/bin/"
#       cp -Rf $f $DF_DIR/bin/
#     done
#   fi
# }

# function add_includes {
#   echo "> Adding bash includes"
#   exists=`cat ~/.bashrc | grep bash_includes`
#   if [ -z "$exists" ]; then
#     echo -ne "\n[ -s $HOME/.bash_includes ] && source \"$HOME/.bash_includes\"\n" >> ~/.bashrc
#   fi
  
#   echo "> Adding bash includes"
#   exists=`cat ~/.bashrc | grep bashrc_custom`
#   if [ -z "$exists" ]; then
#     echo -ne "\n[ -s $HOME/.bashrc_custom ] && source \"$HOME/.bashrc_custom\"\n" >> ~/.bashrc
#   fi
  
#   echo "> Adding bash aliases"
# }

# function restart_shell {
#     echo "> Restarting shell"
#     source ~/.bashrc
# }

# link_dotfiles() {
#   for filepath in "$DF_DIR"/*; do
#     filename=`basename $filepath`
#     target="$HOME/.$filename";

#     if [ ! -L "$target" ]; then
#       case "$filename" in
#         install-or-update.sh | LICENSE | README.md | bin | conf | zsh | rcrc)
#           # Do nothing
#           ;;
#       *)
#         echo "Linking $filename";
#         #echo "ln -s \"$filepath\" \"$target\"";
#         ln -s "$filepath" "$target";
#         ;;
#       esac
#     fi
#   done
# }


#get_os
# create_dir
# copy_common
# copy_os
# add_includes
# link_dotfiles
# restart_shell
