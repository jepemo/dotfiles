#!/usr/bin/env bash

set -euo pipefail

APT_UPGRADE="sudo apt update && sudo apt upgrade -y"
APT_REMOVE="sudo apt remove"
APT_INSTALL="sudo apt install"
APT_CLEAN="sudo apt autoremove"

SRC_DIR="/home/$SUDO_USER/src"


_s() { echo -ne "[\e[32m*\e[0m] \e[1m$1\e[0m\n"; }
_e() { echo -ne "\e[31m!!\e[0m \e[1m$1\e[0m\n"; }
_i() { echo -ne "\e[1m$1\e[0m\n"; }

_cmd() {
  #eval $1 2>&1 | echo -ne "> $1\n"
  eval $1
}

title() {
  echo -e "
███████ ███████ ████████ ██    ██ ██████
██      ██         ██    ██    ██ ██   ██
███████ █████      ██    ██    ██ ██████
     ██ ██         ██    ██    ██ ██
███████ ███████    ██     ██████  ██      ██
"
# https://patorjk.com/software/taag/#p=display&f=ANSI%20Regular&t=GO!
}

_git_clone() {
  if [[ -d "$2" ]]
  then
    _cmd "git -C $2 pull origin master"
    return;
  fi

  _cmd "git clone $1 $2"
  _cmd "chmod"
}

am_i_root() {
  _s "Checking permissions"
  if [ "$EUID" -ne 0 ]
  	then _e "N0! Please run as root"
  	exit
  fi
}

upgrade_and_install_system() {
  _s "Updating system && installing packages"
  _cmd "$APT_UPGRADE"

  _cmd "$APT_REMOVE \
thunderbird"

  _cmd "$APT_INSTALL \
apt-transport-https \
build-essential \
ca-certificates \
cowsay \
curl \
fzf \
git \
gnupg \
jq \
lsb-release \
rcm \
tmux \
zsh \
-y"
}

clean_system() {
  _s "Cleaning System"
  _cmd "$APT_CLEAN"
}

change_to_zsh() {
  _s "Changing shell to ZSH"
  _cmd "chsh -s `which zsh`"
}

install_docker() {
  _s "Installing docker"
  _cmd "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg"
  _cmd "echo \
\"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null"

  _cmd "$APT_UPGRADE"
  _cmd "$APT_REMOVE docker docker-engine docker.io containerd runc"
  _cmd "$APT_INSTALL docker-ce docker-ce-cli containerd.io"
  _cmd "sudo groupadd -f docker"
  _cmd "sudo usermod -aG docker $SUDO_USER"
  _cmd "sudo systemctl restart docker"

  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

install_vscode() {
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg

  sudo apt install apt-transport-https
  sudo apt update
  sudo apt install code # or code-insiders
}

install_alacritty() {
  sudo add-apt-repository ppa:mmstick76/alacritty
  sudo apt install alacritty
}

setup_git() {
  git config --global user.email "you@example.com"
  git config --global user.name "Tu Nombre"
  git config --global credential.helper cache
}

#install_dotfiles() {
#  _s "Installing dotfiles"
#
#  _cmd "mkdir -p ~/src"
#  _git_clone "https://github.com/jepemo/dotfiles" "$SRC_DIR/dotfiles"
#}

install_asdf_plugins() {
  _s "Installing asdf plugins"

  _cmd "asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git"
  _cmd "asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git"
  # Erlang deps
  #sudo apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
}

title
am_i_root
# upgrade_and_install_system
# install_dotfiles
# install_docker
# install_vscode
# install_alacritty
# clean_system
# change_to_zsh


# configure zsh
# install asdf

# install docker/podman?

# clone github repos

# reboot
