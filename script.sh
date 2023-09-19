#!/bin/sh

# Install fish
sudo apt update && sudo apt upgrade
sudo apt install -y software-properties-common curl

sudo apt-add-repository ppa:fish-shell/release-3
sudo apt install -y fish

# Install fisher and tide@v5
fish << END
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v5
END

# Set fish as default shell
if [ $SHELL != /usr/bin/fish ]; then
	chsh -s /usr/bin/fish
fi

# Install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

if [ -f /usr/bin/nvim ]; then
	sudo rm -rf /usr/bin/nvim
fi

sudo mv nvim.appimage /usr/bin/nvim

# Set vim as alias for neovim
if [ -f /usr/bin/vim ]; then
	sudo rm -rf /usr/bin/vim
fi

sudo ln -s /usr/bin/nvim /usr/bin/vim

# Install neovim plugins and configuration
sudo apt install -y git make clang

mkdir -p ~/.config
git clone https://github.com/nvim-lua/kickstart.nvim.git ~/.config/nvim

echo "\033[1;33m" # Yellow
echo "Try running nvim, if it fails, run \"sudo apt install -y fuse\""

echo "Relog to set fish as default shell"
