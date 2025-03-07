#!/bin/bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

THEME_VARIANTS=('-window' '-sidebar')

render_background() {
  local theme="${1}"

  local FILEID="background${theme}"
  local FILENAME="$REPO_DIR/backgrounds/$FILEID"

  mkdir -p "$REPO_DIR/backgrounds"

  if [[ -f "$FILENAME.jpg" ]]; then
    echo "$FILENAME exists"
  else
    echo -e "\nRendering $FILENAME.png"
    $INKSCAPE "--export-id=$FILEID" \
              "--export-dpi=96" \
              "--export-id-only" \
              "--export-filename=$FILENAME.png" "backgrounds.svg" >/dev/null
    convert "$FILENAME.png" "$FILENAME.jpg"
  fi

  rm -rf "$FILENAME.png"
}

for theme in "${THEME_VARIANTS[@]}"; do
  render_background "${theme}"
done

exit 0
