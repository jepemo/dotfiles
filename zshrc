# tmux {{{
# Copied from *gabebw* dotfiles
# If exists a tmux session starts the environment inside otherwise it creates a new one.
connect_to_most_recent_tmux_session() {
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

export VISUAL=nvim
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
q(){ $VISUAL "$(readlink ~/.zshrc)" }
alias qq="cd . && source ~/.zshrc"
alias qqq="cd ~/.dotfiles && git add . && git commit -a && git pull origin master && git push origin master && cd -"
# ----
alias v=$VISUAL
alias vim=$VISUAL
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

alias cat="bat --theme=\"TwoDark\""
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


# ZSH PLUGINS {{{

# Download Znap, if it's not there yet.
[[ -f ~/.zsh/zsh-snap/znap.zsh ]] ||
	git clone --depth 1 -- \
		https://github.com/marlonrichert/zsh-snap.git ~/.zsh/zsh-snap

source ~/.zsh/zsh-snap/znap.zsh  # Start Znap

# ZSH own prompts
# `znap prompt` makes your prompt visible in just 15-40ms!
# znap prompt sindresorhus/pure

# `znap source` automatically downloads and starts your plugins.
# znap source marlonrichert/zsh-autocomplete
# znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

# `znap eval` caches and runs any kind of command output for you.
# znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'
             
# `znap function` lets you lazy-load features you don't always need.
# znap function _pyenv pyenvn 'eval "$( pyenv init - --no-rehash )"'
# compctl -K    _pyenv pyenv

# }}}

#. $HOME/.asdf/asdf.sh
#. $HOME/.cargo/env

# Python poetry
# . $HOME/.poetry/env
# export PATH="$HOME/.poetry/bin:$PATH"


# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix


