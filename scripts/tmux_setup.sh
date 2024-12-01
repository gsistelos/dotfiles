#!/usr/bin/env bash

source scripts/utils.sh

PACKAGES=(
	"tmux"
	"curl"
)

ensure_installed

# .tmux.conf
curl -fsSL https://raw.githubusercontent.com/gsistelos/dotfiles/main/.tmux.conf -o ~/.tmux.conf
