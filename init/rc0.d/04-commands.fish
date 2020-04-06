#!/usr/bin/env fish

# define the root prefix of a command set
# e.g. define_command "plugin" "A set of commands to install and mange plugins" 
function define_command -a prefix_name summary -d "create a command prefix"
    _define_command $prefix_name $summary
    _define_command_completion $prefix_name $summary
    _define_command_dispatcher $prefix_name

    _define_help_subcommand $prefix_name
end

function _define_help_subcommand -a prefix_name
    set -l ev "on_"$prefix_name"_help"
    echo The event will be $ev
    define_subcommand $prefix_name "help" $ev "Display help for command $prefix_name"
    define_subcommand $prefix_name "help2" $ev "Display help2 for command $prefix_name"
end

function define_subcommand -a prefix_name command_name event_name summary -d "create a command prefix"
    _define_subcommand $prefix_name $command_name $event_name $summary
end

function _define_subcommand -a prefix_name command_name event_name summary -d "create a command prefix impl"
    # erase definitions for event and summary
    eval "set -e _subcommand_event_$prefix_name_$command_name"
    eval "set -e _subcommand_summary_$prefix_name_$command_name"

    set -l x "_subcommand_names_$prefix_name"
    eval "set -U $x \$$x $command_name"
    eval "set -U _subcommand_event_$prefix_name_$command_name '$event_name'"
    eval "set -U _subcommand_summary_$prefix_name_$command_name '$summary'"
    echo "sub command '$prefix_name $command_name' was defined"
end

function _define_command -a prefix_name summary -d "create a command prefix"
    eval "set -e _subcommand_names_$prefix_name"
    if not contains $prefix_name $_command_names
        set -U _command_names $_command_names $prefix_name
        eval "set -U _command_summary_$prefix_name '$summary'"
    end

end

function _define_command_completion -a prefix summary
    complete -c $prefix -x -a $summary
end

function _display_command_help_for -a prefix_name -d "display usage text for command"
    set -l x "_subcommand_names_$prefix_name"
    set -l header "Command Usage: $prefix_name"
    echo $header
    for i in (seq 1 (string length $header))
        echo -n "="
    end
    echo

    for subcommand in $$x
        set -l y "_subcommand_summary_$prefix_name_$subcommand"
        echo -e "$prefix_name $subcommand\t"$$y
    end

end

function _define_command_dispatcher -a prefix -d "creates a function to dispatch subcommands for top level command"

    function _dispatch_ -a prefix
        set -l x (count $argv)
        echo x was $x

        if test 1 -eq $x
            _display_command_help_for $prefix
            echo $prefix ":" $argv
            return
        end
        
        echo "xyzzy $prefix"

    end

    eval 'function '$prefix' ; _dispatch_ '$prefix' $argv; end'
end

function fishdots
  if test 0 -eq (count $argv)
    fishdots_help
    return
  end

  switch $argv[1]
    case home
      fishdots_home
    case menu
      fishdots_menu
    case save
      fishdots_save
    case sync
      fishdots_sync
    case update
      fishdots_update
    case help
      fishdots_help
    case '*'
      fishdots_help
  end
end
