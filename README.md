# Modern Development Environment Dotfiles

A comprehensive dotfiles repository containing configuration files for a modern development environment across macOS, Linux, and Windows. This setup emphasizes terminal-based workflows with Fish shell, Neovim, Kitty terminal, and tmux.

## Features

- **Cross-platform support**: macOS, Linux, and Windows configurations
- **Modern terminal stack**: Fish shell with Starship prompt, Kitty terminal, tmux multiplexer
- **Neovim setup**: LazyVim-based configuration with TypeScript, ESLint, Prettier support
- **Window management**: Aerospace (macOS), SketchyBar status bar
- **Consistent theming**: Solarized/Catppuccin themes across all tools
- **Development tools**: Yazi file manager, Lazygit, NVM auto-switching

## Quick Start

### Installation

```bash
# Clone the repository
git clone <repository-url> ~/.config/dotfiles
cd ~/.config/dotfiles

# Install all configurations
./scripts/install.sh
```

This will create symbolic links for all major configuration directories: aerospace, sketchybar, fish, kitty, neofetch, nvim, tmux, zk, and borders.

### Key Tools & Aliases

- **Editor**: `v` → Neovim with LazyVim
- **File manager**: `yz` → Yazi
- **Git UI**: `lzg` → Lazygit  
- **Docker**: `dk` → docker, `dp` → docker-compose
- **Package managers**: npm, yarn, pnpm, bun aliases

## Configuration Structure

### Core Components

- **Fish Shell** (`fish/`): Main shell with platform-specific configs and aliases
- **Neovim** (`nvim/`): LazyVim-based setup with custom plugins
- **Kitty Terminal** (`kitty/`): Modern terminal with Solarized theme
- **Tmux** (`tmux/`): Terminal multiplexer with Catppuccin theme
- **Window Management**: Aerospace + SketchyBar (macOS)

### Platform Support

The configuration automatically detects the platform and loads appropriate settings:
- `config-osx.fish`, `config-linux.fish`, `config-windows.fish`
- Tmux imports macOS-specific settings when detected

## Development Environment

- **Languages**: Node.js (NVM), Go, Rust, Java support
- **Themes**: Consistent Solarized/Catppuccin across tools
- **Fonts**: Nerd Fonts for consistent iconography
- **Plugins**: Managed via lazy.nvim, TPM, and Fisher

## Usage

After installation, reload your shell or restart your terminal. The configuration provides:
- Vim-like navigation in tmux (`h,j,k,l`)
- Modern file browsing with Yazi
- Comprehensive Git workflow with Lazygit
- Full-featured Neovim IDE experience
