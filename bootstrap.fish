#!/usr/bin/env fish

function to_dotform -a original_name -d "transform a name from symlink form into dotfile form"
    set a (string replace ".symlink" "" $original_name)
    echo ".$a"
end

function backup_specific_dotfile -a dotfile_path
    if test -e $dotfile_path
        set -l p ~/.fishdots_backups/backup_(date +%Y%m%d-%H)
        if not test -d $p
            mkdir -p $p
        end
        mv $dotfile_path $p     
    end
end

function backup_home_links -d "move everything off into a sub directory to keep ~ clean"
  backup_specific_dotfile '~/.vim/'
end

function make_symlink -a origin -d "transforms a symlink file or directory into a dotfile in the $HOME directory"
    set dotform "$HOME/."(basename -s .symlink $origin)

    if test -e $dotform
        backup_specific_dotfile $dotform
    end

    if not test -e "$dotform"
        ln -fs "$origin" "$dotform"
    end
end


backup_home_links

# assume that we are in the directory that needs to be linked
# link it through to .config/fish/config.fish

# ~/.config/fish/config.fish
if test -e ~/.config/fish/config.fish
    echo "backing up config file" 
    backup_specific_dotfile ~/.config/fish/config.fish
    ln -s config.symlink/fish/config.fish $HOME/.config/fish/config.fish
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

for l in (find . -name "*.symlink")        
    make_symlink (realpath $l)
end

for p in (cut -d',' -f1 ~/.fishdots/known-plugins.dat)
    mkdir -p ~/.config/fishdots/plugins/
    pushd .
    cd ~/.config/fishdots/plugins/
    git clone $p
    popd
end



