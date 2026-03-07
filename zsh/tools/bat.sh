if (( $+commands[batcat] )); then
  export BAT_THEME="everforest-soft"
  export BAT_CMD="batcat"
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "using batcat for previews"
elif (( $+commands[bat] )); then
  export BAT_THEME="everforest-soft"
  export BAT_CMD="bat"
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "using bat for previews"
else
  unset BAT_CMD
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping bat setup (bat/batcat not found)"
fi
