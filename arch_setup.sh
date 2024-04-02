#!/bin/bash

# Installs packages and utils needed for my config

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

echo -e "${WARNING} You need to have sudo privileges to run this script"

yn_question "Continue?"
if [ $? -eq 0 ]; then
    exit 1
fi

yn_question "Install pipewire?"
if [ $? -eq 1 ]; then
    sudo pacman -S pipewire pipewire-jack pipewire-alsa pipewire-pulse
fi

yn_question "Install i3-wm + picom + feh + scrot + font-awesome + noto-fonts?"
if [ $? -eq 1 ]; then
    sudo pacman -S i3 xorg xorg-xinit picom feh scrot ttf-font-awesome noto-fonts noto-fonts-cjk noto-fonts-extra

    echo "exec i3" > ~/.xinitrc
    mkdir ~/Screenshots
fi

yn_question "Install alacritty?"
if [ $? -eq 1 ]; then
    sudo pacman -S alacritty
fi

yn_question "Install tmux?"
if [ $? -eq 1 ]; then
    sudo pacman -S tmux
fi

yn_question "Install nvim + nvim plugins dependencies?"
if [ $? -eq 1 ]; then
    sudo pacman -S neovim

    # plugins dependencies
    sudo pacman -S git wget gcc make unzip ripgrep xclip fd python-virtualenv python-pip

    # nvm
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | NODE_VERSION=stable bash
fi

yn_question "Install ohmyzsh + zsh-autosuggestions + zsh-syntax-highlighting?"
if [ $? -eq 1 ]; then
    sudo pacman -S zsh git

    # ohmyzsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    # zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
