#!/usr/bin/env sh

source ./utils.sh

require_pkg_manager
require_packages "curl tmux"

FILES="$HOME/.tmux.conf"

bkp_files "$FILES"
link_dots "$FILES"
