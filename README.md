# TOM's DOTFILES

## How to use

- create symbolic link

run following command (you must change `/path/to/the/dotfiles/` path)

```bash
ln -s /path/to/the/dotfiles/.bashrc ~/.bashrc
ln -s /path/to/the/dotfiles/.bashrc.d ~/.bashrc.d
```

## setting zellij

run following command
```bash
zellij setup --dump-config > config.kdl
patch -u config.kdl zellij_config.patch
```

## feature

### .bashrc

- zellij completion
