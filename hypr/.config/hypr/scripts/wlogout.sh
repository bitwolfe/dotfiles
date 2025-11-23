#!/usr/bin/env bash

if pgrep -x "Hyprland" >/dev/null ; then
    res_w=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
    res_h=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
    h_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')
elif pgrep -x "niri" >/dev/null ; then
    res_w=$(niri msg -j outputs | jq '."DP-2".current_mode as $mode | ."DP-2".modes[$mode].width')
    res_h=$(niri msg -j outputs | jq '."DP-2".current_mode as $mode | ."DP-2".modes[$mode].height')
    h_scale=$(niri msg -j outputs | jq '."DP-2".logical.scale')
fi

if [ -z "$res_w" ]; then
    echo ":: Resolution not detected"
    exit 1
fi

w_margin=$((res_h * 27 / h_scale))

echo ":: Width: $res_w"
echo ":: Height: $res_h"
echo ":: Scale: $h_scale"
echo ":: W Margin: $w_margin"
wlogout -b 5 -T $w_margin -B $w_margin