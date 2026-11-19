#!/bin/sh
# Start i3 with logging. Logs: ~/.local/state/i3/
export LD_LIBRARY_PATH="$HOME/.local/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export PATH="$HOME/.local/bin:$PATH"

# Snap apps (firefox) force GDK_BACKEND=wayland whenever GNOME's wayland-0 socket
# exists, so they fail with "cannot open display" here. Keep them on this X server.
export DISABLE_WAYLAND=1

LOGDIR="${XDG_STATE_HOME:-$HOME/.local/state}/i3"
mkdir -p "$LOGDIR"
LOG="$LOGDIR/i3.log"

# Keep the previous session's log
[ -f "$LOG" ] && mv -f "$LOG" "$LOG.old"

# Fail loudly (into the log) if the config is broken
{
  echo "=== i3 session start: $(date '+%F %T') DISPLAY=$DISPLAY ==="
  "$HOME/.local/bin/i3" -C -V 2>&1 || echo "!!! i3 config check reported errors (see above)"
} >>"$LOG" 2>&1

# Replace the shell with i3; stdout+stderr go to the log
exec "$HOME/.local/bin/i3" --shmlog-size=26214400 >>"$LOG" 2>&1
