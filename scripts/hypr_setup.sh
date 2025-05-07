#!/usr/bin/env sh

source ./utils.sh

require_pkg_manager
require_packages "greetd-regreet uwsm hyprland hyprpaper xdg-desktop-portal-hyprland hyprpolkitagent qt5-wayland dunst noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra waybar ttf-ubuntu-nerd rofi alacritty ttf-jetbrains-mono-nerd"

FILES="$HOME/.config/hypr $HOME/.config/waybar $HOME/.config/rofi $HOME/.config/alacritty $HOME/.wallpapers"

bkp_files "$FILES"
link_dots "$FILES"

systemctl --user enable --now hyprpolkitagent.service
