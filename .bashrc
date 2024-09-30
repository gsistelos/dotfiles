#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$HOME/.local/bin:$PATH"

export EDITOR=nvim
export BROWSER=firefox

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Prompt
source $HOME/.git-prompt.sh
PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " %s")'; \
  PS1='\[\e[94m\][\[\e[0m\] \[\e[92m\]\W\[\e[96m\]${PS1_CMD1}\[\e[0m\] \[\e[94m\]]\$\[\e[0m\] '

# bash-completion
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
  . /usr/share/bash-completion/bash_completion

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
