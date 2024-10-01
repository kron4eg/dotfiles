function ek --description 'FZFind and export KUBECONFIG'
    set --local rgcmd "rg --max-depth 3 -l '^kind: Config\$' $HOME/.kube/ \$PWD 2>/dev/null"

    if test -n "$argv"
        set rgcmd "$rgcmd | grep $argv"
    end

    set --global --export KUBECONFIG (eval $rgcmd | fzf --select-1)
end
