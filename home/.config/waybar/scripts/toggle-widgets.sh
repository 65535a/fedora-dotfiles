#!/bin/bash
EWW="$HOME/.local/bin/eww"
WINDOWS=("stats-widget" "journal-widget")

if $EWW active-windows | grep -q "${WINDOWS[0]}"; then
    for w in "${WINDOWS[@]}"; do
        $EWW close "$w"
    done
else
    for w in "${WINDOWS[@]}"; do
        $EWW open "$w"
    done
fi

pkill -RTMIN+8 waybar