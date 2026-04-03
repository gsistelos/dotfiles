#!/usr/bin/env bash

source "$(dirname "${0}")/utils.sh"


check_distro() {
	if [ ! -f /etc/os-release ]; then
		log_fatal "/etc/os-release is not a regular file"
	fi

	local distros="Arch CachyOS Ubuntu Debian"

	for distro in ${distros}; do
		local lowercase_distro
		lowercase_distro="$(echo "${distro}" | tr "A-Z" "a-z")"

		if grep -q "^ID=${lowercase_distro}$" /etc/os-release; then
			DISTRO="${distro}"
			log_info "Running script for ${distro} distro..."
		fi
	done

	if [ -z "${DISTRO:-}" ]; then
		local distros_str
		distros_str="$(echo "${distros}" | sed -E 's/ /, /g; s/, ([^,]*)$/ and \1/')"
		log_fatal "This script only supports ${distros_str} distros"
	fi

	if ! yn_question "Continue?"; then
		log_info "Exiting..."
		exit 0
	fi
}


install_packages() {
	local common_packages="git less curl unzip make bash zsh tmux"

	local update_command
	local install_command

	if [ "${DISTRO}" = "Arch" ] || [ "${DISTRO}" = "CachyOS" ]; then
		local pacman_packages="${common_packages}"
		update_command="sudo pacman -Syu --noconfirm"
		install_command="sudo pacman -S --needed --noconfirm ${pacman_packages}"
	elif [ "${DISTRO}" = "Ubuntu" ] || [ "${DISTRO}" = "Debian" ]; then
		local apt_packages="${common_packages}"
		update_command="sudo apt update && sudo apt upgrade -y"
		install_command="sudo apt install -y ${apt_packages}"
	fi

	log_info "Updating packages..."
	if ! eval "${update_command}"; then
		log_fatal "Failed to update packages"
	fi

	log_info "Installing packages..."
	if ! eval "${install_command}"; then
		log_fatal "Failed to install packages"
	fi
}


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

	ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

	ZSH_AUTOSUGGESTIONS="${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
	if [ ! -d "${ZSH_AUTOSUGGESTIONS}" ] && ! git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_AUTOSUGGESTIONS}"; then
		log_fatal "Failed to install zsh-autosuggestions"
	fi

	ZSH_SYNTAX_HIGHLIGHTING="${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
	if [ ! -d "${ZSH_SYNTAX_HIGHLIGHTING}" ] && ! git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_SYNTAX_HIGHLIGHTING}"; then
		log_fatal "Failed to install zsh-syntax-highlighting"
	fi
}


check_distro
install_packages
install_zsh_plugins
