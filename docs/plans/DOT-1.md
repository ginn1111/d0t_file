---
status: completed
scope: Portable opt-in Evondev Dracula theme for seven tools
owner: Gin
---

# Plan — DOT-1 portable theme bundle

1. Inspect upstream theme JSON and local Herdr, Kitty, Neovim/Lualine, Yazi, Starship, and Hermes conventions. Confirm exact color roles and tool schemas; record provenance and caveat in the bundle guide. Evidence: extracted source color table and observed configuration paths (B1, B2).
2. Write a static palette guide and independent tool files under `themes/evondev-dracula/`. Do not edit active configs or broken symlinks. Evidence: explicit file list and scoped Git diff/status (B1, B2, B5).
3. Document opt-in activation and rollback for each tool. For tools with only whole-file config support, give merge steps rather than destructive replacement. Evidence: guide review against each output (B3).
4. Validate TOML/YAML/Lua syntax and runtime-specific configuration where possible; render Starship in a temporary clean directory and a Git checkout. Evidence: real command output and checks for 16 ANSI colors and one-line module order (B1, B4).
5. Recheck existing active-file status/diff, report the provisional source mismatch and any checks blocked by broken symlinks or runtime limitations. Evidence: scoped Git status and a task update (B5).

## Verification commands

- `uv run --no-project --with pyyaml --python /opt/homebrew/bin/python3 themes/evondev-dracula/verify.py`
- `HERDR_CONFIG_PATH="$PWD/themes/evondev-dracula/herdr.toml" herdr config check`
- `nvim --headless -u NONE -i NONE --cmd 'set rtp^=themes/evondev-dracula/nvim' --cmd 'colorscheme evondev_dracula' --cmd "lua assert(vim.g.colors_name == 'evondev_dracula')" --cmd "lua local t=dofile('themes/evondev-dracula/lualine.lua'); assert(t.normal.a.bg == '#7f5cdf')" +qa`
- Kitty config parsed in isolation via `kitty +runpy` and `kitty.config.load_config`, checking `accumulate_bad_lines` is empty.

Yazi TTY-dependent interactive rendering was not exercised. The repository's pre-existing `scripts/check_theme_palette.sh` fails independently of this bundle: missing `configs/theme/solarized-osaka.palette`, broken `configs/yazi/theme.toml`, and unmatched active Solarized config. The external Ginflow harness also reports blockers for missing canonical project verification and restart instructions (plus warnings about repository-local instructions); it does not validate this opt-in bundle. Gin subsequently authorized a scoped local commit of DOT-1 files solely for review; no activation, push, or symlink repair is part of this card.
