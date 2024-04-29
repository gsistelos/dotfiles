#!/bin/bash

# Installs packages and utils needed for my config

RED="\033[0;31m"
YELLOW="\033[0;33m"
NO_COLOR="\033[0m"

WARNING="[${YELLOW}WARNING${NO_COLOR}]"
ERROR="[${RED}ERROR${NO_COLOR}]"

yn_question () {
    while [ 42 ]; do
        echo -n "-> ${1} [Y/n] "

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
    sudo apt install pipewire pipewire-jack pipewire-alsa pipewire-pulse
fi

yn_question "Install nvim + nvim plugins dependencies?"
if [ $? -eq 1 ]; then
    sudo apt install curl fuse

    curl -fsSO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod +x nvim.appimage

    sudo mv nvim.appimage /usr/bin/nvim

    # plugins dependencies
    sudo apt install git wget gcc make unzip ripgrep xclip fd-find python3-venv python3-pip

    # nvm
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | NODE_VERSION=stable bash
fi

yn_question "Install ohmyzsh + zsh-autosuggestions + zsh-syntax-highlighting?"
if [ $? -eq 1 ]; then
    sudo apt install curl zsh git

    # ohmyzsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    # zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
