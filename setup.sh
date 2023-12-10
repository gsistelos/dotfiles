#!/bin/sh

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
NO_COLOR="\033[0m"

ERROR="[${RED}ERROR${NO_COLOR}]"
OK="[${GREEN}OK${NO_COLOR}]"
INFO="[${BLUE}INFO${NO_COLOR}]"
WARNING="[${YELLOW}WARNING${NO_COLOR}]"

echo "${INFO} This script is meant to be run in a minimal install of a Debian or Arch based distro"
echo "${INFO} You need to have sudo privileges to run this script"

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

if [ -f /etc/debian_version ]; then
    echo "${INFO} Debian based distro detected"
    IS_DEB=true
elif [ -f /etc/arch-release ]; then
    echo "${INFO} Arch based distro detected"
    IS_DEB=false
else
    echo "${ERROR} This script only works in Debian or Arch based distros"
    exit 1
fi

echo "${INFO} Updating system..."
if [ $IS_DEB = true ]; then
    sudo apt update -y && sudo apt upgrade -y
else
    sudo pacman -Su --noconfirm
fi

echo "${INFO} Installing Oh My Zsh dependencies..."
if [ $IS_DEB = true ]; then
    sudo apt install -y git curl zsh
else
    sudo pacman -S --noconfirm git curl zsh
fi

echo "${INFO} Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo -n "${WARNING} Do you want to install a custom Zsh configuration? [y/N] "
while [ true ]; do
    read input
    input=$(echo $input | tr "[:upper:]" "[:lower:]")

    if [ $input = "y" -o $input = "yes" ]; then
        echo "${OK} Downloading..."
        # zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-autosuggestions \
            ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        # zsh-syntax-highlighting
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
            ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        # .zshrc
        curl -fsSLo $HOME/.zshrc https://raw.githubusercontent.com/gsistelos/my-config/main/.zshrc
        break
    elif [ $input = "" -o $input = "n" -o $input = "no" ]; then
        echo "${OK} Skipping..."
        break
    else
        echo "${ERROR} Invalid input. Try again"
    fi
done

echo "${INFO} Installing Neovim dependencies..."
if [ $IS_DEB = true ]; then
    sudo apt install -y fuse
else
    sudo pacman -S --noconfirm fuse
fi

echo "${INFO} Installing Neovim..."
curl -fsSLO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod +x nvim.appimage

sudo mv nvim.appimage /usr/bin/nvim

echo -n "${WARNING} Do you want to install a custom Neovim configuration? [y/N] "
while [ true ]; do
    read input
    input=$(echo $input | tr "[:upper:]" "[:lower:]")

    if [ $input = "y" -o $input = "yes" ]; then
        echo "${OK} Clonning..."
        # nvm
        curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        # node
        nvm install stable
        # plugins dependencies
        if [ $IS_DEB = true ]; then
            sudo apt install -y gcc make unzip tar gzip fd-find ripgrep python3-venv xclip
        else
            sudo pacman -S --noconfirm gcc make unzip tar gzip fd ripgrep python-venv xclip
        fi
        # node provider
        sudo npm install -g neovim
        # nvim config
        git clone https://github.com/gsistelos/nvim.git $HOME/.config/nvim
        break
    elif [ $input = "" -o $input = "n" -o $input = "no" ]; then
        echo "${OK} Skipping..."
        break
    else
        echo "${ERROR} Invalid input. Try again"
    fi
done

echo "${OK} Done! All configurations are ready to use"
