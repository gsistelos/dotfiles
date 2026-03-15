#!/usr/bin/env sh

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
	echo -n "$1 [Y/n] "
	read -r ANSWER

	case $ANSWER in
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
		local lowercase_distro=$(echo ${distro} | tr "A-Z" "a-z")

		if grep -q "ID=${lowercase_distro}" /etc/os-release; then
			DISTRO=${distro}
			echo "${INFO} Running script for ${distro} distro..."
		fi
	done

	if [ -z ${DISTRO} ]; then
	    local distros_str=$(echo "$distros" | sed -E 's/ /, /g; s/, ([^,]*)$/ and \1/')
		echo "${ERROR} This script only supports ${distros_str} distros"
		exit 1
	fi

	if ! yn_question "Continue?"; then
		exit 0
	fi
}


install_packages() {
	if [ ${DISTRO} = "Arch" ]; then
		UPDATE_PACKAGES="sudo pacman -Syu --noconfirm"
		INSTALL_PACKAGES="sudo pacman -S --needed --noconfirm git less curl unzip make bash zsh tmux"
	elif [ "$DISTRO" = "Ubuntu" ] || [ "$DISTRO" = "Debian" ]; then
		UPDATE_PACKAGES="sudo apt update && sudo apt upgrade -y"
		INSTALL_PACKAGES="sudo apt install -y git less curl unzip make bash zsh tmux"
	fi

	echo "${INFO} Updating packages..."
	if ! eval "${UPDATE_PACKAGES}"; then
		echo "${ERROR} Failed to update packages"
		exit 1
	fi

	echo "${INFO} Installing packages..."
	if ! eval "${INSTALL_PACKAGES}"; then
		echo "${ERROR} Failed to install packages"
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

	if [ ${DISTRO} = "Arch" ]; then
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
install_uv
install_fnm
install_rustup
install_golang
