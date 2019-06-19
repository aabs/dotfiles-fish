#!/usr/bin/env fish

bind \cd 'exit'

set -g fish_key_bindings fish_vi_key_bindings

# bind \cS 'commandline -C 0; commandline -i "sudo "; end-of-line'

function fish_right_prompt -d "Write out the right prompt"
    echo (df -h | grep xvda3 | awk '{print $5;}';date '+%H:%M:%S')
end

