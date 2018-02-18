#!/usr/bin/env fish

# assume that we are in the directory that needs to be linked
# link it through to .config/fish/config.fish

# ~/.config/fish/config.fish
if test -e ~/.config/fish/config.fish
    echo "backing up config file" 
    mv ~/.config/fish/config.fish ~/.config/fish/config.fish.backup
end


if test -e ~/.fishdots 
    and test -L ~/.fishdots
    rm $HOME/.fishdots
end

if test -e $HOME/.fishdots
    echo "fishdots exists in place - aborting"
    exit 1
else
    ln -s (realpath .) $HOME/.fishdots
end

function to_dotform -d "transform a name from symlink form into dotfile form"
    set a (string replace ".symlink" "" $argv[1])
    echo ".$a"
end

function make_symlink -d "transforms a symlink file or directory into a dotfile in the $HOME directory"
    set origin $argv[1]
    set dotform "$HOME/."(basename -s .symlink $origin)
    if test -f "$dotform"
        mv -f $dotform $dotform.backup
    end 
    ln -fs "$origin" "$dotform"
    #echo "linking $origin to $dotform"
end

for l in (find . -name "*.symlink")
    make_symlink (realpath $l)
end