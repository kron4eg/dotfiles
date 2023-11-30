#!/usr/bin/env bash

#.bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export TERM=xterm-256color
export PATH=/usr/bin:/usr/sbin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/local/sbin

case ${OSTYPE} in
darwin*)
	alias ls="gls"
	alias make="gmake"
	alias awk="gawk"
	alias date="gdate"
	stty dsusp undef
	;;
linux-gnu*) ;;

esac

if command -v exa &>/dev/null; then
	alias ll="exa --group-directories-first --long --all"
else
	alias ll="ls -la --color=auto --group-directories-first"
fi

if command -v lsd &>/dev/null; then
	alias ll="lsd --oneline --almost-all --group-directories-first"
	alias lla="ll --long"
fi

if command -v bat &>/dev/null; then
	alias cat="bat"
	export FZF_CTRL_T_OPTS="--height 100% --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
fi

if command -v xdg-open &>/dev/null; then
	alias open=xdg-open
fi

if command -v rg &>/dev/null; then
	export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden --follow"
fi

alias grep="grep --colour=auto"
if command -v ggrep &>/dev/null; then
	alias grep="ggrep --colour=auto"
fi

alias rgrep='fgrep -R'
# this alias makes it so that watch can be used with other aliases, like "watch k get pods"
alias watch='watch '
alias k9s='k9s --headless'
alias kamal="docker run -it --rm -v '${PWD}:/workdir' -v '/run/host-services/ssh-auth.sock:/run/host-services/ssh-auth.sock' -e SSH_AUTH_SOCK='/run/host-services/ssh-auth.sock' -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/basecamp/kamal:latest"
alias aws-select-profile='export AWS_PROFILE=$(aws configure list-profiles | fzf)'
alias aws-select-region='export AWS_DEFAULT_REGION=$(aws ec2 describe-regions | jq -r ".Regions[].RegionName" | fzf)'

export MYSQL_PS1="\u@\h/\d> "
export LANG=en_US.UTF-8
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export EDITOR=vim
if command -v nvim &>/dev/null; then
	export EDITOR=nvim
	alias vim=nvim
fi
export HOMEBREW_NO_ANALYTICS=1
# export GOPROXY="https://proxy.golang.org"

if [[ "$VSCODE_CLI" == "1" ]]; then
	export EDITOR="code -w"
fi
if [[ "$TERM_PROGRAM" = "vscode" ]]; then
	export EDITOR="code -w"
fi
export PAGER=less
export HISTCONTROL="ignoredups"
export HISTIGNORE='pwd:exit:fg:bg:top:clear:history:ll:ls:uptime:df'
export HISTSIZE=1000000
export NVM_DIR="$HOME/.nvm"

shopt -s autocd
shopt -s cdspell
shopt -s histappend
shopt -s nocaseglob

# set -o vi
# bind -m vi-insert "\C-l":clear-screen

export PS1='\w\n\$ '

function _update_ps1() {
	PS1="$(powerline-go \
		-newline \
		-condensed \
		-cwd-mode=plain \
		-hostname-only-if-ssh \
		-git-mode=simple \
		-modules="aws,termtitle,direnv,kube,host,ssh,cwd,perms,git,venv,jobs,exit" \
		-error=$? \
		-jobs=$(jobs -p | wc -l))"

	# Uncomment the following line to automatically clear errors after showing
	# them once. This not only clears the error for powerline-go, but also for
	# everything else you run in that shell. Don't enable this if you're not
	# sure this is what you want.

	#set "?"
}

if [ "$TERM" != "linux" ] && command -v powerline-go &>/dev/null; then
	PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

if command -v direnv &>/dev/null; then
	eval "$(direnv hook bash)"
fi

if command -v kubectl &>/dev/null; then
	if [ -f ~/.fubectl.source ]; then
		source ~/.fubectl.source
	else
		alias k=kubectl
	fi
	source <(k completion bash | sed s/kubectl/k/g)

	if [[ -f "/usr/local/opt/kube-ps1/share/kube-ps1.sh" ]]; then
		source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
		PS1='$(kube_ps1)'$PS1
		kubeoff
	fi
	export PATH="${HOME}/.krew/bin:$PATH"
fi

export PS2='continue-> '

[[ -f "/etc/bash_completion" ]] && . "/etc/bash_completion"
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

if [ -f /usr/share/doc/tmux/examples/bash_completion_tmux.sh ]; then
	. /usr/share/doc/tmux/examples/bash_completion_tmux.sh
fi

# if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
#   source /usr/local/opt/chruby/share/chruby/chruby.sh
#   source /usr/local/opt/chruby/share/chruby/auto.sh
# fi

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

DENO_INSTALL="/home/kron/.deno"
[ -d "$DENO_INSTALL" ] && export PATH="$DENO_INSTALL/bin:$PATH"

[ -f /usr/local/opt/fzf/shell/completion.bash ] && source /usr/local/opt/fzf/shell/completion.bash
[ -f /usr/local/opt/fzf/shell/key-bindings.bash ] && source /usr/local/opt/fzf/shell/key-bindings.bash
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash

if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc ]; then
	source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
	source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc
fi

complete -C /usr/local/bin/mc mc
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

fif() {
	rg \
		--line-number \
		--no-column \
		--no-heading \
		--fixed-strings \
		--ignore-case \
		--hidden \
		--follow \
		--glob '!.git/*' "$1" |
		awk -F ":" '/1/ {start = $2<5 ? 0 : $2 - 5; end = $2 + 5; print $1 " " $2 " " start ":" end}' |
		fzf --preview 'bat --color always {1} --highlight-line {2} --line-range {3}' --preview-window wrap
}
