#!/usr/bin/env sh

source ./utils.sh

REQUIRED_PACKAGES=(
	"tmux"
	"curl"
)

require_packages

# .tmux.conf
curl -fsSL https://raw.githubusercontent.com/gsistelos/dotfiles/main/.tmux.conf -o ~/.tmux.conf
