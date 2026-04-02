export ZSH="$HOME/.oh-my-zsh"

# Default apps
export EDITOR="nvim"
export BROWSER="brave"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

# Path
export PATH="$HOME/.local/bin:$PATH"

# Prompt
if command -v oh-my-posh >/dev/null 2>&1; then
	eval "$(oh-my-posh init zsh)"
fi

source $ZSH/oh-my-zsh.sh

# Tools
if command -v uv >/dev/null 2>&1; then
	eval "$(uv generate-shell-completion zsh)"
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
