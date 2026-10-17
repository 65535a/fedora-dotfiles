#!/bin/bash
STATUS="$(mullvad status 2>/dev/null)"
echo "$STATUS" | grep -q "^Connected" || exit 0

LOCATION="$(echo "$STATUS" | grep -m1 'Visible location' | sed 's/.*Visible location: *//')"
[ -z "$LOCATION" ] && LOCATION="$(echo "$STATUS" | head -1)"

jq -nc --arg t "Mullvad: $LOCATION" '{text: "󰕥", tooltip: $t, class: "connected"}'