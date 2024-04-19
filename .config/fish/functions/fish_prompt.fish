function fish_prompt --description 'Write out the prompt'
  eval ~/bin/powerline-go \
		-newline \
		-hostname-only-if-ssh \
		-git-mode=simple \
		-modules="aws,termtitle,direnv,kube,host,ssh,cwd,perms,git,venv,jobs,exit" \
    -error $status \
    -jobs (count (jobs -p))
end
