# File management aliases
alias ls='eza --icons -a'
alias ll='eza -lha --icons --git'
alias tree='eza --tree --icons -a'

# Reload Zsh configuration
alias reload='exec zsh'

# Navigation aliases
alias project='cd ~/project'
alias config='cd ~/.config'
alias dotfiles='cd ~/project/dotfiles'
alias nvimConfig='cd ~/project/dotfiles/src/module/nvim'

# Git aliases
alias lg='lazygit'
alias gst='git status'
alias gds='git diff --staged'
alias gsw='git switch'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gl='git log --all --graph --decorate --pretty="%C(cyan)%h %C(white) %an %ar%C(auto) %D%n%s%n"'
alias gb='git branch'
alias gi='git init'
alias gcl='git clone'

# Package management aliases
alias up='yay -Syu'
alias pacs='sudo pacman -S'
alias pacr='sudo pacman -Rns'
alias orphans='pacman -Qdtq'

command -v bat >/dev/null && alias cat='bat'

launch() {
  whence -p "$1" >/dev/null || {
    print -u2 "launch: $1 not found"
    return 1
  }
  nohup "$@" >/dev/null 2>&1 &|
  exit
}

neovide() { launch neovide "$@"; }
code() { launch code "${@:-.}"; }
