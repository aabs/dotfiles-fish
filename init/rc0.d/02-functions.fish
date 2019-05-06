# one or two useful reusable functions for git repos

function fishdots_git_branch_name -a abs_path -d "get the git branch name of the supplied directory"
  _fd_enter $abs_path
  git branch | grep '^\*'| cut -d' ' -f 2
  _fd_leave
end

function fishdots_git_save -a abs_path commit_message -d "save the contents of repo locally"
  # first check its actually a git repo!
  if not test -d $abs_path/.git
    error "[$abs_path] doesn't seem to be a git repo. Aborting."
    return 1
  end

  # then check in any local changes
  _fd_enter $abs_path
  git add -A .
  git commit -m "$commit_message"
  _fd_leave
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
  _fd_enter $abs_path
  git pull origin (fishdots_git_branch_name $abs_path)
  git push origin (fishdots_git_branch_name $abs_path)
  git fetch --all -t
  _fd_leave
end

function _fd_enter -a abs_path
  pushd .
  cd $abs_path
end

function _fd_leave
  popd
end

function _fd_display_option -a command_name name desc -d 'display a help option formatted'
  colour_print cyan "$command_name "
  colour_print green "$name "
  colour_print normal "$desc"
  echo
end
