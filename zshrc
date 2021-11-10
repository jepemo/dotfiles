# tmux {{{
# Copied from *gabebw* dotfiles
# If exists a tmux session starts the environment inside.
connect_to_most_recent_tmux_session() {
  # echo "$TMUX"
  if _not_in_tmux && _not_any_tmux_sessions; then
    tmux new -s XYZ
  elif _not_in_tmux && _any_tmux_sessions; then
    tmux attach -t "$(_most_recent_tmux_session)"
  else
    echo ""
    echo "/|\(;,;)/|\  ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn"
    echo ""
  fi
}

# Returns the name of the most recent tmux session, sorted by time the session
# was last attached.
_most_recent_tmux_session(){
  tmux list-sessions -F "#{session_last_attached} #{session_name}" | \
    sort -r | \
    cut -d' ' -f2 | \
    head -1
}

_not_in_tmux() {
  [[ -z "$TMUX" ]]
}

# _not_in_tmux() {
#   [[ -z "$TMUX" ]]
# }

_not_any_tmux_sessions() {
  [[ ! -n "$(tmux ls 2>/dev/null)" ]]
}

_any_tmux_sessions() {
  [[ -n "$(tmux ls 2>/dev/null)" ]]
}

inside_ssh(){
  [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]
}

in_vs_code(){ [[ "$TERM_PROGRAM" == "vscode" ]] }

if ! inside_ssh && ! in_vs_code; then
  connect_to_most_recent_tmux_session
fi
# }}}


# BASE="$HOME/.dotfiles/zsh"

# for file in "$BASE"/*.zsh
# do
#   source "$file"
# done

export VISUAL=vim
export EDITOR=$VISUAL

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
. $HOME/.cargo/env
