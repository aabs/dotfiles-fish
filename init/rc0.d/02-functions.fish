# one or two useful reusable functions for git repos

function fish_greeting -d "intercept the fish greeting and re-emit it so plugins can respond"
    emit on_fish_greeting
end

function fishdots_git_branch_name -a abs_path -d "get the git branch name of the supplied directory"
    pushd $abs_path
    git branch | grep '^\*' | cut -d' ' -f 2
    popd
end

function fishdots_git_save -a abs_path commit_message -d "save the contents of repo locally"
    # first check its actually a git repo!
    if not test -d $abs_path/.git
        error "[$abs_path] doesn't seem to be a git repo. Aborting."
        return 1
    end

    # then check in any local changes
    pushd $abs_path
    git add -A .
    git commit -m "$commit_message"
    popd
end

function fishdots_git_sync -a abs_path commit_message -d "save and get any changes to repo"
    # first check its actually a git repo!
    if not test -d $abs_path/.git
        error "[$abs_path] doesn't seem to be a git repo. Aborting."
        return 1
    end

    # then check in any local changes
    fishdots_git_save $abs_path $commit_message

    # then get remote changes and try to push local changes up to origin
    pushd $abs_path
    git pull origin (fishdots_git_branch_name $abs_path)
    git push origin (fishdots_git_branch_name $abs_path)
    git fetch --all -t
    popd
end

function _fd_enter -a abs_path
    emit fd_entering_folder $abs_path
    pushd $abs_path
    emit fd_entered_folder $abs_path
end

function _fd_leave
    emit fd_leaving_folder (pwd)
    popd
    emit fd_left_folder (pwd)
end

function _fd_display_option -a command_name name desc -d 'display a help option formatted'
    colour_print cyan "$command_name "
    colour_print green "$name "
    colour_print normal "$desc"
    echo
end

function input_set --argument var_name prompt_msg -d "prompt the user to supply input to set a variable"
    echo "$prompt_msg :"
    eval "read -g "$var_name
end

function input_set_with_default --argument var_name prompt_msg default -d "prompt the user to supply input to set a variable"
    echo "$prompt_msg [$default]:"
    eval "read -g "$var_name
    if test $$var_name = ""
        set -g $var_name $default
    end
end