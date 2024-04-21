alias ll="eza --group-directories-first --all --icons --oneline --git"
alias lla="ll -l"
alias aws-select-profile="export AWS_PROFILE=(aws configure list-profiles | fzf)"
alias aws-select-region="export AWS_DEFAULT_REGION=(aws ec2 describe-regions | jq -r .Regions[].RegionName | fzf)"

abbr --add k kubectl

set -U fish_greeting
set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -gx MYSQL_PS1 "\u@\h/\d> "
set -gx LANG en_US.UTF-8
set -gx NVIM_TUI_ENABLE_TRUE_COLOR 1
set -gx EDITOR nvim
set -gx FZF_DEFAULT_COMMAND "rg --files --no-ignore-vcs --hidden --follow"

fish_add_path --global --path --prepend /bin /sbin
fish_add_path --global --path --append ~/bin ~/.cargo/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    gpgconf --launch gpg-agent
    direnv hook fish | source
end
