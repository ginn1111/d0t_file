#!/usr/bin/env bash

## Applets : Network (NetworkManager via nmcli)
## Style matches adi1090x applets; uses the shared applet theme.

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

notify() { command -v notify-send >/dev/null && notify-send -u low "Network" "$1"; }

# State
radio="$(nmcli -t radio wifi 2>/dev/null)"
active="$(nmcli -t -f NAME,TYPE,DEVICE connection show --active 2>/dev/null \
	| awk -F: '$2 !~ /loopback/ {printf "%s%s (%s)", sep, $1, $3; sep=", "}')"
[[ -z "$active" ]] && active="not connected"

prompt='Network'
mesg="Active: $active"

# Fixed options
opt_toggle="󰖪 Turn Wi-Fi off"
[[ "$radio" != "enabled" ]] && opt_toggle="󰖩 Turn Wi-Fi on"
opt_rescan="󰑐 Rescan"
opt_editor="󰒓 Edit connections"
opt_tui="󰆍 nmtui"

# Wi-Fi list: "<inuse> <bars> <ssid>  <security>" ; dedupe by SSID, hide empty SSIDs
wifi_list() {
	[[ "$radio" != "enabled" ]] && return
	nmcli -t -f IN-USE,SIGNAL,SECURITY,SSID dev wifi list 2>/dev/null \
	| awk -F: '
		{ ssid=$4; for (i=5;i<=NF;i++) ssid=ssid ":" $i; gsub(/\\/, "", ssid) }
		ssid=="" || seen[ssid]++ { next }
		{
			s=$2+0
			icon = s>=75 ? "󰤨" : s>=50 ? "󰤥" : s>=25 ? "󰤢" : "󰤟"
			lock = ($3=="" || $3=="--") ? " " : "󰌾"
			mark = ($1=="*") ? "" : " "
			printf "%s %s %s %s\t%s\n", mark, icon, lock, ssid, ssid
		}'
}

rofi_cmd() {
	rofi -theme-str 'window {width: 480px;}' \
		-theme-str 'listview {columns: 1; lines: 10; scrollbar: true;}' \
		-theme-str 'textbox-prompt-colon {str: "󰖩";}' \
		-dmenu -i \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme "${theme}" "$@"
}

ask_password() {
	rofi -theme-str 'window {width: 400px;}' \
		-theme-str 'mainbox {children: [ "inputbar", "message" ];}' \
		-theme-str 'inputbar {children: [ "textbox-prompt-colon", "prompt", "entry" ];}' \
		-theme-str 'entry {enabled: true; padding: 10px;}' \
		-theme-str 'textbox-prompt-colon {str: "󰌾";}' \
		-dmenu -password \
		-p "Password" \
		-mesg "Wi-Fi: $1" \
		-theme "${theme}" </dev/null
}

connect_ssid() {
	local ssid="$1" out
	# Saved profile? bring it up directly.
	if nmcli -t -f NAME connection show | grep -Fxq -- "$ssid"; then
		out="$(nmcli connection up id "$ssid" 2>&1)" && { notify "Connected to $ssid"; return; }
	fi
	out="$(nmcli dev wifi connect "$ssid" 2>&1)" && { notify "Connected to $ssid"; return; }
	# Needs a password
	local pw; pw="$(ask_password "$ssid")"
	[[ -z "$pw" ]] && return
	if out="$(nmcli dev wifi connect "$ssid" password "$pw" 2>&1)"; then
		notify "Connected to $ssid"
	else
		notify "Failed: $out"
	fi
}

# Build menu + parallel SSID array; rofi returns the selected index (-format i)
wifi_rows=() wifi_ssids=()
while IFS=$'\t' read -r row ssid; do
	wifi_rows+=("$row"); wifi_ssids+=("$ssid")
done < <(wifi_list)

rows=("$opt_toggle" "${wifi_rows[@]}" "$opt_rescan" "$opt_editor" "$opt_tui")
idx="$(printf '%s\n' "${rows[@]}" | rofi_cmd -format i)"
[[ -z "$idx" ]] && exit 0
n=${#wifi_rows[@]}

if   (( idx == 0 ));      then
	if [[ "$radio" == "enabled" ]]; then nmcli radio wifi off; else nmcli radio wifi on; fi
elif (( idx <= n ));      then
	connect_ssid "${wifi_ssids[idx-1]}"
elif (( idx == n + 1 ));  then
	nmcli dev wifi rescan >/dev/null 2>&1; sleep 2; exec "$0"
elif (( idx == n + 2 ));  then
	nm-connection-editor >/dev/null 2>&1 & disown
elif (( idx == n + 3 ));  then
	x-terminal-emulator -e nmtui >/dev/null 2>&1 & disown
fi
