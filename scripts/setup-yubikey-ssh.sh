#!/usr/bin/env bash
set -euo pipefail

GNUPGHOME="${GNUPGHOME:-$HOME/.gnupg}"
SSH_DIR="$HOME/.ssh"
GPG_AGENT_CONF="$GNUPGHOME/gpg-agent.conf"
SSH_CONFIG="$SSH_DIR/config"
SSH_INCLUDE_DIR="$SSH_DIR/config.d"
SSH_GPG_INCLUDE="$SSH_INCLUDE_DIR/10-gpg-agent.conf"
IDENTITY_SOCKET="$GNUPGHOME/S.gpg-agent.ssh"

missing=()
for required_cmd in gpg gpgconf ssh-add ssh; do
  if ! command -v "$required_cmd" >/dev/null 2>&1; then
    missing+=("$required_cmd")
  fi
done

if (( ${#missing[@]} > 0 )); then
  printf 'Missing required command(s): %s\n' "${missing[*]}" >&2
  if [[ "$(uname -s)" == "Darwin" ]]; then
    cat <<'EOF' >&2

Install prerequisites on macOS:
  brew install gnupg pinentry-mac
EOF
  else
    cat <<'EOF' >&2

Install prerequisites from your package manager:
  gnupg (gpg, gpgconf)
  openssh-client (ssh, ssh-add)
EOF
  fi
  exit 1
fi

append_if_missing() {
  local line="$1"
  local file="$2"
  if ! grep -Fxq "$line" "$file"; then
    printf '%s\n' "$line" >> "$file"
  fi
}

detect_pinentry_program() {
  local os
  os="$(uname -s)"

  if [[ "$os" == "Darwin" ]]; then
    for candidate in /opt/homebrew/bin/pinentry-mac /usr/local/bin/pinentry-mac; do
      if [[ -x "$candidate" ]]; then
        printf '%s\n' "$candidate"
        return 0
      fi
    done
  else
    # Prefer GUI pinentry on Linux desktops, with curses fallback.
    local candidate
    for candidate in pinentry-gnome3 pinentry-gtk-2 pinentry-qt pinentry-curses pinentry; do
      if command -v "$candidate" >/dev/null 2>&1; then
        command -v "$candidate"
        return 0
      fi
    done
  fi

  return 1
}

mkdir -p "$GNUPGHOME" "$SSH_INCLUDE_DIR"
chmod 700 "$GNUPGHOME" "$SSH_DIR"

touch "$GPG_AGENT_CONF"
chmod 600 "$GPG_AGENT_CONF"

append_if_missing "enable-ssh-support" "$GPG_AGENT_CONF"
append_if_missing "default-cache-ttl 600" "$GPG_AGENT_CONF"
append_if_missing "max-cache-ttl 7200" "$GPG_AGENT_CONF"

if ! grep -Eq '^[[:space:]]*pinentry-program[[:space:]]+' "$GPG_AGENT_CONF"; then
  if pinentry_program="$(detect_pinentry_program)"; then
    append_if_missing "pinentry-program $pinentry_program" "$GPG_AGENT_CONF"
  elif [[ "$(uname -s)" == "Darwin" ]]; then
    echo "Warning: pinentry-mac not found; install it for GUI PIN prompts (brew install pinentry-mac)." >&2
  else
    echo "Warning: no pinentry program found in PATH; install one (e.g. pinentry-gnome3 or pinentry-qt)." >&2
  fi
fi

if [[ ! -f "$SSH_CONFIG" ]]; then
  cat > "$SSH_CONFIG" <<'EOF'
Include ~/.ssh/config.d/*.conf
EOF
  chmod 600 "$SSH_CONFIG"
elif ! grep -Eq '^[[:space:]]*Include[[:space:]]+~/.ssh/config\.d/\*\.conf([[:space:]]|$)' "$SSH_CONFIG"; then
  printf '\nInclude ~/.ssh/config.d/*.conf\n' >> "$SSH_CONFIG"
fi

cat > "$SSH_GPG_INCLUDE" <<EOF
Host *
  IdentityAgent $IDENTITY_SOCKET
EOF
chmod 600 "$SSH_GPG_INCLUDE"

if command -v gpgconf >/dev/null 2>&1; then
  gpgconf --kill gpg-agent >/dev/null 2>&1 || true
fi

cat <<EOF
YubiKey SSH bootstrap complete.

Reference guide:
- https://github.com/drduh/YubiKey-Guide

Configured:
- $GPG_AGENT_CONF
- $SSH_CONFIG
- $SSH_GPG_INCLUDE

Next steps:
1. Open a new shell (or run: gpgconf --launch gpg-agent)
2. Verify your auth key is visible: ssh-add -L
3. Test GitHub SSH: ssh -T git@github.com

If ssh-add shows no keys, run: gpg --card-status
EOF
