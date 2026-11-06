#!/bin/bash
readonly RESET=$'\033[0m'
readonly BOLD=$'\033[1m'

readonly GREY=$'\033[38;2;125;125;125m'
readonly BG_INFO=$'\033[44;37m'
readonly BG_SUCCESS=$'\033[42;30m'
readonly BG_WARNING=$'\033[43;30m'
readonly BG_ERROR=$'\033[41;37m'

timestamp() {
  printf '%s%(%H:%M:%S)T%s' "$GREY" -1 "$RESET"
}

log() {
  local badge=$1 label=$2 message=$3 end=${4-$'\n'}

  printf '%s %s%s %s %s %s %s' \
    "$(timestamp)" "$BOLD" "$badge" "$label" "$RESET" "$message" "$end"
}

info() { log "$BG_INFO" INFO "$1"; }
info_inline() { log "$BG_INFO" INFO "$1" ''; }
success() { log "$BG_SUCCESS" SUCCESS "$1"; }
warning() { log "$BG_WARNING" WARNING "$1" >&2; }

error() {
  log "$BG_ERROR" ERROR "$1" >&2
  exit 1
}
