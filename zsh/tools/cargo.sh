CARGO_BIN="$HOME/.cargo/bin"

if [[ -d "$CARGO_BIN" ]]; then
  case ":$PATH:" in
    *":$CARGO_BIN:"*) ;;
    *)
      export PATH="$CARGO_BIN:$PATH"
      (( $+functions[zsh_startup_log] )) && zsh_startup_log "added cargo bin to PATH: $CARGO_BIN"
      ;;
  esac
else
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping cargo bin path (missing $CARGO_BIN)"
fi
