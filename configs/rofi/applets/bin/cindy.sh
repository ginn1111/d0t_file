#!/usr/bin/env bash

## Applets : Cindy hub — one entry point to the other rofi applets.

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"
dir="$HOME/.config/rofi"

prompt='Cindy'
mesg="$(hostname) · up $(uptime -p | sed -e 's/up //')"

# label | command   (command runs via bash -c)
entries=(
	"󰀻 Apps|$dir/launchers/type-4/launcher.sh"
	"󰖩 Network|$dir/applets/bin/network.sh"
	"󰕾 Volume|$dir/applets/bin/volume.sh"
	"󰖟 Quick links|$dir/applets/bin/quicklinks.sh"
	"󰒓 Settings|gnome-control-center"
	"󰐥 Power|$dir/applets/bin/powermenu.sh"
)

idx="$(printf '%s\n' "${entries[@]%%|*}" | rofi \
	-theme-str 'window {width: 360px;}' \
	-theme-str "listview {columns: 1; lines: ${#entries[@]};}" \
	-theme-str 'textbox-prompt-colon {str: "◇";}' \
	-dmenu -i -format i \
	-p "$prompt" \
	-mesg "$mesg" \
	-theme "${theme}")"

[[ -z "$idx" ]] && exit 0
cmd="${entries[idx]#*|}"
setsid -f bash -c "$cmd" >/dev/null 2>&1
