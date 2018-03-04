#!/usr/bin/env bash


function fecho -d "display text with  (prefix, colour) msg"
    set_color $argv[2]
    echo -n $argv[1] 
    echo $argv[3]
    set_color normal
end

function ok -d "display text with [OK] prefix"
    fecho "[OK] " green "$argv[1]"
end

function running
    fecho " => " cyan "$argv[1]"
end

function action
    fecho "[action] " yellow "$argv[1]"
end

function warn
    fecho "[warning] " yellow "$argv[1]"
end

function error
    fecho "[error] " red "$argv[1]"
end
