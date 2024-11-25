export ZSH="$HOME/.oh-my-zsh"

export EDITOR="nvim"
export BROWSER="firefox"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
	git
	zsh-nvm
	zsh-autosuggestions
	zsh-syntax-highlighting
)

export PNPM_HOME="$HOME/.local/share/pnpm"

export PATH="$HOME/.local/bin:$HOME/go/bin:$PNPM_HOME:$PATH"

source $ZSH/oh-my-zsh.sh
