#!/bin/bash

RED="\033[0;31m"
YELLOW="\033[0;33m"
NO_COLOR="\033[0m"

WARNING="[${YELLOW}WARNING${NO_COLOR}]"
ERROR="[${RED}ERROR${NO_COLOR}]"

yn_question () {
    echo -n "-> ${1} [Y/n] "
    while [ 42 ]; do
        read input
        input=$(echo $input | tr [:upper:] [:lower:])

        case $input in
        "" | "y" | "yes")
            return 1
            ;;
        "n" | "no")
            return 0
            ;;
        *)
            echo -e "${ERROR} Invalid input"
            echo -n "-> ${1} [Y/n] "
        esac
    done
}

echo -e "${WARNING} This script is meant to be run in a minimal Arch Linux install"
echo -e "${WARNING} Existing configurations will be overwritten"
echo -e "${WARNING} You need to have sudo privileges to run this script"

yn_question "Do you want to continue?"
if [ $? -eq 0 ]; then
    exit 1
fi

yn_question "Install pipewire?"
if [ $? -eq 1 ]; then
    sudo pacman -S pipewire pipewire-jack pipewire-alsa pipewire-pulse
fi

yn_question "Install and configure alacritty?"
if [ $? -eq 1 ]; then
    sudo pacman -S alacritty

    mkdir -p ~/.config/alacritty

    # ~/.config/alacritty/alacritty.toml
    curl -fsSLo ~/.config/alacritty/alacritty.toml https://raw.githubusercontent.com/gsistelos/my-config/main/alacritty.toml
fi

yn_question "Install and configure i3-wm?"
if [ $? -eq 1 ]; then
    sudo pacman -S i3 xorg xorg-xinit

    echo "exec i3" > ~/.xinitrc

    mkdir -p ~/.config/i3

    # ~/.config/i3/config
    curl -fsSLo ~/.config/i3/config https://raw.githubusercontent.com/gsistelos/my-config/main/config
fi

yn_question "Install and configure tmux?"
if [ $? -eq 1 ]; then
    sudo pacman -S tmux

    # ~/.tmux.conf
    curl -fsSLo ~/.tmux.conf https://raw.githubusercontent.com/gsistelos/my-config/main/.tmux.conf
fi

yn_question "Install and configure nvim?"
if [ $? -eq 1 ]; then
    sudo pacman -S neovim git wget gcc make unzip ripgrep xclip fd python-virtualenv python-pip

    # nvm
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | NODE_VERSION=stable bash

    mkdir ~/.config

    # ~/.config/nvim
    git clone https://github.com/gsistelos/nvim.git ~/.config/nvim
fi

yn_question "Install and configure ohmyzsh?"
if [ $? -eq 1 ]; then
    sudo pacman -S zsh git

    # ohmyzsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    # zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # ~/.zshrc
    curl -fsSLo ~/.zshrc https://raw.githubusercontent.com/gsistelos/my-config/main/.zshrc
fi
