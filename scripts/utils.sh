#!/usr/bin/env sh

yn_question() {
    printf "%s [Y/n] " "$1"
    read -r ANSWER

    case "$ANSWER" in
        [yY] | [yY][eE][sS] | "")
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

require_pkg_manager() {
    PKG_MANAGER=$1

    printf "Checking if '%s' is installed...\n" "$PKG_MANAGER"
    if command -v "$PKG_MANAGER" >/dev/null 2>&1; then
        return 0
    fi

    if ! yn_question "'$PKG_MANAGER' is not installed. Would you like to install it?"; then
        echo "Installation aborted by user."
        return 1
    fi

    TEMP_DIR=$(mktemp -d "/tmp/$PKG_MANAGER.XXXXXX")
    if [ ! -d "$TEMP_DIR" ]; then
        echo "Failed to create temporary directory."
        return 1
    fi

    echo "Cloning '$PKG_MANAGER' into '$TEMP_DIR'..."
    if ! git clone "https://aur.archlinux.org/$PKG_MANAGER.git" "$TEMP_DIR"; then
        echo "Failed to clone repository."
        return 1
    fi

    if ! cd "$TEMP_DIR"; then
        echo "Failed to enter directory '$TEMP_DIR'."
        return 1
    fi

    if ! makepkg -si; then
        echo "Failed to build and install package."
        return 1
    fi

    return 0
}

require_packages() {
    REQUIRED_PACKAGES=$1

    echo "Updating packages..."
    if ! "$PKG_MANAGER" -Syu --noconfirm; then
        echo "Failed to update packages."
        return 1
    fi

    echo "Checking for required packages..."
    MISSING_PACKAGES=""
    for PACKAGE in $REQUIRED_PACKAGES; do
        # Check if package exists
        if ! "$PKG_MANAGER" -Ss "^$PACKAGE$" >/dev/null 2>&1; then
            echo "Package '$PACKAGE' does not exist."
            return 1
        fi

        # Check if package is installed
        if ! "$PKG_MANAGER" -Q "$PACKAGE" >/dev/null 2>&1; then
            MISSING_PACKAGES="$MISSING_PACKAGES $PACKAGE"
        fi
    done

    # Return if there are no missing packages
    if [ -z "$MISSING_PACKAGES" ]; then
        return 0
    fi

    echo "Missing packages:"
    for PACKAGE in $MISSING_PACKAGES; do
        echo "- $PACKAGE"
    done

    if ! yn_question "Would you like to install these packages?"; then
        echo "Installation aborted by user."
        return 1
    fi

    if ! "$PKG_MANAGER" -S --needed --noconfirm $MISSING_PACKAGES; then
        echo "Failed to install missing packages."
        return 1
    fi

    return 0
}

bkp_files() {
    BKP_PATHS=$1

    echo "Backing up files..."

    for TARGET_PATH in $BKP_PATHS; do
        if [ ! -e "$TARGET_PATH" ]; then
            continue
        fi

        TARGET_PATH_BASENAME=$(basename "$TARGET_PATH")

        TEMP_DIR=$(mktemp -u "/tmp/$TARGET_PATH_BASENAME.XXXXXX")

        echo "Moving '$TARGET_PATH' to '$TEMP_DIR'..."
        if ! mv "$TARGET_PATH" "$TEMP_DIR"; then
            echo "Failed to back up '$TARGET_PATH'."
            return 1
        fi
    done

    return 0
}

link_dots() {
    LINK_PATHS=$1

    echo "Linking files..."

    DOTS_DIR=$(cd .. && pwd)

    for TARGET_PATH in $LINK_PATHS; do
        LINK="$DOTS_DIR/$(basename "$TARGET_PATH")"
        if [ ! -e "$LINK" ]; then
            echo "File '$LINK' does not exit."
            return 1
        fi

        echo "Linking '$TARGET_PATH' to '$LINK'..."
        if ! ln -s "$LINK" "$TARGET_PATH"; then
            echo "Failed to create link for '$TARGET_PATH'."
            return 1
        fi
    done

    return 0
}
