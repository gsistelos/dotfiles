# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls="ls --color=auto"
alias grep="grep --color=auto"

# Default apps
export EDITOR="nvim"
export BROWSER="firefox"

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
export PATH="$HOME/.local/bin:$PATH"

# Tools
eval "$(uv generate-shell-completion bash)"

FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
	export PATH="$FNM_PATH:$PATH"
	eval "`fnm env`"
fi
