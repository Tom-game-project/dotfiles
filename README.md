# TOM's DOTFILES

## How to use

- create symbolic link

run following command (you must change `/path/to/the/dotfiles/` path)

```bash
ln -s /path/to/the/dotfiles/.bashrc ~/.bashrc
ln -s /path/to/the/dotfiles/.bashrc.d ~/.bashrc.d
```

## setting zellij

for wayland

run following command
```bash
zellij setup --dump-config > config.kdl
patch -u config.kdl zellij_config.patch
```

- room.wasm setting

and you have to install cli tool for copy and paste 
```bash
sudo apt install wl-clipboard
```

## setting `.vimrc`

links
  - https://github.com/mattn/vim-lsp-settings?tab=readme-ov-file
  - https://github.com/prabirshrestha/vim-lsp
  - https://github.com/junegunn/vim-plug?tab=readme-ov-file
  - https://github.com/fannheyward/coc-rust-analyzer


## convenient ls
```
ls --git -la --tree --git-ignore --no-permissions --no-user --no-time
```

## feature

### .bashrc

- zellij completion

## dependences
