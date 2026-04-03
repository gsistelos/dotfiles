#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FIREFOX_DIR="${FIREFOX_DIR:-$HOME/.config/mozilla/firefox}"
PROFILE_GROUPS_DIR="$FIREFOX_DIR/Profile Groups"


find_with_ending() {
	local directory="$1"
	local ending="$2"

	if [ -d "$directory" ]; then
		find "$directory" -maxdepth 1 -name "*${ending}"
	fi
}

create_profile() {
	local path="$1"
	local name="$2"
	local icon="$3"

	echo "info: creating profile: $path, $name, $icon" >&2

	# Default theme values used by Firefox profile groups.
	local default_theme_id="default-theme@mozilla.org"
	local default_theme_fg="rgb(255,255,255)"
	local default_theme_bg="rgb(28,27,34)"

	sqlite3 "$STORE_ID" <<EOF
INSERT INTO Profiles (path, name, avatar, themeId, themeFg, themeBg)
VALUES ('$path', '$name', '$icon', '$default_theme_id', '$default_theme_fg', '$default_theme_bg')
EOF

	if [ ! -d "$FIREFOX_DIR/$path" ]; then
		mkdir -p "$FIREFOX_DIR/$path"
	fi

	if [ ! -f "$FIREFOX_DIR/$path/user.js" ]; then
		cp -f "$SCRIPT_DIR/user.js" "$FIREFOX_DIR/$path/user.js"
	fi
}


# Get Profile Groups database
STORE_ID="$(find_with_ending "$PROFILE_GROUPS_DIR" ".sqlite" | head -n 1)"
if [ -z "$STORE_ID" ]; then
	echo "error: no Firefox Profile Groups database found" >&2
	exit 1
fi


# Create default profile
default_release_directory="$(find_with_ending "$FIREFOX_DIR" ".default-release" | head -n 1)"
if [ -z "$default_release_directory" ]; then
	echo "error: failed to find default release directory" >&2
	exit 1
fi

create_profile "$(basename "$default_release_directory")" "Default" "star"


# Create custom profiles
chars="abcdefghijklmnopqrstuvwxyz0123456789"

hash=""
for i in {1..8} ; do
	hash+="${chars:RANDOM % ${#chars}:1}"
done

create_profile "$hash.atomo" "Atomo" "star"
create_profile "$hash.capstone" "Capstone" "star"
create_profile "$hash.austral" "Austral" "star"
