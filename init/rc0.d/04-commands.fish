#!/usr/bin/env fish

# define the root prefix of a command set
# e.g. define_command "plugin" "A set of commands to install and mange plugins" 
function define_command -a prefix_name summary -d "create a command prefix"
    _define_command $prefix_name $summary
    _define_command_completion $prefix_name $summary
    _define_command_dispatcher $prefix_name

    _define_help_subcommand $prefix_name
end

function define_subcommand -a prefix_name command_name event_name summary -d "create a command prefix"
    _define_subcommand $prefix_name $command_name $event_name $summary
    _define_subcommand_completion  $prefix_name $command_name $summary
end
function define_subcommand_nonevented -a prefix_name command_name function_name summary -d "create a command prefix"
    _define_subcommand_nonevented $prefix_name $command_name $function_name $summary
    _define_subcommand_completion  $prefix_name $command_name $summary
end

function _define_subcommand -a prefix_name command_name event_name summary -d "create a command prefix impl"
    # erase definitions for event and summary
    eval "set -e _subcommand_event_"$prefix_name"_"$command_name
    eval "set -e _subcommand_summary_"$prefix_name"_"$command_name

    set -l x "_subcommand_names_$prefix_name"
    eval "set -U $x \$$x $command_name"
    eval "set -U _subcommand_event_"$prefix_name"_"$command_name" '$event_name'"
    eval "set -U _subcommand_summary_"$prefix_name"_"$command_name" '$summary'"
end

function _define_subcommand_nonevented -a prefix_name command_name function_name summary -d "create a command prefix impl"
    # erase definitions for event and summary
    eval "set -e _subcommand_function_"$prefix_name"_"$command_name
    eval "set -e _subcommand_summary_"$prefix_name"_"$command_name

    set -l x "_subcommand_names_$prefix_name"
    eval "set -U $x \$$x $command_name"
    eval "set -U _subcommand_function_"$prefix_name"_"$command_name" '$function_name'"
    eval "set -U _subcommand_summary_"$prefix_name"_"$command_name" '$summary'"
end

function _define_command -a prefix_name summary -d "create a command prefix"
    eval "set -e _subcommand_names_$prefix_name"
    if not contains $prefix_name $_command_names
        set -U _command_names $_command_names $prefix_name
        eval "set -U _command_summary_$prefix_name '$summary'"
    end
end

function _define_command_completion -a prefix summary
    complete -x -c "$prefix" -d "$summary"
end

function _define_subcommand_completion -a prefix subcmd summary
    complete -x -c "$prefix" -a "$subcmd" -d "$summary"
end

function _display_command_help_for -a prefix_name -d "display usage text for command"
    set -l x "_subcommand_names_$prefix_name"
    set -l cmd_summary "_command_summary_$prefix_name"
    set -l header "Command Usage for $prefix_name"
    echo $header
    _underline $header '-'
    echo $$cmd_summary
    echo
    echo $prefix_name" <command> [options] [args]"
    echo

    for subcommand in $$x
        set -l y "_subcommand_summary_$prefix_name_$subcommand"
        echo -e "$prefix_name $subcommand\t"$$y
    end

end

function _underline -a str ul -d "create an underlined version of a string"
    for i in (seq 1 (string length $str))
        echo -n $ul
    end
    echo
end

function _define_command_dispatcher -a prefix -d "creates a function to dispatch subcommands for top level command"

    function _dispatch_ -a prefix
        set -l argcount (count $argv)

        if test 1 -eq $argcount
            _display_command_help_for $prefix
            return
        end

        set -l subcmds "_subcommand_names_$prefix"
        set -l sub $argv[2]
        set -l rest $argv[3..8]
        set -l ev "_subcommand_event_"$prefix"_$sub"
        if set -q $ev
            eval "emit $$ev $rest"
        end
        set -l fn "_subcommand_function_"$prefix"_$sub"
        if set -q $fn
            eval "$$fn $rest"
        end
    end

    eval 'function '$prefix' ; _dispatch_ '$prefix' $argv; end'
end

function _define_help_subcommand -a prefix_name
    set -l ev "on_"$prefix_name"_help"
    define_subcommand $prefix_name "help" $ev "Display help for command $prefix_name"

    # create an event handler for displaying the help for this command
    eval 'function __'$prefix_name'_help -e '$ev' ; _display_command_help_for '$prefix_name'; end'
end