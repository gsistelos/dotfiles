#!/bin/sh

sudo apt update
sudo apt install -y fish curl git make gcc

# Install mesloLGS font
sudo mkdir -p /usr/share/fonts/truetype
sudo cp -r mesloLGS /usr/share/fonts/truetype

# Install fisher and tide@v5
fish << END
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v5
END

# Set fish as default shell
chsh -s /usr/bin/fish

# Install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

if [ -f /usr/bin/nvim ]; then
  sudo rm -rf /usr/bin/nvim
fi

sudo mv nvim.appimage /usr/bin/nvim

# Install neovim plugins and configuration
mkdir -p ~/.config
git clone https://github.com/nvim-lua/kickstart.nvim.git ~/.config/nvim
