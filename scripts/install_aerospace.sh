#!/bin/sh
echo "Install aerospace ..."

echo "Install dependencies ..."

brew install --cask font-sf-pro

echo "Install dependencies done"

# borderszz
brew tap FelixKratz/formulae
brew install borders

# Aerospace
brew install --cask nikitabobko/tap/aerospace

echo "Install aerospace done"
