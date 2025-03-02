# Hyprland

## Nvidia + Wayland

### See

- https://wiki.hyprland.org/Nvidia/#installation
- https://wiki.hyprland.org/Nvidia/#installation

### TL;DR

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
