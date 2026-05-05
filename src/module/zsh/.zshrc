export PATH="/ucrt64/bin:/usr/bin:$PATH"
export PATH="$PATH:/c/Progra~1/starship/bin"
export PATH="$PATH:/c/Progra~1/nodejs"
export PATH="$PATH:/c/Progra~1/Git/cmd"
export PATH="$PATH:/c/Users/luism/AppData/Local/pnpm"
export PATH="$PATH:/c/Users/luism/.bun/bin"
export PATH="$PATH:/c/ProgramData/chocolatey/lib/terraform/tools"
export GEM_HOME="/home/luism/.local/share/gem/ruby/3.4.0"
export PATH="/home/luism/.local/share/gem/ruby/3.4.0/bin:$PATH"

alias ls='colorls --group-directories-first --almost-all'
alias update="source ~/.zshrc"
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gl='git log --all --graph --decorate --pretty="%C(cyan)%h %C(white) %an %ar%C(auto) %D%n%s%n"'
alias gb='git branch'
alias gi='git init'
alias gcl='git clone'

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

bindkey '^D' kill-whole-line
bindkey '^G' beginning-of-line
bindkey '^K' end-of-line
bindkey '^F' fzf-history-widget

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"