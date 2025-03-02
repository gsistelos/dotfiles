#!/usr/bin/env sh

source ./utils.sh

REQUIRED_PACKAGES=(
	"bash"
	"curl"
	"unzip"
)

require_packages

DOTS="$(cd .. && pwd)"

ln -s ${DOTS}/.bashrc ${HOME}

# uv
curl -LsSf https://astral.sh/uv/install.sh | env INSTALLER_NO_MODIFY_PATH=1 sh

# fnm
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
