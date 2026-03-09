NVIM_LOCAL_BIN="/opt/nvim-linux-x86_64/bin"

if [[ -d "$NVIM_LOCAL_BIN" ]]; then
  export PATH="$PATH:$NVIM_LOCAL_BIN"
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "added Neovim local bin to PATH: $NVIM_LOCAL_BIN"
else
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping Neovim local bin path (missing $NVIM_LOCAL_BIN)"
fi

NVIM_PROFILE_PATH="$HOME/.config/nvim-handforge"

if (( $+commands[nvim] )); then
  # export NVIM_APPNAME=nvim-kickstart-11
  export NVIM_APPNAME="${NVIM_PROFILE_PATH##*/}"
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "set NVIM_APPNAME=$NVIM_APPNAME (from $NVIM_PROFILE_PATH)"

  if [[ "${NVIM_APPNAME:-}" == "nvim-handforge" ]]; then
    if (( $+commands[tree-sitter] )); then
      (( $+functions[zsh_startup_log] )) && zsh_startup_log "tree-sitter CLI available for $NVIM_APPNAME"
    else
      (( $+functions[zsh_startup_log] )) && zsh_startup_log "tree-sitter CLI not found (run scripts/install-tree-sitter-cli.sh or use nix develop)"
    fi

    if (( $+commands[cargo] )); then
      (( $+functions[zsh_startup_log] )) && zsh_startup_log "cargo available for $NVIM_APPNAME"
    else
      (( $+functions[zsh_startup_log] )) && zsh_startup_log "cargo not found (run scripts/install-rustup.sh; needed for tree-sitter-cli)"
    fi
  fi
else
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping NVIM_APPNAME (nvim not found)"
fi
