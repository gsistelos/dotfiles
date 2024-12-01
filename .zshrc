export ZSH="$HOME/.oh-my-zsh"

export EDITOR="nvim"
export BROWSER="firefox"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

export PATH="$HOME/.local/bin:$PATH"

source $ZSH/oh-my-zsh.sh
