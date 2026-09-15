#!/bin/bash
EWW="$HOME/.local/bin/eww"
WINDOW="stats-widget"

if $EWW active-windows | grep -q "$WINDOW"; then
    echo '{"text": "󰜬", "class": "active", "tooltip": "Widgets: shown (click to hide)"}'
else
    echo '{"text": "󱍕", "class": "inactive", "tooltip": "Widgets: hidden (click to show)"}'
fi