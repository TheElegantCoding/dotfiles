source "$HOME/project/dotfiles/src/global/util/logger.sh"

ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"

zplugin_load() {
  local plugin_path="$ZPLUGINDIR/$2"

  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    info "Installing $2"
    git clone --depth 1 "https://github.com/$1/$2" "$plugin_path" \
     || { error "Failed to install $2"; return 1; }
  fi

  source "$plugin_path/$2.plugin.zsh"
}

zplugin_update() {
  local dir

  for dir in "$ZPLUGINDIR"/*/; do
    info "Updating plugin in ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

zplugin_load "zsh-users" "zsh-autosuggestions"
zplugin_load "zsh-users" "zsh-syntax-highlighting"