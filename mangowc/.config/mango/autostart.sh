#!/bin/bash

set +e

# obs
dbus-update-activation-environment --systemd DISPLAY TERMINAL WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots >/dev/null 2>&1
