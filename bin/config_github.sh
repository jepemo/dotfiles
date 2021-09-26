#!/usr/bin/env bash

set -euo pipefail

SRC_DIR=~/src

install_github_cli() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install gh
  fi
}

config_github_login() {
    git config --global credential.helper store
    gh auth login
}

clone_new_repo() {
 repo_name=`gh repo list -L 1000 | fzf | awk '{ print $1 }'`
 repo_dir="$SRC_DIR/$repo_name"
 raw_repo_name=`echo $repo_name | cut -d '/' -f 2`

 if [ ! -d "$repo_dir" ]; then
   gh repo clone $raw_repo_name $repo_dir
 else
   cd $repo_dir
   gh repo sync
   cd -
 fi
}

if ! command -v gh &> /dev/null
then
    install_github_cli
    config_github_login
fi

clone_new_repo