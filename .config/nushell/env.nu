# `env.nu` is loaded before `config.nu`.

# Append paths to $env.PATH.
const paths = [
    $nu.home-path | path join ".cargo/bin",
    $nu.home-path | path join ".go/bin",
    $nu.home-path | path join ".local/bin",
    $nu.home-path | path join ".local/share/fnm",
]

for path in $paths {
    $env.PATH = $env.PATH | append $path
}

# Load fnm environment variables
^fnm env --json | from json | load-env

$env.PATH = $env.PATH | append ($env.FNM_MULTISHELL_PATH | path join 'bin')

# Create a hook that runs `fnm use --install-if-missing`
$env.config.hooks.env_change.PWD = (
    $env.config.hooks.env_change.PWD? | append {
        condition: {|| ['.nvmrc' '.node-version', 'package.json'] | any {|file| $file | path exists}}
        code: {|| ^fnm use --install-if-missing}
    }
)

# Set Neovim as default editor.
$env.config.buffer_editor = "nvim"

# Setup Zoxide for nushell.
# The file is sourced in `config.nu`.
^zoxide init nushell | save -f ~/.zoxide.nu
