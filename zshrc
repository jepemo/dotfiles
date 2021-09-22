BASE="$HOME/.dotfiles/zsh"

for file in "$BASE"/*.zsh
do
  source "$file"
done

export EDITOR=nano

# Tmux aliases
peek() { tmux split-window -p 33 $EDITOR $@ || exit; }
q(){ vim "$(readlink ~/.zshrc)" }

# Aliases
alias ls="ls -FGh"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias du="du -cksh"
alias df="df -h"