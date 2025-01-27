#!/usr/bin/env bash

source utils.sh

REQUIRED_PACKAGES=(
	hyprland
	hyprpaper
	xdg-desktop-portal-hyprland
	polkit-kde-agent
	qt5-wayland
	dunst
	noto-fonts
	noto-fonts-cjk
	noto-fonts-emoji
	noto-fonts-extra

	waybar
	ttf-ubuntu-nerd

	rofi

	alacritty
	ttf-jetbrains-mono-nerd
)

require_packages

CONFIG_DIR="../.config"
USER_CONFIG_DIR="$HOME/.config"

cp -r ${CONFIG_DIR}/hypr      ${USER_CONFIG_DIR}
cp -r ${CONFIG_DIR}/waybar    ${USER_CONFIG_DIR}
cp -r ${CONFIG_DIR}/rofi      ${USER_CONFIG_DIR}
cp -r ${CONFIG_DIR}/alacritty ${USER_CONFIG_DIR}
