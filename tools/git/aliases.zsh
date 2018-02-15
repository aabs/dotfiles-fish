# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/

# If Hub is installed via powershell/chocolatey, then alias it for git
# if [[ -f /mnt/c/ProgramData/chocolatey/bin/hub.exe ]]; then
#   alias git="hub.exe"
# fi
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

# The rest of my fun git aliases
alias gll="git ll"
alias gpom="git push origin master"
