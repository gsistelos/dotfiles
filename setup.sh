#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
NO_COLOR="\033[0m"

ERROR="[${RED}ERROR${NO_COLOR}]"
OK="[${GREEN}OK${NO_COLOR}]"
INFO="[${BLUE}INFO${NO_COLOR}]"
WARNING="[${YELLOW}WARNING${NO_COLOR}]"

echo "${WARNING} This script is meant to be run in a minimal install of a Debian or Arch based distro"
echo "${WARNING} You need to have sudo privileges to run this script"

echo -n "${WARNING} Do you want to continue? [y/N] "
while [ true ]; do
    read input
    input=$(echo $input | tr "[:upper:]" "[:lower:]")

    if [ $input = "y" -o $input = "yes" ]; then
        echo "${OK} Continuing..."
        break
    elif [ $input = "" -o $input = "n" -o $input = "no" ]; then
        echo "${OK} Aborting..."
        exit 1
    else
        echo "${ERROR} Invalid input. Try again"
    fi
done

DEFAULT_PACKAGES="git curl zsh wget gcc make gzip unzip tar ripgrep xclip"

if [ -f /etc/debian_version ]; then
    echo "${INFO} Debian based distro detected"
    DISTRO_PACKAGES="fuse fd-find python3-venv python3-pip"
    PKG_UPDATE="sudo apt update -y && sudo apt upgrade -y"
    PKG_INSTALL="sudo apt install -y"

    # neovim
    curl -fsSLO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod +x nvim.appimage

    sudo mv nvim.appimage /usr/bin/nvim
elif [ -f /etc/arch-release ]; then
    echo "${INFO} Arch based distro detected"
    DISTRO_PACKAGES="neovim fd python-virtualenv python-pip"
    PKG_UPDATE="sudo pacman -Syu --noconfirm"
    PKG_INSTALL="sudo pacman -S --noconfirm"
else
    echo "${ERROR} This script only works in Debian or Arch based distros"
    exit 1
fi

echo "${INFO} Updating system..."
$PKG_UPDATE

echo "${INFO} Installing packages..."
$PKG_INSTALL $DEFAULT_PACKAGES $DISTRO_PACKAGES
# nvm
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | NODE_VERSION=stable bash

echo "${INFO} Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "${INFO} Installing Zsh configuration..."
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# .zshrc
curl -fsSLo $HOME/.zshrc https://raw.githubusercontent.com/gsistelos/my-config/main/.zshrc

echo "${INFO} Installing Neovim configuration..."
# nvim config
git clone https://github.com/gsistelos/nvim.git $HOME/.config/nvim

echo "${OK} Done! All configurations are ready to use"
