#!/usr/bin/env sh

source ./utils.sh

REQUIRED_PACKAGES=(
	"tmux"
	"curl"
)

require_packages

DOTS="$(cd .. && pwd)"

ln -s ${DOTS}/.tmux.conf ${HOME}
