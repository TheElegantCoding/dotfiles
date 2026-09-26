alias ls='eza --icons'
alias ll='eza -lh --icons --git'
alias la='eza -lha --icons --git'
alias tree='eza --tree --icons'

compdef eza=ls

alias update="source ~/.config/zsh/.zshrc"

alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias gl='git log --all --graph --decorate --pretty="%C(cyan)%h %C(white) %an %ar%C(auto) %D%n%s%n"'
alias gb='git branch'
alias gi='git init'
alias gcl='git clone'