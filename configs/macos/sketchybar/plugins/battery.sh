#!/bin/sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

source "$CONFIG_DIR/icons.sh"  # Loads all defined colors
source "$CONFIG_DIR/colors.sh" # Loads all defined colors

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

case ${PERCENTAGE} in
9[0-9] | 100)
  ICON=$BATTERY_100
  COLOR=$GREEN
  ;;
[6-8][0-9])
  ICON=$BATTERY_75
  COLOR=$YELLOW
  ;;
[3-5][0-9])
  ICON=$BATTERY_50
  COLOR=$ORANGE
  ;;
[1-2][0-9])
  ICON=$BATTERY_25
  COLOR=$RED
  ;;
*)
  ICON=$BATTERY_0
  COLOR=$ACCENT_COLOR
  ;;
esac

if [[ $CHARGING != "" ]]; then
  ICON=$BATTERY_CHARGING
  COLOR=$ACCENT_COLOR
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set $NAME icon="$ICON" icon.color=$COLOR label="${PERCENTAGE}%"
