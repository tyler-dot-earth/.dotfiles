if (( $+commands[gpgconf] )); then
  if [[ -t 0 ]] || [[ -t 1 ]]; then
    export GPG_TTY="$(tty)"
    (( $+functions[zsh_startup_log] )) && zsh_startup_log "set GPG_TTY to $GPG_TTY"
  fi

  if (( $+commands[gpg-connect-agent] )); then
    # Keep gpg-agent attached to the current terminal so pinentry can appear.
    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1 || true
  fi
else
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping GPG_TTY setup (gpgconf not installed)"
fi
