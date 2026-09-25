#!/bin/bash

RESET="\033[0m"
BOLD="\033[1m"

BG_INFO="\033[44;37m"
BG_SUCCESS="\033[42;30m"
BG_WARNING="\033[43;30m"
BG_ERROR="\033[41;37m"
GREY="\033[38;2;125;125;125m"

timestamp() {
  echo -e "${GREY}$(date +"%H:%M:%S")${RESET}"
}

info() {
  echo -e "$(timestamp) ${BOLD}${BG_INFO} INFO ${RESET} $1"
}

info_inline() {
  echo -en "$(timestamp) ${BOLD}${BG_INFO} INFO ${RESET} $1"
}

warning() {
  echo -e "$(timestamp) ${BOLD}${BG_WARNING} WARNING ${RESET} $1"
}

success() {
  echo -e "$(timestamp) ${BOLD}${BG_SUCCESS} SUCCESS ${RESET} $1"
}

error() {
  echo -e "$(timestamp) ${BOLD}${BG_ERROR} ERROR ${RESET} $1"
  exit 1
}