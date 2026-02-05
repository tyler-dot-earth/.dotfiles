if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then
  export FPATH="$HOME/.zsh/completions:$FPATH"
fi

export PATH=$HOME/.local/bin:$PATH

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
