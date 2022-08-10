# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [[ ${OSTYPE} == *"darwin"* ]]; then
	alias ls="gls"
	alias make="gmake"
	alias awk="gawk"
	alias date="gdate"
fi

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

if [[ ${TERM} == "xterm-kitty" ]]; then
	alias ssh="kitty +kitten ssh"
fi

if [ $(command -v exa) ]; then
	alias ll="exa --group-directories-first --long --all"
else
	alias ll="ls -la --color=auto --group-directories-first"
fi

if [ $(command -v bat) ]; then
	alias cat="bat"
fi

if [ $(command -v xdg-open) ]; then
	alias open=xdg-open
fi

alias grep="grep --colour=auto"
if [[ $(command -v ggrep) ]]; then
	alias grep="ggrep --colour=auto"
fi

alias rgrep='fgrep -R'
# this alias makes it so that watch can be used with other aliases, like "watch k get pods"
alias watch='watch '

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/openssl/bin:/usr/local/opt/python/libexec/bin:$PATH
export MYSQL_PS1="\u@\h/\d> "
export LANG=en_US.UTF-8
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export EDITOR=vim
export HOMEBREW_NO_ANALYTICS=1
export GOPROXY="https://proxy.golang.org"
export NNN_RESTRICT_NAV_OPEN=1
export NNN_RESTRICT_0B=1
export NNN_SHOW_HIDDEN=1

if [[ "$VSCODE_CLI" == "1" ]]; then
	export EDITOR="code -w"
fi
if [[ "$TERM_PROGRAM" = "vscode" ]]; then
	export EDITOR="code -w"
fi
export PAGER=less
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"'
export HISTCONTROL="ignoredups"
export HISTIGNORE='pwd:exit:fg:bg:top:clear:history:ll:ls:uptime:df'
export HISTSIZE=1000000
export NVM_DIR="$HOME/.nvm"

shopt -s histappend
shopt -s cdspell
# set -o vi
# bind -m vi-insert "\C-l":clear-screen

parse_git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

n() {
	export NNN_TMPFILE=${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd

	nnn "$@"

	if [ -f $NNN_TMPFILE ]; then
		. $NNN_TMPFILE
		rm -f $NNN_TMPFILE >/dev/null
	fi
}

export PS1='\w\n\$ '

if [ $(command -v git) ]; then
	export PS1='\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\n\$ '
fi

if [ $(command -v direnv) ]; then
	eval "$(direnv hook bash)"
fi

if [ $(command -v kubectl) ]; then
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

[ -f /usr/local/opt/fzf/shell/completion.bash ] && source /usr/local/opt/fzf/shell/completion.bash
[ -f /usr/local/opt/fzf/shell/key-bindings.bash ] && source /usr/local/opt/fzf/shell/key-bindings.bash
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash

export PATH="$HOME/.yarn/bin:$PATH"

if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc ]; then
	source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
	source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc
fi

complete -C /usr/local/bin/mc mc
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
