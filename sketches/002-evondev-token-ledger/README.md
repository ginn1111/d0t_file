## Token ledger

### Design stance
A dense, portable reference sheet that makes semantic role names and hex values the primary artifact.

### Key choices
- Layout: token table with a smaller contextual editor/terminal sample.
- Typography: system UI with monospace role names and values.
- Color: provisional upstream Evondev Dracula Darker Contrast, plus the local VS Code status-bar override.
- Interaction: toggle editor/terminal and click a row to copy its hex.

### Trade-offs
- Strong at: finding and exporting named colors.
- Weak at: judging how a whole workspace feels.

### Best for
A cross-tool implementation blueprint where mappings matter more than visual polish.
