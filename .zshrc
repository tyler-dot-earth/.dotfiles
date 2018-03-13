# zsh config

## vi mode
bindkey -v
export KEYTIMEOUT=1

## history
export HISTSIZE=20000 # history size
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

# NPM
export PATH="$PATH:$HOME/.npm/bin"

# Yarn
export PATH="$(yarn global bin):$PATH"

# NVM (NodeJS version manager)
export NVM_DIR="/home/tyler/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Path completion like ~/d/s => ~/Documents/stuff...
# These two initialize the completion system,
# providing the case-sensitive expansion
autoload -U compinit
compinit
# This sets the case insensitivity
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# Init fzf (fuzzy finder)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set default for fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)

# 'ghost history' when typing commands.
# https://github.com/zsh-users/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan" # ghost color

# get some secret stuff
source ~/.zshrc_private
