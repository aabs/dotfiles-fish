#!/usr/bin/env fish

set -x PATH "$HOME/bin" "/usr/local/bin" "$DOTFILES/bin" $PATH
# set -x PATH "/usr/local/go/bin" "/home/linuxbrew/.linuxbrew/bin" "$HOME/bin" "/usr/local/bin" "/usr/local/sbin" "$DOTFILES/bin" $PATH

set -x EDITOR vim

if test -e /mnt/d/
    set -x SYNC_HOME /mnt/d/Synchronised
else if test -e /d/
    set -x SYNC_HOME /d/Synchronised
else if test -e /media/aabs/DATA/
    set -x SYNC_HOME /media/aabs/DATA/Synchronised
else
    set_color red
    echo "[ERROR] unable to find the Sync directory"
    set_color normal
end

