---
status: completed
card: DOT-1
assignee: cindy
blocked_by: []
scope: Portable opt-in Evondev Dracula theme for terminal and workspace tools
owner: Gin
---

# Spec — Portable Evondev Dracula theme

## Source and intent

Use the upstream Evondev Dracula **Darker Contrast** colors shown in the two approved palette sketches. The locally selected VS Code theme is named “Evondev Dracula Darker Text,” but its exact theme JSON is unavailable; do not claim an exact match. Preserve the local status-bar override `#7f5cdf` where a status bar exists. The theme is opt-in and must not alter existing active settings.

## Behavior

- **B1 Palette:** A documented, static semantic palette maps exact upstream values to canvas, surface, text, muted, selection, accent, success, warning, error, syntax, and ANSI colors. Record source and the provisional-match caveat.
- **B2 Outputs:** Provide theme files for Herdr, Kitty, Neovim, Lualine, Yazi, one-line Starship, and a Cindy Hermes skin. Neovim and Lualine are separate outputs; neither requires editing the currently broken symlink targets.
- **B3 Activation:** Each tool has opt-in instructions, including a safe merge for Herdr (theme snippet is not a full copy of the user's config) and Yazi, and a way to revert. No automatic activation, reload, symlink replacement, or edits to live configs.
- **B4 Starship:** Prompt is exactly one line: directory, git branch/status, prompt glyph. No right prompt, runtime, infrastructure, time, or newline modules. Git information is absent outside a repository.
- **B5 Safety:** All artifacts are additive under a dedicated theme directory except linked spec/plan. Do not touch unrelated modified or deleted files; do not attempt to repair existing symlinks.

## Verification

- Parse TOML and YAML files; parse Lua files and load theme modules in isolation where possible.
- Validate all color strings and semantic tokens against the source JSON and intended derivations; verify 16 terminal ANSI colors and Starship's one-line output with and without a Git repository.
- Verify no changes to existing active configs using targeted Git status/diff. When a tool cannot parse a fragment standalone, test an explicitly constructed temporary merged config without touching live settings.

## Acceptance

- [x] Seven opt-in outputs and a palette/activation guide exist at `themes/evondev-dracula/`.
- [x] Starship renders a single minimal line; no right prompt (`themes/evondev-dracula/verify.py`).
- [x] TOML/YAML, Kitty, Herdr, and Neovim/Lualine validate with real commands. Yazi's interactive appearance still requires a TTY and visual approval.
- [x] Existing active configs remain unchanged by this task; baseline workspace dirt and broken symlinks were left alone.
