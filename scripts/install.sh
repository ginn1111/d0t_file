#!/bin/bash

set -u

# Tool directories under configs/ that should be linked into the user's config home.
SYM_LINKS=("aerospace" "fish" "kitty" "neofetch" "nvim" "tmux" "zk" "borders" "herdr" "yazi" "borders")

# Resolve the script's directory so the installer works from any current directory.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"
CONFIG_DIR="$REPO_ROOT/configs"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
LOCAL_BIN="${XDG_BIN_HOME:-$HOME/.local/bin}"

printf '\n🚀  Installing dotfiles\n\n'
mkdir -p "$CONFIG_HOME"

for sl in "${SYM_LINKS[@]}"; do
  source="$CONFIG_DIR/$sl"
  target="$CONFIG_HOME/$sl"

  if [ ! -d "$source" ]; then
    printf '  ✗ Missing config: %s\n' "$source" >&2
    exit 1
  fi

  if [ -L "$target" ]; then
    current="$(readlink "$target")"
    if [ "$current" = "$source" ]; then
      printf '  ✓ %-12s already linked\n' "$sl"
      continue
    fi
    rm "$target"
  elif [ -e "$target" ]; then
    printf '  ⚠ %-12s exists and is not a symlink; skipping\n' "$sl" >&2
    continue
  fi

  printf '  → Linking %-12s\n' "$sl"
  ln -s "$source" "$target"
done

printf '\n✓  Dotfile links created\n'

if [ -t 0 ]; then
  answer=""
  printf '\n🔗  Link link_obsidian to %s? [y/N] ' "$LOCAL_BIN"
  read -r answer || answer=""

  case "$answer" in
  y | Y | yes | YES)
    local_link="$LOCAL_BIN/link_obsidian"
    mkdir -p "$LOCAL_BIN"

    if [ -L "$local_link" ]; then
      current="$(readlink "$local_link")"
      if [ "$current" = "$SCRIPT_DIR/link_obsidian.sh" ]; then
        printf '  ✓ link_obsidian already linked\n'
      else
        rm "$local_link"
        ln -s "$SCRIPT_DIR/link_obsidian.sh" "$local_link"
        printf '  ✓ Refreshed %s\n' "$local_link"
      fi
    elif [ -e "$local_link" ]; then
      printf '  ⚠ %s exists and is not a symlink; skipping\n' "$local_link" >&2
    else
      ln -s "$SCRIPT_DIR/link_obsidian.sh" "$local_link"
      printf '  ✓ Linked %s\n' "$local_link"
    fi
    ;;
  *)
    printf '  ↷ Skipped link_obsidian\n'
    ;;
  esac
else
  printf '\n↷  Skipping link_obsidian prompt (non-interactive)\n'
fi

printf '\n⚙  Installing zk dependencies\n'
bash "$SCRIPT_DIR/install_zk_note.sh"
printf '\n⚙  Installing aerospace dependencies\n'
bash "$SCRIPT_DIR/install_aerospace.sh"
printf '\n✓  Dotfiles installation complete\n'
