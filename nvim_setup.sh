#!/bin/sh

sudo apt update
sudo apt upgrade

sudo apt install -y curl git fuse

# neovim
curl -fLo nvim https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim

sudo mv nvim /usr/bin/

# vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git clone https://github.com/gsistelos/nvim ~/.config/nvim

# plugins dependencies
sudo apt install -y gcc nodejs
