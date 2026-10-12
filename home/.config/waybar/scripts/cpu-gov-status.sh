#!/bin/sh
# Waybar status for performance mode (CPU governor + PipeWire buffer). Outputs JSON.

gov=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo unknown)

meta() {
    pw-metadata -n settings 0 "$1" 2>/dev/null | sed -n "s/.*value:'\([0-9]*\)'.*/\1/p" | head -n1
}

quantum=$(meta clock.force-quantum)
rate=$(meta clock.force-rate)

if [ -n "$quantum" ] && [ "$quantum" != "0" ]; then
    [ -z "$rate" ] || [ "$rate" = "0" ] && rate=48000
    ms=$(awk -v q="$quantum" -v r="$rate" 'BEGIN { printf "%.1f", q / r * 1000 }')
    buf="Buffer: $quantum samples ($ms ms at $rate Hz)"
else
    buf="Buffer: PipeWire default"
fi

if [ "$gov" = "performance" ]; then
    printf '{"text":"󰙽","tooltip":"CPU governor: performance\\n%s\\nClick to switch back","class":"performance"}\n' "$buf"
else
    printf '{"text":"󰚘","tooltip":"CPU governor: %s\\n%s\\nClick for performance mode","class":"normal"}\n' "$gov" "$gov" "$buf"
fi
