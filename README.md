
## Installation:

Usage:  `./install.sh [OPTIONS...]`

```
  -t, --theme     Background theme variant(s) [window|sidebar] (default is window)
  -s, --screen    Screen display variant(s)   [1080p|2k|4k] (default is 1080p)
  -r, --remove    Remove/Uninstall theme      (must add theme options, default is Matrices-window)
  -b, --boot      Install theme into '/boot/grub' or '/boot/grub2'
  -h, --help      Show this help
```

_If no options are used, a user interface `dialog` will show up instead_

### Examples:
 - Install window theme on 2k display device:

```sh
sudo ./install.sh -t window -s 2k
```

 - Install sidebar theme into /boot/grub/themes:

```sh
sudo ./install.sh -b -t sidebar
```

 - Uninstall window theme:

```sh
sudo ./install.sh -r -t window
```

## Issues / tweaks:

### Correcting display resolution:

 - On the grub screen, press `c` to enter the command line
 - Enter `vbeinfo` or `videoinfo` to check available resolutions
 - Open `/etc/default/grub`, and edit `GRUB_GFXMODE=[height]x[width]x32` to match your resolution
 - Finally, run `grub-mkconfig -o /boot/grub/grub.cfg` to update your grub config

### Setting a custom background:

 - Make sure you have `imagemagick` installed, or at least something that provides `convert`
 - Find the resolution of your display, and make sure your background matches the resolution
   - 1920x1080 >> 1080p
   - 2560x1440 >> 2k
   - 3840x2160 >> 4k
 - Place your custom background inside the root of the project, and name it `background.jpg`
 - Run the installer like normal, but with -s `[YOUR_RESOLUTION]` and -t `[THEME]` and -i `[ICON]`
   - Make sure to replace `[YOUR_RESOLUTION]` with your resolution and `[THEME]` with the theme

## Contributing:
 - If you made changes to icons, or added a new one:
   - Delete the existing icon, if there is one
   - Run `cd assets; ./render-all.sh`
 - Create a pull request from your branch or fork
 - If any issues occur, report then to the [issue](issues) page

## Preview:
![preview-01](backgrounds/previews/preview-window.jpg?raw=true)
![preview-02](backgrounds/previews/preview-sidebar.jpg?raw=true)

## Documents

[Grub2 theme reference](https://wiki.rosalab.ru/en/index.php/Grub2_theme_/_reference)

[Grub2 theme tutorial](https://wiki.rosalab.ru/en/index.php/Grub2_theme_tutorial)
