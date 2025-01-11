# Hyprland

```sh
pacman -S --needed hyprland hyprpaper xdg-desktop-portal-hyprland polkit-kde-agent qt5-wayland dunst
```

## Fonts

```sh
pacman -S --needed noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
```

## Screenshot

```sh
pacman -S --needed grim slurp wl-clipboard
```

## Nvidia + Wayland

```sh
pacman -S --needed nvidia
```

Add this `MODULES` to `/etc/mkinitcpio.conf`:

```
MODULES=(... nvidia nvidia_modeset nvidia_uvm nvidia_drm ...)
```

Add this line to `/etc/modprobe.d/nvidia.conf`:

```
options nvidia_drm modeset=1 fbdev=1
```

Run:

```sh
sudo mkinitcpio -P
```

Reboot.
