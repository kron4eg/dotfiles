alias ll="eza --group-directories-first --all --icons --oneline --git"
alias lla="ll -l"
alias aws-select-profile="export AWS_PROFILE=(aws configure list-profiles | fzf)"
alias aws-select-region="export AWS_DEFAULT_REGION=(aws ec2 describe-regions | jq -r .Regions[].RegionName | fzf)"
alias isql="sqlite3 :memory:"

abbr --add k kubectl
abbr --add zr zellij run --
abbr --add zrf zellij run --floating --

set -U fish_greeting
# set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -gx MYSQL_PS1 "\u@\h/\d> "
set -gx LANG en_US.UTF-8
set -gx NVIM_TUI_ENABLE_TRUE_COLOR 1
set -gx EDITOR nvim
set -gx FZF_DEFAULT_COMMAND "rg --files --no-ignore-vcs --hidden --follow"

fish_add_path --global --path --prepend /bin /sbin
fish_add_path --global --path --append ~/bin ~/.cargo/bin ~/.local/bin ~/.krew/bin ~/.deno/bin ~/.opencode/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    gpgconf --launch gpg-agent
    direnv hook fish | source

    if [ "$TERM_PROGRAM" = vscode ]
      set -gx EDITOR "code -w"
    end
end
