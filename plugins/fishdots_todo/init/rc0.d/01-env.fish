set -x TODO_DIR "$HOME/.fishdots/tools/todo"
set -x TODO_FILE "$TODO_DIR/todo.txt"
set -x DONE_FILE "$TODO_DIR/done.txt"
set -x REPORT_FILE "$TODO_DIR/report.txt"

function todo
  ~/.fishdots/tools/todo/todo.sh -d "$TODO_DIR/todo.cfg" $argv
end