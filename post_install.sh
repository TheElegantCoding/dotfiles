#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/src/global/util/logger.sh"

DOTFILES_DIR="$HOME/project/dotfiles/src/module"
CONFIG_DIR="$HOME/.config"

info "Initializing dotfiles from $DOTFILES_DIR..."

mkdir -p "$CONFIG_DIR"

for module in "$DOTFILES_DIR"/*; do
  if [ -d "$module" ]; then
    name=$(basename "$module")
    target="$CONFIG_DIR/$name"

    if [ "$name" = "keyd" ]; then
      sudo mkdir -p /etc/keyd
      sudo ln -sf "$module/default.conf" /etc/keyd/default.conf
      sudo keyd reload
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

# pacman -S git base-devel hyprland github-cli nodejs kitty pipewire pipewire-pulse wireplumber pipewire-alsa brightnessctl playerctl gnome-keyring keyd libsecret rtkit neovim starship bun zsh zoxide bat fzf eza ttf-cascadia-code-nerd noto-fonts-emoji xorg-xcursorgen unzip firefox
# yay -S visual-studio-code-bin

# systemctl --user enable --now pipewire.socket
# systemctl --user enable --now pipewire-pulse.socket
# systemctl --user enable --now wireplumber.service
# systemctl --user enable --now rtkit-daemon
# systemctl enable --now keyd

# Login with github is
#
# gh auth login