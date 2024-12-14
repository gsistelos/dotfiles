#!/usr/bin/env bash

DOTFILES=(
	".bashrc"
	".zshrc"
	".tmux.conf"
)

DOTDIRS=(
	".config/alacritty"
	".config/hypr"
	".config/i3"
	".config/rofi"
	".config/waybar"
)

for DOTFILE in ${DOTFILES[@]}; do
	cp ~/$DOTFILE .
done

for DOTDIR in ${DOTDIRS[@]}; do
	cp -r ~/$DOTDIR .config/
done
