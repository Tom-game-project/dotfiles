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

and you have to install cli tool for copy and paste 
```bash
sudo apt install wl-clipboard
```

## feature

### .bashrc

- zellij completion
