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

source $ZSH/oh-my-zsh.sh

# eval "$(starship init zsh)"

eval "$(oh-my-posh init zsh --config "${0:a:h}/starship_style.omp.json")"
