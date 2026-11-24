#!/usr/bin/env bash
# List windows in the i3 scratchpad with rofi (Cindy theme); show the one you pick.

# Cindy Black & Ruby applet theme (same as the Cindy hub, cindy.sh)
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

list=$(i3-msg -t get_tree | jq -r '
  .. | objects | select(.name == "__i3_scratch")
  | .. | objects | select(.window != null)
  | "\(.id)\t\(.window_properties.class)  —  \(.name)"')

if [ -z "$list" ]; then
    notify-send "Scratchpad" "Scratchpad is empty" 2>/dev/null
    exit 0
fi

count=$(printf '%s\n' "$list" | wc -l)
lines=$(( count < 8 ? count : 8 ))

choice=$(printf '%s\n' "$list" | cut -f2 | rofi \
    -theme-str 'window {width: 520px;}' \
    -theme-str "listview {columns: 1; lines: $lines;}" \
    -theme-str 'textbox-prompt-colon {str: "◇";}' \
    -dmenu -i -format i \
    -p "Scratchpad" \
    -mesg "$count hidden window(s) · Enter to show" \
    -theme "$theme")
[ -z "$choice" ] && exit 0

id=$(printf '%s\n' "$list" | sed -n "$((choice + 1))p" | cut -f1)
i3-msg "[con_id=$id] scratchpad show, move position center" >/dev/null
