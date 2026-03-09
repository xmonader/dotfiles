.PHONY: install stow kde

SWAY_DEPS = sway swaylock foot rofi wofi wl-clipboard stow dunst pcmanfm waybar terminator \
      xdg-desktop-portal-wlr xdg-desktop-portal-gtk libappindicator3-1 \
      mako-notifier gnome-keyring network-manager-gnome

install:
	doas apt install -y $(SWAY_DEPS)

stow:
	stow -v -t $(HOME) sway dunst rofi vim terminator localdir

kde:
	bash kde/setup.sh
