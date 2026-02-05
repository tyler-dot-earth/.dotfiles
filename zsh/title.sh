DISABLE_AUTO_TITLE="true"

function precmd() {
  echo -ne "\033]0;$(print -rD $PWD)\007"
}

function preexec() {
  print -Pn "\e]0;🚀 $(print -rD $PWD) $1\a"
}
