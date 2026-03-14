# Set XDG_CONFIG_HOME if not set
XDG_CONFIG_HOME ?= $(HOME)/.config

DOTFILES_CONFIG_DIR := $(CURDIR)/.config

BASH := $(HOME)/.bashrc
ZSH := $(HOME)/.zshrc
TMUX := $(HOME)/.tmux.conf
HYPR := $(XDG_CONFIG_HOME)/hypr
FOOT := $(XDG_CONFIG_HOME)/foot

.PHONY: help
help:
	@echo "Usage:"
	@echo "  make all      Install all (cli + desktop)"
	@echo "  make cli      Install CLI config (bash, zsh, tmux)"
	@echo "  make desktop  Install desktop config (hypr, foot)"
	@echo "  make TARGET   Install a single symlink (e.g. make ~/.bashrc)"

.PHONY: all
all: cli desktop

.PHONY: cli
cli: $(BASH) $(ZSH) $(TMUX)

.PHONY: desktop
desktop: $(HYPR) $(FOOT)

$(XDG_CONFIG_HOME):
	mkdir -p "$(XDG_CONFIG_HOME)"

define symlink_recipe
	if [ -e "$@" ]; then mv "$@" "/tmp/$(notdir $@)"; fi
	ln -s "$<" "$@"
endef

$(XDG_CONFIG_HOME)/%: $(DOTFILES_CONFIG_DIR)/% | $(XDG_CONFIG_HOME)
	$(symlink_recipe)

$(HOME)/%: $(CURDIR)/%
	$(symlink_recipe)
