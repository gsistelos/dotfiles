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
eval "$(oh-my-posh init zsh)"

source $ZSH/oh-my-zsh.sh

# Tools
eval "$(uv generate-shell-completion zsh)"

FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
	export PATH="$FNM_PATH:$PATH"
	eval "`fnm env`"
fi

GO_PATH="/usr/local/go/bin"
if [ -d "$GO_PATH" ]; then
	export PATH="$GO_PATH:$PATH"
fi

. "$HOME/.cargo/env"
