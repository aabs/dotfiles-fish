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
set -U FISHDOTS $HOME/.config/fishdots/home

if test -e $FISHDOTS
    echo "Fishdots already installed. Aborting web installer."
    exit 1
end

mkdir -p $FISHDOTS
cd $FISHDOTS
set -l latest_release (curl https://raw.githubusercontent.com/aabs/fishdots/feature/nix-bootstrap/latest_release.txt)
curl -L https://github.com/aabs/fishdots/releases/download/{$latest_release}/fishdots-{$latest_release}.tar.gz | tar xzvf -


# 2. Establish a dotfiles management area called `$HOME/.config/fishdots/gens` 
#    where all scripts and plugins will be stored
mkdir -p $FISHDOTS/../gens/original

# 3. Replace all pre-existing scripts with indirect symlinks that 
#    point to the original files stored in `$HOME/.config/fishdots/gens/original`.

# 4. Establish a first generation `$HOME/.config/fishdots/gens/gen1` that holds
#    links to the scripts established by default by fishdots.

# 5. setup invocation script for fishdots loader
mkdir -p $HOME/.config/fish
echo -e "#!/usr/bin/env fish\n\nsource $HOME/.config/fishdots/home/init/boot.fish" >$HOME/.config/fish/config.init