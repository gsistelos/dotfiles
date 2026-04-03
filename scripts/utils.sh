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

log_success() {
    local message="$1"
    printf "%s %s\n" "${SUCCESS}" "${message}"
}

log_info() {
	local message="$1"
	printf "%s %s\n" "${INFO}" "${message}"
}

log_warning() {
	local message="$1"
	printf "%s %s\n" "${WARNING}" "${message}"
}

log_error() {
	local message="$1"
	printf "%s %s\n" "${ERROR}" "${message}" >&2
}

log_fatal() {
	local message="$1"
	printf "%s %s\n" "${ERROR}" "${message}" >&2
	exit 1
}
