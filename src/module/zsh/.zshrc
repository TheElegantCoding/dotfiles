source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/keybinding.zsh"

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

eval "$(zoxide init zsh)"

autoload -Uz compinit

compinit -d "$XDG_STATE_HOME/zsh/zcompdump"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' shell '/usr/bin/zsh'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'

eval "$(starship init zsh)"

# for file in ~/*.zsh; do
#   source "$file"
# done

# ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
#
# if [ ! -d "$ZINIT_HOME" ]; then
#   mkdir -p "$(dirname "$ZINIT_HOME")"
#   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
# fi
#
# source "${ZINIT_HOME}/zinit.zsh"
#

# zinit cdreplay -q
#
# zinit light Aloxaf/fzf-tab
# zinit light zsh-users/zsh-autosuggestions
# zinit light zsh-users/zsh-syntax-highlighting
# zinit light MichaelAquilina/zsh-you-should-use
#

#
# source /ucrt64/share/fzf/key-bindings.zsh
# source /ucrt64/share/fzf/completion.zsh
#

#
