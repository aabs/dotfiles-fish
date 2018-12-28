#!/usr/bin/env fish

# this is the one env var that needs to be set up prior to the boot process
# fishdots should have been persistently set during install.
#set -U FISHDOTS (realpath ~/.config/fishdots/home)
set -U FISHDOTS_CONFIG $FISHDOTS/config
set -U FISHDOTS_PLUGINS_HOME ~/.config/fishdots/plugins

set -x QUIET_FISHDOTS_BOOT_LOGGING false
set -g FD_MAX_RUN_LEVEL 4

if test $QUIET_FISHDOTS_BOOT_LOGGING  != true
    echo "Welcome to fishdots"
    echo 
end

function colour_print -a colour message
        set_color $colour
        printf "%s" $message
        set_color normal
end

function fecho -a icon icon_colour msg  -d "display text with  (prefix, colour) msg"
    if test $QUIET_FISHDOTS_BOOT_LOGGING  != true
        colour_print $icon_colour $icon
        colour_print normal $msg
        echo
    end
end

function boot    -a message; fecho "[BOOT] "    bryellow "$message"; end
function ok      -a message; fecho "[OK] "      green    "$message"; end
function running -a message; fecho "    => "    cyan     "$message"; end
function action  -a message; fecho "[action] "  yellow   "$message"; end
function warn    -a message; fecho "[warning] " yellow   "$message"; end
function error   -a message; fecho "[error] "   red      "$message"; end

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
# that way, if one plugin depends on functions or environment variables established
# elsewhere, they can be confident to have them present when they make their own definitions 
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

