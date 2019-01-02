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
set -l latest_release (curl https://raw.githubusercontent.com/aabs/fishdots/feature/nix-bootstrap/latest_release.txt)

if not set -q FISHDOTS_INSTALL_PATH
  set -x FISHDOTS_INSTALL_PATH $HOME
end

set -U FISHDOTS "$FISHDOTS_INSTALL_PATH/.config/fishdots/home/fishdots-$latest_release"

if test -e $FISHDOTS
    echo "Fishdots already installed. Aborting web installer."
    exit 1
end

mkdir -p $FISHDOTS
cd $FISHDOTS/..
curl -L https://github.com/aabs/fishdots/archive/v{$latest_release}.tar.gz | tar xzf -

# 2. Establish a dotfiles management area called `$HOME/.config/fishdots/gens` 
#    where all scripts and plugins will be stored
mkdir -p $FISHDOTS/../../plugins

set -U GEN_ROOT "$FISHDOTS/../../gens"
# 3. Replace all pre-existing scripts with indirect symlinks that 
#    point to the original files stored in `$HOME/.config/fishdots/gens/original`.
source $FISHDOTS/indirection.fish
install_for_first_time $FISHDOTS_INSTALL_PATH

# 4. Establish a first generation `$HOME/.config/fishdots/gens/gen1` that holds
#    links to the scripts established by default by fishdots.

# 5. setup invocation script for fishdots loader
mkdir -p $HOME/.config/fish
echo -e "#!/usr/bin/env fish\n\nsource $FISHDOTS/init/boot.fish" >$HOME/.config/fish/config.fish
