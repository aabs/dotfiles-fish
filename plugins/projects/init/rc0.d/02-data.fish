
# assoc usage patterns
# ==========================
# assoc.set name[key] value
# assoc.get name[key]
# assoc.rm  name[key]
# assoc.has_key name[key]

    set _project_names coins erl dots career thor notes kops

    assoc.set project_paths[coins]   "$FINANCE_DIR"    
    assoc.set project_names[coins]  "Ledger crypto-coin accounts"    
    

    assoc.set project_paths[erl]     "$PROJECT_HOME/by-technology/erlang/katas"    
    assoc.set project_names[erl]    "Erlang Code Katas"	


    assoc.set project_paths[dots]    "$DOTFILES" 
    assoc.set project_names[dots]   "My WSL Dotfiles"    
    

    assoc.set project_paths[career]  "$CAREER_DIR" 
    assoc.set project_names[career] "My Career Plan" 



    assoc.set project_paths[thor]    "/mnt/d/Synchronised/active_work/Projects/thor/test" 
    assoc.set project_names[thor]   "THOR test harness"	




    assoc.set project_paths[notes]   "$HOME/notes" 
    assoc.set project_names[notes]  "My Text Notes Collection" 



    assoc.set project_paths[fdp]    "$HOME/dev/fishdots_problem"
    assoc.set project_names[fdp]   "Fishdots Problem Plugin"

    assoc.set project_paths[kops]    "/mnt/d/Synchronised/active_personal/Projects/by-technology/docker/kubernetes/kops"
    assoc.set project_names[kops]   "Kubernetes kops experiments"
