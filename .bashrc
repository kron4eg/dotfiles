# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [[ ${OSTYPE} == *"darwin"* ]]; then
    alias ls="gls"
    alias make="gmake"
    alias awk="gawk"
fi

alias ll="ls -la --color=auto --group-directories-first"
alias rgrep='fgrep -R'

export PATH=/usr/local/go/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/openssl/bin:$PATH:$HOME/bin
export MYSQL_PS1="\u@\h/\d> "
export GREP_OPTIONS=--colour=auto
export LANG=en_US.UTF-8
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export EDITOR=vim
export HOMEBREW_NO_ANALYTICS=1
# if [ $(command -v nvim) ]; then
#     export EDITOR=nvim
# fi
if [[ "$VSCODE_CLI" == "1" ]]; then
    export EDITOR="code -w"
fi
if [[ "$TERM_PROGRAM" = "vscode" ]]; then
    export EDITOR="code -w"
fi
export PAGER=less
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"'
export HISTCONTROL="ignoredups"
export HISTIGNORE="&:ls:[bf]g:exit"
export HISTSIZE=1000000
export NVM_DIR="$HOME/.nvm"

shopt -s histappend
shopt -s cdspell
set -o vi
bind -m vi-insert "\C-l":clear-screen

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
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
fi

export PS2='continue-> '

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ $(command -v brew) ]; then
    brw_pref=$(brew --prefix)

    if [ -f $brw_pref/etc/bash_completion ]; then
        . $brw_pref/etc/bash_completion
    fi
fi

if [ -f /usr/share/doc/tmux/examples/bash_completion_tmux.sh ]; then
    . /usr/share/doc/tmux/examples/bash_completion_tmux.sh
fi

# if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
#   source /usr/local/opt/chruby/share/chruby/chruby.sh
#   source /usr/local/opt/chruby/share/chruby/auto.sh
# fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# export PATH="$HOME/.yarn/bin:$PATH"

if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc ]; then
    source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
    source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc
fi
