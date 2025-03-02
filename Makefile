SCRIPTS_DIR=scripts

.PHONY: bash
bash:
	@cd $(SCRIPTS_DIR) && sh bash_setup.sh

.PHONY: zsh
zsh: bash
	@cd $(SCRIPTS_DIR) && sh zsh_setup.sh

.PHONY: tmux
tmux:
	@cd $(SCRIPTS_DIR) && sh tmux_setup.sh

.PHONY: hypr
hypr:
	@cd $(SCRIPTS_DIR) && sh hypr_setup.sh
