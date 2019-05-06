#!/usr/bin/env fish

# functions for managing plugins

function plugin
  if test 0 -eq (count $argv)
    plugin_help
    return
  end
  switch $argv[1]
    case home
      cd $FISHDOTS_PLUGINS_HOME
    case install
      plugin_install $argv[2] $argv[3]
    case uninstall
      plugin_uninstall $argv[2]
    case ls
      plugin_list
    case sync
      plugin_sync $argv[2]
    case help
      plugin_help
    case '*'
      plugin_help
  end
end

function plugin_help
  echo "Fishdots Plugins Usage"
  echo "======================"
  echo "plugin <command> [options] [args]"
  echo ""
  plugin_option 'home' 'cd to the plugin root folder' 
  plugin_option 'install <url> <name>' 'install the plugin identified by the git repo path' 
  plugin_option "plugin uninstall name" "remove the plugin by name"
  plugin_option "plugin ls" "  list all installed plugins"
  plugin_option "plugin sync" "save and push any changes to the plugin"
  plugin_option "plugin help" "this .. .  ."
end

complete -c plugin -x -a home -d "cd to the plugin root folder" 
complete -c plugin -x -a install -d "install the plugin identified by the git repo path" 
complete -c plugin -x -a uninstall -d "remove the plugin by name"
complete -c plugin -x -a ls -d "list all installed plugins"
complete -c plugin -x -a sync -d "save and push any changes to the plugin"
complete -c plugin -x -a help -d "display usage guide"

# helper function for displaying usage info
function plugin_option -a name desc
  
  _fd_display_option 'plugin' $name $desc
end

function plugin_install -a git_url name
  _fd_enter $FISHDOTS_PLUGINS_HOME
 
  if test -e $name
    warn "Plugin is already installed"
  end

  git clone $git_url $name
  _fd_leave
end

function plugin_uninstall -a name
  # just delete it  (?? OR check if there are uncommitted changes first ??)
  _fd_enter $FISHDOTS_PLUGINS_HOME

  if test -e $name
    rm -rf $name
  end

  _fd_leave
end

function plugin_list
  for p in (find $FISHDOTS_PLUGINS_HOME -maxdepth 1 -mindepth 1 -type d)
    echo (basename $p)
  end
end


function plugin_sync -d "synchronise all plugin folders"
  for i in (ls $FISHDOTS_PLUGINS_HOME)
    fishdots_git_sync $FISHDOTS_PLUGINS_HOME/$i "more tinkering"
  end
end
