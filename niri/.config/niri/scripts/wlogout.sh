#!/usr/bin/env bash

res_w=$(niri msg -j outputs | jq '."DP-2".current_mode as $mode | ."DP-2".modes[$mode].width')
res_h=$(niri msg -j outputs | jq '."DP-2".current_mode as $mode | ."DP-2".modes[$mode].height')
h_scale=$(niri msg -j outputs | jq '."DP-2".logical.scale')

if [ -z "$res_w" ]; then
  echo ":: Resolution not detected"
  exit 1
fi

w_margin=$((res_h * 27 / h_scale))

wlogout -l ~/.config/niri/wlogout/layout -C ~/.config/niri/wlogout/style.css -b 5 -T $w_margin -B $w_margin
