#!/usr/bin/env bash

selected=$(systemctl list-unit-files --no-pager --type=service --no-legend | rofi -dmenu -i -p service | awk '{print $1;}')

selected=$(echo $selected | awk '{print $1;}')

if [ x$selected != x ] ; then

    action=$(printf "start\nstop\nrestart\n" | rofi -dmenu -p action)
    
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
