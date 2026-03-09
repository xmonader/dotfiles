# dotfiles

these are my current system configurations (sway/Wayland)

## structure

every root directory in this repo is for specific application and all files underneath are to be linked relative to the home dir e.g ( PATH/TO/DOTFILES/sway/.config/sway/config -> /home/USERNAME/.config/sway/config )

## setup

- fork the repo
- install dependencies: `make install`
- symlink configs: `make stow`

alternatively install [stow](https://www.gnu.org/software/stow/) or [nistow](https://github.com/xmonader/nistow) manually and run `stow <dir>` per app.

## deps

- sway
- swaylock
- foot
- rofi (rofi-wayland)
- wofi
- wl-clipboard
- dunst
- pcmanfm
- waybar
- terminator
- stow

## keybindings

- alt+w: finding window
- alt+r: rofi launcher
- alt+k: process killer
- alt+m: math evaluator
- alt+l: lock screen
- alt+s: duckduckgo search
- alt+a: all rofi apps
- alt+v: youtube video player
- alt+f: file manager
- alt+shift+q: close window
