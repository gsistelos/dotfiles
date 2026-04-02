# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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
if command -v oh-my-posh >/dev/null 2>&1; then
	eval "$(oh-my-posh init bash)"
fi

# Path
export PATH="$HOME/.local/bin:$PATH"

# Tools
if command -v uv >/dev/null 2>&1; then
	eval "$(uv generate-shell-completion bash)"
fi

FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
	export PATH="$FNM_PATH:$PATH"
fi

if command -v fnm >/dev/null 2>&1; then
	eval "$(fnm env)"
fi

GO_PATH="/usr/local/go/bin"
if [ -d "$GO_PATH" ]; then
	export PATH="$GO_PATH:$PATH"
fi

if [ -f "$HOME/.cargo/env" ]; then
	. "$HOME/.cargo/env"
fi
