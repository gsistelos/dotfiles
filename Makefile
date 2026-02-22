DOTFILES = $(shell pwd)

CONFIG_DIR = $(HOME)/.config

BASH = $(HOME)/.bashrc
ZSH = $(HOME)/.zshrc
TMUX = $(HOME)/.tmux.conf
HYPR = $(CONFIG_DIR)/hypr
FOOT = $(CONFIG_DIR)/foot

$(CONFIG_DIR):
	mkdir -p $(CONFIG_DIR)

$(HOME)/%: $(DOTFILES)/% $(CONFIG_DIR)
	if [ -e "$@" ]; then mv "$@" "/tmp/$(notdir $@)"; fi
	ln -s "$<" "$@"

.PHONY: all
all: $(BASH) $(ZSH) $(TMUX) $(HYPR) $(FOOT)
