#!/usr/bin/env fish

define_command fishdots "main command for controlling fishdots"
define_subcommand fishdots home on_fishdots_home "switch to fishdots home folder"
define_subcommand fishdots menu on_fishdots_menu "display the menu for fishdots"
define_subcommand fishdots save on_fishdots_save "save any changes to your fishdots locally"
define_subcommand fishdots sync on_fishdots_sync "save any changes to your fishdots locally and push to origin"
define_subcommand fishdots update on_fishdots_update "pull any changes to fishdots down from github"

function fishdots_home -e on_fishdots_home -d "cd to fishdots directory"
    cd $FISHDOTS
end

function fishdots_update -e on_fishdots_update -d "get the latest version of fishdots and each of its plugins"
    fishdots_sync
    for p in (find $FISHDOTS_PLUGINS_HOME -maxdepth 1 -mindepth 1 -type d)
        plugin sync (basename $p)
    end
end

function fishdots_save -e on_fishdots_save -d "save all new or modified notes locally"
    fishdots_git_save $FISHDOTS "more tinkering"
end

function fishdots_sync -e on_fishdots_sync -a msg -d "save all notes to origin repo"
    fishdots_git_sync $FISHDOTS "$msg"
end

function fd_menu
    # set -l menu_hover_item_style -o black -b yellow
    set -l menu_cursor_glyph '>'
    set -l menu_cursor_glyph_style -o
    menu $argv
    set -g fd_selected_item (echo $menu_selected_index)
end

function fishdots_menu -e on_fishdots_menu
    if test 0 -eq (count $argv)
        set -l options home update sync help
        fd_menu 'fishdots main menu' $options
        fishdots_dispatch $options[$menu_selected_index]
    else
        fishdots_dispatch $argv
    end
end

function fishdots_search -a root_path pattern -d "find file by full text search"
    ag -lc "$pattern" $root_path | sort -t: -nrk2 | cut -d':' -f1
end

function fishdots_find -a root_path pattern -d "find item by name"
    find $root_path/ -iname "*$pattern*"
end

function fishdots_find_select -a root_path pattern
    set -l opts (fishdots_find $root_path $pattern)
    fd_menu $opts
    set -g fd_selected_file "$opts[$fd_selected_item]"
end

function fishdots_search_select -a root_path pattern
    set -l opts (fishdots_search $root_path $pattern)
    fd_menu $opts
    set -g fd_selected_file "$opts[$fd_selected_item]"
end

function fishdots_select_from -a root_path search_pattern -d "create a menu to choose between the elements found using the search terms"
    set matches (_note_search "$search_pattern")
end
