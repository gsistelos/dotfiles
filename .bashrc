#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias ls="ls --color=auto"

alias ll="ls -l"
alias la="ls -la"


export EDITOR="nvim"
export BROWSER="firefox"


# Prompt
RESET="\[\e[0m\]"
GREEN="\[\e[92m\]"
BLUE="\[\e[94m\]"
CYAN="\[\e[96m\]"

DIR="${GREEN}\W${RESET}"

source $HOME/.git-prompt.sh
GIT_COMMAND='$(__git_ps1 " %s")'
GIT_PROMPT="${CYAN}${GIT_COMMAND}${RESET}"

PS1="${BLUE}[${RESET} ${DIR}${GIT_PROMPT} ${BLUE}]\$${RESET} "


# bash-completion
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
  source /usr/share/bash-completion/bash_completion


export PATH="$HOME/.local/bin:$PATH"
