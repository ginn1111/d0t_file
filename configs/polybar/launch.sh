#!/usr/bin/env bash
# Launch polybar on every connected monitor (rootless install in ~/.local).
export PATH="$HOME/.local/bin:$PATH"
POLYBAR="$HOME/.local/bin/polybar"
LOG="${XDG_RUNTIME_DIR:-/tmp}/polybar"

# Stop running instances
polybar-msg cmd quit >/dev/null 2>&1 || killall -q -u "$USER" polybar
for i in $(seq 1 20); do pgrep -u "$UID" -x polybar >/dev/null || break; sleep 0.2; done

primary=$(xrandr --query | awk '/ connected primary/{print $1}')
for m in $(xrandr --query | awk '/ connected/{print $1}'); do
  MONITOR="$m" "$POLYBAR" --reload example >>"$LOG-$m.log" 2>&1 &
  disown
done
echo "polybar launched on: $(xrandr --query | awk '/ connected/{printf "%s ", $1}') (primary: $primary)"
