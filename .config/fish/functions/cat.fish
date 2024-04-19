function cat --wraps cat
    if type -q bat
        bat $argv
    else
        command ls $argv
    end
end
