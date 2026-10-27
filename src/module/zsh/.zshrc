source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/keybinding.zsh"
source "$HOME/.config/zsh/base.zsh"
source "$HOME/.config/zsh/plugin.zsh"

if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
  "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
  zle -N zle-keymap-select "";
fi

if uwsm check may-start && uwsm select; then
	exec uwsm start default
fi

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(iris init zsh)"