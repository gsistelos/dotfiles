#!/bin/sh

sudo apt update
sudo apt upgrade

sudo apt install -y curl git fuse

# neovim
curl -fLo nvim https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim

sudo mv nvim /usr/bin/

# plugins
git clone https://github.com/gsistelos/nvim ~/.config/nvim

# plugins dependencies
sudo apt install -y gcc make nodejs npm unzip tar gzip fd-find python3-venv

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.0.1/ripgrep_14.0.1-1_amd64.deb
sudo dpkg -i ripgrep_14.0.1-1_amd64.deb

# clipboard
sudo apt install -y xclip

# nodejs provider
sudo npm install -g neovim
