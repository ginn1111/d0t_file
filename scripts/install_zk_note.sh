#!/bin/sh

# install dependencies
echo 'Install zk dependencies ...'

brew install ripgrep fzf sqlite3 bat

echo 'Installing zk dependencies done!'

echo 'Checking zk environments ...'
if [ ! -d ~/note-taking-system ]; then
  mkdir -p ~/note-taking-system
fi

if [ -d ~/note-taking-system ]; then
  mkdir -p ~/note-taking-system/task
  mkdir -p ~/note-taking-system/idea
  mkdir -p ~/note-taking-system/archive
  mkdir -p ~/note-taking-system/\$in
fi
echo 'Checking zk environments done!'
