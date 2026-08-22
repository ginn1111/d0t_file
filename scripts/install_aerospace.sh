#!/bin/sh
printf '  → Installing aerospace dependencies\n'

printf '  → Installing SF Pro font\n'

brew install --cask font-sf-pro

printf '  ✓ SF Pro font installed\n'

printf '  → Installing borders\n'
brew tap FelixKratz/formulae
brew install borders

printf '  → Installing aerospace\n'
brew install --cask nikitabobko/tap/aerospace

printf '  ✓ Aerospace dependencies installed\n'
