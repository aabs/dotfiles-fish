#!/usr/bin/env fish

# this will have been invoked from .config/fish/config.fish, which will have set $DOTFILES

function log
    if test $QUIET_FISHDOTS != true
        set_color brred
        echo -n " ⇒ "
        set_color normal
        echo $argv[1]
    end
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

fish_logo