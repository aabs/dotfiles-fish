function clip -d "insert something into the clipboard is it is available"
    if test -e /dev/clipboard
        echo $argv[1] > /dev/clipboard
    else
        if test -e /dev/clip
            echo $argv[1] > /dev/clip
        end
    end
end