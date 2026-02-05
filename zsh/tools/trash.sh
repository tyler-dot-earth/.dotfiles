# Safe rm with trash support
# Main: trash-cli (Node.js version - `trash` command)
# Fallback: rm -i with warning

if command -v trash &> /dev/null; then
  alias rm='trash'
else
  alias rm='rm -i'

  if [[ -z "$ZSH_TRASH_WARNED" ]]; then
    echo "[zsh] trash-cli not found, using rm -i fallback"
    echo "[zsh] Install trash-cli for safer deletes: npm install --global trash-cli"
    export ZSH_TRASH_WARNED=1
  fi
fi
