#!/usr/bin/env fish
function pubkey
    clip (cat ~/.ssh/id_rsa.pub)
    ok 'Public key copied to pasteboard.'
end

function l -w ls
    clear
    ls -lash --group-directories-first
end

abbr --add salias 'alias | sort | grep'
abbr --add bal 'ledger bal'
abbr --add cls 'clear'

function mcd -w mkdir
    mkdir $argv[1]
    cd $argv[1]
end 





switch (uname)
    case Darwin
        alias vimenv='mvim ~/.dotfiles'
        alias code='/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'
        alias USM='open -a Safari.app https://goto.unisuper.com.au'
        alias ywriter='mono /Applications/yWriter6/yWriter6.exe'
        alias chromedb='/opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222'
        alias att='atom .'
        alias rpisshtest='ssh-test "$DOTFILES/system/parklabrae.hosts.txt"'
        alias cpu='top -o cpu -s 3'
        alias google='googler -n 7 -c ru -l ru'
    case Linux
        alias vimenv='vim $DOTFILES'
        alias rpisshtest='echo "this only works at home"'
        alias att='atom .'
        alias ctt='code . &'
end

# source $(brew --prefix nvm)/nvm.sh
alias senv='env | sort'
alias envup='source ~/.zshrc'
alias myssh='ssh root@176.126.85.224'
