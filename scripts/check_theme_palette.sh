#!/bin/bash
# Fails if a themed config is missing or uses a hex color outside the Solarized Osaka palette.
# Lines starting with '#' are comments and are ignored (kitty/toml/yaml all use '#' comments).
set -u

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
PALETTE="$ROOT/configs/theme/solarized-osaka.palette"
FILES=(
  "configs/kitty/solarized_osaka_dark.conf"
  "configs/yazi/theme.toml"
  "configs/herdr/config.toml"
  "configs/hermes/skins/solarized-osaka-gintary.yaml"
  "configs/hermes/skins/solarized-osaka-ginb.yaml"
)

allowed="$(grep -oE '#[0-9a-fA-F]{6}' "$PALETTE" | tr 'A-F' 'a-f' | sort -u)"
status=0

for f in "${FILES[@]}"; do
  if [ ! -f "$ROOT/$f" ]; then
    printf 'MISSING %s\n' "$f"
    status=1
    continue
  fi
  used="$(grep -vE '^[[:space:]]*#' "$ROOT/$f" | grep -oE '#[0-9a-fA-F]{6}' | tr 'A-F' 'a-f' | sort -u)"
  bad="$(comm -23 <(printf '%s\n' "$used") <(printf '%s\n' "$allowed") | grep -v '^$')"
  if [ -n "$bad" ]; then
    printf 'OFF-PALETTE %s: %s\n' "$f" "$(echo $bad)"
    status=1
  fi
done

grep -qE '^include[[:space:]]+solarized_osaka_dark\.conf' "$ROOT/configs/kitty/kitty.conf" \
  || { printf 'kitty.conf does not include solarized_osaka_dark.conf\n'; status=1; }

[ "$status" -eq 0 ] && printf 'theme palette OK\n'
exit "$status"
