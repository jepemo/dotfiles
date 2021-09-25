BASE="$HOME/.dotfiles/zsh"

for file in "$BASE"/*.zsh
do
  source "$file"
done

export EDITOR=vim

# Aliases {{{
peek() { tmux split-window -p 33 $EDITOR $@ || exit; }
q(){ vim "$(readlink ~/.zshrc)" }
alias qq="cd . && source ~/.zshrc"
alias ls="ls -FGh"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias cp="cp -iv"
alias rm="rm -iv"
alias mv="mv -iv"
alias du="du -cksh"
alias df="df -h"

alias ...="cd ../.."
# }}}

# GIT {{{
function g {
  if [[ $# > 0 ]]; then
    git "$@"
  else
    git status
  fi
}
# }}}

. $HOME/.asdf/asdf.sh