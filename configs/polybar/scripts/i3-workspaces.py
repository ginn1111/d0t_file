#!/usr/bin/python3
"""Polybar i3 workspaces with per-window app icons (stdlib only, raw i3 IPC).

  i3-workspaces.py            -> tail mode: print one line per i3 change
  i3-workspaces.py goto NAME  -> switch workspace (used by click actions)
  i3-workspaces.py cmd ...    -> run an arbitrary i3 command (scroll)

Shows only workspaces on $MONITOR (polybar sets it via launch.sh).
"""
import glob
import json
import os
import socket
import struct
import sys
import time

# ---- look (Cindy Black & Ruby) ------------------------------------------
C_ACTIVE_BG = "#3a1a26"   # colors.rule
C_ACTIVE_FG = "#bec6d0"   # colors.foreground
C_UNDERLINE = "#c62f52"   # colors.primary
C_VISIBLE_FG = "#bec6d0"
C_OCCUPIED_FG = "#a0acbb"  # colors.sub
C_ICON_DIM = "#6b7686"     # colors.dim (icons on unfocused workspaces)
C_URGENT_BG = "#e35535"    # colors.alert
C_URGENT_FG = "#111418"
BOLD_FONT = 2              # polybar font-1 (1-based %{T2})
PAD = 1                    # spaces inside each workspace pill (left/right)
GAP = 6                    # px between workspace pills
ICON_GAP = 1               # spaces between number and icons / between icons
DEDUPE = True              # one icon per app per workspace
MAX_ICONS = 6

# window class/instance (lowercase, substring match) -> Nerd Font glyph
ICONS = [
    ("firefox", "\U000f0239"),
    ("brave", "\U000f059f"),
    ("chrom", "\U000f02af"),
    ("slack", "\U000f04b1"),
    ("discord", "\U000f066f"),
    ("telegram", "\uf2c6"),
    ("code", "\U000f0a1e"),
    ("cursor", "\U000f0a1e"),
    ("spotify", "\U000f04c7"),
    ("vlc", "\U000f057c"),
    ("thunderbird", "\U000f01ee"),
    ("thunar", "\U000f024b"),
    ("nautilus", "\U000f024b"),
    ("pcmanfm", "\U000f024b"),
    ("nemo", "\U000f024b"),
    ("pavucontrol", "\U000f057e"),
    ("obsidian", "\U000f0219"),
    ("libreoffice", "\U000f0219"),
    ("kitty", "\U000f018d"),
    ("alacritty", "\U000f018d"),
    ("wezterm", "\U000f018d"),
    ("terminal", "\U000f018d"),
    ("xterm", "\U000f018d"),
]
DEFAULT_ICON = "\U000f08c6"  # md-application

# ---- i3 IPC -------------------------------------------------------------
MAGIC = b"i3-ipc"
RUN_COMMAND, GET_WORKSPACES, SUBSCRIBE, GET_TREE = 0, 1, 2, 4


def sock_path():
    p = os.environ.get("I3SOCK")
    if p and os.path.exists(p):
        return p
    found = sorted(glob.glob(f"/run/user/{os.getuid()}/i3/ipc-socket.*"),
                   key=os.path.getmtime, reverse=True)
    if found:
        return found[0]
    raise FileNotFoundError("i3 IPC socket not found")


def connect():
    s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    s.connect(sock_path())
    return s


def _recv_exact(s, n):
    buf = b""
    while len(buf) < n:
        chunk = s.recv(n - len(buf))
        if not chunk:
            raise ConnectionError("i3 socket closed")
        buf += chunk
    return buf


def send(s, mtype, payload=""):
    data = payload.encode()
    s.sendall(MAGIC + struct.pack("=II", len(data), mtype) + data)


def recv(s):
    hdr = _recv_exact(s, len(MAGIC) + 8)
    length, mtype = struct.unpack("=II", hdr[len(MAGIC):])
    return mtype, json.loads(_recv_exact(s, length))


