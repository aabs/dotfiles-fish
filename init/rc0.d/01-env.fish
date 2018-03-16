#!/usr/bin/env fish

set -x PATH "$HOME/bin" "/usr/local/bin" "$HOME/.fishdots/bin" $PATH
set -x EDITOR vim


# too many other things depend on this for their rc0.d loading to put this in a plugin
if test -e /mnt/d/
    set -U SYNC_HOME /mnt/d/Synchronised
else if test -e /d/
    set -U SYNC_HOME /d/Synchronised
else if test -e /media/aabs/DATA/
    set -U SYNC_HOME /media/aabs/DATA/Synchronised
else
    set_color red
    echo "[ERROR] unable to find the Sync directory"
    set_color normal
end
