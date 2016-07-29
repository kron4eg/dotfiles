# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [[ ${OSTYPE} == *"darwin"* ]]; then
    alias ls="gls"
    alias make="gmake"
fi

alias ll="ls -la --color=auto --group-directories-first"
alias rgrep='fgrep -R'
#alias irb='irb --readline -r irb/completion'

export PATH=/usr/local/go/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/openssl/bin:$PATH:$HOME/bin
export MYSQL_PS1="\u@\h/\d> "
export GREP_OPTIONS=--colour=auto
export LANG=en_US.UTF-8
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
export EDITOR=vim
if [ $(command -v nvim) ]; then
    export EDITOR=nvim
fi
export PAGER=less
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"'
export HISTCONTROL="ignoredups"
export HISTIGNORE="&:ls:[bf]g:exit"

shopt -s histappend
shopt -s cdspell

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1='[\u@\h:\w\[\033[01;31m\]\[\033[00m\]]\n\$ '

if [ $(command -v git) ]; then
    export PS1='[\u@\h:\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]]\n\$ '
fi
export PS2='continue-> '

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ $(command -v brew) ] && [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

if [ -f /usr/share/doc/tmux/examples/bash_completion_tmux.sh ]; then
    . /usr/share/doc/tmux/examples/bash_completion_tmux.sh
fi

if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/opt/chruby/share/chruby/auto.sh
fi

export NVM_DIR="$HOME/.nvm"

if [ $(command -v brew) ]; then
    . "$(brew --prefix nvm)/nvm.sh"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
