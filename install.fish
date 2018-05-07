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


# 1. Create a download area, into which the release will be decompressed.
set FD_HOME $HOME/.config/fishdots
mkdir -p $FD_HOME
cd $FD_HOME
set -l rel ()
curl -L https://github.com/aabs/fishdots/releases/download/v0.0.1_alpha/fishdots-0.0.1.tar.gz | tar xzvf -


# 2. Establish a dotfiles management area called `$HOME/.config/fishdots/gens` 
#    where all scripts and plugins will be stored

# 3. Replace all pre-existing scripts with indirect symlinks that 
#    point to the original files stored in `$HOME/.config/fishdots/gens/original`.

# 4. Establish a first generation `$HOME/.config/fishdots/gens/gen1` that holds
#    links to the scripts established by default by fishdots.
