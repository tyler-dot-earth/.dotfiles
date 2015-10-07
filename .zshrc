# zsh config

## vi mode
bindkey -v
export KEYTIMEOUT=1

## history
export HISTSIZE=2000 # history size
export HISTFILE="$HOME/.zsh_history" # history file
export SAVEHIST=$HISTSIZE # enable history

## reverse history search
bindkey '^R' history-incremental-search-backward

## default editor
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

## modern completion system
zstyle ':completion:*' menu select=long
autoload -Uz compinit
compinit

## Prompt config
# Print an empty line before the PROMPT is rendered
# precmd() { print "" }
## %/     Present  working  directory
LOCATION=$'%/' # current location
NEWLINE=$'\n' # newline
AUTOHASH=$'%#' # character that shows as % (normal user) or # (sudo user)
PROMPT=%B${NEWLINE}${LOCATION}%b${NEWLINE}${AUTOHASH}" "

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# NPM
export PATH="$PATH:$HOME/.npm/bin"

export NVM_DIR="/home/tyler/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
