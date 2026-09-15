#!/bin/bash
IFACE="wld0"
STAT="/sys/class/net/$IFACE/statistics/tx_bytes"
CACHE="/tmp/eww-net-up-cache"

CURRENT=$(cat "$STAT")
NOW=$(date +%s.%N)

if [[ -f "$CACHE" ]]; then
    read -r PREV PREV_TIME < "$CACHE"
    DELTA_BYTES=$(( CURRENT - PREV ))
    DELTA_TIME=$(echo "$NOW - $PREV_TIME" | bc)
    KBPS=$(echo "scale=1; $DELTA_BYTES / 1024 / $DELTA_TIME" | bc)
else
    KBPS=0
fi

echo "$CURRENT $NOW" > "$CACHE"
echo "$KBPS"
