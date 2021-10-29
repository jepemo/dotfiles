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
# dotfiles workflow
q(){ vim "$(readlink ~/.zshrc)" }
alias qq="cd . && source ~/.zshrc"
alias qqq="cd ~/.dotfiles && git add . && git commit -a && git pull origin master && git push origin master && cd -"
# ----
alias ls="exa -Fh --color=auto"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias cp="cp -iv"
alias rm="rm -iv"
alias mv="mv -iv"
alias du="du -cksh"
alias df="df -h"

alias ...="cd ../.."

alias cat="batcat"
alias gh-get="bash ~/.dotfiles/bin/config_github.sh"
# }}}

# UFG Aliases {{{
alias zxc-close='git branch | fzf | xargs git branch -D'
alias zxc-co='git branch | fzf | xargs git checkout'
# }}}

# Ubuntu FIXES {{{
alias fix-ubuntu-reset-sound="pulseaudio -k && sudo alsa force-reload"
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
