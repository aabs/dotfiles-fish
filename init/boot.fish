#!/usr/bin/env fish

source helpers.fish

# this is the one env var that needs to be set up prior to the boot process

setu_ifndef FISHDOTS "$HOME/.fishdots"
setu_ifndef FISHDOTS_CONFIG ~/.config/fishdots
setu_ifndef FISHDOTS_PLUGINS_HOME "$FISHDOTS_CONFIG/plugins"
setu_ifndef QUIET_FISHDOTS_BOOT_LOGGING true
setu_ifndef FD_MAX_RUN_LEVEL 5

if set -q QUIET_FISHDOTS_BOOT_LOGGING
    echo "Welcome to fishdots"
    echo
end

boot "Gathering Local Configs"

# this gives the local rc function (that might contain secrets or configs you
# don't want in a repo) to get a change to set configs in preparation for 
# booting the rest of FD
run_ifexists $HOME/localrc.fish
run_ifexists $HOME/(hostname).localrc.fish

# source third party dependencies
run_ifexists $FISHDOTS/tools/fish-menu/menu.fish

boot "Booting Fishdots"
# run each of the init scripts in each init level in turn
for level in (seq 0 $FD_MAX_RUN_LEVEL)
    if test -e "$FISHDOTS/init/rc"$level".d/"
        ok "Level: $level"
        for script in (find "$FISHDOTS/init/rc"$level".d/" -name "*.fish")
            running (basename $script)
            source $script
        end
    end
end

# boot to each level on each of the plugins before commencing the next run level
# that way, if one plugin depends on functions or environment variables 
# established elsewhere, they can be confident to have them present when they 
# make their own definitions

echo
boot "Loading Fishdots Plugins"
for level in (seq 0 $FD_MAX_RUN_LEVEL)
    ok "Level: $level"
    for plugin in (find $FISHDOTS_PLUGINS_HOME -maxdepth 1 -mindepth 1 -type d -not -iname "_*")
        if test -e $plugin/init/rc"$level".d/
            fecho "  => " blue (basename $plugin)
            for script in (find "$plugin/init/rc"$level".d/" -name "*.fish")
                running (basename $script)
                source $script
            end
        end
    end
end
# IDEA: rename a plugin to have a leading underscore to ignore it

