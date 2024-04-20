function cat --wraps cat
    if type -q bat
        bat $argv
    else
        command cat $argv
    end
end
