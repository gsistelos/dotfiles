# Hyprland

## Required packages

```sh
sudo pacman -S --needed \
    hyprland \
    foot \
    ttf-meslo-nerd \
    ttf-font-awesome \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    noto-fonts-extra \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    qt5-wayland \
    qt6-wayland \
    qt5ct \
    qt6ct \
    hyprlauncher \
    hyprpaper \
    grim \
    slurp \
    wl-clipboard
```

## Applications theme

```sh
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"
```

## Nvidia + Wayland

### See

- https://wiki.hyprland.org/Nvidia/#installation
