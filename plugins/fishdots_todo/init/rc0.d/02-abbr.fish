# Actions:
# add|a "THING I NEED TO DO +project @context"
function task -a title
  todo add $title
end
# addm "THINGS I NEED TO DO
#     MORE THINGS I NEED TO DO"
# addto DEST "TEXT TO ADD"
# append|app ITEM# "TEXT TO APPEND"
# archive
# command [ACTIONS]
# deduplicate
# del|rm ITEM# [TERM]
function task_rm -a task_id
  todo rm $task_id
end

# depri|dp ITEM#[, ITEM#, ITEM#, ...]

# do ITEM#[, ITEM#, ITEM#, ...]
function did -a task_id
  todo do $task_id
end
# help [ACTION...]
# list|ls [TERM...]
function tasks
  todo list
end

# listall|lsa [TERM...]
# listaddons
# listcon|lsc [TERM...]
# listfile|lf [SRC [TERM...]]
# listpri|lsp [PRIORITIES] [TERM...]
# listproj|lsprj [TERM...]
# move|mv ITEM# DEST [SRC]
# prepend|prep ITEM# "TEXT TO PREPEND"
# pri|p ITEM# PRIORITY
# replace ITEM# "UPDATED TODO"
# report
# shorthelp
