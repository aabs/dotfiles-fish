#!/usr/bin/env fish
abbr --add ptask        '_create_project_task' # create a task for a specific project e.g.: ptask "My Task".  Uses the $CURRENT_PROJECT_SN
abbr --add ptasks       "_list_project_tasks"

abbr --add projects     'project_list_project_short_names'
abbr --add mltp     'cd $CAREER_DIR && atom .'
abbr --add pnote        '_create_project_note_dated'
function _find_project_notes
    notes find $CURRENT_PROJECT_SN
end
function project 
    echo $CURRENT_PROJECT_SN
end
abbr --add pcd      '_cd_project_directory'
abbr --add pqci     '_project_quick_checkin'
abbr --add ptd      '_project_detach_from_tmux_session'
abbr --add leave        'i out; ptd'
abbr --add pnotes       '_find_project_notes'
