#!/usr/bin/env fish

# FishDots installer script.
# Copyright (c) 2018 Andrew Matthews
#
# What this script does
# =====================
#
# The purpose of this script is to download and install the latest stable fishdots release.
# In the process it will do the following:

# 1. Create a download area, into which the release will be decompressed.

# 2. Establish a dotfiles management area called `$HOME/.config/fishdots/gens`
#    where all scripts and plugins will be stored

# 3. Replace all pre-existing scripts with indirect symlinks that
#    point to the original files stored in `$HOME/.config/fishdots/gens/original`.

# 4. Establish a first generation `$HOME/.config/fishdots/gens/gen1` that holds
#    links to the scripts established by default by fishdots.

# One liner install script
# ========================

# curl -skLq bit.ly/fishdots_install | fish

# 1. Create a download area, into which the release will be decompressed.
set -l latest_release (curl -skq https://raw.githubusercontent.com/aabs/fishdots/master/latest-release.txt)

if not set -q FISHDOTS_INSTALL_PATH
  set -x FISHDOTS_INSTALL_PATH $HOME
  echo installing into $FISHDOTS_INSTALL_PATH
end

# compute the location for the installation
set -e FISHDOTS
set -U FISHDOTS "$FISHDOTS_INSTALL_PATH/.config/fishdots/home/fishdots-$latest_release"
echo Fishdots home set to $FISHDOTS

# abort if fishdots is already installed
if test -e $FISHDOTS
    echo "Fishdots already installed. Aborting web installer."
    exit 1
end

# create the new install folder and extract the latest release into it
mkdir -p $FISHDOTS
cd $FISHDOTS/..
curl -L https://github.com/aabs/fishdots/archive/v{$latest_release}.tar.gz | tar xzf -

# now place an easy link to fishdots in the home folder
ln -fs $FISHDOTS $HOME/.fishdots

# now ensure FD gets loaded during fish shell start process

touch $HOME/.config/fish/config.fish
echo -e "\n\nsource ~/.fishdots/init/boot.fish" >> $HOME/.config/fish/config.fish
