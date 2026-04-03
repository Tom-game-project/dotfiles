# ~/.config/fish/config.fish の末尾などに追加

function fish_user_key_bindings
    # コマンドラインが空のときに Ctrl+z を押すと fg (フォアグラウンド復帰) を実行
    bind \cz 'fg 2>/dev/null; or commandline -f repaint'
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -gx GPG_TTY (tty)
    gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
end
source $HOME/.local/bin/env.fish
alias ls="eza --icons --group-directories-first"
alias lt="eza --icons --group-directories-first --tree --git-ignore --all"
starship init fish | source

# fish_add_path $HOME/project/Bear-4.0.0/target/release/

# 環境変数を読み込む
if test -f ~/.profile
    fenv source ~/.profile
end

# Zellij環境下でのみ環境変数を設定する
if set -q ZELLIJ
    # zellij上でvim, nvimを開いた際に、黒い帯状の模様が見えてしまう問題の解決
    # "tmux-256color" など、問題が解決した環境変数の値を指定してください
    set -gx TERM "screen-256color"
    
    # もし COLORTERM で解決した場合はこちら
    # set -gx COLORTERM "truecolor"
end

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '~/.opam/opam-init/init.fish' && source '~/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration

