#!/usr/bin/env fish

# functions for managing plugins

function plugin
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

function plugin_help
  echo "Fishdots Plugins Usage"
  echo "===================="
  echo "plugin <command> [options] [args]"
  echo ""
  echo "plugin install url name"
  echo "  install the plugin identified by the git repo path into $$FISHDOTS_PLUGINS_HOME/$$name"
  echo ""
  echo "plugin uninstall name"
  echo "  remove the plugin by name"
  echo ""
  echo "plugin ls"
  echo "  list all installed plugins"
  echo ""
  echo "plugin save name"
  echo "  save any changes to the plugin"
  echo ""
  echo "plugin sync name"
  echo "  save and push any changes to the plugin"
  echo ""
  echo "plugin help"
  echo "  this .. .  ."
end

function plugin_save -a basename -d "save all new or modified notes locally"
  fishdots_git_save $FISHDOTS_PLUGINS_HOME/$basename "more tinkering"
end

function plugin_sync -a basename -d "save all notes to origin repo"
  fishdots_git_sync $FISHDOTS_PLUGINS_HOME/$basename "more tinkering"
end