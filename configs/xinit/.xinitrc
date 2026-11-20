#!/bin/sh
# Start i3 with logging. Logs: ~/.local/state/i3/
export LD_LIBRARY_PATH="$HOME/.local/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export PATH="$HOME/.local/bin:$PATH"

# The locally extracted imlib2 (used by feh) looks for its image loaders in the
# compiled-in /usr/lib/x86_64-linux-gnu/imlib2, which does not exist here, so
# feh fails with "No Imlib2 loader for that file format". Point it at our copy.
export IMLIB2_LOADER_PATH="$HOME/.local/opt/i3-tools/usr/lib/x86_64-linux-gnu/imlib2/loaders"

# Snap apps (firefox) force GDK_BACKEND=wayland whenever GNOME's wayland-0 socket
# exists, so they fail with "cannot open display" here. Keep them on this X server.
export DISABLE_WAYLAND=1

# Input method (fcitx5 + unikey for Vietnamese).
# fcitx5 itself is started from ~/.config/i3/config; these variables tell each
# kind of X app how to find it. They must be exported before i3 starts so every
# app launched from i3 inherits them. Changes need a logout/login to apply.
#
#   XMODIFIERS      legacy XIM protocol: plain X11 apps (xterm, etc.)
#   GTK_IM_MODULE   GTK apps (Firefox, Slack, ...) load fcitx5's GTK im-module
#   QT_IM_MODULE    Qt apps load fcitx5's Qt platform-input-context plugin
#   GLFW_IM_MODULE  kitty on X11 only supports the ibus protocol (no "fcitx"
#                   value exists); fcitx5 ships an ibus frontend
#                   (libibusfrontend.so) that answers it, so kitty, and Neovim
#                   inside it, can type through unikey.
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

# Cursor theme (user-local, ~/.local/share/icons). Exported so every app
# launched from i3 (GTK, Qt, kitty, Electron) picks the same theme and size.
export XCURSOR_THEME=Bibata-Original-Ice
export XCURSOR_SIZE=24
export XCURSOR_PATH="$HOME/.icons:$HOME/.local/share/icons:/usr/share/icons"
[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

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
