#!/usr/bin/env fish

# this is the one env var that needs to be set up prior to the boot process
set DOTFILES (realpath ~/.fishdots)

for level in (seq 0 2)
    for script in (find "$DOTFILES/init/rc"$level".d/" -name "*.fish")
        echo "sourcing $script"
        # source $script
    end
end



