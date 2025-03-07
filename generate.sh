#! /usr/bin/env bash

# Exit Immediately if a command fails
set -o errexit

readonly REPO_DIR="$(dirname "$(readlink -m "${0}")")"
source "${REPO_DIR}/core.sh"

usage() {
cat << EOF

Usage: $0 [OPTION]...

OPTIONS:
  -t, --theme     Background theme variant(s) [window|sidebar] (default is window)
  -s, --screen    Screen display variant(s)   [1080p|2k|4k] (default is 1080p)

  -h, --help      Show this help

EOF
}

generate() {
  local dest="${1}"
  local theme="${2}"
  local screen="${3}"

  local THEME_DIR="${1}/${THEME_NAME}-${2}"

  copy_files

  prompt -s "\n Finished ..."
}

while [[ $# -gt 0 ]]; do
  case "${1}" in
    -d|--dest)
      dest="${2}"
      if [[ ! -d "${dest}" ]]; then
        echo -e "\nDestination directory does not exist. Let's make a new one..."
        mkdir -p ${dest}
      fi
      shift 2
      ;;
    -t|--theme)
      shift
      for theme in "${@}"; do
        case "${theme}" in
          window)
            themes+=("${THEME_VARIANTS[0]}")
            shift
            ;;
          sidebar)
            themes+=("${THEME_VARIANTS[1]}")
            shift
            ;;
          -*)
            break
            ;;
          *)
            prompt -e "ERROR: Unrecognized theme variant '$1'."
            prompt -i "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -s|--screen)
      shift
      for screen in "${@}"; do
        case "${screen}" in
          1080p)
            screens+=("${SCREEN_VARIANTS[0]}")
            shift
            ;;
          2k)
            screens+=("${SCREEN_VARIANTS[1]}")
            shift
            ;;
          4k)
            screens+=("${SCREEN_VARIANTS[2]}")
            shift
            ;;
          -*)
            break
            ;;
          *)
            prompt -e "ERROR: Unrecognized screen variant '$1'."
            prompt -i "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      prompt -e "ERROR: Unrecognized installation option '$1'."
      prompt -i "Try '$0 --help' for more information."
      exit 1
      ;;
  esac
done

for theme in "${themes[@]-${THEME_VARIANTS[0]}}"; do
  for screen in "${screens[@]-${SCREEN_VARIANTS[0]}}"; do
    generate "${dest:-$REO_DIR}" "${theme}" "${screen}"
  done
done

exit 0
