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

echo -e "${WARNING} This script is meant to be run in a minimal install of a Debian based distro"
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

echo -e "${INFO} Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo -e "${INFO} Installing packages..."
sudo apt install -y tmux git curl zsh wget \
	gcc make gzip unzip tar \
	ripgrep xclip fd-find python3-venv \
	python3-pip

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

echo -e "${INFO} Installing Neovim..."
curl -fsSLO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod +x nvim.appimage

sudo mv nvim.appimage /usr/bin/nvim

echo -e "${INFO} Installing tmux configuration..."
curl -fsSLo $HOME/.tmux.conf https://raw.githubusercontent.com/gsistelos/my-config/main/.tmux.conf

echo -e "${OK} Done! All configurations are ready to use"
