#!/usr/bin/env sh

source ./utils.sh

REQUIRED_PACKAGES=(
	greetd-regreet

	uwsm

	hyprland
	hyprpaper
	xdg-desktop-portal-hyprland
	hyprpolkitagent
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

DOTS_CONFIG="$(cd .. && pwd)/.config"
USER_CONFIG="${HOME}/.config"

ln -s ${DOTS_CONFIG}/hypr      ${USER_CONFIG}
ln -s ${DOTS_CONFIG}/waybar    ${USER_CONFIG}
ln -s ${DOTS_CONFIG}/rofi      ${USER_CONFIG}
ln -s ${DOTS_CONFIG}/alacritty ${USER_CONFIG}

DOTS="$(cd .. && pwd)"

ln -s ${DOTS}/.wallpapers ${HOME}

systemctl --user enable --now hyprpolkitagent.service
