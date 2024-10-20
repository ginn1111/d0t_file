#!/bin/bash

SYM_LINKS=("aerospace" "sketchybar" "fish" "kitty" "neofetch" "nvim" "tmux" "zk" "borders")

# NOTE: exec in the current directory
echo "Creating symbol links ..."

for sl in ${SYM_LINKS[@]}; do
  ln -s "$PWD/$sl" "$HOME/.config/"
done

echo "Creating symbol links done!"

bash ./install_zk_note.sh
bash ./install_aerospace.sh