def query(mtype, payload=""):
    s = connect()
    try:
        send(s, mtype, payload)
        return recv(s)[1]
    finally:
        s.close()


# ---- rendering ----------------------------------------------------------
def icon_for(props):
    keys = " ".join(
        (props.get(k) or "").lower() for k in ("class", "instance"))
    for needle, glyph in ICONS:
        if needle in keys:
            return glyph
    return DEFAULT_ICON


def collect_windows(node, out, ws=None):
    if node.get("type") == "workspace":
        ws = node.get("name")
    props = node.get("window_properties")
    if ws and node.get("window") and props:
        out.setdefault(ws, []).append(icon_for(props))
    for child in node.get("nodes", []) + node.get("floating_nodes", []):
        collect_windows(child, out, ws)
    return out


def esc_action(text):
    return text.replace(":", "\\:")


def render():
    monitor = os.environ.get("MONITOR", "")
    workspaces = query(GET_WORKSPACES)
    icons = collect_windows(query(GET_TREE), {})
    me = os.path.realpath(__file__)
    parts = []
    # Real spaces (not %{O}) inside pills: polybar offsets skip the underline.
    pad, sp = " " * PAD, " " * ICON_GAP
    for ws in sorted(workspaces, key=lambda w: (w["num"] < 0, w["num"], w["name"])):
        if monitor and ws["output"] != monitor:
            continue
        name = ws["name"]
        glyphs = icons.get(name, [])
        if DEDUPE:
            glyphs = list(dict.fromkeys(glyphs))
        glyphs = glyphs[:MAX_ICONS]
        # Nerd Font icons overflow their cell to the right: add a space after each.
        icon_str = sp.join(g + " " for g in glyphs)
        if ws["urgent"]:
            body = name + (sp + icon_str if glyphs else "")
            seg = f"%{{B{C_URGENT_BG}}}%{{F{C_URGENT_FG}}}{pad}{body}{pad}%{{F-}}%{{B-}}"
        elif ws["focused"]:
            body = f"%{{T{BOLD_FONT}}}{name}%{{T-}}" + (sp + icon_str if glyphs else "")
            seg = (f"%{{B{C_ACTIVE_BG}}}%{{F{C_ACTIVE_FG}}}%{{u{C_UNDERLINE}}}%{{+u}}"
                   f"{pad}{body}{pad}%{{-u}}%{{F-}}%{{B-}}")
        else:
            fg = C_VISIBLE_FG if ws["visible"] else C_OCCUPIED_FG
            body = name
            if glyphs:
                body += f"{sp}%{{F{C_ICON_DIM}}}{icon_str}%{{F-}}"
            seg = f"%{{F{fg}}}{pad}{body}{pad}%{{F-}}"
        click = esc_action(f"{me} goto {name}")
        parts.append(f"%{{A1:{click}:}}{seg}%{{A}}")
    return f"%{{O{GAP}}}".join(parts)


def tail():
    last = None
    while True:
        try:
            s = connect()
            send(s, SUBSCRIBE, json.dumps(["workspace", "window", "output", "shutdown"]))
            recv(s)  # subscribe ack
            while True:
                line = render()
                if line != last:
                    print(line, flush=True)
                    last = line
                mtype, ev = recv(s)
                if mtype & 0x7FFFFFFF == 6 and ev.get("change") in ("restart", "exit"):
                    break  # i3 restarting: reconnect
        except (OSError, ConnectionError, ValueError):
            pass
        last = None
        time.sleep(0.5)


def main():
    if len(sys.argv) >= 3 and sys.argv[1] == "goto":
        name = " ".join(sys.argv[2:]).replace('"', '\\"')
        query(RUN_COMMAND, f'workspace "{name}"')
    elif len(sys.argv) >= 3 and sys.argv[1] == "cmd":
        query(RUN_COMMAND, " ".join(sys.argv[2:]))
    else:
        tail()


if __name__ == "__main__":
    main()
