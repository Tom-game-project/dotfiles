# ~/.config/fish/config.fish の末尾などに追加

function fish_user_key_bindings
    # コマンドラインが空のときに Ctrl+z を押すと fg (フォアグラウンド復帰) を実行
    bind \cz 'fg 2>/dev/null; or commandline -f repaint'
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
source $HOME/.local/bin/env.fish
alias ls="eza --icons --group-directories-first"
alias lt="eza --icons --group-directories-first --tree --git-ignore --all"
starship init fish | source

# fish_add_path $HOME/project/Bear-4.0.0/target/release/

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/tom/.opam/opam-init/init.fish' && source '/home/tom/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
