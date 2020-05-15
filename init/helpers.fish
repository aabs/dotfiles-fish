#!/usr/bin/env fish

function colour_print -a colour message
    set_color $colour
    printf "%s" $message
    set_color normal
end

function fdecho -d "just echo if we are allowed to"
    if set -q FISHDOTS_SUPPRESS_BOOT_LOGGING
        echo $argv
    end

end

function fecho -a icon icon_colour msg  -d "display text with  (prefix, colour) msg"
    if set -q FISHDOTS_SUPPRESS_BOOT_LOGGING
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

function setu_ifndef -a name value
    if not set -q $name
        ok "setting $name"
        set -U $name $value
    else
        warn "not setting $name"
    end
end

function run_ifexists -a path_of_file
    if test -f $path_of_file
        ok "running $path_of_file"
        source $path_of_file
    else
        warn "$path_of_file not found."
    end
end
