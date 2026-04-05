#!/usr/bin/env bash

source "$(dirname "$0")/utils.sh"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
FIREFOX_DIR="$XDG_CONFIG_HOME/mozilla/firefox"


find_with_ending() {
	local directory="$1"
	local ending="$2"

	if [ -d "$directory" ]; then
		find "$directory" -maxdepth 1 -name "*$ending"
	fi
}

get_store_id() {
	local store_id
	store_id="$(find_with_ending "$FIREFOX_DIR/Profile Groups" ".sqlite" | head -n 1)"
	if [ -z "$store_id" ]; then
		log_fatal "No StoreID file found"
	fi

	printf "%s\n" "$store_id"
}

get_profile_path() {
	local name="$1"

	local path
	path="$(sqlite3 "$STORE_ID" "SELECT path FROM Profiles WHERE name = '$name'")"
	if [ -z "$path" ]; then
		log_fatal "Profile path not found: $name"
	fi

	printf "%s\n" "$path"
}

configure_profile() {
	local name="$1"
	local avatar="$2"
	local rename="${3:-}"

	local path
	path="$(get_profile_path "$name")"

	sqlite3 "$STORE_ID" "UPDATE Profiles SET avatar = '$avatar' WHERE path = '$path'"

	if [ -n "$rename" ]; then
		sqlite3 "$STORE_ID" "UPDATE Profiles SET name = '$rename' WHERE path = '$path'"
	fi

	cp -f "$SCRIPT_DIR/user.js" "$FIREFOX_DIR/$path/user.js"
}


check_distro "Arch CachyOS"
install_packages "Arch CachyOS" "sudo pacman -Syu --noconfirm" "sudo pacman -S --needed --noconfirm firefox"

STORE_ID="$(get_store_id)"

configure_profile "Original profile" "star"      "Default"
configure_profile "Atomo"            "briefcase"
configure_profile "Capstone"         "briefcase"
configure_profile "Austral"          "briefcase"
