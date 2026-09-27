source "$HOME/.config/zsh/aliases.zsh"
source "$HOME/.config/zsh/keybinding.zsh"
source "$HOME/.config/zsh/base.zsh"
source "$HOME/.config/zsh/fzf.zsh"
source "$HOME/.config/zsh/plugin.zsh"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

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