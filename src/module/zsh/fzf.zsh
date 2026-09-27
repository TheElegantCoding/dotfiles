if [[ -f "/usr/share/fzf/key-bindings.zsh" ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'
elif command -v fdfind >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --strip-cwd-prefix'
fi

_fzf_file_no_hidden() {
  local cmd result
  cmd="${FZF_DEFAULT_COMMAND/--hidden /}"
  result=$(eval "${cmd:-find . -type f}" | fzf) && LBUFFER+="$result"
  zle reset-prompt
}

fzf_preview() {
  if [ -d "$1" ]; then
    eza --tree --icons --color=always -L 2 "$1"
  elif [ -f "$1" ]; then
    bat --style=numbers --color=always --line-range :500 "$1"
  else
    echo "Cannot preview $1"
  fi
}

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border --preview "fzf_preview {}"'


zle -N _fzf_file_no_hidden