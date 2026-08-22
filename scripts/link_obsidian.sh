#!/bin/bash

set -u

# BASH_SOURCE may point to a symlink in ~/.local/bin rather than this repository.
SOURCE_SCRIPT="${BASH_SOURCE[0]}"
# Follow the chain so the repository root is derived from the real script path.
while [ -L "$SOURCE_SCRIPT" ]; do
  # Resolve relative symlink targets from the directory containing each link.
  LINK_DIR="$(cd -P -- "$(dirname -- "$SOURCE_SCRIPT")" && pwd)"
  LINK_TARGET="$(readlink "$SOURCE_SCRIPT")"
  case "$LINK_TARGET" in
    /*) SOURCE_SCRIPT="$LINK_TARGET" ;;
    *) SOURCE_SCRIPT="$LINK_DIR/$LINK_TARGET" ;;
  esac
done

SCRIPT_DIR="$(cd -P -- "$(dirname -- "$SOURCE_SCRIPT")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"
SOURCE="$REPO_ROOT/configs/obsidian"
TARGET="$PWD/.obsidian"

if [ ! -d "$SOURCE" ]; then
  printf '✗ Missing Obsidian config: %s\n' "$SOURCE" >&2
  exit 1
fi

if [ -L "$TARGET" ]; then
  current="$(readlink "$TARGET")"
  if [ "$current" = "$SOURCE" ]; then
    printf '✓ Obsidian config already linked in %s\n' "$PWD"
    exit 0
  fi
  rm "$TARGET"
elif [ -e "$TARGET" ]; then
  printf '⚠ %s exists and is not a symlink; leaving it unchanged\n' "$TARGET" >&2
  exit 1
fi

ln -s "$SOURCE" "$TARGET"
printf '✓ Linked %s → %s\n' "$TARGET" "$SOURCE"
