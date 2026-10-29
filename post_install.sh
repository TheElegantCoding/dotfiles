#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/src/global/util/logger.sh"

DOTFILES_DIR="$HOME/project/dotfiles/src/module"
ASSET_DIR="$HOME/project/dotfiles/src/global/asset/"
CONFIG_DIR="$HOME/.config"
ETC_MODULES=("keyd")

info "Initializing dotfiles from $DOTFILES_DIR..."

mkdir -p "$CONFIG_DIR"

for module in "$DOTFILES_DIR"/*; do
  if [ -d "$module" ]; then
    name=$(basename "$module")
    target="$CONFIG_DIR/$name"

    if [[ " ${ETC_MODULES[*]} " =~ " ${name} " ]]; then
      info "Linking root module: $name -> /etc/$name"
      sudo mkdir -p "/etc/$name"

      for file in "$module"/*; do
        if [ -f "$file" ]; then
          filename=$(basename "$file")
          sudo ln -sf "$file" "/etc/$name/$filename"
        fi
      done

      if [ "$name" = "keyd" ]; then
        sudo keyd reload 2>/dev/null || true
      fi

    else
      [ -L "$target" ] && rm "$target"
      ln -s "$module" "$target"
      info "Linking: $name -> $target"
    fi
  fi
done

success "All dotfiles have been linked successfully."

info "Configuring Zsh..."

# update /etc/zshenv to point to the new ZDOTDIR
# echo 'export ZDOTDIR="$HOME/.config/zsh"' | sudo tee -a /etc/zsh/zshenv

info "Installint aditional packages."

# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si
# cd..

# pacman -S git base-devel vlc noto-fonts noto-fonts-cjk noto-fonts-extra tf-nerd-fonts-symbols ttf-cascadia-mono-nerd rust imagemagick tree-sitter-cli hyprland github-cli nodejs kitty pipewire pipewire-pulse wireplumber pipewire-alsa brightnessctl playerctl neovide gnome-keyring keyd libsecret rtkit neovim starship bun zsh zoxide bat fzf eza ttf-cascadia-code-nerd noto-fonts-emoji xorg-xcursorgen unzip firefox stylua uwsm libnewt quickshell bluez bluez-utils terraform wget
# bun i -g oxlint
# yay -S visual-studio-code-bin iris-autocomplete
# npm i -g oxlint oxfmt
# sudo ln -s ~/project/dotfiles/src/module/sddm/theme /usr/share/sddm/themes/theme

# systemctl --user enable --now pipewire.socket
# systemctl --user enable --now pipewire-pulse.socket
# systemctl --user enable --now wireplumber.service
# systemctl --user enable --now rtkit-daemon
# systemctl enable --now keyd

# Login with github is
#
# gh auth login
#

info "Setting up assets"

for module in "$ASSET_DIR"/*; do
  if [ -d "$module" ]; then
    name=$(basename "$module")
    target="$CONFIG_DIR/$name"

    if [ "$name" = "sound" ]; then
      chmod +x "$module"/*
    fi

    if [ -L "$target" ] || [ -e "$target" ]; then
      rm -rf "$target"
    fi

    ln -s "$module" "$target"
    info "Linking: $name -> $target"
  fi
done