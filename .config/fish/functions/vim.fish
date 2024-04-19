function vim --wraps vim
    if type -q nvim
        nvim $argv
    else
        command vim
    end
end
