#!/usr/bin/env bash

source "$(dirname "${0}")/utils.sh"


install_zsh_plugins() {
	log_info "Installing zsh plugins..."

	if [ ! -d "${HOME}/.oh-my-zsh" ]; then
		local install_script
		install_script="$(mktemp)"
		if ! curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o "${install_script}"; then
			rm -f "${install_script}"
			log_fatal "Failed to download oh-my-zsh installer"
		fi

		if ! sh "${install_script}" --unattended --keep-zshrc; then
			rm -f "${install_script}"
			log_fatal "Failed to install oh-my-zsh"
		fi
		rm -f "${install_script}"
	else
		log_info "oh-my-zsh already installed, skipping..."
	fi

	ZSH_CUSTOM="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"

	ZSH_AUTOSUGGESTIONS="${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
	if [ ! -d "${ZSH_AUTOSUGGESTIONS}" ] && ! git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_AUTOSUGGESTIONS}"; then
		log_fatal "Failed to install zsh-autosuggestions"
	fi

	ZSH_SYNTAX_HIGHLIGHTING="${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
	if [ ! -d "${ZSH_SYNTAX_HIGHLIGHTING}" ] && ! git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_SYNTAX_HIGHLIGHTING}"; then
		log_fatal "Failed to install zsh-syntax-highlighting"
	fi
}


COMMON_PACKAGES="git less curl unzip make bash zsh tmux"

check_distro "Arch CachyOS Ubuntu Debian"
install_packages "Arch CachyOS" "sudo pacman -Syu --noconfirm" "sudo pacman -S --needed --noconfirm ${COMMON_PACKAGES}"
install_packages "Ubuntu Debian" "sudo apt update && sudo apt upgrade -y" "sudo apt install -y ${COMMON_PACKAGES}"
install_zsh_plugins
