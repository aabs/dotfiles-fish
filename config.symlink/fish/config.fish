#!/usr/bin/env fish


# this is the one env var that needs to be set up prior to the boot process
set DOTFILES (realpath ~/.fishdots)
set -x QUIET_FISHDOTS true
source $DOTFILES/init/boot.fish
