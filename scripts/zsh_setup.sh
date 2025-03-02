#!/usr/bin/env sh

source ./utils.sh

REQUIRED_PACKAGES=(
	"zsh"
	"git"
	"curl"
	"unzip"
)

require_packages

DOTS="$(cd .. && pwd)"

ln -s ${DOTS}/.p10k.zsh ${HOME}
ln -s ${DOTS}/.zshrc ${HOME}

# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# p10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
