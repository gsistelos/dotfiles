#!/bin/env bash

ensure_installed () {
	for PACKAGE in "${PACKAGES[@]}"; do
		pacman -Q ${PACKAGE} &> /dev/null
		if [ $? -ne 0 ]; then
			echo "Required packages:"
			for PACKAGE in "${PACKAGES[@]}"; do
				echo -e "- $PACKAGE"
			done

			echo "Please install these before running this script."
			exit 1
		fi
	done
}
