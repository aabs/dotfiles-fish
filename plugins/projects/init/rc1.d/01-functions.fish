#!/usr/bin/zsh


project_path(){
    echo $project_paths[$1]
}

project_name(){
    echo $project_names[$1]
}

project_list_project_short_names(){
	for key in ${(k)project_names};
	do
		echo $key
	done
}

project_list_project_long_names(){
	for key in ${(k)project_names};
	do
		echo $project_names[$key]
	done
}

goto(){
    echo "Switching to $(project_name $1)"
    i sw "$(project_name $1)"
    set_current_project $1
    GEOMETRY_PROMPT_SUFFIX=" <$CURRENT_PROJECT_SN> $"
    pcd $1
}

set_current_project(){
    export CURRENT_PROJECT_SN=$1
}

edit_project(){
    _cd_project_directory
	$EDITOR 
}

_cd_current_project_directory(){
    _cd_project_directory $CURRENT_PROJECT_SN
}

_cd_project_directory(){
    cd $(project_path $1)
}


_create_project_task(){
    _create_task "$1 +$CURRENT_PROJECT_SN"
}

_create_project_note_dated(){
    notes n "$CURRENT_PROJECT_SN/$(today)-$1"
}
_project_quick_checkin(){
    git add -A
    git rm $(git ls-files --deleted) 2> /dev/null
    git commit --no-verify -m "$1"
    git push origin "$(git_current_branch)"
}

_project_detach_from_tmux_session(){
    tmux detach -s "${CURRENT_PROJECT_SN}-session"
}

for key in ${(k)project_names};
do
    eval "alias $key='goto $key'"
done
