#!/bin/bash
EWW="$HOME/.local/bin/eww"
WINDOW="$1"

if $EWW active-windows | grep -q "$WINDOW"; then
    echo "{\"alt\":\"active\",\"class\":\"active\",\"tooltip\":\"$WINDOW: shown (click to hide)\"}"
else
    echo "{\"alt\":\"inactive\",\"class\":\"inactive\",\"tooltip\":\"$WINDOW: hidden (click to show)\"}"
fi