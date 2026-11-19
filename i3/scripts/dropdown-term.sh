#!/bin/sh
# Toggle the drop-down kitty terminal (i3 scratchpad).
# Starts it first if it is not running (e.g. after it was closed).

has_dropdown() {
    i3-msg -t get_tree | grep -q '"class":"dropdown"'
}

if ! has_dropdown; then
    kitty --class dropdown >/dev/null 2>&1 &
    # wait up to 5s for the window to be managed (for_window moves it to scratchpad)
    i=0
    while [ $i -lt 50 ] && ! has_dropdown; do
        sleep 0.1
        i=$((i + 1))
    done
fi

i3-msg '[class="dropdown"] scratchpad show, move position center' >/dev/null
