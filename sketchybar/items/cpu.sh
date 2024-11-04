#!/bin/bash

# sketchybar --add item cpu right \
#            --set cpu  update_freq=2 \
#                       icon=􀧓   󰘚 \
#                       script="$PLUGIN_DIR/cpu.sh"
# 󰑭

FONT="Hack Nerd Font"

sketchybar --add alias "Stats,Sensors_sensors" e \
  --set "Stats,Sensors_sensors" update_freq=2 \
  icon.padding_right=0 icon.font="$FONT:Regular:16.0" icon.color=$RED label.drawing=off \
  icon=
sketchybar --add alias "Stats,CPU_mini" e \
  --set "Stats,CPU_mini" update_freq=2 \
  icon.padding_right=0 icon.font="$FONT:Regular:18.0" icon.color=$ORANGE label.drawing=off \
  icon=󰍛
sketchybar --add alias "Stats,RAM_mini" e \
  --set "Stats,RAM_mini" update_freq=2 \
  icon.padding_right=2 icon.font="$FONT:Regular:20.0" icon.color=$YELLOW label.drawing=off \
  icon=󰘚
