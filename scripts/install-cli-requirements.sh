#!/usr/bin/env bash

set -euo pipefail

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

SUCCESS="[${GREEN}SUCCESS${RESET}]"
INFO="[${BLUE}INFO${RESET}]"
WARNING="[${YELLOW}WARNING${RESET}]"
ERROR="[${RED}ERROR${RESET}]"


yn_question() {
	local question="$1"

	printf "%s [Y/n] " "${question}"
	read -r answer

	case ${answer} in
		[yY] | [yY][eE][sS] | "")
			return 0
			;;
		*)
			return 1
			;;
	esac
}


check_distro() {
	if [ ! -f /etc/os-release ]; then
		echo "${ERROR} /etc/os-release is not a regular file"
		exit 1
	fi

	local distros="Arch Ubuntu Debian"

	for distro in ${distros}; do
		local lowercase_distro
		lowercase_distro="$(echo "${distro}" | tr "A-Z" "a-z")"

		if grep -q "^ID=${lowercase_distro}$" /etc/os-release; then
			DISTRO="${distro}"
			echo "${INFO} Running script for ${distro} distro..."
		fi
	done

	if [ -z "${DISTRO:-}" ]; then
		local distros_str
		distros_str="$(echo "$distros" | sed -E 's/ /, /g; s/, ([^,]*)$/ and \1/')"
		echo "${ERROR} This script only supports ${distros_str} distros"
		exit 1
	fi

	if ! yn_question "Continue?"; then
		exit 0
	fi
}


install_packages() {
	local update_packages
	local install_packages

	if [ "${DISTRO}" = "Arch" ]; then
		update_packages="sudo pacman -Syu --noconfirm"
		install_packages="sudo pacman -S --needed --noconfirm git less curl unzip make bash zsh tmux"
	elif [ "$DISTRO" = "Ubuntu" ] || [ "$DISTRO" = "Debian" ]; then
		update_packages="sudo apt update && sudo apt upgrade -y"
		install_packages="sudo apt install -y git less curl unzip make bash zsh tmux"
	fi

	echo "${INFO} Updating packages..."
	if ! eval "${update_packages}"; then
		echo "${ERROR} Failed to update packages"
		exit 1
	fi

	echo "${INFO} Installing packages..."
	if ! eval "${install_packages}"; then
		echo "${ERROR} Failed to install packages"
		exit 1
	fi
}


install_zsh_plugins() {
	echo "${INFO} Installing zsh plugins..."

	ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
	if [ ! -d "$HOME/.oh-my-zsh" ]; then
		local install_script
		install_script="$(mktemp)"
		if ! curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o "${install_script}"; then
			echo "${ERROR} Failed to download oh-my-zsh installer"
			rm -f "${install_script}"
			exit 1
		fi

		if ! sh "${install_script}" --unattended --keep-zshrc; then
			echo "${ERROR} Failed to install oh-my-zsh"
			rm -f "${install_script}"
			exit 1
		fi
		rm -f "${install_script}"
	else
		echo "${INFO} oh-my-zsh already installed, skipping..."
	fi

	if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && ! git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"; then
		echo "${ERROR} Failed to install zsh-autosuggestions"
		exit 1
	fi

	if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && ! git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"; then
		echo "${ERROR} Failed to install zsh-syntax-highlighting"
		exit 1
	fi
}


check_distro
install_packages
install_zsh_plugins
