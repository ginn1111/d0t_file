#!/usr/bin/env bash
# Polybar: show the active fcitx5 input method (tail mode, prints on change).
# Click handling lives in config.ini ([module/fcitx5]).

REMOTE="${FCITX5_REMOTE:-$HOME/.local/bin/fcitx5-remote}"
command -v "$REMOTE" >/dev/null 2>&1 || REMOTE="fcitx5-remote"

label() {
    case "$1" in
        keyboard-us) echo "EN" ;;
        unikey)      echo "VI" ;;
        keyboard-*)  echo "${1#keyboard-}" | tr '[:lower:]' '[:upper:]' ;;
        "")          echo "off" ;;
        *)           echo "$1" ;;
    esac
}

prev=""
while :; do
    cur=$(label "$("$REMOTE" -n 2>/dev/null)")
    if [[ "$cur" != "$prev" ]]; then
        echo "$cur"
        prev="$cur"
    fi
    sleep 0.5
done
