#!/usr/bin/env bash

theme="$HOME/.config/rofi/launchers/type-4/style-1.rasi"
selected=$(systemctl list-unit-files --no-pager --type=service --no-legend | rofi -dmenu -i -p service -theme "$theme" | awk '{print $1;}')

selected=$(echo $selected | awk '{print $1;}')

if [ x$selected != x ] ; then

    action=$(printf "start\nstop\nrestart\n" | rofi -dmenu -p action -theme "$theme")
    
    case "$action" in
        "start")
            pkexec systemctl start $selected
            ;;
        "stop")
            pkexec systemctl stop $selected
            ;;
        "restart")
            pkexec systemctl restart $selected
            ;;
        "")
            exec $0 "$@"
            ;;
    esac

fi
