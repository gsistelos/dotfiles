#!/bin/sh

sudo apt update
sudo apt install -y fish curl git

# Install mesloLGS font
sudo mkdir -p /usr/share/fonts/truetype
sudo cp -r mesloLGS /usr/share/fonts/truetype

fish << END
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v5
END

chsh -s /usr/bin/fish

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

sudo mv nvim.appimage /usr/bin/nvim
sudo ln -s /usr/bin/nvim /usr/bin/vim

mkdir -p ~/.config
git clone https://github.com/nvim-lua/kickstart.nvim.git ~/.config/nvim
