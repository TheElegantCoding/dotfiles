bindkey -e

bindkey '^D' kill-whole-line
bindkey '^H' beginning-of-line

# Ctrl+Left / Ctrl+Right: move by word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Alt+S: prepend sudo to the current command
prepend-sudo() {
  [[ $BUFFER == sudo\ * ]] && return
  BUFFER="sudo $BUFFER"
  ((CURSOR += 5))
}

zle -N prepend-sudo
bindkey '^[s' prepend-sudo
