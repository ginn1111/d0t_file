#!/bin/bash

# sketchybar --add item cpu right \
#            --set cpu  update_freq=2 \
#                       icon=􀧓  \
#                       script="$PLUGIN_DIR/cpu.sh"

sketchybar --add alias "Stats,RAM_mini" right \
  --set "Stats,RAM_mini" update_freq=2 \
  icon.padding_right=2 label.drawing=off \
  icon=􀧓

sketchybar --add alias "Stats,CPU_mini" right \
  --set "Stats,CPU_mini" update_freq=2 \
  icon.padding_right=2 label.drawing=off \
  icon=
