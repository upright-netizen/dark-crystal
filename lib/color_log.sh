#!/usr/bin/env zsh

typeset -A text_colors background_colors effects

escape="\033[";
reset="${escape}0m";

text_colors=(
  default          "39"
  black            "30"
  red              "31"
  green            "32"
  yellow           "33"
  blue             "34"
  purple           "35"
  cyan             "36"
  white            "37"
  bright_red       "91"
  bright_green     "92"
  bright_yellow    "93"
  bright_blue      "94"
  bright_purple    "95"
  bright_cyan      "96"
  bright_white     "97"
)

background_colors=(
  default     "49"
  black       "40"
  red         "41"
  green       "42"
  yellow      "43"
  blue        "44"
  purple      "45"
  cyan        "46"
  white       "47"
)

effects=(
  default       "0"
  bold          "1"
  italic        "3"
  underline     "4"
)



function log () {
  # check if message
  test -n "$1" || {
    echo "Nothing specified";
    exit 1;
  }

  message=$1;

  # build treatment
  color=${2:-"default"}
  background_color=${3:-"default"}
  format=${4:-"default"}

  treatment="${escape}";
  treatment="${treatment}${effects[$format]};"
  treatment="${treatment}${text_colors[$color]};"
  treatment="${treatment}${background_colors[$background_color]}m"

  echo -e "${treatment}$message${reset}";
}

log "this is a test string" "red" "default" "underline";
log "this is a test string" "white" "blue";
log "this is a test string";