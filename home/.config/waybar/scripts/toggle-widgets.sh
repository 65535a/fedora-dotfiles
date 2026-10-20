#!/bin/bash
EWW="$HOME/.local/bin/eww"
WINDOW="$1"
SIGNAL="$2"

if $EWW active-windows | grep -q "$WINDOW"; then
    $EWW close "$WINDOW"
else
    $EWW open "$WINDOW"
fi

pkill -RTMIN+"$SIGNAL" waybar