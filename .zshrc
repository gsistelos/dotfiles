# Install dependencies if missing
if [ ! -e "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
	git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
	git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

	curl -s https://ohmyposh.dev/install.sh | bash -s
fi

if [ -z "$(which uv)" ]; then
	curl -LsSf https://astral.sh/uv/install.sh | sh

	curl -fsSL https://fnm.vercel.app/install | bash

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

	curl -sL https://go.dev/dl/go1.26.1.linux-amd64.tar.gz -o /tmp/go.tar.gz
	tar -C "$HOME/.local" -xzf /tmp/go.tar.gz
fi

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
export PATH="$HOME/.local/go/bin:$HOME/.local/bin:$PATH"

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

. "$HOME/.cargo/env"
