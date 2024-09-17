#!/bin/env bash

DOTFILES=(
    ".tmux.conf"
    ".bashrc"
)

DOTDIRS=(
    ".config/alacritty"
    ".config/hypr"
    ".config/rofi"
    ".config/waybar"
)

for DOTFILE in ${DOTFILES[@]}; do
    cp -r ~/$DOTFILE $DOTFILE
done

for DOTDIR in ${DOTDIRS[@]}; do
    cp -r ~/$DOTDIR .config/
done
