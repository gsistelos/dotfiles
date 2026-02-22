# dotfiles

## Required packages

**Required for CLI**:

```sh
sudo pacman -S --needed \
    git \
    less \
    make \
    unzip \
    bash \
    zsh \
    tmux
```

**Required for desktop**:

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
    adw-gtk-theme \
    hyprlauncher \
    hyprpaper \
    grim \
    slurp \
    wl-clipboard
```

**Dark theme**:

```sh
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark # for GTK4 apps
gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3" # for GTK3 apps
```

## Usage

```sh
git clone --depth 1 https://github.com/gsistelos/dotfiles
make # to create symbolic links for all configuration files
make ~/.bashrc # to create a symbolic link for `.bashrc`
make ~/.config/hypr # to create a symbolic link for `.config/hypr`
```
