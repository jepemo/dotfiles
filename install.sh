#!/usr/bin/env bash

_s() { echo -ne "[\e[32m*\e[0m] \e[1m$1\e[0m\n"; }


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

install_basic_packages() {
  _s "Installing basic packages"

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt install \
      curl \
      git \
      rcm \
      tmux \
      zsh;
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Install in MacOSX"

    brew install asdf
  fi
}

install_asdf() {
  rm -Rf ~/.asdf
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
}

link_dotfiles() {
  _s "Linking dotfiles"
  cp -f rcrc ~/.rcrc >/dev/null 2>&1
  rcup -v -d .
}

#install_basic_packages
#install_asdf
link_dotfiles

