#!/bin/sh
# Toggles "performance mode": CPU governor + PipeWire buffer size.
# Runs as your normal user. Only the root-owned /usr/local/bin/cpu-gov-toggle
# runs with sudo; nothing in this file gets root rights.

QUANTUM=256         # buffer size in samples when performance mode is on
RATE=48000          # sample rate in Hz when performance mode is on
NORMAL_QUANTUM=1024 # buffer size in samples when performance mode is off

sudo -n /usr/local/bin/cpu-gov-toggle || {
    notify-send "Performance mode" "Could not switch the CPU governor (sudo rule missing?)" 2>/dev/null
    exit 1
}

gov=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)

if [ "$gov" = "performance" ]; then
    pw-metadata -n settings 0 clock.force-rate "$RATE" >/dev/null
    pw-metadata -n settings 0 clock.force-quantum "$QUANTUM" >/dev/null
else
    # Relaxed buffer for normal use; rate goes back to PipeWire's default
    pw-metadata -n settings 0 clock.force-quantum "$NORMAL_QUANTUM" >/dev/null
    pw-metadata -n settings 0 clock.force-rate 0 >/dev/null
fi

# Tell Waybar to refresh the button right away
pkill -RTMIN+8 waybar
