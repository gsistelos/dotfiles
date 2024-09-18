#!/bin/env bash

source utils.sh

PACKAGES=(
	"tmux"
	"git"
	"curl"
)

ensure_installed

# tmux plugin manager
git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# .tmux.conf
curl -fsSL https://raw.githubusercontent.com/gsistelos/dotfiles/main/.tmux.conf -o ~/.tmux.conf
