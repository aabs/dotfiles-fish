# Standard utility functions to assist with (e.g.) list processing

function size -a list
  count $list
end

function head -a list
  $list[1]
end

function tail -a list
  $list[2..-1]
end

function item -a list index
  $list[$index]
end

function map -a fn_txt list
  set result ""
  for i in list
    set mapped (eval "$fn_txt $i")
    set result $result $mapped
  end
  echo $result
end
