#!/usr/bin/env fish

function map -a fn_txt list
  set result ""
  for i in list
    set mapped (eval "$fn_txt $i")
    set result $result $mapped
  end
  echo $result
end

function _set -a varName key value -d 'add property to JSON formatted property set using JQ'
  if test -z $varName
    set -g $varName "{}"
  end
  set -g $varName (echo $$varName | jq ".$key |= \"$value\"")
end

function _get -a varName key -d 'get property value from JSON formatted property set using JQ'
  echo $$varName | jq ".$key"
end

function get_unquoted -a v k
    set r (string replace -a "\"" "" (_get $v $k))
    echo (string replace -a "'" "" $r)
end

