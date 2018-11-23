export EDITOR=nano

# Tmux aliases
peek() { tmux split-window -p 33 $EDITOR $@ || exit; }
