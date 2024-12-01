SCRIPT_DIR = scripts


.PHONY: get
get:
	./$(SCRIPT_DIR)/get_config.sh

.PHONY: set
set:
	./$(SCRIPT_DIR)/set_config.sh

.PHONY: bash
bash:
	./$(SCRIPT_DIR)/bash_setup.sh

.PHONY: tmux
tmux:
	./$(SCRIPT_DIR)/tmux_setup.sh

.PHONY: zsh
zsh:
	./$(SCRIPT_DIR)/zsh_setup.sh
