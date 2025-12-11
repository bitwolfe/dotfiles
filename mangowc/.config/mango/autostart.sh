#!/bin/bash

set +e

# set settings for screen record/share
dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots >/dev/null 2>&1

# notifications
swaync -c ~/.config/mango/swaync/config.json -s ~/.config/mango/swaync/style.css >/dev/null 2>&1 &

# night light
wlsunset -T 3501 -t 3500 >/dev/null 2>&1 &

elephant >/dev/null 2>&1 &

# walker service (app launcher)
walker --gapplication-service >/dev/null 2>&1 &

# wallpaper
swww-daemon >/dev/null 2>&1 &

# top bar
waybar -c ~/.config/mango/waybar/config.jsonc -s ~/.config/mango/waybar/style.css >/dev/null 2>&1 &

# hypridle and hyprlock
hypridle -c ~/.config/mango/hypridle.conf >/dev/null 2>&1 &

# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &

# clipboard content manager
wl-paste --type text --watch cliphist store >/dev/null 2>&1 &

# xwayland dpi scale
echo "Xft.dpi: 100" | xrdb -merge
gsettings set org.gnome.desktop.interface text-scaling-factor 1.00

# permission agent
/usr/libexec/polkit-mate-authentication-agent-1 >/dev/null 2>&1 &

#snixembed --fork &

# xdg autostart
#systemctl --user start mango-session.target >/dev/null 2>&1 &

/usr/bin/arch-update --tray >/dev/null 2>&1 &

/usr/bin/1password --silent >/dev/null 2>&1 &

/usr/bin/nextcloud --background >/dev/null 2>&1 &

/usr/bin/steam -silent >/dev/null 2>&1 &

/opt/discord/Discord --start-minimized >/dev/null 2>&1 &
