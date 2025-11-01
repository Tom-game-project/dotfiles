if status is-interactive
    # Commands to run in interactive sessions can go here
end
source $HOME/.local/bin/env.fish
alias ls="eza --icons --group-directories-first"
alias lt="eza --icons --group-directories-first --tree --git-ignore"
starship init fish | source
