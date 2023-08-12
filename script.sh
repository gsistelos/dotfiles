#!/bin/sh

# Check if if the script is being run with sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run with sudo"
    exit 1
fi

# Install mesloLGS font
if [ ! -d /usr/share/fonts/truetype/mesloLGS ]; then
	mkdir -p /usr/share/fonts/truetype
	cp -r mesloLGS /usr/share/fonts/truetype
fi

# Install and configure fish
if [ ! -f /usr/bin/fish ]; then
	apt update
	apt install -y fish curl

	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

	fisher install IlanCosman/tide@v5
fi

# Install and configure neovim
if [ ! -f /usr/local/bin/nvim ]; then
	apt update -y
	apt install -y git ninja-build gettext cmake unzip curl

	git clone https://github.com/neovim/neovim ~/neovim
	make -C ~/neovim CMAKE_BUILD_TYPE=RelWithDebInfo
	make -C ~/neovim install

	ln -s /usr/local/bin/nvim /usr/local/bin/vim

	cp -r init.lua lua ~/.config/nvim
fi

