autoload -U add-zsh-hook

load-nvmrc() {
  local node_version
  local current_node
  local nvmrc_path=".nvmrc"
  local node_version_path=".node-version"
  local package_json="package.json"

  local BOLD="\e[1m"
  local GREEN="\e[32m"
  local RESET="\e[0m"

  if [[ -f "$nvmrc_path" ]]; then
    node_version=$(<"$nvmrc_path")
  elif [[ -f "$node_version_path" ]]; then
    node_version=$(<"$node_version_path")
  elif [[ -f "$package_json" ]]; then
    node_version=$(node -e "try { console.log(require('./package.json').engines.node) } catch (e) { process.exit(1) }" 2>/dev/null)
  fi


  if [[ -n "$node_version" && "$node_version" != "undefined" ]]; then
    node_version=$(echo "$node_version" | sed 's/[v>=^~]//g' | xargs)
    current_node=$(node -v | sed 's/v//g')

    if [[ "$node_version" != "$current_node" ]]; then
    echo -e "${GREEN}${RESET} ${BOLD}Node.js Environment shift $current_node 󰁔 $node_version"
      nvm use "$node_version" > /dev/null || nvm install "$node_version"
    fi
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc