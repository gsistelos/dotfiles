#!/usr/bin/env bash
set -euo pipefail

RED=$'\033[1;31m'
GREEN=$'\033[1;32m'
YELLOW=$'\033[1;33m'
BLUE=$'\033[1;34m'
RESET=$'\033[0m'

SUCCESS="[${GREEN}SUCCESS${RESET}]"
INFO="[${BLUE}INFO${RESET}]"
WARNING="[${YELLOW}WARNING${RESET}]"
ERROR="[${RED}ERROR${RESET}]"


yn_question() {
	local question="${1}"

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

log_success() {
    local message="${1}"
    printf "%s %s\n" "${SUCCESS}" "${message}"
}

log_info() {
	local message="${1}"
	printf "%s %s\n" "${INFO}" "${message}"
}

log_warning() {
	local message="${1}"
	printf "%s %s\n" "${WARNING}" "${message}"
}

log_error() {
	local message="${1}"
	printf "%s %s\n" "${ERROR}" "${message}" >&2
}

log_fatal() {
	local message="${1}"
	printf "%s %s\n" "${ERROR}" "${message}" >&2
	exit 1
}

check_distro() {
	local distros="${1}"

	if [ ! -f /etc/os-release ]; then
		log_fatal "/etc/os-release is not a regular file"
	fi

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
	local distros="${1}"
	local update_command="${2}"
	local install_command="${3}"

	if [[ " ${distros} " != *" ${DISTRO} "* ]]; then
		return 0
	fi

	log_info "Updating packages..."
	if ! eval "${update_command}"; then
		log_fatal "Failed to update packages"
	fi

	log_info "Installing packages..."
	if ! eval "${install_command}"; then
		log_fatal "Failed to install packages"
	fi

	return 0
}
