#!/usr/bin/env fish

#### Geneeral purpose helper functions for fishdots
function fishdots
  if test 0 -eq (count $argv)
    fishdots_help
    return
  end

  switch $argv[1]
    case home
      fishdots_home
    case update
      fishdots_update
    case save
      fishdots_save
    case sync
      fishdots_sync
    case help
      fishdots_help
    case '*'
      fishdots_help
  end
end

function fishdots_home -d "cd to fishdots directory"
  _enter_fishdots_home
end

function fishdots_update -d "get the latest version of fishdots and each of its plugins"
  fishdots_sync
  for p in (find $FISHDOTS_PLUGINS_HOME -maxdepth 1 -mindepth 1 -type d)
    plugin sync (basename $p)
  end
end

function fishdots_save -d "save all new or modified notes locally"
  fishdots_git_save $FISHDOTS "more tinkering"
end

function fishdots_sync -d "save all notes to origin repo"
  fishdots_git_sync $FISHDOTS "more tinkering"
end

function fishdots_menu
  set -l options home update sync help
  menu $options
  fishdots $options[$menu_selected_index]
end

function fishdots_help
  echo "Fishdots fishdots Usage"
  echo "======================="
  echo "fishdots <command> [options] [args]"
  echo ""

  echo "fishdots home"
  echo " go to the fishdots home directory"
  echo ""

  echo "fishdots update"
  echo " sync fishdots as well as all its plugins"
  echo ""

  echo "fishdots save"
  echo " save any changes to fishdots"
  echo ""

  echo "fishdots sync"
  echo " save and get any changes to fishdots"
  echo ""

  echo "fishdots help"
  echo " this..."
  echo ""

  
end

function _enter_fishdots_home
  pushd .
  cd $FISHDOTS
end

function _leave_fishdots_home
  popd
end
