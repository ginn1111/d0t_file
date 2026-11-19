#!/bin/sh
# Based on polybar/polybar-scripts system-cpu-temppercore; AMD k10temp fallback added.
SENSORS=/home/thuan-aioz/.local/bin/sensors
fmt() { sed -E 's/^[^:]+:[[:space:]]*\+?([0-9]+)(\.[0-9]+)?°C.*/\1°C/' | paste -sd' ' | sed 's/ /  /g'; }
out=$($SENSORS 2>/dev/null | grep -E '^Core [0-9]+:' | fmt)
[ -z "$out" ] && out=$($SENSORS 'k10temp-*' 2>/dev/null | grep -E '^(Tctl|Tccd[0-9]+):' | fmt)
echo "${out:-N/A}"
