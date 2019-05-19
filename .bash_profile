# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
export PATH="/usr/local/opt/gettext/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
