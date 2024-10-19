#!/bin/bash
sketchybar --add event aerospace_workspace_change

MONITORS=$(aerospace list-monitors | awk '{print $1}')

for m in ${MONITORS[@]}; do
  for sid in $(aerospace list-workspaces --monitor $m); do
    sketchybar --add space space.$sid left \
      --set space.$sid space=$sid \
      icon=$sid \
      icon.font="$FONT:Regular:12.0" \
      label.font="sketchybar-app-font:Regular:12.0" \
      label.padding_right=20 \
      label.y_offset=-1 \
      script="$PLUGIN_DIR/space.sh $sid" \
      --subscribe space.$sid space_windows_change aerospace_workspace_change
  done
done

sketchybar --add item space_separator left \
  --set space_separator icon="􀆊" \
  icon.color=$ACCENT_COLOR \
  icon.padding_left=4 \
  label.drawing=off \
  background.drawing=off \
  script="$PLUGIN_DIR/space_windows.sh" \
  --subscribe space_separator space_windows_change aerospace_workspace_change
