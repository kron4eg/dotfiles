# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

source ~/.bash_profile
#source /etc/bash_completion.d/mercurial.sh
source /home/kron/REPOS/django/extras/django_bash_completion

PATH=$PATH:/sbin:$HOME/bin

export PATH
export EDITOR=vim

shopt -s histappend
PROMPT_COMMAND='history -a'
shopt -s cdspell
export HISTCONTROL="ignoredups"
export HISTIGNORE="&:ls:[bf]g:exit"


parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1='[\u@\h \w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]]$ '

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export GEM_HOME="$HOME/gems"
export GEM_PATH="$GEM_HOME:/usr/lib/ruby/1.8"
export PATH="$GEM_HOME/bin:$PATH" 
export RUBYLIB="$GEM_HOME/lib/"
