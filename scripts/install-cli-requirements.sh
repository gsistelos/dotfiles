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
	if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc; then
		echo "${ERROR} Failed to install oh-my-zsh"
		exit 1
	fi

	if ! git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"; then
		echo "${ERROR} Failed to install zsh-autosuggestions"
		exit 1
	fi

	if ! git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"; then
		echo "${ERROR} Failed to install zsh-syntax-highlighting"
		exit 1
	fi

	if ! curl -s https://ohmyposh.dev/install.sh | bash -s; then
		echo "${ERROR} Failed to install oh-my-posh"
		exit 1
	fi
}


install_uv() {
	echo "${INFO} Installing uv..."
	if ! curl -LsSf https://astral.sh/uv/install.sh | sh; then
		echo "${ERROR} Failed to install uv"
		exit 1
	fi
}


install_fnm() {
	echo "${INFO} Installing fnm..."
	if ! curl -fsSL https://fnm.vercel.app/install | bash; then
		echo "${ERROR} Failed to install fnm"
		exit 1
	fi
}


install_rustup() {
	echo "${INFO} Installing rustup..."
	if ! curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; then
		echo "${ERROR} Failed to install rustup"
		exit 1
	fi
}


install_golang() {
	echo "${INFO} Installing golang..."

	if [ "${DISTRO}" = "Arch" ]; then
		if ! sudo pacman -S --needed --noconfirm golang; then
			echo "${ERROR} Failed to install golang"
			exit 1
		fi
	elif [ "$DISTRO" = "Ubuntu" ] || [ "$DISTRO" = "Debian" ]; then
		local tar_gz="go1.26.1.linux-amd64.tar.gz"

		echo "${INFO} Installing golang..."
		if ! curl -fL https://go.dev/dl/${tar_gz} -o /tmp/${tar_gz}; then
			echo "${ERROR} Failed to curl ${tar_gz}"
			exit 1
		fi

		if ! sudo tar -C /usr/local -xzf /tmp/${tar_gz}; then
			echo "${ERROR} Failed to extract ${tar_gz}"
			exit 1
		fi
	fi
}


check_distro
install_packages
install_zsh_plugins
install_uv
install_fnm
install_rustup
install_golang
