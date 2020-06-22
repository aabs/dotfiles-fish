#!/usr/bin/env fish
function pubkey
    clip (cat ~/.ssh/id_rsa.pub)
    ok 'Public key copied to pasteboard.'
end

function l -w ls
    clear
    if type -q exa
        exa --long --tree --level=2
    else
        ls -lash --group-directories-first
    end
end

abbr --add salias 'abbr | sort | grep'
abbr --add bal 'ledger bal'
abbr --add cls 'clear'

function mcd -w mkdir
    mkdir $argv[1]
    cd $argv[1]
end

switch (uname)
    case Darwin
        abbr --add vimenv 'mvim ~/.dotfiles'
        abbr --add code '/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron'
        abbr --add USM 'open -a Safari.app https://goto.unisuper.com.au'
        abbr --add ywriter 'mono /Applications/yWriter6/yWriter6.exe'
        abbr --add chromedb '/opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222'
        abbr --add att 'atom .'
        abbr --add rpisshtest 'ssh-test "$DOTFILES/system/parklabrae.hosts.txt"'
        abbr --add cpu 'top -o cpu -s 3'
        abbr --add google 'googler -n 7 -c ru -l ru'
    case Linux
        abbr --add vimenv '$EDITOR $DOTFILES'
        abbr --add att 'atom .&'
        abbr --add ctt 'code .&'
end

# source $(brew --prefix nvm)/nvm.sh
abbr --add senv 'env | sort'
abbr --add envup 'source ~/.zshrc'
abbr --add dc 'docker-compose'
abbr --add dcu 'docker-compose up -d'
abbr --add dcd 'docker-compose down'
abbr --add dcl 'docker-compose logs --follow'
abbr --add space_left "df -h | grep xvda3 | awk '{print \$5;}'"
