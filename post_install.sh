#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/src/module/install/lib.sh"

DOTFILES_DIR="$HOME/project/dotfiles/src/module"
CONFIG_DIR="$HOME/.config"

info "Initializing dotfiles from $DOTFILES_DIR..."

mkdir -p "$CONFIG_DIR"

for module in "$DOTFILES_DIR"/*; do
  if [ -d "$module" ]; then
    name=$(basename "$module")
    target="$CONFIG_DIR/$name"

    if [ -L "$target" ]; then
      info "Updating: $name"
      rm "$target"
    elif [ -e "$target" ]; then
      warning "$target already exists and is not a symlink. Backing it up to ${target}.bak"
      mv "$target" "${target}.bak"
    fi

    ln -s "$module" "$target"
    info "Linking: $name -> $target"
  fi
done

success "All dotfiles have been linked successfully."