#!/usr/bin/env bash

if pgrep -x "Hyprland" >/dev/null; then
  ~/.config/hypr/scripts/wallpaper.sh "$@"
elif pgrep -x "mango" >/dev/null; then
  ~/.config/mango/scripts/wallpaper.sh "$@"
elif pgrep -x "niri" >/dev/null; then
  ~/.config/niri/scripts/wallpaper.sh "$@"
else
  notify-send -a Waypaper "Waypaper post-command error" "Attempted to run Waypaper post-command with unknown compositor."
fi
