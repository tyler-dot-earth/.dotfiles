if (( $+commands[fzf] )); then
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "enabling fzf history keybinding (^R)"

  FZF_PREVIEW_CMD="cat"
  if [[ -n "${BAT_CMD:-}" ]]; then
    FZF_PREVIEW_CMD="$BAT_CMD --color=always --line-range :50"
  fi

  fzf-history-widget() {
    local selected
    selected=$(
      fc -rl 1 |
        sed -E 's/^[[:space:]]*\*[[:space:]]*//; s/^[[:space:]]*[0-9]*[[:space:]]*//' |
        fzf --no-sort --exact --height 40% --layout=reverse --border
    ) || return

    BUFFER="$selected"
    CURSOR=${#BUFFER}
    zle reset-prompt
  }

  zle -N fzf-history-widget
  bindkey '^R' fzf-history-widget

  if (( $+commands[rg] )); then
    (( $+functions[zsh_startup_log] )) && zsh_startup_log "enabling fzf file keybinding (^F)"

    fzf-file-widget() {
      local selected
      selected=$(
        rg --files --hidden --glob '!{node_modules/*,.git/*}' 2>/dev/null |
          fzf --height 50% --layout=reverse --border \
              --preview "$FZF_PREVIEW_CMD {} 2>/dev/null || cat {}" \
              --preview-window 'right:60%'
      ) || return

      LBUFFER="${LBUFFER}${selected}"
      CURSOR=${#LBUFFER}
      zle reset-prompt
    }

    zle -N fzf-file-widget
    bindkey '^F' fzf-file-widget
  else
    (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping fzf file widget (^F) (rg not found)"
  fi
else
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping fzf widgets (fzf not found)"
fi
