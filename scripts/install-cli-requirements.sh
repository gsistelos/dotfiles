#!/usr/bin/env sh

sudo pacman -S --needed --noconfirm \
	git \
	less \
	make \
	unzip \
	bash \
	zsh \
	tmux

curl -LsSf https://astral.sh/uv/install.sh | sh

curl -fsSL https://fnm.vercel.app/install | bash
