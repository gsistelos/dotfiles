#!/bin/env bash

DOTFILES=(
	".tmux.conf"
	".bashrc"
)

for DOTFILE in ${DOTFILES[@]}; do
	cp -r $DOTFILE ~/$DOTFILE
done

cp -r .config ~/
