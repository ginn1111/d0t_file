# Evondev Dracula — opt-in bundle

Seven independent outputs: `herdr.toml`, `kitty.conf`, `nvim/colors/evondev_dracula.lua`, `lualine.lua`, `yazi.toml`, `starship.toml`, `cindy-hermes.yaml`. None is activated by checking out this directory. Do not run the repository installer for this theme.

## Provenance and palette

Reference: [Evondev Dracula `Dracula-darker-contrast.json`](https://github.com/evondev/evondev-dracula/blob/388ada2140ec3ea78995308f0d1f4c3ea504ff67/themes/Dracula-darker-contrast.json), specifically its `colors` and `tokenColors`. This upstream JSON is a VS Code theme with a misleading internal `name` (`Dracula high contrast`); reference the **file path**, not that name. The selected local VS Code variant, **Evondev Dracula Darker Text**, has no available theme JSON here. This bundle is a **provisional Darker Contrast adaptation**, not an exact Darker Text port. `#7f5cdf` is Gin's local VS Code status-bar override, not an upstream token. The status color is used only in surfaces with a status/tab bar.

| Semantic role | Hex | Source / intended use |
| --- | --- | --- |
| Canvas | `#141523` | `editor.background`, `terminal.background` |
| Raised surface | `#191a21` | `statusBar.background`, panels |
| Text | `#f8f8f2` | `editor.foreground` |
| Muted / comment | `#7f848e` | token `comment`; secondary labels |
| Selection | `#44475a` | `editor.selectionBackground` |
| Accent purple | `#bd93f9` | `terminal.ansiBlue`; focus and controls |
| Success mint | `#20e3b2` | `terminal.ansiGreen`; success / functions |
| Warning yellow | `#fde181` | `terminal.ansiYellow`; warnings |
| Error red | `#ff5555` | `terminal.ansiRed`; errors |
| Cyan | `#8be9fd` | `terminal.ansiCyan`; information / types |
| Pink | `#ff6bcb` | `terminal.ansiMagenta`; keywords |
| String | `#f1fa8c` | token `string` |
| Number/orange | `#ffb86c` | source token color |
| Local status override | `#7f5cdf` | user setting, not upstream |

Kitty `color0`–`color15` copy upstream `terminal.ansiBlack`, Red, Green, Yellow, Blue, Magenta, Cyan, White and their Bright counterparts **in that order**, retaining the source's unusual bright black `#8d92ff` and duplicate green/blue/pink values. `#21222c` is source black; `#282a36` and `#6272a4` are source secondary surfaces/text. Non-ANSI surface and syntax mappings are semantic translations, not literal VS Code selector translations.

## Preview and activate manually

Set `BUNDLE` to the absolute checkout path of this directory. Make a backup of each destination before an intentional merge. Steps below are examples, **not commands run by this bundle**. Every activation touches your own settings only when you execute it; revert by restoring the backup (or undoing the specific addition). Do not replace symlinks just to try the theme.

- **Herdr:** `herdr.toml` is a *fragment*, not a full `config.toml`. In your Herdr config, edit the existing `[theme]` values to `name = "dracula"` and `auto_switch = false`, and merge the listed keys into the existing `[theme.custom]` table. Do **not** append a second `[theme]` or `[theme.custom]` heading, and do not copy over `[keys]`, `[terminal]`, or integrations. Validate a temporary merged copy with `HERDR_CONFIG_PATH=/absolute/path/to/merged.toml herdr config check`; then opt in to your normal config and reload only if desired. Undo just these theme fields from your backup.
- **Kitty:** For an isolated preview: `kitty -c NONE -c "$BUNDLE/kitty.conf"`. For lasting activation, place a copy of `kitty.conf` in your Kitty configuration directory and add a single `include evondev-dracula.conf` **after** other color includes in your existing `kitty.conf`; use the actual copied filename and avoid duplicate include lines. To revert, remove that include and restore the previous color include priority. Do not edit `current-theme.conf` automatically.
- **Neovim:** Add `$BUNDLE/nvim` to `runtimepath` for a one-session preview, then `:colorscheme evondev_dracula`. For persistence, copy `nvim/colors/evondev_dracula.lua` into your own `~/.config/nvim/colors/` and select the scheme in your own startup config. Revert by selecting the prior scheme and removing the copy. This file only sets core and Tree-sitter highlight groups; plugin-specific groups keep their defaults.
- **Lualine:** Independently set `options.theme = dofile("/absolute/path/to/lualine.lua")` in your *existing* Lualine setup, or copy the theme into `lua/lualine/themes/evondev_dracula.lua` and use `options.theme = "evondev_dracula"`. Undo the option to restore your prior theme. The repository's `configs/nvim/lua/plugins/lualine.lua` is a broken absolute symlink: neither this bundle nor these instructions require following or repairing it.
- **Yazi:** `theme.toml` is the user theme file. In a **separate** Yazi config directory, copy `yazi.toml` as `theme.toml`, then launch with `YAZI_CONFIG_HOME=/absolute/path/to/separate-config yazi`. If you already have a working Yazi config, merge only the desired tables and rules into its theme file after a backup; do not replace existing `[filetype].rules` blindly. Revert via the backup or launch without that environment override. The repository's `configs/yazi/theme.toml` is a broken absolute symlink; leave it alone.
- **Starship:** Preview per shell with `STARSHIP_CONFIG="$BUNDLE/starship.toml" starship prompt --path "$PWD"`; to enable, set `STARSHIP_CONFIG` in your own shell startup *before* its `starship init`. Revert by unsetting the variable or restoring its old value. Only directory, optional git branch/status, and glyph appear on the left; right prompt is empty, no prompt newline.
- **Cindy Hermes:** Copy `cindy-hermes.yaml` to **Cindy's profile** `<cindy-hermes-home>/skins/evondev-dracula-cindy.yaml` (for example `$HERMES_HOME/skins/` when Cindy's profile is selected). Then, only with Gin's approval for a live setting change, select it via `hermes config set display.skin evondev-dracula-cindy` **in Cindy's profile**. Revert with `hermes config set display.skin default` or the previously selected skin. This bundle does not install or select a skin and never touches Gin's Hermes profile.

## Verification boundary

The files are static. TOML/YAML parsing, Neovim headless loading, Herdr `config check` with an isolated `HERDR_CONFIG_PATH`, and Starship rendering can be checked without changing live config. Kitty/Yazi interactive appearance needs a terminal session; an isolated CLI/config parse is not a substitute for visual approval. See task DOT-1 for evidence and any runtime limits.
