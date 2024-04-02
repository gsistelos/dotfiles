#!/bin/bash

# Copies this script's directories/files to user's configs
# It will overwrite the existing user's configs
#
# Target configs: i3, alacritty, picom, tmux, zsh
#
# Neovim config has its own repository

RED="\033[0;31m"
NO_COLOR="\033[0m"

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

SCRIPT_DIR=$(dirname $0)
CONFIG_DIR=$SCRIPT_DIR/.config

if ! [ -d ~/.config ]; then
    mkdir ~/.config
fi

yn_question "Set i3 config?"
if [ $? -eq 1 ]; then
    cp -r $CONFIG_DIR/i3 ~/.config
fi

yn_question "Set alacritty config?"
if [ $? -eq 1 ]; then
    cp -r $CONFIG_DIR/alacritty ~/.config
fi

yn_question "Set picom config?"
if [ $? -eq 1 ]; then
    cp -r $CONFIG_DIR/picom ~/.config
fi

yn_question "Set tmux config?"
if [ $? -eq 1 ]; then
    cp $SCRIPT_DIR/.tmux.conf ~
fi

yn_question "Set zsh config?"
if [ $? -eq 1 ]; then
    cp $SCRIPT_DIR/.zshrc ~
fi
