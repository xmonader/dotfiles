#!/bin/bash
# KDE Plasma 6 productivity setup
# Run this to configure i3-like keybindings, virtual desktops, and auto-tiling

set -e

echo "=== Setting up 9 virtual desktops (3x3 grid) ==="
kwriteconfig6 --file kwinrc --group Desktops --key Number 9
kwriteconfig6 --file kwinrc --group Desktops --key Rows 3

echo "=== Clearing task manager Meta+N shortcuts ==="
for i in 1 2 3 4 5 6 7 8 9; do
    kwriteconfig6 --file kglobalshortcutsrc --group plasmashell --key "activate task manager entry $i" "none,Meta+$i,Activate Task Manager Entry $i"
done

echo "=== Setting up desktop switching shortcuts (Meta+1-9) ==="
for i in 1 2 3 4 5 6 7 8 9; do
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Switch to Desktop $i" "Meta+$i,,Switch to Desktop $i"
done

echo "=== Setting up move-window-to-desktop shortcuts (Meta+Shift+1-9) ==="
for i in 1 2 3 4 5 6 7 8 9; do
    kwriteconfig6 --file kglobalshortcutsrc --group kwin --key "Window to Desktop $i" "Meta+Shift+$i,,Window to Desktop $i"
done

echo "=== Installing auto-tile KWin script ==="
SCRIPT_DIR="$HOME/.local/share/kwin/scripts/kdeautotile"
mkdir -p "$SCRIPT_DIR/contents/code"
cp "$(dirname "$0")/kwin-autotile/metadata.json" "$SCRIPT_DIR/metadata.json"
cp "$(dirname "$0")/kwin-autotile/contents/code/main.js" "$SCRIPT_DIR/contents/code/main.js"
kwriteconfig6 --file kwinrc --group Plugins --key kdeautotileEnabled true

echo "=== Fixing Vivaldi snap password manager access ==="
if snap list vivaldi &>/dev/null; then
    doas snap connect vivaldi:password-manager-service || true
fi

echo "=== Reloading KWin ==="
qdbus6 org.kde.KWin /KWin reconfigure

echo "Done! KDE is now configured with:"
echo "  - 9 virtual desktops (3x3 grid)"
echo "  - Meta+1-9: switch desktops"
echo "  - Meta+Shift+1-9: move window to desktop"
echo "  - i3-like auto-tiling (master/stack)"
echo "  - Vivaldi snap password manager access"
