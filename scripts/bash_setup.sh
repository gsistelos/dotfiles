#!/bin/env bash

source utils.sh

PACKAGES=("bash" "curl" "bash-completion")

# git-prompt.sh
curl -fsSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh

# .bashrc
curl -fsSL https://raw.githubusercontent.com/gsistelos/dotfiles/main/.bashrc -o ~/.bashrc
