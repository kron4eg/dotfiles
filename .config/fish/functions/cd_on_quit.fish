function spf
    set os $(uname -s)
    set spf_last_dir "$HOME/.local/state/superfile/lastdir"

    command spf $argv

    if test -f "$spf_last_dir"
        source "$spf_last_dir"
        rm -f -- "$spf_last_dir" >> /dev/null
    end
end
