function fish_prompt --description 'Write out the prompt'
    eval powerline-go \
        -cwd-mode=plain \
        -error $status \
        -git-mode=simple \
        -hostname-only-if-ssh \
        -jobs (count (jobs -p)) \
        -modules="aws,termtitle,direnv,kube,host,ssh,cwd,perms,git,venv,jobs,exit" \
        -newline \
        -theme=default
end
