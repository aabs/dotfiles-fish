#!/usr/bin/env fish
# from https://github.com/RomanHargrave/fish-assoc

# ASCII Unit separator, purpose is to separate subrecords, etc...
set __assoc_US \31

# Groks name[key] and sets varname and key variables
function assoc._parsename -S -a raw
    set -l data (string match -r '(.+)\[(.+)\]' $raw)
    if [ (count $data) -lt 3 ]
        echo "Invalid assocatiave array specification '$raw'"
        return 1
    else 
        set _map_varname $data[2]
        set _map_key $data[3]
        return 0
    end
end

# Return 0 when contains subject, print index
function assoc.has_key -S -a varspec 
    assoc._parsename $varspec; or return $status

    contains -i $_map_key (string replace -ra $__assoc_US.+ '' $$_map_varname) #replace all following __assoc_US in each element to show only keys
end

# Remove where key matches
function assoc.rm -S -a varspec
    assoc._parsename $varspec; or return $status

    if set -l idx (assoc.has_key $varspec)
        set -e $_map_varname"[$idx]"
    end
end

# Add/update a value
function assoc.set -S -a varspec -a value
    assoc._parsename $varspec; or return $status

    if set -l idx (assoc.has_key $varspec)
        if [ -z $value ]
            set -e $_map_varname"[$idx]"
            return 0
        else
            set $_map_varname"[$idx]" $_map_key$__assoc_US$value
            return 0
        end
    else
        set $_map_varname $$_map_varname $_map_key$__assoc_US$value
        return 0
    end
end

# Get a value for the given key
function assoc.get -S -a varspec
    assoc._parsename $varspec; or return $status

    if set -l idx (assoc.has_key $varspec)
        eval string replace -r .+$__assoc_US "''" '$'$_map_varname'['$idx']'
        return 0
    else
        return 1
    end
end

function assoc.serialize -S -a varname
    printf '%s\n' $$varname
end
