abbr --add k kubectl
abbr --add ll "eza --group-directories-first --all --icons --oneline --git"
abbr --add lla "ll -l"
abbr --add aws-select-profile "export AWS_PROFILE=(aws configure list-profiles | fzf)"
abbr --add aws-select-region "export AWS_DEFAULT_REGION=(aws ec2 describe-regions | jq -r .Regions[].RegionName | fzf)"

set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -gx MYSQL_PS1 "\u@\h/\d> "
set -gx LANG en_US.UTF-8
set -gx NVIM_TUI_ENABLE_TRUE_COLOR 1
set -gx EDITOR vim
set -gx PATH "$PATH:$HOME/bin:$HOME/.cargo/bin"

if status is-interactive
    # Commands to run in interactive sessions can go here
    gpgconf --launch gpg-agent
    direnv hook fish | source
end
