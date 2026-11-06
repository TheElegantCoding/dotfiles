state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/zsh"

HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE="$state_dir/history"

setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE
setopt AUTOCD NUMERIC_GLOB_SORT

autoload -Uz compinit
compinit -d "$state_dir/zcompdump"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
