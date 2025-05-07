#!/usr/bin/env sh

source ./utils.sh

require_pkg_manager
require_packages "curl bash unzip"

# uv
curl -LsSf https://astral.sh/uv/install.sh | env INSTALLER_NO_MODIFY_PATH=1 sh

# fnm
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

FILES="$HOME/.bashrc"

bkp_files "$FILES"
link_dots "$FILES"
