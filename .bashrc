# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Append paths to $PATH.
export PATH="$PATH:$HOME/.cargo/bin:$HOME/.go/bin:$HOME/.local/bin:$HOME/.local/share/fnm"

# Set Neovim as default editor.
export EDITOR="nvim"

# fnm: Fast and simple Node.js version manager.
eval "$(fnm env)"

# Zoxide: A smarter `cd` command.
eval "$(zoxide init bash)"

# Oh My Posh: A prompt theme engine for any shell.
eval "$(oh-my-posh init bash)"
