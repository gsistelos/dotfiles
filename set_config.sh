#!/bin/env bash

DOTFILES=(
    ".tmux.conf"
    ".zshrc"
)

for DOTFILE in ${DOTFILES[@]}; do
    cp -r $DOTFILE ~/$DOTFILE
done

cp -r .config ~/
