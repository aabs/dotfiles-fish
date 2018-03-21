#!/usr/bin/env fish

#### Geneeral purpose helper functions for fishdots
function fishdots
  switch $argv[1]
    case home
      fishdots_home
    case update
      fishdots_update
    case help
      fishdots_help
    case '*'
      fishdots_help
  end
end

function fishdots_home -d "cd to fishdots directory"
  cd $FISHDOTS
end

function fishdots_update -d "get the latest version of fishdots and each of its plugins"
  cd $FISHDOTS_PLUGINS_HOME/
  git pull origin (/usr/bin/git rev-parse --abbrev-ref HEAD)

  for p in (find $FISHDOTS_PLUGINS_HOME -maxdepth 1 -mindepth 1 -type d)
    cd $FISHDOTS_PLUGINS_HOME/
    git pull origin (/usr/bin/git rev-parse --abbrev-ref HEAD)
  end

end

function fishdots_help
  echo "Fishdots fishdots Usage"
  echo "======================="
  echo "fishdots <command> [options] [args]"
  echo ""
  echo "fishdots update"
  echo "  get the latest version of fishdots and each of its plugins"
  echo ""
  echo "fishdots help"
  echo "  this .. .  ."
end