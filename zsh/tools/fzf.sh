fzf-history-widget() {
  local selected
  selected=$(
    fc -rl 1 |
      sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//' |
      fzf --no-sort --exact --height 40% --layout=reverse --border
  ) || return

  BUFFER="$selected"
  CURSOR=${#BUFFER}
  zle reset-prompt
}

zle -N fzf-history-widget
bindkey '^R' fzf-history-widget
