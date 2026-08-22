#!/bin/sh

printf '  → Installing zk dependencies\n'

brew install ripgrep fzf sqlite3 bat

printf '  ✓ Zk dependencies installed\n'

printf '  → Preparing note-taking directories\n'
if [ ! -d ~/note-taking-system ]; then
  mkdir -p ~/note-taking-system
fi

if [ -d ~/note-taking-system ]; then
  mkdir -p ~/note-taking-system/task
  mkdir -p ~/note-taking-system/idea
  mkdir -p ~/note-taking-system/archive
  mkdir -p ~/note-taking-system/\$in
fi
printf '  ✓ Note-taking directories ready\n'
