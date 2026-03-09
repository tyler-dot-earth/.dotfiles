if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then
  export FPATH="$HOME/.zsh/completions:$FPATH"
fi

export PATH=$HOME/.local/bin:$PATH

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# Make Ctrl-W stop at path separators when editing command lines.
WORDCHARS="${WORDCHARS//\/}"

HOMEBREW_BIN=""
for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [[ -x "$candidate" ]]; then
    HOMEBREW_BIN="$candidate"
    break
  fi
done

if [[ -n "$HOMEBREW_BIN" ]]; then
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "initializing Homebrew via $HOMEBREW_BIN"
  eval "$($HOMEBREW_BIN shellenv)"
else
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping Homebrew shellenv (brew not found)"
fi
