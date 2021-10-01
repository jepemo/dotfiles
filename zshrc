BASE="$HOME/.dotfiles/zsh"

for file in "$BASE"/*.zsh
do
  source "$file"
done

export EDITOR=vim

# General {{{
# Bash Version
# export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\] \[\033[33;1m\]\w\[\033[m\] (\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)) \$  \n| => "
# ZSH Version
precmd() {
    psvar[5]=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
}
export PROMPT="%F{014}%n%f@ %B%F{011}%~%f%b (%5v) $"$'\n'"| => "
# }}}

# Aliases {{{
peek() { tmux split-window -p 33 $EDITOR $@ || exit; }
q(){ vim "$(readlink ~/.zshrc)" }
alias qq="cd . && source ~/.zshrc"
alias ls="ls -FGh --color"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias cp="cp -iv"
alias rm="rm -iv"
alias mv="mv -iv"
alias du="du -cksh"
alias df="df -h"

alias ...="cd ../.."

alias gh-get="bash ~/.dotfiles/bin/config_github.sh"
# }}}

# UFG Aliases {{{
alias ufg-close='git branch | fzf | xargs git branch -D'
alias ufg-co='git branch | fzf | xargs git checkout'
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
