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

echo -e "${WARNING} This script is meant to be run in a minimal install of a Debian or Arch based distro"
echo -e "${WARNING} You need to have sudo privileges to run this script"

echo -ne "${WARNING} Do you want to continue? [Y/n] "
while [ true ]; do
    read input
    input=$(echo $input | tr [:upper:] [:lower:])

    case $input in
        "" | "y" | "yes")
            echo -e "${OK} Continuing..."
            break
            ;;
        "n" | "no")
            echo -e "${OK} Aborting..."
            exit 1
            ;;
        *)
            echo -e "${ERROR} Invalid input. Try again"
    esac
done

COMMON_PACKAGES="tmux git curl zsh wget gcc make gzip unzip tar ripgrep xclip"

if [ -f /etc/debian_version ]; then
    echo -e "${INFO} Debian based distro detected"
    DISTRO_PACKAGES="fd-find python3-venv python3-pip"
    PKG_UPDATE="sudo apt update -y"
    PKG_UPGRADE="sudo apt upgrade -y"
    PKG_INSTALL="sudo apt install -y"
elif [ -f /etc/arch-release ]; then
    echo -e "${INFO} Arch based distro detected"
    DISTRO_PACKAGES="neovim fd python-virtualenv python-pip"
    PKG_UPDATE="sudo pacman -Syu --noconfirm"
    PKG_INSTALL="sudo pacman -S --noconfirm"
else
    echo -e "${ERROR} This script only works in Debian or Arch based distros"
    exit 1
fi

echo -e "${INFO} Updating system..."
$PKG_UPDATE && $PKG_UPGRADE

echo -e "${INFO} Installing packages..."
$PKG_INSTALL $COMMON_PACKAGES $DISTRO_PACKAGES

echo -e "${INFO} Installing nvm..."
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | NODE_VERSION=stable bash

echo -e "${INFO} Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo -e "${INFO} Installing Zsh configuration..."
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# .zshrc
curl -fsSLo $HOME/.zshrc https://raw.githubusercontent.com/gsistelos/my-config/main/.zshrc

if [ -f /etc/debian_version ]; then
    echo -e "${INFO} Installing Neovim..."
    curl -fsSLO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod +x nvim.appimage

    sudo mv nvim.appimage /usr/bin/nvim
fi

echo -e "${INFO} Installing Neovim configuration..."
git clone https://github.com/gsistelos/nvim.git $HOME/.config/nvim

echo -e "${INFO} Installing tmux configuration..."
curl -fsSLo $HOME/.tmux.conf https://raw.githubusercontent.com/gsistelos/my-config/main/.tmux.conf

echo -e "${OK} Done! All configurations are ready to use"
