if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

pass() {
  env EDITOR=/usr/bin/vi pass "$@"
}

confirm() {
  echo "Are you sure you want to run \e[1;31m$@\e[0m? [y/N]"
  read response
  if [[ "$response" = "y" ]] || [[ "$response" = "Y" ]]; then
    "$@"
  else
    echo "Command cancelled."
  fi
}

unalias rdfind 2>/dev/null
rdfind() {
  # Only confirm if using destructive flags
  if [[ "$*" == *"-deleted"* ]] || [[ "$*" == *"-delete"* ]] || [[ "$*" == *"-makehardlinks"* ]] || [[ "$*" == *"-makesymlinks"* ]]; then
    confirm command rdfind "$@"
  else
    command rdfind "$@"
  fi
}

alias lg="lazygit"

setopt COMPLETE_IN_WORD
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=**'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
