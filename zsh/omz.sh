export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  git
  pass
  colored-man-pages
  yarn
  themes
  vi-mode
  emoji-clock
  emoji
  gpg-agent
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-history-substring-search
  eza
  zoxide
)

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "loading Oh My Zsh from $ZSH"
  source "$ZSH/oh-my-zsh.sh"
else
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping Oh My Zsh (missing $ZSH/oh-my-zsh.sh)"
fi

# eval "$(starship init zsh)"

OMZ_CONFIG_DIR="${${(%):-%N}:A:h}"
if (( $+commands[oh-my-posh] )) && [[ -r "$OMZ_CONFIG_DIR/starship_style.omp.json" ]]; then
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "initializing oh-my-posh"
  eval "$(oh-my-posh init zsh --config "$OMZ_CONFIG_DIR/starship_style.omp.json")"
else
  (( $+functions[zsh_startup_log] )) && zsh_startup_log "skipping oh-my-posh (binary or config missing)"
fi
