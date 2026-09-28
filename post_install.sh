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

    if [ -L "$target" ]; then
      info "Updating: $name"
      rm "$target"
    fi

    ln -s "$module" "$target"
    info "Linking: $name -> $target"
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

# pacman -S git base-devel hyprland github-cli kitty pipewire pipewire-pulse wireplumber pipewire-alsa gnome-keyring libsecret rtkit neovim starship bun zsh zoxide bat fzf eza ttf-cascadia-code-nerd xorg-xcursorgen unzip firefox
# yay -S visual-studio-code-bin

# systemctl --user enable --now pipewire.socket
# systemctl --user enable --now pipewire-pulse.socket
# systemctl --user enable --now wireplumber.service
# systemctl --user enable --now rtkit-daemon

# Login with github is
#
# gh auth login