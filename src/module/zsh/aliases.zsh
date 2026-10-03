alias ls='eza --icons -a'
alias ll='eza -lha --icons --git'
alias tree='eza --tree --icons -a'

alias update='source ~/.config/zsh/.zshrc'

alias project='cd ~/project'
alias config='cd ~/.config'
alias dotfiles='cd ~/project/dotfiles'
alias nvimConfig='cd ~/project/dotfiles/src/module/nvim'

alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gl='git log --all --graph --decorate --pretty="%C(cyan)%h %C(white) %an %ar%C(auto) %D%n%s%n"'
alias gb='git branch'
alias gi='git init'
alias gcl='git clone'

if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
elif command -v batcat >/dev/null 2>&1; then
  alias bat='batcat'
  alias cat='batcat'
fi