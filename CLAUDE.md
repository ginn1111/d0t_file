# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive dotfiles repository containing configuration files for a modern development environment across macOS, Linux, and Windows. The setup emphasizes terminal-based workflows with Fish shell, Neovim, Kitty terminal, and tmux.

## Installation and Setup

### Primary Installation
- Run `./scripts/install.sh` to create symbolic links for all major configuration directories
- This script links: aerospace, sketchybar, fish, kitty, neofetch, nvim, tmux, zk, borders to `~/.config/`
- Additional scripts: `install_zk_note.sh` and `install_aerospace.sh` are called automatically

### Platform-Specific Configuration
- Fish shell loads platform-specific configs: `config-osx.fish`, `config-linux.fish`, or `config-windows.fish`
- Tmux imports macOS-specific settings with: `source ~/.config/tmux/macos.conf`

## Core Configuration Architecture

### Fish Shell (`fish/`)
- **Main config**: `config.fish` - handles PATH setup, aliases, and platform detection
- **Platform configs**: Separate files for OS-specific settings
- **Key aliases**: 
  - `v` → `nvim`, `lzg` → `lazygit`, `yz` → `yazi`
  - Docker: `dk` → `docker`, `dp` → `docker-compose`
  - Git shortcuts: `g`, `gp`, `gpull`, `glo`, etc.
- **Environment**: Uses Starship prompt, supports NVM auto-switching
- **Plugins**: Managed via `fish_plugins` (currently using git plugin)

### Neovim (`nvim/`)
- **Framework**: LazyVim-based configuration
- **Plugin manager**: lazy.nvim with automatic bootstrapping
- **Language support**: TypeScript, JSON, Tailwind CSS built-in
- **Features**: ESLint, Prettier, dashboard, project utils, mini animations
- **Custom plugins**: Located in `lua/plugins/` directory
- **Key files**: 
  - `init.lua` → `require("config.lazy")`
  - `lua/config/lazy.lua` - main plugin configuration

### Kitty Terminal (`kitty/`)
- **Theme**: Solarized Dark Higher Contrast (via `current-theme.conf`)
- **Font**: Inconsolata LGC Nerd Font Mono, size 14
- **Features**: Background opacity (0.8), blur (20), startup session
- **Key bindings**: macOS-style copy/paste, vim-like scrolling
- **Startup**: Loads `kitty-startup.session` automatically

### Tmux (`tmux/`)
- **Prefix**: `C-Space` (Control + Space)
- **Theme**: Catppuccin macchiato flavor
- **Key features**: 
  - Vim-like pane navigation (`h,j,k,l`)
  - Split bindings: `'` (horizontal), `/` (vertical)
  - Status bar at top, mouse support enabled
- **Plugins**: TPM, tmux-sensible, catppuccin theme
- **Plugin path**: `~/.tmux/plugins/tpm/tpm`

## Development Environment

### Key Development Tools
- **Editor**: Neovim with LazyVim
- **Shell**: Fish with Starship prompt
- **Terminal**: Kitty with custom keybindings
- **Multiplexer**: Tmux with catppuccin theme
- **File manager**: Yazi (`yz` alias)
- **Git UI**: Lazygit (`lzg` alias)

### Language/Runtime Management
- **Node.js**: NVM with auto-switching via `.nvmrc` detection
- **Go**: GOPATH set to `~/.local/src/go`
- **Rust**: Cargo binaries in PATH
- **Java**: JAVA_HOME configured for JDK 11
- **Package managers**: npm, yarn, pnpm, bun (with aliases)

### Window Management (macOS)
- **Aerospace**: Tiling window manager configuration
- **SketchyBar**: Status bar configuration with custom modules
- **Borders**: Window border customization

## Key Configuration Patterns

### Cross-Platform Support
- Fish shell detects OS with `uname` and loads appropriate config
- Tmux conditionally loads macOS-specific settings
- Separate config files maintain platform-specific customizations

### Plugin Management
- **Neovim**: lazy.nvim with LazyVim framework and extras
- **Tmux**: TPM (Tmux Plugin Manager) with plugins in `~/.tmux/plugins/`
- **Fish**: Fisher for plugin management

### Theme Consistency
- Solarized/Catppuccin themes across terminal, editor, and multiplexer
- Nerd Font usage for consistent iconography
- Background transparency and blur effects in terminal

## Common Workflow Commands

### Development Setup
```bash
# Install all configurations
./scripts/install.sh

# Reload configurations
source ~/.config/fish/config.fish  # Fish
tmux source ~/.config/tmux/tmux.conf  # Tmux (prefix + r also works)
```

### Daily Usage
- Terminal navigation: Use `h,j,k,l` in tmux panes
- File management: `yz` (yazi) for file browsing
- Git operations: `lzg` (lazygit) or fish git aliases
- Editor: `v filename` (neovim with full LazyVim setup)

The configuration emphasizes keyboard-driven workflows, consistent theming, and cross-platform compatibility while maintaining separate concerns for different tools.