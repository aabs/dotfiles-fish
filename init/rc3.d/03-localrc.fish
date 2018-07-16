#!/usr/bin/env fish

if test -f $HOME/localrc.fish
  $HOME/localrc.fish
end 

if test -f $HOME/(hostname).localrc.fish
  source $HOME/(hostname).localrc.fish
end