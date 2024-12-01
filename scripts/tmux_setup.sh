#!/usr/bin/env bash

source utils.sh

PACKAGES=(
	"tmux"
	"curl"
)

ensure_installed

# .tmux.conf
curl -fsSL https://raw.githubusercontent.com/gsistelos/dotfiles/main/.tmux.conf -o ~/.tmux.conf
