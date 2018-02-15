#!/usr/bin/env fish

set -x PATH "$HOME/.tmuxifier/bin" "/usr/local/go/bin" "/home/linuxbrew/.linuxbrew/bin" "$HOME/bin" "/usr/local/bin" "/usr/local/sbin" "$DOTFILES/bin"

set -x EDITOR vim
set -x SYNC_HOME /mnt/d/Synchronised
set -x PROJECT_HOME $SYNC_HOME/active_personal/Projects
