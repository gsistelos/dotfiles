SCRIPTS_DIR=scripts

.PHONY: bash
bash:
	@cd $(SCRIPTS_DIR) && sh bash_setup.sh

.PHONY: zsh
zsh: bash
	@cd $(SCRIPTS_DIR) && sh zsh_setup.sh
