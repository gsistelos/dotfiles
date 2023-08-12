# My Config

## Terminal

### Install fish

```sh
sudo apt update -y
sudo apt install -y fish
```

### Fish config

Install fisher plugin manager:
```sh
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

Download tide fonts from: https://github.com/IlanCosman/tide#font-installation

Install fonts:
```sh
sudo mkdir -p /usr/share/fonts/truetype/mesloLGS
sudo mv ~/Downloads/*.ttf /usr/share/fonts/truetype/mesloLGS
```

Install tide:
```sh
fisher install IlanCosman/tide@v5
```

## Neovim

### Dependencies

https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites

```sh
sudo apt update -y
sudo apt install -y ninja-build gettext cmake unzip curl
```

### Build neovim from source

https://github.com/neovim/neovim/wiki/Building-Neovim#quick-start

Clone neovim repository:
```sh
git clone https://github.com/neovim/neovim
```

Build:
```sh
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

Create a symlink to vim:
```sh
sudo ln -s /usr/local/bin/nvim /usr/local/bin/vim
```

### Neovim kickstart

https://github.com/nvim-lua/kickstart.nvim

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git ~/.config/nvim
```

Run `nvim` to install plugins

### Copilot

Uncomment in `.config/nvim/init.lua` the line `{ import = 'custom.plugins' }`

Add to `.config/nvim/lua/custom/plugins/init.lua` the line `return { "github/copilot.vim" }`
