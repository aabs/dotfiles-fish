#!/usr/bin/env bash

function fecho -a icon icon_colour msg  -d "display text with  (prefix, colour) msg"
    if test $QUIET_FISHDOTS_BOOT_LOGGING  != true
        set_color $icon_colour
        echo -n $icon
        set_color normal
        echo $msg
    end
end

function ok -a message -d "display text with [OK] prefix"
    fecho "[OK] " green "$message"
end

function running -a message 
    fecho " => " cyan "$message"
end

function action -a message
    fecho "[action] " yellow "$message"
end

function warn -a message
    fecho "[warning] " yellow "$message"
end

function error -a message
    fecho "[error] " red "$message"
end
