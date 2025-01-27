#!/usr/bin/env bash

WARNING="[\033[1;33mWARNING\033[0m]"

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

require_packages() {
	echo "Updating packages..."
	yay -Syu --noconfirm

	echo "Checking for required packages..."
	MISSING_PACKAGES=()

	for PACKAGE in "${REQUIRED_PACKAGES[@]}"; do
		# Check if package exists
		if [ -z "$(yay -Ss ^${PACKAGE}$)" ]; then
			echo -e "${WARNING}: Package '${PACKAGE}' does not exist. Skipping..."
			continue
		fi

		# Check if package is installed
		if [ -z "$(yay -Q ${PACKAGE})" ]; then
			MISSING_PACKAGES+=(${PACKAGE})
		fi
	done

	if [ ${MISSING_PACKAGES[0]} ]; then
		echo "Missing packages:"
		for PACKAGE in "${MISSING_PACKAGES[@]}"; do
			echo "- $PACKAGE"
		done

		if yn_question "Would you like to install these packages?"; then
			yay -S --needed --noconfirm ${MISSING_PACKAGES[@]}
		fi
	fi
}
