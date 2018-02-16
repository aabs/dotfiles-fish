set -x TECH_HOME $PROJECT_HOME/by-technology
set -x tech_roots (find $TECH_HOME -mindepth 1 -maxdepth 1 -type d -print0 | xargs -0 basename -a)

for tr in $tech_roots
    assoc.set tech_paths[$tr]   "$TECH_HOME/$tr"    
end

function tech_path
    set -l key $argv[1]
    echo (assoc.get tech_paths[$key])
end

function tech
    cd (tech_path $argv[1])
end