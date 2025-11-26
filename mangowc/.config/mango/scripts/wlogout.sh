#!/usr/bin/env bash

res_w=$(wlr-randr --json | jq '.[].modes[] | select(.current==true) | .width')
res_h=$(wlr-randr --json | jq '.[].modes[] | select(.current==true) | .height')
h_scale=$(wlr-randr --json | jq '.[].scale' | awk '{print $1 * 100}')

if [ -z "$res_w" ]; then
  echo ":: Resolution not detected"
  exit 1
fi

w_margin=$((res_h * 27 / h_scale))

wlogout -l ~/.config/mango/wlogout/layout -C ~/.config/mango/wlogout/style.css -b 5 -T $w_margin -B $w_margin

