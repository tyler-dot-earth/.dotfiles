# Lazy-load nvm and related commands on first use.
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

# Keep a Node binary on PATH for non-zsh shims (e.g. pnpm global bins)
# without sourcing nvm at startup.
if (( ! $+commands[node] )); then
  typeset -a nvm_node_bins
  nvm_node_bins=("$NVM_DIR"/versions/node/*/bin(N))
  if (( ${#nvm_node_bins} )); then
    export PATH="${nvm_node_bins[-1]}:$PATH"
  fi
fi

_lazy_load_nvm() {
  unfunction nvm node npm npx 2>/dev/null

  if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
  fi

  if [[ -s "$NVM_DIR/bash_completion" ]]; then
    source "$NVM_DIR/bash_completion"
  fi
}

nvm() {
  _lazy_load_nvm
  nvm "$@"
}

node() {
  _lazy_load_nvm
  node "$@"
}

npm() {
  _lazy_load_nvm
  npm "$@"
}

npx() {
  _lazy_load_nvm
  npx "$@"
}
