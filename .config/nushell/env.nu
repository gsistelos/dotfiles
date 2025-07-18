# `env.nu` is loaded before `config.nu`.

# Append paths to $env.PATH.
const paths = [
    ($nu.home-path | path join ".cargo/bin"),
    ($nu.home-path | path join ".go/bin"),
    ($nu.home-path | path join ".local/bin"),
]

for path in $paths {
    $env.PATH = ($env.PATH | append $path)
}

# Set Neovim as default editor.
$env.config.buffer_editor = "nvim"

# Setup Zoxide for nushell.
# The file is sourced in `config.nu`.
zoxide init nushell | save -f ~/.zoxide.nu
