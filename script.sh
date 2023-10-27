#!/bin/bash

sudo apt update && sudo apt upgrade

# For neovim and vim-plug
sudo apt install -y git curl fuse

# Install neovim
curl -fLo nvim https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim

sudo mv nvim /usr/bin

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# For copilot
sudo apt install -y nodejs

# For treesitter
sudo apt install -y tar gcc

# For lspconfig
sudo apt install -y unzip npm
