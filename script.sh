#!/bin/sh

# Install dependencies
sudo apt update
sudo apt install -y fish curl git ninja-build gettext cmake unzip

# Install mesloLGS font
sudo mkdir -p /usr/share/fonts/truetype
sudo cp -r mesloLGS /usr/share/fonts/truetype

# Install and build neovim from source
if [ ! -f /usr/local/bin/nvim ]; then
	git clone https://github.com/neovim/neovim /tmp/neovim
	make -C /tmp/neovim CMAKE_BUILD_TYPE=RelWithDebInfo
	make -C /tmp/neovim install
fi

if [ -f "/usr/local/bin/vim" ]; then
	sudo rm /usr/local/bin/vim
fi

sudo ln -s /usr/local/bin/nvim /usr/local/bin/vim

mkdir -p ~/.config
cp -r nvim ~/.config/nvim
