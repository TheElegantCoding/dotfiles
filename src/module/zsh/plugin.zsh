ZPLUGINDIR="$HOME/.config/zsh/plugins"

zplugin_load() {
  local plugin_path="$ZPLUGINDIR/$2"

  if [[ ! -d $plugin_path ]]; then
    print -u2 "Installing $2..."
    git clone --depth 1 "https://github.com/$1/$2" "$plugin_path" || {
      print -u2 "Failed to install $2"
      return 1
    }
  fi

  source "$plugin_path/$2.plugin.zsh"
}

zplugin_update() {
  local dir

  for dir in "$ZPLUGINDIR"/*/(N); do
    print "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}
