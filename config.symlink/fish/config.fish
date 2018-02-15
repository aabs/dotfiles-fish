#!/usr/bin/env fish

# this is the one env var that needs to be set up prior to the boot process
set DOTFILES (realpath ~/.fishdots)

function log
    set_color brred
    echo -n " ⇒ "
    set_color normal
    echo $argv[1]
end

# run each of the init scripts in each init level in turn
for level in (seq 0 2)
    for script in (find "$DOTFILES/init/rc"$level".d/" -name "*.fish")
        log (basename $script)        
        source $script
    end
end

# run each of the init scripts in each of the plugins
# rename a plugin to have a leading underscore to ignore it
for plugin in (find $DOTFILES/plugins -maxdepth 1 -mindepth 1 -type d -not -iname "_*")
    log (basename $plugin)
    for level in (seq 0 2)
        if test -e $plugin/init/rc"$level".d/
            for script in (find "$plugin/init/rc"$level".d/" -name "*.fish")
                source $script
            end
        end
    end
end