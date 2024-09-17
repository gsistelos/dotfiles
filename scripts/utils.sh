#!/bin/env bash

required_packages_error () {
    echo "Required packages:"
    for PACKAGE in "${PACKAGES[@]}"; do
        echo -e "- $PACKAGE"
    done

    echo "Please install these before running this script."
    exit 1
}

ensure_installed () {
    for PACKAGE in "${PACKAGES[@]}"; do
        pacman -Q ${PACKAGE} > /dev/null
        if [ $? -ne 0 ]; then
            required_packages_error
        fi
    done
}
