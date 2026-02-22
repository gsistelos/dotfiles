# Install dependencies if missing
if [ ! -e "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
	git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
	git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

	curl -s https://ohmyposh.dev/install.sh | bash -s

	curl -LsSf https://astral.sh/uv/install.sh | sh

	curl -fsSL https://fnm.vercel.app/install | bash
fi

export ZSH="$HOME/.oh-my-zsh"

# Default apps
export EDITOR="nvim"
export BROWSER="firefox"

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
