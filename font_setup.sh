#!/bin/bash

FONTS_PATH=/usr/share/fonts/TTF

sudo curl -fsSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o $FONTS_PATH/'MesloLGS NF Regular.ttf'
sudo curl -fsSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -o $FONTS_PATH/'MesloLGS NF Bold.ttf'
sudo curl -fsSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -o $FONTS_PATH/'MesloLGS NF Italic.ttf'
sudo curl -fsSL https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -o $FONTS_PATH/'MesloLGS NF Bold Italic.ttf'
