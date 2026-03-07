if (( $+commands[delta] )); then
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "delta available"
else
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "delta not found (git pager/diffFilter may fail if enabled in gitconfig)"
fi
