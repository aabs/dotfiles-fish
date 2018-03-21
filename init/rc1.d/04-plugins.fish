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
    case list
      plugin_list
    case refresh
      plugin_refresh $argv[2]
    case help
      plugin_help
    case '*'
      plugin_help
  end
end

function plugin_install -a git_url name
  cd $FISHDOTS_PLUGINS_HOME
  git clone $git_url $name
end

function plugin_refresh -a name
  cd $FISHDOTS_PLUGINS_HOME/$name
  git pull origin (/usr/bin/git rev-parse --abbrev-ref HEAD)
end

function plugin_uninstall -a name
  # just delete it  (?? OR check if there are uncommitted changes first ??)
  if test -e "$FISHDOTS_PLUGINS_HOME/$name"
    rm -rf "$FISHDOTS_PLUGINS_HOME/$name"
  end
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
  echo "plugin list"
  echo "  list all installed plugins"
  echo ""
  echo "plugin refresh name"
  echo "  get any origin changes for the plugin"
  echo ""
  echo "plugin help"
  echo "  this .. .  ."
end