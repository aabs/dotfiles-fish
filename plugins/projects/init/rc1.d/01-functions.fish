#!/usr/bin/fish

# assoc usage patterns
# ==========================
# assoc.set name[key] value
# assoc.get name[key]
# assoc.rm  name[key]
# assoc.has_key name[key]

function project_path
    set -l key $argv[1]
    echo (assoc.get project_paths[$key])
end

function project_name
    echo (assoc.get project_names[$argv[1]])
end

function project_list_project_short_names
    for key in $_project_names
		echo $key        
    end
end

function project_list_project_long_names
    for key in $_project_names
		echo (assoc.get project_names[$key])
    end
end

function goto
    ok "Switching to "(project_name $argv[1])
    set_current_project $argv[1]
    pcd $argv[1]
end

function set_current_project
    set -x CURRENT_PROJECT_SN $argv[1]
end

function edit_project
    _cd_project_directory
	$EDITOR 
end

function _cd_current_project_directory
    _cd_project_directory $CURRENT_PROJECT_SN
end

function _cd_project_directory
    cd (project_path $argv[1])
end


function _create_project_task
    _create_task "$argv[1] +$CURRENT_PROJECT_SN"
end

function _create_project_note_dated
    notes n "$CURRENT_PROJECT_SN/"(date --iso-8601)"-$argv[1]"
end

function _project_quick_checkin
    git add -A
    git rm (git ls-files --deleted) 2> /dev/null
    git commit --no-verify -m "$argv[1]"
    git push origin (git branch-name)
end

function _project_detach_from_tmux_session
    tmux detach -s $CURRENT_PROJECT_SN"-session"
end

function _list_project_tasks
    td list +$CURRENT_PROJECT_SN
end

function pcd -d "switch to project directory"
    cd (project_path $argv[1])
end

