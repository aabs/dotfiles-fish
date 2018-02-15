#!/usr/bin/env fish

# this is the one env var that needs to be set up prior to the boot process
set DOTFILES (realpath ~/.fishdots)

function log
    set_color brred
    echo -n " ⇒ "
    set_color normal
    echo $argv[1]
end

for level in (seq 0 2)
    for script in (find "$DOTFILES/init/rc"$level".d/" -name "*.fish")
        log (basename $script)        
        source $script
    end
end



