SCRIPT_DIR = scripts


.PHONY: get
get:
	./$(SCRIPT_DIR)/get_config.sh

.PHONY: set
set:
	./$(SCRIPT_DIR)/set_config.sh

.PHONY: bash
bash:
	cd $(SCRIPT_DIR)
	./$(SCRIPT_DIR)/bash_setup.sh

.PHONY: tmux
tmux:
	cd $(SCRIPT_DIR)
	./$(SCRIPT_DIR)/tmux_setup.sh

.PHONY: zsh
zsh:
	cd $(SCRIPT_DIR)
	./$(SCRIPT_DIR)/zsh_setup.sh
