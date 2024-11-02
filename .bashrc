#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"
export BROWSER="firefox"


alias ls="ls --color=auto"
alias grep="grep --color=auto"


# Prompt
RESET="\[\e[0m\]"
GREEN="\[\e[92m\]"
BLUE="\[\e[94m\]"
CYAN="\[\e[96m\]"

PRE="${BLUE}[${RESET}"
POST="${BLUE}]\$${RESET}"

DIR="${GREEN}\W${RESET}"

source $HOME/.git-prompt.sh
GIT_COMMAND='$(__git_ps1 " %s")'
GIT_PROMPT="${CYAN}${GIT_COMMAND}${RESET}"

PS1="${PRE} ${DIR}${GIT_PROMPT} ${POST} "


# bash-completion
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
  source /usr/share/bash-completion/bash_completion


# nvm
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"

source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec


# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
