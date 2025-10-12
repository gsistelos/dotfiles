# If not running interactively, don't do anything.
if [[ $- != *i* ]]; then
	return
fi

not_found_installing_message() {
	echo "$1 not found, installing..."
}

# Create binaries directory if not found
BINARIES="$HOME/.local/bin"

if [[ ! -d $BINARIES ]]; then
	mkdir -p "$BINARIES"
fi

export PATH="$PATH:$BINARIES"

# Create config directory if not found
CONFIG_DIR="$HOME/.config"

if [[ ! -d $CONFIG_DIR ]]; then
	mkdir -p "$CONFIG_DIR"
fi

# Setup `nvim` if not found
NVIM_BIN="$BINARIES/nvim"
NVIM_APP_IMAGE_URI="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage"

if ! which nvim > /dev/null; then
	not_found_installing_message "$NVIM_BIN"
	curl -fsSL "$NVIM_APP_IMAGE_URI" -o "$NVIM_BIN" && chmod u+x "$NVIM_BIN"
fi

export EDITOR="nvim"

# Setup nvim config if not found
NVIM_CONFIG_DIR="$CONFIG_DIR/nvim"
NVIM_CONFIG_URI="https://github.com/gsistelos/nvim.git"

if [[ ! -d $NVIM_CONFIG_DIR ]]; then
	not_found_installing_message "$NVIM_CONFIG_DIR"
	git clone --depth=1 "$NVIM_CONFIG_URI" "$NVIM_CONFIG_DIR"
fi

# Setup rust if not found
CARGO_DIR="$HOME/.cargo"
RUSTUP_URI="https://sh.rustup.rs"

if [[ ! -d $CARGO_DIR ]]; then
	not_found_installing_message "$CARGO_DIR"
	curl -fsSL "$RUSTUP_URI" | sh -s -- -y --no-modify-path
fi

export PATH="$PATH:$CARGO_DIR/bin"

source "$CARGO_DIR/env"

# Setup `go` if not found
GO_DEST="$HOME/.local"
GO_DIR="$GO_DEST/go"
GO_VERSION="1.25.2"
GO_ARCH="linux-amd64"
GO_TAR_URI="https://go.dev/dl/go$GO_VERSION.$GO_ARCH.tar.gz"
GO_TAR="/tmp/go$GO_VERSION.$GO_ARCH.tar.gz"

if [[ ! -d $GO_DIR ]]; then
	not_found_installing_message "$GO_DIR"
	curl -fsSL "$GO_TAR_URI" -o "$GO_TAR" && mkdir -p "$GO_DEST" && tar -C "$GO_DEST" -xzf "$GO_TAR"
fi

export PATH="$PATH:$GO_DIR/bin"

# Setup `fnm` if not found
FNM_DIR="$HOME/.local/share/fnm"
FNM_INSTALLER_URI="https://fnm.vercel.app/install"
FNM_USE_VERSION="24"

if [[ ! -d $FNM_DIR ]]; then
	not_found_installing_message "$FNM_DIR"
	curl -fsSL "$FNM_INSTALLER_URI" | bash -s -- --skip-shell | fnm use --install-if-missing "$FNM_USE_VERSION"
fi

export PATH="$PATH:$FNM_DIR"

source <(fnm env --use-on-cd --shell bash)

# Setup `uv` if not found
UV_BIN="$BINARIES/uv"
UV_INSTALLER_URI="https://astral.sh/uv/install.sh"

if ! which uv > /dev/null; then
	not_found_installing_message "$UV_BIN"
	curl -fsSL "$UV_INSTALLER_URI" | sh
fi

# source <(uv generate-shell-completion bash)
# source <(uvx generate-shell-completion bash)

# Setup `oh-my-posh` if not found
OH_MY_POSH_BIN="$BINARIES/oh-my-posh"
OH_MY_POSH_INSTALLER_URI="https://ohmyposh.dev/install.sh"

if ! which oh-my-posh > /dev/null; then
	not_found_installing_message "$OH_MY_POSH_BIN"
	curl -s "$OH_MY_POSH_INSTALLER_URI" | bash -s
fi

source <(oh-my-posh init bash)

# Setup `eza` if not found
if ! which eza > /dev/null; then
	sudo apt install -y eza
fi

alias ls=eza

# Setup `bat` if not found
if ! which batcat > /dev/null; then
	sudo apt install -y bat
fi

# Setup `zoxide` if not found
if ! which zoxide > /dev/null; then
	sudo apt install -y zoxide
fi

source <(zoxide init bash)
