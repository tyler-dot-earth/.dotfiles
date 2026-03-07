ZSH_INIT_DIR="${${(%):-%N}:A:h}"

zsh_startup_log() {
  if (( ${ZSH_DEBUG_STARTUP:-0} )); then
    print -u2 -- "[zsh-startup] $*"
  fi
}

zsh_startup_log "loading core zsh config from $ZSH_INIT_DIR"

source "$ZSH_INIT_DIR/env.sh"
source "$ZSH_INIT_DIR/omz.sh"

if (( ! $+functions[compdef] )); then
  zsh_startup_log "initializing zsh completions via compinit"
  autoload -Uz compinit
  compinit -i
fi

source "$ZSH_INIT_DIR/aliases.sh"
source "$ZSH_INIT_DIR/title.sh"
source "$ZSH_INIT_DIR/tools/init.sh"

if [[ -r "$HOME/.zshrc_private" ]]; then
  zsh_startup_log "loading $HOME/.zshrc_private"
  source "$HOME/.zshrc_private"
else
  zsh_startup_log "skipping $HOME/.zshrc_private (not found)"
fi
