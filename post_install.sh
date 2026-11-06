#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/src/global/util/logger.sh"

readonly GLOBAL_DIR="$DIR/src/global"
readonly MODULE_DIR="$DIR/src/module"
readonly ASSET_DIR="$DIR/src/global/asset"
readonly CONFIG_DIR="$HOME/.config"
readonly ZDOTDIR_LINE='export ZDOTDIR="$HOME/.config/zsh"'

link() {
  local source=$1 target=$2

  if [[ -e $target && ! -L $target ]]; then
    mv "$target" "$target.bak-$EPOCHSECONDS"
    warning "Backed up existing $target"
  fi

  ln -sfn "$source" "$target"
  info "Linking: ${source##*/} -> $target"
}

link_dirs() {
  local dir
  for dir in "$1"/*/; do
    link "${dir%/}" "$CONFIG_DIR/$(basename "$dir")"
  done
}

install_system_files() {
  info "Installing system files..."
  sudo install -D -m 644 -o root -g root \
    "$DIR/src/global/etc/pam.d/login" /etc/pam.d/login
}

install_yay() {
  command -v yay &> /dev/null && return

  info "Installing yay..."
  local tmp
  tmp=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$tmp/yay"
  (cd "$tmp/yay" && makepkg -si)
  rm -rf "$tmp"
}

install_packages() {
  info "Installing packages..."
  sudo pacman -S --needed - < "$GLOBAL_DIR/packages/pacman.txt"
  install_yay
  xargs -r -a "$GLOBAL_DIR/packages/aur.txt" yay -S --needed
}

install_bun_packages() {
  info "Installing global bun packages..."
  bun i -g oxlint oxfmt
}

configure_zsh() {
  info "Configuring Zsh..."
  grep -qxF "$ZDOTDIR_LINE" /etc/zsh/zshenv 2> /dev/null ||
    echo "$ZDOTDIR_LINE" | sudo tee -a /etc/zsh/zshenv > /dev/null
  mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
}

enable_units() {
  local file=$1
  shift
  local -a units

  mapfile -t units < <(grep -vE '^\s*(#|$)' "$file")
  ((${#units[@]})) || return 0

  "$@" enable --now "${units[@]}"
}

enable_services() {
  info "Enabling services..."
  enable_units "$GLOBAL_DIR/services/system.txt" sudo systemctl
  enable_units "$GLOBAL_DIR/services/user.txt" systemctl --user
}

login_github() {
  gh auth status &> /dev/null || gh auth login
}

info "Initializing dotfiles from $DIR..."
mkdir -p "$CONFIG_DIR"
link_dirs "$MODULE_DIR"
link_dirs "$ASSET_DIR"
[[ -d $ASSET_DIR/sound ]] && chmod +x "$ASSET_DIR"/sound/*

install_packages
install_system_files
install_bun_packages
configure_zsh
enable_services
login_github

success "Post-install finished."
