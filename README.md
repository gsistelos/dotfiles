# dotfiles

## Required packages

**Required for CLI**:

```sh
./scripts/install-cli-requirements.sh
```

**Required for desktop**:

```sh
./scripts/install-desktop-requirements.sh
```

## Dark theme:

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
