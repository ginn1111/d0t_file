#!/bin/bash

# sketchybar --add item front_app left \
#   --set front_app background.color=$ACCENT_COLOR \
#   icon.color=$BAR_COLOR \
#   icon.font="sketchybar-app-font:Regular:12.0" \
#   label.color=$BAR_COLOR \
#   script="$PLUGIN_DIR/front_app.sh" \
#   --subscribe front_app front_app_switched

front_app=(
  label.font="$FONT:Regular:10.0"
  icon.background.drawing=on
  background.border_width=0
  display=active
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
)
sketchybar --add item front_app left \
  --set front_app "${front_app[@]}" \
  --subscribe front_app front_app_switched
