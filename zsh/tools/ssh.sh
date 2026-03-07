GPG_AGENT_CONF="${GNUPGHOME:-$HOME/.gnupg}/gpg-agent.conf"

if ! (( $+commands[gpgconf] )); then
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping gpg-agent SSH socket wiring (gpgconf not installed)"
elif [[ ! -r "$GPG_AGENT_CONF" ]] || ! grep -Eq '^[[:space:]]*enable-ssh-support([[:space:]]|$)' "$GPG_AGENT_CONF"; then
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping gpg-agent SSH socket wiring (enable-ssh-support not configured)"
else
  GPG_SSH_SOCK="$(gpgconf --list-dirs agent-ssh-socket 2>/dev/null || true)"

  if [[ -n "$GPG_SSH_SOCK" ]]; then
    export SSH_AUTH_SOCK="$GPG_SSH_SOCK"
    (( $+functions[zsh_startup_log] )) && zsh_startup_log "using gpg-agent SSH socket: $SSH_AUTH_SOCK"
  else
    (( $+functions[zsh_startup_log] )) && zsh_startup_log "gpg-agent SSH support enabled, but socket lookup failed"
  fi
fi
