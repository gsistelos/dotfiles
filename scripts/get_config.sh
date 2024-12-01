#!/usr/bin/env bash

DOTDIRS=(
	".config/alacritty"
	".config/hypr"
	".config/i3"
	".config/rofi"
	".config/waybar"
)

for DOTDIR in ${DOTDIRS[@]}; do
	cp -r ~/$DOTDIR .config/
done
