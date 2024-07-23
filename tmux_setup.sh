#!/bin/env bash

PACKAGES=("tmux" "git" "curl")

required_packages_error () {
    echo "Required packages:"
    for PACKAGE in "${PACKAGES[@]}"; do
        echo -e "- $PACKAGE"
    done

    echo "Please install these before running this script."
    exit 1
}

check_installed () {
    which ${1}

    if [ $? -ne 0 ]; then
        echo "${1} not installed."
        required_packages_error
    fi
}

for PACKAGE in "${PACKAGES[@]}"; do
    check_installed "$PACKAGE"
done

# tmux plugin manager
git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# .tmux.conf
curl -fsSL https://raw.githubusercontent.com/gsistelos/dotfiles/main/.tmux.conf -o ~/.tmux.conf
