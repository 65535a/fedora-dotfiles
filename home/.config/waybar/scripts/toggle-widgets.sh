#!/bin/bash
EWW="$HOME/.local/bin/eww"
WINDOW="stats-widget"

if $EWW active-windows | grep -q "$WINDOW"; then
    $EWW close "$WINDOW"
else
    $EWW open "$WINDOW"
fi