# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ ${OSTYPE} == "darwin15" ]; then
    alias ls="gls"
fi

alias ll="ls -la --color=auto --group-directories-first"
alias rgrep='fgrep -R'
#alias irb='irb --readline -r irb/completion'
alias siftnb='sift -n --binary-skip'

#export CC=/usr/local/bin/gcc-5
#export CPP=/usr/local/bin/cpp-5
#export CXX=/usr/local/bin/g++-5

export PATH=/usr/local/go/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/openssl/bin:$PATH:$HOME/bin
export MYSQL_PS1="\u@\h/\d> "
export GREP_OPTIONS=--colour=auto
export LANG=en_US.UTF-8
export EDITOR=nvim
export ALTERNATE_EDITOR=vim
export PAGER=less
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"'
export HISTCONTROL="ignoredups"
export HISTIGNORE="&:ls:[bf]g:exit"
export BASHRC=1

shopt -s histappend
shopt -s cdspell

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1='[\u@\h:\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]]\n\$ '
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
