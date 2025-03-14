#! /bin/bash

OPEN_DIR=$(cd $(dirname $0) && pwd)

THEME_NAME=Matrices

SCREEN_VARIANTS=('1080p' '2k' '4k')
THEME_VARIANTS=('window' 'sidebar')

screens=()
themes=()

if [[ "${#screens[@]}" -eq 0 ]] ; then
  screens=("${SCREEN_VARIANTS[@]}")
fi

if [[ "${#themes[@]}" -eq 0 ]] ; then
  themes=("${THEME_VARIANTS[@]}")
fi

Tar_themes() {
  for theme in "${themes[@]}"; do
    rm -rf ${THEME_NAME}-${theme}-grub-themes.tar
    rm -rf ${THEME_NAME}-${theme}-grub-themes.tar.xz
  done

  for theme in "${themes[@]}"; do
    tar -Jcvf ${THEME_NAME}-${theme}-grub-themes.tar.xz ${THEME_NAME}-${theme}-grub-themes
  done
}

Clear_theme() {
  for theme in "${themes[@]}"; do
    rm -rf ${THEME_NAME}-${theme}-grub-themes
  done
}

for theme in "${themes[@]}"; do
  for screen in "${screens[@]}"; do
    ./generate.sh -d "$OPEN_DIR/releases/${THEME_NAME}-${theme}-grub-themes/${screen}" -t "${theme}" -s "${screen}"
    cp -rf "$OPEN_DIR/releases/"install "$OPEN_DIR/releases/${THEME_NAME}-${theme}-grub-themes/${screen}"/install.sh
    cp -rf "$OPEN_DIR/backgrounds/previews/preview-${theme}.jpg" "$OPEN_DIR/releases/${THEME_NAME}-${theme}-grub-themes/${screen}/preview.jpg"
    sed -i "s/grub_theme_name/${THEME_NAME}-${theme}/g" "$OPEN_DIR/releases/${THEME_NAME}-${theme}-grub-themes/${screen}"/install.sh
  done
done

cd "$OPEN_DIR/releases"

Tar_themes && Clear_theme

