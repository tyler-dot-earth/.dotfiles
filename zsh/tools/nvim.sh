NVIM_LOCAL_BIN="/opt/nvim-linux-x86_64/bin"

if [[ -d "$NVIM_LOCAL_BIN" ]]; then
  export PATH="$PATH:$NVIM_LOCAL_BIN"
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "added Neovim local bin to PATH: $NVIM_LOCAL_BIN"
else
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping Neovim local bin path (missing $NVIM_LOCAL_BIN)"
fi

if (( $+commands[nvim] )); then
  export NVIM_APPNAME=nvim-kickstart-11
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "set NVIM_APPNAME=$NVIM_APPNAME"
else
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping NVIM_APPNAME (nvim not found)"
fi
