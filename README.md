# My Config

### Terminal

 - [fish](https://github.com/fish-shell/fish-shell): the friendly interactive shell
 - [fisher](https://github.com/jorgebucaran/fisher): fish plugin manager
 - [tide](https://github.com/IlanCosman/tide): the ultimate fish prompt

### Neovim

 - [neovim](https://github.com/neovim/neovim): hyperextensible vim-based text editor
 - [init.lua](https://github.com/nvim-lua/kickstart.nvim): neovim configuration with useful plugins

Script does not replace existing neovim configuration

## Script installation

Clone this repository:
```sh
git clone https://github.com/gsistelos/my-config.git
```

Run script:
```sh
cd my-config && ./script.sh
```

## Post installation

When `nvim` open it will install plugins automatically

If your fish icons are not working, change the terminal font to mesloLGS

To configure tide, enter fish and run:
```fish
tide configure
```
