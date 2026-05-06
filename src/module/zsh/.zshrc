for file in ~/module/*.zsh; do
  source "$file"
done

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz compinit && compinit
zinit cdreplay -q

zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light MichaelAquilina/zsh-you-should-use

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' shell '/usr/bin/zsh'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'

source /ucrt64/share/fzf/key-bindings.zsh
source /ucrt64/share/fzf/completion.zsh

HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"