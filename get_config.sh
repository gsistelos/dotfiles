#!/bin/bash

# Copies user's configs to this script's directories/files
# It will overwrite the existing directories/files in this script's directory
#
# Target configs: i3, alacritty, tmux, zsh
#
# Neovim config has its own repository

SCRIPT_DIR=$(dirname $0)
CONFIG_DIR=$SCRIPT_DIR/.config

if ! [ -d $CONFIG_DIR ]; then
    mkdir $CONFIG_DIR
fi

cp -r ~/.config/i3 $CONFIG_DIR
cp -r ~/.config/alacritty $CONFIG_DIR
cp ~/.tmux.conf $SCRIPT_DIR
cp ~/.zshrc $SCRIPT_DIR
