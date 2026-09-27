HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE="$XDG_STATE_HOME/zsh/history"

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS

setopt AUTOCD
setopt NUMERIC_GLOB_SORT

autoload -Uz compinit

compinit -d "$XDG_STATE_HOME/zsh/zcompdump"
compdef eza=ls

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' shell '/usr/bin/zsh'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'