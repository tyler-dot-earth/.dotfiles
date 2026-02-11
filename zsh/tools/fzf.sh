fzf-history-widget() {
  local selected
  selected=$(
    fc -rl 1 |
      sed -E 's/^[[:space:]]*\*?[[:space:]]*[0-9]*[[:space:]]*//' |
      fzf --no-sort --exact --height 40% --layout=reverse --border
  ) || return

  BUFFER="$selected"
  CURSOR=${#BUFFER}
  zle reset-prompt
}

zle -N fzf-history-widget
bindkey '^R' fzf-history-widget

fzf-file-widget() {
  local selected
  selected=$(
    rg --files --hidden --glob '!{node_modules/*,.git/*}' 2>/dev/null |
      fzf --height 50% --layout=reverse --border \
          --preview 'batcat --color=always --line-range :50 {} 2>/dev/null || cat {}' \
          --preview-window 'right:60%'
  ) || return

  LBUFFER="${LBUFFER}${selected}"
  CURSOR=${#LBUFFER}
  zle reset-prompt
}

zle -N fzf-file-widget
bindkey '^F' fzf-file-widget
