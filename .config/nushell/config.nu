# `env.nu` is loaded before `config.nu`.

# Zoxide: A smarter `cd` command.
# The file is created in `env.nu`.
source ~/.zoxide.nu
alias cd = z

# Oh My Posh: A prompt theme engine for any shell.
^oh-my-posh init nu
