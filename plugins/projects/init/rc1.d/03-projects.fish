#!/usr/bin/env fish
function _list_project_tasks
    td list +$CURRENT_PROJECT_SN
end

alias ptask='_create_project_task' # create a task for a specific project e.g.: ptask "My Task".  Uses the $CURRENT_PROJECT_SN
alias ptasks="_list_project_tasks"

function pcd -d "switch to project directory"
    cd (project_path $argv[1])
end