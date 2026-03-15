# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Install dependencies if missing
if [ -z "$(which uv)" ]; then
	curl -LsSf https://astral.sh/uv/install.sh | sh

	curl -fsSL https://fnm.vercel.app/install | bash

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

	curl -sL https://go.dev/dl/go1.26.1.linux-amd64.tar.gz -o /tmp/go.tar.gz
	tar -C "$HOME/.local" -xzf /tmp/go.tar.gz
fi

# Aliases
alias ls="ls --color=auto"
alias grep="grep --color=auto"

# Default apps
export EDITOR="nvim"
export BROWSER="brave"

# Colors
NO_COLOR="\033[0m"
BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"

# Prompt
DIR="$GREEN\w$NO_COLOR"
PS1="$BLUE[$NO_COLOR $DIR $BLUE]\$$NO_COLOR "

# Path
export PATH="$HOME/.local/go/bin:$HOME/.local/bin:$PATH"

# Tools
eval "$(uv generate-shell-completion bash)"

FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
	export PATH="$FNM_PATH:$PATH"
	eval "`fnm env`"
fi

. "$HOME/.cargo/env"
