source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/keybinding.zsh"
source "$ZDOTDIR/base.zsh"
source "$ZDOTDIR/plugin.zsh"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
zplugin_load zsh-users zsh-syntax-highlighting
eval "$(iris init zsh)"
