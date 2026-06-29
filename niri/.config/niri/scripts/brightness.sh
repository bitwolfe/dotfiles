#!/bin/bash

DEFAULT_BRIGHTNESS=135
MIN_BRIGHTNESS=40
STATE_CACHE="$HOME/.cache/dotfiles/display-brightness"

die() {
    echo "brightness.sh: $*" >&2
    exit 1
}

is_number() {
    [[ "$1" =~ ^[0-9]+$ ]]
}

get_current_brightness() {
    local output
    local brightness

    if ! output=$(ddcutil getvcp 10 -t --skip-ddc-checks 2>&1); then
        die "failed to get current brightness: $output"
    fi

    brightness=$(awk '/^VCP[[:space:]]+10[[:space:]]+C[[:space:]]+[0-9]+[[:space:]]+[0-9]+$/ { print $4; exit }' <<<"$output")
    if ! is_number "$brightness"; then
        die "failed to parse current brightness from ddcutil output: $output"
    fi

    echo "$brightness"
}

set_brightness() {
    local brightness="$1"

    if ! is_number "$brightness"; then
        die "invalid brightness value: $brightness"
    fi

    ddcutil setvcp 10 "$brightness" --skip-ddc-checks || die "failed to set brightness to $brightness"
}

case "$1" in
    dim)
        current_brightness=$(get_current_brightness) || exit 1
        mkdir -p "$(dirname "$STATE_CACHE")"
        echo "$current_brightness" >"$STATE_CACHE"
        set_brightness "$MIN_BRIGHTNESS"
        ;;
    restore)
        if [ -f "$STATE_CACHE" ]; then
            previous_brightness=$(<"$STATE_CACHE")
        else
            previous_brightness="$DEFAULT_BRIGHTNESS"
        fi

        set_brightness "$previous_brightness"
        rm -f "$STATE_CACHE"
        ;;
    *)
        echo "Usage: $0 {dim|restore}"
        exit 1
        ;;
esac
