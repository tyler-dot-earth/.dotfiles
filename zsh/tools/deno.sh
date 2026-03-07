if [[ -r "$HOME/.deno/env" ]]; then
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "loading Deno environment from $HOME/.deno/env"
  . "$HOME/.deno/env"
else
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping Deno environment (missing $HOME/.deno/env)"
fi
