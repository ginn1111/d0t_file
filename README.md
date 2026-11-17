# Modern Development Environment Dotfiles

A comprehensive dotfiles repository containing configuration files for a modern development environment across macOS, Linux, and Windows. This setup emphasizes terminal-based workflows with Bash, Neovim, Kitty terminal, and tmux.

## Features

- **Cross-platform support**: macOS, Linux, and Windows configurations
- **Modern terminal stack**: Bash with Starship prompt, Kitty terminal, tmux multiplexer
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

This links the Bash configs to `~/.bashrc` and `~/.bash_profile` and creates symbolic links for the configuration directories, including aerospace, kitty, neofetch, nvim, tmux, zk, and borders. Existing files are left in place; move or merge them first if you want the installer to create these links.

### Key Tools & Aliases

- **Editor**: `v` → Neovim with LazyVim
- **File manager**: `yz` → Yazi
- **Git UI**: `lzg` → Lazygit  
- **Docker**: `dk` → docker, `dp` → docker-compose
- **Package managers**: npm, yarn, pnpm, bun aliases

## Configuration Structure

### Core Components

- **Bash Shell** (`configs/bash/.bashrc` and `.bash_profile`): Fish aliases and environment settings, platform-aware PATH, Starship, and NVM auto-switching
- **Neovim** (`nvim/`): LazyVim-based setup with custom plugins
- **Kitty Terminal** (`kitty/`): Modern terminal with Solarized theme
- **Tmux** (`tmux/`): Terminal multiplexer with Catppuccin theme
- **Window Management**: Aerospace + SketchyBar (macOS)

### Platform Support

The Bash configuration detects macOS and Linux for the `ls` aliases and pnpm location. Tmux imports macOS-specific settings when detected.

## Development Environment

- **Languages**: Node.js (NVM), Go, Rust, Java support
- **Themes**: Consistent Solarized/Catppuccin across tools
- **Fonts**: Nerd Fonts for consistent iconography
- **Plugins**: Managed via lazy.nvim and TPM; Bash loads installed fzf, zoxide, jenv, and Starship integrations

## Usage

After installation, reload your shell or restart your terminal. The configuration provides:
- Vim-like navigation in tmux (`h,j,k,l`)
- Modern file browsing with Yazi
- Comprehensive Git workflow with Lazygit
- Full-featured Neovim IDE experience

For a running Bash shell, use `source ~/.bashrc`. Machine-specific settings can go in `~/.bashrc.local`. NVM auto-switching requires `~/.nvm/nvm.sh` and a readable `.nvmrc` in the current directory; other shell integrations load only when installed.
